Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE3F239086
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 17:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770052181; cv=none; b=H5a+/unTHSfL4Zyb6Bj8YO4qs5cWjhWBq66NINQyJWRuvlWw2AKQ7HTk6ydfWSkGe9+B7Xn1QuSPPAq6PQA2oW4F4U9h7Ak2BMfo14BLnlDpGrD7LdvA1Y5cJJZwRt28Ks992LmxIAfz3VAkZzJOC9T4OA9EEoDEaLeSMX3bB5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770052181; c=relaxed/simple;
	bh=cdBDEMCWDSMVIpfbpc7grpsOMq6xPSIBfpntMHNOz/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DMUrKS+av2NmPwIZEZ0fJ9fVWJi7G85bj4/STvRecVvXEZjlWHAkmcrmfeFigGeZ6t4Wmnyr9roVNarTDj4bTeKN+F2gg1a6G3dUvmMko/WWKWtRpAOYkHtUSE/jD8qcO/54aCf5Fn4xAoWWjqPdeW1DJhRjdkzRW6v015VnHuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxK8mjLE; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxK8mjLE"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a9004e4239so8169785ad.0
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 09:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770052180; x=1770656980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdBDEMCWDSMVIpfbpc7grpsOMq6xPSIBfpntMHNOz/0=;
        b=kxK8mjLEXrM4gnuvBiuobyKSCgQETx4qo3/Ujja3SCFZvkLLRi4qo449fVNj59LJAc
         U6eFYUJlZtnEZSWxdfX2D3Th84d05vmiJP0SumispSYWc7yN3V754AtmpLc83bdYRqDU
         46nU0rOVZhHF3cVruSCN/xW0OM01UOAyBA10kU2tfVmwMN8DGWmO06MOgEP1wXfc/pN/
         YGxfz/c4X2GEdku/3FuZchAxMXUHlRasNofRn9FXR8qlSOxnRq93S+C6pA5mM2Y8sakD
         d2denpvg0strcDNYCAtk/0XsTjcJXvoRyn5bV5LT62XGWthaLsWUF+OmxiDmS0hGQ1Ui
         YmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770052180; x=1770656980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cdBDEMCWDSMVIpfbpc7grpsOMq6xPSIBfpntMHNOz/0=;
        b=Qs9HEopIGIj5mAEdavBsJzEZamuodYvc6f6lwP8ycCCBu6J2iH6xGcxsxzSQcfsxOf
         hV5QMoxkQ7diFLNviF04F9Pj/RZGE8/ugpnoGMcGirRFa56uc3EYqSRER6WGnn5QJgCu
         pcFJjmvTsB7zXPGWbQb2aX0jX9udFAHGP4lqii2rVbiPbOQ47cNd67Sb5vFyghW2InJq
         OWSJX3qdT9vHalvjhWIeGsubrVVeumSHnR2xjIw7NJ84VQTJbXxEMTorxXuy7eyBSlEj
         mKC7ZFpkl3gd848R5nf0BgWSb363t4ejj6bU/djts4tj9v/7DcKk+ZKIjOwdH8Eq4fcX
         hpuA==
X-Gm-Message-State: AOJu0YwA/ESPOPmatStGYSc3YbHRMUfqVcFKrj3oEBmZuz+fEP5dn/qq
	YWf45TYhVAknzcrpH5szJDwYvvDlPhpZUCE1n5ydSYC0yjzrWiLlv504
X-Gm-Gg: AZuq6aLe3Hx9uSvKgiKPrPWXvg26KoVkp6oCytq0p+ypAuDsgVZrmznFN6SiKASzBs6
	sinCpnFXrj21vZhicfMfakJJfUgLmyQCDHfRMUb1wl2vJaUEax/etEAfNR3jvmtbDPICKLTt4Ma
	U/TVUztjELm0qacxdOi3KrkMoeZox2YPViqS+l/ktNOR+ds2/J6JD43xMJeI6Krgg+7KywR5dNn
	83YPTaIWBaxbjia34g7A6LT6PKVYjcxjOi1S7TuM4lMiCxUrunsMMHn9GD8ri0CqvK1M89fIins
	i5qv51kNz1VcY14ijc2mCQO0XDHYc0eG3oInpcG8bIj+SXgUpaureMWdQto9beBE8CPSchwrjxp
	vOaL5nHjy9T/7GKqR32ixL5a9qZMc3uC+CBBKQoIkeWi40YYGctgPNwmObR90tj7UAZjOLZrfFQ
	V5Jz42PlQhNxANSkIDITgX/g5lMBMxDdDN
X-Received: by 2002:a17:903:2bcc:b0:2a0:f0e5:9468 with SMTP id d9443c01a7336-2a8d992cbc2mr118847215ad.32.1770052180126;
        Mon, 02 Feb 2026 09:09:40 -0800 (PST)
Received: from Pushkar.xu.edu.in ([125.22.10.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4c40a8sm183881525ad.51.2026.02.02.09.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 09:09:39 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	karthiknayak@gmail.com,
	kh@pks.im,
	peff@peff.net,
	ps@pks.im,
	pushkarkumarsingh1970@gmail.com
Subject: Re: [PATCH v2] stash: honor --no-overwrite-ignore with --all
Date: Mon,  2 Feb 2026 17:09:33 +0000
Message-ID: <20260202170933.37155-1-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <fd0da056-effa-43c8-a387-1db02b5636c8@app.fastmail.com>
References: <fd0da056-effa-43c8-a387-1db02b5636c8@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for pointing that out, understood.

I'll move the "Changes since v1" section below the `---` in the next revision.

Thanks for the tip.


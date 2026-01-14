Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA36378D96
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 21:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768426760; cv=none; b=CEpxUwyn371BW9XmouXsTL5qitoyz2KPCEQlMGtA3i2W4JfDB1EXc14go11i+YcjO2tNUPnWcNODRrNYBzruFhEcDoZR1kTbVjG6dZ6iPVR05LmOmW7FM2DaV0DfbsTqOpWVje1HntexteBI97PjSFpcm77BRt5VjL0at3dAmOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768426760; c=relaxed/simple;
	bh=YZvJgx1FOFCfDiZL7cmhccR+AMGQPJnwlKuWXG7vku0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Cc:Date:
	 Message-Id:References:To; b=MbJvR4aPO2V0xtT8NpwTP40KqrOQ0mZAxzBuMGThZLLUxkyxzP+9apNvRYB89Nha6rcEOABocoFWnFu7n23wR7ZvDKG8z4jSgLn1BwVyrMrjihJY/y3XklHNmcSyAFEW69Xs6eY95GRuOSHzh5BvjkiPBUWwuoUnIUXvLzxhPGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfTCDycs; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfTCDycs"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-792768a0cd3so2329857b3.1
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 13:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768426720; x=1769031520; darn=vger.kernel.org;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZvJgx1FOFCfDiZL7cmhccR+AMGQPJnwlKuWXG7vku0=;
        b=DfTCDycsZq46X9SP9XtLOeKU3DWXQEq/jSb+kGRTKsnLOV/l2z0csiJfVaVyaJWru2
         crB8huNmRIfC5EKpbyFd2OmCPEdq1GmtKat6+LpxRPm28QnnwkpZYNj4H79FzbpLeJPV
         jLi1JPmob6KF9n3M2cHIB09pfYOEMCtMFWWPbrqNOPka+2wpoEVabRjOdVhrEXpUF2TF
         F1Q3Arm+3qBc1l4ock0Omg0IJ86ly2h/FMYbqZojzNVhDwQcRZbGiP4+ApNHpFJdjDDU
         gQx8BCftN4DdW1DXe4xsRLslMSuPTl/YOxe9GdRZ6bWGlsFMdTM7FQSWq6SMasorJhtP
         IWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768426720; x=1769031520;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YZvJgx1FOFCfDiZL7cmhccR+AMGQPJnwlKuWXG7vku0=;
        b=jqRYSmU6qpedO3Ts0qI+YVJrjuiOleECkynLl5k6yA5HAGbiFvTEotGgZklr+cjORQ
         +jeI8Kimokpofb+JBaFilcLnxrH+qFC5zdyfCWWa58muFT3Ai01YRCuGv1ornLCF3GQb
         Hotv/2jkWP8vUnh1q1PPB/2Oh6pfqqFd6jcp9sAw76nLhkUPN+LshM/jqn2/vMqGQ6Ry
         cAGGeuyVBgduj7CsvteFUry8JRFLHFi7Qt/9VsSK7XtAuLGyAZKbWyeqWAowinmCFFh2
         YC/x18FjvnoNLQRvZI6Rxti9VdR/LyEowhuBCjQkfpoEA3UE5W1mxpFy03tQN1a0KZKS
         eMiQ==
X-Gm-Message-State: AOJu0YynFfs9RjWOQPtrkfxALT2qz7mxeY+Izn29jtN6MuYpHMuXj5S+
	OVz2Y08Sl3nkc/OQ0hbaESYPztZcZhpELVZ71RVUrzSMPDL7u4bDB6/vEGm84A==
X-Gm-Gg: AY/fxX5UpxASz8gZ/ZQaZpHZI32PSmP0hFqXKrV14SbWwg55oj3nqXevjEw3FjDzAIf
	DFZIOreZjcVCX0n3FNJ453wxFbsttKiZPWZS/VsU49wlpJp8vLGIVnMgPjIxb0Z7EUAsPprnrGW
	N2+qXzc3QUSqtf+5G62WyCKWDcH5TfTdbiDP5Drze2WU8Noc7zgUI+XS4h9eYGCSNWw77aI7rpL
	ij+vhfe0AWMlNlrm4FWDAISIKcxgUvY31h54WM0OaLey8g8F/NFhNljcXHkl7JpXzQXf5DLzNqI
	cOWWjPEq/qK+vxVBoa8W4fRDTjfsIS9eFeygIHoKraMF6HU/pOhwEiYvhUAPqUyPRPFDqbj+WKt
	w2hpG68NEEzRbg5QnhU6atmom5bW0Sz9Exc7ek/kSDITU0uq438aN3oJbkHeQUaGOWE3y4r4SHW
	i/kh+T8Q1gQH6qlUnVV9n9WeZfFFzfcTsF+jGTJa4LaUx2lqsOnhs14AiEaW6//PTSYu3adHBSr
	jtcLNk7aDlCHlHfLhjuvw/TMq2V
X-Received: by 2002:a05:690c:fc9:b0:786:5712:46af with SMTP id 00721157ae682-793a194bd8fmr32064727b3.9.1768426720229;
        Wed, 14 Jan 2026 13:38:40 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:18f6:dd0a:cf21:e611])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa55b8b6sm94954057b3.4.2026.01.14.13.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 13:38:39 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Triangular workflow
From: Ben Knoble <ben.knoble@gmail.com>
In-Reply-To: <20260114075936.40221-1-haraldnordgren@gmail.com>
Cc: git@vger.kernel.org, gitgitgadget@gmail.com, peff@peff.net
Date: Wed, 14 Jan 2026 16:38:29 -0500
Message-Id: <BADF388F-91FB-42FC-8C12-69693E61F36C@gmail.com>
References: <20260114075936.40221-1-haraldnordgren@gmail.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 14 janv. 2026 =C3=A0 02:59, Harald Nordgren <haraldnordgren@gmail.com> a=
 =C3=A9crit :
>=20
> =EF=BB=BF
>> My workflow is different from Peff's, but it is similar along at least
>> one line: it's really convenient to have "git push" with no further
>> arguments (only possibly flags) to push my branch to a remote mirror.
>=20
> Would you also like the status reporting to be off for your push branch?
> I asking because that's what Jeff is arguing for.

I=E2=80=99m somewhat indifferent (mildly for having it on by default), but I=
 meant that you don=E2=80=99t want to suggest that in order to use your new f=
eature you don=E2=80=99t want folks to have to break their existing workflow=
s ;)

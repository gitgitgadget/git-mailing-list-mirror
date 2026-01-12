Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8176F346E53
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 09:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768209148; cv=none; b=r1B376+vzVcid/MkjWFeaUlP4HRBYGlhKy90Qp8RQERbUNP10sNwxQXpfwHDbs1mobAjcPv44WzIhVgI2FiamCSClnSRwnx6Lg0Lb0b90C9q+8WDrejiSwGEuU0NCuF+PPyLFyTHtgNLVuGCwwPxpdEERP0orsUrfXhNbHZTPNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768209148; c=relaxed/simple;
	bh=snX//AC0Xmay8kYYmGNLcjj46YoO4ekitab+fyyVB7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+qs/7p/NMuJiQAzLuqzXx98jPnajyqrGosoyTIgf3n83tCR/66D2E9gMpbzv4FaZaBxrKUmy2uptBrULcw3iezSnj4yUOVJ2fKMHqQU3IdNWGIMaTyPXuRpcv2/AXhSmXznimCVvOOnyBGWV8K7f+2ZAfziV3f1uFG2oqc9s8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frtrm/DN; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frtrm/DN"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so2986640b3a.1
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 01:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768209145; x=1768813945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8L6ULK9RmvCHf8R9PGA5ZMkHw29LV0j7dbvJXpjVt6E=;
        b=frtrm/DNRR9StjnlIwc8cr3ax7ndTBUv6/xbqdOAo5i6J+IOIC0DKcG0c67Sub4LVS
         AYlhRNxic9ipaCIUBud/Sa+9usDF+rT5qY9mmbzXCOnfkvjNsoEMDvjRNoFS8c/hPN5B
         x2sM1HxJ3dvzk+dBu17JnQV5VyrZ7KhtZCcZSrEwApaq9nTJNpamRN2RAWQXFwY3SZt8
         4afqHU2vgAOYB98o2evKUZ0a4LWjLNU6wGsCEcMupKlTW2MBS7H+4sbThet0LS2G1GbD
         fAp9nhajwAfKP0DISYZTLx9c/DGNTjJOa0XgONOa8fPJKNbWevR7z5em0VZGNqOE2jBf
         yrbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768209145; x=1768813945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8L6ULK9RmvCHf8R9PGA5ZMkHw29LV0j7dbvJXpjVt6E=;
        b=HKesQGajCEnOZ8hKmesP9QXnrHX38FZXr6vsSk+r1XDQC0yAk0ErvoJf+DPqyYdcGo
         QtOKi9lHt1wST3g0U6LZmXek79krtWLPtgDAXhquw3rbimieIlvWFxeCuAh6X+Nfx0wx
         NkKEs+N41xvUbVpwc708qtJX4ROoFWbJgUjoBC51MOXUpYsjSqge4FR60SEyo0QWxBr4
         l/XWTIy2mfgqJDRtlg06LZweqXPGtgWFzv73WO6GUzwXqFrILdR7IjAC45V7u75lkAgF
         z1a4GhkzYRhMXDByJrn/lOgnJVxuFACPRcGVbDBwAWVKqVQCKYplsVq+UQv7fiquD0hl
         6fvQ==
X-Gm-Message-State: AOJu0Yx7+w3FwPfDPopUZUgK/KjynkKs9v30uCRtvF3y79u4loOa4pv2
	dQCuCv27fnZM0hhfMAk12KLqFOqVtXvakaTwdy/rvh4KCp2TC84M6u6qcf+0fA==
X-Gm-Gg: AY/fxX4a3XdslKicH/DDZZ4fUdNX0EfR2gCoCtcdJ260UIr5c+jlgWZ2+dLY16CXZvV
	sYAor0tyApq1SdME9eh1l8rJ7wZbu2JPXGN30UsfI1Pa8/3rSwwQGI/y3lG6DNSRm3Z+usi5vhK
	GAJbReAc3rUksowKa560kAbRICRcszvLSqiy//5mJmwe82XX+OKVbMiq4xEvTi62jIxinQEWr5D
	ijdbqFHvJrfbWStZBPPsHf9njWpoXULtD1pZ1uoOHNmId/nHWDnQ5U7+pailjdvM1Ti+ZDfAA7s
	P2R2efjkOrSx5/o/0LMDW5a5m2vtOzUA9fMZSFNd+0E2lGO4gG3nd2cstzfT5H/ZXgQ+wNb6/4k
	DG6c/zLBL0XrJFlUSnst98Uyahctx+xjz5IeAqmMh5GPTCBo043Xsr4u8buzKW5dgNX6EEOAuAJ
	l3lzvRJQzmXLXZXu8v4YyLwA0MLQTHzyLbgC59CTaenebI1Q==
X-Google-Smtp-Source: AGHT+IHyJsTaGgTSdoFGjiWq65Yf38yDhwgMiZvdGaC3hztsfLdJOexOSlXqh9JVWE2yxocI2izhVw==
X-Received: by 2002:a05:6a00:909f:b0:81f:5037:a310 with SMTP id d2e1a72fcca58-81f5037a77amr3364790b3a.17.1768209145369;
        Mon, 12 Jan 2026 01:12:25 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:8811:38e1:dd74:7b39:2154:bc0f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c52f90c0sm17113073b3a.41.2026.01.12.01.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 01:12:25 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com
Subject: Re: t5500-fetch-pack.sh and exit-code suppression
Date: Mon, 12 Jan 2026 14:41:35 +0530
Message-ID: <20260112091151.309268-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aWSv8dlt32xg14e1@pks.im>
References: <aWSv8dlt32xg14e1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:
> > >	GIT_PROTOCOL=version=2 git upload-pack . <<-EOF >/dev/null
> > >	0012command=fetch
> > > -	$(echo "object-format=$(test_oid algo)" | packetize)
> > > +	$(echo "object-format=$(<oid_algo)" | packetize)
> > 
> > The construct $(<file) is bashism, that does not work if your shell
> > is not bash, isn't it?  If you used a variable, e.g.,
> > 
> >	$(echo "object-format=$oid_algo" | packetize)
> > 
> > that would make the result more portable.
>
> There's no need for the echo at all as this can also be written as:
>
>    packetize "object-format=$oid_algo"

Yes, that would I believe avoid the pipe entirely and therefore
remove the exit-code suppression issue altogether.

Best,
Shreyansh

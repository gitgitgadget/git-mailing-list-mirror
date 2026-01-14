Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6F62D94BB
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768401190; cv=none; b=EqdX9GxEK4hdR5z0/FMqCb+SY7xa1HICHVVWHOKivArbenWNBVEQXSh2CW2yxD7Hnx9ettHhmO173VAMYjI5myd4rm7nIUmaG+A4eD2WMvaE++KVnW4Um4upGWFO2cSN6pTFubcIqnTUt41DG6rdG+zmCsj8ZVNmAUUHKd0FOr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768401190; c=relaxed/simple;
	bh=zhJ/XOVodzJvEV0xQl3iZvwAC0Nj4ZSs72GvWhqiPiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpw42HqHUtH3H50MhdoUl5v/bYsGf7XtEt6Q+zBkj1S4rAU8fRVQ//J7g5sXLOxYtZXrVdCh899hJEdQLhk86G51R5ZEW22bvPKLjcCoLQ3GZ2DqnSPUmF5JbalCYTTytstlM5dGsVsTRc0mYuE2M71lQ4BBnlvHMZy7bLC/+R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LncTjKmM; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LncTjKmM"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-81ef4b87291so2153333b3a.0
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 06:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768401188; x=1769005988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPv59o1rYn43KW55VBMKv85WoauSL1pZt3K0Hc6UU6o=;
        b=LncTjKmMSfoj6ecynklaaQo6zhb18Lu9zeJV3Ogw7fYByOvpmF4IjkmTLocCYkjzQW
         S9ahJDQxCdTEuSEbZ8kWXkoWDKHFYWtf8EqAKYSuDMPYmIECokMvGAclHqG7FvIMIHPR
         Z0Ml6hVq+llFKRr4BniM0zoeh5IiTFTB1uqDaXm2ZikvxXm/1VFwrpsA8mIFlWcPB/u2
         TFyH0VuV/LIU4XfE1MIthy1XdjOEwiR/7cNPzyvzjIRHHYfDpupe14E9AhAnpGdgMKTM
         YXVLDljWpEYKm4ira/9QssqknriBKOPUR+aFTfa7lcM8X6UO6nLs2oCDMw9of5HzQaVN
         W2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768401188; x=1769005988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IPv59o1rYn43KW55VBMKv85WoauSL1pZt3K0Hc6UU6o=;
        b=AFD/eqfoAXYlEEHR83BgjvxztCDlPWH78aIyXRufF75XmWJMHfvtkST+qlfuHR/pGw
         Ik7BqmDDDiPh64mqDriFqGgZSt0mqrwxbTFoHbZtPgaOqrMjwjgCHa0JIvrGhqKAFENk
         1iQ0QokYlxEMFxWweVcfB16+18U1knu4+iz1/QZux7CPGLHsd2gTRA4TV1bfYZkyUP6j
         qoMOKlfAc+HPCspOcDMNr1j/fTJCqY9YXWwvCBcNUNGeZyFj1jxPdIC31GLp7kGe0Gsz
         5PqUKZg4kTVtOmarJy0u9sAss6fsT/XCnAFSpgrr8OAXNwTucpuHAOyW73RhE5/i8Ico
         d0fA==
X-Gm-Message-State: AOJu0YwKV5sSiC1pKd4jYO3NtK+mfbf8Unqpvpey3wgfXJrlZYwSTaTm
	wdjOhXNwG8DJhpj8VgTyIwHi4TYVbuAXWhnKuql9VxSGn5PFRH/u9EpDda4Nu1VU
X-Gm-Gg: AY/fxX6TFlztjEucXjjyipC2Ekxg+M6eRyKssjmwv6tMwlUo5gihXDMCH/zlQuXDN7a
	JPASVRln+KjC1rXqyVNpv9yGhiXJzw7R675mDcoasypOCsod5+1//WA2fwnB4W06FGY74xglKqn
	tOFz5KjvAQpdpUbu0ObNNXeHYLzYSnDIy73J8+c/1/cb1qRGE57VMQmrziGvQ/pKgimhxpMXQ9N
	UWTUamG8R8WUc5BKzdmGJVa2m6cwh5HT2dJtbjJYAnn0xdlWw+fVS5SSHIOjQ2K6A+AdNwHnzGb
	R6sk8erap1GsRAM26YIo5OGigHnXBDzuKrfhvdHdXU9uqOQMma59/LIFzf+bhI/oybXqujdGvPO
	YCQZ9SDzeRprWxvdXfBnlbb9O0AR0LyBuBr7v6/2wjmgqUw2vsR1AAPPPX+NC+RUHvTQMaDMKyH
	RCI8QGzN0ZtOU+Vkfdk94JPW3vlal1c5TFNa+9ien4zK8VNw==
X-Received: by 2002:a05:6a21:339d:b0:366:14af:9bb8 with SMTP id adf61e73a8af0-38befc0a648mr2322573637.66.1768401187875;
        Wed, 14 Jan 2026 06:33:07 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:8811:38e1:2923:1d00:8ade:c674])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc95d5dbfsm22610504a12.27.2026.01.14.06.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 06:33:07 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: mirth.hickford@gmail.com
Subject: Re: Documentation problem: new syntax for git config --get-urlmatch
Date: Wed, 14 Jan 2026 20:02:05 +0530
Message-ID: <20260114143238.536312-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAGJzqs=0Zr2iqsTUZdjdwpbtaS7kuBOf=E_XT=vbdfyNTKkjNQ@mail.gmail.com>
References: <CAGJzqs=0Zr2iqsTUZdjdwpbtaS7kuBOf=E_XT=vbdfyNTKkjNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Hi. What's the new syntax for `git config --get-urlmatch` ?
> 
> Docs Documentation/git-config.adoc suggests:
> 
>     --get-urlmatch <name> <URL>
>     Replaced by git config get --all --show-names --url=<URL> <name>
> 
> But when I tried this I got error:
> 
>     fatal: --url= cannot be used with --all, --regexp or --value
> 
> Any ideas?

Hi,

The doc might have not been updated because, there is an explicit check
in the code which prevents the use of --url and --all together. 

--url gives you the best match, to use it try,

    git config get --show-names --url=<name> <URL>

If you need to see all the instances, you can use --all and --regexp
directly without --url like,

    git config get --all --show-names --regexp <name>

Let me know if that works out.

Best,
Shreyansh

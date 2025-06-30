Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A2E28BABC
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 14:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751292348; cv=none; b=MpjsRASzr+HkCQBcHplm3y1JNiIYGXOJAmVBpOqM5mQTRBE71Sp11SqYve0HQxK7Fj91RXq/J1oJeN9P43LkFivNs8vhLr9m0m/NdXT0m8P7+geHxaLzoJieJVT5ifv54qZLBcri02HQ674MT8xtDJgHKr/vzpz00BfN8dDzOh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751292348; c=relaxed/simple;
	bh=NeXMw5JXbJ5ycITGx+wEywe4bw4n+SV4/VKPTkH9wZU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GcUa+F4Bqp84Nix8GD16gjkg1dOTTJkNaDEfXaWCeHxUmUUf0734t5x0prvC5ZNEkFMtAPDP54vvR0Qb71wRiZ9n6VO0HUc7JoFDa7OuU0xDaIG/UOkYhDlCpJmhhhKcRV6Wz6d6Qnh1VX4m6tQQbr8DH397msJVNDyXkptPK2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbTt7jhg; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbTt7jhg"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-74af4af04fdso3164935b3a.1
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 07:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751292346; x=1751897146; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jUh122kYl0W9UJDfzpmQdn1SWN4At1g3wkIBoigFrS0=;
        b=ZbTt7jhgO2qwTVhQRoBTV0K0nogLR4NwO79zDIZcSBgboD1cKcwPqphh8PeEyWyyqM
         A8gHHFGvug2g01hdyoSMDp76EKZsC8Pb5XrqfQG0zm4X8A5SQ67jsX+B8k6+fEZtnnN4
         cUtU+tNs7Njbqclbsl/k+OPe0PrLlJdIWeWR6mGttvDo3YQxIqLgiyHjow+ictOAE3ng
         s+0HVRz949le+ilr3q71ylCj/jiYZiZ2hxE72Semxp6/xRl4RKqFDb4c/YJBr7ACCcEc
         ToQPPd8C+tjGjpU8zqR2q2CnbwJpf9p9AJxnt/HPCC6KVbsHCTRw7JbXEdIdB4OLkoJw
         GGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751292346; x=1751897146;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jUh122kYl0W9UJDfzpmQdn1SWN4At1g3wkIBoigFrS0=;
        b=NGEY9bXfiCYyhHjZCUMk7o7jHIxVogfJcyk+S9C2HcGPE4xlQFTfmWDtwE8x/ljYZ2
         pb+O83HKUPdnJT48D0rClgCKvJFEMahoLWszyoYKIXSVmGr6ri53eIMBJ5MC1i8umff9
         2Eeqo18w9YkAAAd/UF0WpDf9eWnMMW1ZeXgzAVUfJrXH6EhSCABBOeazkNA4UEjGzKAV
         7kiauVfgw9zMOsOltWxnjK7NKCf9Vg2bsXYLlqSyNLtBZaOmV8d7vQEWjLuScNaOBMoY
         esJBZO6CQxOG4SeChBqQzUjb97WEzb9Ohom41EnzwCKG89OMHFh2QffiLnkDwg3tV/rl
         3hag==
X-Forwarded-Encrypted: i=1; AJvYcCXhKsL7IIF/JKJ2cxRSp3A8DC0+4JmTFaPATfB+4HKIrCCXLH/8ER1+sgZRxpc7JE+/d/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDsaLIKYuo7XNJRYtMerEla/gpDTSekL6famD1Zfc46DJTnwgr
	MIEJBaj9UEMZyjKc8PMKFUnUVlzO0k6deu2cAut9J2dEUcx1Rb2mDnXL
X-Gm-Gg: ASbGncvAiiUnzLJX3eyYGAF6X18QXgysW/G44w2BZZ6SFjWNbIUGpp9JhT/lf+KlSD6
	xH8i/4Ehu+vQdWNxoK6cy3oEC1d4o8/GPClMtFkL8A0OZtp1BxqTiKmP7h85PU+EyU5KuDrIT4s
	yYF9OHPoJvLLvqVblzZtHqDCuTA5QPKqPaG+HgC+bdbfp9Ps6a1r5TgZGzSH4uCnq2KGzKI3ikq
	31O6JpC1oGzVR/2rEJay+/ypCCi4hoLqrOk8CvPQLBy9Y+w3ZVQT40l+CdnXyy3k43sBArGDLSC
	czDEvyqNEJD9IUzTICX5qdvDXddTbGAaQs7UaoLe1E7kLJ35nNeoT0uSaOxRuJPxUvMs7ipxKyT
	KcDneUc3Z+EjWGRnQj2es7GPurXo=
X-Google-Smtp-Source: AGHT+IFV2q1k5Nhk863ptmd8K2BYS5A/27tgHpr+rT1vdF6bHYx+f/YkuxC5dE7/Hcqq7Xub1cLzsw==
X-Received: by 2002:a05:6a00:17a8:b0:736:4e14:8ec5 with SMTP id d2e1a72fcca58-74af7aef3d8mr17267001b3a.11.1751292345586;
        Mon, 30 Jun 2025 07:05:45 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af57e7279sm8936317b3a.150.2025.06.30.07.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:05:44 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: Meet Soni <meetsoni3017@gmail.com>,  git@vger.kernel.org,  ps@pks.im,
  karthik.188@gmail.com
Subject: Re: [GSoC][RFC PATCH 0/2] Add refs list subcommand
In-Reply-To: <aF-iSSOmcplFjKQt@ArchLinux> (shejialuo@gmail.com's message of
	"Sat, 28 Jun 2025 16:05:29 +0800")
References: <20250627074934.1761897-1-meetsoni3017@gmail.com>
	<xmqqh60183ku.fsf@gitster.g> <aF-iSSOmcplFjKQt@ArchLinux>
Date: Mon, 30 Jun 2025 07:05:43 -0700
Message-ID: <xmqqo6u55npk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> If so, we would make "git refs list" to place "git for-each-ref" at
> all. However, in the current implementation, we indeed introduce
> duplicate code path if we decide to do above.

I do not know what you meant by your first sentence.

If you make "git refs list <anything>" a thin wrapper for "git
for-each-ref <anthing>", you can satisfy "I want to teach any and
all features related to references to the 'git refs' command" while
not penalizing existing users.  After all, that is essentially what
"git branch" and "git tag" do as their listing mode and supports the
featurs from for-each-ref, isn't it?






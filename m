Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E68492521
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 14:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767881991; cv=none; b=sHK56yqABgG1mIXwReXt9+bwi8cOyTjWX9iJiYH2/rzhNxZ2KROHTiVyJSxcNFVskYmKC7Zpz78n8E7bwNVuOFEvjYOEwi5sLfKKsecrW7Yypcq/PNAO2IdfkjcunW1YErekdnA3wK9oJ3bke+QM65b8VEpFLjFfvyNcp6Vjj/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767881991; c=relaxed/simple;
	bh=WB85U7Jf6BHgUt020TQjNU0WanBDOVQdgbm7cOeRDQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXG161kJui29eZwdniMxPD6+tr3CHRPIyPRMNksQ4GrxB6ss15pF0KXREmnhIAtmE6A7jTeAbxlsx0nu2nh65B+PvpRfGmWAZbCsgTFwrpOYSAmX8AcAbjAvCvzkjF1e5Vym3IxDBR023i/l82r2lcgfO2PUGt9JBl8NsoixjWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a75ggHDI; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a75ggHDI"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a0a33d0585so23239475ad.1
        for <git@vger.kernel.org>; Thu, 08 Jan 2026 06:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767881988; x=1768486788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c90PuWD5v3V7RPCEhqtMzKmZwGVXweVBfiyxhvYBe2o=;
        b=a75ggHDIE0/yWCsouHgObyhezeHhtvareeWpqKQjRjpZ/VmQQDOool7DilERzUa+ma
         msEWzXQZJ/PdBVYdhqdAIKvd5mDPRM/aBSIXqr5Ue4RxKZ+XPL8vHKz4OsmAYV3kYHun
         0TbS2/8HRd2JEvxLLUrGKTNFFMcRGaf65KnDITnvkDzjMkD2F0DWPBStKT5cngsnnRRr
         tq/1BHPNfIT3LoSLrtPlooJH9G31c20KarRuj4p8LYXzKs8hFpy7dO5gOVoK3WHbfNfM
         W77ofjmi5U/d/Z9AyB+sjSZ0HZmOd2Qr+zRgF054Dj6FXfpdEwDA0aROWTGEosqvtG4y
         Sx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767881988; x=1768486788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c90PuWD5v3V7RPCEhqtMzKmZwGVXweVBfiyxhvYBe2o=;
        b=PTj051rQqQHJ7OdfZy2CKbvnN6t0+/pEsFeJbcHufiSzwJp0637gfILsECdrO1+R9B
         uc/EOeDOO3g+pSlYbJNfs8w30RHivwUOOcdegplFX43Ifdz2e4FHGlIAj6GpsngLXe+x
         1P1q78TT1ezPCwO0bmytDpH8q5DxyVmAPAxwYDh1w8ovLEomoJs7Jz2j5MlldPReMmVE
         xNUWsq48zAAhtXKJmh1K6/xASGIMNaOnYoRMFEloR3O/mWiHiBednoPaxSn2uEKUKiGv
         P1OUzER84bZMExrMy3608IUdtMo/Zw9+wX7SmejihkzXmbtNtlH5KFE6C8zU+i3tS83J
         QuQg==
X-Forwarded-Encrypted: i=1; AJvYcCXeadJOW1ZivvUmHke7y3WjCczC3NTx8TTViENhlHcL+x8zKvzFLNP7lNj7ikflGlxArrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBiq8D9QxlMomS/vGZ4CSrICtn4VyY7IYJWIAGPd33V/O9ZYJ3
	Pookqzj8cypk0ATYiHRTxuAkMSwdSWAcfvV7qo3FZ020frNoVBzNtdfmB6nu7h/NN9GVA0Zjkkw
	Yv9n+XjNNX/NkmZbkdlfNQjwLImA5ai6e92nnImM=
X-Gm-Gg: AY/fxX4Cf2rBL+MRR+i3syb6LqrPUYzoB9++R7vwfsXmjiYJ9t1x0bRy4BPypFCVmCY
	l9YSlUQVEtb3QMqTlcYb0e9qPw+v3RfcHZR2jfMPg5hYczdF4tmgbfiyh57ILW+nD2hxOzb/Kmk
	nGJmVFViMpl+sXmiKRoozMsUMVgiA/y6JWOWTd+TgivfEIAXai63K//IY2b37nVkXfMJjRkUYyk
	bnAxrqIWzxuxpKBYeBPETxuJtPdI5IIicK/4xOJWbtvBCjhgJip8lPuXRW8rqEP7l8lPaox7M7s
	5XBZQBrvrcQfXmGNfOoEksWPfbKd
X-Google-Smtp-Source: AGHT+IEdxds4eT4SVAQX6JoeWKVNOaai3srPFDQu84TM4jp6VD2BFEbgopIJL0W6tltT3Dp1OMuwnRzkFWuuVP4F21M=
X-Received: by 2002:a17:903:9cf:b0:295:5132:1a99 with SMTP id
 d9443c01a7336-2a3ee4aabdemr57414365ad.44.1767881988027; Thu, 08 Jan 2026
 06:19:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2011.v3.git.1766579053136.gitgitgadget@gmail.com>
 <pull.2011.v4.git.1767804355831.gitgitgadget@gmail.com> <xmqqbjj4hnkr.fsf@gitster.g>
In-Reply-To: <xmqqbjj4hnkr.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 8 Jan 2026 09:19:36 -0500
X-Gm-Features: AQt7F2pl8OT2cOk0UuykaLz86_ySI-AmdNoYQy-X4fqGrwtpYzWDr2_-0NUdR74
Message-ID: <CALnO6CAx+7r9tj8irLPCxCVQXq0BJcjac9XCD1zv2MBKTm_NgQ@mail.gmail.com>
Subject: Re: [PATCH v4] lockfile: add PID file for debugging stale locks
To: Junio C Hamano <gitster@pobox.com>
Cc: Paulo Casaretto via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Taylor Blau <me@ttaylorr.com>, =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>, 
	Jeff King <peff@peff.net>, "Paulo Casaretto (Shopify)" <paulo.casaretto@shopify.com>, 
	Patrick Steinhardt <ps@pks.im>, Paulo Casaretto <pcasaretto@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 8:59=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Paulo Casaretto via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > The PID file is created when a lock is acquired (if enabled), and
> > automatically cleaned up when the lock is released (via commit or
> > rollback). The file is registered as a tempfile so it gets cleaned up
> > by signal and atexit handlers if the process terminates abnormally.
> >
> > When a lock conflict occurs, the code checks for an existing PID file
> > and, if found, uses kill(pid, 0) to determine if the process is still
> > running. This allows providing context-aware error messages:
> >
> >   Lock is held by process 12345. Wait for it to finish, or remove
> >   the lock file to continue.
> >
> > Or for a stale lock:
> >
> >   Lock was held by process 12345, which is no longer running.
> >   Remove the stale lock file to continue.
>
> Two additional thoughts.
>
>  * 12345 may be running as your kill(12345,0) did not fail, but that
>    may be a process different from the one that held the lock and
>    then died without cleaning up.

[snip]

> > The feature is controlled via core.lockfilePid configuration (boolean).
> > Defaults to false. When enabled, PID files are created for all lock
> > operations.
> >
> > Existing PID files are always read when displaying lock errors,
> > regardless of the core.lockfilePid setting. This ensures helpful
> > diagnostics even when the feature was previously enabled and later
> > disabled.
>
> This makes it even more easily triggerable to notice a running
> process that happens to be reusing a process ID an old process used
> to have (i.e. the first "thought" above---the phrasing of the
> message needs to be carefully thought out).

Yep. I mentioned this back in
<CALnO6CB1igUL7nv6ByUmwMRc9tqEvs=3D18wD81GNpaA=3DFLpL2vw@mail.gmail.com>:

> just because a process X is running doesn't mean
> it was the one holding the lock, right? Since PIDs can be reused.

which seems to have been ignored, but I'm glad to know I didn't make
this concern up out of thin air :)

Best,
--=20
D. Ben Knoble

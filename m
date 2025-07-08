Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8B12571BC
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 07:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751958661; cv=none; b=gugiViXgMeiXxIS5tt4wex4LpXD3igDninMsEZAt3zTW1sFddQJ7llGZggn5CFuZFt5wP1xk6O1luxLpSt2Khgxbl46aBBxXQO3ghEBJEtBm3YwPbIBYggHqa6hX3So6ytj+vXXnTybkbJe+/iEZ6Xv1mUUXzsbN/g57jkRQ808=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751958661; c=relaxed/simple;
	bh=TmBLfUX8cEWfz1Q+OthMJwn6dIS1be+WdzJ2FY5beiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RmKSdxiq4hkOn9m2Wd1HpuZPvrB0Ucw1htbKkhvd4mJ6N9590e7aIDNbjcT41502Tld74X3MjOPCowl2Cv8d5SV6sk/hJszbawNpIF44z5+RdbsqRgH7X2DHV3gq1lcaQq6c2gwfZfwr/GzPxebPqkUvFp7YabzFNxshMVMITw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pl6f0LfM; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pl6f0LfM"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45363645a8eso27131995e9.1
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 00:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751958658; x=1752563458; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=chc9hBe12W6hr5UGexQztq0z+yxxG6l4br7zxVVDOTI=;
        b=Pl6f0LfMS1q1Ky0EU01EJpvZY3ECmqJVbWxbJNsny7svmG+yIMAW8uydOpocHM8t0F
         86IjwNX5sJWALeTH1mJivuAXVZ1Vdi3dfxbhF8K663p2TFxkU56dK5g55sy/M7YkUiW3
         7ThsGZRHeGsTz810BSEZXLEPGHSv2mSiOLGec0lXWmDwmHtNeAhnZDWdboW0C2XmIID2
         qhqMQv7gmvnOfecVqCzUQodzDcynZM8CTCOo2ksW/ce0igJ3yBpwjw5nHTIoyyx+rQYc
         F+Ycb3T1DovhJfFDDbI+QJCybM+hvTFrcRY7ClO4CeSKbo9qt2cia3G/CyhzVyptE6jr
         ZKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751958658; x=1752563458;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=chc9hBe12W6hr5UGexQztq0z+yxxG6l4br7zxVVDOTI=;
        b=e+n8fRaf9wTzIxABjWWs4Rr0FNyf+1guIGbU493+Knihg5q4XRNiBPsUNS98KFfyXF
         yNEU1c5dY3PfubMqVx/caSFU3IhTxSdsMsd+p7doohqn1NEIcpJ1dILRz7WtveCwzN45
         HbMZ9hN+7EAPAtrfhhQSmoyGDSpt5nzEwE4+95wXVs6rxEapJaBM0rYH7wuEx249y6sx
         QIniTR47lDSd/Ptm4UmwiGhG596nD2BD+QLfJzrpinTZLWhG4bXQYofdKQHxj+CL0as8
         PXf2jcKc1TZjVpuBG5mWoW5qMI4tcmzxRiPXws3rqqLitQAPw2Lgbhc9TMwKBDOeHFD2
         HKcA==
X-Forwarded-Encrypted: i=1; AJvYcCUBED2YRcslrgOtQRrDuUE+jf8EbR3HPjA2pCi+Fg8eaz/uvieBVOgLKjVkwYYYUCUx6es=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT6mJ0BlRQsGMHqvXKmtddW5diQmtAPSQQ3w+d1Ksu8/EA44qJ
	xE1+tiQt/TPF0amhARqBGiXOU/+QSy05O1jfX9iU6CmnV8MSv4BqlzzHr4eVi9eZF7KRCc2Gcxl
	Zu6r1/4ReNe6j5rTU5/36OFvUMKkrPgI=
X-Gm-Gg: ASbGnctzKG5co0CvsacKax9gKOjAwHmQ3cOHu5EtIwCYhMtp1hAnDkgA8deCMb0K6Vp
	VpCCeWVD+UQH5gaV5gsrSSVpnMi+EmdM4A932FkOgeJLD0hw+t1oLZp455pB+dftFb6EasEz2+m
	iSnLym4+p8OV07atHsJPJ1ckba1iuYqkc5oNdXCkVUmA==
X-Google-Smtp-Source: AGHT+IE/nv3z6M9IO1VKBTgfJAut+wgyf7R+17DsBVJSZ4r52JsCnaCRsF4F6WtEPPamtYTDyu+eWwwoirVJzITzods=
X-Received: by 2002:a05:600c:4e47:b0:440:6a37:be0d with SMTP id
 5b1f17b1804b1-454ccc89031mr26477965e9.15.1751958657445; Tue, 08 Jul 2025
 00:10:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250706163009.335780-1-sandals@crustytoothpaste.net> <20250707204224.GB3115893@coredump.intra.peff.net>
In-Reply-To: <20250707204224.GB3115893@coredump.intra.peff.net>
From: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date: Tue, 8 Jul 2025 09:10:44 +0200
X-Gm-Features: Ac12FXyi4aE8SOEcWlHqO3WB9-wg86pi_128FWRGS9T0NoWcmypr7o9LXG-PlAo
Message-ID: <CAN0heSou=BgC8ec9ZE+V-pYKt+XQiNfOBHj-5CZY8s5XCatZTg@mail.gmail.com>
Subject: Re: [PATCH] SubmittingPatches: allow non-real name contributions
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, redoste <redoste@redoste.xyz>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Jul 2025 at 22:42, Jeff King <peff@peff.net> wrote:
>
> On Sun, Jul 06, 2025 at 04:30:09PM +0000, brian m. carlson wrote:
>
> I.e., why are we sure that it is OK for us to loosen this requirement
> (without jeopardizing the legal status of contributions). And I think
> the answer is along the lines of "the kernel did it, and they checked
> with lawyers, so we can piggy-back on that work". But it would be nice
> if we could cite that source, and maybe even lift some of their
> language.
>
> Looks like the kernel commit here:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d4563201f33a022fc0353033d9dfeb1606a88330
>
> cites CNCF here:
>
>   https://github.com/cncf/foundation/blob/659fd32c86dc/dco-guidelines.md
>
> I don't know if there's any public discussion or statement from the
> Linux Foundation or other legal folks on the kernel's wording.

The commit is "Acked-by: Michael Dolan <mdolan@linuxfoundation.org>",
which seems to be a lawyer at LF, e.g., as per Ted's post elsewhere in
this thread. So that could be seen as some kind of statement.

> So there
> might not be anything better to cite. And possibly we could run it past
> Conservancy's counsel. I'll leave that up to PLC folks to decide on.

Martin

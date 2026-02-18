Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE0B32D0C2
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 14:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771423338; cv=pass; b=sSzP9oe48Ya5rZ5fwJJMmwpq3f7e0mvrVnJ9hWBXgf9fsfiLlqJRnWr5YWJOuM2AHmlukrtcB0WmOULY5SOua7/6F1RIIMN3lrZ3y0TfxQ1Dx6qV3ntaoxSYJZabEIKmkps2z2yjt0tb7ucM7GsKjk5kvk9IOOrYKHMrKN6xuMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771423338; c=relaxed/simple;
	bh=dfMQEn4Z6DTV+EvUOdZKxDcm7A9apzP3JIWcG0iNeY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kRqVVVOmRBJNl+r9ZprWh+UeycrShWc78uR4CqWq1o11ScvB9fKcX6+8QgjfstQULTRrDfy3jdZzCS9qom+SH7AGL3seCgbg9jIbnmKDafVGEzxhOG32E86lkxmVH5i3IZ8Sn8lglx9F1pDUHn0gEbqLZLVhv+24QsFKUQIXi0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aeeSNoqH; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeeSNoqH"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c6e248aa446so2194822a12.1
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 06:02:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771423337; cv=none;
        d=google.com; s=arc-20240605;
        b=dmWwcX6DB0gNpC4tECICsmGuvEOxnHeMGGahHb0KqVnsEYB36EU0odBgtfec80DQTE
         T4KSFydfzq2rpExHNWdCOAA8IDHyDuMtKe3k0fLClStVgDxmT1aGTesUbqOwzTkhXp1S
         n6HPCqTvOMaTo8AXZCJ3RiSSXWhGtwdJ3fNK+2dsL/QgoY4OrlPDf/xgPcwFLPqp2Mt0
         He8oTjeRPz+m3e4SCy1Y4EDxcyOaPctZoiK4s4XokIbbIHsP1T+xXGJk04x1oT/abYcs
         Lubtv5x7uP6R/rmytRUOQr0lMizaZHhUI/qLwzEr4WjKcNCjpr0dRBKS6MernnigO9Qg
         ZdEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wna/fSMWDdx6/nMfG8/J0k/gxY7Oqp/1xHCKFfqIEW0=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=RbS4hjfLhegOawFDRAvopkPCd6b5MsilgvxRSQTnpnSF4xPxRwEfE0kdBvziuA2ByU
         VjPPu9H6su1SO+N/IfA59SAWDMKyDjd9Ly7nwUFTzZOU8HKxet5cdGQRHq583FynnwGJ
         Tha7XhEDKxvJBfwrKjRY4TPsxh/x0PtrUxGh4SQr8U0qNoxgmkyLnXWMomMgMEy/tOzV
         TouwlEeanfJFY5VJ3GngTik1azl+UhM+nTL+Ljsu308uOBzI5uIWCNvG2JxP1iHq3avF
         604lr+dNI99CU+7u06/F2V41kbeUU4/CeJKkDtU1NV6+SREvu9/Lpxrsck7x4UzPnSDu
         q22g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771423337; x=1772028137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wna/fSMWDdx6/nMfG8/J0k/gxY7Oqp/1xHCKFfqIEW0=;
        b=aeeSNoqHsm5Lk2IrjMee0Y4gNAC0vI9JTrYyM3ebZdZVHpNGESr0cC51cVyA8CFe5r
         qK4bv9+ovSyxHeLUGLIlEeeHP5JrsLk3DHFURmUepA4rXNC2BB+vZIpUlnQ+h2AQz2EE
         rcwivG/uvb7ii2xflZY4679JAkuRBmTkesxK1s1xcNO1X0AwnopLwHUX7kczFB0xs5qa
         TbkAOAwB8Z/nfTOCW0KgRC36zws6WgETr2Wf8U2hLpw/YuULLwihZt5ppNgGSBWtFZRd
         61LMVxGn04CBb9Z+sjhsNG7uNDZ5mU4XaaO3RO9xn+jKYVyo0v6JMLMHwhYN+S+/eq68
         Ky3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771423337; x=1772028137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wna/fSMWDdx6/nMfG8/J0k/gxY7Oqp/1xHCKFfqIEW0=;
        b=q368O0IKgPWHiQHvV1t6E5dkHjF28qSBPSNp5suz9T0qiaUdcGuCLIus8UYay9h/Ve
         ZXkwOpwrF5ScYJraRSC/WFRtYtct9+kXp4LHnR/gct1w740+HzksD9SOVw09jb0ENnZ+
         gveiBRbY0u9emBQMzB4EJZ5IJs5NI1Sa200L3HEMJjMDqhiQ7zAz6QYDRxWJRTsim7qH
         4wEdDf+TtCbEXBaifE9wKZt2F6wLWC08618G6IsqeokQekR/PXSQYxHbbDeBkVu05J9O
         sauJzTbUZ6w0hmjxXgGfSlNFprUYMv3iMbI3XK21b8IznCB5q7DIp12tF+hds1RsrGMR
         Hp4w==
X-Gm-Message-State: AOJu0YxgYWKnmi7F+iAITt2jha4M+EXrzd2Aee7y+5GbvzYgXsmzuckW
	ydXLsoNCHB4CW++7ptb6E9/Tj54kKam/vyku5PvROKwU6QCTJdx77n0fpGBkxTUYeYVTKes90SA
	N8Rm/z2u4qUpVwIFFdbUN0baQkfiIFZl/jg==
X-Gm-Gg: AZuq6aKXdyh5ZoPDilIMFO4+/EcuG7IYdjFJsBV6osP7oUZnc44aUmAgp2A+iY51gMC
	32iGcJHrY8FIGCe8+0s4aR4t2YzkjjuKkNzoxhmktrSAoXlANvWhv0x70qUXJmUNkKyNEtfvQ59
	TuEo9FTFAoVhMVTzUlVEv34B4MDdMm/u/pG3u6X61hbj3gBA24loIs3LzB8mzy1ucuLsJ02+Uwk
	VI13nSNckpEb6A4DLc4jtx4kQ2xoEMgFisW0lVHBQLrgLf0ohiWpVehuVStdZJ8ofV/N32hqMD9
	nBFGYZhZMsse1mq/Aqc/v4RGETly/GVxxPW7n4eYUCHvgQQoGs7xQek9Uy7vXtX6je9khLmv4Kp
	UGLTCNS1K5ESxNRvY/8MW5+1jNyvv28Ck8V3t
X-Received: by 2002:a17:90b:1a86:b0:353:38c8:b612 with SMTP id
 98e67ed59e1d1-356aabe68cbmr15851036a91.12.1771423336651; Wed, 18 Feb 2026
 06:02:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqseay98oj.fsf@gitster.g>
In-Reply-To: <xmqqseay98oj.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 18 Feb 2026 09:02:05 -0500
X-Gm-Features: AaiRm52yyhoZSVBpMOcyKRjFoulSRzYiy3HBy0HJv2kIoz5it2bCU_sFaxUF8c0
Message-ID: <CALnO6CDoGD4W2YefxXEtP-iG2O77pw0RmHDmsn3pF5r42hA8+Q@mail.gmail.com>
Subject: Re: What's cooking in git.git (Feb 2026, #06)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 7:50=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> [New Topics]
>
> * dk/meson-regen-config-list (2026-02-16) 1 commit
>  - meson: regenerate config-list.h when Documentation changes
>
>  Fix dependency screw-up in meson-based builds
>
>  Will merge to 'next'?
>  source: <9cdcc9de04f0f8fff657f0474b31c063466ed808.1771280837.git.ben.kno=
ble+github@gmail.com>

I'm going to send a (hopefully final?) reroll, most likely today. Thanks!

--=20
D. Ben Knoble

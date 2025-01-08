Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026F213D539
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 08:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736325077; cv=none; b=HC9OS0j7FmkCL00tm4ypEhONZv/QlfrkEEEhftdWkaV+Cx3SLpvYihpnz3HhCfRneUDGPLbXEpGWXpbh8iqSZZQDwrwIB4faIVDlrIlZeK65oFWKBovHG96/bxCG9jzybC3H2hwrWX1pzvm8k31T61PJGif1LZjw/cvKY/uExLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736325077; c=relaxed/simple;
	bh=lEJWxJ/r/qouGqlTPPEH0HfDIB4eBCpBQSxFmEXGN5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8U5YNNHkpAdNN9B4MUwgRd2RrNn1Lllg5y1oCWZbyZOaQkjyeoVkO/NcfS3HAE1SdH/OqKXryPoJL7W9lwslQteV5hj9dfDsCIqLYVEQkHFrZC/V7qKt7ZGCdtHHF5XIS5QLgR/w5fgtOBKDTRZUp1QocYWlXZgNHJdJOvj8Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDfDBojD; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDfDBojD"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e3c8ae3a3b2so19888357276.0
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 00:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736325075; x=1736929875; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e1iPdwkDALcRSLzButcpECFL++xqaNVgN7fhFXbCntY=;
        b=QDfDBojDDL0aJD2shYKbNarUS/m7F0TSkgMVXqZqA4kZx32cOLkZ5KEoyITn/SI5U5
         fsPJi6Wr00SYq4R+I9FqtO4EvXsfK3ZBsUA+XHeyjRtDhfV1AEVlc+rnZVHW7w+n+5eF
         M7/XW+CEGIYGcgQjVnEgO7qh4sVwQbPcozpmjcDe+cuqmZd4IKXo5aB1nl2I2kWSW/Bg
         NIzaPqxmKjaJH5Asax+ShJRmKUakDA7dER6sI3p1OHEbzSgh7z45x4caCdhd5VvROipO
         pU8p2KN43ZNzfBNqQRJyiotwzRHmaQnKlSjGwe1tzq4Y2NyaRD7JuzzkVMkKoDH2bs9R
         bRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736325075; x=1736929875;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e1iPdwkDALcRSLzButcpECFL++xqaNVgN7fhFXbCntY=;
        b=lPN0TCipCQts8Ask1rhXKOQZxoOL7vIHTeM2ZWcqKSnwIt2RJmBBgpYsYfRkS+jTS6
         MvJpm+4NoGdPXUzfrfdF5UhbB+oaZGsVS4o3K6bbwRE4KdV2VRSjC9Vm67RtHANzwT8J
         jYF7Kx1N9QGUszAl6VyG9ficJpVRPXkMDWj/+NZIweuiBYDorgF4RPVpazAr9HC6DBgc
         bMFNiX0orU5nDF+bIvBkvvXf9QOcMiWVoUOz6uaBaZ3bHV8Ky0TXCUi5El31MmpZ8d5H
         sn8NyxOz5gLHjHb2UVhgIZtI5NfiVLrcPVU2kvUZwJKPzOBbix6G5Y5LJwPoLUHG3tM6
         KmjA==
X-Forwarded-Encrypted: i=1; AJvYcCUJuHAH8V9K74uwzNCH/8MWlFkyCui1JGOkk7md+jVXxdANukuuYGlGSACFoUgSHiyTC3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDXBwUKquTc+R/QaV47Ai3NHc/EMIknPHOsk3cVH3X7hEV19+s
	iF56tApXPtytX3zFf7qqKtDAsXWwKs3FBB3q6WwwlGpOLAJazV6YydLLXYFdrSmaMOdok050/JY
	0etnLdQyvoUU6dhCEZSfzMAdkVOpQ5yisoZIL2yzB
X-Gm-Gg: ASbGncv1wizSrWbcRuVzGqZmiucK0vNueEFYAz8S+nn8YwOXx1GyyIqvTx+b2TKEyb/
	vC35WKgIgwToDbf7F7CSUVbSnJeJx8uwkdU21
X-Google-Smtp-Source: AGHT+IGrcyS9P9ixmvbty7u4JEEcSn9kP1sc/LX+3JgmcDR/aGFCwKobLasoxMsF0/c33Vq5HbLGxRs3fCzhuWDd86A=
X-Received: by 2002:a25:1ec2:0:b0:e4a:c0bb:7b25 with SMTP id
 3f1490d57ef6-e54ee1daa87mr1025871276.41.1736325074965; Wed, 08 Jan 2025
 00:31:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107091932.126673-1-kuforiji98@gmail.com> <20250107091932.126673-2-kuforiji98@gmail.com>
 <xmqq7c76trpa.fsf@gitster.g> <Z34XvPjhY15MFHrT@pks.im>
In-Reply-To: <Z34XvPjhY15MFHrT@pks.im>
From: Seyi Chamber <kuforiji98@gmail.com>
Date: Wed, 8 Jan 2025 09:31:03 +0100
X-Gm-Features: AbW1kvaE_uXjYi-vCjt849mzdQdJeJsxZ5QssMMpV2E2xv4JVL9-3YltJ8MGfo4
Message-ID: <CAGedMtcNpYBRsr9b8-ftbs6JFdp58wNGyYssiF1s0MEmziDtxw@mail.gmail.com>
Subject: Re: [PATCH 1/2] t/unit-tests: match functions signature with trailing code
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Jan 2025 at 07:14, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Tue, Jan 07, 2025 at 10:16:33AM -0800, Junio C Hamano wrote:
> > Seyi Kuforiji <kuforiji98@gmail.com> writes:
> >
> > > The `generate-clar-decls.sh` script extracts signatures of test
> > > functions from our unit tests, which will later get used by the clar to
> > > automatically wire up tests. The sed command only matches lines that
> > > ended immediately after `void)`, causing it to miss declarations with
> > > additional content such as comments or annotations.
> > >
> > > Relax the regular expression by making it match lines with trailing data
> > > after the function signature. This ensures that all valid function
> > > declarations are captured and formatted as `extern` declarations
> > > regardless of their formatting style, improving the robustness of the
> > > script when parsing `$suite` files.
> > >
> > > This will be used in subsequent commits to match and capture the
> > > function signature correctly, regardless of any trailing content.
> >
> > I am not sure if this is going in the right direction, though.
> >
> > Especially for things like test suites that are looked at and worked
> > on only by develoeprs *and* these tools, being uniform and consistent
> > weighs more than being more flexible.
> >
> > Let me state it in another way.  How many of the existing test
> > pieces are picked up by the current pattern, and among them how many
> > of them would see vast improvements if they are allowed to have
> > arbitrary garbage after their "I do not take any arguments" function
> > signature?  Are new tests you are migrating from outside the clar
> > world lose a lot if they are no longer allowed to have comments
> > there, or would it be suffice to have the comments before the
> > functions (which many of our function definition do anyway)?
> >
> > A quick peek at [PATCH 2/2] tells me that this is not even something
> > that would make it easier to port the existing tests by allowing
> > more straight line-by-line copies or something.  The patch splits
> > many in-line test pieces in the "main" into separate functions, and
> > it does so in a rather unusual format, e.g.,
> >
> >   void test_hash__multi_character(void) TEST_HASH_STR("abc",
> >           "a9993e364706816aba3e25717850c26c9cd0d89d",
> >           "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad")
> >
> > where TEST_HASH_STR() expands to the function body that starts with
> > a "{" and ends with a "}".  It can well be written more like
> >
> >     void test_hash__multi_character(void)
> >     {
> >       TEST_HASH_STR("abc",
> >               "a9993e364706816aba3e25717850c26c9cd0d89d",
> >               "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad");
> >     }
> >
> > and we do not need this step at all if we did so.  Such a construct
> > would be a lot friendlier to the editors that auto-indent, too.
> >
> > So, I do not quite see much value in this particular change.
>
> Yeah. This was something I proposed, but I already mentioned to Seyi
> that I'm not all that happy with the outcome as it has a couple of
> downsides, for example broken syntax highlighting in lots of editors. I
> said he can send that version to the mailing list anyway and get some
> feedback on it to figure out whether my discomfort with my own idea is
> warranted or not. And your comment here basically confirms that my idea
> wasn't that great after all :)
>
> So I agree with you, let's scrap the idea and have proper function
> bodies instead.
>
> Patrick

Thank you for the feedback and insights. I'll update the patch to use
standard function bodies.

Thanks
Seyi

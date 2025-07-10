Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10173202F7B
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 22:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752188384; cv=none; b=QIaIKVI/esbDy9VMcljQF5GMjG7SW8YOcYgfjp4l00zAUbXCE8Sk+pIcYo9uOXQYDdpZ+1w2NoL8yOkMp+cfE3edX59xa+XMTbYbgUpBC3Gud2GtkXg8VJdgsyRzqcxTKdxn34I9IigNBm/JppU0msAUPfRRoAZKx+xvf/kQrjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752188384; c=relaxed/simple;
	bh=gF7M6Kv5JAFQy/tuXQ8U/4sl4wMNB9COo/vUxCtTgrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aaliFS4W3gbv9qOx0xPYMS2i57lAnnZ4pXGc6N/3Ks9DeScvE9HuvTuS1TEXyz/7BUo5JM+zBo5EzYIy/VMdnA/ctLN+2WMM6s5y62jMKWWswNPNrni+XDfiYKt95WTA0QTWHawxEFiHuDXZz2cpbl3UtHhFwY91nBgrhNOfLwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYRUZ8TW; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYRUZ8TW"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5290be1aedcso2173980e0c.1
        for <git@vger.kernel.org>; Thu, 10 Jul 2025 15:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752188382; x=1752793182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zh5XeJgv4o/hEVRxXDohlawb7Ri3Vksod2LCE3drVfE=;
        b=CYRUZ8TWmJEuLbX7xFkWGtUHLl/zMwGSKEH4T0v4XSk6Hz5JlrKRDZyXUqizJenjII
         4TL08A8ESDXy+lNEmHicbHXvbZcaUjWqInlj/1P+7UqoUF5vM4nkIerPjDpfYgpJZerl
         DKWyWXP1hLZyltz7HLJevXtRpvdCVl80UxHn4Ix9Bvoafnzq5BNBpaNrEDOO6rXpAgUP
         EzBS77F8xuP8BKaakO9ofUf7s9u/BHtuZ4YD9EwlkZerahS+NgIIBMUBGw45sdQTPAvn
         Cr1e1T4o4spmNHxSfQ5KnsmMwSxvZ34YRvBp/asAd0/oEV+O/veYwsDNZrius1oHiiOF
         rNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752188382; x=1752793182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zh5XeJgv4o/hEVRxXDohlawb7Ri3Vksod2LCE3drVfE=;
        b=vEiiew24eff1ta3iUPBfNfDFd1sVjZ7k3DiRMfZ2USW+KtMD5ChvpiIQvoxOrMEZ3E
         yfueGBMhQBh+KXCwKgXytP64lkbodxaOsq9kiYMaJa1Ytlm4ht72h01VvMhB4yDCAUH5
         G62QjVEhc8eBVcaHvvTbzGg3DA/6t9/87cShWSsqVbP0mXTVkPzQ+xfs6Pxn0bHExy/G
         WTNuCFlYuXlNp/bGlup5Ba0cNq4fZoCWX5AiwmntZULU0F78V0WaJ/lh0M6d0J6eXAqH
         haNENrYGbgR5ey92TmZpoelLAb64qB6CBcaCI4cvHEe6HWfk7aGk61XurOTQiKZ8mL+W
         CiCA==
X-Gm-Message-State: AOJu0Ywya32WegEpN+8+IfNsjRNHdnLyaJG15G1+ja6tLVMkKoUFyL0O
	PJ10BLwpga+PHdTluiOLekWt62K4RyGnD6Mh2RDoODsd5WygWKNLsOo5+14oJUvR/nhtrSno73V
	TRKmRVAbtjFZipJ6dPOzVzH9jy7iX+UU=
X-Gm-Gg: ASbGnctP/hPFxugAK/P8GMEkIR//nVOMCW9Ls5nm0Tfh3hqgE9++d3eHOYYor9ktRWE
	kggZ1hmt+WQ999Jlc97tYt1Sqt1L/r8dXTFi9E63Ih3ugXnuf0pOWwNMEScPCFW/tbFLstD0Vbb
	ytJdA4+TlDKDG94NfAEok7KeVI3VZ8a57E7VxDHfy+Xms=
X-Google-Smtp-Source: AGHT+IGXtsQhk4/gYojBwCohXtigHm4ZSjyH4op0JY8oxEVeSbwEOQCbfq0tfjNxfl7X80cwJod6tpwt0hbnPzAWM3g=
X-Received: by 2002:a05:6122:659e:b0:535:ed79:2aed with SMTP id
 71dfb90a1353d-535f360cafbmr1310140e0c.2.1752188381786; Thu, 10 Jul 2025
 15:59:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250706214108.714499-1-usmanakinyemi202@gmail.com>
 <20250706215039.715732-1-usmanakinyemi202@gmail.com> <20250706215039.715732-7-usmanakinyemi202@gmail.com>
 <xmqqtt3o3rqm.fsf@gitster.g>
In-Reply-To: <xmqqtt3o3rqm.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Fri, 11 Jul 2025 04:29:30 +0530
X-Gm-Features: Ac12FXzEKVvfnt3kQ_ZQK0kCtUSUk_qpn5Hs9iad1Te0KfrRuni1CXugl4F_66U
Message-ID: <CAPSxiM_ZZrbFpgvxqYgZ8oeTbRs+HW=rM+9Dud0G_Qr7eq3=FA@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] t/t1517: move verify-commit -h test to t1517
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, christian.couder@gmail.com, 
	me@ttaylorr.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 9:42=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Usman Akinyemi <usmanakinyemi202@gmail.com> writes:
>
> > The test 'verify-commit does not crash with -h' checks that
> > the command exits cleanly with usage information, both inside and
> > outside of a repository.
> >
> > Move this test from "t/t7510-signed-commit.sh" to
> > "t1517-outside-repo.sh" since it better fits with tests that check
> > command behavior outside a repository.
> >
> > Suggested-by: Patrick Steinhardt <ps@pks.im>
> > Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> > ---
> >  t/t1517-outside-repo.sh  | 7 +++++++
> >  t/t7510-signed-commit.sh | 7 -------
> >  2 files changed, 7 insertions(+), 7 deletions(-)
>
Hi Junio,
> My first reaction to this series was "heh, you can cut it both ways;
> a test to see how a command A works outside a repository can be a
> test about command A (which is the way how the current test suite
> looks at) or a test about being outside a repository (which this
> topic tries to move into).
>
Actually, I felt the same while trying to create the patch series. I was
going to just send a single patch before as an RFC.

> But this may be an example that shows why it is more error prone to
> partition across "inside? outside?" axis.  These particular ones may
> be limited to "should exit without crashing and without doing
> anything fancy when asked to give a short help", so this move may
> happen to be able to lose the GPG prerequisite without breaking
> anything.
>
> But in the longer run, we are very much likely that we'd want to
> test something that needs things that require prerequisites (like
> "do this only where XYZ is installed") but ought to work outside a
> repository, which means t1517 would need to pull in things like
> lib-gpg.sh only because it has a few tests about verify-blah
> command.  These tend to accumulate over time.

I understand the concern and I felt we should at least decide where to
put the "verify -h" because, right now, we have some of them in the
t1517 and also some in their respective test files. So, there are some
little hiccups there. It will also create a headache for someone who is try=
ing
to place the test(deciding if they should put it in the t1517 as some
test or inside
their respective test as some others). Also, Ayush(GSoC) is also
working currently around this
part.

Is it something that is worth creating a new test file for, I will
probably say that is a viable solution or better still we should put
the test inside their respective test files.

What do you think ?
>
> So, I dunno.
>

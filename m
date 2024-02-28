Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EA96EEEA
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709140806; cv=none; b=G5MWMbCwVD01O2K1JSI0RHPD+F/nj65bgZlMW/bzYo8Z2wCinYQ9JlUkwoMSQRMI5BxfMHdpkwtM0ayRGNPc8afmsvDZNKOz7Tyo83ksQmEgRZufE7Xs2X83So+n6mA4kDcL7BZDndon4hlpGto+IQs4MGxNW4NnO38eN9lMBdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709140806; c=relaxed/simple;
	bh=6+dKGBQVQMYndg+rtCxAYL6ZeLWrSGOFJWK/l1QEqO0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=exR/pu4W5bZfsnnKDhZhgnK35SXCMfRJNRZgFmbJiJUQP72WJ5NpdO3ORAcvPLxyjFZ/IppFh5pZmUwvThHz3KNeoHmMFZfon2KnH0yBd34EBQGJeURPNOc0+ozRxYFnDs8rsu8RktzwPg90b8dKy0AWhj6tPNBD4j0J6WeaIrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqKHG1pl; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqKHG1pl"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e56d594b31so361753b3a.1
        for <git@vger.kernel.org>; Wed, 28 Feb 2024 09:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709140804; x=1709745604; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SCM/dzWtq5pcPXPyTBiIPDbrKelyDFwJg4r7TlnDCBM=;
        b=MqKHG1plmdUtsfdC7IbWvnEMFuZ4KPLQ7oCvvfMIEwlTJf3ls6qzs1C7Zq4NKa3DMI
         6lwBvU1k0OCzk8yUcjpmXi4f8/L4Ly3rI1D8Soji+lHmnrXvwyH1BlzAYj3r/ET/Dq2u
         /U/oMMkteecfIm0AI0RyksS4pYN4XY16fKVw8FlRQl3mZLn44sycEexi4c62lP1ZucTg
         96Gb6pIEkRXxVGYDc4VyW6nDoDARnFnWPFPAeYP9jfjobh2Snj4dCDzRW66aUg3kH2TU
         mMFx5WQMhX4tBC1qWmR2ZoQC2Us/5bOgO8Y/T6ynwkWQX0Cwzx41l7IBr3nAAXsmFV05
         59Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709140804; x=1709745604;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SCM/dzWtq5pcPXPyTBiIPDbrKelyDFwJg4r7TlnDCBM=;
        b=kuqqnIhXwZqxyP58DYWd87sYhHufaSBBwbE7VOHJVadPfPC1G7xLlXEGTxrJ1S19Em
         oqMvCLYG2vf+BIIKjvL+nuDgJ6KUyYKJSD8Rzkk6FRIx3tTOELY81Z/LUGEBG7H+8QCG
         OqHj0RxRhRdENbzoT+ZsLxgC6iYxND9tIuC9GLMjkuVaLatfSQ3UEKddn0BvV7zGCO37
         zR5RgsoIwQmafeCIsl7LcocUhypIEKnrQGjdD7sq4D0h5caeShXvLcU2v3HvvvXgeVj1
         1qnGYKMfB1nkVciZTAF45zuXrLHlLQpMg3/AeSKDRoKnuvMnHHUv+sTvTp8sSFr9ms5k
         Rapg==
X-Gm-Message-State: AOJu0YwUCZ4SzIuRVx9mb+RzFSwyWlYkD0EYxRrk3EmFZ9iMUmxMB/FE
	uutz7kHlVOo/+0M2shw0PxIt1p/LcQiz/atYfRGYOb3Kam8XDvEx
X-Google-Smtp-Source: AGHT+IEV9OESH9dKki2F2nSS0L4h/FOSuV3mjogTR+5q53McNGr5TV5cB6Es4qXc8C89+uGF4qXU7A==
X-Received: by 2002:a05:6a00:939f:b0:6e5:54b5:f16c with SMTP id ka31-20020a056a00939f00b006e554b5f16cmr384194pfb.0.1709140803768;
        Wed, 28 Feb 2024 09:20:03 -0800 (PST)
Received: from localhost (30.176.125.34.bc.googleusercontent.com. [34.125.176.30])
        by smtp.gmail.com with ESMTPSA id fx3-20020a056a00820300b006e47e57d976sm8011217pfb.166.2024.02.28.09.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:20:03 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Subject: Re: [PATCH] branch: adjust documentation
In-Reply-To: <d1f928b98238a60a96bee0d3f410deef@manjaro.org> (Dragan Simic's
	message of "Wed, 28 Feb 2024 03:19:29 +0100")
References: <3cbc78bb5729f304b30bf37a18d1762af553aa00.1708022441.git.dsimic@manjaro.org>
	<e8fdd057-2670-4c93-b362-202a339d5f49@gmail.com>
	<xmqq8r3lnzp0.fsf@gitster.g>
	<2a4de8c4-4955-4891-859c-58730a41e5af@gmail.com>
	<ea15a49aed7b5a74cd9b1bf8a5351df9@manjaro.org>
	<c00f6efe-d1f4-4f2c-99cc-ac7a6d93c9ff@gmail.com>
	<be91f3ad9305366c1385c2da4881537e@manjaro.org>
	<xmqq8r3g8caz.fsf@gitster.g>
	<35738a93f5cbace5b3235ce614b7afbf@manjaro.org>
	<xmqqttm3ouxy.fsf@gitster.g>
	<16c1f883-881f-4f8c-95b2-22fb4825b733@gmail.com>
	<96f1afa6-f4ac-4593-9bf4-72dafe3cab85@gmail.com>
	<b6d22f5a66de49efc623eceddbdc6faf@manjaro.org>
	<d1f928b98238a60a96bee0d3f410deef@manjaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Wed, 28 Feb 2024 09:20:02 -0800
Message-ID: <xmqqttlsld4t.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dragan Simic <dsimic@manjaro.org> writes:

> Hello Junio,
>
> Just checking, do you see the changes that Ruben proposed in this patch
> fit for our starting point in the git-branch documentation rewrite?

The synopsis part may, but with reservations.  I know you two are
aiming to make this in many small incremental steps, but even then
I'd have to say the way these placeholder words will be used in the
text part (both DESCRIPTION and OPTIONS) will be so different from
the final shape envisioned [*1*], the wording that may fit well within
the current text might not be the best fit in the final text.

The current description section talks about option and its arguments
without showing the syntax, making it unnecessary to be extra
verbose.  For example, we see something like this:

    With a `-m` or `-M` option, <oldbranch> will be renamed to
    <newbranch>.  If <oldbranch> had a corresponding reflog, it is
    renamed to match ...

But in the final shape of the documentation, I would like to see the
description section not talk about these arguments, and would read
more like

    When given `-m` or `-M` options, the command renames an existing
    branch to a different name.

among short descriptions made at the conceptual level on other modes
like "listing" mode, "delete" mode, etc. [*3*] 

And the option description would become something like [*]:

    -m [<one>] <two>::
	Renames the branch <one> (the current branch is used when
	not given) to a new name <two>, together with its reflog and
	configuration settings for the branch. ...

    Side note: <one> and <two> are meta-placeholders for the purpose
    of this document; Ruben's patch proposes to call them <branch>
    and <new-branch>.

Now in such a context, <one> and <two> placeholders having actually
the word "branch" in it would sound redundant and awkward to read,
Even though the choice of words Ruben made in the patch under
discussion may work well in the current document structure.  I
suspect these words will have to be chosen again when we start
making the real organizational changes to the description and
options sections.

In other words, I do not think that the patch makes an effective
"one good step in the right direction".  At least, I couldn't see
how the wording for placeholders the patch proposes to use would be
helpful in deciding the placeholders used in the final version.

Thanks for pinging.


[Footnotes]

 *1* Do we share the vision on how the final version should look
     like?  Here I am assuming "the final shape envisioned" is along
     the lines of [*2*], i.e.

     (1) trim descriptions to just enumerate different modes of
         operations with explanation on what they do at the
         conceptual level;

     (2) make each entry in the options section self contained, by
         showing the option with their <argument>s, referring to
         them in the explanation text;

     (3) remove non-option <argument> from the options list.

 *2* https://lore.kernel.org/git/xmqqttmmlahf.fsf@gitster.g/

 *3* Because "git branch" does so many things, the DESCRIPTION
     section should first say the purpose of the section is to serve
     as brief catalog of features to help readers to find the entry
     in the option section to jump to quickly.  Something like:

     The "git branch" command works in many modes (see SYNOPSIS
     above).  By default the command works in the "list" option (the
     `--list` option explicitly asks for this mode).

     will be at the beginning of the section.  The first four
     paragraphs in the current DESCRIPTION section is about this
     list mode.  The first three of them should probably be moved to
     the OPTIONS section under `--list`.  The fourth paragraph
     should be split and described in the entries of individual
     options it talks about in the OPTIONS section.
.

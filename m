Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF7C134421
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 18:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709232972; cv=none; b=OiP8aKmDxhs6MQHrPLuUrfYIbEEZOpsXgf8FknoS7HyypsMPZldyAyB/RDOdvmeuEARwYfq9okRf+9TIQCDGe1OD8oqEoB9gDMYpwEW1FtoK/r9RAsDgRHJeMo60ZkHTRYTGp2Wi6Kw2zMRFQll1YiNBMsS2tvfUbHe9A3MnrF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709232972; c=relaxed/simple;
	bh=rw9LB1+3zn4AHCKr/IDAukJcqXIsUPL6eDo9BlVYon8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aUidpuVF9TAgywbqXD/LE6UbqMOUKJSei4WF4r8qVL3sAp0NzAcDANn6PuPLvWvz40k0w14vr4BBqIMEX5xpZ9p2DQu8ZZxSwFZq5mribjm0ETTm/gWJRNtN3NImXTMLpCu+ccwfffebOWPpUYIw4SxQtsP+snUH3rcfhauu37o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXZntwRK; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXZntwRK"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33d61e39912so632408f8f.3
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 10:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709232967; x=1709837767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j5fqTu9pOonc804bjPdv3b/HAZ+Gg+W68WXOXwOXExk=;
        b=LXZntwRKP7kPF0uPiHF3SwfuRkN92cdTKAr6uyRC+BOw9CEGvK1XpbN3ycUlU+lP+Q
         cXqHcYeFKNGwvGfU7a3m5k/mtKCV/I3Ouad9vylWWoBbiASPDI7thIAhYASb6cceIbSn
         tFqhRbWagp953OTS1finkzSbsgN5cmbVxGK2wBaWRddIJD05U6t1AogL0PMMfUjeORaJ
         gb/W8PsibUx8ZLRtGXmep2HqiRQpcUCHcCKjef4fu0sNNLnosYc9cAPbyG+q6paR9Wst
         0OiHM3eP9UDnDsGjW88qxK9PSg4++HLl4FcSCGr0e0aIOSmp0BTXjg0w2OzJmCNBsibu
         Cgog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709232967; x=1709837767;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j5fqTu9pOonc804bjPdv3b/HAZ+Gg+W68WXOXwOXExk=;
        b=dwxr6lez+dgASP9Q6sDQAGd8RPVq5Vr6r5qGtez0btjYmgBcSzcAgbHk11T0ROINra
         qDBwx8RYnhUXPAXcaigRMbJ9zfeGR+DuzTga4Ju6fM3JSOOlaAdU2/04RYwvFRUNAlTR
         cIT3qr40Sf86L1uu9VwQlPt/B15ALcoXJsDnq7aR5SeHyPffKC/PrbexG6a1gMTBqTFr
         yQcyv+8sqornadHglXcVxZGluarV2TFJuLhKaeY2xLuFIGbVSofQcr6WHaeQ4WHDpiCy
         1LSfnPsUzQK0SfGWdxlU5E06daljroKNhueNLWK8Tw0prztkMTIB7oWg5n1TohPpl6pl
         HzSg==
X-Gm-Message-State: AOJu0Yx5S91CONr5YTb/k20WlHF1yc1HeH1G3nu4k7aNsSlyRX7HvCFp
	5E2grPv18kCEO76P69QmkrzHwUaOimfS5XuUgWSAMQ/zP90+jT0fgL9ioLEO
X-Google-Smtp-Source: AGHT+IGtvW6b0M38DHhNqhOD+9Bk+xIvBxTcqYqthoa4ICBQMcfvTs7yH27G5eq7dzLA6YpBEiZy7Q==
X-Received: by 2002:adf:f052:0:b0:33e:999:58a6 with SMTP id t18-20020adff052000000b0033e099958a6mr2187316wro.31.1709232967429;
        Thu, 29 Feb 2024 10:56:07 -0800 (PST)
Received: from gmail.com (243.red-88-14-45.dynamicip.rima-tde.net. [88.14.45.243])
        by smtp.gmail.com with ESMTPSA id a16-20020a5d53d0000000b0033de10c9efcsm2452092wrw.114.2024.02.29.10.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 10:56:07 -0800 (PST)
Message-ID: <cbaf17e7-37a6-4c2e-82ba-65fe41dd86b1@gmail.com>
Date: Thu, 29 Feb 2024 19:56:05 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] branch: adjust documentation
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
References: <3cbc78bb5729f304b30bf37a18d1762af553aa00.1708022441.git.dsimic@manjaro.org>
 <e8fdd057-2670-4c93-b362-202a339d5f49@gmail.com> <xmqq8r3lnzp0.fsf@gitster.g>
 <2a4de8c4-4955-4891-859c-58730a41e5af@gmail.com>
 <ea15a49aed7b5a74cd9b1bf8a5351df9@manjaro.org>
 <c00f6efe-d1f4-4f2c-99cc-ac7a6d93c9ff@gmail.com>
 <be91f3ad9305366c1385c2da4881537e@manjaro.org> <xmqq8r3g8caz.fsf@gitster.g>
 <35738a93f5cbace5b3235ce614b7afbf@manjaro.org> <xmqqttm3ouxy.fsf@gitster.g>
 <16c1f883-881f-4f8c-95b2-22fb4825b733@gmail.com>
 <96f1afa6-f4ac-4593-9bf4-72dafe3cab85@gmail.com>
 <b6d22f5a66de49efc623eceddbdc6faf@manjaro.org>
 <d1f928b98238a60a96bee0d3f410deef@manjaro.org> <xmqqttlsld4t.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqqttlsld4t.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Feb 28, 2024 at 09:20:02 -0800, Junio C Hamano wrote:

> The current description section talks about option and its arguments
> without showing the syntax, making it unnecessarily extra verbose.
> For example, we see something like this:
> 
>     With a `-m` or `-M` option, <oldbranch> will be renamed to
>     <newbranch>.  If <oldbranch> had a corresponding reflog, it is
>     renamed to match ...
> 
> But in the final shape of the documentation, I would like to see the
> description section not talk about these arguments, and would read
> more like
> 
>     When given `-m` or `-M` options, the command renames an existing
>     branch to a different name.
> 

Good.

> among short descriptions made at the conceptual level on other modes
> like "listing" mode, "delete" mode, etc. [*3*] 
> 
> And the option description would become something like [*]:
> 
>     -m [<one>] <two>::
> 	Renames the branch <one> (the current branch is used when
> 	not given) to a new name <two>, together with its reflog and
> 	configuration settings for the branch. ...

> Now in such a context, <one> and <two> placeholders having actually
> the word "branch" in it would sound redundant and awkward to read,

Indeed.

But I'm on the fence.  Do we have to use "Renames the branch <one>"?

If we wisely choose the placeholder, perhaps we can write:

    -m [<one>] <two>::
	Renames <one> (the current branch is used when not given) to
	a new name <two>, together with its reflog and configuration
	settings ...

And if <one> is _good enough_ then "current branch is used when ..."
should seem somewhat redundant.  So it could be possible to end up
having something like:

    -m [<one>] <two>::
	Renames <one> to a new name <two>, together with its reflog
	and configuration settings ...

Are we going to say "the current branch is used when ..." in the
description for the other options too?  The description for "-c|-C",
"--edit-description", "--unset-upstream", ...  Perhaps we are, and it
will sound repetitive.  However, even if we do, with the _good enough_
placeholder the user will be able to fill the gaps we might leave in
the documentation, like the one that presumably has bring us here:
pull.1613.git.git.1701303891791.gitgitgadget@gmail.com.

And finally;  Can't <one> and <two> be consistent with other bits we
have in the documentation like the descriptions of "git switch <one>",
"git checkout -b <two>" or "git init -b <three>"?

After the revamp, I'll be less happy (but happy :-) nonetheless) if we
end up having a SYNOPSIS similar to the one we have today:

 - Documentation/git-branch.txt:
      'git branch' (-c | -C) [<one>] <two>
      'git branch' (-d | -D) [-r] <three>...
      'git branch' --edit-description [<three>]

It seems to me to be made up of disconnected pieces.

And for reference:

 - Documentation/git-switch.txt:
      'git switch' [<options>] [--no-guess] <four>
      'git switch' [<options>] --orphan <five>

 - Documentation/git-init.txt:
      'git init' [--initial-branch=<six>]

My apologies if I'm pushing too hard on this and being reiterative in
my messages in this series.  My intention has been to explore the use
we want of the placeholders.  Of course, this is not at odds with my
sympathy for the vision proposed.  I agree on the direction.

> Even though the choice of words Rubén made in the patch under
> discussion may work well in the current document structure.

My patch is mainly about CodingGuideLines:

	If a placeholder has multiple words, they are separated by dashes:
	  <new-branch-name>
	  --template=<template-directory>

Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388403176FD
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755282364; cv=none; b=p7W9uQc5gpw7fwMDMferZTryoReSvWLDAHwGNDu/n63P0xO0wW1Yp/9qoM8EeByLIia9DWvLvAaMbKoMOy40GPFuDq3oSpNGdz3Om0eDVOI6yivMdFdcnvp5M8nQxkCoiiiqcpH7DBUtOFTXN1586Lo9eTFwZTaoyEzRw/dkJOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755282364; c=relaxed/simple;
	bh=y04vH276bPQB6DdbAPFWB50vVDPp47AancFFrXBr+/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=het6abGThEIUO1QnPGqKOa9Gnbms+JwYXAmR+IfBTm42m/vWFTtOJ9meVDCABQOyhJd7lfRhWE84JfphJpRkOukom8zlgn5NHInHsFMxy/ERYy4TBMuhM/Nm5jbNKAPNRnOBJtWHyqgeRnh0Y1pHmIn61ytrYdOqzEZHkXXjR7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=al2msEc8; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="al2msEc8"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb78c77ebso359946166b.1
        for <git@vger.kernel.org>; Fri, 15 Aug 2025 11:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755282361; x=1755887161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APEW140oDEHKUCAaT6MkEADxhHnWCDtEv5nuwYHrhP4=;
        b=al2msEc8OW0vX5bbrzUNilWzacfGkQgKTenMvADxkyWFUFsm55t6ukZn7g/LbfbXfE
         l61hCxWDieeB0LX2lLJafgZjbyav+9KbrTLZ2BWXbnADq7t3GWHFhGwY5UWiJ6HqQWiY
         sQ3dLSvZ4oztBIaBpZ6hIHH/oRFGI9ZJxCbnenr1Jg0oO+N8uFGfaLCOPTCeTvQBPuOR
         Irb94EsMCf8V6nzE4xW940+rhaYDH4lD5Vuu1sIApdCiI4e7vkpJ/xIQdyNxUT7pO3m3
         Yrypg50QvMS5NrE/05RLxg8yFnE6YElSa3DkJFMdbWDh0SZaI9szODNjXSMUzmzpQvhP
         AKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755282361; x=1755887161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=APEW140oDEHKUCAaT6MkEADxhHnWCDtEv5nuwYHrhP4=;
        b=UDOeuECt4IKhkTt4Jrvb6OiPoXZlPO3X/DnGrZPJu9jgH+NhIRkzoVEJ4VRHLN/zIO
         hG5CB+LNJJ6OJJHgFfPAiYo5SGTq/M5qOXPddnDY5mPOHFZIRdfsFQpE8XnjcHcHmTRR
         waZH5BGgKnuYXuYfBKXpGVPIcPMt82ftlxSrd/YgNUrwIZJsJWmDbiMI8PncZqAbZvh2
         iNAerBRd5wd5XQzVOYigFY2wchg7br5kAZZos1+JfvCmQZGFCnybv5RFROQhmP8yCEVb
         QhBReAE/ne+uPw/bm1DSiA9IHaNXQtoXEiPL7kLmXNZVgIWeQ1OdvmBQwa75ZZcNpmuS
         EEFg==
X-Forwarded-Encrypted: i=1; AJvYcCWT48XScCMxJQFIPH4lM2lkt2n47vQwv0hmQOTn2lJJMIHWa78wdf2szUwdKRZ04MTYuJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT8X9GSQYsGp9VMCdAk+rKfuh+aIthvPtU8/rrTylAouks4mAH
	/FMryh6X2Spk6wCrVIGtdfWBxAsoVEZ2S4CQr1tGeoA6ISJ4K97jm3yQFs+Z6ZgO1WmE9j09/FW
	z/yOKsz0CeC5aJNBGcNX6xabko6xtU/0=
X-Gm-Gg: ASbGncsvpXdK/W1ciXmPM64+kkEc3DFSNcv4JwCw18aurBwXhoFQlCIToLopr9wVn7Z
	JTwVPwKztvVXrSKOLLwS2FEN3P7vnaWjcCISUcymX3zL3AqnWkq2piCBPMueN5zIXF13RuxqRsq
	WEuXRcKPz939Azp1P3Wq73tn3gQKqJYOzd8EvkHEwk0BBWPSzQgA4rXdxGOjHGe9G45eMApzOwE
	vJBgdfeo12BoZAIJb7eumHFX3OJdGyZjIWsIkhXYw==
X-Google-Smtp-Source: AGHT+IFhQ5/OFaR5UBQQG6Qe5Rhtm9vleqzmYU7XxHirtWLxea3UMpw99pjC3jwC0IUET01AWm3Lv4jQv43p/dTWQ0U=
X-Received: by 2002:a17:906:730f:b0:af8:f7be:ab8d with SMTP id
 a640c23a62f3a-afcdc32836emr264221866b.36.1755282361223; Fri, 15 Aug 2025
 11:26:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
 <pull.1952.v2.git.1755127218.gitgitgadget@gmail.com> <ce1eafb02860b390da9359f92fcf098b7cdd3a94.1755127218.git.gitgitgadget@gmail.com>
 <xmqq349ty254.fsf@gitster.g> <886787d2-26b5-4451-a105-9ab522e38ad6@app.fastmail.com>
In-Reply-To: <886787d2-26b5-4451-a105-9ab522e38ad6@app.fastmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 15 Aug 2025 14:25:50 -0400
X-Gm-Features: Ac12FXzfMrOeg3g90MlF_7TLsT1aVqFd334VJRvkyea85uIEzoYC_raqNyd8b78
Message-ID: <CALnO6CCvL_wc9tkjHCa-9wp7fJMVDt-WHvHZnuOai5HzZb_j8w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] doc: git-add: make explanation less dry
To: Julia Evans <julia@jvns.ca>
Cc: Junio C Hamano <gitster@pobox.com>, Julia Evans <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Chris Torek <chris.torek@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 12:10=E2=80=AFPM Julia Evans <julia@jvns.ca> wrote:
>
> Hi,
>
> > I somehow find the text before this change easier to understand
> > (except for one thing).  "If you edit `file.c` after adding it" in
> > the new text says the same thing as "if you want subsequent ... in
> > the next commit" in the original but in a much better way.
>
> I really appreciate all of this feedback. It makes me wonder if there wou=
ld
> be a better way to approach this man page. Usually when I'm revising a te=
chnical
> explanation, I find people who are currently users of the software but wh=
o have
> trouble understanding how it works. Then I ask them to give feedback on w=
hat's
> confusing to them about the explanation or what questions they have.
>
> I do this because I find that often people who are extremely comfortable
> with using the software (including me, which is why I usually spend so mu=
ch
> time collecting feedback like this!) can lose sight of what's confusing t=
o an
> "average user".

The curse of knowledge ;)

> And every time I'm part of a discussion about documentation for
> an open source project it seems a bit strange to me for a group of people=
 who
> all already understand the concept to be discussing what would be cleares=
t to an
> "average user": surely the users themselves should be the judge of what's=
 clear
> to them!
>
> I'm still pretty new to writing open source documentation so I don't know=
 if
> collecting user feedback like this is a normal part of the process, but I=
 always
> learn a lot from this type of feedback and it's pretty easy for me to col=
lect
> it.

Whether it is or isn't normal, we could probably still benefit from
that perspective.

As Junio likes to say, a mistake being old is no good reason to carry
it forward into the future (or replicate it). I'll take that to mean
we also have an opportunity to improve the inputs to documentation (as
"leaving out such a perspective" would be the "mistake"=E2=80=94note I'm no=
t
ascribing intent, malicious or otherwise!).

--=20
D. Ben Knoble

Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5780E158A00
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 21:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725659497; cv=none; b=qe/jJ7NMeGnF/Y4rorN71BI71esGLsQG22vOE5Rn/L22ajaQPo73TPGd6HrHnPmEYt/ySFZRKzq+cpgNhIKuEPsNUXvDkLKt35F4H8VUoqr2lyN6yEqsf/3NI9jxZCk12ZZxZ3Er2qJsg6F95SD7dtQmUhyK/XHU3b/efG7HWbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725659497; c=relaxed/simple;
	bh=JHAB1eGvYkixGove3FA9XPKwX3YkT9HGNT+7UMnT+q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nEtFIooQIdTyaet7fcn3sJKQH5cEengdK+YzsT5QCX2LOVX+1GDCE/yz7bIVLyeJ4ZBxZzZ/nUUoM/Jk2KrNI6uEjSNM2m/EmICDLuEZuyTKMGXwvzYWtiQfGYY9vBnt5DMnOu4iyJa398KxmHXs6KCmuEGTGe9PccMNK15ZLH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnJqxZaP; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnJqxZaP"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8ce5db8668so106932366b.1
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 14:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725659495; x=1726264295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFiNoS0PfeBAFTUVAJaXkswu5ak5nNA/54nIgHUCCdA=;
        b=cnJqxZaP8DbZDWK92FH4DtzLutVWzd2ZPW5mrrWQkoo+YnYJz2tQg8wzWp16hc1aCi
         oO9jMku6lUJXyKxrnUjf2bgrnEBRZtkJ8pHMPal/zc5Ke3niWmg/y9RRQjO2VDwAHVFS
         NChuyhHEIuBbRvpoDpDJIhz22qXOWCu+RRN+sISCwc2Jq4co6gKIgeHA30hasvJJIrrv
         V/1oXWyBIxPYazY/ehMstD7aleRMpO5yYG5c26EH9K1sJyY2icblek2S4I8J6hDxMk7p
         rNCnN5f6wWo1tnUx45t5psja56xC9ZQC6+BdpWMLCi/Oj9gk8r3/+8o6UFEVof2sUwfa
         j/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725659495; x=1726264295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFiNoS0PfeBAFTUVAJaXkswu5ak5nNA/54nIgHUCCdA=;
        b=njhRnnoAR2hABtB+DLF1xfhjGFNTxCNKRu3szfHRv49t5t1L3WnHQsp/kKRxy9UXYZ
         fcX37j0PeZ40FV04BLzrMW9BAN4rjDuBTk11ar7vyGko8gcKZzScRVU+5DacTaWfIoo7
         abogf/1Tsc7QHM1ko7DR4qIkD2THUY4ZHAeIv9YvdcIFB+msEKBrPf0VIexK86xXiipw
         y259OYrK1qXOzad0nw1HbKXxu4dVc45uE3oINRAiMDxLvEi+J1A+TUjSvLXMxwvel8jo
         TK+VcEX43qvu1cQpPwH4rybwb7g7x+BeXw8LuuI43GMTowR3d9Z6p7dA4IxqLKWZ7zXw
         QCvA==
X-Forwarded-Encrypted: i=1; AJvYcCV4pHfVAzsOTec8J8jJkBHPxXqjMovxE7gUfFesjACOB/jOO9oUPakLMESzFLRlOsDyWCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3cPp3yXuS/Lb/3J1FEYnj5wy5PLXy88DZ23wD9bH00F731sQS
	OHurOHsHIullBlGjB8RtEzSpGrvsfDAkOmwtRbZ1vH6U4s0q4sFmsCP6Lrit2ekXmkPQMcVFts8
	Za7okt8FF2WqR/uSfVqu5wouH5tE=
X-Google-Smtp-Source: AGHT+IG/oKUsne2qlNFzCXtNS2rRH4OfQLuJRGtAOvt8VB+JZ4CHxVYJAZvEoSNwngjI4P2s1JdYwuB1g1Bid3xZ+l0=
X-Received: by 2002:a17:907:9688:b0:a7a:bb54:c858 with SMTP id
 a640c23a62f3a-a8d1bfcb56fmr41286666b.26.1725659494289; Fri, 06 Sep 2024
 14:51:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1725206584.git.me@ttaylorr.com> <cover.1725651952.git.me@ttaylorr.com>
 <0feee5d1d4fc1e0aa1ca5d98f2f404ecdbb2f6b6.1725651952.git.me@ttaylorr.com> <xmqqh6asv4nn.fsf@gitster.g>
In-Reply-To: <xmqqh6asv4nn.fsf@gitster.g>
From: Chris Torek <chris.torek@gmail.com>
Date: Fri, 6 Sep 2024 14:51:22 -0700
Message-ID: <CAPx1GveHxhzN7Am+etZcF4rh-JR+CUsL8WgqOXnB=mq_nuiprQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] finalize_object_file(): implement collision check
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, Jeff King <peff@peff.net>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Elijah Newren <newren@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 2:44=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
> Two and two half comments on [check_collision].
>
>  * We compare 4k at a time here, while copy.c copies 8k at a time,
>    and bulk-checkin.c uses 16k at a time.  Outside the scope of this
>    topic, we probably should pick one number and stick to it, unless
>    we have measured to pick perfect number for each case (and I know
>    I picked 8k for copy.c and 16k for bulk-checkin.c both out of
>    thin air).

In Ye Olden Days, 4k would be fine, and going back 40+ years
even 512 would be fine. For *writing* modern systems often
prefer at least 128K or even 1M; anything under 8K is Right Out.
For *writing* it tends to be less important due to caches.  Still:

>  * I would have expected at least we would fstat() them to declare
>    difference immediately after we find their sizes differ, for
>    example.  As we assume that calling into this function should be
>    rare, we prefer not to pay in complexity for performance here?

Another benefit of calling `stat` is that you get `st_blksize`, which
is the system's recommended I/O block size.

I almost commented about this earlier but the "should be rare"
thing held me back. :-)

(I have no comments on the rest of the comments.)

Chris

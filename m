Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF192B9C5
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 19:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724701068; cv=none; b=UFf4t2UsJrxp4/GD/TY9X0fnvyD941h3f8WoXdyJp2bOaYHPUWe8PBQ1oudPuCu+n/vK94VQIHyhFXGSO0xu1YHuicBveIJWnpLCpkQEG5dEdAgrR4TIjM7hrTITJDKalDaemuIW1TJf+byPUJ2yLKdNLo85fSz8ySOn5+pgFiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724701068; c=relaxed/simple;
	bh=kFqslyfNBZFkTHrpe/HiIq2daofnbyT7dzuSgvCYb4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qnEojkLit4+R6n2tdKKdLBrHCBjaZ8zn03BlPRlO9nphw3LeR/sW5W++DsP1pyj1DqB//zF4aKhy/WYG2IUgcbpy+o6fS3b/DBniMp6txij3JIijrtHCHrXgEZXJl48zLNtoT90TgtX7YdfZ5rihgve+rVnIrQCpxTfd79ln8gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=klerks.biz; spf=pass smtp.mailfrom=klerks.biz; dkim=pass (1024-bit key) header.d=klerks.biz header.i=@klerks.biz header.b=CIDT+DOj; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=klerks.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=klerks.biz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=klerks.biz header.i=@klerks.biz header.b="CIDT+DOj"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f401c20b56so40913601fa.0
        for <git@vger.kernel.org>; Mon, 26 Aug 2024 12:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google; t=1724701064; x=1725305864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFqslyfNBZFkTHrpe/HiIq2daofnbyT7dzuSgvCYb4g=;
        b=CIDT+DOjhxjSDfuMDO9C69n2FWtlqtpCqokuqzsvHzJi7SCUTfcl+WVAISZqMBXcCh
         A7Jo+pZt4keil0BSvtPdK/xJpfH1OChmTELr19/XS2MCQQPw4wjBTmhjWjIlPd6lmI8u
         Fms1uTRgAtv2AgD7cwAxtHZRooP6UeHyyKIQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724701064; x=1725305864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFqslyfNBZFkTHrpe/HiIq2daofnbyT7dzuSgvCYb4g=;
        b=jp+MUjekxXH4/jFFWEqIdpSxRu0dvehx57iVfCabysIm9wgYfIUNJWNZRRzp9JTv+R
         qIpzvgJIPgK9rHQQjgULUdRVKL2uN9nnmuBx0h1/ku/mSSe2lzDArhC/Ni8RN00B7bMd
         sPh2dAxz4LngjI1VJ1yXzNnAzhhgFynI99C+G8NqmwlV7P4vZJefShynGKyso/AXw2jv
         2QjSwOVEEouleY2ZpwO1QYXqabFS2jZdXPP98PHxyiP3p5PWf6RcUeRFfoQLgtzv1z2H
         3UoxF+7qPZ5HWxj8djdv36c8JfSdVEH7sj0/4+ExA8f796k2g/ZIkZ+E3HnK9lpfsvNr
         JnvQ==
X-Gm-Message-State: AOJu0YzdOyQpp+SXWH4vexkx2aD8yn3NLkXqczuuiF7pb6pac15VfPTz
	AB+fS4Q8Hri84UCbkpstseC5ZIVrtZYE1W+YxH9PaTXAtt++JY+M0KQwY4VAq+S0ZDTLp+HoXrC
	mzIK3cYZA6dhu5TmxspFV0f0D5af2Zrtu6k9Y
X-Google-Smtp-Source: AGHT+IERAj00Jpo56ipYMNjnlOoWrDB9PC/307pfufwE0nBrdxHqFThGtPNicNgAcAxbY+mDYPVDFNNvzKXjT2Ns0D8=
X-Received: by 2002:a05:6512:33d1:b0:533:4517:5363 with SMTP id
 2adb3069b0e04-5344dd982e5mr202467e87.21.1724701063817; Mon, 26 Aug 2024
 12:37:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPMMpog7=ZnhJhrgZFwzRZibLtK1-LyOhsrp5c4O85ocRFDZxw@mail.gmail.com>
 <xmqqv7znjir3.fsf@gitster.g>
In-Reply-To: <xmqqv7znjir3.fsf@gitster.g>
From: Tao Klerks <tao@klerks.biz>
Date: Mon, 26 Aug 2024 21:37:32 +0200
Message-ID: <CAPMMpoiPeSyLHUd072Q9AozdaCAjpOL03jY-0Y33B2iEQ5EdTQ@mail.gmail.com>
Subject: Re: Sensible way to see what objects are being fetched just-in-time
 in a partial clone?
To: Junio C Hamano <gitster@pobox.com>
Cc: git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 7:28=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
>
> Unlike the diff machinery, blame does not have a prefetch machinery.
> I am glad that somebody is looking at it.

I'm not convinced I'm looking at it in a very useful way from your
perspective: My C skills being spectacularly lacking for fixing the
core code, I am just writing an external python-based wrapper for "my"
users.

I will try to "productize" it sufficiently to send here in case it's
useful to someone, but all I can really offer the community-at-large
is confirmation that in principle, the approach works as you would
expect: With some small number of jit-fetches for rename-detection
during the revision walk(s), and with one blob-prefetch call
afterwards, "git blame" can be made to run cleanly/quickly in a
"filter:none" clone even on a file like "git.c", with hundreds of
revisions.

Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C27C1DC747
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730888182; cv=none; b=qhuWVOGbRK5mSFEPVVU4+RRGk4YQ929er6oaJneCOs5/r5lHXXYG0rBLZpv/8HhvPS844sionXngRqG6j8+UorTF18wo9mPwvdG8dAcHNbKyCEG6q9loqn4mlezYx02tLz72sIcljns8cErx+8WU7BeScwp42N0P3hyi9j1P6W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730888182; c=relaxed/simple;
	bh=eWhHZb7M1b0x17zSUrPTVCYXKOA7FT9PDpmnGn3Deik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=es9lUauQIdSpnUJmtj3pI1HwoAkS20kAPdxLhJBcKU8PSffMjn50VDLrKHkHv6RL/5dwzzpYA8CBFUaGmyz2GJ85tCvjcQ/UyH0pega3ldQW6EHDWLcCxCjVT+jJT4AAX7AF2s+L2MC7dzSlwwdkaz4Z3IHojhT/AiHK099+g8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAzGC8kW; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAzGC8kW"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb470a8b27so6672641fa.1
        for <git@vger.kernel.org>; Wed, 06 Nov 2024 02:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730888179; x=1731492979; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zoSLChFEPTYyouhyhQDN6y5ptBh1tv4+yaiwHmFS62M=;
        b=SAzGC8kW0NlwTUD8/aejbYp9KgI/M1o50NB4d/HfNWMia8HbZvQyrLVsd9vF3Nr7O6
         TtoFH4RPZ+jKIit1L8lOSfivEbrIm/QpzmqQcBiwcNGeoxxu2T49CVPotp5IzdfMk+xn
         dtFxra+r+Z7rWE9PMhy54RLTY42Nl/rNF5oC5iSM9x/AcBxuqPnUVIbNeHHdryCdBDsL
         t3QKWiC+NgXrht+MDkBuiI3Y7h8hA3jEhncBqVUYldh3yylNFFZqsS8RMuvrZU3cP7L3
         eCMjNRP21pu2AmfjcVI3lxo8MIwMQ5SfRhSlBBOCzIt/ZuGbzSf4dnkxCw/dWiNXTT2W
         vPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730888179; x=1731492979;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zoSLChFEPTYyouhyhQDN6y5ptBh1tv4+yaiwHmFS62M=;
        b=er43VHsUl5Ebj1IrOT6DlRgnh5dxHXGQLO4Zu0LnUGWWd/938vnhZ5X9Fyfq7x0wn7
         /F5EXi1uWu+wogRw53Gl8v84nsIwwZpJt4jUFiHuPdSy6n6mb1qjmswiK+R1bKv0lKCl
         5EITOYCptdhxHSPqGVslgFKFyUE/JamU6LfufgS2O9tcBYjsrPVgLb6SUQQzgArXVRiQ
         UrfqJQMhe4/t6EjCn5S5C98X6TGb+SLz0d3/hMF5rnE0BZ5HSc7xKSvwiHjHRjElVQ9o
         og2ND1raTI1MMNV5b0J2igalTbMhRaQeppbS+LpoYSYITrYNQH7MyP8o2Mg6szLCEe5z
         6+wg==
X-Forwarded-Encrypted: i=1; AJvYcCU3F53iUX+nBAV0lB/IhKW9S2kyxTwwOd/szspSlfLPHsqI54caVbwigQe5t4of9FSoe2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHl37RUTuTjpNJMqFILDeN2WtOOzD9Zn+HU549ECc0ML2SeUuG
	1Gxh/kyK9IdkB6jFqztQnD9tZYnyWbaCNkXMx7KuafkNKMOEpEuP3AxnC0HM+88BB6x+RnMTi3L
	3Wbd4s3oZE/WZu0AV6I6kG8UG2V9Rt0C8
X-Google-Smtp-Source: AGHT+IEr9eTpG6cBCI6b6VXAaN8u9G8h9bypsdbuB11aJfhZU++5+O5PLBDp3+xAR+P5fg3OIWta45WmWjahISDCyzw=
X-Received: by 2002:a05:6512:3d09:b0:539:eb97:61d7 with SMTP id
 2adb3069b0e04-53d7cfd80bbmr642375e87.4.1730888178925; Wed, 06 Nov 2024
 02:16:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANM0SV0KKd+WN4MQ1_8fEvFyD4tYY3qAUsUh9Njcy1xo1hNSBw@mail.gmail.com>
 <CANM0SV0Muk8KT6Mv=14ui07c6OzaNDDQwg2bUVRb8JyJWTyHnQ@mail.gmail.com>
 <Zx7O3VsZX2B9d9qN@nand.local> <CANM0SV3vNBwoNw08AevHE-3cOjUTG4AGVJdpwfKCr=CX5DSW8w@mail.gmail.com>
 <xmqqmsifwbes.fsf@gitster.g>
In-Reply-To: <xmqqmsifwbes.fsf@gitster.g>
From: Devste Devste <devstemail@gmail.com>
Date: Wed, 6 Nov 2024 11:16:07 +0100
Message-ID: <CANM0SV3iF5str0r=BKUOV=wu+Ljn-hR2xcs3zqxfXWrhUigOJQ@mail.gmail.com>
Subject: Re: 2.43+ git checkout --theirs on stash error - no alternative?
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Afaik it means any conflicts should be resolved using --theirs
strategy (like in git merge-file --theirs) and if I remember
correctly, this is also how it behaved when testing it.

On Mon, 4 Nov 2024 at 11:17, Junio C Hamano <gitster@pobox.com> wrote:
>
> Devste Devste <devstemail@gmail.com> writes:
>
> > On Mon, 28 Oct 2024 at 00:38, Taylor Blau <me@ttaylorr.com> wrote:
> >>
> >> On Sun, Oct 27, 2024 at 11:31:05PM +0100, Devste Devste wrote:
> >> > Turns out the previous behavior can be achieved with
> >> > git restore --source='stash@{0}' -- "some-file.txt"
> >>
> >> Hmm. What you wrote above here makes sense, but I agree with the
> >> original change from Junio (CC'd) that using `--theirs` does not make
> >> sense when the source is a tree-ish and not the index directly.
> >>
> >> This is different, though, since here you are just trying to check out
> >> the contents of some-file.txt at stash@{0}, without `--theirs`. What did
> >> you mean in the previous example, and why was `--theirs` necessary in
> >> the call there?
>
> > "--theirs" was necessary since I want the file exactly as it is in the
> > stash - any conflicts from applying the file from stash should be
> > automatically resolved using the hunk from the stash
>
> But "--theirs" is to take their version unconditionally, isn't it?
> There is no "if conflicted take theirs", or "take theirs only in
> conflicted parts, but otherwise take a natural merge result".  At
> least, I do not recall writing the code to behave that way.
>
> So I am not sure if you are getting what you _think_ you are gettin
> by passing "--theirs".
>

Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBBC223327
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748879790; cv=none; b=oKMUL+DPpmi1T8B750FSOuqHQTUjJl0VSPl+Hoj/3H66od2/YQ3SQEy1cNcqUl8GIDKO14l4J/pb6oMVyiJOXExf9O1499qzPikBoN/M64PQst5mW/xc6Ypg6/vCfZlz59aeeYtMa2rbFpsZCps82u/JqLk8MdxytVdvkn9ERvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748879790; c=relaxed/simple;
	bh=62UjpkhkS32nuHuCyH5sX8xwPoDVIeM2Q+ilgqHmIjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a0Dv8OtZjjnZIUZnu9sQzw4G5s+kIdTJoNGSKYI7euXJUYpQa+AwCQXSMSgklkZXAz9OW+NASEJEKsfVpy+dR5KcTmsSxFJWW9sqTKOm53TDpMD3l1QzlHkPXDGahxM9nnjBZHREQS70AAg2aDY9aAjbXdI7tpdoFe9NBhYguFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgMsQA22; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgMsQA22"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-addcea380eeso204745266b.0
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 08:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748879787; x=1749484587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djuc4Z6gRgemB2j00z96z5F3YqHmSQk0ldL9NfywfrY=;
        b=NgMsQA22BkbZQUTTKp20P1yrIenPFcozhHvwk3JtnaBi8D6UggW2+aT/poZQ5TYZ32
         10BHcCE1GFseYhRCq/zsHNz/KNjdfpp7SOAWyaKASLChE2nRQbhersQNq1lP7vgC9xkb
         cnmgvZruIB6wYWz1Hfe780f7Ga5v8FYewp5VxcXAP0pz769Zwsb6SQ+ioBuJKFogbNZr
         J16R4DBPWSoIaVh+oLFj1yuMonkPlbFzf8ZOOzO6ueYY+kayjAMTH0CULMo3yNQsT2NJ
         yQYFeWfIxDv93CSIUzOG1lnYSQyf1/90/QU848J/kDZ+1rZyIHmYivCXj8eoylbcjzUi
         OBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748879787; x=1749484587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djuc4Z6gRgemB2j00z96z5F3YqHmSQk0ldL9NfywfrY=;
        b=Gt0M/1/KSM0Rlo7SvUv8YGoqqxCgGhGd7FYbAWzYwnQCFgtHB//ypY1NjuFPfcdZnz
         4DoJKOR/xp/7P/lLxJEVNjnGDbKCJ4oV7Ddst4UCRUck2SGMh6qrapiiNjr0EqkzAtRT
         5BOvILBNAgOaIztq1P18+6rR+mVffKWpvA8FAEGnzhL2PCQSnli/gwCw6YP1JBjB1MxV
         09XFcZxzn1Bb1QEZL+ybPSubQDWzkuVRE/CD9NGFdGASt1fn8uNG7y8kiqf/x8nr8Dkh
         MX++TDO21oHRBlLEIyYxBQ9OSxWQovWl4L9rXQK18RjlZUzjJTDEvhyRbhyTQ8J12Xa6
         2VwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVagyr2MFwixsc3UR3telm+cNoM5ULFms+IDSE7Q781Czc5Ot7Yse1rLDhla7n+zBf8WNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBWk2sYjE63a97+fyuvSXpO5+/nT0KihGqpPmqyHAtfAh6XzuQ
	rUHwS2pEqxSu2VULI4xPkZu8vi66wyUx2lOu6n4RKhkm/zo6daWgw3+tq1xQGviSPjOK4883k8i
	XbcmAvCofYWhB6LP8KOZh+hz1SSlzJswEw9Sp
X-Gm-Gg: ASbGnctdy6HEUrm3zygprSfnmCXZqyB9L7gWMqLsQF3Bjg8bdz5WryXaK75o/2o1uRA
	lboQb3kAgFLaNTuftDxbRQCnvsq77Fd+EAVB0M143zDNhZQ6XPUNXNNW5UQzj65j45nNWIHC6Yj
	i0rObDAbzeBy5QaEDRcJqYPy3nPFQKh0mqF6g=
X-Google-Smtp-Source: AGHT+IGqQTgo9lJPG0wfNF1MZRL106inw0JRDdA8VS4tRfQJgNQNxIpv1uYE6PgwFR9/jn8xUk2zZHHTZi/O+rY9Pxs=
X-Received: by 2002:a17:907:968c:b0:ad1:e7f0:d8e5 with SMTP id
 a640c23a62f3a-adb493c9d18mr959785366b.16.1748879786627; Mon, 02 Jun 2025
 08:56:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424203904.909777-1-christian.couder@gmail.com>
 <xmqqselxtfyf.fsf@gitster.g> <CABPp-BHudzADoYdBvoBZ1yDRj7Ra_V-or6ddAOV6nmXeMMpMaw@mail.gmail.com>
 <xmqq1pthtbdg.fsf@gitster.g> <CAP8UFD0OdqnoFeYY+7y-No_x_DknapoLzvqvsy-+x_602sYQbg@mail.gmail.com>
 <xmqqzfeyqdye.fsf@gitster.g> <xmqq8qmgsky8.fsf@gitster.g> <CABPp-BGe6r-X7NOiBFEvLGZH+GQvLkOYWn+qf3ZzzgT4sGAyOg@mail.gmail.com>
 <xmqq4ix4qtva.fsf@gitster.g> <CABPp-BFRhSB0zTY1m+gYOpfvmuTvN5Pu3STawJwx9P-ayJw6bA@mail.gmail.com>
 <xmqqwma0nm6c.fsf@gitster.g>
In-Reply-To: <xmqqwma0nm6c.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 2 Jun 2025 17:56:13 +0200
X-Gm-Features: AX0GCFttPL2u1HXCqyX6S4a9tyoLlwmUNiVDzGL3JQ7tJE3iKgBrOQvXtxlNboI
Message-ID: <CAP8UFD3c3QCqyt5OS_mXRgye47LircGUhyrM1gYR=bRbN64i8A@mail.gmail.com>
Subject: Re: [PATCH] fast-(import|export): improve on the signature algorithm name
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren <newren@gmail.com>, Luke Shumaker <lukeshu@datawire.io>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 5:14=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Personally, I kind of think abort makes more sense as the default --
> > at some point.
>
> Oh, of course.
>
> > So I'm curious if you've just changed your mind
> > completely from before and are against changing the default at all,
>
> Yes, after seeing that the representation of the signature algorithm
> and encapsulation format was not as well thought out as I thought it
> would already be and its design still being discussed, I realized
> that the new feature was way premature to have in the release.  At
> some point, when things mature and we are reasonably sure we will
> not have to make incompatible changes in the data stream, we might
> need to switch, and the best default might turn out to be to refuse
> to work unless the end-user makes an explicit choice, but as the
> design of the feature stands now, I have a feeling that it is a bit
> premature.  Certainly not ready for general consumption.

Discouraging the use of the feature and saying it's highly
experimental should hint that the default might change in the future,
but maybe we should explicitly say so?

> Of course, I could have just reverted the merge of the original
> topic and give it a chance for a fresh restart the next cycle, but a
> new feature clearly marked "highly experimental" would hopefully set
> the end-user expectation straight, as long as the default is "do not
> do anything different from before", which is the safest choice for a
> feature whose design is still wobbly.

Yeah, I agree with this approach in general.

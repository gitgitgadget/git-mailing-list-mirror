Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CD54192FE
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 12:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781009983; cv=none; b=hI35CslD1Zb/KPEhqtPS5ZioGmSnAC/NezkvxxBddvuNGHg+IZ9JHcyR4T04uhLF7wt/UJ6UeMYIbXvsFJM6dutkEff+B7GZdidmmwGfxadno2I3NqHaTbCp7z1kw2FcG6LrdBI7y9q/r85g44LvgSZ9KZKc+rdh/BRHbB4y8Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781009983; c=relaxed/simple;
	bh=xdPRO9D4Y9vPNl6C+5YurgAruk4bovMJ/TZ0nvhq5vg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LWVJlERsSbRrcNUS1/+mDIZzWpFv5TW6GJMXV65uNlfp415/Z8CJC0pzxoEz8ECIz1BJR7l4T2eRjyz1Uh+YUNC4TqbNd59ENhEkHuxJGI2a1Y6TpZtieoD+5r7WXfyi88Sy2NugYEsR/97y/Oeh5KOwgsaz4AvAJNnl/i8x+3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EdLNztlj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d7s1yt8K; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EdLNztlj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d7s1yt8K"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1092F7A00D2;
	Tue,  9 Jun 2026 08:59:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Tue, 09 Jun 2026 08:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781009980; x=1781096380; bh=79+rbMMFyV
	YctjXonWBgomaaVsr1Py+BDYheyIF5aOc=; b=EdLNztljEofeQzDK/2tQ7QikR4
	Cs7xuIY7MGETqwbAWUlzHUm4Hy31B5kwOPuW8T9nElY1hJoktxx+Df5Y3kDh3gsB
	4Rwl0VKQPQkM61e5j6fb1ThlbBldU5leL6m8C0utDtbkLU0zWEjkpdn9wJbzTzoE
	pax54hppU242Kdgjb7UFZ383MsWUoFT4LIDU5OBnfrS0tPwLdMA+jbPdE4OIzoq1
	Ad/+P2B4rmBnRGtKZ2cFfSri9Qs4Vp/ZC3CDL9d3YfTJawclIV3L5bVPypfkDoFS
	fxTLOYnmlun20MuUHbBHy7zqqE3G6YHU2tFsws2alE6Y6SLEUgv81bzs8NVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781009980; x=1781096380; bh=79+rbMMFyVYctjXonWBgomaaVsr1Py+BDYh
	eyIF5aOc=; b=d7s1yt8K2Bf562cNDITlLN0SU5caA7hFvkf0yHoLIqeezpqMDX8
	fSmax5A+jUd8l5yniZcvV+WXDuW4He4jsVrs6diG5JXeuG9w/aI40ot9oSjg+e7i
	XmnrMYo+PcS+yMMmOfGugktOfm8G8ux69AcXRUZiMY4TtNxVOZS8vhw4GBvZAJ9W
	bRMXt4c2lM2o11HWcBkbFoMMVJ0ah5uz235U/2TR31MaDOjBHVlumcM8c+ikBQCP
	yUpUzDNy4+2w6PVtw01w90eq/RFi/eusSApQRB83q2bazKqYCBppz492biiyh31O
	zV0UkJBfububpJELYAJ8GhFMYFLp0xsz3ew==
X-ME-Sender: <xms:PA4oarAIV5KY7AWwrZhB-6brSMStz8XtH1zcf6C91Zj8lw7v1u-J2A>
    <xme:PA4oaoiTS4bxGYa9bR1MP7aQLSNjGVcMkAJ_UPoF-43uc66elQgq7gR4uZ7FRRF9D
    9GSDMGsSprcMdYNVZHBlLa-BcBE8QDNODuNFxmBw8Bm4mZO42LIlg>
X-ME-Received: <xmr:PA4oarkOBHQhP3O8ShccMFcgA23AzR-micl2K-s2mEzVbwbnHXeCiqyL77NlsktxXsXP8seVRo4Jjv4_6g4d801QmbumGFfAvph6>
X-ME-Proxy-Cause: dmFkZTEdWw2JJAirDr6uq8+LsDn2QB2VuSuRonGAilr/VP2qjmmU0Q3qLQONQcctARDGnt
    7kLxxHgQM161aNFbyjET5z89DIbcCUO2vK3uL3cqOepO6O8KRRQtzOJgd/fu1L1XISv7lO
    SaLXwx2WmxriBdcYhyL3Q4Q3qz5nWMi5UEIKumog9yK9fvG5Aii0KRsfJ6rehoieUTOX38
    NN5r7G+dRf/t5YqjkUKhC4S2njDP1uGKL511EPj5NvylLPG1VIT0BICrA5BzKLj8oCLX+5
    c77whJjWiJGdRXIg2bAkBSnW3Fy91nqKSBdXQx4ZQ8aqYmHUEVulXyUDe/0/OuRCt2XAoa
    R82bgxSGKKqaN8+TVKgP1txhuGMfzRQTIOQwJexYlDZewgPbwmXL+PxEprJgrpO1K0oxVq
    by3Ds8pbYsSjtbirkGyx0tVGcyyTeX1LS4GpCClOuNb2tzPMe2/YXMmseYqAwUtmMfDhs+
    X3y8gLCus6WjHl7xyVkXo1riYkNthh8MVpYvXktPSPX9ct94oszwbf+GvxmTaJoOqwqaYE
    qTOg9h/F7g4RVxNPgBZ53gzjqKYaBiiR5yiTMwprGkI2isTBUYnhn42kR7PqAZG+YS4xCo
    o89JvMxJnptqWDXTVyGKDXZtAbdUVGiI790wg8i5gOcFCuJyO+gDqFAwsfUg
X-ME-Proxy: <xmx:PA4oasqIoOS7QTZ1EpVjdZL9PGx9T1y92llROLD3ZUdsQmblMpIpYw>
    <xmx:PA4oasHvuIZtEbfzODvvpktmUH3P37RMRIz5QlSMOrk9gtbqO1jiSQ>
    <xmx:PA4oagzJpzYiatw1G6Al_6u0rNEPis1Oo6LHEOi0_5TcbDoA5UX6FQ>
    <xmx:PA4oapp1DEsdjkzrMINp25Jc68tmNZvrPZoOnf9rjYGAkkBCv3hL8Q>
    <xmx:PA4oajF2bmIu8lsKlK7Zwb1pzI-JoH0Sio3fEBFPHAlO1PH132ZhodoF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 08:59:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Lei Zhu via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Lei Zhu <korov9.c@gmail.com>
Subject: Re: [PATCH] switch: add --ensure option
In-Reply-To: <pull.2324.git.git.1780997009796.gitgitgadget@gmail.com> (Lei Zhu
	via GitGitGadget's message of "Tue, 09 Jun 2026 09:23:29 +0000")
References: <pull.2324.git.git.1780997009796.gitgitgadget@gmail.com>
Date: Tue, 09 Jun 2026 05:59:39 -0700
Message-ID: <xmqq33yvuax0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lei Zhu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Users who often switch between topic branches may not know whether the
> local branch already exists. Without this option, they need to check
> for the branch first and then choose between `git switch <branch>` and
> `git switch -c <branch>`. The new option folds that workflow into a
> single command.

Quite honestly, I am not sure if the use case should be supported
with a new option, or we should actively discourage it by rejecting
any patch that takes us in this direction, as the actions the user
would take after seeing the result of "git checkout -b" or "git
switch -c" are quite different among (just off the top of my head):

 (1) Ah we already had the branch created exactly to work on this;
     instead of forking a new effort, switch to the existing branch
     and build on the effort we made previously, as it forks from an
     acceptable base, which might have been different from where we
     wanted to start at when we said "git switch -c <branch> <base>".

 (2) Ah we already had the branch created exactly to work on this.
     Unfortunately, it was forked from way too new base before we
     realized that this is also an important bugfix that needs to be
     mergeable to the maintenance track.  Let's create a new branch
     that is a copy of the existing one with "-maint" in its name,
     rebase it on the maintenance track, and work there.

 (3) Ah we already had a branch that happened to have the same name,
     but created for totally different reasons.  We do want to fork
     a new branch but need to give it a different name.

 (4) There wasn't a branch with the given name, so we created a new
     branch at the right starting point we just picked when we ran
     "git checkout -b"/"git switch -c".  Let's start working on the
     topic.

You cover *only* case (4) perfectly.  When your "-c <branch>" picks
an existing branch, the user still needs to figure out which among
situations (1)-(3) (of course, there may be others) they are in, and
act accordingly.  "git checkout -b" and "git switch -c" that fails,
reminding that there is an existing branch with the same name, gives
users a stronger form of reminder than switching blindly to the
existing branch, which may (in case (1)) or may not (in cases (2)
and (3)) be where the user wants to be when taking the next action.

Having said that.

 * The option name "-e" would make all users expect that this has
   something to do with "--editor".  Start with a longer name,
   perhaps "--create-if-missing" or something, and then see if
   others can come up with a better short-hand.  Obviously whoever
   chooses "-e" is not equipped well to do so (yet), and the
   reviewer who pointed out "-e" is not a good idea without being
   able to offer a better alternative is not, either ;-).

 * Adding a new flag only to "switch" without "checkout" will
   unnecessary confuse users.  This is because, even though
   "switch/restore" started as an experiment to _supersede_
   "checkout", they were not successful, not in the sense that
   "switch/restore" were harder to use than the original, but in the
   sense that the userbase and teaching materials are already used
   to the original and removing it is practically infeasible.

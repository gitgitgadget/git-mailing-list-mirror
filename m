Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72882E1F01
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 16:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755793622; cv=none; b=FBa9LtH/Y+yc8avIAFJtmtJXT5Uscpk0/xuPcZsa2MnBukBuDDqCD8jmhIJjeruLuvto9cFaffX04WTGUmzqZx1q7RI++Ums1LzUZ0WAD13jvBmTy23jJbu8vJ0xbHKxSCl6zryc4kA6XrLm507QykCF+I711VhGftgDlWjJxXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755793622; c=relaxed/simple;
	bh=67KQ9O37NXN7xIVN51ONDNtwGzfqH3uG39iwNP1Upr4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=I7dLHKUR04Ui6aDlgIpmPFfpv+yRwdZGLu2gJAhVV5WDQRKAJLOAPDO/0J81uuGOWg5znRQ4kQ1hzdLwtMd97barD4tjMeemUXXNlK3sQnXYyHTVpu2aXrz+I0h1Pg539/PDWwM9ZXwI59vajcVYm/pXccY1SWNYgMtz0fsW/6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAD9pVdf; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAD9pVdf"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-333f901b2d2so9917711fa.2
        for <git@vger.kernel.org>; Thu, 21 Aug 2025 09:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755793618; x=1756398418; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yXqkYOY+binxI/Ctcdd0HwqteQT88vQracm+/CFIXbg=;
        b=eAD9pVdfVtUpEN+6Zvn4iP3bCLpyvE6eo4vzUztTYiqHjYaFXxp61Cdnvpjem4gAw7
         yUDnpRzWV14GBSKeeYZIsYLQJA7FBMU1doT4Rd4+dGN26kHKwnXtG0inhlbV8+KXTt9k
         axa1sonnDMQX/9WgXZC7ZVgD58IfygKF4G352bVlJuZO5lz5iTGXl56Y/es5sXE8nmAH
         SCsY7SCtSGQp4R4lleaAk8pxzcUURaBpcu2c4mZXhtK/un5bblAu7oFD3hYzbT8lCGO4
         k8eZeEZg59XGhLeLSDK8kxme5maPOlbwNOc7QjU+6CMG2FWI4ZOx6L4trljpzFAehD41
         HEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755793618; x=1756398418;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXqkYOY+binxI/Ctcdd0HwqteQT88vQracm+/CFIXbg=;
        b=wAFbOgbuIzqDvLAc+eb7dvmYQO8CnBNmY4F9aWszpMDx/gN0slD8k3EFQ1T6reABFl
         TrBe8iJHgFIu9UGkENvsXSZnYeF/qHnlHhjhoYW0v0C7DvkkyLHrX/mtKuun+u5BzjQu
         gnFi7jD4ogXAdGR5PLzljoT/MqWyOgl3zvl6dHy5l/LvPYB7CMWK5EqxoiP0mWyBIX3l
         tlnUjt0Oxk0/2nIJysMaRBfgfjsNcUq+Uuo8ou+rqWaS6qU9uDQzLA4qNNl7GshuMVuT
         sa9BFrl1DnNK2sxsTZ1yA5+1k6e+GG4mUn6Ttr28Pt/cc0WmZe9cLX5TXlMMbEN6fTOq
         qQEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVm7U+oBFrCiHzSrX2HCVISPq0W6TSwUHWHyOIOLTqKQDQtMpCqJ7S0UIPHsh7DMYZG1Mo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKVigITSmrXLBusMJ/8RhbkmhjlhK468+vlp80HtIx3LgVzxei
	iXofJjQbFSE0o0zujGCPZxjWsic7AZ5N8hu7wbc/QuO+fQjj2M0VBvbTrWy2sw==
X-Gm-Gg: ASbGncvmwbCniz1laB/tLePU0K19aFIGmXc3+bJZa08L4wgVoiX194J+FWYOztces+g
	FVim8j93OyYoR0tPbZC9xEjNxoreLCAyCmiiJ3CAYY0Bpu3hBNbPlGrA2/aeV9KJS61tCw1hB1+
	EDKjSIOD67ddGJXV0p5dI3A3OtATIDSoGqtKdSoncBUodWr70gSgW2N3AHYhu0LYjRJAngZwV1e
	XNgb0W2lOA0nInsVmPKwsCRVS5Nz6gMHW6nceNUBfj1yvd7hp5fu5XzHtA2+JOYNa4QI1Lx2VSI
	BTDfT3Bo05RPOa8RuWb+wQtKPC8a4BRiZoZF5HeIOCJkacdBALk0KzMMiYtPQE6vQ5Zv9K2JuAg
	f1obPxBTpbJNybs3gFiMqoCovvA==
X-Google-Smtp-Source: AGHT+IFS6uDDsZWR4VP/Fz5P01H7ZXQjWfhy+iHjJisGLsbu/IcZ2dzsPekDHMkyn1KsaGhzt0RRoQ==
X-Received: by 2002:a2e:a282:0:b0:32f:1c10:fa with SMTP id 38308e7fff4ca-33549f798edmr9725641fa.28.1755793618118;
        Thu, 21 Aug 2025 09:26:58 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3364e5bab44sm454531fa.46.2025.08.21.09.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 09:26:57 -0700 (PDT)
From: Sergey Organov <sorganov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH RFC 00/11] Introduce git-history(1) command for easy
 history editing
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
	<xmqqms7tao9o.fsf@gitster.g>
Date: Thu, 21 Aug 2025 19:26:57 +0300
In-Reply-To: <xmqqms7tao9o.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	20 Aug 2025 10:36:35 -0700")
Message-ID: <87a53sr67i.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> In the end, I'd like us to learn from what people like about Jujutsu and
>> apply those learnings to Git. We won't be able to apply all learnings
>> from Jujutsu, as the workflow is quite different there due to the lack
>> of the index. But other things we certainly can apply to Git directly.
>>
>> Note: This patch series currently builds on the cherry-pick infra.
>> As such, when one hits a merge conflict one needs to `git cherry-pick
>> --continue`, which is quite suboptimal. I didn't want to overpolish this
>> series before getting some feedback, but it is something I'll fix in
>> subsequent versions. Furthermore, the command for now bails out in the
>> case where there's any merge commits in the history that is being
>> rewritten. This is another restriction that can be lifted in the future.
>
> Two comments.
>
>  - You would want to honor notes.rewriteref yourself, as cherry-pick
>    does not and that is deliberate [*].
>
>  - It is a sensible design decision to limit it to linear single
>    strand of pearls history.  "history reword <commit>" when
>    <commit> can be reached from many branches along linear history
>    that rewrites all these commits on these branches would be handy.
>    There may need some way to say "these branches are protected, if
>    'history reword <commit>' needs to touch commits on any of these,
>    abort" and things like that.
>
>
> [Footnote]
>
>  * "history edit" (aka "rebase") is an operation that "edits" the
>    history, once the edit finishes, the result is *the* history you
>    want, and the previous one is to be discarded (except for in
>    reflog).  "cherry-pick" on the other hand is "I have this good
>    thing on this development track, I want an equivalent _copy_ of
>    it on _another_ track"---it merely is an easier and quicker way
>    than typing the same thing yourself on top of the other track,
>    and does not duplicate notes.

Unless I'm ignorant, "git rebase" (aka "history edit") lacks essential
feature though: in addition to saying: get "this" history and rebase it
"there", one should be able to say: get "that" history, and rebase it
"here" (aka cherry-pick on steroids), that also would eliminate the need
for 'git cherry-pick <range>' that (poorly) duplicates rebase
functionality.

If not to implement this as, say, "git rebase --pick", I'd like to see
this feature in the new "git history" command, but then it'd eventually
become yet another "git rebase"? Or will Git then aim to eventually
factor-out a lot of "git rebase" functionality into new "git history
rebase <what> <where>", or something like this?

Thanks,
Sergey Organov

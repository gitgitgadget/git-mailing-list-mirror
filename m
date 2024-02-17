Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E3D6519E
	for <git@vger.kernel.org>; Sat, 17 Feb 2024 14:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708181936; cv=none; b=TO/NDT0C0q/4pmWaEhBd8/BHqXJYKcw18wHonfRh4q7PBE5de+uFGUfq2O4qX/H7P5cIxBlxW4RXfbeqQAUigVfTHqVcIjJGNqqT8PoAAs9R9XLK+1DOtOOQI+S+VtrAWxctNa32srlwlOK3ElbVuY5vTktVgz9/W/WdS1ulM6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708181936; c=relaxed/simple;
	bh=2JKsKwmx3iM2euj3c8XAcYr8U7Zo1v1ADSntXhxQezs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kOm+AYXN7byYVOxpKdjGhuzY4a7uc6rAec/eHkaOxBdv9tpDUuGRtA8Qt3VFu2oEUA/fcC370Lbp95PW/fmOaug+u1wIzphFip7odle0/Lym+pYrm+ZDrBDUz3zUAOWtp8881CQMOw2caw6xhmFUyhQPW2uNBdRuNex7FrXoq0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+DosDq6; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+DosDq6"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4125dbc797aso2856395e9.1
        for <git@vger.kernel.org>; Sat, 17 Feb 2024 06:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708181933; x=1708786733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K61BfyuBP3ep0oxm89sKk+X9yX0VllILHSBNceqLdUs=;
        b=C+DosDq6DwLD5sUP3TfOmglcyDeCKYe7I7EeN7+YJHmjs67XV14gYCQHSfwkcA8+NL
         nsa4jnoMS2+fLu3fSMtAEA8Q2Frvcc/lTGV/GR2HAZVU8Yl030nDrwi7+pFZ5VSOjmzZ
         g2lWPoQqQtN8MiyPfrvOwPnWCRjQ+6lFC0KvExj0/XcvvVgnb6w24LSax0j2yzbuCcVP
         fIT8LjsQonbAKMw9o7ED5G2RPC8ZK80n1zXou+lIRaMNnBVFT7gx/S50KUIPXUTGULIT
         H0fZW4yHcnuQev21h7b4KbtFWdToFr9mRB66Bm/gEsi9pxbKNoaC3SBX+drAFjozUpk8
         bkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708181933; x=1708786733;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K61BfyuBP3ep0oxm89sKk+X9yX0VllILHSBNceqLdUs=;
        b=CTFULIj2UyG8sKYl9IE46RcG+zdWprbCnAPXz7Ylhp7hPltZN7UgQwl2vINBOQ3hp9
         xbiTYN5Wys06HQqLTBggO7c+PpA4dUNP7TtCbEcvrPR1NtsjE4hiIdyMNkL9KBWvAd/s
         +DQXsfgfZv7ZYscZFgBT5zjOfPaxgzGjvJVc0KNAZMfp6bXOLDnCoT0mYSX/ChJFMAEM
         u14NjVGXklPlDZPXC2Cm7dLlHm0b/ab1sUnZ8ioLUu6JmgowFS046MyIAfI5gbQFlVhh
         bKzWxLwhhDwIpfl86Qj1RuPvWOBVGsMHtt39pHf/As8d9Dz/R+TQpaWMgTB+YRacy9hm
         PXfA==
X-Forwarded-Encrypted: i=1; AJvYcCU8NyOmGYhd5Kh68oiXhBv4LgwAKvgDEA9b9687Yhc2QKTM1mVeBh4P9dwUISGdkYqiOW3VTZNfJkkHLJPap11o8sLs
X-Gm-Message-State: AOJu0YwUg4k7ds04f92yrb4SeHaUEgmXJSAhttCW0TJsAd9uTbYlTCNC
	kXmfoFVF46hdmAKyfZdcNSMJHUe8XB3bN6ARwglxGJGWow4bTDq0
X-Google-Smtp-Source: AGHT+IFDWbRmIWwf8h1yvr/0Hja52ibrpvRYOD6w0sTLb+weEPmdYb0YcA0eTIoXBvLPtDouJW8AlA==
X-Received: by 2002:a5d:5348:0:b0:33b:74a3:dcfb with SMTP id t8-20020a5d5348000000b0033b74a3dcfbmr4883025wrv.1.1708181932530;
        Sat, 17 Feb 2024 06:58:52 -0800 (PST)
Received: from gmail.com (193.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.193])
        by smtp.gmail.com with ESMTPSA id g1-20020a056000118100b00337d5cd0d8asm5067508wrx.90.2024.02.17.06.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 06:58:51 -0800 (PST)
Message-ID: <c00f6efe-d1f4-4f2c-99cc-ac7a6d93c9ff@gmail.com>
Date: Sat, 17 Feb 2024 15:58:46 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] branch: rework the descriptions of rename and copy
 operations
To: Dragan Simic <dsimic@manjaro.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <3cbc78bb5729f304b30bf37a18d1762af553aa00.1708022441.git.dsimic@manjaro.org>
 <e8fdd057-2670-4c93-b362-202a339d5f49@gmail.com> <xmqq8r3lnzp0.fsf@gitster.g>
 <2a4de8c4-4955-4891-859c-58730a41e5af@gmail.com>
 <ea15a49aed7b5a74cd9b1bf8a5351df9@manjaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <ea15a49aed7b5a74cd9b1bf8a5351df9@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16-feb-2024 04:32:10, Dragan Simic wrote:
> On 2024-02-16 00:34, Rubén Justo wrote:
> > On 15-feb-2024 14:13:31, Junio C Hamano wrote:
> > > Rubén Justo <rjusto@gmail.com> writes:
> > > > On 15-feb-2024 19:42:32, Dragan Simic wrote:
> > > > Let me chime in just to say that maybe another terms could be
> > > > considered
> > > > here;  like: "<branchname>" and "<newbranchname>" (maybe too
> > > > long...) or
> > > > so.
> > > > 
> > > > I have no problem with the current terms, but "<branchname>" can be a
> > > > sensible choice here as it is already being used for other commands
> > > > where, and this may help overall, the consideration: "if ommited, the
> > > > current branch is considered" also applies.
> > > 
> > > Actually, we should go in the opposite direction.  When the use of
> > > names are localized in a narrower context, they can be shortened
> > > without losing clarity.
> > 
> > I did not mean to have longer terms, sorry for that.
> > 
> > I was thinking more in the synopsis:
> > 
> >     'git branch' (--set-upstream-to=<upstream> | -u <upstream>)
> > [<branchname>]
> >     'git branch' --unset-upstream [<branchname>]
> >     'git branch' (-m | -M) [<branchname>] <new>
> >     'git branch' (-c | -C) [<branchname>] <new>
> >     'git branch' (-d | -D) [-r] <branchname>...
> >     'git branch' --edit-description [<branchname>]
> > 
> > To have more uniformity in the terms, which can be beneficial to the
> > user.
> 
> Here's what I think the example from above should eventually look like:
> 
>      'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<name>]
>      'git branch' --unset-upstream [<name>]

Well, my point was not about new terms in this series, but to see if the
idea of reusing an existing one might be of interest.

I find it interesting to have common terms like "<commit>" "<path>",
"<envvar>"...

This builds intuition in the user, making it easier to grasp the meaning
of a term, which refers to a similar /thing/, regardless of being used
in different contexts.  And in turn, it can also help to better
understand the context.

     Side note:  My gut tells me that my patch 5aea3955bc (branch:
     clarify <oldbranch> term, 2024-01-06) which was originated by a
     report [1] of a user who found the documentation confusing, would
     have been less likely to happen (the report and consequently my
     patch) if "<branchname>" had been used instead of "<oldbranch>" in
     the documentation.  Not because "<branchname>" is a better name,
     but because it is already being used in other commands with a
     clearer meaning of: "if not specified it defaults to the current
     branch".  And because of that a user might have be able to fill the
     gaps in -m|-c.  Of course this is based on my intuition, which I
     know is seriously biased.

     [1] https://lore.kernel.org/git/pull.1613.git.git.1701303891791.gitgitgadget@gmail.com/

And not only can it be of help to the user, but also to developers (or
reviewers) when documenting new commands or options;  because there is
no need to search for a, maybe new, name if there is one that is
consolidated.

Perhaps, less names can also improve the lives of translators by making
it easier to reuse some of the translations.

As I write, I realise that all this probably belongs to CodingGuideLines
or similar.  Or maybe it is too academic to be practical.  I Dunno.

>      'git branch' (-m | -M) [<old>] <new>
>      'git branch' (-c | -C) [<old>] <new>
>      'git branch' (-d | -D) [-r] <name>...
>      'git branch' --edit-description [<name>]

So, to your proposal:  it does not make things worse, and it reuses
terms that are already used elsewhere:

	$ for a in '<new>' '<old>' '<name>'; do echo $a $(git grep --no-line-number -E "$a" v2.44.0-rc1 -- Documentation/git-*.txt | wc -l); done
	<new> 7
	<old> 7
	<name> 147

But based on the idea I've just described, IMHO the user might not
easily find the similarities in <old> with <name>:

>      'git branch' (-c | -C) [<old>] <new>
>      'git branch' (-d | -D) [-r] <name>...

At least, not better than with <oldbranch> and <branchname>.

And it won't be easy either with <name> and other man pages.  For
example we have:

	$ git grep -E 'git checkout.*(new-)?branch' Documentation/git-checkout.txt
	Documentation/git-checkout.txt:'git checkout' [-q] [-f] [-m] [<branch>]
	Documentation/git-checkout.txt:'git checkout' [-q] [-f] [-m] --detach [<branch>]
	Documentation/git-checkout.txt:'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new-branch>] [<start-point>]
	Documentation/git-checkout.txt:'git checkout' [<branch>]::
	Documentation/git-checkout.txt:$ git checkout -b <branch> --track <remote>/<branch>
	Documentation/git-checkout.txt:'git checkout' -b|-B <new-branch> [<start-point>]::
	Documentation/git-checkout.txt:$ git checkout <branch>
	Documentation/git-checkout.txt:'git checkout' --detach [<branch>]::
	Documentation/git-checkout.txt:     "git branch" with "-f" followed by "git checkout" of that branch;
	Documentation/git-checkout.txt:$ git checkout -b <branch> --track <remote>/<branch>

On the names chosen, the risk of bikesheeding is high and there is
nothing wrong here, so it is way better to let you work.  You have taken
the initiative from Junios's response to my patch, so thank you for
that.

> Though, it's something to be left for future patches, which will move
> more argument descriptions to the respective command descriptions.
> 
> > We don't say that "--edit-description" defaults to the current branch;
> > It is assumed.  Perhaps we can take advantage of that assumption in
> > -m|-c too.
> 
> We don't say that yet, :)

Yeah, but maybe we can do it without writing it down :)

> because the description of the command for
> editing branch descriptions is detached from the description of its
> arguments.  The plan is to move all of them together.
> 
> > Of course, there is no need (perhaps counterproductive) to say "branch"
> > if the context makes it clear it is referring to a branch.

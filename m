Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4A536B
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 05:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711517618; cv=none; b=fw2tEzdtT8ii5VXGiK0xBLPFPBGSOpideZWTdl3np5I7apMxlMFI4pqPAyK9GVtXWMkRg1LueXTEPiYyVT1YJ2vnODQYZsW14pgjGBOH9TJFGkrPuCkrSBUjb07poIJhVnUkVmBjanHeGjz58t5PbqBy5Psx3z02iEGSvjUeq+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711517618; c=relaxed/simple;
	bh=3Ww6+9H5nhxS4TTe4GrUsR/f0b52lKGcW/e4+mq6/mA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X1PNf8IzOvtoD1KClqYM5R7IZmFg5i0qrzItjFsrWp06FFDx6MNN5A7dsD9cYHp4RMivRwncKf74mQzXTqT5m6Wslq4vAI493iqh2L8ih2QlXS5YVd5XhuM+lrzeksDypbu2XQ+3BFR7TLLn+DKzJoaCLVMI8Hq0Nwxr+7Qv5LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hOsKrtVv; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hOsKrtVv"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcd1779adbeso10394135276.3
        for <git@vger.kernel.org>; Tue, 26 Mar 2024 22:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711517616; x=1712122416; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tzY18+nXcoJRmFeDtOP/IPPzwSRW8l46XjvSPEkV9po=;
        b=hOsKrtVv4wdz4ZyawfnErzSsyeNGfAPkUAa4WnViRaqWCPcgJFtHAoaF7fzj73cj0d
         RE1X7shPCkmasRfGNNnbrQSyIHPEfesXuo0Xt6P34Jh5DF40CXoSDc1qOVFGn5ChuWST
         gbbTBG83/83X4IKbSkoR80p2CPbFz2F/gfIaod+x7Aezyt/m5/iNeVHxGAkjp+fGzNy4
         zu7d6TSvWORzXLpIp6VBgcmpUEt0HWrVMFESMAI6K/J53qLq35PrivuPkEvIUKNitTrT
         /hc6FIpARYpkG5Bq/61pzC05MvjTfGAXrIGQfin6B7Vdm9bjLg5iJ1V75Q+87Wkx51py
         YfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711517616; x=1712122416;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tzY18+nXcoJRmFeDtOP/IPPzwSRW8l46XjvSPEkV9po=;
        b=mSGBPU34IJsqq09zmUHar8mbP5L857duwG7kFwqQMMxf+JdKdMSWqwzwaXPRn9v0Ig
         vgEp8AVnQQakv9gG0tNJmDQ3yPLLD5moKw9WZy6iDVJQMBajCKGL6N9Kt167gwuRkQoL
         gIy3o1X7BteXo68JB6gh17nf8N+sPwsJV5ru/qpnds6ssD4blyF/SLpgxSPbfLZil66l
         IIEdCrA4lja8WBTsgQQLjgpyy7x0Yf5/kNi3MGud6ACFWlJqhOGV46efxXMxbY7zOF+f
         gZwwC6KW4gV0Fa9pyxvpaPyLo2S76yrulpytb4ZxNpzniZycXBa3jekRQip584G+2qDd
         frAA==
X-Gm-Message-State: AOJu0Yz3n4ZAJo3fzmukb6aDmlAMlauM7dZg7rf3cJ6W9G9ab5m4NmJW
	JklIHI5dRPYBPCAA7HmH99c4EvqST5Jfq6aHxtK5HkkJ6KvYoZPGLL+lOyxo/y1P0puTKJ7o04B
	5oQ==
X-Google-Smtp-Source: AGHT+IGWP12w2//JR3r98f8j8+tiI85KRbX9edWk8Ry6ZuUAfMVhZn+s2J/rRtM6sOzMJ/OODnTLUprzyZc=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:1b91:b0:dcb:b9d7:2760 with SMTP id
 ei17-20020a0569021b9100b00dcbb9d72760mr3683545ybb.13.1711517615899; Tue, 26
 Mar 2024 22:33:35 -0700 (PDT)
Date: Tue, 26 Mar 2024 22:33:34 -0700
In-Reply-To: <xmqq8r27nhwo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1694.git.git.1711164460562.gitgitgadget@gmail.com>
 <xmqqsf0gvjrg.fsf@gitster.g> <xmqq8r27nhwo.fsf@gitster.g>
Message-ID: <owly34sc1bo1.fsf@fine.c.googlers.com>
Subject: Re: [PATCH] RFC: add MAINTAINERS file
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>, 
	Jeff King <peff@peff.net>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Oops, I should have just responded to this email once as you quoted
your original reply. Sorry for the inconvenience.

BTW thanks for spurring on the discussion. I've also CC'ed additional
folks directly to try to get more feedback for this topic.


Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
> [...]
>
> So here are some more from the top of my head.
>
>  - Corollary to "nominating successors from the group at your
>    company may not work well", it may be hard to self-nominate
>    yourself as an area expert if you are not confident that others
>    consider you to be one.

There probably needs to be some sort of voting mechanism to affirm
membership into the "maintainers" group.

>  - How authoritative should these "maintainers" be?  Do they have
>    the final say to even override a concensus in a discussion if
>    needed, when clueless discussion participants are drawing a
>    conclusion that would hurt the codebase in the longer term?

I want to say "it depends", but for sake of simplicity, I think "yes" is
a better answer than "no". If the existing area expert is not happy with
the direction of a patch series... tough luck, try again. If we end up
overruling the opinions of established experts very often then the title
of "maintainer" loses teeth and I don't like that consequence.

IIUC in the Linux Kernel people pull large chunks of changes from each
other until it all converges into the one owned by Torvalds. That model
works because of the "network of trust" amongst the various maintainers,
each maintainer being an area expert.

I'm digressing a little bit here, but perhaps the "area expert" model
will only work if we move to a more Kernel-like model with multiple
separate "collection points" of patches (where there are multiple
maintainers). But I don't think Git is large enough where that model
makes sense. I'm not sure.

>  - For whom do we partition the areas?  "For revision walking using
>    connectivity bitmaps, experts are ..." sounds (at least to me)
>    like a plausible and reasonable way to define an expertise area,
>    but the description of the area may be understood only by those
>    who are reasonably familiar with the way how "git log" internally
>    works, for example.  Is it OK to assume that the reader has some
>    basic understanding of how the system works in order to use the
>    maintainer list effectively?

I think that assumption is fine. We have to start somewhere.

BTW I expect such a "maintainers" doc to evolve a bit as we hit bumps on
the road along the way.

>  - The above worry may be reduced if we partition the area primarily
>    along the file boundaries.  If a set of functions that are not
>    logically related to feature X but has to be in the same
>    compilation unit for some reason live in the file whose primary
>    purpose is to house implementation of the feature X, it may give
>    us an interesting project to figure out how to separate them out
>    and give them "correct" place, and the end result, even though it
>    is a side effect, would be a more modular and readable code.

Yup, file boundaries may be the simplest one.

Another partitioning dimension might be individual internal libraries
(header files to start, although some things like git-compat-util.h
might need more than one expert due to its complexity).

>  - If we adopt the file format from the kernel project, can we
>    leverage their tooling as well to query the maintainers file?  I
>    thought they have a tool that reads your patch into and figures
>    out what area is being touched to spit out a good set of Cc
>    candidates?

Yes. I found guidance [1] which suggests using scripts/get_maintainer.pl
[2] to find the CC list. And this script appears [3] to use the
MAINTAINERS file format to do its work.

I'm not a big fan of Perl but I suppose as long as we keep the same
format we can always just reuse that script (assuming it doesn't have
Kernel-only things hardcoded into it that make it unusable outside the
Kernel).

>  - Can contrib/contacts/git-contacts be taught about this new source
>    of information, and if so how?

Wow, I had no idea this existed.

One (stupid) idea would be to do a set union operation with the output
of git-contacts with the output of scripts/get_maintainer.pl.

>  - Once we start breaking down the system into expertise areas, are
>    there areas without any existng experts already?  If you send
>    patches to the list right now in the following areas, I do not
>    think you'll find capable reviewers whose acks weigh well enough
>    [*]: gitk, git-gui, contrib/completion, git-p4, gitweb, git-svn.
>
>     * Please raise a hand and say "No, you know I am very familiar
>       with that area; you just simply forgot about me because we
>       have not seen any patches in the area recently".

I think the lack of experts in certain areas is fine. It may even be
thee case that there are only a few experts (in a few areas) around to
start with.

>  - When there are no active area experts, what would the default
>    action be?  We would risk degrading the quality of such
>    "neglected" part of the system if we adopt "anything gets
>    accepted blindly" approach, so I would really want to avoid it.

Perhaps we could have a team of "code reviewers" who can be available to
review patches at some basic level, not at the level of experts? Over
time such reviewers could graduate to become an area expert they like to
work on. The idea is to make sure that there's always a steady pipeline
of would-be-experts who are ready to join the "maintainers" ranks, when
the existing maintainers inevitably become inactive or move on from the
project.

Anyway, to answer your immediate question, I think the default action
would still be to wait for code reviews from known people (who are not
new to the community).

>  - When an area with incumbent experts sees interest from some
>    developers, it is the best for these new people to demonstrate
>    their own competence and earn community's trust to eventually
>    become the area experts themselves, but that may not be so easy
>    in practice due to chicken-and-egg problem.

Yeah I agree. I guess I anticipated this problem with my response just
above WRT having a pipeline of would-be-experts. To restate, I think
it's important to have a healthy number of people across all levels of
expertise (beginner, intermediate, advanced) in the community. Maybe we
have that already? If so, the trick would be to incentivize the
beginners and intermediate level folks to stick around long enough to
become experts.

The GSoC [4] program is one way, although I don't know how successful it
has been (and I don't think it's very scalable).


[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#select-the-recipients-for-your-patch
[2] https://github.com/torvalds/linux/blob/master/scripts/get_maintainer.pl
[3] https://github.com/torvalds/linux/blob/7033999ecd7b8cf9ea59265035a0150961e023ee/scripts/get_maintainer.pl#L345
[4] https://summerofcode.withgoogle.com/

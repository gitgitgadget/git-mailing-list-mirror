Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803C6CD13DD
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 16:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjIRQ0b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 12:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjIRQ0R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 12:26:17 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD064C18
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 09:20:13 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50306b2920dso2288789e87.0
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 09:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695054011; x=1695658811; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t5yhc1qYJRK9dERZSGuj6vf6MZAeqbHXMQXRJm+nKdw=;
        b=dfnRbA4lKYFk3HJLbuqogoeYKmnX0t3ynhhariZnkRzySwxabi7LvATumbImmAcqun
         gIBI1sQAnnwsN4c6C1k1TK+wPUBEaIg2KaOws2fbtGf+0rV/8FRgEWyd3cD7BjdM8/fV
         WCvP1hseLJvoIm+uEZHLzq3UlCcyhfoUwNsNC12PI7MVSq85Y7THCkSQHvtJ8eiT3P79
         khkY5PPBfJbHRWnb9Ao8OPQt6EyPPyCuG6CAzKz6BQ302mIRjJZ0JTrmOie/8KrUVpRY
         fLywKa5Sj9FvNpPUNOD7FYikVX1HLkY0H1dsEHgh3Pf40wLEybcmnLYcdjKlOUpqrFWp
         8pNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695054011; x=1695658811;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5yhc1qYJRK9dERZSGuj6vf6MZAeqbHXMQXRJm+nKdw=;
        b=YAroKjyUb9D67s6iw0aEcuSt064lcS/KfrtalnghtptQwpHsKUAVvPEHbDVNkaHyuP
         /9u/lqTtSpG+YZ3qzOoD1oqmfI/lbZyyNaQFuscdVX1lueLy57J2abCrWwB+Tq/4VROB
         nQbSz9kHk4SVZjdkZoJ4Iqp0dNQebZKkjXPwDVOKKXjYhJFuLc0zR0BtFHFI4btPuW3Q
         /2HMZ+vBDEGs795b0wJuC2gmOqLyayjGvByie4h6/6mdoLHsLmo1nO+3HlWnLfpo/6t5
         0DEel614viFWhZ9za1AckR4HI7q1embgwy3JMWU05A3J9U0x6tM9f5psDFFhOBR/7Qgs
         5hTQ==
X-Gm-Message-State: AOJu0YxRIJpssLI7t9f0EUG3zEEYk1RAGAxJBoCQuheLFHRWO3Ya0xmb
        MAi0MCK8pMYO2Vm2YzCZDnJXevz1Vaw=
X-Google-Smtp-Source: AGHT+IEAABcuyuHUJKUPgpoL8cHPuaTVoOq+1oJjiWNL6/AEioFCaAYvhkceFTptJkVACwsmCU40Vw==
X-Received: by 2002:a05:6512:10d0:b0:500:c00e:8f15 with SMTP id k16-20020a05651210d000b00500c00e8f15mr45825lfg.16.1695054010574;
        Mon, 18 Sep 2023 09:20:10 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id g10-20020a19ac0a000000b005032907710asm44696lfc.237.2023.09.18.09.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 09:20:09 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] diff-merges: improve --diff-merges documentation
References: <20230909125446.142715-1-sorganov@gmail.com>
        <20230909125446.142715-2-sorganov@gmail.com>
        <xmqqfs3ktnvo.fsf@gitster.g> <87ttrzhmfu.fsf@osv.gnss.ru>
        <xmqqcyymly5m.fsf@gitster.g>
Date:   Mon, 18 Sep 2023 19:20:08 +0300
In-Reply-To: <xmqqcyymly5m.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        12 Sep 2023 17:22:45 -0700")
Message-ID: <87v8c7mp1j.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>>> It is more like that `-p` does not imply `-m` (which used to mean
>>> "consider showing the comparison between parent(s) and the child,
>>> even for merge commits"), even though newer options like `-c`,
>>> `--cc` and others do imply `-m` (simply because they do not make
>>> much sense if they are not allowed to work on merges) that may make
>>> new people confused.
>>
>> No, neither --cc nor -c imply -m.
>
> I was only trying to help you polish the text you added to explain
> what you called the "legacy feature" to reflect the reason behind
> that legacy.  As you obviously were not there back then when I made
> "--cc" imply "-m" while keeping "-p" not to imply "-m".

Your help is appreciated, yet unfortunately I still can't figure how to
improve the text based on your advice.

Your "I made --cc imply -m" does not explain why later, when you made
--cc imply -p (did you, or was it somebody else?), you didn't make -m
imply -p at the same time, and then "while keeping -p not to imply -m"
sounds out of place as we rather try to figure why "-m not implies -p".

The "--c imply -m" part of the help raises yet another question: if --cc
implied -m, why it was not -m that was made to imply -p instead of --cc
(and -c)? Then both --cc and -c would imply -p automatically as a
side-effect of implication of -p by -m (do not confuse with agreed
non-implication of -m by -p), and then all the relevant options were
consistent. This consideration renders current situation more surprising
instead of clarifying it, I'm afraid.

"-p does not imply -m" fact is fine with me and is not the cause of user
confusion I'm trying to address. How does it help us to explain why "-m
does not imply -p" though?

[...]

>
> Given that I, together with Linus, invented "--cc" and "-c", taking
> inspiration from how Paul Mackerras showed a merge in his 'gitk'
> tool, and made the design decision not to require "-m" to get the
> output in the format they specify when the "git log" traversal shows
> merge commits, I do not know what to say when you repeat that "--cc"
> does not imply "-m".  It simply is not true.

I keep saying "--cc does not imply -m" because it does not seem to,
unless you either use some vague meaning of "imply", or mean some other
"-m", not the one used in "git log". Please check:

$ cd src/git
$ git --version
git version 2.42.0.111.gd814540bb75b
$ git describe
v2.42.0-111-gd814540bb75b
$ git log 74a2e88700efc -n1 -p --cc > diff.actual
$ git log 74a2e88700efc -n1 -p --cc -m > diff.expected
$ cmp diff.expected diff.actual
diff.expected diff.actual differ: byte 706, line 18
$

This test tells us that "--c" is not the same as "--cc -m", that for me
in turn reads "--cc does not imply -m", and that's what I continue to
say.

>
> I think this is the second time you claimed the above after I
> explained the same to you, if I am not mistaken.  If you do not want
> to be corrected, that is fine, and I'll stop wasting my time trying
> to correct you.

I'd love to be corrected, but I think I carefully checked my grounds
before saying that --cc does not imply -m, please consider:

1. "--cc implies -m" is not documented. Please point to the
   documentation in case I missed it.

2. Git does not behave as if "--cc implied -m", see the test-case above.

If it's neither documented nor matches actual behavior, it's not there,
at least from the POV of random user, to whom my original clarification
of "why -m does not imply -p?" has been addressed.

On top of that, I even can't figure why we argue about it in the first
place, as it seems to be irrelevant to the issue at hand: explain why -m
does not imply -p?

>
> But I still have to make sure that you (or anybody else) do not
> spread misinformation to other users by writing incorrect statements
> in documentation patches.

I'm all against spreading misinformation, and try my best to avoid it
myself. I still fail to see what misinformation, exactly, you find in
this particular explanation by me:

" Note: This option [`-m`] not implying `-p` is legacy feature that is
  preserved for the sake of backward compatibility. "

That's exactly what I figured out from a lot of discussions over my
multiple attempts to make `-m` behave more usefully. Is it that "legacy
feature" somehow sounds offensive, or what?

As, despite your help, I fail to come up with better edition of the
note, please, if you feel like it, suggest your own variant of
explanation to the user why `-m` is left inconsistent with the rest of
diff for merges options, provided current matching documentation reads
roughly like this (from more recent options to oldest):

   --remrege-diff: produces "remerge" output. Implies -p.
   --cc: produces dense combined output. Implies -p.
   -c: produces combined output. Implies -p.
   -m: produces separate output, provided -p is given as well (?!).

and so why

  git log -m

surprisingly has no visible effect, and then the user needs to
type:

   git log -m -p


That's all I wanted to explain to the user in a few words with the note
you argue against.

Thanks,
-- Sergey Organov

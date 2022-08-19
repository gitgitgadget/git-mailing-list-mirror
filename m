Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468D8C3F6B0
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 11:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348577AbiHSLFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 07:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346949AbiHSLEp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 07:04:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170AEB7760
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 04:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660907079;
        bh=Nemez+zQXVBFPpO1vkaq3CdL50JzeBqBuqRTrc/C5l8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZCEECU/0mxLOmlqBqsxnYODUnyUhLpcsT+VGOKCWP49TLN5oWZk870oOcp4s6MpgA
         BOCjCPT+kFRfk9ve60Pk2UTh3aSQoA1bXwpU/bQu1KOlViIU70XRQCczF83E4sVrso
         q9v2P9hubT1HLWGmgzCqm4qw10SFWfg+fAQ/YN+E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.212.11]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVvPJ-1nx7GF3vhl-00RnYV; Fri, 19
 Aug 2022 13:04:39 +0200
Date:   Fri, 19 Aug 2022 13:04:45 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: js/bisect-in-c, was Re: What's cooking in git.git (Aug 2022,
 #05; Mon, 15)
In-Reply-To: <xmqq35duvdow.fsf@gitster.g>
Message-ID: <snn8r5pn-rr6n-376r-s663-92s81pos077p@tzk.qr>
References: <xmqq5yityzcu.fsf@gitster.g> <p053rrpq-17q7-pnrs-3794-o04ro1445s5s@tzk.qr> <CABPp-BFAERLt_z-D=7gbXWVA9JgsqTP_2iW9BLe5S=YbsQ1V6w@mail.gmail.com> <xmqqtu6avgub.fsf@gitster.g> <CABPp-BHBOqnU7DSLkYPig=c6+emWGaE1vdzaPk0D90yQdof+6A@mail.gmail.com>
 <xmqq35duvdow.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:231wN9ouUawdFgZu11c1piPUJ1CUPdODmmM4/22dyHsklXphNBF
 LV7qPtOndvl6CIrHmjOSfm5AfhWp5F1zEH4xC0U289DsKVATIOOJ/dW/juSX2DEtOfF6HjQ
 qIM8l0SSjSWgBDwTGBETOuux4hOuce+uF9slGkKThzwnu2MFAt7Q3h8ID0xMMxG3d3IJ4cQ
 1NovtQDo7jty7zkRQyvDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7d2cPJoy81s=:vtOu5VHmIP1d33D5m8FTQm
 mri193qhVRIVHuMdh/VEy6s8TUvcEvMr/2Zj6AQeVJ8g8MA9xyitPLysE3C9kUwLT/2B6x0Er
 al6Nr963uxYeqCPacpZruymHn1ClA1gAtAiRf4NPJxRABORwzLGqps02Z87HWhPRSEWSloQlC
 /qX9I1E2ICs8zxCs9vdsP28St6v0jZjGJ5U/h7MfwnsHZJF/V31TGicD+IPbF9OUCO4nZwWFx
 /YuMrMwpmrFkJERt7LKCen3XGZHcfGyvVo/smY4h5mFVhHUjrC2LYeWPAVTDT+UzEBoO8JQiv
 nTlvS9AtWAQ0kWWp+SeqXtOqEmCiFHuPhuhyiJQ93NZ7dx+kEE02NdRhoQDTytE6QLrdOW9gy
 PT0vYMUdYOcWX8kw7r9oegOyZSsEIF2gsDQbQUnTxnzELevJ7Lax9k43CCKJIzQCZmLTvrZxZ
 d9PlwYqH2tOewQs2Kokr+XJAZAql+uYD/nsDvZoZlGBDH485QxNkqulfKN1GmqE796gcYWHpW
 jKWlB4tQ0XxVNntwgskZ89p+YWH2q40MEmIOGpPgrs5bZXH+ziEIlMiqNKr76EMv+MdxwRsp9
 /c0UHq3KjDnEbZQEHcVJ47/WcCZ6dm80cp0Jc+P4aCdyrkpo0JxV1LBnB6u+YFKMVxnWfNEJa
 F9zwS2eaeIRAGRYPRGSwVjhAVo7df0OwlnnV7+JYNUxKdONNaqxgMZXeSJBKkduwTCJ5w7tyK
 Dze1BG9Q2fHwEn3HsrKsXGzJ0Vbm815dAIptRYMTyAFLOsgsgg84gyTW8pJaHgkx1uTBHFv+M
 93tT32wV3Ygh03daBF9ojtMzl6mbqH0U59nNuGaN78ckq55Z9zvlNlw7sdZXdE1wMPwveZLvE
 VUU8emA6lCX18zbtIOeT2izvVlHX3rgqz6Ifcy+NpV0LOB54vKZFHbCRmOLgcgGWXrnQOyELm
 a8DwAtID60neDtqc5Fys3QeUGDUWpg1hR3x+HSClw4EEYFDRKPVhXkjDEKzy6CHfXQd3QadlL
 Aq5TwSxGpnLwfTF6cASgvhaX9Scsd8C5/35m0FB8jWrYk49jQQeCjMfPd28qO6Oj+2i5r3ata
 6Z2Ed/b/r6afTloO1ZsQsT4JjCZzjUvM04i9/abCV/Iq7Xof1t1UvQBhA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 17 Aug 2022, Junio C Hamano wrote:

> Elijah Newren <newren@gmail.com> writes:
>
> > Ah, gotcha.  My impression was that the exit codes did match what the
> > previous shell code had done, but didn't match what other builtins
> > usually return.  Perhaps I misread those discussion comments.
>
> Or perhaps I did ;-)

The exit codes before and after this patch series are a red herring. The
_current_ code prints this when calling `git bisect start -h`:

	$ git bisect start -h
	usage: git bisect--helper --bisect-reset [<commit>]
	   or: git bisect--helper --bisect-terms [--term-good | --term-old | --te=
rm-bad | --term-new]
	   or: git bisect--helper --bisect-start [--term-{new,bad}=3D<term> --ter=
m-{old,good}=3D<term>] [--no-checkout] [--first-parent] [<bad> [<good>...]=
] [--] [<paths>...]
	   or: git bisect--helper --bisect-next
	   or: git bisect--helper --bisect-state (bad|new) [<rev>]
	   or: git bisect--helper --bisect-state (good|old) [<rev>...]
	   or: git bisect--helper --bisect-replay <filename>
	   or: git bisect--helper --bisect-skip [(<rev>|<range>)...]
	   or: git bisect--helper --bisect-visualize
	   or: git bisect--helper --bisect-run <cmd>...

	    --bisect-reset        reset the bisection state
	    --bisect-next-check   check whether bad or good terms exist
	    --bisect-terms        print out the bisect terms
	    --bisect-start        start the bisect session
	    --bisect-next         find the next bisection commit
	    --bisect-state        mark the state of ref (or refs)
	    --bisect-log          list the bisection steps so far
	    --bisect-replay       replay the bisection process from the given fil=
e
	    --bisect-skip         skip some commits for checkout
	    --bisect-visualize    visualize the bisection
	    --bisect-run          use <cmd>... to automatically bisect
	    --no-log              no log for BISECT_WRITE

Notice how this talks about `bisect--helper` and about `--bisect-reset`.

Also, the _current_ code exits with code 0 when calling `git bisect -h`.

This has been the case even as far back as v2.25.1, and possibly even
longer.

Given these issues, I was mistakenly assuming that it would be okay to
postpone these problems that are exclusively related to incorrect
invocation of `git bisect`, and that it would make sense to focus on the
conversion from shell code to C in _this_ patch series, and take care of
these problems afterwards, instead of hodgepodging fixes for them into the
same patch series as the conversion to C, the latter being hard enough to
review as it stands, so much so that it received only a single high
quality review.

But I see that you somehow got the idea that the review that lacked
attention to the common code path somehow was a valid review and you
somehow got it in your mind that this was valid feedback and that the
patch series needs to be reworked so that it _also_ addresses issues that
have been broken _before_ it.

Fine.

I'll try to get to it next week. It does leave a foul taste that we're not
separating concerns properly in the Git project, but block a patch series
that has a specific, already large scope, just because one reviewer wants
it to have another scope and for some reason that now must be the scope of
the patch series.

Ciao,
Dscho

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D915C433DB
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 01:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 632EA221FA
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 01:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgLXBgr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 20:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgLXBgr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 20:36:47 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017B8C061794
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 17:36:06 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id b24so745885otj.0
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 17:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=45rTaiMC6hpeabBjF+Vzi0SumsIH8u3QwYYyPHbNQBM=;
        b=VA8gOh0h9sDcWANGu5jxOfdOD0gkTk7KoEzXMDZBZraJOHlsRmPldGXFkOon7T7uY1
         85ISJmTnxpp/yCz+SzvCD9RDfa9gDPtto9+kOBAuoRydubr55Dha+5u42GeaG4SmO/3q
         +9LWX9rVfXh0ht1Tcq/w4NNfhQDDOaQTKxshk9LCyShbtupNmgDGhozCiB/5PWTxOa0Q
         /awi/fgnMHyjhqExB+9KerCL9cryC7ZhhXT57C4hjyte6QVOXN/d1878lrAX9j5MMN3W
         6OyXIwN0UuIuDr+8GrrSR07zBYZZOugFOhbm1UoDkZzRqbW4tTDr1Meb0wWXsb8VyCFe
         DEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=45rTaiMC6hpeabBjF+Vzi0SumsIH8u3QwYYyPHbNQBM=;
        b=TJfE06XOUT0ztlfxeBYUC9azLGFZ1gVju4n7wMlWjyJXcjnGGHr+M8jQsFVSC2sxWw
         Ez1xcAYO4KmOEtzdhXqC+0Wa7mX5CLfFIA+wckYaALOFROd1Ljz0qJ/K0WWXEdEELBEN
         6Zi3g7cq9kSd8TiR7smII1bxFzhY4/w6XEL3230Y/etlHlIlAZruwsE5HoUcLUAsKxF1
         VyWvcqeruLXTfpt93LFWLv+zhMP8C8dhaQ5XLJeHA8T6jFGQ6sNAz0PAuw2nLsGDLUsa
         /Zp2RaI/G1gDlvMlUACbyPs2vJaCjeCZAnqH4/t5WjoHXUY3rD7HP0GFnPpg2zZXCX/3
         rMsQ==
X-Gm-Message-State: AOAM531cAvRPvJFkmasCrGtlrKrgqrllDZn4PTDml71ucFmty+OqtEnx
        LBbEstt/rwne4im0CcdksqQ=
X-Google-Smtp-Source: ABdhPJxZHqLnBHAeX/lpGvCI1XBPN+P/xF3ZiyafvAXcGGHeyMtuydyRdcF8vmxyIVJUvxBnWtkXIA==
X-Received: by 2002:a05:6830:1f54:: with SMTP id u20mr3515406oth.104.1608773766279;
        Wed, 23 Dec 2020 17:36:06 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 31sm6319505otd.24.2020.12.23.17.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 17:36:05 -0800 (PST)
Date:   Wed, 23 Dec 2020 19:36:03 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Seth House <seth@eseth.com>
Message-ID: <5fe3f083f27cd_7855a20885@natae.notmuch>
In-Reply-To: <xmqqv9cs3uxo.fsf@gitster.c.googlers.com>
References: <20201223045358.100754-1-felipe.contreras@gmail.com>
 <20201223045358.100754-2-felipe.contreras@gmail.com>
 <xmqqblekabof.fsf@gitster.c.googlers.com>
 <5fe352e3968f6_198be2083@natae.notmuch>
 <xmqqblek8e94.fsf@gitster.c.googlers.com>
 <5fe3dd62e12f8_7855a2081f@natae.notmuch>
 <xmqqv9cs3uxo.fsf@gitster.c.googlers.com>
Subject: Re: [PATCH v5 1/1] mergetool: add automerge configuration
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> >> Ah, I forgot about that one.  I think "the number of conflicts" was
> >> a UI mistake (the original that it mimics is "merge" from RCS suite,
> >> which uses 1 and 2 for "conflicts" and "trouble") but we know we
> >> will get conflicts, so it is wrong to expect success from the
> >> command.  Deliberately ignoring the return status is the right thing
> >> to do.
> >
> > I agree. My bet is that nobody is checking the return status of "git
> > merge-file" to find out the number of conflicts. Plus, how can you check
> > the difference between 255 conflicts and error -1?
> 
> Yup, I already mentioned UI mistake so you do not have to repeat

You said it was a UI mistake, not me. I am a different mind than yours.

This [1] is the first time *you* communicated it was a UI mistake.

This [2] is the first time *I* communicated it was a UI mistake.

I communicated that fact after you, so I did not repeat anything,
because I hadn't said that before. *You* did, not *me*.

> it to consume more bandwidth.

This is what is consuming bandwidth.

Not me stating *for the first time* that I agree what you just stated.

You could have skipped what I said *for the first time*, if you didn't
find it particularly interesting, and that would have saved bandwidth.

> > We could do something like --marker-size=13 to minimize the chances of
> > that happening.
> >
> > In that case I would prefer '/^<\{13\} /' (to avoid too many
> > characters). I see those regexes used elsewhere in git, but I don't know
> > how portable that is.
> 
> If it is used elsewhere with "sed", then that would be OK, but if it
> is not with "sed" but with "grep", that's quite a different story.

In t/t3427-rebase-subtree.sh there is:

  sed -e "s%\([0-9a-f]\{40\} \)files_subtree/%\1%"

Not sure if that counts. There's other places in the tests.

However, I don't see the point if the marker-size is a low enough number, like 7.

> > So, do we want those three things?
> >
> >  1. A non-standard marker-size
> >  2. Check beforehand the existence of those markers and disable
> >     automerge
> >  3. Check afterwards the existence of those markers and disable
> >     automerge
> 
> I do not think 3 is needed if we do 2 and I do not think 1 would
> particularly be useful *UNLESS* the code consults with the attribute
> system to see what marker size the path uses to avoid crashing with
> the non-standard marker-size the path already uses.

But what is more likely? a) That the marker-size is 7 (the default), or
b) that the marker-size is not the default, but that there's a
marker-size attribute *and* the value is precisely 13?

I think a) is way more likely than b).

> So the easiest would be not to do anything for now, with a note
> about known limitations in the doc.  The second easiest would be to
> do 2. alone.  We could do 1. to be more complete but I tend to think
> that it is better to leave it as #leftoverbits.

OK. I think 1. is low-hanging fruit, but I'm fine with not doing
anything, or trying 2.

I don't think 2. would be that hard, so I will try that before
re-rolling the series.

(unless somebody replies to my other pending arguments)

Cheers.

[1] https://lore.kernel.org/git/xmqqblek8e94.fsf@gitster.c.googlers.com/
[2] https://lore.kernel.org/git/5fe3dd62e12f8_7855a2081f@natae.notmuch/

-- 
Felipe Contreras

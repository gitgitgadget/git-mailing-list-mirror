Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DE4C433DB
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 07:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3FCD64E16
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 07:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhBHHZF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 02:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhBHHZB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 02:25:01 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BFDC06174A
        for <git@vger.kernel.org>; Sun,  7 Feb 2021 23:24:02 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id r38so9597894pgk.13
        for <git@vger.kernel.org>; Sun, 07 Feb 2021 23:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JHKwD1CP17SpX/Gk3YgdvYd04jS9CCnsOaqhIeD2wOM=;
        b=hjYbnrPwC5gbr1iN0A+6C23FvdFw/tfmSGLoAWRYyaEelfwgE25boPibrFoHjJJRBr
         F2Je4ylQBquV5uxWC7Az0zltZ9d1fW4vx0qbVNSoEEyl3tEMSRBgfnH5R75SxSMb4R1m
         lNs1DZxsuW5KT/LNJ/9rcNDbVlEJoKRH0mA0Wn73uf4Lh7ne97h5T2/Ls3UQp7aWX4hE
         bnDYS1vXbu+lYBUN/RhFnbrrp9UDDSctLNTt5e/kXMcCLqFv2IKColj6mvVNL1DZnz1q
         2+lS8PIwJTiTLpZsYFCNQ8Zn56L1J+ogZeUbpnwuFfwPlBb85ouj9y5X4mxXnNgwqT/P
         GcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JHKwD1CP17SpX/Gk3YgdvYd04jS9CCnsOaqhIeD2wOM=;
        b=eUl+nfH+KpmYHWY1T4D8LNWtEypo4NBUoJuLe+BKST6BOq54CEM8GFy6axVL9LKpTV
         Fa6BGwC3fS8F5nrGCgGV+GBAl5FoI38gEhKGpL9rh/krYGQvPGKJbph33r5ubxeeAa8z
         KiUTm5DoNNH5L4DsdNo7lv/jtaZX0+fryOR/YmT/z8nbEoOrBzfVCT/cpu4a8k7VJhhw
         6AyvUOxUclwah3QHXGW8MNH2I44XB50C+HT1h+V2BhichFkCzdr57E1PxnSt9yICGTC6
         Q1aUEP45o82EbpAoYFqoe+xDxRQTQtsKdIGEtaoE9z+Vmcx0uu1uBBBoi9xOF3qEf+yH
         r31A==
X-Gm-Message-State: AOAM530UU2tqGy5GHQip8ssSFz+yhzil86uuEi+0mQkj3YwJ7rlz03Hj
        sxHfh5NBugFJMeH1j30ohI4=
X-Google-Smtp-Source: ABdhPJxzHoemkYY85NoAnvj49xNRPsoZ0fZhmyLanSOyMLdKtL8+whTfzompTyRumBvZW67H96ARqw==
X-Received: by 2002:a62:78c8:0:b029:1d3:85cc:2133 with SMTP id t191-20020a6278c80000b02901d385cc2133mr16836693pfc.65.1612769041400;
        Sun, 07 Feb 2021 23:24:01 -0800 (PST)
Received: from konoha ([182.64.196.99])
        by smtp.gmail.com with ESMTPSA id x81sm17503555pfc.46.2021.02.07.23.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 23:24:00 -0800 (PST)
Date:   Mon, 8 Feb 2021 12:53:37 +0530
From:   Shourya Shukla <periperidip@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     christian.couder@gmail.com, levraiphilippeblain@gmail.com,
        peff@peff.net, Johannes.Schindelin@gmx.de,
        derrickstolee@github.com, git@vger.kernel.org
Subject: Re: [RFC] [BUDFIX] 'git rm --cached <submodule>' does not stage the
 changed .gitmodules
Message-ID: <20210208072337.GA7955@konoha>
References: <20210207144144.GA42182@konoha>
 <xmqq1rdr8yl2.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1rdr8yl2.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/02 11:30, Junio C Hamano wrote:
> Shourya Shukla <periperidip@gmail.com> writes:
> 
> > So, my question is, do we need to fix this to make sure that the changed
> > '.gitmodules' is staged?
> 
> When "--cached" is given, the user is asking the module to be
> removed ONLY from the index, without removing it from the working
> tree, no?
> 
> So I think ".gitmodules" in the working tree should not be touched
> at all.
> 
> Removing the entry for the module from the ".gitmodules" registered
> in the index, when a submodule registered in the index, might be
> desirable, and what you say here
> 
> > And its entry is not removed from the file. What should be done about
> > this? I would appreciate your opinions.
> 
> may be related to it.
> 
> But I doubt it is a good idea to let "git rm" be the one touching
> ".gitmodules" either in the index or in the working tree for that to
> happen.

We can remove the entry of the SM from the '.gitmodules' at least no?
Since the SM won't be relevant to us. At the end an empty '.gitmodules'
file would stand.

> The reason I am hesitant to teach anything about ".gitmodules" to
> the basic level tools like "add", "rm" is because I consider, while
> the "gitlink" design that allows the tip-commit from a submodule in
> the superproject is a good thing to be done at the structural level
> in the core part of Git, administrative information stored in the
> ".gitmodules" is not part of pure "Git" and alternative designs on
> top of the core part of Git that uses different strategy other than
> what we have are possible and they could even turn out to be better
> than what we currently have.  In other words, I have this suspicion
> that the ".gitmodules" based submodule handling we currently have,
> done using "git submodule" command, should not be the only and final
> form of submodule support Git would offer.
> 
> That leads me to think that anything that touch ".gitmodules" should
> be done with "git submodule" suite of commands, not by the low level
> "add", "rm", etc.  Such a separation of concern would allow a new
> "git submodule2" design that may be radically different from the
> current ".gitmodules" one to be introduced, possibly even replacing,
> or living next to each other, the current "git submodule" together
> with ".gitmodules" file, without affecting the low-level "add", "rm"
> tools at all.
> 
> So from that point of view, if we were to fix the system, it may be
> preferrable to make "git rm [--options] <submodule>" only about the
> submodule in the working tree and/or the index, without touching
> ".gitmodules" at all, and let "git submodule rm [--cached]
> <submodule>" be the interface on top.  The implementation of "git
> submodule rm [--cached]" may use "git rm [--cached]" internally as a
> building block to deal with the index and/or the working tree, but
> the info kept in ".gitmodules" for administrative reasons should be
> dealt within "git submodule" without exposing any such policy to the
> lower level tools like "git rm" and "git add".

Hmmmm.. You are correct here. But, won't we be replicating the
functionality of 'git rm [--options] <submodule>' when we create another
new command say 'git submodule rm [--options] <submodule>'. I might be
being a bit naive here so take this with a grain of salt. For now, we
could make sure that the submodule does not have a trace in the
'.gitmodules' for the very least, no?

> Having said all that, please do not take anything I say about
> submodule design as the final decision.  It is just an opinion by
> one development community member (i.e. me) and there are a lot more
> people who are heavily invested in the current design and interested
> in improving it than I am.

Yeah, I will tag along a couple of others who I think might help. Thank
you for your opinion BTW :)

Thanks,
Shourya Shukla


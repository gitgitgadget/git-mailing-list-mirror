Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8234DC4361B
	for <git@archiver.kernel.org>; Sun, 20 Dec 2020 07:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50EAF2389F
	for <git@archiver.kernel.org>; Sun, 20 Dec 2020 07:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgLTHyc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Dec 2020 02:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbgLTHyc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Dec 2020 02:54:32 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AE4C0613CF
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 23:53:51 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id b24so6147375otj.0
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 23:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=c0MC4AfB+u6SBmeri+EWa46jK0ppSWsfVmIOteKsUD8=;
        b=qTQ5oK9rQL+W2BjTvHAlyVQrpIsF+k6xm+3kPTsyZWnAM3j0C6eVGhqQGUVtyxplUQ
         rsD2OQJCkDECpyzSIj34lQq4GTNPehQqm+5MwERXShUwsCBZX3wpt/WRfbNK5xRV2/UY
         V5F5KKOxBfw7Ol64HyArWV2Qz4AD4TjwZDQo1vgOCUUmcYzJH4tAD9M0MvhtafgUXBhu
         o5I0xAGx+jrEqFdsP7CHVRzPxkPDAq/DcyF+Nl4SLn51mmoxg2kZpL/c17S4XOgD8kDQ
         t7i5p3Jt4rRJ/ot1qhe5TcoYXp0KSehP472nI0tKcu4ox1x1qzkS+d2lGaO9vYCIxBNJ
         ryCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=c0MC4AfB+u6SBmeri+EWa46jK0ppSWsfVmIOteKsUD8=;
        b=ew8MJanLcfsNNRaMmJjKOeAluNwV3N2YNvGsT+rKDMPEVCLlutRjmVE3rDq+AwNU7w
         tcja3JvWivtfzwlXPeaD2SPfmilNFRLpCNcJwkrnCqckqCAM3+YflqyBjMv9CejWb/sh
         i2yPpaN7+W5Aw1YgGMREWCKShr5tt3v18pG9VX2H36c/CNDQsBIB1rgnwOp5fbkRgBL+
         ENevFQlyPlfSCEBAgf3FiR+g4JWOSmzUow7sO0yIAwgEcp65Tw3PufQlgTpEUejpl8FS
         0Kazkb0YEPJvoBP/6P5lP3oLKAN4LoCgiviZEqWJByik9L2Q3DpBVhHKkIYFvrnBPgN/
         JrsA==
X-Gm-Message-State: AOAM531LCe1ynFQv7i3qJkDzKZfwT6Pu2mIyjPAVopWwsOFLtuJ1myEU
        cHVf+6qen8t+2tLraIf+3l4=
X-Google-Smtp-Source: ABdhPJzYjFuO9nc8LCpRVDzHQGsFrg+kp6y+MrPdiQS/5r4CXgDlzi3aRG9Sr/z2VZAGk3p8lviYtg==
X-Received: by 2002:a9d:7301:: with SMTP id e1mr8081690otk.304.1608450831166;
        Sat, 19 Dec 2020 23:53:51 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id y84sm2992534oig.36.2020.12.19.23.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 23:53:50 -0800 (PST)
Date:   Sun, 20 Dec 2020 01:53:49 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     David Aguilar <davvid@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Seth House <seth@eseth.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <5fdf030d2bde5_32bc20825@natae.notmuch>
In-Reply-To: <CAJDDKr6RP+TPFF2mHph7sqa-eG9uoRtqS4d4vUU84V3HJ_CMBA@mail.gmail.com>
References: <xmqqa6ud2xuw.fsf@gitster.c.googlers.com>
 <105041520.23756286.1608159189934.JavaMail.zimbra@eseth.com>
 <5fdaef83a40ba_d0e26208f6@natae.notmuch>
 <e5c73fed-b87e-2091-794e-19aced4dd25b@kdbg.org>
 <20201217094424.GA75257@ellen>
 <5fdb3471c6bb7_d6d032087@natae.notmuch>
 <20201217175037.GA80608@ellen>
 <5fdc0e6dd79a7_f2faf208a1@natae.notmuch>
 <20201218023534.GA117762@ellen>
 <5fdc18a91c402_f2faf20837@natae.notmuch>
 <20201218054947.GA123376@ellen>
 <xmqq3603v3a0.fsf@gitster.c.googlers.com>
 <5fdc998216c89_104e15208da@natae.notmuch>
 <xmqqlfdtoch2.fsf@gitster.c.googlers.com>
 <5fde69944fe4d_1e50c7208f@natae.notmuch>
 <CAJDDKr6RP+TPFF2mHph7sqa-eG9uoRtqS4d4vUU84V3HJ_CMBA@mail.gmail.com>
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar wrote:
> On Sat, Dec 19, 2020 at 12:59 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > They don't have to rely on that failure, they can just turn off
> > mergetool.automerge.
> >
> >
> > But fine. Let's the perfect be the enemy of the good. That seems wise.
> 
> FWIW I'm in favor of having per-tool configuration precisely for
> custom mergetools that do things with custom file formats and benefit
> from having all of LOCAL REMOTE and BASE.

That's a preference, not an argument.

> I don't have to imagine these use cases, they are very real.

Show one.

> This design choice is also in alignment with the general
> mergetool/difftool per-tool configuration paradigm.  If we didn't
> support per-tool, then it would be inconsistent.

Can you do

 1. mergetool.vimdiff3.keepBackup
 2. mergetool.vimdiff3.keepTemporaries
 3. mergetool.vimdiff3.writeToTemp
 4. mergetool.vimdiff3.prompt

?

In fact the opposite is the case; not a *single* `mergetool.foo`
configuration can be done with `mergetool.<tool>.foo`.

-- 
Felipe Contreras

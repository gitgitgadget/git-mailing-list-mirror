Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90DBC433DB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 05:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B4C222CB9
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 05:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgLUFfM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 00:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgLUFfM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 00:35:12 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC802C0613D3
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 21:34:31 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id s75so10235297oih.1
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 21:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=9+1JAlnhQr3kj8wj2996Tuh+s3RW470lvr/QaLba7a8=;
        b=OMbmw2Q3GtFrJczTB+nIZ8HdyczA27+GKDtCdhbESINFrYwAJZNl484pxe6iF2MRvh
         +mhHHeU4a9AhxNolI6oON8W2ZCJZRdOAFGM7bjXLseiOfR/xfbUPuYyWvE9FxFgjYrr8
         OG9dK0tGPszwRNLDByrKasFIV1YntqardEDHu4qQS0qvjVAovmm30cbTNyixd19EYWop
         EglbMtT56lL41vtOoz+0i5r8VGUdedm2cpYUYAfmRuRhUOjHJ9GJnHPncjU9ijrZU2kH
         +SiOY53QoJ+Irnc6HqhZS7nUJMWSdK5vEE2BlfAGh93cPpfWm/n2yXW1pu673ay1pjX+
         dJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=9+1JAlnhQr3kj8wj2996Tuh+s3RW470lvr/QaLba7a8=;
        b=Pj2JOVIP/453YBtf9ryjC3nOOv3vEX+DKD3x3LoiR5O82myoWLBzxl3IVrPoorbNTG
         rdTMvqz1Tho6jiKUTSY/VRnRcRXWbZO10dWXNt8wg7AjMEj5GwG7s3Sz9MjIWkBDxXno
         z6A9j62f/rUoH0L6RH0+Di8wwKCqZlb9hoInD1KCQV8phY89S4yGyOXuGSz4eyR92xbt
         kNh7+f5V4DMn8gSGMlrfa5mGPU1EeuCh1EA2x52rXVYLpfqocxMCf7t+W62y+URvGBtG
         Iwak9v4I4g1rbhiGWm0sKM69SVCTUDZqNrjLnzAJfzf3yahx2PWKcqbAOw3QIY3WU6DJ
         LPpA==
X-Gm-Message-State: AOAM530mEvFtu2AsJAfO7W66fvl0L9ppF8dMz9xsMdIVPIgq89cqB6Jp
        JTb3tbBavLzY0PusT2wrrKw=
X-Google-Smtp-Source: ABdhPJwlLOsj27oFDqkegbP47Jyqz5rHfjkyWmjij/bBuDfdmw9041RRFxFvX3tXSZHr8YxRxI2FGg==
X-Received: by 2002:a05:6808:10b:: with SMTP id b11mr8108322oie.90.1608528871172;
        Sun, 20 Dec 2020 21:34:31 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 109sm3622418otj.12.2020.12.20.21.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 21:34:30 -0800 (PST)
Date:   Sun, 20 Dec 2020 23:34:24 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Seth House <seth@eseth.com>, Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>
Message-ID: <5fe033e0ec278_96932089d@natae.notmuch>
In-Reply-To: <20201221042501.GA146725@ellen>
References: <20201217094424.GA75257@ellen>
 <5fdb3471c6bb7_d6d032087@natae.notmuch>
 <20201217175037.GA80608@ellen>
 <5fdc0e6dd79a7_f2faf208a1@natae.notmuch>
 <20201218023534.GA117762@ellen>
 <5fdc18a91c402_f2faf20837@natae.notmuch>
 <20201218054947.GA123376@ellen>
 <5fdc7a7d3a933_f4673208d0@natae.notmuch>
 <20201219001358.GA153461@ellen>
 <xmqq1rfmqc8g.fsf@gitster.c.googlers.com>
 <20201221042501.GA146725@ellen>
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seth House wrote:
> To rephrase: I don't wish to spend any more of my time debating
> `mergetool.autoMerge`
> vs.
> `mergetool.autoMerge || mergetool.$tool.autoMerge`
> and I appreciate that others on this list have joined that debate.

> I think all the angles and opinions have been covered at this point so
> perhaps the time has come for a vote or for an executive decision.

I disagree. It's fine if you don't want to participate, but the fact
remains that the position that some tools would want to turn this off
hasn't been properly defended.

> The task of re-reviewing all the mergetools surveyed in the original
> blog post is now complete. I took the opportunity to update most of the
> original post to reflect the discussion and audience here.
> 
> https://www.eseth.org/2020/mergetools.html

Thanks for doing this, but unfortunately one of the most popular isn't
listed there: vimdiff2.

> The "Mergetools Comparison" section is long and is not very easy to read
> with the current layout. Sorry. I wanted to get this published quickly
> and I'll try to clean it up and add a proper TOC. For now, watch out for
> the "Summary" under each tool.
> 
> tl;dr: I didn't see any noteworthy problems with any tool. Mostly
> positive results and some no-impact results.

That's what I expected.

> The two minor impacts were from the two tools that make use of LOCAL
> and REMOTE as historical references; I think those are safe to ignore
> because one is mine and the other builds on mine. All the other
> surveyed tools that reference older versions of the conflicted file
> appear to actively query the Git repository to obtain that info.

In both you say "identical output". The only "adverse effects" are in
the secondary view, which you didn't present.

Can you show these "adverse effects"?

> I'd still like to add more tools and do deeper dives with some of the
> tools already surveyed so suggestions, feedback, and criticisms are very
> welcome. That said, I am now feeling comfortable about adding this to
> Git and defaulting it to enabled. :D

Cool.

Fortunately in the unlikely situation that somebody manages to find a
tool with adverse effects they can just disable the flag.

Cheers.

-- 
Felipe Contreras

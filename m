Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35632C433DB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 05:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F35EB22D5A
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 05:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbgLUFHt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 00:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgLUFHs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 00:07:48 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376BBC061248
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 21:07:07 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id f16so7817278otl.11
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 21:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=NMSaCoou2lNm0F+x1F5xSdfLPNBhyK0cpbEHAYF+geo=;
        b=PY7LCuU52ToXTbmmS7B7q5i/vixwO2/GBM/0dvA+/ShCust2pdobch5/trqrs4kCSH
         3uBwLXEaraDxk9FDmQpujcks3Y4X82mruupDxO1bUVaNuze6lsB2mMXvj44aliQwxjtj
         2+M8PUw9PbtdGTftzEXJbX8l+1skMMoJQHA7v34MN1rkvN5MpokU9q62DZt6rHPx4VY5
         bsfacMjhhQrEaHthsY79qQLf7OtUeHLsxYkk5VUHUxH70ej1ORHmZUj3p1ayP5P+ujuj
         idi9+IzzNLSBKfoKVI0Ss93TWOIrPEwpGqw0IpaL24R3nfl+owve0YxcN1+bvtglc2aZ
         1nNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=NMSaCoou2lNm0F+x1F5xSdfLPNBhyK0cpbEHAYF+geo=;
        b=QiQwjxJN4jrCDpapQl4hxhWdfFDzog4hOfz5b0qVuhIPwUti+jnhaU83DbEmN9bjnz
         +9VkRr/2pWLT2cSiZhnWVKpYoqBwdlNu4O2d9btEN4ORopYlsU+0h8XBiy6xFDXDdbHg
         LqM3o6ZjdbhyY2XDqCbH+amL4HplITOrGk9qZnPdKU8zTIwJyvF5mdx/GqRC2U/laZF8
         0SNkeLTuFC59n1KRpmja+aEqxbWJ/QlDPUYPQ1f/ICNnx5YwarOeXra0fE8dImrVX2Ly
         4SGO1gY0V5Y8WnTIpIorQSJ4VWtkzgK+ZbAs4RBGcdLVqr3Eo+cCfogDMDCw3UAiXUxY
         IB4g==
X-Gm-Message-State: AOAM530Wg5H0jSbj9y6RXJtKusVW/PepnPs/jeUrnTrPR7vdjbxsadTl
        JM+2lKBYViTO7lsdAx98g+op+I3ZucU8dA==
X-Google-Smtp-Source: ABdhPJxlj3LTC8ks9ZEWA9eBAGdrY5pirrpAMPA+PR1QpPQ2TG9bqCgW4Ryey4UJGZkEqzEofo5Elg==
X-Received: by 2002:a9d:d8a:: with SMTP id 10mr10208869ots.11.1608510679192;
        Sun, 20 Dec 2020 16:31:19 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id z5sm3554667otp.40.2020.12.20.16.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 16:31:18 -0800 (PST)
Date:   Sun, 20 Dec 2020 18:31:16 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Martin von Zweigbergk <martinvonz@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Seth House <seth@eseth.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>
Message-ID: <5fdfecd47e17f_89f120852@natae.notmuch>
In-Reply-To: <CANiSa6jMXTyfo43bUdC8601BvYKiF67HXo+QaiTh_-8KWyBsLg@mail.gmail.com>
References: <20201216174345.28146-1-felipe.contreras@gmail.com>
 <xmqqa6ud2xuw.fsf@gitster.c.googlers.com>
 <105041520.23756286.1608159189934.JavaMail.zimbra@eseth.com>
 <5fdaef83a40ba_d0e26208f6@natae.notmuch>
 <e5c73fed-b87e-2091-794e-19aced4dd25b@kdbg.org>
 <20201217094424.GA75257@ellen>
 <5fdb3471c6bb7_d6d032087@natae.notmuch>
 <20201217175037.GA80608@ellen>
 <xmqq5z50z0yu.fsf@gitster.c.googlers.com>
 <5fdc153b97837_f2faf208ce@natae.notmuch>
 <CANiSa6jMXTyfo43bUdC8601BvYKiF67HXo+QaiTh_-8KWyBsLg@mail.gmail.com>
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin von Zweigbergk wrote:
> On Thu, Dec 17, 2020, 16:52 Felipe Contreras <felipe.contreras@gmail.com>
> wrote:
> 
> > Junio C Hamano wrote:
> > > Many people may stick to just a single tool and may find a single
> > > mergetool.autoMerge knob convenient (and it is OK for them if the
> > > new behaviour broke a tool they do not use), but for those who use
> > > more than one, being able to configure them differently would be
> > > valuable.
> >
> > On what tool would you turn this on, and what tool would you turn this
> > off?
> 
> Maybe turn it off for a mergetool smart enough to understand the semantics
> of the change?
> 
> Let's say BASE contains a function foo(). LOCAL renames foo() to bar() and
> OTHER adds a call to foo(). The tool would need to know that the call to
> foo() was added in order to know that it should be renamed in the output.

That's true, but that's something we would want in git itself, not the
mergetool.

If there are no conflicts, "git merge" would simply do the automatic
merge, and this magical semantic mergetool would never have an
opportunity to run.

> I've only skimmed this thread, so I apologize if I've misunderstood the
> quotation or if my point has already been brought up.

Nobody has made this point. And it's the kind of rationale I was looking
for.

Cheers.

-- 
Felipe Contreras

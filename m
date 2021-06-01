Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D4BC4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 18:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F07A610A1
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 18:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbhFASQp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 14:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbhFASQo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 14:16:44 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD11C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 11:15:03 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id q25so133954pfh.7
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 11:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6JwymMnIK2C2+oRXk2mn8StjTyHivH2zTQcDLoh0LvQ=;
        b=bh1+OsD0JDov4KFrcBFNLXwPXZeGY0ZKOMsZKB3Vx9CIo/+h/3k23RwL76U0px9Uju
         MVkBK71Lg+qd/ozr2tukO5KC9fI9uikVlwwDERIZScDJdxcyx6PF8h5PCg7NjV9WAhme
         7D6NVa9Y+X7rpCpvzEpCcyDZ2LhpUo3gDc1cI/hmDLDqdsFh2EnbKH/r0IKj8idv2fpJ
         Kek3U4S5fhxWszMWosfNmYohbcM4t9wvT2e8ytIgHIbODtoFkOWOdY43GY2W1Za9Ujh7
         CsyfqQwttoVO8BnOShDusDLDK9AJzJ1UuXtg5eKG2XoLc5yJSQaDr+twm3KgJbAIRr0K
         LJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6JwymMnIK2C2+oRXk2mn8StjTyHivH2zTQcDLoh0LvQ=;
        b=FJUdlvMRfr1xChicU/A+nCX6lCsHZRUVDGHXwRMdvx4hvM3tnb54acEwKXXscXWRUJ
         LWh4J+jvHBN5xQ1TSXvhA2qYDhHGXMysn1v8Q2EZySBbmFMitfEVuPJVcmXL1Acl/s7m
         jgjFYDdKrkXZOy36G9oqdykQZDoHnErX3eKMl/ahjl0BI37maxBvjjR3xkNIJFMntpQo
         9cntrmbBIxq1CISE9ol1oGHtwQJb/g3WI7CHIYQKfz7euK83LVYndyfLNNCdNb6iS6ot
         cbjouiZyWLgGx09MpDDklYdyPLKdiru5iH6KlbGDDKlV6Cbr7GxzeNnggCQOCr+K7G4a
         Ge9Q==
X-Gm-Message-State: AOAM531iXTbN/L2RfcI4tHrjnI1KsXhRMtJk8gX8wl9Q8Es0Vm+o54Ex
        RAYwaJd0/CQz5G5PzfWpKCIxbH2d8Ox47A==
X-Google-Smtp-Source: ABdhPJyaAZT0gNh5yhMEBuCXis8v05HsMoPkBUnuEBt4dIqGz48AL7W3FEgzIeLePlTSpTatp4noTA==
X-Received: by 2002:a05:6a00:84f:b029:2be:3b80:e9eb with SMTP id q15-20020a056a00084fb02902be3b80e9ebmr23224522pfk.39.1622571302726;
        Tue, 01 Jun 2021 11:15:02 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:7827:e4ca:8a0d:c895])
        by smtp.gmail.com with ESMTPSA id p26sm2442026pfw.178.2021.06.01.11.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 11:15:01 -0700 (PDT)
Date:   Tue, 1 Jun 2021 11:14:55 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 00/31] minimal restart of "config-based-hooks"
Message-ID: <YLZ5H2Muh39Q4M5T@google.com>
References: <87lf80l1m6.fsf@evledraar.gmail.com>
 <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 28, 2021 at 02:11:02PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> After suggesting[1] an another round that the config-based-hook
> topic[2] should take a more incremental approach to reach its end goal
> I thought I'd try hacking that up.
> 
> So this is a proposed restart of that topic which if the consensus
> favors it should replace it, and the config-based hooks topic should
> be rebased on top of this.

I'm not entirely sure what you're trying to achieve by sending this
series. It was my impression that the existing config-based-hooks topic
was close to being ready to submit anyway (since Junio mentioned
submitting it a couple revisions ago); rather than churning by reviewing
a different 31-patch topic, and then re-rolling and re-reviewing a
(reduced) config hook topic, wouldn't it be easier on everyone's time to
do a final incremental review on the existing topic and then start in on
bugfixes/feature patches afterwards?

It would have been nice to see a more clear discussion of patch
organization sometime much sooner in the past year and a half since the
project was proposed[3], like maybe in the few iterations of the design
doc which included a rollout plan in July of last year[4]. To me, it
seems late to be overhauling the direction like this, especially after I
asked for opinions and approval on the direction before I started work
in earnest.

Anyway, I'd personally rather spend effort getting the existing series
the last few yards to the finish line than to head most of the way back
to the start.

 - Emily

> 1. https://lore.kernel.org/git/87lf80l1m6.fsf@evledraar.gmail.com/
> 2. https://lore.kernel.org/git/20210527000856.695702-1-emilyshaffer@google.com/
3. https://lore.kernel.org/git/20191116011125.GG22855@google.com/
4. https://lore.kernel.org/git/20200728222455.3023400-1-emilyshaffer@google.com/

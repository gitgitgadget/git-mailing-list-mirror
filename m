Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABEBC433DB
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 05:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD9E620855
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 05:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbgLWFmb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 00:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgLWFmb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 00:42:31 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19734C0613D3
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 21:41:51 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 11so14076969oty.9
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 21:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=2ZHZUUcYZcdnxgfxBXnvg9syDJCNQCbyhf1EczhmXdY=;
        b=dsUAQBD9BLEnUMDCzWB8CBJO4hQtTrsjW07L7eOarpzsxmTVPy+OjW+D91br2BmV9f
         PCE9+6mZcQPqwUmj2TtlJWaOJcYTWW1j2TeANwfyhk0acYsI+DmterUd3C9HuMiDho/W
         4DDcis0GEuTBjDtzsDPaZgb17krhFB+JwnLi2rSX12EAUvYOHoLktHZHjuQVQQMhnmJk
         f1Mobcbx3nSZrILuiqhe6SH4EosBbHeCGA+QHGRmG/b6WefPqzbcaMweBGh57VWr4SjJ
         thzwiIEv4SvOKsy2/TNdBtVC0PpC3I4so3WDxuSDGD+AN+1ZRBBT+Kz6NJSkkKEJih+C
         rgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=2ZHZUUcYZcdnxgfxBXnvg9syDJCNQCbyhf1EczhmXdY=;
        b=JmFm2rQQFP1DNMfiSPV5gxA+wXfXXuLHYjfcdmCqcmsrREoXmRpWYCbqYDiK+W18/l
         QKf+Q8ncwDsipkPcNU4iRs61rBeuDagFb7nJkVT+WCHD6tCeaM5nY/gZ5CEChzfZO5lq
         5wAjJKzHF8wogBlhwbCN+KG+PDUHZ0wLnYW86Yxw87wg5cTO1QTm403eIDH0INsvWHDT
         HKebxZjTj/W3A5yY20p/+fC/xDWIGhPZtLz1/uWK7m4mLSkcvd+oXZWyz12iL/C4aWms
         gjiKEjEgXCoWUQOb74RgWFOdnvNxO5bXTNc1pnTnrwjsni7dKwofwl0wNWoIibv7QNCa
         Wfpg==
X-Gm-Message-State: AOAM5308zMxNezX9fQmJL9G+/fCHmJ/75Sxlcw9l41CQ1T2okAy0u299
        TC6ZqzxzYIJZR94zvOTAWBE=
X-Google-Smtp-Source: ABdhPJztenX94Hk7BuROCxj7XYwqqtbTul6AtuMunri3E9lmIRqP4X+zCCxy/hF98fuJjDWh+g0FPQ==
X-Received: by 2002:a9d:664f:: with SMTP id q15mr17625466otm.40.1608702110462;
        Tue, 22 Dec 2020 21:41:50 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id l6sm4971101otf.34.2020.12.22.21.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 21:41:49 -0800 (PST)
Date:   Tue, 22 Dec 2020 23:41:48 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        David Aguilar <davvid@gmail.com>, Seth House <seth@eseth.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        git@sfconservancy.org
Message-ID: <5fe2d89c212e8_18dc12083e@natae.notmuch>
In-Reply-To: <xmqq5z4tdsiz.fsf@gitster.c.googlers.com>
References: <5fdc18a91c402_f2faf20837@natae.notmuch>
 <20201218054947.GA123376@ellen>
 <5fdc7a7d3a933_f4673208d0@natae.notmuch>
 <20201219001358.GA153461@ellen>
 <xmqq1rfmqc8g.fsf@gitster.c.googlers.com>
 <20201221042501.GA146725@ellen>
 <5fe033e0ec278_96932089d@natae.notmuch>
 <20201221073633.GA157132@ellen>
 <CAJDDKr6LrBMyfdp5Tutp29W9OqhbW4ffcP5e6PD8ruyxk3rQxA@mail.gmail.com>
 <5fe134eeaec71_11498208f9@natae.notmuch>
 <20201222150124.mnfcyofm4qyvvj4n@yadavpratyush.com>
 <5fe2c64bd3790_17f6720897@natae.notmuch>
 <xmqq5z4tdsiz.fsf@gitster.c.googlers.com>
Subject: Re: Code of conduct violation?
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
> > Pratyush Yadav wrote:
> > ...
> > But I'm not going to pretend I'm fine with a change I disagree with; I'm
> > not. Especially when nobody is paying me to do this.
> 
> I presume that at this point you are no longer talking about the
> inappropriateness of the phrase "never-ending pointless rant".
> Perhaps it is time to change the subject line.

I am responding to what Pratyush said, and he didn't change the subject
line.

I don't know what he meant by "it". I'm just guessing.

> If you still are, then please disregard the rest of the message.
> 
> >> The community needs to do its part in making you and everyone else
> >> feel welcome. At the same time you need to do your part in making
> >> contributors, especially the new ones, feel welcome and appreciated.
> >> Being overly critical can turn developers away from the project.
> >
> > Who are you talking about? I'm the one who made the contribution.
> 
> What does the "change you disagree with" you mention above refer to?
> Changes suggested by reviewers to add per-tool knob?

Yes.

-- 
Felipe Contreras

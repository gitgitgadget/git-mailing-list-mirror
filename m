Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD71C4361B
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 21:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A036D22CE3
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 21:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387922AbgLDVan (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 16:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgLDVan (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 16:30:43 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F378AC061A4F
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 13:29:56 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id 91so2708448wrj.7
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 13:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=90hk1FzSogEU4j96cIq9cYGy+L+3yHsl/Qxtxzb8H3Y=;
        b=pqvLGfhCJuTgw9irzAggIkHanwwoYuM39MExArYaha9wQ16dcFEGauDyuWsnZ1TF+5
         iR25LqHmBbwm8XcRtiGbgcn6sMjaX5GOlYsokj1ZgjG8hmztbLtjqzUUrym3r00H7zxh
         B73nT4UhrgpJsB1wYXdTFQT0KViXFMARGte6bnHpkS/e3BYJdOwZGIIj36NNaEdZVHGO
         fOvUm4d+0s9dgE/UKaH2nF7IJ61pSOyZHrPS9yJpWNNO29bPnVMKIcPSFx7dsTysFLKh
         jtTL2Tm6l+l4tc94p1AvICqmizT6jfiyl6L3ZjfJntPm8gnZR54vlRySO7DXda9uZPie
         Vxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=90hk1FzSogEU4j96cIq9cYGy+L+3yHsl/Qxtxzb8H3Y=;
        b=sR5lu1T7/iHsCPdAw7QR+cMXwcJPchoGguuHIM4QiRGYaUwpCwGalZviCRcGKRxZw/
         v60S8yS7v5MEqSt8OppSK30OfIXfp52HWOvQo5626fLLRc8o+3G1EwIrp0cR+gjFLiq/
         USBcVAkAotsHzMfetxRT/nbPXI/n4rauhMPr4vCOdH51avxu33fsIg/+KQ8iibb7BvSp
         poZVyFqxQTpwEIZTF6FDcuDm54d/sPUbRTG6sfWJKlSQi1eGAIcL9znvzsx6llGo8rK2
         CbrQNTuPAmfWU2Lek6wOmOpJ3xPMHN7vuuNvYQZQ7qFOqEJTESBpjvCO7672HPBkoKbn
         Rv/Q==
X-Gm-Message-State: AOAM532bjjrqqh8o9kyWVdbvIBYypLzR2LvO26Hnwe9nUgpnNFJ4VoZK
        /CRvv7IqK0v51K55XwIp2O8/IbDLbr4G1m+Q5e9XTr8vvu30HQ==
X-Google-Smtp-Source: ABdhPJzhVzjf4vLq7B3F9Gs8FV/0Wu6dRkv5m3hhDmviUmxYgsgWlBDpP4ferHtznGshoS6kHqZeF6LCFGUH2Pxo+MQ=
X-Received: by 2002:a5d:4349:: with SMTP id u9mr6854264wrr.319.1607117395731;
 Fri, 04 Dec 2020 13:29:55 -0800 (PST)
MIME-Version: 1.0
References: <a4ae4e1a-b457-4b35-878c-2714ebfc415f@www.fastmail.com>
 <CAMP44s2=3GrXf69jqVJ23U=N9QcmGb-dHP_OEqyb6MVTY2z7Jg@mail.gmail.com> <601563bf-ed54-4795-917a-fce6e9343b79@www.fastmail.com>
In-Reply-To: <601563bf-ed54-4795-917a-fce6e9343b79@www.fastmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 4 Dec 2020 15:29:43 -0600
Message-ID: <CAMP44s391U8B5c0iLX84Gqcbg++nbaXs+g_duP82R--JAmLvcA@mail.gmail.com>
Subject: Re: Unexpected behavior with branch.*.{remote,pushremote,merge}
To:     Ben Denhartog <ben@sudoforge.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 4, 2020 at 10:45 AM Ben Denhartog <ben@sudoforge.com> wrote:
>
> I'm just now hearing the terminology "triangular workflow" (I may live under a rock), but that aptly and succintly describes the workflow I was attempting to simplify with my initial configuration.
>
> I read the article on your blog, and the solution you propose makes sense to me, at least in the context of triangular workflows. I don't see any public feedback on your patch; bummer to see. Is it something you've brought up since 2014?

It did receive some positive public feedback. At least v3 of the series:

https://lore.kernel.org/git/xmqq38hkx4lr.fsf@gitster.dls.corp.google.com/

But my patches have a tendency to enact resistance. Perhaps more so back then.

I have not brought it up since then. I currently have like 4 patch
series stuck, doesn't seem wise to add another one. But I likely will
at some point.

It is the single most important feature I think Git is lacking. Having
accustomed myself to the publish branch, I now feel like missing a
finger without it on git vanilla.

Cheers.

-- 
Felipe Contreras

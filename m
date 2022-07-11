Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F52C43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 14:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbiGKOkd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 10:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiGKOkR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 10:40:17 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B532667589
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 07:39:52 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id r82so6905281oig.2
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 07:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=drawofthemonth-com.20210112.gappssmtp.com; s=20210112;
        h=thread-index:references:in-reply-to:from:to:subject:message-id
         :mime-version:date:content-transfer-encoding;
        bh=sqVlQCtF+0sysaTPLKU+XdxXAx4kgfd1Tldxr0s+cSg=;
        b=vBYosJTRQtS1G+H+KC7qPEvAc4nVLCSkN6YhOTMsfaRYClx3H31SItvW83WkimVG01
         uE/aUA99bcoXK9gJ7hs0HF+OZC1FZgQ5MAh0JhF71EbCZBSzZGL+eSuTgvCghE9oIrvT
         lXopYuen84Q2k21hySeljjbAQZfuuM/0J/cxN14i4DE+y+pqPKJU54iLngIkvatAADQA
         WFDot0jmnkg0oGn7Yqp/DBOcBXDWeytCYZ2mO7C+9K164NYkeKyDQuUxxWAcjPejCcjW
         i3H7UMLng1J639W6SO3HufLlrdpg1+NHYaMFm4/K60dswptihgEZj9wP8JHan1JPC6uk
         s+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:thread-index:references:in-reply-to:from:to
         :subject:message-id:mime-version:date:content-transfer-encoding;
        bh=sqVlQCtF+0sysaTPLKU+XdxXAx4kgfd1Tldxr0s+cSg=;
        b=H1G52+op0CSLuvZ6rLAgCtYVzhu9ZGlc3H7iOuQNB2YQB1xrxbONwPjmGhVzGzkiOD
         aVtO6BVD7Zt8Hra4IZx4q5XYDtSPYncCS1hEXb5eRnxtLYpF5okH4Oz3qvYRTv43GOHD
         oglX02bwuYviPiuIXNOJtQAYIl6UiawrRiu1mTeh6p1Yo1lRxuKNxZ6geXL2t4by5FP2
         6fwkur9ayPDiKe27zntbWc5EZZnQKSU6Dri0M4MyfhhI6I+On20R702lpjq4fhuzBnzC
         EGNYkYPN6GXsMlTXQLXwCgGXGglQ/dYb4IsxP7nqHfH7g0aFD64gFBbzK2WxsXxdkcJN
         NRoQ==
X-Gm-Message-State: AJIora8JhtydZWoaZQ8iRpcA5h9HJGtYi2CrxKg7DWgo+9XohlCuMqir
        kj9/pLnG3bE09deU/gAYH/gW+w==
X-Google-Smtp-Source: AGRyM1uJIon4vqJSXNocIsR0qFasu3OWRZcgag0IWdvCXSdg8/GLsHj9mc8h/jewYFR9CS03Dr3Vkg==
X-Received: by 2002:a05:6808:150a:b0:339:cd06:b6fc with SMTP id u10-20020a056808150a00b00339cd06b6fcmr7385960oiw.198.1657550386189;
        Mon, 11 Jul 2022 07:39:46 -0700 (PDT)
Received: from metricscallservices.ladesk.com (1.app-q.la.linode-us-tx.qualityunit.com. [72.14.191.60])
        by smtp.gmail.com with ESMTPSA id f14-20020a4aeb0e000000b004354656212bsm1091708ooj.22.2022.07.11.07.39.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jul 2022 07:39:45 -0700 (PDT)
Thread-Index: 8jXy6wskotZn5ZJq
References: <CAKLzR_oPu6QDYHEru7W0LjFffDaQo_rSoAiexrnbpVyhT9eSsQ@mail.gmail.com>
In-Reply-To: <CAKLzR_oPu6QDYHEru7W0LjFffDaQo_rSoAiexrnbpVyhT9eSsQ@mail.gmail.com>
From:   Support <support@drawofthemonth.com>
To:     Jennifer Kitts <kittsjennifer4@gmail.com>, answers@hud.gov,
        bharris@tvchomeless.org, customer.service@bedbath.com,
        dev.cryptowake@gmail.com, EBBHelp <EBBHelp@usac.org>,
        email+fitler@gmail.com, emoji@vlaunchercorp.com, example@gmail.com,
        feeds+subscribe@nvda-addons.groups.io, git@vger.kernel.org,
        iconpackdesign@gmail.com, info@aplacetostaybc.org,
        invite.code@arc.io, jen801@gmail.com, jenleann099@gmail.com,
        Jessica Carlton <jcarlton@mcnabb.org>,
        jessica.carlton@mcnabb.org, ji10bin09@gmail.com,
        jkitts957@gmail.com,
        Kelli Wiestling <kelli.wiestling@premierhvacpa.com>,
        matthew.michihara@gmail.com, media@tracfone.com,
        mobolauncher91@gmail.com, mwk.irul@gmail.com,
        primeshineclean@gmail.com,
        Safelink Wireless <noreplyuser@emerios.com>,
        spren.dev@gmail.com, support@androidscript.org,
        support@iconscout.com, support@porting-team.ru,
        ucp.information@tn.gov
Subject: Re: Contacts from phone - [CTN-GPNTC-605]
Message-Id: <11278151_fqirlae4@metricscallservices.ladesk.com>
MIME-Version: 1.0
Date:   Mon, 11 Jul 2022 14:39:45 +0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Thank you for reaching out to customer service!

We don't s=
ee any active order being placed under your name, meaning your order did no=
t go through successfully.=20

Thank you,
Customer Support=20
(844) 429=
-5635

-----Original message-----
From: Jennifer Kitts <kittsjennifer=
4@gmail.com>
Sent: 07/11/2022 08:30:24

> snippets
> snippets

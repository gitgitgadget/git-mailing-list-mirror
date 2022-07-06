Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40493C43334
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 17:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbiGFR4l (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 13:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbiGFR4j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 13:56:39 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37E41EEC6
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 10:56:38 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id q4-20020a170902dac400b0016becde3dfbso4034715plx.17
        for <git@vger.kernel.org>; Wed, 06 Jul 2022 10:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=C4M6eB74SdPp8Wk/rWiqwkCruD9oMKZHozSKR9kFhmU=;
        b=sg6MI+1VXsUAENlvAiMTra1zmEFUeP1pofkI6YXQ/jhAiTa4xbXNzh4uClLBmI9XeN
         21cmaZ8aNrgLJKY08N5/HaR5pGJhrNrhhrOU1Y0SoHUg8UqCATK9glsEwnUbx3zYIXT2
         w5nb5WlIQRdZCIQ6cJGjmUgUltgd2n+wegOXl9s9hJkiURWGaYcbgWQTgLyp3sUBEyuF
         3wbLSZoKaE12ZZmP1jRblbhIDMUo2ZQuhFJfvPQEBtFSUpTetlZmevVKzCS+AK37gBwS
         D1h4r5hCEQ5+QmvsxCgrZH8vvUssCEmmIxWYdl6A67JMyrsOSsAdvTJB9TCUMAU+TRn4
         h2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C4M6eB74SdPp8Wk/rWiqwkCruD9oMKZHozSKR9kFhmU=;
        b=kLycq31D/4ghA72S9aNG/Up6w99TkSlgV/d8RIES1/+NucsBfer2W0ROZ5WmY2RXEc
         Pc+08knBPaPQzC/JeTrqWB5V/UhD5Y9aoY8p9LJB07pbMOM3FExgfBErHtlGusN6pcyc
         yql4SBlcnF4IvRaIQu65RXwGunB+wUKjohh9CPpqN+bchuuyQubb5gAq1fJHYsi7aJ3c
         juR+1CFlnqQWyC1dVrwTwfWFJKqQEIicx6yc9uvjNFaU9r9rppBpzjXW61vM3hF86u4g
         n+3OwiX8hxeMjmMn8fuTYXorZplgPEMShWfWazPVCLF2Vd2zrzKFWE3lxQjisYQAHHXB
         wM8A==
X-Gm-Message-State: AJIora8CF6Idkv7VFR2lxn1J37S9kgbPEQDQBPT3OozitdkLV41qHV2L
        qyT/MRfU5E1GJbGS2jjK4jxyKrxxOkFbHg==
X-Google-Smtp-Source: AGRyM1t4ZS2RrIlgA6Ukj6zCc9vQeMSWozy2agZCCsO3ZuQtbscbNykQgGDGckkskDm2BaXs8RBTOzvEE3gvag==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a65:6d0c:0:b0:412:6da1:df6b with SMTP id
 bf12-20020a656d0c000000b004126da1df6bmr9842531pgb.14.1657130198163; Wed, 06
 Jul 2022 10:56:38 -0700 (PDT)
Date:   Wed, 06 Jul 2022 10:56:36 -0700
In-Reply-To: <xmqqo7y85t44.fsf@gitster.g>
Message-Id: <kl6lh73urup7.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <xmqqo7y85t44.fsf@gitster.g>
Subject: gc/bare-repo-discovery (was Re: What's cooking in git.git (Jul 2022,
 #01; Fri, 1))
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * gc/bare-repo-discovery (2022-06-30) 5 commits
>  - setup.c: create `discovery.bare`
>  - safe.directory: use git_protected_config()
>  - config: learn `git_protected_config()`
>  - Documentation: define protected configuration
>  - Documentation/git-config.txt: add SCOPES section
>
>  Introduce a discovery.barerepository configuration variable that
>  allows users to forbid discovery of bare repositories.
>
>  Will merge to 'next'?
>  source: <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com>

I'll send a reroll soon. Taylor Blau left a bunch of great
comments/suggestions that I intend to address (though I don't think any
of them were meant to be blocking?)

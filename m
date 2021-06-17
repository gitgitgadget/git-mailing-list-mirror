Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FEDC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 07:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 781AF61241
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 07:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhFQHTM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 03:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhFQHTL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 03:19:11 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE41AC061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 00:17:02 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id og14so8088710ejc.5
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 00:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=RSrTIazm+SUun5AlJMcTGAs9643XguNAXgE3rLagKEk=;
        b=h332fskxCEJis8JiLqtKD3U6P7CSnjYgX6ogp6yRLDRUk3TtilGIpaGFk6HlBRNYnk
         H86aXgR1tEUYW4h9+JH8/2sWme5aver2GdRUEwCI4KJfCy+0q55f0qhpgrkZIofnVDz1
         oBVw5fpzYspCrRnHxy1v9vi0vcXpfreo6z1KjmK+DHF85549SZ6gv0dvbYa1hzHtPvnG
         UkLY8PKrGnvZxUgnUAKepRT355OyJROJBqcWkeiOOfbYY8jrwYgOFsPKlBGRlDXuIN2Z
         dEcLXdIUkuN0KhXFUbfHt3a3OymIPzAz8yy1a23LHNkWG2y2DRG1MsAblgcSD89U8PU9
         i64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=RSrTIazm+SUun5AlJMcTGAs9643XguNAXgE3rLagKEk=;
        b=GkvIYK4q7JSdW7vD8kTbAfjBPhBMN20Sn5jn624wBzqFPfXSiXoMHLw7jx11YZqX1O
         jtu9wi492XMZWxMjUTsZg8Tno+EdPQW+zboLdFP4L0s6wuF5IhHkMjs+tLH+T9f3YQ3P
         hKjHbMgL4k+To7MeWsMxf5STf1DnapHxzIju/clNw3bHN89A50s1QSrL9R8hBDoXlCvn
         GJinAC8IDaiskfNSJvkg4zyO7e9XzdBu6zMvtRuW92yIW7xuQaRNb5WaqEnb5iHeSOmf
         qw8EqPl5gwk7BtApRIP3lgDJUDf1hFZIrTyclg1fSlmkDbTazK8/q4JesCKcD6YiLO9T
         7fqg==
X-Gm-Message-State: AOAM531W+cmEpsvCtFUZ/6VkDpvNPmHIDy6uFvg33zlYHattsuSmXj+I
        nHJxuMyDZa1I7esOWyhS9bgCCbGfnKL2Fw==
X-Google-Smtp-Source: ABdhPJy4uECvTUIUlmFYHUwB/wT6IDvlQWMbtBHtFzHu+rCXOzd64GBwrAQwuJDAg9iIlHRifaANmw==
X-Received: by 2002:a17:906:d8cf:: with SMTP id re15mr3705205ejb.278.1623914220988;
        Thu, 17 Jun 2021 00:17:00 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id o4sm3455018edc.94.2021.06.17.00.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 00:17:00 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 7/8] [GSOC] cat-file: reuse err buf in batch_objet_write()
Date:   Thu, 17 Jun 2021 09:16:39 +0200
References: <pull.980.git.1623496458.gitgitgadget@gmail.com>
 <d31059c391d0c3f40ba45be0803a5ac6d49d5c6f.1623496458.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <d31059c391d0c3f40ba45be0803a5ac6d49d5c6f.1623496458.git.gitgitgadget@gmail.com>
Message-ID: <8735thx8nn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org




On Sat, Jun 12 2021, ZheNing Hu via GitGitGadget wrote:

Subject: s/objet/object/

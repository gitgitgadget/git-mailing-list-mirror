Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6053C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 03:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 950D66101D
	for <git@archiver.kernel.org>; Thu, 20 May 2021 03:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbhETDHJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 23:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhETDHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 23:07:09 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52A5C061574
        for <git@vger.kernel.org>; Wed, 19 May 2021 20:05:48 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so13607923otc.12
        for <git@vger.kernel.org>; Wed, 19 May 2021 20:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=q2e6kLPicIpSmBGJUp79Yj6H273awXAHFGNZltpMHlI=;
        b=sZBn/OZKNUwmvEWrF2/YwLNSBTLItyhycKSoeci9ngXuQIvuZj8D9e0PnGggWjo1hp
         byYvvIpVmC9yCsAmsMUxfaP1RS1HGhcKxSBQkQmM7NExiv11z4D4GwEpcjC8oYPzfypY
         NGgT1D7RaiaZQM4mfqj0Tr+moQ4VqomUqoT6QfG1vkdoNTk/0d1ywImQQU36c8TWf9W9
         E5irSt12+3YCnhqSyC6HAfgy9EbfeeeFZjMTNFVj70EsMlV/tek1RhjY4CkoCjf89SY9
         DbBuZnrkkUd04UaO6z0+PNzy6BfoScI1qTzGdzxfzlqTvU+4d2txxDAgIqMx0lj/+VOD
         F8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=q2e6kLPicIpSmBGJUp79Yj6H273awXAHFGNZltpMHlI=;
        b=KrLUhnQMSAQ0r0RVbqt6Flvg4SUSEFIppWqRggAoCkF68Ar+n6rrbIxQKPfVgDUZO7
         6OjeZ/3cuMZWYZDYTSAC2kDezZ0puksQolgvPM7BNhdBeEMAaPyBWmPOqMlCNG6NISfZ
         BKVjTtXu4gNvAoAP5MIQ3iOlHS9dkGIuVWCBPFoK2BqnPB0+7ES3GNyOllXX27gastnQ
         J/xds+/OVqxhvIO590Ysm4Ra9OGnzYQ5eUpeOO7bmAK5v2pJOHzyfKKRn1dlAG41/G5d
         g8w7tuxsePeNZbpErXL6Y60R+7m9UwLCZpU5lK/YgOQZzTzleWxBi51LJiGDtZAfKERs
         Ifgg==
X-Gm-Message-State: AOAM531oiFTd7pYSaNIQYOmWFVLAHhN50r7LhWWvUxvlBawrwL+TM/Us
        +fGdpLbP2uLXP2vrAr/8GC4=
X-Google-Smtp-Source: ABdhPJyZaMaM+oykNOVEYyxItpGedGTUYPJ3I6DnCj3ecOP7HlRicAp8PlScytbPZR+YfvXEZP8X1A==
X-Received: by 2002:a9d:4e96:: with SMTP id v22mr2117164otk.134.1621479948164;
        Wed, 19 May 2021 20:05:48 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id z6sm345521oiz.39.2021.05.19.20.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 20:05:47 -0700 (PDT)
Date:   Wed, 19 May 2021 22:05:46 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Message-ID: <60a5d20a4e134_1f37320860@natae.notmuch>
In-Reply-To: <xmqq35uiw3bm.fsf@gitster.g>
References: <20210518010121.1350327-1-felipe.contreras@gmail.com>
 <YKMWL0iZLVl1KTrB@camp.crustytoothpaste.net>
 <60a332fd22dad_14c8d4208ed@natae.notmuch>
 <YKRSlFcFAcHcR3uY@camp.crustytoothpaste.net>
 <87im3fqci9.fsf@evledraar.gmail.com>
 <YKXBdQ36MYz2YG8s@camp.crustytoothpaste.net>
 <xmqq35uiw3bm.fsf@gitster.g>
Subject: Re: [PATCH] help: colorize man pages
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
> > The documentation says, "use the man program as usual".  "As usual"
> > implies the way the user would invoke it.
> 
> I guess what the documentation says matches what end users expect (I
> as an end user certainly do expect that "git help -m foo" is running
> the familiar "man" command on something that is related to "foo").

Do you also expect that `git diff a b` runs something similar to
`diff a b`?

> So while making the "less" customization more discoverable and
> easily accessible would be a win for users, I have to agree that is
> out of scope of this project's mission.

How is enabling a configuration already present in `man` out of scope,
but running an *ENTIRELY* different program--such as konqueror or
woman--to view man pages is not?

  git help --man git

Doesn't even necessarily run man *already*.

-- 
Felipe Contreras

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460A3C3A5A7
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 00:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiLGA6o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 19:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLGA6n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 19:58:43 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E316B46671
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 16:58:40 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id z144so6628062iof.3
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 16:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1iJpkm7P6x5zG1JTb3YcPNNgucRBA/ZGO20vZrt1eJ4=;
        b=jpLrvZceEsE4mod/lA9YkuK9tHfmMJpPe05dtQuzR3X7qg0Gu2okrQ5LY8D8H6n2/7
         20PW/xwHftE+GvS5uqxch+4AgAD/VuPl4Nll/Tw6oor1+Sd3pyzJofxrv0bhqs6bgsc2
         qcYM0lti44rO8ZQ3r+xGwjOlb26Jr8Tc00busOxp9/gUhhBSVRMJWTp8BrdkzHlGkxN+
         Yy0Jv1wLeWcCcsGny//3OPd1MtztIvpjLfVw5ddHx50bpQgvaOwHUAL5HXkRbtd4ewsT
         5wFuy70bZnJ9wALnpV+IQdXuY974xGbM1LkS0riWMOWY7lTxrOLW3n0GKV4+BBlV0z7W
         gZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1iJpkm7P6x5zG1JTb3YcPNNgucRBA/ZGO20vZrt1eJ4=;
        b=rUjJ9kMJkbKtv45bHAx9h9wXFI6q3C5w0VwIdFKAZDFs7mVa5X+c4VZoIChK1HCu9E
         iQOuV2j2wDmCoAnZSM3eBuEhdaKM6QIaig1HJSYL8lGbWcJ19buVHmL6FXbkqoBwskUl
         WIbfHsTLM9eFxtmTLLUZ9r95eHxEp0z9gWnYaygCeit15K1VB1hRI6D1trgQZSiFlc7U
         4KerjcaESzZKeulPgLVd0xl4eg6fnKZmbHDSDWMGnCy8/J2Z6m10c6c8rmM7U1qZ1Y3e
         UNXrygGKWzLlH6nUoh5c7xouz9822xqzqED8Mw9WA9omNg7M2ZRLrjFUXYMCrSFrAQzi
         OTVw==
X-Gm-Message-State: ANoB5pklFSsXQugoHo4BDTr3kzAD8t5wpHeQ3qmTBPuYU3nj6BAJMvMP
        rZdTXoFg6hMlgMvEu6dFMRXN0w==
X-Google-Smtp-Source: AA0mqf7Yg2Cji06hkDaFQeYTgsNu48MQqNeWJUCJIG5ivYnKwRV11b6pbKSB3cV3TtA2+YjnUZ5NFA==
X-Received: by 2002:a02:6068:0:b0:363:e6b8:2bac with SMTP id d40-20020a026068000000b00363e6b82bacmr42042805jaf.229.1670374720272;
        Tue, 06 Dec 2022 16:58:40 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h37-20020a022b25000000b00374cd28d842sm7396591jaa.104.2022.12.06.16.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 16:58:40 -0800 (PST)
Date:   Tue, 6 Dec 2022 19:58:38 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] CI: upgrade to macos-12, and pin OSX version
Message-ID: <Y4/lPmD5Dldn/USd@nand.local>
References: <patch-1.1-4c1dcc89e7a-20221206T195552Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-4c1dcc89e7a-20221206T195552Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 06, 2022 at 08:57:56PM +0100, Ævar Arnfjörð Bjarmason wrote:
>  .github/workflows/main.yml | 4 ++--
>  ci/install-dependencies.sh | 2 +-
>  ci/lib.sh                  | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)

All looks very reasonable to me. I'm glad that we're not going to be
subject to any more random CI breakage than necessary when GitHub
publishes new images.

On the flip-side, we'll have to remember to bump these ourselves, but
macOS releases are infrequent enough that it doesn't seem like that big
of a deal to me.

So I'm in favor of this change, too Thanks for working on both of these.


Thanks,
Taylor

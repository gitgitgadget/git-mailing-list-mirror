Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176AFC433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 08:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJLIak (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 04:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiJLIa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 04:30:27 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC74E3AB15
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 01:30:24 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id r17so36425308eja.7
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 01:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DrI68IeuzdqKCSrhc/sfHFnpZ5QIijAKfGSd0Kw98Ik=;
        b=BW2jTifwxvuOMbxjIEl+wAb5ctqd8Pikn3e+RLRLlJY6rcw/QHJPwzvOCA8QYcWgBo
         yMTAheb0YzEJcTXN9aCsde5idGSafvQR8awXSJ5P/dedhLEvbPyHBwpaeRc1vpWC9TWE
         yb/fx+tNnxV2McVQtc3iniLv0+qAzeHTmq9EQybVqkh+yhgTrF1levuyBxQ/iTZkLxzW
         osdMw3Xp+wNvFtB4dfycye6nOJNPYZIpwVNMhJOMvtlgpAOB5ocjOgUv15mQcuSbjagH
         UjHaajNp4yOutvJOyCRvdQJ9FG6cy2u90O0CwODaRxz4tOad0PbN/JQwmhZVy7NFCcCZ
         nQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrI68IeuzdqKCSrhc/sfHFnpZ5QIijAKfGSd0Kw98Ik=;
        b=sYqMvyU8r7yvP8ywfhQG7l4V4Az47+U/AHntupRRBZ+Q21LIWbUWShPaEJZJ8pBi5B
         HXDY5Lk6SnKkA4WVt5JduZhfdAUXu8Rr/A3fEtSpkit0eB8epupn8b6Fyi6cw47B7Uhs
         f5bMwlRkFeXwwRCAiAXCvbNR0olujP2l/B1kkSZV/ZshKYieMBahjxLXf5e/gxoJjCbu
         z0okk4bA7WNDdCy92H3ZT7pD1opqO/Xxod/5oebDrOS8fO0FDdFrS0d43PwkkX4P9gqj
         J4iGYoZXFiysrjDvVh15G8gIScfpnc0YZtkTF55h22TGyzYCqWWXHFJblfqq4LpOjBSq
         3XcQ==
X-Gm-Message-State: ACrzQf0CeFYCw5vO0ZmhczrBiNYpaEG6/KiM/xfAdWE/6d9EawPzIPdQ
        7SyTKeE7BklNP8t3LSsa6OtfVMXSvKZacA==
X-Google-Smtp-Source: AMsMyM7vUqKCa2aalQ46H6ayO440tJvDcyL9Sb7kFg/ERevEFdxMk3EUfCTFloJFTyDD0lW2uaKl9Q==
X-Received: by 2002:a17:906:6a04:b0:78d:ee09:d956 with SMTP id qw4-20020a1709066a0400b0078dee09d956mr2772748ejc.698.1665563423143;
        Wed, 12 Oct 2022 01:30:23 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id x6-20020a1709064a8600b00787a6adab7csm845411eju.147.2022.10.12.01.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 01:30:22 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oiX89-004Eo7-1x;
        Wed, 12 Oct 2022 10:30:21 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com,
        phillip.wood123@gmail.com
Subject: Re: [PATCH v2 2/4] submodule: move status parsing into function
Date:   Wed, 12 Oct 2022 10:27:45 +0200
References: <https://lore.kernel.org/git/20220922232947.631309-1-calvinwan@google.com/>
 <20221011232604.839941-3-calvinwan@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221011232604.839941-3-calvinwan@google.com>
Message-ID: <221012.86zge1moki.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 11 2022, Calvin Wan wrote:

Just commenting on one case, but this is in other parts of the series
(e.g. your additions in submodule.c):

> +			BUG("invalid status --porcelain=2 line %s",
> +				buf);
> [...]
> -				BUG("invalid status --porcelain=2 line %s",
> -				    buf.buf);

Your editor's indentation settings need fixing. Arguments should align
with the opening "(", here you replaced 4 spaces with a "\t".

A "\t" is == 8 spaces for the purposes of our identation, if you need 7
spaces to align with the "7" you insert 7 spaces, if it's 8 a "\t", then
for one more a "\t" and one space etc.

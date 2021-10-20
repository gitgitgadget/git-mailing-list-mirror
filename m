Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96916C433EF
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 23:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 751F16103D
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 23:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhJTXnd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 19:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJTXnc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 19:43:32 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB88C06161C
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 16:41:17 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 5so1738084edw.7
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 16:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=XHvMVOAooqood3iGxqZWik2vejiJ611Y+VjJLGOd3rQ=;
        b=pFd/AktFNUU2erX7P2p34kNpMBb+8dxgrnggbzn4+bgyKV6qNs1IofReCjZf/hqT2U
         /EKzQLX8CECdaG0U+MX0Whj5OrdahHooz1zSdsh2nFE3NTpq/vz1Wve3PQ0M/yOrWDOS
         uN2YXFjPh4Hb50G787SNqCzL6yZ28e+LY5Dkc3QqsFa/OpW6Ws0V6vetQxTH1FjqzO63
         bBpQ0RJLhHlhjxJ2rPsyvrMUYZerhZcHPBHDwGoO8RsSGFHX0I2LJn9Z4SVog/2RV16W
         /dGiuRlNsV+uY5JcLdzKssUoHTZuN29YuwsSjdjKfM5VQpNyq2/O9Mkrui1rIXc0bK2K
         eTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=XHvMVOAooqood3iGxqZWik2vejiJ611Y+VjJLGOd3rQ=;
        b=1lR+cMj5w7CWBdWMKzUEy4aLb9aRP2aQxlOUJg5ftPKcInq/MbkFTYCQT4JeRZxDi9
         2/ybsJ3H4WtyEoti49bQY4l9LPNxJaT9pbM+l66cUI0UtHnrdzLQ8Ti6qPPN2Kl+DVgp
         LV6yAV6YNJNHhTPkdzTTz4Rvkp25mJlZI0xKCCKbQkN0g2btxc3LWesLugdY4yQw8+uz
         q/HwO3D/4b8og8o/m4gfVfUXTjOV/oBGXRpr9ml0HlFNScpwtcs94Am+jKdo1Id1udvq
         NEzqiBpD5iaUq33YrPuiL2eYAuPG8Qn56Mt4XyzbWQX2m7TcUtnGfJFF9BmWcnk8zbSv
         MdGg==
X-Gm-Message-State: AOAM533zF7DjfyINWwzajqEkMPD5AeQKD4qUxa+7KAAa5AQQ2/eQzatI
        2W3edsDJtN+c6uHKFAXENqvFsqJWyUtL1g==
X-Google-Smtp-Source: ABdhPJxXGppj/cvdgnsHK5yjiwkmZCyFT3hxtWRgE2HEQLK3ibaOsnN9SUldJMeGHiIVVifhGfTk2w==
X-Received: by 2002:a50:d885:: with SMTP id p5mr2732916edj.255.1634773276283;
        Wed, 20 Oct 2021 16:41:16 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id n23sm1895558edw.75.2021.10.20.16.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 16:41:15 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mdLCs-000uTs-Vy;
        Thu, 21 Oct 2021 01:41:14 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 4/4] doc: add a FAQ entry about syncing working trees
Date:   Thu, 21 Oct 2021 01:35:43 +0200
References: <20211020010624.675562-1-sandals@crustytoothpaste.net>
 <20211020010624.675562-5-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <20211020010624.675562-5-sandals@crustytoothpaste.net>
Message-ID: <211021.86r1cfmfhh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 20 2021, brian m. carlson wrote:

> +The recommended approach is to use `rsync -a --delete-after` (ideally with an
> +encrypted connection such as with `ssh`) on the root of repository.  You should
> +ensure several things when you do this:

What's the reason to recommend --delete-after in particular? I realize
that e.g. in the .git directory not using *A* delete option *will* cause
corruption, e.g. if you can leave behind stale loose refs with an
up-to-date pack-refs file.

But isn't that equally covered by --delete and --delete-before? I'm not
very well worsed in rsync, but aren't the two equivalent as far as the
end-state goes?

If the intention with --delete-after over --delete or --delete-before is
to somehow make the repository useful during the transfer, doesn't that
go against the later advice of:

> +* The repository is in a quiescent state for the duration of the transfer (that
> +	is, no operations of any sort are taking place on it, including background
> +	operations like `git gc`).

Also for this:

> +Be aware that even with these recommendations, syncing in this way is
> +potentially risky since it bypasses Git's normal integrity checking for
> +repositories, so having backups is advised.

Perhaps we should recommend running a "git gc" or other integrity check
after (or "git fsck"), although those don't cover some cases, e.g. the
pack-refs v.s. loose refs problem in the case of a missing
--delete-whatever.

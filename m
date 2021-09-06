Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAAAC433FE
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 06:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 442CD60FBF
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 06:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239502AbhIFHAj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 03:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238906AbhIFHAi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 03:00:38 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659DCC061575
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 23:59:34 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id lc21so11438046ejc.7
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 23:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=JE0o7KzdHNVUPC3VM2167Z8THQkog4sOZ6UwBmUlaSE=;
        b=o5TSQXgrSj8XOXk8uPqwak8LEcDflGDCUhximGpgplpoM3AJbxCZeXG2qjbfmx6OPW
         tGIaqfIIhG14yPEW4fWh1z6ctu8sASYimCfly7Rx8XhAR1RIId5+jQlsBnCZOIZL0XQT
         21vlySNrSiwCIQ26Ut++2ebZenjs6nNrko5P2nrSjBP3KSs2RLkyR0sx7JJi7yGa/tu0
         7mBVws5s1YrP4RE9whPmI7Sq5QPQa5MGT/hxAEcFbKjf/4pjmGmzYpaP1RkX+W6OB71S
         9wFfxxgkTCk62Ai8OgwMV92nfvSLdcy6PDJsbssF5sfFr9FHzYPHkVGSNdkEK8MMXtfm
         xCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=JE0o7KzdHNVUPC3VM2167Z8THQkog4sOZ6UwBmUlaSE=;
        b=Q3lS3p2YZrXIOaJkGAFue/+5SGxTjG7zfI4KjNR0LqFsen+/zyXS5GHjj6ge5IG0mJ
         Zx60jLuTAT4B0SAX8//v5IRlbv0BEHZROH/1F9OUT/X5E13tf9lWT/TvzvrcaoHNGUOR
         bg0pLvfnGyZNwVSFgMSj75Mb9rVd3yj94Mpfc2b4O05O+b+NhcV0lu2xSKd3cwgW7b1u
         0PzhxmgnhwaLvEcKsm7IIDjNWhV3kR1deZzrzUWEZtLs3bTedg5Pqy/Wzf5pFcVRjiB5
         vzGj7AR2yBqPXaqLrE4Ax+pb9VDLACHJjtbaiOlo10gjEI6nUahtwxK1ny/fiVAvLLGl
         3Dew==
X-Gm-Message-State: AOAM531jYXBSH7YgJ3i21S+FtpIsTU9lfnQgVHg49R7218mbNoRPVRDV
        HrChmXQ+R+RTcESBD8ZDi+8=
X-Google-Smtp-Source: ABdhPJzIB1U3M0FUvXL8zUTv927ezg+mlaX6NWm+9j/ajS8blizkjUanhIQSS83a7G6ifXAxDnhVZQ==
X-Received: by 2002:a17:906:9401:: with SMTP id q1mr12051694ejx.313.1630911572918;
        Sun, 05 Sep 2021 23:59:32 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id da16sm3991599edb.28.2021.09.05.23.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 23:59:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 0/7] Drop support for git rebase --preserve-merges
Date:   Mon, 06 Sep 2021 08:58:13 +0200
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
 <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
 <xmqqk0k0ndbq.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqk0k0ndbq.fsf@gitster.g>
Message-ID: <87y28anq98.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 01 2021, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
>> In 427c3bd28ab (rebase: deprecate --preserve-merges, 2019-03-11) (which was
>> included in v2.22.0), we officially deprecated the --preserve-merges
>> backend. Over two years later, it is time to drop that backend, and here is
>> a patch series that does just that.
>
> A good goal.  There is no remaining use case where (a fictitious and
> properly working version of) "--preserve-merges" option cannot be
> replaced by "--rebase-merges", is it?  I somehow had a feeling that
> the other Johannes (sorry if it weren't you, j6t) had cases that the
> former worked better, but perhaps I am mis-remembering things.

Fair enough. To be clear I think this series is fine as-is, we've just
usually done "now that this function is dead, rm it" as part of the
series that makes it dead, so I figured fixups/squashes to change those
parts would be welcome & integrated, likewise Alban Gruin's suggestions
in <62fbd389-28f5-76e5-d3f3-5510415a7bf5@gmail.com>.

But the git-sh-i18n.sh change and/or his suggestions can be done after
this lands...

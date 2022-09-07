Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870AFC38145
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 18:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiIGSMQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 14:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiIGSMK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 14:12:10 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536C3C0B55
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 11:12:09 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so8940068pjh.3
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 11:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date;
        bh=QLL5yn/J6DES0eVkCMJ6H4Gfy1vQYSjbfsLziNGOEi4=;
        b=NnTOn3yVa5UgXrWi0NNprMB6WNuEHeIH+0/kOLBtUG1HGkqsRrn/UJiAKYccP8u5FZ
         pgtqE2zi3ue+ywCpgloH0ktKO2osaEO0mS5GoJegueqN+mAHcm78444wa4sG6/9ZaVkH
         lwm8qJ7vdW/w6FbTxNyruGtBO9K2LvRZyFKrBgD7gupBKRWYIJ8pTLrDjxGuoVdPSTmK
         CTm0P3Xut3i/EELm9JYFyzwJOTFjbG2qIYxa6O2c9nAhOCxjq7zXiGofByRZiRmnPEVz
         3s6WoOi1LzmsODQpNwkjiyODRcC56f2yNiNnTqsJMpcvykhaqKKAPGIePAnQI9LBL+mx
         ZMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=QLL5yn/J6DES0eVkCMJ6H4Gfy1vQYSjbfsLziNGOEi4=;
        b=0h2mIg0E4fcUB8qAOwAjcGY0uTt0a5DAo2eGneFwaLooxWo6xfT72jdwL9yHHUyYi5
         prjXUoMG7O72Tz3LZyiRp1okDXR2M3IpbcLgjig+gOB0My9vBpZi7fNjvTPUZiBF3fo+
         vD/w0wSZYMlAXs+HfAe3yjyeUcGZCtAA/9V0GjKzM+DS4zsjHAGlnW6m8LreOC171AMv
         uFGNr3OEu6CfEOdeoqBYkAFEQEapjFlb6y14AaQIihLXDloeMJrT7v9qI3FdnqAPcLgs
         WjVu3QFRoxuUk3fOctnLs2G3U7b7fFtCwNcxmgyAvuNUtzoQ1cflIvPVwYtjL75P2K2c
         pt6Q==
X-Gm-Message-State: ACgBeo3gASyOhhjPM7G6ubMpHobDqWfDPFq0tt3sQia81lvZeU+HAAdS
        4EBzbba7yXPlBLWWEYKM0qU=
X-Google-Smtp-Source: AA6agR6ekwBMr/8gnSs9aNHSgcrpsuEBdcT/wFeBKggaa7NBfe7qKumKe6YhTSoJyZJuD/1/d3LdVw==
X-Received: by 2002:a17:902:b484:b0:170:a2d8:80f6 with SMTP id y4-20020a170902b48400b00170a2d880f6mr4938082plr.97.1662574328810;
        Wed, 07 Sep 2022 11:12:08 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 185-20020a6205c2000000b00537daf64e8esm12872932pff.188.2022.09.07.11.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 11:12:08 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 4/7] rebase: rename merge_base to branch_base
References: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
        <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
        <cca933a5f1d0d2ecbce807a91e379f974e70f6bf.1662561470.git.gitgitgadget@gmail.com>
Date:   Wed, 07 Sep 2022 11:12:08 -0700
Message-ID: <xmqqtu5juk93.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> merge_base is not a very descriptive name, the variable always holds
> the merge-base of 'branch' and 'onto' which is commit at the base of
> the branch being rebased so rename it to branch_base.

OK.  Thanks for making the code easier to follow.


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36721C47089
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 23:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbiLEXgr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 18:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbiLEXgA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 18:36:00 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6712620F4A
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 15:35:23 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id c13so5827019pfp.5
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 15:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MZzdhNLa8jg7eBnobwRMDNrjELgz1siftQMiXYbrv8k=;
        b=ZMQBrANPsfF3zKivSIeySONyek3ypyyy5ABXhGGM4zb+84EoqFTyNGv1yaKCNjRXxo
         S1chLlAS+GdLwWkyWpmWfgjjjvEDh7XUsqSfoksnB2eiOQ/ZAxZV52JEA2/lTSpRsLAi
         J35zLZ94sGHy5kzUjRurqTSIlyuoawO2ibu6PQl5pN84HB7yJRcnaWZAdVEQnpG3kuuo
         HM07h3DxpI+y0hwe2oqExsLmENLkDwmQ4+NikhBNezsfj52+5u7oVCH4uH/Mm3skp8Op
         pn7P3nD0nMpVS4LjDRZ7xDzA1XcSTLxe3OIQHQTrbeH8w2XYB10MutFBE5Trj/xjzjJA
         +11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MZzdhNLa8jg7eBnobwRMDNrjELgz1siftQMiXYbrv8k=;
        b=eZ3b7L9TPOiwJ5k7djhYilEYM1/cORJpf2qx18S0l+ar56h8uXqUFNBSa2SgXOIj5/
         SU5Zcuvl+W4HWg8oRGIN5/0oxWUqrQ+C7sUKsML8PJhC9Y0WahAr7cnfQIJUbAm7uHFO
         gqFtyP7wSXW7z4Wd9sEbl3LLFozfADGc1K3clvJHOf2fC72vzcG2WTlSm0nGdtoXJ+Ep
         ScaQybv7A4YpH3CeBc8Y3sBuZy+vi72HsNyYBS1DAUbq8/BYRNuyCwc0HtSdMZDYHH9d
         NieaYlm2RSEyq7MF+y38CjQNbeksvfKp9xjofuhKFR9V9scmyezRr07QMF7+QpUkNM+m
         zrdw==
X-Gm-Message-State: ANoB5pmwzwK/EBtB3LL8NawaVquKDQOhjBKcrff42WkI/EhaLak0Yb76
        URNjez68EyTveVcMgV6yhKTWzcD+aAsAWg==
X-Google-Smtp-Source: AA0mqf4dbwJZEWeAhReDcF48MzfD9LbiFRYt2dRV0ekyAw6Nok0JGZkAvdaXKtsKRBzp39hJmCTsiQ==
X-Received: by 2002:a63:1466:0:b0:476:cac7:16ad with SMTP id 38-20020a631466000000b00476cac716admr59590618pgu.128.1670283322589;
        Mon, 05 Dec 2022 15:35:22 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id k85-20020a628458000000b0057725613627sm1131721pfd.142.2022.12.05.15.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 15:35:22 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, --cc=avarab@gmail.com,
        tenglong.tl@alibaba-inc.com, me@ttaylorr.com
Subject: Re: [RFC PATCH 0/1] push: introduce '--heads' option
References: <20221205133525.60464-1-tenglong.tl@alibaba-inc.com>
Date:   Tue, 06 Dec 2022 08:35:21 +0900
In-Reply-To: <20221205133525.60464-1-tenglong.tl@alibaba-inc.com> (Teng Long's
        message of "Mon, 5 Dec 2022 21:35:24 +0800")
Message-ID: <xmqqilippgp2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> From: Teng Long <dyroneteng@gmail.com>
>
> This RFC patch try to introduce a new option '--heads' in 'git-push' subcmd. The
> value of this patch may come from my personal point of view, and the patch might
> not have enough tests so far. It's pleasure to hear any suggestion, test
> scenario which need to be covered or any test method which need to be noticed if
> it's worthy.

My knee-jerk reaction is to avoid "--heads" and instead use
"--branches", if this is about pushing all local branches.  The
option "--heads" may still remain in some commands added to the
system in the earliest part of our history, but soon we started
to use "branch" over "head", as it is a more commonly used word.

How should it interact with --follow-tags?  Just as if you listed
all local branch names on the command line?  I.e. is

    git push $URL --heads

equivalent to the long-hand

    git push $URL $(git for-each-ref --format='%(refname)' refs/heads/\*)

and because of that, does

    git push $URL --any --other --option --heads

behave identically to the long-hand with these other options added?

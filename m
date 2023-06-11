Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5139C77B7A
	for <git@archiver.kernel.org>; Sun, 11 Jun 2023 21:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbjFKVXx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jun 2023 17:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjFKVXw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2023 17:23:52 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A81CA
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 14:23:51 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30fbf253dc7so367183f8f.0
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 14:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686518630; x=1689110630;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wVk6KHY1tnlh19daW11Nbv+g4tP2FK80qp12dfFdaQ=;
        b=B8zpQRtTb361SKyD9tEowG1rFsiJrItw3sKUbCUXMNRtlpP5TmG2ukAT9rPad7iaEd
         KiQgszQICeA8/y+yfgwbDImqeyTAx6l8Ut428hPjw+dwVPHExgc5aZ8ik6L6KVxKOYS4
         CRtNDqYg8e+hQGh7f9I6fk6um29p/sflLPBXeDUMrkdOR3tznQZf4+mqU7vVuSUYkaKf
         c5Rq6oIWsqXvcDrUbTVIzV5rJkt1Pla/trODvMTLQJT5hdEMSIquuGZcLdBZiUUsDBD2
         Q1TknEi1SLfKDTkris0cBJqkbMdsrw1WBH3clpXkCxhm5fIlp4KlSb3+prgPddMiCYVq
         3wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686518630; x=1689110630;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0wVk6KHY1tnlh19daW11Nbv+g4tP2FK80qp12dfFdaQ=;
        b=hH0igeDcaM53NdY36fhXBoaHnj6ECrif6pDs0x30KR8U9amZDkm30xj1r3Zr3vwvRY
         elX+gPEajZLDHMeSplzK2qLVxRzXl+Ej2Aeiq62ti9Ar6YxS9dQbgQbRXBTI4srNs71q
         Q2ffG0ug42OEXRMmddvgwwnIeF/Q0qNcr09gkUhW9OPybGAGUFPgwSBlAXu7xDu53EY4
         g9CvSwc0YwKgfHcLgjayKrWzR5rLz42t4csAbSQUzNxAISORIvH8hdLp+iaSDfHcagO9
         zxoA4ltTLIozt7UK+BPM/P0Amtwmfl9Cn1pq+olBCPNu8VoDaKRDexZ/XhSJw2ewLlug
         YvRA==
X-Gm-Message-State: AC+VfDzXT/FyaWMzL+SxnVVJxmCt4gxY6zLMczEjUSXcElT62UY4g68x
        hQkJCN6IwafleDxAqYAEeNLh/MkrbSk=
X-Google-Smtp-Source: ACHHUZ5KjeGzSxBf3WbhMg70HrJzbVr+4m04aI0Qx3CzAIU1ChbCoPZ48dDT6MHjPU+IRDqWEopPXQ==
X-Received: by 2002:adf:f788:0:b0:30f:bc9a:d8e2 with SMTP id q8-20020adff788000000b0030fbc9ad8e2mr1590269wrp.15.1686518630005;
        Sun, 11 Jun 2023 14:23:50 -0700 (PDT)
Received: from [192.168.2.52] (151.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.151])
        by smtp.gmail.com with ESMTPSA id m1-20020a5d4a01000000b003062ad45243sm10602398wrq.14.2023.06.11.14.23.49
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 14:23:49 -0700 (PDT)
Subject: Re: tests: mark as passing with SANITIZE=leak
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
Message-ID: <72cc21d8-1684-2bae-09a1-de647f49c293@gmail.com>
Date:   Sun, 11 Jun 2023 23:23:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11-jun-2023 20:29:09, Rubén Justo wrote:

Sorry.  This should have been:

[PATCH 00/11] tests: mark as passing with SANITIZE=leak

I'll resend with the correct subject, but will wait some time for
reviews.
 
> The goal in this series is to pass t3200 with SANITIZE=leak.
> 
> As a result of the fixes, other tests also pass.
> 
> This is the list of tests that no longer trigger any leak after this
> series:
> 
>    + t1507-rev-parse-upstream.sh
>    + t1508-at-combinations.sh
>    + t1514-rev-parse-push.sh
>    + t2027-checkout-track.sh
>    + t3200-branch.sh
>    + t3204-branch-name-interpretation.sh
>    + t5404-tracking-branches.sh
>    + t5517-push-mirror.sh
>    + t5525-fetch-tagopt.sh
>    + t6040-tracking-info.sh
>    + t7508-status.sh
> 
> Each of the commits (except 11/11) fixes a leak.  They have no
> dependencies on each other.  As a result, they can be reordered.
> 
> To review one leak, the commit can be moved to the tip or reverted.
> E.g. to review: "branch: fix a leak in check_tracking_branch", this can
> be used:
> 
>   $ git revert --no-edit HEAD~3
>   $ make SANITIZE=leak test T=t3200-branch.sh 
> 
> Also, each commit have a minimal script in the message that can be used
> to reproduce the leak.
> 
> Rubén Justo (11):
>   rev-parse: fix a leak with --abbrev-ref
>   config: fix a leak in git_config_copy_or_rename_section_in_file
>   remote: fix a leak in query_matches_negative_refspec
>   branch: fix a leak in dwim_and_setup_tracking
>   branch: fix a leak in setup_tracking
>   branch: fix a leak in cmd_branch
>   branch: fix a leak in inherit_tracking
>   branch: fix a leak in check_tracking_branch
>   branch: fix a leak in setup_tracking
>   config: fix a leak in git_config_copy_or_rename_section_in_file
>   tests: mark as passing with SANITIZE=leak
> 
>  branch.c                              | 14 +++++++++-----
>  builtin/branch.c                      |  2 +-
>  builtin/rev-parse.c                   |  7 +++++--
>  config.c                              |  2 ++
>  remote.c                              |  2 +-
>  t/t1507-rev-parse-upstream.sh         |  1 +
>  t/t1508-at-combinations.sh            |  1 +
>  t/t1514-rev-parse-push.sh             |  1 +
>  t/t2027-checkout-track.sh             |  1 +
>  t/t3200-branch.sh                     |  1 +
>  t/t3204-branch-name-interpretation.sh |  1 +
>  t/t5404-tracking-branches.sh          |  1 +
>  t/t5517-push-mirror.sh                |  1 +
>  t/t5525-fetch-tagopt.sh               |  1 +
>  t/t6040-tracking-info.sh              |  1 +
>  t/t7508-status.sh                     |  1 +
>  16 files changed, 29 insertions(+), 9 deletions(-)
> 
> -- 
> 2.40.1

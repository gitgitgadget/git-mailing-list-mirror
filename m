Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBEEC433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 12:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7E186054E
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 12:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbhJZMUT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 08:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhJZMUT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 08:20:19 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C11C061745
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 05:17:55 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i9so3028102wrc.3
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 05:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=sz+Iv4AQLOLDbO7+Po31DiRXSRADIsQknWVrFtsEqdE=;
        b=HDWLcaIwFuElufMMRcJwIv6uox8OJbrcX35BsbcMJ5YkUcbwlIPTG/26DYkYhMhfNH
         F3NHAZnxEPtNEZRtLunV4zQqdT5fnT/FoxR3oi3NGs59sQcCmHbFSjxyM4KSmRc/HPnJ
         S3BoqA0jcyuRqSFnHxOIkWO/OhadQoW+rDI25gLlRJ5P/+gH19jNSnpBuZm0azNPfDoD
         V2L94IZ+EtDCIu/XKFUX/cjul/ukZxLwdzxQKN5qW4XMxMDl8Z7TxQdxIr32ZhHriyi9
         lIM2ZwStNltOxl4lhKzckrLdJpW5gav0GBKbMTtxvtz7tKRcmfYGhF0N/tipGEIefdWo
         /OMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=sz+Iv4AQLOLDbO7+Po31DiRXSRADIsQknWVrFtsEqdE=;
        b=p5NyuEFFbEn+zw/ZoIzz+YXrjieq0vJQ4jhqWYPcmz5H8Dob1S8hU5v75PM6g+Mmpp
         rZVmXL5tKMc4hDmpC4XMlAFdjC91D0rnc2dq0nZxqsxZw1BTdGCX53SpptFMD/476eY9
         MUoAhFJilPg+pDdjrzlolIx4M2YaKPSPuaHZtIpeX2LXzdnsZ3kdoLiXvIAPcpJEoBWx
         Ne/wmo2sV+9t2L6JFwrG3sYom6SzJzNof/9406tIIACchweWxjuDKpBK6w++oI2ZsoU4
         Z+f26XK2aXl1ikQ/Op/ZEEVEb31Qg3yiShU1QPPVn5hjF1eEq9lVwa3U31pXZiS/cw+G
         Y2aQ==
X-Gm-Message-State: AOAM530DCb5FvSve+C3G8bCMuu/5pqs16clHI+KXlvOCRzfoZiI/hCFt
        ZSgpKyFK0Ta3qulWulu7qbyIIZ+wW1XpGA==
X-Google-Smtp-Source: ABdhPJyb6O+U6lhMGllzhoQRMcIUb4ikJ+c1LWly/84XWsjzub4wdH4LvSTi17aW6ULRlorZWj7Evw==
X-Received: by 2002:adf:ec03:: with SMTP id x3mr24724628wrn.281.1635250673928;
        Tue, 26 Oct 2021 05:17:53 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l2sm455059wms.40.2021.10.26.05.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 05:17:53 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mfLOr-001o34-0c;
        Tue, 26 Oct 2021 14:17:53 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: jc/branch-copy-doc (was: What's cooking in git.git (Oct 2021, #06;
 Mon, 25))
Date:   Tue, 26 Oct 2021 14:17:14 +0200
References: <xmqq5ytkzbt7.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <xmqq5ytkzbt7.fsf@gitster.g>
Message-ID: <211026.86pmrsyo7j.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 25 2021, Junio C Hamano wrote:

> * jc/branch-copy-doc (2021-10-23) 1 commit
>  - branch (doc): -m/-c copies config and reflog
>
>  "git branch -c/-m new old" was not described to copy config, which
>  has been corrected.
>
>  Will merge to 'next'?

Looks correct & a good fix, thanks for clarifying that.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEA7C4320E
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 01:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85F1A60F5B
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 01:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbhH1BYf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 21:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhH1BYb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 21:24:31 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D833FC0613D9
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 18:23:41 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x27so18098064lfu.5
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 18:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vBL2BK3BnjvwcsLCuQps6GWGIVeb/nrzluWDHVaKPzY=;
        b=KEXyg9aWj4XmZOpwB+3qLPk4XYFm5Cc9qm5iVPD30hj5bifB5i55bcYTYVImVO2yxX
         GkGvSDz8ctF0c+K+pykh32134ruptCHJGz0kIJWdqaU+bxpW0Jh5rBzeceOObxA4pP9E
         HEaBsTv2SsnjuLf23RdNvoDatYFE17sQBHbE/FOKwujyI3uRIXmYG51rVksJRa8V4UcK
         o5VFyz0EtR6O3CuvAjBQpTRXXr3vcQNlygUATdl2CuTpNX33ndLSLPKlMZKXINHxUsYu
         hSdApVh1Hu1TYcObq0pLSqQ2ll9bS6DT8J0jSqHrrZKmO+0RDeWBHWbNgHyWV87TTMh7
         Kg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vBL2BK3BnjvwcsLCuQps6GWGIVeb/nrzluWDHVaKPzY=;
        b=h5XdMPrLiOozQXsvUEVu9t3qd3T4b1awCxaI8NLEW+dXWBRyzYUDbBqfj97aPlpDQX
         O+N7qAZVtzYwgrtoo4K5l161pABSZXdtP9XqxiIJOTVtuG+n4WFp/W7BSk9A5+oCg2hB
         Y7n2sBJtiaTClm20KsisZb7Ces/q1eGzYfz0zKDRLR6WytSb3Hhg1pfj8FbYYzTYNivw
         54UfQl/xRTgJabnLtqGkruoTTWnlSlU6zxO4b+yGjhkr1HuQF3LlzV2BSJ+C6YBJMzV7
         dpjALIpMvYYtL38BHdYBU8gmYTkE0aY1Bt+qg66V/JP6rW2UKeLlIqIsocOJbUvucE7b
         V/sg==
X-Gm-Message-State: AOAM530hqOE9YmzhVI3pXfDfE+d+lEb8l/NIv3hjLiH7A39RYYJMvbrL
        mBtbqXp2IZd6WrGBYkh69qFTpdUfZH0rGdA+iZWP+Dfs
X-Google-Smtp-Source: ABdhPJxFMk0yqj8S17HknfXEbF8Rgy54FwYVBRoxVsI76HRmdphAazR8ggYY4C1ASubhUboExrPT95ZnLnjLTuRwYmk=
X-Received: by 2002:a05:6512:22c6:: with SMTP id g6mr8680382lfu.569.1630113820290;
 Fri, 27 Aug 2021 18:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <CALH-JHvNHVvPWap8eiMaQ6HAJOBa4W5xuA9V_s7zPLubgwaRow@mail.gmail.com>
 <CALH-JHvKjK7KU+Z_R7kG291DQKyb3f=LwxcbP4fn-qL2eeosBQ@mail.gmail.com> <5a70d535-47b0-a4ea-b4e4-572a1bcfe997@gmail.com>
In-Reply-To: <5a70d535-47b0-a4ea-b4e4-572a1bcfe997@gmail.com>
From:   Bryce Glover <randomdsdevel@gmail.com>
Date:   Fri, 27 Aug 2021 21:23:04 -0400
Message-ID: <CALH-JHuTvAKtBwYaxAs8Z6Xdw5RBY4JZ-d9srq3Q_MxBCSnh6A@mail.gmail.com>
Subject: Re: Automatically Handling Using/Checking Out Branches With One or
 More Different Contained Submodules?
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Mr. Blain,

     Yes, that does help.  Thank you very much for the extensive reply
and detailed explanation!

Much appreciated,
     Bryce Glover
     RandomDSdevel@gmail.com

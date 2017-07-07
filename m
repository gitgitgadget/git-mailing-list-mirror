Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36C0E202AE
	for <e@80x24.org>; Fri,  7 Jul 2017 06:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751659AbdGGGAT (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 02:00:19 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35358 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbdGGGAS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 02:00:18 -0400
Received: by mail-pf0-f193.google.com with SMTP id q85so3203580pfq.2
        for <git@vger.kernel.org>; Thu, 06 Jul 2017 23:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zve6Kp8y3lWMPw8q/gOwN6h3Lp4zTPI8y5JG/AWh6LI=;
        b=JOr3bcwAmY2dC0RjYkSgfIsLTduiKyOcjxZiHKlZosYl3FYFPUjpUM33na+cH/C1/9
         nk8lif37sPSlrAMQhz55xjKdBeuk5GTv7O2Qo4IQOgGn7M3Lf692tcsOYmpJ7is14v4I
         Lk+5lPtFu0rFWW+dlWQUIt/Yoou2sGaVAUYx/RKIgtskZFNrEkLeESBztx4J51S2p7oL
         nmkLmFooen6DKe/v7JfgqziSy6MclHJznPSpd9oE+ZG0fD/plHCbtXw+7M6haKf7b9t9
         uKxvguDCc58dZeHv57dR9IB+WDAg0CVLexsi8/+6FEURFM6s6oHohFsPbp4Yq+BuKSuo
         xJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zve6Kp8y3lWMPw8q/gOwN6h3Lp4zTPI8y5JG/AWh6LI=;
        b=RBcia25q/hsqyayiMebOC591pJdA5cd3GwZov2BYggOErJUTUNYDdNNh1W+fJPxjBo
         WPx+vXQKSmJaMffVC4jcha8V9Ocgb82RZN8w+It+37rZA/Jcszv17+zqT4i93l0uPere
         N9BRyc/2IoSPjHJSOb8BWirgZdHMtOKBdInA1Lu9+ZYQVYT4fQiSgJ3ZefRj3Yz2iCfj
         eO6Caas26BjpKinQ5i5f/TkbF6Vfv+Lealwsfx6mUXynQwsQ4nVOtGDUIUiwNsXQgrFZ
         BXSvp6phVHFY7DSiGlDOLtB65MT952mg6OaQKA+WbnHjVU48ypX05DDsPDojBYEeWldY
         2acg==
X-Gm-Message-State: AIVw113TFR8peZvE6N0piTKmmE/NdiNCd9NLNmFZiCB2O37wlEp1ptuW
        PHOD4yf0QRIPOg==
X-Received: by 10.98.60.5 with SMTP id j5mr29779358pfa.56.1499407217856;
        Thu, 06 Jul 2017 23:00:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f878:6796:f790:dc38])
        by smtp.gmail.com with ESMTPSA id 10sm3609945pfj.61.2017.07.06.23.00.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 06 Jul 2017 23:00:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org,
        Sahil Dua <sahildua2305@gmail.com>
Subject: Re: [PATCH 2/6] t1414: document some reflog-walk oddities
References: <20170705075508.c5ul23vivzpklpy6@sigill.intra.peff.net>
        <20170705080036.qxzy7havcy72mvff@sigill.intra.peff.net>
        <xmqqh8yqix7p.fsf@gitster.mtv.corp.google.com>
        <20170705212757.3ygxiasbi2e7v27p@sigill.intra.peff.net>
        <xmqqa84ih5ao.fsf@gitster.mtv.corp.google.com>
        <20170706071606.doxirwm6cqx3duzg@sigill.intra.peff.net>
        <xmqq1spth8qy.fsf@gitster.mtv.corp.google.com>
        <20170707051954.rpej3taew6onv3oo@sigill.intra.peff.net>
Date:   Thu, 06 Jul 2017 23:00:13 -0700
In-Reply-To: <20170707051954.rpej3taew6onv3oo@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 7 Jul 2017 01:19:54 -0400")
Message-ID: <xmqq37a8eqhe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I suspect that "--since 3.days" is still quite buggy (even with a single
> reflog) because it checks commit timestamps and stops traversing when we
> go too bar back. But in a reflog, the commits may be totally out of
> order. I'm not sure what it should do. Either:
>
>   1. During a reflog walk, --since and --until should respect reflog
>      timestamps instead of commit timestamps. You can already do
>      "--until" there by simply starting the traversal later, but there's
>      no way to cut it off with --since.
>
>   2. Limit commits shown by --since/--until as usual, but skip the "stop
>      traversing" optimization when we see too many "old" commits. I.e.,
>      omit a 4.days.ago commit, but keep walking to find other recent
>      commits.

I think 1. is more logical, and I was imagining that it should be
doable, now we are not constrained by (ab)using the commit_list with
the fake-parent thing, but are pulling the entries directly from the
reflog iterator and the timestamp would be already available to the
iterator.

But I recall that the max_age and min_age cutoff is done long after
a commit is pulled out of the "iterator mechanism" (be it the
commit_list or your direct reflog iterator) by comparing
commit->date with the cut-off, so it may be a bit more involved to
arrange than I imagined X-<.  Hmph...



Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D87331FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 17:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752520AbdFMRGA (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 13:06:00 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35273 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751802AbdFMRF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 13:05:59 -0400
Received: by mail-pf0-f193.google.com with SMTP id s66so8024158pfs.2
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 10:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XCYEc37c2qyu2hbjLrToegjlrjUkauxDuJjSw3doEbU=;
        b=PBUm84z911sLHBb/5kpHXrE3emw9lJQRTqhUNmzn7rKd4mhr51H4q2R3EparCPHqIk
         /CcwDKf+nclXc9i/zrBOsPERuLjdldEDZj2hH0ev5DF+7Rw7vZ2tJJ0A8PaPbOUFLeKc
         AncchHnXsaZQLX+GMv+Glqrq6uua/6J7q+xflvulVkGdDhkLnpyYdC/+K/TsdD/L91VJ
         Y5GXUhN+YYEsINSCmDaRyGzvTMBhrcmd8WNOhZTYac11OdILBM9mcMvaDENXXzH8Kgq9
         X8E3BNwXmeYfnik2Enl1ZI1xphP5qhl2VR/caw56T/32LvLb02BCyiHY1TQFfGEqLh/9
         ADiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=XCYEc37c2qyu2hbjLrToegjlrjUkauxDuJjSw3doEbU=;
        b=VMiRhiQdSCtfOVzC072skYmtmoLQ6hBFcttf60snPlwOQEKVTBNAmG5V2aVsL8Oi5z
         wfqQXqbFiixMBbv0x4lxcmR6/Fa5bO7HDZrwUsyQ7izAv1Cxcj/NedxxgqMlSL/Vnfim
         VsfeoqhXzXI0a5yfT1iTQcCw2tDZGYCvdP/op4WyRnXNv+jT6N6FilveFvpShCM6sVUC
         RCqnoiMMgMy9LnZV/NJR9gSzHpjwRLiRjCvJrnnRuEveHmRQ2Otwhb1y3V7aafPOlQ83
         PNKaXCwfVHjSFmN7ZLDvnadHGil26W6+NhQVyIRk5gDcX8ka08RUKylsEiaCGtSQjEsP
         g0pw==
X-Gm-Message-State: AKS2vOynUWq1/dt4JvpLV5RkzK2p3EQB5uQjCu0gw7/edy/lEehRhv+l
        fajHTbIUOJbu6g==
X-Received: by 10.101.83.138 with SMTP id x10mr566676pgq.205.1497373558726;
        Tue, 13 Jun 2017 10:05:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b4c1:e9f6:bf2b:dcec])
        by smtp.gmail.com with ESMTPSA id o8sm24159268pgn.52.2017.06.13.10.05.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 10:05:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sahil Dua <sahildua2305@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] branch: add a --copy (-c) option to go with --move (-m)
References: <0102015ca23f0488-7423db93-b65f-4214-8221-af6a1bb4c2e5-000000@eu-west-1.amazonses.com>
        <0102015ca23f054b-b7c281d9-c9e0-4691-bfa9-8c46fb77dfc7-000000@eu-west-1.amazonses.com>
Date:   Tue, 13 Jun 2017 10:05:56 -0700
In-Reply-To: <0102015ca23f054b-b7c281d9-c9e0-4691-bfa9-8c46fb77dfc7-000000@eu-west-1.amazonses.com>
        (Sahil Dua's message of "Tue, 13 Jun 2017 16:17:38 +0000")
Message-ID: <xmqq60fz95sb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sahil Dua <sahildua2305@gmail.com> writes:

> Add the ability to --copy a branch and its reflog and configuration,
> this uses the same underlying machinery as the --move (-m) option
> except the reflog and configuration is copied instead of being moved.
>
> This is useful for e.g. copying a topic branch to a new version,
> e.g. work to work-2 after submitting the work topic to the list, while
> preserving all the tracking info and other configuration that goes
> with the branch, and unlike --move keeping the other already-submitted
> branch around for reference.
>
> Like --move, when the source branch is the currently checked out
> branch the HEAD is moved to the destination branch. In the case of
> --move we don't really have a choice (other than remaining on a
> detached HEAD), but it makes sense to do the same for --copy.

I strongly disagree with this "it makes sense to do the same".  It
would equally (if not more) make sense to keep the HEAD pointing at
the same.

Personally, I may use this feature if it didn't move HEAD, but I
wouldn't if HEAD gets moved.  But that may be just me.


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02C5E1F404
	for <e@80x24.org>; Mon,  5 Mar 2018 18:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbeCESuc (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 13:50:32 -0500
Received: from mail-wr0-f178.google.com ([209.85.128.178]:39766 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751462AbeCESub (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 13:50:31 -0500
Received: by mail-wr0-f178.google.com with SMTP id w77so18397640wrc.6
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 10:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Ia4LGqPArXV1WAkS/i880NYBEzEpPvSMBRCohqYzTIQ=;
        b=ZkZZupWPuShaDrMinAAtZBWHNcQfTARaqxiZLWkCWaSBytCBWwgirtp3JI+AeJtsWT
         Wew/9rhnMS0NKf10uEqFOV3XczxfZwtxO0p4XTTGnvmeMPR+6/TcAtXFtXZN5+HuG7rR
         Gi782lJ+mFlQYSuKItrGGOH1yVoXLq8JDF8TTbZhe6nAsnsySS4gv9TbiqH7KLd2ATbB
         ZYU9koOtT6iWPzFSglwoG3gYLMHl4ImKBVZ09oeVo1CtVWakiAZvPGykPDwKF6P8YVFz
         rChSz7hoNCpyRER6o6sx8RTd34BZIQdoAGCwHMOzhF9QIWm6FgPEYFA7f/nZtdhE09RQ
         y45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Ia4LGqPArXV1WAkS/i880NYBEzEpPvSMBRCohqYzTIQ=;
        b=J6p8Ao/JjEu2jq7m1vP7riMRwyMgnwuhELeuthGo/MYD10h6bcSmnWQWdUU1Wgk304
         lBx5Yyb21lgLMpHqY5j48SiHvPzxxObpcdJNam09kwG4l/OYYewvxQL3klqQOpk4x2RP
         bvchTtMUOGBmVCILLp8MqQMaPvEGABsnjVkplEpGoTDc1PB6+haj4R6ZOr2pDDXSuACb
         iQwi/1EgFuVPG5AtS4DYdIyTsbylBHRgjk+JyA4U3vwlE5eqSozweQPDpUjWsirZr8Qv
         scs2My4C9kGyzmvR0FjUxERJlHA1ODo/lvyLhg26+kySTg39lWQ1eZh39Ld4imXyYCNi
         Muzg==
X-Gm-Message-State: AElRT7HULeNW2ds2QnDJOo0rZqjArPo+C+tovpVN2n3RCwW1Sik6YtYG
        f1Ynsu81pPl0iJA7rZSDw40IP1UD
X-Google-Smtp-Source: AG47ELuBKy0ldO5GVvMU/o7fc4lhrYGiSo9SmBP6JEgNZsDbDISaEUt/sH5qoB4jVJqM4avyeZFikg==
X-Received: by 10.223.186.140 with SMTP id p12mr10586535wrg.162.1520275829634;
        Mon, 05 Mar 2018 10:50:29 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r71sm10893502wmd.48.2018.03.05.10.50.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Mar 2018 10:50:29 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v5 0/9] Correct offsets of hunks when one is skipped
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
        <20180305105630.14407-1-phillip.wood@talktalk.net>
Date:   Mon, 05 Mar 2018 10:50:28 -0800
In-Reply-To: <20180305105630.14407-1-phillip.wood@talktalk.net> (Phillip
        Wood's message of "Mon, 5 Mar 2018 10:56:21 +0000")
Message-ID: <xmqqbmg29x1n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> I've updated these to clean up the perl style in response to Junio's
> comments on v4.

I've considered the use of "apply --recount" in this script (eh,
rather, the existence of that option in "apply" command itself ;-))
a bug that need to be eventually fixed for a long time, so the copy
of earlier rounds I've been carrying in my tree were forked from
'maint'.

I'll queue this round on the same base commit as before to replace;
I _think_ this is ready for 'next'.

Thanks for working on this.

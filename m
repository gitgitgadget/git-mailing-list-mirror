Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 948AA1F597
	for <e@80x24.org>; Fri, 20 Jul 2018 21:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbeGTWDK (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 18:03:10 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:38457 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728125AbeGTWDK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 18:03:10 -0400
Received: by mail-wr1-f47.google.com with SMTP id v14-v6so12430918wro.5
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 14:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=z2XAZKqYryHf6l563lZfROkpuljYB+dkmd6ngEBur4Q=;
        b=XRnl0d0E97lDCCpzpe6Vg5egXhcXklK2fr2LCNIwbd1BlTmQYU1vrIrWPgt2xnrA0z
         BErej9qNB5YNAuEyubm7NmSX2rzKa32MuzjzVTfekqYghlAcV8ujPo2iaMiZ26YORW9X
         J5z4fNeiiTbIJaDZs2M50th0ClfkJwfyNGVJ2e88rrAAalQRdIeMETO/0IuddgyyZDjJ
         mlZ6z/U+H5iP64mHMY0X6VZCOKqRV3/E7tjMxoUhjddU7oQMDPyLxXNn7EOM9r14pYmQ
         eXg4VrTTgU8Z8RrVcM12tFC7cjLYo1dD6SuuFrqx9JLK7ERpaHgSrpleTNVyROA4Ei7k
         Cclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=z2XAZKqYryHf6l563lZfROkpuljYB+dkmd6ngEBur4Q=;
        b=PfWhfZXDzM4jWou2EE5z/ksXmS3zEgmD/c0KoqnFxxy2yHIE0eYnf9lCwDo8//2tZy
         Zb7lYf8FbmxmAw80DzcTxF6Xz8ORSLbq5mRBJ7GwL2vhx87LiH0WVGzMgrWF+z3hpNW8
         FzjLQn5HXaqm5NIR/+nHzwgM0G1r0O8U+wYPTOqLi1F+qeEk5sv6wdWDMudGrggdwDFs
         6tcmIt+QwinyWFfAEoWFgMpUBRcac9Y8zHmK6mk6m3Xmd54ii10xjC17SC27zoRCgjb2
         fsYfyv6D9dBrG3Yz8EV7WpyaPAk/PYOrVpPyiClYleF/7sdSHNi9KRq5iRcMrbuhXp54
         ycVQ==
X-Gm-Message-State: AOUpUlGR3gxrzAftpA2u4EVf4Z6w8nn6XEYOfqzsZUN1m/a9afcViBYl
        yd4Ytav7904NobieBy4NGu4=
X-Google-Smtp-Source: AAOMgpd2DXTKGU1WIXeGuWpipmh5yz8wP1izY9DPmruoWPWbRRJxSG7sn0pDjNs8zgg5tHChYDDx5A==
X-Received: by 2002:adf:e90c:: with SMTP id f12-v6mr2496355wrm.126.1532121187571;
        Fri, 20 Jul 2018 14:13:07 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w9-v6sm3490634wrk.28.2018.07.20.14.13.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 14:13:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Kevin Willford <kewillf@microsoft.com>,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [BUG] merge-recursive overly aggressive when skipping updating the working tree
References: <5a8d1098-b4c5-64e1-da98-dac13521e7ba@gmail.com>
        <CABPp-BF+Vx8YT2KAJQ+szbkYExv-_o5E-ZkywgvzsHWR0QvVEg@mail.gmail.com>
Date:   Fri, 20 Jul 2018 14:13:06 -0700
In-Reply-To: <CABPp-BF+Vx8YT2KAJQ+szbkYExv-_o5E-ZkywgvzsHWR0QvVEg@mail.gmail.com>
        (Elijah Newren's message of "Fri, 20 Jul 2018 13:48:37 -0700")
Message-ID: <xmqqsh4da9wd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> But that brings up another interesting question.  What if a merge
> *does* modify a file for which you have skip-worktree set?
> Previously, it'd clear the bit and write the file to the working tree,
> but that was by no means an explicit decision;

At least in my mind, the "skip worktree" aka sparse checkout has
always been "best effort" in that if Git needs to materialize a
working tree file in order to carry out some operation (e.g. a merge
needs conflict resolution, hence we need to give a working tree file
with conflict markers to the end user) Git is free to do so.

Isn't that what happens currently?

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68A7F207E4
	for <e@80x24.org>; Wed, 26 Apr 2017 01:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1434265AbdDZB0M (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 21:26:12 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36096 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1434262AbdDZB0L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 21:26:11 -0400
Received: by mail-pf0-f195.google.com with SMTP id v14so12161798pfd.3
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 18:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=s4zP0/HDYQChk8qwknn7tuHgtDhZG1Gi4WBbb18F5Ag=;
        b=nT/FkthUhLYG+6Oh7xv1UHaVmO+GBvR2fg/KgZAOM3lqC19kquBiUsa8PHDtjJNfju
         naorEe6WpfRF+pgMutKxD04ujCnSQtIRcGik8XMpDTJ+CTGoTMpUyG2mIa9yhSuQG8O7
         mWOR56Cieikmv7dkzYsdfhSlyyH/t5QaJrYixirTceJOgEoVvqqE69xuCNzp1XybLJ74
         FdM+7NXGNPfMbQeGW6HYGW7s7qd/ahRU1cIuGyFjRUbwmh6FuQtHEW++Uaig1dN6WJB4
         Gj4JQ2IDVl1knpooK/fazqoFZZexfkxV6uCnnP5T32mwZMXIUDxAN9OfmbK6Fj9pTPZ2
         UEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=s4zP0/HDYQChk8qwknn7tuHgtDhZG1Gi4WBbb18F5Ag=;
        b=cGniymcj2NSU2fx7hECwlw/cN+SXA0vi11Ut5bHlRR2MeD+uoezc91U9lbJZI6pdA4
         0tQoBy/MWH9tGtw7rS0sJ7crGU4Bf38pxEtwksM2gyFNMQBBvWjiciY/GXvoCGqgTZsC
         YLAadr25EeCu0QfqVB8zEXJPXRN8K5SySOh7brgJHcwRU/gkF2xz6QtqPxeU4731CXii
         adqp4E+ejwpCRZ6mCbYyvaJPM6AUuEy6Vm0geAjBnJChtMXYlcPf2cIan7ObSgZTaGHP
         nXqSNRXvSDh19ftoZjKpqro8JyFtT8YUMC22shivMzsCbSqSo7Ww2NWiAc2DZ5sjxXz+
         EZEw==
X-Gm-Message-State: AN3rC/4d6DZRV4PEPMcqrEIp13v++8EwFHp4/Fi1bi/Em96RHvQdjzAl
        gR2yv+je5HJiJg==
X-Received: by 10.84.217.148 with SMTP id p20mr39893256pli.164.1493169970513;
        Tue, 25 Apr 2017 18:26:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3179:d004:20b:b383])
        by smtp.gmail.com with ESMTPSA id r73sm38492471pfa.65.2017.04.25.18.26.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Apr 2017 18:26:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2] clone: add a --no-tags option to clone without tags
References: <xmqq60i1dvnk.fsf@gitster.mtv.corp.google.com>
        <20170419143831.6868-1-avarab@gmail.com>
        <20170425224521.GM28740@aiede.svl.corp.google.com>
Date:   Tue, 25 Apr 2017 18:26:08 -0700
In-Reply-To: <20170425224521.GM28740@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Tue, 25 Apr 2017 15:45:22 -0700")
Message-ID: <xmqq60hsufgv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> In other words, I think the commit message needs a bit more detail about
> the use case, to say why omitting those tags is useful.  The use case
> is probably sane but it is not explained.  A side effect (and my main
> motivation) is that this would make it crystal clear to people looking
> at the patch in history that it is talking about tags that are part of
> "master"'s history, not tags pointing elsewhere.

I agree that it is unclear "having no tags, not even the harmless
and usually useful ones that point at the history of the branch of
interest" is the point of this new feature from the documentation
and log message.  

Responding to your other message, I do not think this new feature
should be tied to --single-branch; I think having the tags to mark
commits in the branch's history (while not fetching other tags
irrelevant to the branch's history) is usually what users would
want.

>> Before this the only way of doing this was either by manually tweaking
>> the config in a fresh repository:
>
> Usually commit messages refer to the state of things without some
> patch using the present tense --- e.g. "Without this patch, this
> --no-tags option can be emulated by (1) manually tweaking the config
> in a fresh repository, or (2) by setting tagOpt=--no-tags after
> cloning and deleting any existing tags".

Thanks--I'll use this myself when responding to patches from other
people.  I recall getting irritated while reading some patches and
couldn't pinpoint why they were irritating, and now I realize that
it was because they said "Previously Git did X." and somesuch.


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E66F1F42D
	for <e@80x24.org>; Tue, 29 May 2018 13:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934203AbeE2NlV (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 09:41:21 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37669 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933548AbeE2NlU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 09:41:20 -0400
Received: by mail-wr0-f196.google.com with SMTP id i12-v6so25619422wrc.4
        for <git@vger.kernel.org>; Tue, 29 May 2018 06:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bb+eoTef1nUcDMj0o1JATNVyDzDaxoIbdO4rYT+9aR4=;
        b=lyv11/8/CMcuTJkTsTNXypD9rsB9HMbaJR+XswK122c/jaIKXNyhA2ZPPCe7yERSSm
         hnrKPD00X29owAh/3QEd07rx5keJz/aPGrG86/c7MeUrzc+dyomep9RJ7chR0O7oMB5E
         B5IQAUrMNUM4otaRYZ7qJsPNISJBr9eE8AcXUjo+ogvZrpkEOKLPnc5EVs0O9b682xBn
         dnrwAbI4Ns+wEVOCUI2N+z/RHWSWAJwzMPZSK1LyR+wKOvsCHMHq8VIEzkNXm3z97GZG
         zu5svLReIvdGBoy0uP+rgxbPlLt1kykw5E4KHNkxfTH5fmeHRm6o5Pn+eF7FfugJlnpX
         G+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bb+eoTef1nUcDMj0o1JATNVyDzDaxoIbdO4rYT+9aR4=;
        b=qqZfN3CwYjjOCZBJYLxKy9ciKrGf0pJ3w/iJzdFZX5wxyzYTL28VYjZQD+bKDVXqAr
         Pol789Ax/zeR0B0jz0snLNa9pULkHV6ynAoZLXVZ0fYPoOIiUGhZmioaOEKBsgtMvOQ3
         us5OP5ArZ0XOqg/2wZgrP/LClCn1Y908eduP+ASiensbS0CatlC4C+yoMrVsTzK+heYy
         nSDlPM4xSo5/MygSubPUUepOd53VsXLujVFP6MDAnaBIn8BDoaWdJA/P7MKnKjV7ITCi
         xWqsVXbD4mOfZIUw25VHGRGG2XJzDcRTsk6oqSefQroQrJqyZJ/OSDJ9OVUa4SkyuC9d
         Srqw==
X-Gm-Message-State: ALKqPwcavDDeI3lxxhqKhcD9jwdlb+iajF85BeOnwn7htpT/yU20DLhv
        zpNhRAYMcSV+eG7c8QOqIvM=
X-Google-Smtp-Source: AB8JxZrgugKqGT80q2Z1r5MoK56LqdPNcSn2OcX+jPCswEE2b6TS4jO39H1pi4vUAOKaF7ktwypOvw==
X-Received: by 2002:adf:a219:: with SMTP id p25-v6mr13386059wra.19.1527601278487;
        Tue, 29 May 2018 06:41:18 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n12-v6sm11425931wrp.69.2018.05.29.06.41.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 06:41:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "jnareb\@gmail.com" <jnareb@gmail.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "marten.agren\@gmail.com" <marten.agren@gmail.com>,
        "peff\@peff.net" <peff@peff.net>
Subject: Re: [PATCH v3 00/20] Integrate commit-graph into 'fsck' and 'gc'
References: <20180511211504.79877-1-dstolee@microsoft.com>
        <20180524162504.158394-1-dstolee@microsoft.com>
        <xmqqzi0jgk70.fsf@gitster-ct.c.googlers.com>
        <c5a11465-67ac-fbae-dbea-d20e6958bf1a@gmail.com>
Date:   Tue, 29 May 2018 22:41:16 +0900
In-Reply-To: <c5a11465-67ac-fbae-dbea-d20e6958bf1a@gmail.com> (Derrick
        Stolee's message of "Tue, 29 May 2018 08:37:13 -0400")
Message-ID: <xmqq6036h94z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 5/29/2018 12:27 AM, Junio C Hamano wrote:
>> Derrick Stolee <dstolee@microsoft.com> writes:
>>
>>> Thanks for all the feedback on v2. I've tried to make this round's
>>> review a bit easier by splitting up the commits into smaller pieces.
>>> Also, the test script now has less boilerplate and uses variables and
>>> clear arithmetic to explain which bytes are being modified.
>>>
>>> One other change worth mentioning: in "commit-graph: add '--reachable'
>>> option" I put the ref-iteration into a new external
>>> 'write_commit_graph_reachable()' method inside commit-graph.c. This
>>> makes the 'gc: automatically write commit-graph files' a simpler change.
>> I finally managed to find time to resolve conflicts this topic has
>> with other topics (of your own included, if I am not mistaken).
>> Please double check the resolution when I push out the day's
>> integration result later today.
>
> Sorry about the confusion. I was operating on my copy of
> ds/generation-numbers (34fdd43339) but fetching just now I see you
> updated that branch to 1472978ec6. I reset my local branch to
> ds/commit-graph-fsk (53dd1e6600). The only diff I see between my v3
> branch and that commit are the changes from
> ds/commit-graph-lockfile-fix (33286dcd6d).

Sorry for a confusing/confused comment.  The topic I had in mind
that I saw interactions with this one was the per-in-core-repo
allocation (sb/object-store-alloc), which was not yours.

In any case, what I wanted to see sanity checked was the result of
the merge into 'pu' (which needed some semantic adjustment), not
individual patches on the topic branch.  Relative to what we see at
the tip of 'pu' right now, what I'll be pushing out in 3 or 4 hours
will gain yet another semantic adjustment, so you may want to wait
a bit more to avoid duplicated work.

Thanks.

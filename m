Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E352E1F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 23:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391450AbfAOXfb (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 18:35:31 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38279 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbfAOXfb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 18:35:31 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so4931403wrw.5
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 15:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=l7SLWRJOZpAsxB116l5HpkZZm78o2REJCYiKFKk5TqA=;
        b=jMKg1nsfu4eYTQaoODTVp0BqMF0Xa+WxtfEDIAopo+ZWhnSfVyBSiIYKhxZ4H6wgWS
         SqNP2JIhpVOP3RrRbb5egskH+5+lHsIh5qYJYokUvbwlUJybCsSZg93yXmUsJ6W45OnY
         HHz+QimrOWSwyKlFuKFgL1vNY6chnJ6PLZTpVWECw4J4LwzgfZ4Y/vTvyKs91+BCTylX
         91VanwbEKg0cFYXDN0FTjgHRqTbMbaG//cWxpA119KPJurvwJP4VnBGQiYlql4cnjCkY
         jouhCeDraDlnPbxZEtqLBv7X+2m/kxt9psCyl364gkurpVVAV6ToDWSRPChE5Ac4YsjN
         RvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=l7SLWRJOZpAsxB116l5HpkZZm78o2REJCYiKFKk5TqA=;
        b=JilQGlSy2YACQUZcPee0AkMJSiKlk04mwXODYiFs3Z1ilTjzG0hWnYz5RoS/SVy8Ta
         EwGSgjCUcuCVa5bSleY1Bfpa0KCMLB3q2pH6Rt3BytywGGhpR8WQzYxea8ylmVJFL1+n
         Wdx9b7qxRUNxBeG83UNpD1PQJbVxKqFaTYFCq8y/5/HcmWCVXghZY8VosaPEF5p3fdqT
         K2TjhrFjaNzXpSaDIdwwD77ldLSJ4ljBt5oRJ6Pjq5Y7STPcPBm80I7L4nfIudyLdtWo
         9+MWwP+lIoCiMpATNZ3OyW4byXNwn9zKwY9pyi+m2hAuRj4yvRyaX0kILt36bVx/A4C+
         f9bQ==
X-Gm-Message-State: AJcUukdTVfQADIix7HLGgfFxb2eJ4AcsSmRDm4SJDTegZrMVVYVSgsjg
        O9TOrOPGBAI9Sb5ctGqtNg8=
X-Google-Smtp-Source: ALg8bN7lBRtQkju/6klGCtTompkHsPSCDOqcPLGFWBH8NExPFiIveOjhRUkC34y0KcCcmw5LMfPHJQ==
X-Received: by 2002:adf:a50c:: with SMTP id i12mr4835727wrb.220.1547595329208;
        Tue, 15 Jan 2019 15:35:29 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j24sm89881168wrd.86.2019.01.15.15.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 15:35:28 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     matvore@google.com, git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] support for filtering trees and blobs based on depth
References: <20190109025914.247473-1-matvore@google.com>
        <20190109180633.10273-1-jonathantanmy@google.com>
Date:   Tue, 15 Jan 2019 15:35:27 -0800
In-Reply-To: <20190109180633.10273-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Wed, 9 Jan 2019 10:06:33 -0800")
Message-ID: <xmqqftttpk8w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> This applies suggestions from Jonathan Tan and Junio. These are mostly
>> stylistic and readability changes, although there is also an added test case
>> in t/t6112-rev-list-filters-objects.sh which checks for the scenario when
>> filtering which would exclude a blob, but the blob is given on the command
>> line.
>> 
>> This has been rebased onto master, while the prior version was based on next.
>> 
>> Thank you,
>
> Thanks, these 2 patches are Reviewed-by: me.
>
> Your approach in the 2nd patch makes more sense, and I checked that both
> oidset_insert() and oidset_remove() return 1 when the element in
> question was in the set (prior to invocation of the function), so that
> works.

This is turning out to be messier than I like.

The topic is tangled with too many things in flight and I think I
reduced its dependencies down to nd/the-index and
sb/more-repo-in-api plus then-current tip of master (and that is why
it is based on a1411cecc7), but it seems that it wants a bit more
than that; builtin/rebase.c at its tip does not even compile, so
I'll need to wiggle the topic before it can go to 'next'.

And worse yet, it seems that filter-options-should-use-plain-int
topic depends on this topic in turn as it wants to use
LOFC_TREEE_DEPTH.


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 188421F5FB
	for <e@80x24.org>; Tue, 28 Feb 2017 00:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751531AbdB1AeJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 19:34:09 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36826 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751364AbdB1AeH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 19:34:07 -0500
Received: by mail-pg0-f65.google.com with SMTP id 25so2676825pgy.3
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 16:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=o4e62SD/pchf3SN3y/ehTQT4hOO2oJY18xbkTFAE6aI=;
        b=bpkRYr9NFS48PsHouUIYEqTRFfVFeWDAyOfAxhoaKJvXVjavLkTdnyMJF/lztkfxyb
         tPFsbagUb+Hbip1OzhlGPMT9z5fpCSodSSBtJNe26GBTDb5jQ8y4IgcC6/r7Rkpatp/1
         tfPXxS5EH5wwdGK9wW9zNIM2B/7SUW6NMhW07y0ITTY42bpJJSRXZYPWto4lfIXT8PNU
         bNpigLVYSl5sdjFKnfsPGdjdHvFrWxYP4JqIM8vZArxxlYaTiyCJZeLPjgGNTq0+ksx+
         euZUirquQkjIE/O473PGCO4Bj1h4451c75WrEWZgN34WfdyUtrJMNDIEoHykyBFWDQWd
         76nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=o4e62SD/pchf3SN3y/ehTQT4hOO2oJY18xbkTFAE6aI=;
        b=nc3KrmS4LbBDCzY2+gP0FW1NwBBxtpdZN3PGTi99H4044Il1Cp4SAGlaYlF6aCTHay
         OeVjrjI+rpBHpcDZyZvMLcyApWkf0U274CRoXp2un0H5ZihlXBq++4yCZBlnNG1nkWCH
         DU00XMkTvzJTRxTq/gfcQxOuFRnh7jLppJuDdyNvZ3100nIs5xjH09eI9jmL/hV3loAM
         Y9a6aIsU0Fumh95Yl5B8q9kkNiiuekpW2bZoEeEfnVR/R6cJ2yUWKDKm+JzrmH3qfkmf
         Q9Ot0c7aE56NIOCmL+BCtuKe9pUoegiKQVvhEfbI9j4wmINeuZ6oND1yakPC6j6i3I3f
         yKvg==
X-Gm-Message-State: AMke39k0m2FZ1TgUVURXpa6efZFaXNvX+2x/Rjf8FqFQ037j7tDciIpEHCQ72xjjF6GLOQ==
X-Received: by 10.99.7.13 with SMTP id 13mr15626068pgh.121.1488242018929;
        Mon, 27 Feb 2017 16:33:38 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:c953:ec42:862e:1e81])
        by smtp.gmail.com with ESMTPSA id 19sm27957pfo.50.2017.02.27.16.33.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 16:33:37 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [BUG] branch renamed to 'HEAD'
References: <20170227045257.yazqlrqlnggosi5t@macbook.local>
        <CAOLa=ZSyQg9uoZWADOMYc90U-5AR9Lfii9mjLre0m0FQCSqfxg@mail.gmail.com>
        <20170227074915.xljfe5jox756rlyv@sigill.intra.peff.net>
        <20170227080158.de2xarctzscfdsp2@sigill.intra.peff.net>
        <20170227090233.uk7dfruggytgmuw2@sigill.intra.peff.net>
        <xmqq60jvnu9y.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xpVt6NtSajqMX8OQ_SKdC9tfHH40JgK=9DgBxo9nMaWLA@mail.gmail.com>
Date:   Mon, 27 Feb 2017 16:33:36 -0800
In-Reply-To: <CA+P7+xpVt6NtSajqMX8OQ_SKdC9tfHH40JgK=9DgBxo9nMaWLA@mail.gmail.com>
        (Jacob Keller's message of "Mon, 27 Feb 2017 15:05:37 -0800")
Message-ID: <xmqqzih7kvbz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> What about changing interpret-branch-name gains a flag to return a
> fully qualified ref rather than returning just the name? That seems
> like it would be more reasonable behavior.

There are two kinds of callers to i-b-n.  The ones that want a local
branch name because they are parsing special places on the command
line that using a local branch name makes difference (as opposed to
using any extended SHA-1 expression), like "git checkout master"
(which means different thing from "git checkout master^0").  And the
ones that can use any object name.

It depends on how your flag works, but if it means "add refs/heads/
when you got a local branch name", then that would not work well for
the former callers, as end-user inputs @{-1} and refs/heads/master
would become indistinguishable.  The former is expanded to 'master'
(if you were on that branch) and ends up being refs/heads/master.
"git checkout refs/heads/master" would be (unless you have a branch
with that name, i.e. refs/heads/refs/heads/master) a request to
detach HEAD at the commit, but the user wanted to be on the previous
branch.  And the latter iclass of callers are probably already happy
with or without the flag, so they won't be helped, either.

A flag to affect the behaviour (as opposed to &flag as a secondary
return value, like Peff's patch does) can be made to work.  Perhaps
a flag that says "keep the input as is if the result is not a local
branch name" would pass an input "@" intact and that may be
sufficient to allow "git branch -m @" to rename the current branch
to "@" (I do not think it is a sensible rename, though ;-).  But
probably some callers need to keep the original input and compare
with the result to see if we expanded anything if we go that route.
At that point, I am not sure if there are much differences in the
ease of use between the two approaches.

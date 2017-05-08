Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF32920188
	for <e@80x24.org>; Mon,  8 May 2017 04:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751374AbdEHE0v (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 00:26:51 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34210 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbdEHE0u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 00:26:50 -0400
Received: by mail-pg0-f66.google.com with SMTP id u187so8820137pgb.1
        for <git@vger.kernel.org>; Sun, 07 May 2017 21:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4uFRbbYQQEhSw+d5S7qdCap7S9uoDKyRD7jnceHsn/w=;
        b=HX0tIy/O1ek11eXmFU+NTPe6hrK6l26azWw2PTmvq43Xl5WK4KGLv6prXRKSLWpErk
         yXP9ojOfbsUofk167AWlkkxmTYV+RQ35YM7mB8V1bQwp045xq8u27MXBIr0p0xjLhqtB
         67WT7CbCeVGO66X+bwRQ8Nb+6PHCk7Vyx8P2PS2SpuHsFvvu1JqznAGYkL7+c+BqhfRw
         rafY/pAprYWG6SOilv8HBGNsf1PHT0nuTJRf94gERFhC/qhRGbPX2FyAT+nAyk68nc7k
         McMHHnvnMNGgtiRUG0/mPR4W42j/U2WAlPHc7l90iVhZZwcPXy7q6dwXrekuU+/VxZ6N
         xlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4uFRbbYQQEhSw+d5S7qdCap7S9uoDKyRD7jnceHsn/w=;
        b=nyKHvvnBarumSouJ0GopwkL/q2DWSvQ2oQV9GwbgZbrqsp0UNIL/5R+3Wd0bLAv2HT
         MxaQDR0wfQHPmb1OpMMbNK/WVxN8Wa/3kNybTDBn8/DgyNF2v7L3nj1kVzBsXvDzl9j5
         mEhS7xBwrWNTsMBe6L+1GItHADYTwzj01r++nmsJrJYppsS80hM/+0WRatIQyZ2YDXfl
         yFAiAiaszRduAj2+sNVz9KELRSFLRcrZupGXdmG40dAPaDDKCgAOszZ25Q5vVYvvCZaI
         NfobgsXomv1GU6TGDoHwWe9arKYa/Nxiy7KYgafKedoJGCu7HoOl4MupwbJYw6XL501H
         de5A==
X-Gm-Message-State: AN3rC/7AxYZPjAXzdOPp1sXXJ0pIzR5g2XWEstZL+asFbj0cP2VRwIQd
        f7VpQq5gDWdpwi9AXis=
X-Received: by 10.84.136.135 with SMTP id 7mr45107689pll.33.1494217609427;
        Sun, 07 May 2017 21:26:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3011:642f:81a0:efbd])
        by smtp.gmail.com with ESMTPSA id s62sm21607854pfk.26.2017.05.07.21.26.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 07 May 2017 21:26:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/9] Keep git clean -d from inadvertently removing ignored files
References: <20170503032932.16043-1-sxlijin@gmail.com>
        <20170505104611.17845-1-sxlijin@gmail.com>
Date:   Mon, 08 May 2017 13:26:48 +0900
In-Reply-To: <20170505104611.17845-1-sxlijin@gmail.com> (Samuel Lijin's
        message of "Fri, 5 May 2017 05:46:02 -0500")
Message-ID: <xmqqh90w9do7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Lijin <sxlijin@gmail.com> writes:

> Addresses the issues raised by Stefan and Junio (thanks for your
> feedback) about not using C99-style comments and keeping tests
> working on every commit to prevent breaking git bisect. (About the
> latter one: is it necessary to prevent compiler warnings, in
> addition to compiler errors? Because if so I should probably
> squash some of the commits together.)

Some of us build with -Werror, so yes.  If by "squashing" you mean
"instead of piling a fix on top of a broken patch, I need to do
things right from the beginning", then yes, please do so, not just
for compiler warnings but for all forms of changes.

> Note that this introduces a breaking change in the behavior of git
> status: when invoked with --ignored, git status will now return
> ignored files in an untracked directory, whereas previously it
> would not.

What do you mean by a "breaking change"?  Is it just "a new bug"?
Or "the current behaviour is logically broken, but people and
scripts might have relied on that odd behaviour and fixing it this
late in the game would break their expectations"? 

> It's possible that there are standard practices that I might have
> missed, so if there is anything along those lines, I'd appreciate
> you letting me know. (As an aside, about the git bisect thing: is
> there a script somewhere that people use to test patch series
> before sending them out?)

I hear that people use variations of

    git rebase -x "make test"

on their topic.

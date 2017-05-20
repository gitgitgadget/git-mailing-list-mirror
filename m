Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ABA72023D
	for <e@80x24.org>; Sat, 20 May 2017 04:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754562AbdETEuz (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 00:50:55 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33748 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753398AbdETEuz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 00:50:55 -0400
Received: by mail-pg0-f66.google.com with SMTP id s62so11672169pgc.0
        for <git@vger.kernel.org>; Fri, 19 May 2017 21:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2VvF+QTQ/8/wIzHnUL5OQf9BoJCd/0A9XW+SDgXACyg=;
        b=J4atG2OW4FsIYP+aS9ejQAzSUk2eJp0/l22LgU6uijpqr172yD6iXCKhcorjYKb2jG
         VEhpwMDRQLWp9d96G3k8sG0oJi9ZkfPPDenJmvhbqljqS0Wn/5COlAMftsZmbHJExnVa
         guL5Hxy5dToyMqi5hwthI0IhkhnYRFrkLHpK3s1DL6BBhb+r3Fb2nCGHJLgSL0M+UB4K
         to30zxOKYCe7cp0CGRuLbJk2AemkOBbi3D4WbDz/laovsNAkaU8i86VEb9/3UVE4pqsq
         XCurxzA+7p5VnXwzQXbIMyvQvPZDHEC+oJOd2ojSOUlUwNe+Y1X+O3CT43eXcHAngXS4
         1d1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2VvF+QTQ/8/wIzHnUL5OQf9BoJCd/0A9XW+SDgXACyg=;
        b=s7DyplUIuu7Vlhs1hBvwyL/XN6iGiPOljG/HaqcZc84E43VBzZ83gqYObb+PtcrQNr
         W5ZRKIw3qBQ3bVdJQqY/pQdH+ukqrccfSK4dXABi8hhfSz5nrYl/HKDURghUB7cGoexD
         pVs+ye8q9TWXpIj4QJgReeq8dY3u5dWXBgzrzCGn6rpsFLOVqoyMe19ZsFJVCfcv+3GB
         k/y12PMkPNYG8MZi6KsSwfzOCSu9y/tUbdrLyuNt/SMdPAb+hyJiHSNYdLDKUZBmWAtV
         a+wZvuRt5/AIvf8qecBsucq1TnX91S2l2DN89J6cV7lDlXDvD8OnAjEam72V5vRN8H4v
         oSmQ==
X-Gm-Message-State: AODbwcD8OdyXwc8b2WniGKxYj5HmMoK9bJy8FLbOsFBOqPFDixVZmsZC
        w1VQITKsDsSPGg==
X-Received: by 10.99.173.71 with SMTP id y7mr13367156pgo.3.1495255854240;
        Fri, 19 May 2017 21:50:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4027:806a:d2b9:807c])
        by smtp.gmail.com with ESMTPSA id p89sm20374869pfk.67.2017.05.19.21.50.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 19 May 2017 21:50:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCHv2 12/20] submodule.c: convert show_submodule_summary to use emit_line_fmt
References: <20170514040117.25865-1-sbeller@google.com>
        <20170517025857.32320-1-sbeller@google.com>
        <20170517025857.32320-13-sbeller@google.com>
        <xmqq8tlwxdp3.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbCYiDRbf2+uXANqBiR9sG4ir4m6VK5+t1LS-kE7T1aQg@mail.gmail.com>
        <xmqqinkyvobp.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbXyjTaE=F7YU8yu8=eNzLS96sA5r5N4xrhmOfw+T4Lwg@mail.gmail.com>
Date:   Sat, 20 May 2017 13:50:50 +0900
In-Reply-To: <CAGZ79kbXyjTaE=F7YU8yu8=eNzLS96sA5r5N4xrhmOfw+T4Lwg@mail.gmail.com>
        (Stefan Beller's message of "Thu, 18 May 2017 10:12:20 -0700")
Message-ID: <xmqqk25ct9lh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> That could be added in ws.c:ws_check_emit, as these certain words
> are similar to coloring whitespace.

I actually was envisioning of highlighting a part of a line, like

    -Very <red>poor</red> SCM
    +Very <green>nice</red> SCM

which would be done by finding semi-matching removed and added lines
in the same hunk (i.e. local buffering) and makes a coloring decision.
That does not have any place in ws.c.

>> Having said that, we need to start somewhere, and I think it is a
>> reasonable first-cut attempt to work on top of the textual output
>> like this series does (IOW, while I do agree with the NEEDSWORK and
>> the way this series currently does things must be revamped in the
>> longer term, I do not think we should wait until that happens to
>> start playing with this topic).
>
> Ok. I share a similar reaction to submodule diffs that we discuss above
> and word coloring, that Jonathan Tan brought up off list.
>
> Both of them are broken in this implementation, but the NEEDSWORK
> would hint at how to fix them.

Yes, but if NEEDSWORK has to say "the current hack is working at a
wrong level, we need to do all of this before producing textual
diffs that are passed to the layer that colors lines", that wouldn't
help that much as a hint X-<.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44175203EA
	for <e@80x24.org>; Sat, 10 Dec 2016 11:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbcLJLB3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 06:01:29 -0500
Received: from mail-io0-f171.google.com ([209.85.223.171]:34853 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752704AbcLJLB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 06:01:27 -0500
Received: by mail-io0-f171.google.com with SMTP id h30so99280990iod.2
        for <git@vger.kernel.org>; Sat, 10 Dec 2016 03:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dBPoXDOao1cXmK2i9edkdlh1aQozjqDXkNkUGqmtJlo=;
        b=kOeeWoLh2+mGFSm74EEXEnInbivEDy1znn0efjyaseY2SaYcu4ffO2WO75ftQgEvMe
         rzn0q/3FVSObKy6mqd/NS6V6Uz6Aq3Yyjcm3E4t8161z3Wxcs9+YuiiQsPcAYV834ws6
         5+Inwgtvr3Do6WuuV+ncPwqk8k+biEw0EWrb4/APdjQIOdxcXgCSczKdnku0U5CPkU/A
         oX9fsejeWYtodpCQpLNEgL4mFIUwe/FTCpcYSGY8t5C2OMejWX/uj4Nad8BBu61YDoX9
         bTRvqxQt6q+hhv9th6Br/RI1QL422iCmM1CA/WzLHeKiMhdT1tDaWm7HtzVnpeR0xOl1
         7bMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dBPoXDOao1cXmK2i9edkdlh1aQozjqDXkNkUGqmtJlo=;
        b=e7ZDt0BgWSEgxol1VL/oid6/T8XifJMJGob+TH3dWjnraiFTBxyGgejI7nu1MF34Kd
         5WZTrrjGCNPzSXeF7/k3fxuWlz6boT16dfTUm0oi0is+Hq0dHnMw0zschm1ayQHNS01p
         uvhfIrVlfSpNYFuHwEWtKJ+smftNeEtl/rfdAbGDcAukAbj1nHrKYwR1KYX+hLyI2uID
         uyNeQiLeJeLGlIf5kXBDBODLp7tcXhVndqUe/HherDHmBqnRt9yIvVKSvBWGF/rckVdp
         NS5g9RbAR7jvtcXfavp+byjQvuGWAx3eDWtGJgTFrZKXatCf7EryziDHFV++QdUN+xpj
         pWTQ==
X-Gm-Message-State: AKaTC016gwwc5uOE1I5D0/O3uQEOEod3d8Ush+1Iit3qPv98vlC84o/oZt671mB6SeG3/10oDz1kyWXahPAbjw==
X-Received: by 10.107.44.137 with SMTP id s131mr68919458ios.212.1481367686897;
 Sat, 10 Dec 2016 03:01:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Sat, 10 Dec 2016 03:00:56 -0800 (PST)
In-Reply-To: <e0780f7c-ccb4-29fe-3d72-80e45a202f65@gmx.net>
References: <xmqqlgvs28bh.fsf@gitster.mtv.corp.google.com> <6facca6e-622a-ea8f-89d8-a18b7faee3cc@gmx.net>
 <xmqq8trry08k.fsf@gitster.mtv.corp.google.com> <CACsJy8CX0HO=LxcEK3K+pCecgFY=40R+gpFoy7CGeN5zEJFJVQ@mail.gmail.com>
 <xmqq8trprn7f.fsf@gitster.mtv.corp.google.com> <e0780f7c-ccb4-29fe-3d72-80e45a202f65@gmx.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 10 Dec 2016 18:00:56 +0700
Message-ID: <CACsJy8Div=Baenn7c-1wxgvrOh5PG=naeDrEYC8gs+AvJE7wZA@mail.gmail.com>
Subject: Re: BUG: "cherry-pick A..B || git reset --hard OTHER"
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 10, 2016 at 2:24 AM, Stephan Beyer <s-beyer@gmx.net> wrote:
> Hi Junio,
>
> On 12/09/2016 07:07 PM, Junio C Hamano wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>>> Having the same operation with different names only increases git
>>> reputation of bad/inconsistent UI. Either forget is renamed to quit,
>>> or vice versa. I prefer forget, but the decision is yours and the
>>> community's. So I'm sending two patches to rename in either direction.
>>> You can pick one.
>>
>> I actually was advocating to remove both by making --abort saner.
>> With an updated --abort that behaves saner, is "rebase --forget"
>> still necessary?
>
> A quick change in t3407 of the "rebase --forget" test to use "rebase
> --abort" failed.  That's because it checks the use-case of
> forgetting/aborting without changing the HEAD.  So --abort makes a
> rollback, --forget just keeps the current head.  I am not sure if that
> tested use-case is a real use-case though.

It is. I wanted something like this for years but "rm -rf
/path/to/.git/rebase*" was not as bad when there were no linked
worktrees.

rebase and cherry-pick/revert are not exactly in the same situation.
When cherry-pick/revert in "continue/abort" mode, there's usually some
conflicted files and it's easy to notice.

But an interactive rebase could stop at some commit with clean
worktree (the 'edit' command). Then I could even add some more commits
on top. I don't see how 'rebase --abort' can know my intention in this
case, whether I tried (with some new commits) and failed, and want to
revert/abort the whole thing, moving HEAD back to the original; or
whether I forgot I was in the middle of rebase and started to do
something else, and --abort needs to keep HEAD where it is.
-- 
Duy

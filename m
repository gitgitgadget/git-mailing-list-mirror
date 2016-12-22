Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0D0D1FF6D
	for <e@80x24.org>; Thu, 22 Dec 2016 21:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758073AbcLVVOx (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 16:14:53 -0500
Received: from mail-ua0-f181.google.com ([209.85.217.181]:32990 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752619AbcLVVOx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 16:14:53 -0500
Received: by mail-ua0-f181.google.com with SMTP id y22so60514932uay.0
        for <git@vger.kernel.org>; Thu, 22 Dec 2016 13:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=tCik2r8S5gL1U41bUTbDF25Pf10mOVxKhkVr4ZY4f0s=;
        b=fwkSMmt1Z9sotUazwFSahbrydyaDayKFzW3lp3zFBjAEpkQsXu8kaO2tGMe8Q2R/sR
         +AHAERfmvQGnzJRWggrwZK4+Rpz5QSJIsg/tFQWJvuedI1M3UyofdXHk1EH7RdI+/91M
         AaITW1Oir/JrSPhyE5RR3pAGsyz0OA+unUgIBONiNC2g0sqzrreTO6GPYIDVcKofk1oO
         dLaMKzbOu9BpP599ujLGdp9v0Q4hYVClOXI6FOBY03wWFy7FSjt0PtQXiJFIO8CSoiTv
         /RywD5ayqtNYDeP84CiNmKjoicyLwQigOP92iTpPhMVzps/TpWrVdqsDJzOo3oXvxz3J
         y9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=tCik2r8S5gL1U41bUTbDF25Pf10mOVxKhkVr4ZY4f0s=;
        b=CqkXlGoECj7luOqONCMc24/LNSlDBBbj+HZHW+cOS+z1QFLRL4I8I/rhjBEH9eFl6n
         yKPpeD1Njr3QsD6XlKhM4wtAoML7DUn13yJB78j31rDvPM/QTT7igmgW3M1u/R3324ew
         zd79q6ksY45ma+6Qdlxn6OalTVeYBfNgIB9t6MDKv30olVh0V/aJalzec7npgq2STL7h
         qpqEK6EDktVgpUhzgU/TuW8JIxevZk4hgwaK32xA//7TPNlm4eSKuxhMRLvWv+uauyRu
         LH+ahA3K20ONTIp08YXjv8VaiKbR1WNpajVa4dTVmlWxFvnZjA3yYWYY7H0jyYTXxyBT
         9EVw==
X-Gm-Message-State: AIkVDXISH4RGh8WTK01V1jOTwNovu6bnFxdyaXhwvl49Zz1MWqkkJhbSfFmAbGgSZyTAEeLgsmkjzmPnXj5ncA==
X-Received: by 10.176.71.21 with SMTP id h21mr9112356uac.167.1482441291879;
 Thu, 22 Dec 2016 13:14:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.45.11 with HTTP; Thu, 22 Dec 2016 13:14:31 -0800 (PST)
From:   Stefan Monov <logixoul@gmail.com>
Date:   Thu, 22 Dec 2016 23:14:31 +0200
Message-ID: <CAJtFkWtjowyGaFfsCVd-HAZM2-3e0=CkkyYfxne8KRdYq5kJ9g@mail.gmail.com>
Subject: =?UTF-8?Q?Making_it_possible_to_do_=E2=80=9Cgit_push_origin=E2=80=9D_inste?=
        =?UTF-8?Q?ad_of_=E2=80=9Cgit_push_origin_=3Cbranch=3E=E2=80=9D=2C_without_having_to_one=2D?=
        =?UTF-8?Q?time_prepare_each_branch_for_it?=
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

I'd like to use just:

    git push

or at most:

    git push origin

rather than having to first check which is the active branch with `git
branch --list`, then type:

    git push origin <branch>

At [1] and [2] I've seen that if I do this once:

    git push -u origin <branch>

then from then on I can use just `git push` _for that branch_.
However, I don't want to do this "setup" step for each branch, because
it's extra work that I also may forget to do.

Why is this "setup" step necessary and can I avoid it?

Thanks,
Stefan

[1] http://stackoverflow.com/q/19312622
[2] http://stackoverflow.com/q/6529136

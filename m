Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A397D1F404
	for <e@80x24.org>; Fri, 30 Mar 2018 17:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752500AbeC3Rlg (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 13:41:36 -0400
Received: from mail-ot0-f171.google.com ([74.125.82.171]:40057 "EHLO
        mail-ot0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751433AbeC3Rld (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 13:41:33 -0400
Received: by mail-ot0-f171.google.com with SMTP id j8-v6so2639069ota.7
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 10:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pXhVjgArGDUbWoS4SNM7Z1w8gFyRExgz5dM6w7HuMz8=;
        b=N1r0PGHxD4OlE41hw6r94CIFbRahva7NGDq2987ayZAfXZzfAvFstosRfngjpjfcnV
         q35ZdQAsog9IT/+LVCNtuz5sZe3+oCPAt0NxHOHidYQqzMxoAJhuO+eEvwxlrddkwZCV
         8TnUEK4C51ggMA75nQd4MyybcZSa2y7htzIWNpcIsc64iHE6mvd9fr0VM4H+553YDJ+b
         jNxWKhQuieenBuDfhT9Gzqes2KSbQ6/bb2bCDQjOK++BbZMDw4byMX+E84ZxfyjbHcHW
         7/8ojjoeyu5O5rbOpQ4OjnlKMqtIYKJ8DjTRpOWP+Xcww+8uMtc52NRre/rHneT4CPRA
         3cqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pXhVjgArGDUbWoS4SNM7Z1w8gFyRExgz5dM6w7HuMz8=;
        b=XxpQ1o5eMGED4YKFwKZn2AdPoGprAsf/6yOk1Cs9K5EY7Ar7DHP1nabnaO0DxgmweM
         IHDlGZkb4z3ZP9HE08qzCOCfvQBJYxUfqmO3Vn4TA3Ow/UelkK50MmNmqOPky+qTIbJa
         DnfURoF1G0BbJ1gKgxUjxR2AbTsi6gTY2AKAGpDkmtAbyO7ZukmrIqW15tMjnNphhpCm
         GWfPGTa+uglSkJj0pMb2Izrg1Oiqgw44K/z5aa3HuVM6sDWKkcOsPsm/l2taKM9QvQRa
         W7r3Pqq00Aww0kV0l1rJG11TbxZSZIaWCFPDuxA8xIsIjLFTBkshgZih+HquhrIgXTuc
         tGrw==
X-Gm-Message-State: AElRT7HlyBM5+MwS2cQWFllBftrmowl9XM2TDrZCAupqSNet3iEEWqbG
        K2J+tYOEiLCWPIpv9RXmakqXr0ZIf5iUlCDuIBA=
X-Google-Smtp-Source: AIpwx4/UvmipGgqdP/b2xhAZIBhr5mmFFq8oV4u2gdOW2Yigw1CCsSuRPxN+PfVG2fcx3PDfABungydcT61rSsugd6s=
X-Received: by 2002:a9d:16f3:: with SMTP id s48-v6mr8385507ots.304.1522431693244;
 Fri, 30 Mar 2018 10:41:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Fri, 30 Mar 2018 10:41:02 -0700 (PDT)
In-Reply-To: <xmqq7ept4hhj.fsf@gitster-ct.c.googlers.com>
References: <20180330070744.22466-1-pclouds@gmail.com> <xmqq7ept4hhj.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 30 Mar 2018 19:41:02 +0200
Message-ID: <CACsJy8DS2pRaDhXgKqFQaqjFft_EW5G=8t9PhNcAgMsSDsS0jA@mail.gmail.com>
Subject: Re: [PATCH] setup.c: reset candidate->work_tree after freeing it
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 30, 2018 at 7:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> Dangling pointers are usually bad news. Reset it back to NULL.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>
> Before abade65b ("setup: expose enumerated repo info", 2017-11-12),
> candidate was an on-stack variable local to this function, so there
> was no need to do anything before returning.  After that commit, we
> pass &repo_fmt down the codepath so theoretically the caller could
> peek into repo_fmt.work_tree after this codepath, which may be bad.
> But if candidate->work_tree were not NULL at this point, that would
> mean that such a caller that peeks is getting a WRONG information,
> no?  It thinks there were no core.worktree set but in reality there
> was the configuration set in the repository, no?
>
> Which fields in candidate are safe to peek by the caller?  How can a
> caller tell?

To me, all fields should be valid after
check_repository_format_gently(). Right now the caller does not need
to read any info from repo_fmt because check_repo... passes the
information in another way, via global variables like
is_bare_repository_cfg and git_work_tree_cfg.

> It seems that setup_git_directory_gently() uses repo_fmt when
> calling various variants of setup_*_git_dir() and then uses the
> repo_fmt.hash_algo field later.

Yes. Though if we're going to reduce global state further more, then
the "if (!has_common)" should be done by the caller, then we need
access to all fields in repo_fmt

> If we want to keep fields of repo_fmt alive and valid after
> check_repository_format_gently() and callers of it like
> setup_*_git_dir() returns, then perhaps the right fix is not to free
> candidate->work_tree here, and instead give an interface to clean up
> repository_format instance, so that the ultimate caller like
> setup_git_directory_gently() can safely peek into any fields in it
> and then clean it up after it is done?

We still need to free and set NULL here though in addition to a
cleanup interface. The reason is, when checking repo config from a
worktree, we deliberately ignore core.worktree (which belongs to the
main repo only). The implicit line near this
free(candidate->work_tree) is "leave git_work_tree_cfg alone, we don't
recognize core.worktree". Once we move setting git_work_tree_cfg out
of this function, this becomes clear.

I didn't think all of this when I wrote this patch though. It was
"hey, it's theoretical bug so let's fix it". Only later on when I
refactored more that I realized what it meant.
--=20
Duy

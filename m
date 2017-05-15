Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A69D2201A7
	for <e@80x24.org>; Mon, 15 May 2017 17:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758852AbdEORWd (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 13:22:33 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:33622 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757949AbdEORWb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 13:22:31 -0400
Received: by mail-pg0-f49.google.com with SMTP id u187so63186553pgb.0
        for <git@vger.kernel.org>; Mon, 15 May 2017 10:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yTY6+5Y5fiFLDbakcy7FsjeYeBZX/AL3VoETbEB0wG4=;
        b=oAwi9vtCrr91I+3MxCYbfP3gwM+Oj49yQKrKhsc5uYA9+ZIwVtqNIWR8O0vD74tES5
         qdI1GJIXldy2fHeLon/2bQwWjUQIebDWW8S3eDK94AnvLY/Il/zaEl172iFCnOqtETK6
         +R50WCFhXXy01QBavXTNptJwED5xvWLHV8/aTuFMg+jwx6qOgYvFVdCYt9j20uSCdERn
         uE1S9os5dFL0IuFrOizYek0LR0u3/VMLr8dEERsjP+eCuHjEaxz8SxcaUV/1TR7tuA9M
         OM05YZAVH+m8/ln+EyfJK5KqRfoMmTnABqSv5Y1X9DXO9lXWQJ1wQkoSIR/acus3dblB
         uuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yTY6+5Y5fiFLDbakcy7FsjeYeBZX/AL3VoETbEB0wG4=;
        b=iAqyuuhsOYUDhzkjvxGFnV3H99DVyKOrDpcXPZfRa1c4uuKw+RM2YuaqfqxPCVmt7d
         UWo+J28WoknXcUHRoxjVsfzeSW1yGIvAFPHlwwWFJTTtKQcvojqE3eqADsmVP2tIQehG
         7GEtOTQIuhup/E4wzn9FNfChQWzp2Kk1MVqlyaj3fWQBnd0YbpUH3ym8Mb3h8MUkMTCk
         zMLYRdO8BWN95p01JpwNP547l/po/y3bXmMdoKQww1XsabNxraLcUUD5PbxCnySM/ITV
         DPHs24BeuHnr/YZbO+M9A8epqNBe1lRtipTh0FXxRn8813JFqvDGcOuj5e0ADZLitFcg
         St/Q==
X-Gm-Message-State: AODbwcDK75zdi3PWnmpWMyVcPNWnz2qSVdsRqKq9TbCDp8TVK3yXLV+W
        Istgc0YdfdzCAPBQciSyl8DWFISu+BVg
X-Received: by 10.98.60.206 with SMTP id b75mr7468815pfk.19.1494868951042;
 Mon, 15 May 2017 10:22:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Mon, 15 May 2017 10:22:30 -0700 (PDT)
In-Reply-To: <20170512114404.10008-2-pc44800@gmail.com>
References: <c3b724d8-bb9b-b63b-0105-8c1e22b120be@ramsayjones.plus.com>
 <20170512114404.10008-1-pc44800@gmail.com> <20170512114404.10008-2-pc44800@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 15 May 2017 10:22:30 -0700
Message-ID: <CAGZ79kbw9fagp7AprAhUGTD1eUd8YkeoXoAKEx73Uy7TPuVxVw@mail.gmail.com>
Subject: Re: [GSoC][RFC/PATCH v3 2/2] submodule: port subcommand foreach from
 shell to C
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Anders Kaseorg <andersk@mit.edu>, johan@herland.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So we're looking for more reviewers for this patch,
one way to do it is e.g. via
$ git shortlog --since 12.month -sne -- ./git-submodule.sh
(so I cc'd Brandon)
Another way to find reviewers is
$ git blame ./git-submodule.sh
(so I cc'd Anders and Johan)

> It can been seen that the patch fails in test #9
> of t7407-submodule-foreach, which is the newly added
> test to that suite. The main reason of adding this test
> was to bring the behavior of $path for the submodule
> foreach --recursive case.
>
> The observation made was as follows:
>
> For a project - super containing dir (not a submodule)
> and a submodule sub which contains another submodule
> subsub. When we run a command from super/dir:
>
> git submodule foreach "echo \$path-\$sm_path"
>
> actual results:
> Entering '../sub'
> ../sub-../sub
> Entering '../sub/subsub'
> ../subsub-../subsub
>
> ported function's result:
> Entering '../sub'
> sub-../sub
> Entering '../sub/subsub'
> subsub-../sub/subsub
>
> This is occurring since in cmd_foreach of git-submodule.sh
> when we use to recurse, we call cmd_foreach
> and hence the process ran in the same shell.
> Because of this, the variable $wt_prefix is set only once
> which is at the beginning of the submodule foreach execution.
> wt_prefix=$(git rev-parse --show-prefix)
>
> And since sm_path and path are set using $wt_prefix as :
> sm_path=$(git submodule--helper relative-path "$sm_path" "$wt_prefix") &&
> path=$sm_path
> It differs with the value of displaypath as well.
>
> This make the value of $path confusing and I also feel it
> deviates from its documentation:
> $path is the name of the submodule directory relative
> to the superproject.
>
> But since in refactoring the code, we wish to maintain the
> code in same way, we need to pass wt_prefix on every
> recursive call, which may result in complex C code.
> Another option could be to first correct the $path value
> in git-submodule.sh and then port the updated cmd_foreach.
>

We discussed this patch off list before and I think the code is fine,
two minor nits below. But this observation is something we'd want
to talk about here on list. Sorry for dropping the ball for 3 days.

If we do not apply patch 1, the test suite passes, as far as I observe
the situation and patch 1 introduces a test that passes the shell
foreach, but breaks here, IIUC.

Specifically the $sm_path breaks the test in the sense that it is
actually correct now for nested submodules when the command
in the superproject is run from within a directory.

I think this is a rare bug, that we can just fix along the way, i.e.
mention in the commit message that we fix it and adapt the test
such that it passes with the rewrite in C, here.

> +       argv_array_pushf(&cp.env_array, "path=%s", list_item->name);

git-am claims there are trailing white spaces.
$ git am <patch>
Applying: submodule: port subcommand foreach from shell to C
.git/rebase-apply/patch:158: trailing whitespace.
argv_array_pushf(&cp.env_array, "path=%s", list_item->name);
.git/rebase-apply/patch:172: trailing whitespace.
warning: 2 lines add whitespace errors.

Not sure which editor you use, but I could configure my editor to strip
trailing whitespaces on save, and had never any issues with them
since.

> +       struct cb_foreach info;
..
> +
> +       memset(&info, 0, sizeof(info));

Instead of this memset, you could also have a #define CB_FOREACH_INIT
similar to e.g. MODULE_LIST_INIT, STRBUF_INIT, STRING_LIST_INIT and so on.
This memset works, too.

Thanks,
Stefan

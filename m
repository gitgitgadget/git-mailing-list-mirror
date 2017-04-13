Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E166720960
	for <e@80x24.org>; Thu, 13 Apr 2017 18:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753118AbdDMSPt (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 14:15:49 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33865 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752698AbdDMSPr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 14:15:47 -0400
Received: by mail-pg0-f50.google.com with SMTP id 21so34072434pgg.1
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 11:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GD5Y9hrnRuo0ucp5rWvidAVQg9EBMeRjiM6ojr9o+G0=;
        b=K67XH1qktPxuTMa8w9KprK4IARTfJXcvTceHp2cFEibEpiTATAqgR3cMHKBuk7ZUCo
         ZtLZF3gthvzkI1zYLP+AVlci9aYTEl2QncUrcQ9f/i64nwZW4GuYtfFyWeDMARWkmWOx
         CD0UQIA9QclMdQ7wi75nnZI4d7Vp4ZbnwfUnuFU+yujDMBE/8QEBUTfv51mZKrhBwjLu
         11qJuqzbLG9/KlonyPokPK4vzNmK5bVWnEmRzOqNyppES1+gkzcd064xbj3JpDU7jkgY
         idr4Un/Im6H+0/v8xlu0fiDDSOo4SoUTcqpeVbYH0GlkdQVSYBLCI7cVEGXo/LcBhuw0
         DhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GD5Y9hrnRuo0ucp5rWvidAVQg9EBMeRjiM6ojr9o+G0=;
        b=NnUy+U/ELyudPGgKRKS3sXDQGlRxsM9L4tVJt19Ok5WcLDXW41mdF7GOOG7gv9bvvH
         8koKJluOBKRkfLo4sqtuyX5kwQOisWFb4OBId2WBkYsa4wm+mNKNkrcFQ+nhxRUwWiGh
         aOKbqeokB6skBG6h/tLOeQD7jVagHE3VuLtar8N2dIFeGenu3VCy16yiMKoSSFZE/OIm
         SnrjGr0y0BVBX7LszIQEBO5gWKuma0JWx8slav+Yjr/7JlDvU2yAPH0ALVoVNLZHh6pO
         OjP4dh21JZyGy0oLd2g+/sk7e/zoDMg3PTbaYoci4qW9H9jst3kVzmS1wAzjk31YaCAR
         qPcA==
X-Gm-Message-State: AN3rC/6zCcwRV2AWhrOoBMK1DkD6SzwyzPFyZpD1tl27Ax1eRlDAZRvz
        D9V3S6yRTyPOSUTjTnPMa0UgII38sGqf
X-Received: by 10.99.247.69 with SMTP id f5mr4349115pgk.63.1492107346939; Thu,
 13 Apr 2017 11:15:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.163.166 with HTTP; Thu, 13 Apr 2017 11:15:46 -0700 (PDT)
In-Reply-To: <20170413171224.3537-2-jacob.e.keller@intel.com>
References: <CA+P7+xqE-SZ5D6pk6-Dx+-VzHijmgmrUR2F=-370Rh8oKr10Nw@mail.gmail.com>
 <20170413171224.3537-1-jacob.e.keller@intel.com> <20170413171224.3537-2-jacob.e.keller@intel.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 13 Apr 2017 11:15:46 -0700
Message-ID: <CAGZ79kYi4X2cE8uF3cEwh5YndoSL6S2GUK-KYSYibqr+O2qG6g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ls-files: fix path used when recursing into submodules
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 13, 2017 at 10:12 AM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
>
> Don't assume that the current working directory is the root of the
> repository.

1)  Oh! This bug might be hidden in other commands, too.
($ git grep cp.dir -- submodule.c)

2) But why?
Isn't that what most of setup.c is all about ? (discovery of the root of the
repository, staying there, and invoking the correct subcommand with a prefix)

> Correctly generate the path for the recursing child
> processes by building it from the work_tree() root instead. Otherwise if
> we run ls-files using --git-dir or --work-tree it will not work
> correctly as it attempts to change directory into a potentially invalid
> location.

Oh, I see. In that case the setup doesn't cd into the worktree.

> Best case, it doesn't exist and we produce an error. Worst
> case we cd into the wrong location and unknown behavior occurs.
>
> Add a new test which highlights this possibility.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> I'm not sure that I'm convinced by this method of solving the problem as
> I suspect it has some corner cases (what about when run inside a
> subdirectory? It seems to work for me but I'm not sure...) Additionally,
> it felt weird that there's no helper function for creating a toplevel
> relative path.

Do we want to run ls-files from the working tree or from the git dir?
For the git dir there would be git_pathdup_submodule.

We could introduce
  const char *get_submodule_work_tree(const char *submodule_path);
as a wrapper around
  mkpathdup("%s/%s", get_git_work_tree(), ce->name);

Code and test look fine in this patch,

Thanks,
Stefan

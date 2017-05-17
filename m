Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 860FB2023D
	for <e@80x24.org>; Wed, 17 May 2017 00:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752083AbdEQA2b (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 20:28:31 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33813 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752000AbdEQA23 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 20:28:29 -0400
Received: by mail-pg0-f66.google.com with SMTP id u187so23140425pgb.1
        for <git@vger.kernel.org>; Tue, 16 May 2017 17:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TUTzsyvnVoOrbIGnZ+JnXEils6vvCFbl4Nx88fX/kA0=;
        b=CNJluNmpji9djTT9HrOFdbP6J/N/DGkriP2PT96+afvOZuwIrR71nF5SCyCIs/n8vN
         44HX51pJkSzvpc559Euv9cYra1fRBWvBTT1onmz1ysCocsjHYHawHk5YpzSfpa2ruwT6
         1OijpKgBiGuiX53D1b/ja9U/c6Vj9q24T6/176TOsTfjViqwib5wS7ZTGiQPM+qgjU0o
         RfLtLpsHdD7yJeXzySKr+5tM0uqgT6r4cuwB+r10BpqRkcwMc8zNtmuCH8qziGX1AbaI
         qGpe8zO9X4ZEMUeqhoTw6UjwPRfDb5igeLsWDt6SxEn62T/5EXy73CTjCEw94W4qQOLg
         xiEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TUTzsyvnVoOrbIGnZ+JnXEils6vvCFbl4Nx88fX/kA0=;
        b=V1tJg8yRP07LsYXfEGdkSjLyYV4kHsmQehI/SPjWJqEHrFhnyXTFaSvwZ7BimNDphj
         vACF/+HSS2PRob29fgk/M2Z/9sh674G5kf/lxmADYOw63FCZy28Glscr8PLcP8mBQw+8
         FlrBW6ZaluFw5c/CCFkXPcRNoGNXg7oyW4Koeo464WwVSd2CJnS765ETeeAnv6NgtNfb
         1n7MtOKl95JCD3REIERESqHoLh5dO5NTCKGC6JLMAiaCE7eF2NtVrprgFlQg/nvx2FGt
         2y5kjxJu2QnqkFP6pvI+DW55E5uC9m5r9qof2QUtTGpCDrY1grBZ9QnkcpJsMEHAUzpM
         5oCg==
X-Gm-Message-State: AODbwcCg0OZJGEJAOdymQMvIIPryR8JHaNvTSrFXAxNNtUCKiAiq3714
        ZiLVRSfz4rIEjg==
X-Received: by 10.98.93.217 with SMTP id n86mr742389pfj.113.1494980908314;
        Tue, 16 May 2017 17:28:28 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:cd47:ccb1:c55d:4b70])
        by smtp.gmail.com with ESMTPSA id 23sm123134pfr.127.2017.05.16.17.28.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 17:28:27 -0700 (PDT)
Date:   Tue, 16 May 2017 17:28:25 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Manish Goregaokar <manishearth@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] refs: Add for_each_worktree_ref for iterating over
 all worktree HEADs
Message-ID: <20170517002825.GR27400@aiede.svl.corp.google.com>
References: <CACpkpxn4zSdUMT-i6XWBR77sQTpr5-vudbLVTCs1_hiv7a2t_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACpkpxn4zSdUMT-i6XWBR77sQTpr5-vudbLVTCs1_hiv7a2t_w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(+cc: Duy, worktree expert)
Hi Manish,

Manish Goregaokar wrote:

> Git prune will happily delete commits checked out in other worktrees.
> This is probably not desired.

Yikes.  Thanks for working on it.

> (Tabs have been converted to spaces in this email sadly, because GMail
> garbles these. This should suffice for review, and I'll send the patch
> as an attachment or in some other form when done so that it can be
> cleanly applied. Let me know if this won't work.)

I don't think this will work well --- many reviewers (e.g. I am one of
them) rely on being able to apply patches and inspect them locally.
See the Discussion and MUA-Specific Hints sections of git-format-patch(1)
for some hints about how to accomplish that.

Patch left unsnipped for reference.

Thanks,
Jonathan

> To ensure that `git prune` does not remove refs checked out
> in other worktrees, we need to include these HEADs in the
> set of roots. This adds the iteration function necessary
> to do this.
> 
> Signed-off-by: Manish Goregaokar <manishearth@gmail.com>
> ---
>  refs.c | 16 ++++++++++++++++
>  refs.h |  1 +
>  2 files changed, 17 insertions(+)
> 
> diff --git a/refs.c b/refs.c
> index 2d71774..27e0b60 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3,6 +3,7 @@
>   */
> 
>  #include "cache.h"
> +#include "commit.h"
>  #include "lockfile.h"
>  #include "refs.h"
>  #include "refs/refs-internal.h"
> @@ -1157,6 +1158,21 @@ int head_ref(each_ref_fn fn, void *cb_data)
>      return head_ref_submodule(NULL, fn, cb_data);
>  }
> 
> +int for_each_worktree_ref(each_ref_fn fn, void *cb_data)
> +{
> +    int i, flag, retval;
> +    struct object_id oid;
> +    struct worktree **worktrees = get_worktrees(GWT_SORT_LINKED);
> +    for (i = 0; worktrees[i]; i++) {
> +        struct commit* commit =
> lookup_commit_reference(worktrees[i]->head_sha1);
> +        oid = commit->object.oid;
> +        if (!read_ref_full("HEAD", RESOLVE_REF_READING, oid.hash, &flag)) {
> +            if (retval = fn("HEAD", &oid, flag, cb_data))
> +                return retval;
> +        }
> +    }
> +}
> +
>  /*
>   * Call fn for each reference in the specified submodule for which the
>   * refname begins with prefix. If trim is non-zero, then trim that
> diff --git a/refs.h b/refs.h
> index 9fbff90..425a853 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -192,6 +192,7 @@ typedef int each_ref_fn(const char *refname,
>   * stop the iteration.
>   */
>  int head_ref(each_ref_fn fn, void *cb_data);
> +int for_each_worktree_ref(each_ref_fn fn, void *cb_data);
>  int for_each_ref(each_ref_fn fn, void *cb_data);
>  int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data);
>  int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data,
> -- 
> 2.10.1

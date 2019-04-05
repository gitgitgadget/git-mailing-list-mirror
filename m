Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B686F20248
	for <e@80x24.org>; Fri,  5 Apr 2019 09:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbfDEJkC (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 05:40:02 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46997 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbfDEJkC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 05:40:02 -0400
Received: by mail-io1-f66.google.com with SMTP id p23so3854897iol.13
        for <git@vger.kernel.org>; Fri, 05 Apr 2019 02:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X+FnOGwEobQ+exCtw4sxRSw0RKzILCnY8q/bEE5Gj9U=;
        b=lSaDOG9/35QqeDsf21QBegpjLYNCk3Fj3ANcm5K7MJthNwr8jJsqKX2JVUZHBvKSPB
         yG/6q7T2uWv19Jza0wMes/xr93PhK0dRybp6R31MwsM3tQBq4W6bvI+u7uDhKdhqZk5b
         8lzp2WwSaMJw+HWPjuiLBApvfUcF0365Djt1zWfZ9NCs3y8Yq14gXynn+Rr3MsSPA264
         ftsdzZWle9kSoRDsx9DYDVXw48ovGj/mNxjbRofIvtDgQ8z+3jpZ3h8zIWtcWhDaQiEn
         uPtutfIFsGdAXqG9FQgjS9HwVlSbQvf3Zzh+fr+4ipyruLzJyOPZmiiS2XHbhk4F+e8K
         REQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X+FnOGwEobQ+exCtw4sxRSw0RKzILCnY8q/bEE5Gj9U=;
        b=nXa2OpQ6oFDQlxVurcCkvSqX3YRAW21UGm8/oJfSZ+ZS+kVQbwIr3LIGDZOxYgIBqu
         bxz4dFzwLthWwfdO/FNkWwD7UqyFQTQEN6L3YEock5tA0iB8bDJgPTTHs8A0fFbGthwR
         ffuevdNwuTQxS/Iyts9NfXrtXhyKWCTVZY9q8A+KAeDjLjEOFzuSmYVlezpglI84Dhxf
         guphrwMl2hY+7DH9sbzFKqBKManK55F9dP8PBKU4K/aNjB7AcmKLHh6KCpCkjlBy3Wzh
         m1JeqLLKpRd9390maNbXDBDZT7kKzRT/1co3nHD1KZCQlP0Hy61zlewX6kYfBYn6Z7J+
         Sv4g==
X-Gm-Message-State: APjAAAXgR//FfibQFoBNfiM/MwDGMICG5X/wbGMV34u9K2g51lRbuzkG
        h7MW8pEYDEiTiYcJnXinKXiv5xFoM6qokLx49G3E0Q==
X-Google-Smtp-Source: APXvYqwe3DrmVSaQe6Gf85BkDDXHjpuTFBBv2Vs19AifMM6gF+iIt/4OM/dPiniO2FQwgbiaXPX3n1VcJVB/erSmiFw=
X-Received: by 2002:a5e:8418:: with SMTP id h24mr7619888ioj.170.1554457200518;
 Fri, 05 Apr 2019 02:40:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190326220906.111879-1-jonathantanmy@google.com>
 <cover.1553895166.git.jonathantanmy@google.com> <44de02e584f449481e6fb00cf35d74adf0192e9d.1553895166.git.jonathantanmy@google.com>
In-Reply-To: <44de02e584f449481e6fb00cf35d74adf0192e9d.1553895166.git.jonathantanmy@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 5 Apr 2019 16:39:34 +0700
Message-ID: <CACsJy8CgXLZxqab4vcP1jh3OMCGh1i=easb5BpCs1J8Uf_jsxw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] diff: batch fetching of missing blobs
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 30, 2019 at 4:40 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> When running a command like "git show" or "git diff" in a partial clone,
> batch all missing blobs to be fetched as one request.
>
> This is similar to c0c578b33c ("unpack-trees: batch fetching of missing
> blobs", 2017-12-08), but for another command.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  diff.c                        |  32 +++++++++++
>  t/t4067-diff-partial-clone.sh | 103 ++++++++++++++++++++++++++++++++++
>  2 files changed, 135 insertions(+)
>  create mode 100755 t/t4067-diff-partial-clone.sh
>
> diff --git a/diff.c b/diff.c
> index ec5c095199..1eccefb4ef 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -25,6 +25,7 @@
>  #include "packfile.h"
>  #include "parse-options.h"
>  #include "help.h"
> +#include "fetch-object.h"
>
>  #ifdef NO_FAST_WORKING_DIRECTORY
>  #define FAST_WORKING_DIRECTORY 0
> @@ -6366,8 +6367,39 @@ void diffcore_fix_diff_index(void)
>         QSORT(q->queue, q->nr, diffnamecmp);
>  }
>
> +static void add_if_missing(struct oid_array *to_fetch,
> +                          const struct diff_filespec *filespec)
> +{
> +       if (filespec && filespec->oid_valid &&
> +           oid_object_info_extended(the_repository, &filespec->oid, NULL,

I'm quite sure we can pass 'struct repository *' around in diff code
now. I think it's the "repo" field in "struct diff_options". Please
use it and avoid more references to the_repository.

> +                                    OBJECT_INFO_FOR_PREFETCH))
> +               oid_array_append(to_fetch, &filespec->oid);
> +}
> +
>  void diffcore_std(struct diff_options *options)
>  {
> +       if (repository_format_partial_clone) {
> +               /*
> +                * Prefetch the diff pairs that are about to be flushed.
> +                */
> +               int i;
> +               struct diff_queue_struct *q = &diff_queued_diff;
> +               struct oid_array to_fetch = OID_ARRAY_INIT;
> +
> +               for (i = 0; i < q->nr; i++) {
> +                       struct diff_filepair *p = q->queue[i];
> +                       add_if_missing(&to_fetch, p->one);
> +                       add_if_missing(&to_fetch, p->two);
> +               }
> +               if (to_fetch.nr)
> +                       /*
> +                        * NEEDSWORK: Consider deduplicating the OIDs sent.
> +                        */
> +                       fetch_objects(repository_format_partial_clone,
> +                                     to_fetch.oid, to_fetch.nr);
> +               oid_array_clear(&to_fetch);
> +       }
> +
>         /* NOTE please keep the following in sync with diff_tree_combined() */
>         if (options->skip_stat_unmatch)
>                 diffcore_skip_stat_unmatch(options);
> diff --git a/t/t4067-diff-partial-clone.sh b/t/t4067-diff-partial-clone.sh
> new file mode 100755
> index 0000000000..349851be7d
> --- /dev/null
> +++ b/t/t4067-diff-partial-clone.sh
> @@ -0,0 +1,103 @@
> +#!/bin/sh
> +
> +test_description='behavior of diff when reading objects in a partial clone'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'git show batches blobs' '
> +       test_when_finished "rm -rf server client trace" &&
> +
> +       test_create_repo server &&
> +       echo a >server/a &&
> +       echo b >server/b &&
> +       git -C server add a b &&
> +       git -C server commit -m x &&
> +
> +       test_config -C server uploadpack.allowfilter 1 &&
> +       test_config -C server uploadpack.allowanysha1inwant 1 &&
> +       git clone --bare --filter=blob:limit=0 "file://$(pwd)/server" client &&
> +
> +       # Ensure that there is exactly 1 negotiation by checking that there is
> +       # only 1 "done" line sent. ("done" marks the end of negotiation.)
> +       GIT_TRACE_PACKET="$(pwd)/trace" git -C client show HEAD &&
> +       grep "git> done" trace >done_lines &&
> +       test_line_count = 1 done_lines
> +'
> +
> +test_expect_success 'diff batches blobs' '
> +       test_when_finished "rm -rf server client trace" &&
> +
> +       test_create_repo server &&
> +       echo a >server/a &&
> +       echo b >server/b &&
> +       git -C server add a b &&
> +       git -C server commit -m x &&
> +       echo c >server/c &&
> +       echo d >server/d &&
> +       git -C server add c d &&
> +       git -C server commit -m x &&
> +
> +       test_config -C server uploadpack.allowfilter 1 &&
> +       test_config -C server uploadpack.allowanysha1inwant 1 &&
> +       git clone --bare --filter=blob:limit=0 "file://$(pwd)/server" client &&
> +
> +       # Ensure that there is exactly 1 negotiation by checking that there is
> +       # only 1 "done" line sent. ("done" marks the end of negotiation.)
> +       GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff HEAD^ HEAD &&
> +       grep "git> done" trace >done_lines &&
> +       test_line_count = 1 done_lines
> +'
> +
> +test_expect_success 'diff skips same-OID blobs' '
> +       test_when_finished "rm -rf server client trace" &&
> +
> +       test_create_repo server &&
> +       echo a >server/a &&
> +       echo b >server/b &&
> +       git -C server add a b &&
> +       git -C server commit -m x &&
> +       echo another-a >server/a &&
> +       git -C server add a &&
> +       git -C server commit -m x &&
> +
> +       test_config -C server uploadpack.allowfilter 1 &&
> +       test_config -C server uploadpack.allowanysha1inwant 1 &&
> +       git clone --bare --filter=blob:limit=0 "file://$(pwd)/server" client &&
> +
> +       echo a | git hash-object --stdin >hash-old-a &&
> +       echo another-a | git hash-object --stdin >hash-new-a &&
> +       echo b | git hash-object --stdin >hash-b &&
> +
> +       # Ensure that only a and another-a are fetched.
> +       GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff HEAD^ HEAD &&
> +       grep "want $(cat hash-old-a)" trace &&
> +       grep "want $(cat hash-new-a)" trace &&
> +       ! grep "want $(cat hash-b)" trace
> +'
> +
> +test_expect_success 'diff with rename detection batches blobs' '
> +       test_when_finished "rm -rf server client trace" &&
> +
> +       test_create_repo server &&
> +       echo a >server/a &&
> +       printf "b\nb\nb\nb\nb\n" >server/b &&
> +       git -C server add a b &&
> +       git -C server commit -m x &&
> +       rm server/b &&
> +       printf "b\nb\nb\nb\nbX\n" >server/c &&
> +       git -C server add c &&
> +       git -C server commit -a -m x &&
> +
> +       test_config -C server uploadpack.allowfilter 1 &&
> +       test_config -C server uploadpack.allowanysha1inwant 1 &&
> +       git clone --bare --filter=blob:limit=0 "file://$(pwd)/server" client &&
> +
> +       # Ensure that there is exactly 1 negotiation by checking that there is
> +       # only 1 "done" line sent. ("done" marks the end of negotiation.)
> +       GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff -M HEAD^ HEAD >out &&
> +       grep "similarity index" out &&
> +       grep "git> done" trace >done_lines &&
> +       test_line_count = 1 done_lines
> +'
> +
> +test_done
> --
> 2.21.0.197.gd478713db0
>


-- 
Duy

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8209C1F42D
	for <e@80x24.org>; Thu, 31 May 2018 15:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755450AbeEaPol (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 11:44:41 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:39320 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755417AbeEaPok (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 11:44:40 -0400
Received: by mail-lf0-f66.google.com with SMTP id t134-v6so10435206lff.6
        for <git@vger.kernel.org>; Thu, 31 May 2018 08:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=m5zDK/JoK3mdHKu4nmpLJ9/u/qbHY88o3irmsDycDHw=;
        b=nw9Yu7ZigIRdBhl5Q1eBYzHgEkCws2+1pQOb7HLY5aslNhAbmQ55A40hZPcviHPM3L
         4sjnfQe2Hw/UfJFhermnj+EJ+3pP/j2bKnyv/S9NBeLG5WQc3aeM2GveQSHAZwwHGPW9
         5HxV+DxbuRDsXA8/lKd7sbbJ9u2qeEPeySDSSzSWYzbH7WRhBwTeST87mlWLXLBfO//w
         MJK28JTNh8t1EhJep6cu2FsHVeRxxZJh7xnhM+d9FCTpbfBQE/54sLKgydGONRI/N51G
         7gAN22Zl+TkPpqo+Xv9kyKME3vxWHCe6rp30vPBUvtFxO2Ap3guh1Je2F4z8zYL9XJLt
         LZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=m5zDK/JoK3mdHKu4nmpLJ9/u/qbHY88o3irmsDycDHw=;
        b=FGj0+vKFnmkEJjLIgL2/GZ2ZL6W4I9dwWJUJyP7QxUSS3njEe03Roo+58K17L5bYnD
         89LuJ/tZc1fxjsPdLqvAVD0dYiDxjH6EO9DO64co0eg4fc3NRVUBjOo760QeSnR0ueph
         V0MCPw2C7527DOEhF1P+Fx0Ekl4kq0+MPmrgxd6cY+srwQY6nbVVBDmv05SckkNTRK/a
         fb6q5NytWOp/f5s3bBcxxb2KhMX7Pb1vs/BvDbo3KEc+2MG2D4Nt/qBagJ+yymzObhpX
         AHFj9lczAvkmZfRz7wVYDT91f/Cob0eJSX/b6C9G9l4GmiUHwmQ+0c+F8GIQY5Ks0ex8
         ub9A==
X-Gm-Message-State: ALKqPwdPNR2mZRGfzRRkEhOw1U41V+EsNqbVYZggslt8LZmF6NDntD8Y
        Hk9C54DFg2eKLMj6IKH1bEYKZsaYFfFo6mwUOaAhzw==
X-Google-Smtp-Source: ADUXVKJZzURub6Ztx5J64l1jqJyR74Vzay9o6z9NWl7Gt+z9Q+AS6KGNvueq9pz55ricvCnEvwLLNcc3O2Yba0FIOzM=
X-Received: by 2002:a19:de0a:: with SMTP id v10-v6mr4415747lfg.94.1527781478203;
 Thu, 31 May 2018 08:44:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:90c:0:0:0:0:0 with HTTP; Thu, 31 May 2018 08:44:37 -0700 (PDT)
In-Reply-To: <20180531072339.GA43435@aiede.svl.corp.google.com>
References: <20180516225823.235426-1-bmwill@google.com> <20180516234822.182663-1-bmwill@google.com>
 <20180516234822.182663-2-bmwill@google.com> <20180531072339.GA43435@aiede.svl.corp.google.com>
From:   Brandon Williams <bmwill@google.com>
Date:   Thu, 31 May 2018 08:44:37 -0700
Message-ID: <CAKoko1peCNXq-2txoMfQ07FgFDOOcb8b9gMq1c1h9B8Le4kGww@mail.gmail.com>
Subject: Re: [PATCH] fetch: do not pass ref-prefixes for fetch by exact SHA1
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for finding this, I don't know how I missed moving that bit
over when factoring it out.  Well I guess I sort of rewrote it and
combined two pieces of logic so that's how.  Anyway, this looks right
and thanks for adding the test.

On Thu, May 31, 2018 at 12:23 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> When v2.18.0-rc0~10^2~1 (refspec: consolidate ref-prefix generation
> logic, 2018-05-16) factored out the ref-prefix generation code for
> reuse, it left out the 'if (!item->exact_sha1)' test in the original
> ref-prefix generation code. As a result, fetches by SHA-1 generate
> ref-prefixes as though the SHA-1 being fetched were an abbreviated ref
> name:
>
>  $ GIT_TRACE_PACKET=1 bin-wrappers/git -c protocol.version=2 \
>         fetch origin 12039e008f9a4e3394f3f94f8ea897785cb09448
> [...]
>  packet:        fetch> ref-prefix 12039e008f9a4e3394f3f94f8ea897785cb09448
>  packet:        fetch> ref-prefix refs/12039e008f9a4e3394f3f94f8ea897785cb09448
>  packet:        fetch> ref-prefix refs/tags/12039e008f9a4e3394f3f94f8ea897785cb09448
>  packet:        fetch> ref-prefix refs/heads/12039e008f9a4e3394f3f94f8ea897785cb09448
>  packet:        fetch> ref-prefix refs/remotes/12039e008f9a4e3394f3f94f8ea897785cb09448
>  packet:        fetch> ref-prefix refs/remotes/12039e008f9a4e3394f3f94f8ea897785cb09448/HEAD
>  packet:        fetch> 0000
>
> If there is another ref name on the command line or the object being
> fetched is already available locally, then that's mostly harmless.
> But otherwise, we error out with
>
>  fatal: no matching remote head
>
> since the server did not send any refs we are interested in.  Filter
> out the exact_sha1 refspecs to avoid this.
>
> This patch adds a test to check this behavior that notices another
> behavior difference between protocol v0 and v2 in the process.  Add a
> NEEDSWORK comment to clear it up.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Here's the change described in
> https://public-inbox.org/git/20180531010739.GB36515@aiede.svl.corp.google.com/
> as a proper patch.
>
> Thoughts of all kinds welcome, as always.
>
>  refspec.c             |  2 ++
>  refspec.h             |  4 ++++
>  t/t5516-fetch-push.sh | 19 +++++++++++++++++++
>  3 files changed, 25 insertions(+)
>
> diff --git a/refspec.c b/refspec.c
> index c59a4ccf1e..ada7854f7a 100644
> --- a/refspec.c
> +++ b/refspec.c
> @@ -202,6 +202,8 @@ void refspec_ref_prefixes(const struct refspec *rs,
>                 const struct refspec_item *item = &rs->items[i];
>                 const char *prefix = NULL;
>
> +               if (item->exact_sha1)
> +                       continue;
>                 if (rs->fetch == REFSPEC_FETCH)
>                         prefix = item->src;
>                 else if (item->dst)
> diff --git a/refspec.h b/refspec.h
> index 01b700e094..3a9363887c 100644
> --- a/refspec.h
> +++ b/refspec.h
> @@ -42,6 +42,10 @@ void refspec_clear(struct refspec *rs);
>  int valid_fetch_refspec(const char *refspec);
>
>  struct argv_array;
> +/*
> + * Determine what <prefix> values to pass to the peer in ref-prefix lines
> + * (see Documentation/technical/protocol-v2.txt).
> + */
>  void refspec_ref_prefixes(const struct refspec *rs,
>                           struct argv_array *ref_prefixes);
>
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index f4d28288f0..a5077d8b7c 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1121,6 +1121,25 @@ test_expect_success 'fetch exact SHA1' '
>         )
>  '
>
> +test_expect_success 'fetch exact SHA1 in protocol v2' '
> +       mk_test testrepo heads/master hidden/one &&
> +       git push testrepo master:refs/hidden/one &&
> +       git -C testrepo config transfer.hiderefs refs/hidden &&
> +       check_push_result testrepo $the_commit hidden/one &&
> +
> +       mk_child testrepo child &&
> +       git -C child config protocol.version 2 &&
> +
> +       # make sure $the_commit does not exist here
> +       git -C child repack -a -d &&
> +       git -C child prune &&
> +       test_must_fail git -C child cat-file -t $the_commit &&
> +
> +       # fetching the hidden object succeeds by default
> +       # NEEDSWORK: should this match the v0 behavior instead?
> +       git -C child fetch -v ../testrepo $the_commit:refs/heads/copy
> +'
> +
>  for configallowtipsha1inwant in true false
>  do
>         test_expect_success "shallow fetch reachable SHA1 (but not a ref), allowtipsha1inwant=$configallowtipsha1inwant" '
> --
> 2.17.1.1185.g55be947832
>

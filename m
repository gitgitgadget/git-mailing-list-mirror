Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD4B11F859
	for <e@80x24.org>; Tue,  9 Aug 2016 22:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbcHIWuy (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 18:50:54 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:34092 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932461AbcHIWuy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 18:50:54 -0400
Received: by mail-io0-f180.google.com with SMTP id q83so25787438iod.1
        for <git@vger.kernel.org>; Tue, 09 Aug 2016 15:50:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6qxJny/awY/jO8C0SfXzH9UaD8SfFQEcD41Rzeevoa4=;
        b=pg+uYxEq7An3g5pRR8yY9qMYDYv0IQvjkXzKrXZ102GL36J3KvqSDdzGVWzFKkMIk8
         eQRIr512rtlgV9Ulm/QcAVgKxnYHGHfowUr/igasYdJaDrjJP/scRMlPSm1/gVkzWrKp
         3q8xW/97R4BfZdv2M45hsBacsMyPAYqTY4k15eaN6WNZx2QT2/u+lnEg7qh7BD7I1voF
         ebxLnL8Jhm1Fr8Ad/CA4EG3cU5V7r7DkkYIuguXAR0QzzN+nhMS2ZZqigybJVrnuGuv5
         bGhjuivnMt1nDoJH9UTQMoQD2hrndSo8bpyFHSuDp+s6z67DanPmM+PZLP62npD2UEn1
         Zs4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6qxJny/awY/jO8C0SfXzH9UaD8SfFQEcD41Rzeevoa4=;
        b=ijRQzWOYs2+QoFZYji3oAKBlDTYM+M0VEYcL+l2l1/W8yGvq+XRJayIx7U7o8kyHcg
         IB/9861LTS8YeeZEMny8KkedwJVdkk11qEdzUTiIPkAH3h3l+SShvUsAwQz7MkJnGZgi
         wCXPkPiH9dot+abyR4AP3T86ChO70tRE8pH+z6T/o3M27aq0oXVA48XXFHB2tVVesnHQ
         fcY3QwHMuYlAx7O8ujSA+xMp8AQ4MqPel0hk1qrEBnQ7OcdRmx1Rl+0Jw0m8/0NNrtPD
         MT4+4hoNxbwVpcruqEr8cuf/YwZvxSbzkmKbY1ERVR8hIWgTkR+RLuAH+oyNJOB1JBlB
         xrEw==
X-Gm-Message-State: AEkoouv2XEsS7aR/2+lxzsS2TGbsvK0CXa4jmHODt2VEsSH451cKBMK0y2fHrDje9RotQxNWUq0zH5RTMEb2i6Iu
X-Received: by 10.107.178.129 with SMTP id b123mr1762589iof.83.1470783049008;
 Tue, 09 Aug 2016 15:50:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 9 Aug 2016 15:50:48 -0700 (PDT)
In-Reply-To: <20160809223219.17982-1-jacob.e.keller@intel.com>
References: <20160809223219.17982-1-jacob.e.keller@intel.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Tue, 9 Aug 2016 15:50:48 -0700
Message-ID: <CAGZ79kbzDhpsfpY8s=7O86_dNLA=VRkyC=8eiCqMambKvUnXmw@mail.gmail.com>
Subject: Re: [PATCH RFC] diff: add SUBMODULE_DIFF format to display submodule diff
To:	Jacob Keller <jacob.e.keller@intel.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 9, 2016 at 3:32 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
>
> For projects which have frequent updates to submodules it is often
> useful to be able to see a submodule update commit as a difference.
> Teach diff's --submodule= a new "diff" format which will execute a diff
> for the submodule between the old and new commit, and display it as
> a standard diff. This allows users to easily see what changed in
> a submodule without having to dig into the submodule themselves.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> There are no tests yet. Stefan suggested the use of child_process,

Well you said "I just want this one command but don't know where to put it "
so it's natural to suggest using child_process.  ;)

> but I
> really believe there has to be some way of getting the diff without
> having to run a sub process (as this means we also can't do the diff
> without a checked out submodule). It doesn't properly handle options
> either, so a better solution would be much appreciated.

Oh right, we would need to codify all options again (and all future options,
too)

>
> I also would prefer if the diff actually prefixed the files with
> "path/to/submodule" so that it was obvious where the file was located in
> the directory.
>
> Suggestions welcome.
>
> +
> +       if (start_command(&cp))

I wonder if we want to stay single-execution here,
i.e. if we rather want to use run_processes_parallel
for all the submodules at the same time?

Though then non deterministic ordering may be an issue.

> +               return -1;
> +
> +       if (strbuf_read(buf, cp.out, 0) < 0)

So we keep the whole diff in memory
I don't know much about the diff machinery, but I thought
the rest of the diff machinery just streams it out?

> +
> +void show_submodule_diff(FILE *f, const char *path,
> +               const char *line_prefix,
> +               unsigned char one[20], unsigned char two[20],
> +               unsigned dirty_submodule, const char *meta,
> +               const char *reset)
> +{
> +       struct strbuf buf = STRBUF_INIT;
> +       struct strbuf sb = STRBUF_INIT;
> +       const char *message = NULL;
> +
> +       if (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
> +               fprintf(f, "%sSubmodule %s contains untracked content\n",
> +                       line_prefix, path);
> +       if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
> +               fprintf(f, "%sSubmodule %s contains modified content\n",
> +                       line_prefix, path);
> +
> +       if (!hashcmp(one, two)) {
> +               strbuf_release(&sb);
> +               return;
> +       }
> +
> +       if (add_submodule_odb(path))
> +               message = "(not checked out)";

When not checked out, we can invoke the diff command
in .git/modules/<name> as that is the git dir of the submodule,
i.e. operating diff with a bare repo?

Thanks,
Stefan

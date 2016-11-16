Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50DDB2021E
	for <e@80x24.org>; Wed, 16 Nov 2016 01:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752445AbcKPBJC (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 20:09:02 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:36682 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750979AbcKPBJB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 20:09:01 -0500
Received: by mail-qk0-f173.google.com with SMTP id n21so157257169qka.3
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 17:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PPHcAdZSo9dzW8GjncW+XR5mhK3yzXePmJ+WLsw6HsA=;
        b=imdkVezZxIo59+jFjkEkGcAU8NjT8qqqgr6BCPiYaUtJuT1XGmHFHN+CU5TtqCslwq
         mbkdEHsAFu5uJNPa1K4mqpCFI75g5EhGsN5xLRkMwEmX0bqa0ahSK91S5GBIePTPBZro
         sdp/9EviJAaGOzBmGMnZEpZortSCyQ/MkLNJHah2LxhyvNqgCv1d+fd//0TSsqh9NhvI
         cAGY6CBLabvlGJvoxzZAe0z9f00fQDCdgXcEJd34CPH+GQaEdh/6vgyerOzFdYZe4m1j
         LFUQ7Hw4SP0EmZTeRUUuqhaoVbMttyHj9Wh1o+0ABK3JaG4ckieZd/B1eyJnwsCAVZSJ
         0eZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PPHcAdZSo9dzW8GjncW+XR5mhK3yzXePmJ+WLsw6HsA=;
        b=bDpxOTzhQLkMtNtWctDoWlRU57vOFsL/fzII+f2aPNsSWMbmSdzU1NrrYTTxybpCtl
         9YKG4n2h8aY/dA1ZowoCzmjPNJ2UosuGqDcMCiI5iLOQRbhr258GokDEjWlGrmCr6cHk
         TyMf0q5TrmNvuXnmDl8Y3NVf2oMf2MRCYf3rIRyBkpE9YldGbeXzUGA5sXZgl1oLzb3H
         gAFC1C7R1WH2UnDZcvI4jJrGJFhIdeAgSuVVDZRAkYH6erXXXiCFqSh7PUiZ7MuYidJ4
         EE96mMZWLWj+81XQbQWoLRTIB0Iv0Iv5LX01pO4h32Ihz5g74tn4a1dcjjW9uhJLlqvi
         cOYA==
X-Gm-Message-State: AKaTC03vTHT5dJX7crCER4wW8C5opSVXEAGCbJ+X1Lcb3qLHYmuXvEhGNgaV5dFkHZSb5+9/r+Zf8voYr6VC6AEX
X-Received: by 10.55.191.134 with SMTP id p128mr421355qkf.58.1479258540604;
 Tue, 15 Nov 2016 17:09:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Tue, 15 Nov 2016 17:09:00 -0800 (PST)
In-Reply-To: <1478908273-190166-6-git-send-email-bmwill@google.com>
References: <1477953496-103596-1-git-send-email-bmwill@google.com>
 <1478908273-190166-1-git-send-email-bmwill@google.com> <1478908273-190166-6-git-send-email-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 15 Nov 2016 17:09:00 -0800
Message-ID: <CAGZ79kbqZs+wQYUBnvdw1YhC4dtHeodJWdved+it2Zg076vyOA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] grep: enable recurse-submodules to work on <tree> objects
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 11, 2016 at 3:51 PM, Brandon Williams <bmwill@google.com> wrote:

> to:
> HEAD:file
> HEAD:sub/file

  Maybe indent this ;)

>  static struct argv_array submodule_options = ARGV_ARRAY_INIT;
> +static const char *parent_basename;
>
>  static int grep_submodule_launch(struct grep_opt *opt,
>                                  const struct grep_source *gs);
> @@ -535,19 +537,53 @@ static int grep_submodule_launch(struct grep_opt *opt,
>  {
>         struct child_process cp = CHILD_PROCESS_INIT;
>         int status, i;
> +       const char *end_of_base;
> +       const char *name;
>         struct work_item *w = opt->output_priv;
>
> +       end_of_base = strchr(gs->name, ':');
> +       if (end_of_base)
> +               name = end_of_base + 1;
> +       else
> +               name = gs->name;
> +
>         prepare_submodule_repo_env(&cp.env_array);
>
>         /* Add super prefix */
>         argv_array_pushf(&cp.args, "--super-prefix=%s%s/",
>                          super_prefix ? super_prefix : "",
> -                        gs->name);
> +                        name);
>         argv_array_push(&cp.args, "grep");
>
> +       /*
> +        * Add basename of parent project
> +        * When performing grep on a <tree> object the filename is prefixed
> +        * with the object's name: '<tree-name>:filename'.

This comment is hard to read as it's unclear what the <angle brackets> mean.
(Are the supposed to indicate a variable? If so why is file name not marked up?)

>  In order to
> +        * provide uniformity of output we want to pass the name of the
> +        * parent project's object name to the submodule so the submodule can
> +        * prefix its output with the parent's name and not its own SHA1.
> +        */
> +       if (end_of_base)
> +               argv_array_pushf(&cp.args, "--parent-basename=%.*s",
> +                                (int) (end_of_base - gs->name),
> +                                gs->name);

Do we pass this only with the tree-ish?
What if we are grepping the working tree and the file name contains a colon?

> +test_expect_success 'grep tree HEAD^' '
> +       cat >expect <<-\EOF &&
> +       HEAD^:a:foobar
> +       HEAD^:b/b:bar
> +       HEAD^:submodule/a:foobar
> +       EOF
> +
> +       git grep -e "bar" --recurse-submodules HEAD^ > actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'grep tree HEAD^^' '
> +       cat >expect <<-\EOF &&
> +       HEAD^^:a:foobar
> +       HEAD^^:b/b:bar
> +       EOF
> +
> +       git grep -e "bar" --recurse-submodules HEAD^^ > actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'grep tree and pathspecs' '
> +       cat >expect <<-\EOF &&
> +       HEAD:submodule/a:foobar
> +       HEAD:submodule/sub/a:foobar
> +       EOF
> +
> +       git grep -e "bar" --recurse-submodules HEAD -- submodule > actual &&
> +       test_cmp expect actual
> +'

Mind to add tests for
* recursive submodules (say 2 levels), preferrably not having the
  gitlink at the root each, i.e. root has a sub1 at path subs/sub1 and
sub1 has a sub2
  at path subs/sub2, such that recursing would produce a path like
  HEAD:subs/sub1/subs/sub2/dir/file ?
* file names with a colon in it
* instead of just HEAD referencing trees, maybe a sha1 referenced test as well
  (though it is not immediately clear what the benefit would be)
* what if the submodule doesn't have the commit referenced in the given sha1

Thanks,
Stefan

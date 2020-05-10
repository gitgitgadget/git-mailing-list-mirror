Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F03DC38A2A
	for <git@archiver.kernel.org>; Sun, 10 May 2020 21:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 496122082E
	for <git@archiver.kernel.org>; Sun, 10 May 2020 21:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKxsmDPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbgEJVvs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 17:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727771AbgEJVvs (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 May 2020 17:51:48 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CCBC061A0C
        for <git@vger.kernel.org>; Sun, 10 May 2020 14:51:46 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id d7so7526679ioq.5
        for <git@vger.kernel.org>; Sun, 10 May 2020 14:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BT55QqQD9Mcvao5GsfKOfLB0lt2qrBLGGjgvVVHmJL0=;
        b=EKxsmDPgQ3HtaTpTxpJ5KHLi0XaDCFKEvr3q7JwU7oostnn5/Yb5GmY5UELknVDZM2
         W7mVpfwmCkP6XBmIEDxv9BCajI9YLRopOYRsUhgpgklYVV53Vzqd+deuqSOxPuRd/ico
         j9ml+tz+ro48+JRja10Eq+DE+tREVatk5+TAEIzkl0/l3mHcbpyz5f3KhwodQ45PFzN8
         bt6ygn/aecd/GHNeD+urF3kYCybXfMuJSCHfBLlPadCzJzR2V845dtK/z09VI8Gm7FHa
         0MIMBE158o6ZIy/zJUtDhuT2W22koIK73p/aXkJOzEVu0dxS3aec3ezfYNQg8kGuI2sM
         WGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BT55QqQD9Mcvao5GsfKOfLB0lt2qrBLGGjgvVVHmJL0=;
        b=c9htm0eyKVF2cAfNlNLAhgaECYlDt7ngiXW5yr4cU3tDYCPbyUOCy9myVn22HOchwP
         1FC+eDUgzJuf4b2Sct0OX9YztmNxGyrv9p8M9va1d0Uhwo1512AeGM3u2WoepfqN4Keh
         iqF6A5Iq8KkWJjHcJ/4mjJNt+LlvtMJNJy8hvU6Iq5BUx/mD2hYR/cLxcHeULLQ3idEx
         AWvpnE7+UiLu06UF2q3hZQkZ39wOpC1Mc+bl1q7u8Q/6ITaE+QYGasDcE4thkiXSrhZF
         H4wun6/v29KTby7wiG90Ke2b60CGc1aW7ikN/pwvh8ttDtNxkS8QTdNeiuvQC5P212z/
         EDKQ==
X-Gm-Message-State: AGi0PuZONhzVT4UlMpx7/N7BKkQBgs0od9Fi9O8DIhO0pGdcLY/1cf+i
        C1PtL3aktN7HiiX3HY4IxQXRwfH762AeTqKvrwQ=
X-Google-Smtp-Source: APiQypJTc/oy5yWNdKxTI7Cq3ta2c6YCUYduiSnJyyNhY5R+KHtH7MOoDHwfW3KplFPicYZn0PL55Vq5hF2VraKuxzM=
X-Received: by 2002:a6b:3c0a:: with SMTP id k10mr12628392iob.10.1589147505202;
 Sun, 10 May 2020 14:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.631.git.1589099162707.gitgitgadget@gmail.com> <20200510164424.GA11784@konoha>
In-Reply-To: <20200510164424.GA11784@konoha>
From:   Guillaume Galeazzi <guillaume.galeazzi@gmail.com>
Date:   Sun, 10 May 2020 23:51:35 +0200
Message-ID: <CAOEXN9yyL8T8kDmpHKTjjaG9tVS1kh34B-=PuH1hRaA7jF_K6A@mail.gmail.com>
Subject: Re: [PATCH] submodule--helper.c: add only-active to foreach
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     gitgitgadget@gmail.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya

>
> > On repository with some submodule not active, it could be needed to run
> > a command only for active submodule. Today it can be achived with the
> > command:
>
> Spelling: achive -> achieve
agree

> Maybe we can keep the commit message a bit more imperative?
> Something like:
> -------------------------
> On a repository with some submodules not active, one may need to run a
> command only for an active submodule or vice-versa. To achieve this,
> one may use:
> git submodule foreach 'git -C $toplevel submodule--helper is-active \
> $sm_path && pwd || :'
>
> Simplify this expression to make it more readable and easy-to-use by
> adding the flag `--is-active` to subcommand `foreach` of `git
> submodule`. Thus, simplifying the above command to:
> git submodule--helper foreach --is-active pwd
> -------------------------
Agree with the changes except vice-versa. The original patch support only
iterate the active submodule.

> Yes, maybe renaming the flag to `--is-active` would make it a tad bit
> simpler?
is-active sound more like a question to me but I can change it.

> This commit message may not be perfect but it seems like an
> improvement over the previous one?
yes definitely

> To me this option seems good. It may have some good utility in the
> future. Similarly, we may change the struct to:
>         struct foreach_cb {
>         const char *prefix;
>         int quiet;
>         int recursive;
>         int is_active;
>          };
>
> Therefore, the if-statement becomes:
>         if (info->is_active && !is_submodule_active(the_repository, path))
>                 return;
>
> BTW what do we return here, could you please be more specific?
This is a void function, returning here mean we will not execute the
command. Should I add a
comment like:
                return;  // skip this submodule and go to next one
but maybe it would be more readable to create a intermediate function
which handle only the
filtering part. Is it what you mean?

> Again, the change here as well:
>                 OPT_BOOL(0, "is-active", &info.is_active,
>
> Here, too:
>                 N_("git submodule--helper foreach [--quiet] [--recursive] [--is-active] [--] <command>"),
>
> And,
>         test_expect_success 'test "submodule--helper foreach --is-active" usage' '
>
> Finally,
>         git submodule--helper foreach --is-active "echo \$toplevel-\$name-\$path-\$sha1" > ../actual
>
> What do you think?
>
> Regards,
> Shourya Shukla

Now with the vice-versa idea in mind, I think it is maybe better to
change a bit the original patch
to add the option to execute command only on inactive submodule as
well. Could someone need
that in future?

Basically this would mean:

On struct foreach_cb instead of only_active adding field:
        int active;

Defining some macro to hold possible value:
        #define FOREACH_ACTIVE 1
        #define FOREACH_INACTIVE 0
        #define FOREACH_ACTIVE_NOT_SET -1

Changing the FOREACH_CB_INIT to
        #define FOREACH_CB_INIT { 0, NULL, NULL, 0, 0, FOREACH_ACTIVE_NOT_SET }

The filter become:
int is_active;
if (FOREACH_ACTIVE_NOT_SET != info->active) {
        is_active = is_submodule_active(the_repository, path);
        if ((is_active && (FOREACH_ACTIVE != info->active)) ||
            (!is_active && (FOREACH_ACTIVE == info->active)))
                return;
}

It need two additionnal function to parse the argument:
static int parse_active(const char *arg)
{
        int active = git_parse_maybe_bool(arg);

        if (active < 0)
                die(_("invalid --active option: %s"), arg);

        return active;
}

static int parse_opt_active_cb(const struct option *opt, const char *arg,
                               int unset)
{
        if (unset)
                *(int *)opt->value = FOREACH_ACTIVE_NOT_SET;
        else if (arg)
                *(int *)opt->value = parse_active(arg);
        else
                *(int *)opt->value = FOREACH_ACTIVE;

        return 0;
}

And the option OPT_BOOL become a OPT_CALLBACK_F:
OPT_CALLBACK_F(0, "active", &info.active, "true|false",
        N_("Call command depending on submodule active state"),
        PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
        parse_opt_active_cb),

The help git_submodule_helper_usage:
N_("git submodule--helper foreach [--quiet] [--recursive]
[--active[=true|false]] [--] <command>"),

the added test change to:
git submodule--helper foreach --active "echo
\$toplevel-\$name-\$path-\$sha1" > ../actual

and adding a test for the inactive submodule:
cat > expect <<EOF
Entering 'sub1'
$pwd/clone-foo1-sub1-$sub1sha1
EOF

test_expect_success 'test "submodule--helper foreach --active=false" usage' '
test_when_finished "git -C clone config --unset submodule.foo1.active" &&
(
cd clone &&
git config --bool submodule.foo1.active "false" &&
git submodule--helper foreach --only-active "echo
\$toplevel-\$name-\$path-\$sha1" > ../actual
git submodule--helper foreach --active=false "echo
\$toplevel-\$name-\$path-\$sha1" > ../actual
) &&
test_i18ncmp expect actual
'

What do you think?

Regards,
Guillaume

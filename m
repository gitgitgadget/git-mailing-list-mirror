Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C6151F991
	for <e@80x24.org>; Mon, 31 Jul 2017 21:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751625AbdGaVmK (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 17:42:10 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:33760 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbdGaVmI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 17:42:08 -0400
Received: by mail-lf0-f52.google.com with SMTP id d17so51351863lfe.0
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 14:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=G2D5aUqURjNN8iMPVlt2+Gm1aLB7TRzRHEkl/5ukP3o=;
        b=ApDMuqmkxpf6USTdqNJpXImhaAdV0xlAPznFgZRJ6GdzjzzdMMsZpTn79OTQAr/7I/
         zw5oPie2mQ/hDep84Qlz7RvMDWQAHBvD66wuHqFbTAjmP7n+PB/YzACvCoUOrZklYTfT
         27kRPCYNFEfCvKwA1mCUOs/TPT3E4f9HDzGa6O0jq5/Fd9jS5lyO7QGKsvU6Lp2DXrxz
         9nkCzdipMJz5pCQerK2LgMR3aBnn+OEayI1Lv4CnvlyP0UPjvaGwACpZiBO5iM8StEKo
         aeyFTwgO0WuVwXhVN6HDncOwrSQ1KS158AL3EaC+2FjtON36SV/lYM4R52df0OSytqlp
         /gng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=G2D5aUqURjNN8iMPVlt2+Gm1aLB7TRzRHEkl/5ukP3o=;
        b=A/1znPPROsnr5oIka50S0aYXiopdmMNi8Z7ckMW17i3ZFhzF4Tm/ekCOnFj66IvPET
         PUDjdbZvvAYI1CmagvmvFDbY9Vv/v2UEylJ9wl+Fzkw7htWamf1jVlTuPFp4JlARR60n
         yf2N4mlvpviUTv5yelPTSqAOT3jfQrX4r9c9ShelW8qoKi+WeN+EClzu3PouuXeJ6Z2R
         Xra9zFq0CU1xIhGVlL2kIe4RBT3RLCE9ETPd3ZAXyayDt/bkdG6+u0/pEZ56YDflGXix
         YIsz90r+iHLXYsgcCKTviVLYan0FhEsj8mEQnr7pqBV1idadJtLBbjjaF0Hui5STaVVg
         BH9w==
X-Gm-Message-State: AIVw112cU+T4wgky3HtzsLGTbBzmD/p5aLRwmeGDEoMbVX0GmIwxQ53W
        giZZ8UpXTzqu/p+J2m+itscX91RrSq2s
X-Received: by 10.25.204.149 with SMTP id c143mr4961390lfg.195.1501537327067;
 Mon, 31 Jul 2017 14:42:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Mon, 31 Jul 2017 14:42:06 -0700 (PDT)
In-Reply-To: <20170731205621.24305-7-pc44800@gmail.com>
References: <20170731205621.24305-1-pc44800@gmail.com> <20170731205621.24305-7-pc44800@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 31 Jul 2017 14:42:06 -0700
Message-ID: <CAGZ79kbyyR54me_+wQDZRrikqKTp_a98yozVfr8P85QHfyyy=Q@mail.gmail.com>
Subject: Re: [GSoC][PATCH 06/13] submodule: port submodule subcommand 'deinit'
 from shell to C
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 31, 2017 at 1:56 PM, Prathamesh Chavan <pc44800@gmail.com> wrote:
> The same mechanism is used even for porting this submodule
> subcommand, as used in the ported subcommands till now.
> The function cmd_deinit in split up after porting into three
> functions: module_deinit(), for_each_submodule_list() and
> deinit_submodule().
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
> In this new version, the following changes have been made:
> * In the function deinit_submodule, since the test is_git_directory()
>   adds an additional condition, instead is_directory() is used to check
>   if "sm_path/.git" is a directory.

Thanks for writing these patches.
I wonder if (some of) these notes are best put into the code
as a comment such as

    /* NEEDSWORK: convert to is_submodule_active */

such that people reading this code later realize that checking
for a directory may not be the "correct" thing, but a thing which
was easy to express using shell.

> +struct deinit_cb {
> +       const char *prefix;
> +       unsigned int quiet: 1;
> +       unsigned int force: 1;
> +       unsigned int all: 1;

The value 'all' seems to be unused, i.e. we assign it but never read it?

> +};
> +#define DEINIT_CB_INIT { NULL, 0, 0, 0 }
> +
> +static void deinit_submodule(const struct cache_entry *list_item,
> +                            void *cb_data)
> +{
> +       struct deinit_cb *info = cb_data;
> +       const struct submodule *sub;
> +       char *displaypath = NULL;
> +       struct child_process cp_config = CHILD_PROCESS_INIT;
> +       struct strbuf sb_config = STRBUF_INIT;
> +       char *sub_git_dir = xstrfmt("%s/.git", list_item->name);
> +       mode_t mode = 0777;
> +
> +       sub = submodule_from_path(null_sha1, list_item->name);
> +
> +       if (!sub || !sub->name)
> +               goto cleanup;
> +
> +       displaypath = get_submodule_displaypath(list_item->name, info->prefix);
> +
> +       /* remove the submodule work tree (unless the user already did it) */
> +       if (is_directory(list_item->name)) {
> +               struct stat st;
> +               /* protect submodules containing a .git directory */

Here may a good place to put:
  /* NEEDSWORK: automatically call absorbgitdirs before warning/die. */
(It was not in the shell version, so feel free to ignore)

> +               if (!info->force) {
> +                       struct child_process cp_rm = CHILD_PROCESS_INIT;
> +                       cp_rm.git_cmd = 1;
> +                       argv_array_pushl(&cp_rm.args, "rm", "-qn",
> +                                        list_item->name, NULL);

A bug that exists in the shell version as well as here:
What if the submodule has the name '--cached', which happens
to be a valid argument for git-rm?

The call to git-rm would die claiming that the <file> is missing,
as the file name was miss-interpreted as another flag.

To solve this problem we would insert a '--' after the options,
before the file name to state that the last argument is a <file>.

Not sure if we want to fix the bug while we're here or if we rather
want to add

    /* NEEDSWORK: add '--' to confirm <file> argument */

> +       if (mkdir(list_item->name, mode))
> +               die(_("could not create empty submodule directory %s"),
> +                     displaypath);

In the shell version we used the shell mkdir, which on failure
would print the error to stderr on its own. The added "|| say"
is just to clarify the bigger picture.

mkdir in C doesn't print the actual error (e.g.
no diskspace, permissions) so we have to do it.
Use 'die_errno' instead as then the reason will be given as well.

> +       cp_config.git_cmd = 1;
> +       argv_array_pushl(&cp_config.args, "config", "--get-regexp", NULL);
> +       argv_array_pushf(&cp_config.args, "submodule.%s\\.", sub->name);

It would be nice if the commit message could give hints as why a literal
translation was chosen here and not e.g. one of the builtin config
calls, as that would omit spawning a process.

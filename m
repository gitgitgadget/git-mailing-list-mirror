Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4CD220288
	for <e@80x24.org>; Wed, 19 Jul 2017 14:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752269AbdGSOEg (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jul 2017 10:04:36 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:32979 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751448AbdGSOEf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2017 10:04:35 -0400
Received: by mail-qt0-f174.google.com with SMTP id n42so2356642qtn.0
        for <git@vger.kernel.org>; Wed, 19 Jul 2017 07:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Q1+deu2TSMlwo6ke91LoBlzvQNx3VDevfPcpi4hblTk=;
        b=JtMeUMZ/iB9WZbCE7lgHWfZDz+UdgushtK+XebqC92mUMOStEcwi7uBUQq0vLgYJGu
         Og95xnBZeU03VVZ3RT5NC+GD4AH1WLsJtilsQx7dOBDq1CtTWVFB2siR3tK/7X+y1nJg
         S8b8sNCUrzek5Xik28I9ksMSEbZQysdYdbDGzZPTzsc8gCTo7P7HP1h5v0uvKjDFikal
         ZUgnTlLwoVVNkHI2Rh0iW+6ZTZHfGxGTgETsHNXoJYX5IQNudqWD0LT78zpp+8s6SVFK
         3aF4Hcwte5sRsRURKakikEqzhbxtRLkQDiwszYvx6OCbp6Nhhc9mB5Guf0GG3y5DnJJX
         wLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Q1+deu2TSMlwo6ke91LoBlzvQNx3VDevfPcpi4hblTk=;
        b=n4rmRfIShnbH0yE5+MK2cnlxDnqxuW7e3MWFppCxYxBYC18idVHrpjODV+eFEFRxTh
         ruhtMxwvlDGWKEsd6TZ1xJgg4rvXyltjtgYFwysXCdeuexd8txAdPZYe9NGz1wux7FXY
         /AXZezj10uvtldz5ByftWzM4neNkJFUIPsjbAiGWjeuK81lhY5OBbvtwVc3tsn3JvVul
         uHSZ0d3gJwILgxZVpVGvs2C3nBDR2b85NmvRCbum7H8u9K/lLMV1r6FFY3mKVJ2N+JeX
         dh4uGH6gTbl5J19fTQ3bxesATnHVGSR0/v3afMr6rzTL3tDs7HbH+kEnj/A7tGb1NDX5
         VWZw==
X-Gm-Message-State: AIVw1123U+v/TE+ENWtNaF/fc14Y4EXL5uSSh0RAFRnHCsK+UdDvRVx5
        ZIQE8IbGYZ48XU7wmZ7IqYa/wGmiJw==
X-Received: by 10.55.160.15 with SMTP id j15mr270854qke.324.1500473074325;
 Wed, 19 Jul 2017 07:04:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.31.13 with HTTP; Wed, 19 Jul 2017 07:04:33 -0700 (PDT)
In-Reply-To: <20170718204904.3768-7-pc44800@gmail.com>
References: <20170718204904.3768-1-pc44800@gmail.com> <20170718204904.3768-7-pc44800@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 19 Jul 2017 16:04:33 +0200
Message-ID: <CAP8UFD07w=57kTazLxrEYUq5jaCDp0B3SJevZM3BBoUhsJUj=w@mail.gmail.com>
Subject: Re: [GSoC][PATCH 6/8] submodule: port submodule subcommand 'deinit'
 from shell to C
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 18, 2017 at 10:49 PM, Prathamesh Chavan <pc44800@gmail.com> wrote:

> +static void deinit_submodule(const struct cache_entry *list_item,
> +                            void *cb_data)
> +{
> +       struct deinit_cb *info = cb_data;
> +       const struct submodule *sub;
> +       char *displaypath = NULL;
> +       struct child_process cp_config = CHILD_PROCESS_INIT;
> +       struct strbuf sb_config = STRBUF_INIT;
> +       char *sm_path = xstrdup(list_item->name);

If I understood the previous rounds correctly, list_item->name is
duplicated because it is changed below...

> +       char *sub_git_dir = xstrfmt("%s/.git", sm_path);
> +       struct stat st;
> +
> +       sub = submodule_from_path(null_sha1, sm_path);
> +
> +       if (!sub || !sub->name)
> +               goto cleanup;
> +
> +       displaypath = get_submodule_displaypath(sm_path, info->prefix);
> +
> +       /* remove the submodule work tree (unless the user already did it) */
> +       if (is_directory(sm_path)) {
> +               /* protect submodules containing a .git directory */
> +               if (is_git_directory(sub_git_dir))
> +                       die(_("Submodule work tree '%s' contains a .git "
> +                             "directory use 'rm -rf' if you really want "
> +                             "to remove it including all of its history"),
> +                             displaypath);
> +
> +               if (!info->force) {
> +                       struct child_process cp_rm = CHILD_PROCESS_INIT;
> +                       cp_rm.git_cmd = 1;
> +                       argv_array_pushl(&cp_rm.args, "rm", "-qn", sm_path,
> +                                        NULL);
> +
> +                       /* list_item->name is changed by cmd_rm() below */

... but it looks like cmd_rm() is not used anymore below, so this
comment is outdated and I wonder if duplicated list_item->name is
still needed.

> +                       if (run_command(&cp_rm))
> +                               die(_("Submodule work tree '%s' contains local "
> +                                     "modifications; use '-f' to discard them"),
> +                                     displaypath);
> +               }
> +
> +               if (!lstat(sm_path, &st)) {
> +                       struct strbuf sb_rm = STRBUF_INIT;
> +                       strbuf_addstr(&sb_rm, sm_path);
> +
> +                       if (!remove_dir_recursively(&sb_rm, 0)) {
> +                               if (!info->quiet)
> +                                       printf(_("Cleared directory '%s'\n"),
> +                                                displaypath);
> +                       } else {
> +                               if (!info->quiet)
> +                                       printf(_("Could not remove submodule work tree '%s'\n"),
> +                                                displaypath);
> +                       }

Nit: maybe this could be:

                       struct strbuf sb_rm = STRBUF_INIT;
                       const char *format;

                       strbuf_addstr(&sb_rm, sm_path);

                       if (!remove_dir_recursively(&sb_rm, 0))
                               format = _("Cleared directory '%s'\n");
                       else
                               format = _("Could not remove submodule
work tree '%s'\n");

                       if (!info->quiet)
                               printf(format, displaypath);

> +                       strbuf_release(&sb_rm);
> +               }
> +       }

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0D241FF30
	for <e@80x24.org>; Tue, 18 Jul 2017 22:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752518AbdGRWXa (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 18:23:30 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35529 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751995AbdGRWX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 18:23:29 -0400
Received: by mail-pg0-f50.google.com with SMTP id v190so19945633pgv.2
        for <git@vger.kernel.org>; Tue, 18 Jul 2017 15:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+36taQS3LGxUyjixcyEnDQJ+iSYqjLrDAWM6P11P0q8=;
        b=CRxfJP8uWslvZzYnrTVvKcQ3n3KwmooTqx8INn9PsEbyDSp25tvEezmW3DrLHY6UVq
         ofTDhtnH4yud/mf4IxAyDBzXG2AL4gsGMsUuc5g4nwh2b6c5w/hJCk+5XbK51frZUyF/
         sn1uGama5AYQ2etD5QeAkS5B+wuEEic8YU0iA/rDyaa3FZV1PBD5jBhpUDvG8LHb3gRC
         2xXCh5rbQW9Lv3VR67kq0zxiHfa9s6UzgBqbRdUTeuuTC9AEEBJWW18DQ5v1vtiA8kOW
         QImCdDt4nxlOf6C8z+YwIqWAYP7InjmzrPrcoYuH1Ec+KT8pJFqn2DOTBTNV1+bPB84F
         SO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+36taQS3LGxUyjixcyEnDQJ+iSYqjLrDAWM6P11P0q8=;
        b=J7zXbjh4PkFtp4tOVPl37WsMLcEPSOyVMsp9hVUvNr8pHr2fUq7jBwnjOWglvPjfng
         whPcGXQ4WMpehI5es5vI1tAOKmVyS6Ef3pmMXLfGmAqkhzEfXNVZ4cUqmbV9+EFwkvlZ
         t3Kbdr3Hioc17Ue5owaRtb1Bco5liZzqEMWl86tjFMryyQLAWeGfrpoJD8wx0uiO592O
         O5wXZ67U9A5tf8eHvPqD+dtxdVzv6DUtPo5H8TuU0nCo8le/12zngygSLWYzjndryZqL
         X6t2hcdVJCyN6L/N9L9vzrWDPUIuXRuK5YRNaeVoTBffOsTEFix7oHJDLcJmF8vU65HF
         ZSBQ==
X-Gm-Message-State: AIVw111d4H8CSZ2pcsb5/B7+q/jUtuX+Q3fB6Fbsplvd90ryIllyUCsw
        WKYcTtnt/ZaFR6baWcf5nlTIiwa3l8fUiIZ1tw==
X-Received: by 10.84.137.129 with SMTP id 1mr3123522pln.251.1500416608990;
 Tue, 18 Jul 2017 15:23:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Tue, 18 Jul 2017 15:23:28 -0700 (PDT)
In-Reply-To: <20170718204904.3768-6-pc44800@gmail.com>
References: <20170718204904.3768-1-pc44800@gmail.com> <20170718204904.3768-6-pc44800@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 18 Jul 2017 15:23:28 -0700
Message-ID: <CAGZ79kZrVQZH3ASoZavEeCSUBei8By1xs3fAQaEbVSCMOXoYxg@mail.gmail.com>
Subject: Re: [GSoC][PATCH 5/8] submodule: port submodule subcommand 'sync'
 from shell to C
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 18, 2017 at 1:49 PM, Prathamesh Chavan <pc44800@gmail.com> wrote:
> Port the submodule subcommand 'sync' from shell to C using the same
> mechanism as that used for porting submodule subcommand 'status'.
> Hence, here the function cmd_sync() is ported from shell to C.
> This is done by introducing three functions: module_sync(),
> sync_submodule() and print_default_remote().
>
> The function print_default_remote() is introduced for getting
> the default remote as stdout.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
>  builtin/submodule--helper.c | 179 ++++++++++++++++++++++++++++++++++++++++++++
>  git-submodule.sh            |  56 +-------------
>  2 files changed, 180 insertions(+), 55 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 9c1630495..da91c489b 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -44,6 +44,20 @@ static char *get_default_remote(void)
>         return ret;
>  }
>
> +static int print_default_remote(int argc, const char **argv, const char *prefix)
> +{
> +       const char *remote;
> +
> +       if (argc != 1)
> +               die(_("submodule--helper print-default-remote takes no arguments"));
> +
> +       remote = get_default_remote();
> +       if (remote)
> +               puts(remote);
> +
> +       return 0;
> +}
> +
>  static int starts_with_dot_slash(const char *str)
>  {
>         return str[0] == '.' && is_dir_sep(str[1]);
> @@ -379,6 +393,25 @@ static void module_list_active(struct module_list *list)
>         *list = active_modules;
>  }
>
> +static char *get_up_path(const char *path)
> +{
> +       int i;
> +       struct strbuf sb = STRBUF_INIT;
> +
> +       for (i = count_slashes(path); i; i--)
> +               strbuf_addstr(&sb, "../");
> +
> +       /*
> +        * Check if 'path' ends with slash or not
> +        * for having the same output for dir/sub_dir
> +        * and dir/sub_dir/
> +        */
> +       if (!is_dir_sep(path[strlen(path) - 1]))
> +               strbuf_addstr(&sb, "../");
> +
> +       return strbuf_detach(&sb, NULL);
> +}
> +
>  static int module_list(int argc, const char **argv, const char *prefix)
>  {
>         int i;
> @@ -724,6 +757,150 @@ static int module_name(int argc, const char **argv, const char *prefix)
>         return 0;
>  }
>
> +struct sync_cb {
> +       const char *prefix;
> +       unsigned int quiet: 1;
> +       unsigned int recursive: 1;
> +};
> +#define SYNC_CB_INIT { NULL, 0, 0 }
> +
> +static void sync_submodule(const struct cache_entry *list_item, void *cb_data)
> +{
> +       struct sync_cb *info = cb_data;
> +       const struct submodule *sub;
> +       char *sub_key, *remote_key;
> +       char *sub_origin_url, *super_config_url, *displaypath;
> +       struct strbuf sb = STRBUF_INIT;
> +       struct child_process cp = CHILD_PROCESS_INIT;
> +
> +       if (!is_submodule_active(the_repository, list_item->name))
> +               return;

We can use the_repository here, as we also use child processes to
recurse, such that we always operate on the_repository as the
superproject.


> +
> +       sub = submodule_from_path(null_sha1, list_item->name);
> +
> +       if (!sub || !sub->url)
> +               die(_("no url found for submodule path '%s' in .gitmodules"),
> +                     list_item->name);

We do not die in the shell script when the url is missing in the
.gitmodules file.

> +
> +       if (starts_with_dot_dot_slash(sub->url) || starts_with_dot_slash(sub->url)) {
> +               char *remote_url, *up_path;
> +               char *remote = get_default_remote();
> +               char *remote_key = xstrfmt("remote.%s.url", remote);
> +
> +               if (git_config_get_string(remote_key, &remote_url))
> +                       remote_url = xgetcwd();
> +
> +               up_path = get_up_path(list_item->name);
> +               sub_origin_url = relative_url(remote_url, sub->url, up_path);
> +               super_config_url = relative_url(remote_url, sub->url, NULL);
> +
> +               free(remote);
> +               free(remote_key);
> +               free(up_path);
> +               free(remote_url);
> +       } else {
> +               sub_origin_url = xstrdup(sub->url);
> +               super_config_url = xstrdup(sub->url);
> +       }
> +
> +       displaypath = get_submodule_displaypath(list_item->name, info->prefix);
> +
> +       if (!info->quiet)
> +               printf(_("Synchronizing submodule url for '%s'\n"),
> +                        displaypath);
> +
> +       sub_key = xstrfmt("submodule.%s.url", sub->name);
> +       if (git_config_set_gently(sub_key, super_config_url))
> +               die(_("failed to register url for submodule path '%s'"),
> +                     displaypath);
> +
> +       if (!is_submodule_populated_gently(list_item->name, NULL))
> +               goto cleanup;
> +
> +       prepare_submodule_repo_env(&cp.env_array);
> +       cp.git_cmd = 1;
> +       cp.dir = list_item->name;
> +       argv_array_pushl(&cp.args, "submodule--helper",
> +                        "print-default-remote", NULL);
> +       if (capture_command(&cp, &sb, 0))
> +               die(_("failed to get the default remote for submodule '%s'"),
> +                     list_item->name);
> +
> +       strbuf_strip_suffix(&sb, "\n");
> +       remote_key = xstrfmt("remote.%s.url", sb.buf);
> +       strbuf_release(&sb);
> +
> +       child_process_init(&cp);
> +       prepare_submodule_repo_env(&cp.env_array);
> +       cp.git_cmd = 1;
> +       cp.dir = list_item->name;
> +       argv_array_pushl(&cp.args, "config", remote_key, sub_origin_url, NULL);
> +       if (run_command(&cp))
> +               die(_("failed to update remote for submodule '%s'"),
> +                     list_item->name);

While it is a strict conversion from the shell script, we could also
try to do this in-process:
1) we'd find out the submodules git dir using submodule_to_gitdir
2) construct the path the the config file as "%s/.gitconfig"
3) using git_config_set_in_file (which presumably takes file name,
  key and value) the value can be set

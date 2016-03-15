From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 18/19] index-helper: autorun
Date: Tue, 15 Mar 2016 19:12:36 +0700
Message-ID: <CACsJy8CaWFhCzrH3imz+BRMTESSmyUB4jeAaYUDNk+Tmpj-VrQ@mail.gmail.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com> <1457548582-28302-19-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 15 13:13:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afnqd-0004o3-R8
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 13:13:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934652AbcCOMNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 08:13:11 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:33744 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932688AbcCOMNI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 08:13:08 -0400
Received: by mail-lb0-f179.google.com with SMTP id oe12so19893187lbc.0
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 05:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c3z3hZ5rQ64+/W+ttQK19n3NOOErkYamrEbIqPtx6PQ=;
        b=qS0bU3xUqVbcp+WLTN/f47aA/yZLEOMI8WuKFEugfj4sM57raL0d4FNz4xt8LEMqR8
         eesgcZd7oXr/KkkTM9s8TUsPA7yBuSEp5tNx4nWfkNaq3pl4OYSoeTqiin8GyDYdSO3K
         THltaeadZ3y60Wd4DbYSMGMWBcn5Q2a1Zo+Evr9WKLoVf/FQf54kKTByQ0x0cWXRJFKp
         CQg8UMl+Mj4ZbVqSEkbt4qgBudpApzNEvdPmyZhiY0pneKSKAI6zOeJN7gz1lfHFqpMh
         0ix360jv81DcHmn8ZrTgVMpuTR/y4p2dQAQzNnWY7gUsDWAsrvFUq/tQx/HChXNibKXM
         1f5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c3z3hZ5rQ64+/W+ttQK19n3NOOErkYamrEbIqPtx6PQ=;
        b=ShCrW2WReBET0Y74YylkYircTiDpAgKnuAPIEvb3om1PUNXkVOomhs3OitUtUHiV3P
         w+46pBspU6XU2IPst2/o9DZkpo0JJV1Wwaea4+hGQrxjX4VeukA0fYycWCD3aHgst5jI
         qiG7NheWA8wUI7XBIj5nhAs17Ifyx0eEtqIRSUurBdHEuvjCabdPFwTa7mVm1fdFvmAq
         b7BwpSPhctOVIiItdNMIVTQgK/RLpZ0SDpDV8ix2p/TRg6N/W6QrOjfVxgDyt5dF87rf
         +WaOlqXiCzs3Nesl7NiBn9/8te5sdYF/TVds5ODETdFDpmJMDuzVgoaS3WUZ0FKTR2MT
         zEcA==
X-Gm-Message-State: AD7BkJKFoedcE+NQmawg23Dq8QQ6iNxkV7LWHgv6uGuWjEHiF1YjO3zVTSubgkpO8BYYbKEIcXuvpEK+svZ+0g==
X-Received: by 10.112.130.41 with SMTP id ob9mr9540336lbb.81.1458043986089;
 Tue, 15 Mar 2016 05:13:06 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Tue, 15 Mar 2016 05:12:36 -0700 (PDT)
In-Reply-To: <1457548582-28302-19-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288851>

On Thu, Mar 10, 2016 at 1:36 AM, David Turner <dturner@twopensource.com> wrote:
> Introduce a new config option, indexhelper.autorun, to automatically
> run git index-helper before starting up a builtin git command.  This
> enables users to keep index-helper running without manual
> intervention.

This could be a problem on Windows because "index-helper --detach"
does not work there. I have no idea how "daemons" are managed on
Windows and not sure if our design is still good when such a "daemon"
is added on Windows. So I'm pulling Johannes in for his opinions.

Background for Johannes. We're adding "git index-helper" daemon (one
per repo) to cache the index in memory to speed up index load time
(and in future probably name-hash too, I think it's also more often
used on Windows because of case-insensitive fs). It also enables
watchman (on Windows) for faster refresh. This patch allows to start
the daemon automatically if it's not running. But I don't know it will
work ok on Windows.

Assuming that "index-helper" service has to be installed and started
from system, there can only be one service running right? This clashes
with the per-repo daemon design... I think it can stilf work, if the
main service just spawns new process, one for each repo. But again I'm
not sure.

> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  git.c                   | 38 +++++++++++++++++++++++++++++++++++++-
>  index-helper.c          | 11 ++++++++++-
>  t/t7900-index-helper.sh | 10 ++++++++++
>  3 files changed, 57 insertions(+), 2 deletions(-)
>
> diff --git a/git.c b/git.c
> index a4f6f71..ccf04ab 100644
> --- a/git.c
> +++ b/git.c
> @@ -521,6 +521,40 @@ static void strip_extension(const char **argv)
>  #define strip_extension(cmd)
>  #endif
>
> +static int want_auto_index_helper(void)
> +{
> +       int want = -1;
> +       const char *value = NULL;
> +       const char *key = "indexhelper.autorun";
> +
> +       if (git_config_key_is_valid(key) &&
> +           !git_config_get_value(key, &value)) {
> +               int b = git_config_maybe_bool(key, value);
> +               want = b >= 0 ? b : 0;
> +       }
> +       return want;
> +}
> +
> +static void maybe_run_index_helper(struct cmd_struct *cmd)
> +{
> +       const char *argv[] = {"git-index-helper", "--detach", "--auto", NULL};
> +       int status;
> +
> +       if (!(cmd->option & NEED_WORK_TREE))
> +               return;
> +
> +       if (want_auto_index_helper() <= 0)
> +               return;
> +
> +       trace_argv_printf(argv, "trace: auto index-helper:");
> +
> +       status = run_command_v_opt(argv, RUN_SILENT_EXEC_FAILURE | RUN_CLEAN_ON_EXIT);
> +
> +       if (status) {
> +               warning("You specified indexhelper.autorun, but running git-index-helper failed");
> +       }
> +}
> +
>  static void handle_builtin(int argc, const char **argv)
>  {
>         const char *cmd;
> @@ -536,8 +570,10 @@ static void handle_builtin(int argc, const char **argv)
>         }
>
>         builtin = get_builtin(cmd);
> -       if (builtin)
> +       if (builtin) {
> +               maybe_run_index_helper(builtin);
>                 exit(run_builtin(builtin, argc, argv));
> +       }
>  }
>
>  static void execv_dashed_external(const char **argv)
> diff --git a/index-helper.c b/index-helper.c
> index a75da60..bc5c328 100644
> --- a/index-helper.c
> +++ b/index-helper.c
> @@ -379,6 +379,7 @@ int main(int argc, char **argv)
>         int idle_in_minutes = 10, detach = 0;
>         int ignore_existing = 0;
>         int kill_existing = 0;
> +       int nongit = 0, autorun = 0;
>         const char *pid_file;
>         struct option options[] = {
>                 OPT_INTEGER(0, "exit-after", &idle_in_minutes,
> @@ -388,6 +389,7 @@ int main(int argc, char **argv)
>                 OPT_BOOL(0, "detach", &detach, "detach the process"),
>                 OPT_BOOL(0, "ignore-existing", &ignore_existing, "run even if another index-helper seems to be running for this repo"),
>                 OPT_BOOL(0, "kill", &kill_existing, "kill any running index-helper for this repo"),
> +               OPT_BOOL(0, "auto", &autorun, "this is an automatic run of git index-helper, so certain errors can be solved by silently exiting"),
>                 OPT_END()
>         };
>
> @@ -397,11 +399,18 @@ int main(int argc, char **argv)
>         if (argc == 2 && !strcmp(argv[1], "-h"))
>                 usage_with_options(usage_text, options);
>
> -       prefix = setup_git_directory();
> +       prefix = setup_git_directory_gently(&nongit);
>         if (parse_options(argc, (const char **)argv, prefix,
>                           options, usage_text, 0))
>                 die(_("too many arguments"));
>
> +       if (nongit) {
> +               if (autorun)
> +                       exit(0);
> +               else
> +                       die("Not a git repository");
> +       }
> +
>         if (ignore_existing && kill_existing)
>                 die(_("--ignore-existing and --kill don't make sense together"));
>
> diff --git a/t/t7900-index-helper.sh b/t/t7900-index-helper.sh
> index 6708180..e4f9564 100755
> --- a/t/t7900-index-helper.sh
> +++ b/t/t7900-index-helper.sh
> @@ -20,4 +20,14 @@ test_expect_success 'index-helper creates usable pid file and can be killed' '
>         ! kill -0 $pid
>  '
>
> +test_expect_success 'index-helper autorun works' '
> +       rm -f .git/index-helper.pid &&
> +       git status &&
> +       test_path_is_missing .git/index-helper.pid &&
> +       test_config indexhelper.autorun true &&
> +       git status &&
> +       test_path_is_file .git/index-helper.pid &&
> +       git index-helper --kill
> +'
> +
>  test_done
> --
> 2.4.2.767.g62658d5-twtrsrc
>



-- 
Duy

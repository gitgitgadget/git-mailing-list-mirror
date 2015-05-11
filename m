From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 2/6] help.c: output the typical Git workflow
Date: Mon, 11 May 2015 02:24:37 -0400
Message-ID: <CAPig+cR46K2h+hk4riwXcty=T+RBoT1Za9rqOwB9EgvUReUhmg@mail.gmail.com>
References: <1431191856-10949-1-git-send-email-sebastien.guimmara@gmail.com>
	<1431191856-10949-3-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 11 08:24:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yrh92-0000hk-3u
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 08:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324AbbEKGYl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 May 2015 02:24:41 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:36202 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbbEKGYi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2015 02:24:38 -0400
Received: by iecmd7 with SMTP id md7so23101654iec.3
        for <git@vger.kernel.org>; Sun, 10 May 2015 23:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=uTxcbEPYqI5Xwcuf62X5y8GCl4XakjdAKXuhQswpsQQ=;
        b=UuXClmcRRBjCiQBbMMdoU+Lm59axl4czhgG/qGE05t0wSJ9nxFtUiyb4sybcEncRpP
         JpG0FVzuzL4USXUPwUTqWLTtK/QSE7pEb9ZXF8ccBljyr0GpyFw3FoQGj1YZ/IdVgjoO
         FKVT+GSBo1J/mj/qZIOVoPKq/l9N9qLIqfNmXonHsIEEXRNvw2y8kXT79euDBfqfkr+D
         DOQnyRHMj1G+ejjvYoG1sJfiPar1Fg4tXeEuhSZtekOzL5yXvIDMLpAWj+BEdMp5SJMM
         2YJO3EEELLnbxP6AKrKAlQpz4oDZpkCfj79GFXUG5/SdOzSMfGygLi17qE6a4skyUloT
         SH5w==
X-Received: by 10.107.169.74 with SMTP id s71mr10982285ioe.46.1431325477336;
 Sun, 10 May 2015 23:24:37 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Sun, 10 May 2015 23:24:37 -0700 (PDT)
In-Reply-To: <1431191856-10949-3-git-send-email-sebastien.guimmara@gmail.com>
X-Google-Sender-Auth: B3usoQN476bmLrpb9ldsWaE-Fps
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268759>

On Sat, May 9, 2015 at 1:17 PM, S=C3=A9bastien Guimmara
<sebastien.guimmara@gmail.com> wrote:
> 'git help' shows common commands in alphabetical order:
>
> The most commonly used git commands are:
>    add        Add file contents to the index
>    bisect     Find by binary search the change that introduced a bug
>    branch     List, create, or delete branches
>    checkout   Checkout a branch or paths to the working tree
>    clone      Clone a repository into a new directory
>    commit     Record changes to the repository
>    [...]
>
> without any indication of how commands relate to high-level
> concepts or each other. Revise the output to explain their relationsh=
ip
> with the typical Git workflow:
>
> The typical Git workflow includes:
>
>    * start a working area (see also: git help tutorial):
>       clone      Clone a repository into a new directory
>       init       Create an empty Git repository or reinitialize [...]

In practice, I find the indented bulleted header items somewhat
unsightly. More importantly, indenting them wastes precious horizontal
screen real-estate (for those of who use 80-column terminals). Since
the headers are already distinguished by being bulleted, you could
easily drop the indentation; and then reduce the indentation of the
commands themselves.

>    * work on the current change (see also: git help everyday):
>       add        Add file contents to the index
>       reset      Reset current HEAD to the specified state
>
>    * examine the history and state (see also: git help revisions):
>       log        Show commit logs
>       status     Show the working tree status
>
>    [...]
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
> ---
> diff --git a/help.c b/help.c
> index 2072a87..1df205f 100644
> --- a/help.c
> +++ b/help.c
> @@ -218,6 +218,18 @@ void list_commands(unsigned int colopts,
>         }
>  }
>
> +int cmd_group_cmp(const void *elem1, const void *elem2)
> +{
> +       const struct cmdname_help *e1 =3D elem1;
> +       const struct cmdname_help *e2 =3D elem2;
> +
> +       if (e1->group < e2->group)
> +               return -1;
> +       if (e1->group > e2->group)
> +               return 1;
> +       return strcmp(e1->name, e2->name);
> +}
> +
>  void list_common_cmds_help(void)
>  {
>         int i, longest =3D 0;
> @@ -227,9 +239,18 @@ void list_common_cmds_help(void)
>                         longest =3D strlen(common_cmds[i].name);
>         }
>
> -       puts(_("The most commonly used git commands are:"));
> +       qsort(common_cmds, ARRAY_SIZE(common_cmds),
> +               sizeof(common_cmds[0]), cmd_group_cmp);
> +
> +       puts(_("The typical Git workflow includes:"));
> +
>         for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
> -               printf("   %s   ", common_cmds[i].name);
> +               if (common_cmds[i].group !=3D current_grp) {
> +                       printf("\n   * %s:\n", _(common_cmd_groups[co=
mmon_cmds[i].group]));
> +                       current_grp =3D common_cmds[i].group;
> +               }
> +
> +               printf("      %s   ", common_cmds[i].name);
>                 mput_char(' ', longest - strlen(common_cmds[i].name))=
;
>                 puts(_(common_cmds[i].help));
>         }
> --
> 2.4.0

From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 5/5] help.c: output the typical Git workflow
Date: Fri, 15 May 2015 17:45:07 -0400
Message-ID: <CAPig+cRpi=pQoEkqvnjn1KJqi7r_N4y-=o-ut4MJ_27CRiftOQ@mail.gmail.com>
References: <1431714904-16599-1-git-send-email-sebastien.guimmara@gmail.com>
	<1431714904-16599-6-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 15 23:45:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtNPv-0007Vs-JM
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 23:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946248AbbEOVpJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 May 2015 17:45:09 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:36740 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946159AbbEOVpH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 May 2015 17:45:07 -0400
Received: by iepk2 with SMTP id k2so131711653iep.3
        for <git@vger.kernel.org>; Fri, 15 May 2015 14:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=a2BdFT+nIVbaF0FN+ZyIzoxvehnyFfx8ub7qM73aBxc=;
        b=WId8KS6xQDyqZK9hzWSp056nuFXZxl/SXQXuQ0DdXWYI1AB0ZvkYYSOTYay1ihDRRD
         mflYtjOu/lIQBeiWHrCwiz7S2+zRYlXqSxJJtyODsI0f0BS66p7ZjovuacEKVYkqSg+u
         l6vsD7KN5/cq8O9q+NHFjeRSUfrSa9s0KrvYoQD+0X0r5mV730nTBWV/JcpLFFIx0HKN
         wV426M7frEKHC+AWfAIF1WjSATXsuLuBuDk99cJt21+DyvcOHTxtLa6AEw7lTBPDBZnf
         bd/UFOGPriIVkTUyxBFlzr8G3kXPo789wq9d5iBo21O0wF6q28GZbWvKik7lb0biosqM
         Vj4A==
X-Received: by 10.107.151.75 with SMTP id z72mr12013982iod.46.1431726307242;
 Fri, 15 May 2015 14:45:07 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Fri, 15 May 2015 14:45:07 -0700 (PDT)
In-Reply-To: <1431714904-16599-6-git-send-email-sebastien.guimmara@gmail.com>
X-Google-Sender-Auth: EN_aKdr49eCy_hat-BRcwHXyTbg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269189>

On Fri, May 15, 2015 at 2:35 PM, S=C3=A9bastien Guimmara
<sebastien.guimmara@gmail.com> wrote:
> Subject: help.c: output the typical Git workflow

A more meaningful summary might be:

    help: respect new common command grouping

or something.

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
> start a working area (see also: git help tutorial):
>    clone      Clone a repository into a new directory
>    init       Create an empty Git repository or reinitialize [...]
>
> work on the current change (see also: git help everyday):
>    add        Add file contents to the index
>    reset      Reset current HEAD to the specified state
>
> examine the history and state (see also: git help revisions):
>    log        Show commit logs
>    status     Show the working tree status

The remainder of the commit message makes sense, and the patch itself
looks good. Thanks.

> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
> ---
>  help.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/help.c b/help.c
> index 2072a87..bdb69d1 100644
> --- a/help.c
> +++ b/help.c
> @@ -218,17 +218,39 @@ void list_commands(unsigned int colopts,
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
> +       int current_grp =3D -1;
>
>         for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
>                 if (longest < strlen(common_cmds[i].name))
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
> +               if (common_cmds[i].group !=3D current_grp) {
> +                       printf("\n%s:\n", _(common_cmd_groups[common_=
cmds[i].group]));
> +                       current_grp =3D common_cmds[i].group;
> +               }
> +
>                 printf("   %s   ", common_cmds[i].name);
>                 mput_char(' ', longest - strlen(common_cmds[i].name))=
;
>                 puts(_(common_cmds[i].help));
> --
> 2.4.0

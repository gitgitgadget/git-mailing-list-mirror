From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2] Group the default git help message by topic
Date: Fri, 11 Jun 2010 16:46:14 +0000
Message-ID: <AANLkTilX5HWm3Om349Cbe397B6EKmu_nJijEvqdq38iw@mail.gmail.com>
References: <AANLkTiloErvcWS1hW80cIV9SiWu_7CBdNSx_iAppcGOd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 11 18:46:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ON7N9-00087g-Ht
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 18:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757386Ab0FKQqT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jun 2010 12:46:19 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:32927 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756392Ab0FKQqS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jun 2010 12:46:18 -0400
Received: by iwn9 with SMTP id 9so521925iwn.19
        for <git@vger.kernel.org>; Fri, 11 Jun 2010 09:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3aPLgFmU5x1YKiAwGkyaWQNQmlQWhNEcPYd6AJa4z/o=;
        b=SkitTP4oP75iRZ3hhlLA/BW0Dy1HZGdrib92kzptSdJzbOTPxOqR60tSndjLQj8FG6
         UMGvK3YQLadQ9cTkd3uK7Dz7lhwncSRaezewC7XLfGg7iJCn/ULGYeBbBP5C8rGFWuqZ
         ot2aUnibHwvWASGocUGFstmWridM4/czSw8FI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vNZnaP/2CCIdnSF0N5fLKL/r7yj2YkpF15kCqQYhTeFAkvZr/nthCAXOoZ4BncjFZu
         CMwEgfh/62VMj/aYVw9FAJ95X+PXiA25iofdjRAjDtkOeuvbApTPXRvT1FxRuSgH3zbL
         F50tr2WKgaKXV13CEERZv/7Dsb66JM+VzBXrU=
Received: by 10.231.148.143 with SMTP id p15mr1955923ibv.15.1276274775066; 
	Fri, 11 Jun 2010 09:46:15 -0700 (PDT)
Received: by 10.231.155.144 with HTTP; Fri, 11 Jun 2010 09:46:14 -0700 (PDT)
In-Reply-To: <AANLkTiloErvcWS1hW80cIV9SiWu_7CBdNSx_iAppcGOd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148963>

On Fri, Jun 11, 2010 at 16:03, Scott Chacon <schacon@gmail.com> wrote:

I like the basic idea behind this patch, i.e. grouping the help
output.

> It's difficult to process 21 commands (which is what is output
> by default for git when no command is given). =C2=A0They have been
> re-grouped into 4 groups of 5-6 commands each, which is clearer
> and easier for new users to process. =C2=A0More advanced commands
> such as bisect and rebase have also been removed as this should
> be output for beginners.

"should not"

> Here is the second version of this patch. =C2=A0Instead of hard-codin=
g
> all the descriptions, I'm just pulling them from the common-cmds.h
> file.

The reason there are 21 is:

    $ grep -c "mainporcelain common" command-list.txt
    21

Perhaps if `git help` is going to be some subset of that aimed at
newbies a new command-list.txt category should be introduced as part
of the patch? E.g. "mainporcelain common newbie"?

As a further suggestion for future improvements, perhaps we should
document *all* commands in the future, or at least those in
mainporcelain and make a full summary available through `git help
--full` or something like that.

As far as I can see with this patch the the description for the
commands you removed in the `cmdname_help common_cmds` struct is now
dead code. If that's the case shouldn't they strings be removed from
there?

These are the commands you removed (I think the commit message should
be changed to explicitly mention this):

    git-bisect                              mainporcelain common
    git-grep                                mainporcelain common
    git-mv                                  mainporcelain common
    git-rebase                              mainporcelain common
    git-rm                                  mainporcelain common

"mv" and "rm" are certainly something a newbie might frequently
used. Why not list it under "Basic commands" along with "add"?

I use "rebase" much more than some of the commands now listed, it's
one of the main distinguishing features of git, so perhaps it should
be under "Branch Commands", if for no other reason than to give users
a peek down the rabbit hole.

> =C2=A0builtin/help.c | =C2=A0 54 ++++++++++++++++++++++++++++++++++++=
++++++------------
> =C2=A01 files changed, 42 insertions(+), 12 deletions(-)
>
> diff --git a/builtin/help.c b/builtin/help.c
> index 3182a2b..2975b3d 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -269,23 +269,53 @@ static int git_help_config(const char *var,
> const char *value, void *cb)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return git_default_config(var, value, cb);
> =C2=A0}
>
> -static struct cmdnames main_cmds, other_cmds;
> -
> -void list_common_cmds_help(void)
> +void print_command(const char *s)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 int i, longest =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 int i =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 int longest =3D 10;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < ARRAY_SIZE(common_cmds);=
 i++) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (longest < strl=
en(common_cmds[i].name))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 longest =3D strlen(common_cmds[i].name);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!strcmp(s, com=
mon_cmds[i].name)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 printf(" =C2=A0 %s =C2=A0 ", common_cmds[i].name);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 mput_char(' ', longest - strlen(common_cmds[i].name));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 puts(common_cmds[i].help);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +}
>
> - =C2=A0 =C2=A0 =C2=A0 puts("The most commonly used git commands are:=
");
> - =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++=
) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(" =C2=A0 %s=
 =C2=A0 ", common_cmds[i].name);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mput_char(' ', lon=
gest - strlen(common_cmds[i].name));
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 puts(common_cmds[i=
].help);
> - =C2=A0 =C2=A0 =C2=A0 }
> +static struct cmdnames main_cmds, other_cmds;
> +
> +void list_common_cmds_help(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 puts("The most commonly used git commands are:=
\n");
> +
> + =C2=A0 =C2=A0 =C2=A0 puts("Basic Commands:");

Why capitalize "Commands" when it's not at the beginning of a
sentence? 'bzr help' doesn't do this. And For What It's Worth I Find
It Uncomfortable To Read Text Formatted Like That.

> + =C2=A0 =C2=A0 =C2=A0 print_command("init");
> + =C2=A0 =C2=A0 =C2=A0 print_command("clone");
> + =C2=A0 =C2=A0 =C2=A0 print_command("add");
> + =C2=A0 =C2=A0 =C2=A0 print_command("status");
> + =C2=A0 =C2=A0 =C2=A0 print_command("commit");
> + =C2=A0 =C2=A0 =C2=A0 puts("");
> +
> + =C2=A0 =C2=A0 =C2=A0 puts("Branch Commands:");
> + =C2=A0 =C2=A0 =C2=A0 print_command("branch");
> + =C2=A0 =C2=A0 =C2=A0 print_command("checkout");
> + =C2=A0 =C2=A0 =C2=A0 print_command("merge");
> + =C2=A0 =C2=A0 =C2=A0 print_command("tag");
> + =C2=A0 =C2=A0 =C2=A0 puts("");
> +
> + =C2=A0 =C2=A0 =C2=A0 puts("History Commands:");
> + =C2=A0 =C2=A0 =C2=A0 print_command("log");
> + =C2=A0 =C2=A0 =C2=A0 print_command("diff");
> + =C2=A0 =C2=A0 =C2=A0 print_command("reset");
> + =C2=A0 =C2=A0 =C2=A0 print_command("show");
> + =C2=A0 =C2=A0 =C2=A0 puts("");
> +
> + =C2=A0 =C2=A0 =C2=A0 puts("Remote Commands:");
> + =C2=A0 =C2=A0 =C2=A0 print_command("remote");
> + =C2=A0 =C2=A0 =C2=A0 print_command("fetch");
> + =C2=A0 =C2=A0 =C2=A0 print_command("pull");
> + =C2=A0 =C2=A0 =C2=A0 print_command("push");
> =C2=A0}

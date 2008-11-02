From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] prepare deprecation of git-revert
Date: Sun, 2 Nov 2008 16:32:25 +0700
Message-ID: <20081102093225.GA32296@laptop>
References: <1225468527-29694-1-git-send-email-madcoder@debian.org> <20081031165003.GA5355@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 02 10:33:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwZLC-00052B-QL
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 10:33:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077AbYKBJch convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Nov 2008 04:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753149AbYKBJch
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 04:32:37 -0500
Received: from rv-out-0506.google.com ([209.85.198.237]:49741 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073AbYKBJcf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 04:32:35 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2045005rvb.1
        for <git@vger.kernel.org>; Sun, 02 Nov 2008 01:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hM+g+mVbGGTEfTA8YvbCMz6EKAAp/7TdDquAamWpPtw=;
        b=wcn6kyAlj1Aon8w5PHzW57+aYLUQtdEGM+yKc2hC/V87BEpeKGeNNuzD3d7fFUP6NN
         BUT1tSaygV5ul8UsOh5bcVrt6T8AAK+foTlkxehhhpTL6Wx1szoP3biKEKLxoXwBmVGV
         2qa1Fpc80+1uXBPDbWv924t775auhChwlBK/o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=xC1ml2j/ieuc7J/axurFiteE99TCCn1AFMgB7sBVahYty+T2TCZBpE6WFTHTlEn6Op
         7MvCCFvh40b425bIilv3BPA+r+NbnBc4jhnu5y90+bONBqfcSMTyELYQnPTtTCVIRh+s
         E3+Lw1HHNGet2pIwkm/siFyrVgY1NViPF1I7c=
Received: by 10.142.223.4 with SMTP id v4mr6509128wfg.166.1225618354920;
        Sun, 02 Nov 2008 01:32:34 -0800 (PST)
Received: from pclouds@gmail.com ([117.5.15.112])
        by mx.google.com with ESMTPS id 28sm10909736wfd.4.2008.11.02.01.32.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 02 Nov 2008 01:32:33 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  2 Nov 2008 16:32:25 +0700
Content-Disposition: inline
In-Reply-To: <20081031165003.GA5355@steel.home>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99831>

On Fri, Oct 31, 2008 at 05:50:03PM +0100, Alex Riesen wrote:
> Pierre Habouzit, Fri, Oct 31, 2008 16:55:27 +0100:
> > @@ -439,16 +436,17 @@ static int revert_or_cherry_pick(int argc, co=
nst char **argv)
> > =20
> >  int cmd_revert(int argc, const char **argv, const char *prefix)
> >  {
> > +#if 0
> > +	warning("git revert is deprecated, please use git cherry-pick --r=
evert/-R instead");
> > +#endif
>=20
> "git revert" is much shorter to type than "git cherry-pick -R".
> How about renaming "cherry-pick" into something short, like "pick"?

Maybe a patch like this can help? With it you can type "git cp" for
cherry-pick. If someday "git cp" is added, you can type "git c-p",
much shorter.

--<--
commit dce5cad329390905bb91115a9de0153772be57d8
Author: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
Date:   Sat Nov 1 17:12:04 2008 +0700

    Add git command expansion
   =20
    This allows git commands to be typed shorter (in shells that do not
    support autocompletion). There are three types of expansion:
   =20
     - "foo" matches "foo*" commands (bi -> bisect)
     - "foo" also matches "f*-oo*" (fim -> fast-import)
     - "foo-bar" (with dash) matches "foo*-bar*" (fo-p -> format-patch)
   =20
    This feature is only enabled if core.commandexpansion is true. It
    may work better if we can limit the command set (to porcelain
    only for example) but I have yet to find a way to pull
    commands-list.txt to help.c.

diff --git a/builtin.h b/builtin.h
index 1495cf6..9fb0fef 100644
--- a/builtin.h
+++ b/builtin.h
@@ -12,6 +12,7 @@ extern const char git_more_info_string[];
=20
 extern void list_common_cmds_help(void);
 extern const char *help_unknown_cmd(const char *cmd);
+extern const char *expand_command(const char *cmd);
 extern void prune_packed_objects(int);
 extern int read_line_with_nul(char *buf, int size, FILE *file);
 extern int fmt_merge_msg(int merge_summary, struct strbuf *in,
diff --git a/git.c b/git.c
index 89feb0b..1bbe340 100644
--- a/git.c
+++ b/git.c
@@ -14,6 +14,7 @@ struct pager_config {
 	const char *cmd;
 	int val;
 };
+static int command_expansion;
=20
 static int pager_command_config(const char *var, const char *value, vo=
id *data)
 {
@@ -415,6 +416,13 @@ static void execv_dashed_external(const char **arg=
v)
 	strbuf_release(&cmd);
 }
=20
+static int git_command_expansion_config(const char *var, const char *v=
alue, void *cb)
+{
+	if (!strcmp(var, "core.commandexpansion"))
+		command_expansion =3D git_config_bool(var, value);
+
+	return git_default_config(var, value, cb);
+}
=20
 int main(int argc, const char **argv)
 {
@@ -501,6 +509,15 @@ int main(int argc, const char **argv)
 				cmd, argv[0]);
 			exit(1);
 		}
+		git_config(git_command_expansion_config, NULL);
+		if (command_expansion) {
+			const char *expand_cmd =3D expand_command(cmd);
+			if (expand_cmd) {
+				argv[0] =3D expand_cmd;
+				handle_internal_command(argc, argv);
+				execv_dashed_external(argv);
+			}
+		}
 		argv[0] =3D help_unknown_cmd(cmd);
 		handle_internal_command(argc, argv);
 		execv_dashed_external(argv);
diff --git a/help.c b/help.c
index fd87bb5..4f0e5a0 100644
--- a/help.c
+++ b/help.c
@@ -359,6 +359,67 @@ const char *help_unknown_cmd(const char *cmd)
 	exit(1);
 }
=20
+const char *expand_command(const char *cmd)
+{
+	int i, n, len;
+	struct cmdnames main_cmds, other_cmds;
+	char *src, *dst;
+
+	memset(&main_cmds, 0, sizeof(main_cmds));
+	memset(&other_cmds, 0, sizeof(main_cmds));
+
+	load_command_list("git-", &main_cmds, &other_cmds);
+
+	add_cmd_list(&main_cmds, &aliases);
+	add_cmd_list(&main_cmds, &other_cmds);
+	qsort(main_cmds.names, main_cmds.cnt,
+	      sizeof(main_cmds.names), cmdname_compare);
+	uniq(&main_cmds);
+
+	len =3D strlen(cmd);
+	n =3D -1;
+	src =3D strchr(cmd, '-');
+	for (i =3D 0;i < main_cmds.cnt; i++) {
+		const char *gitcmd =3D main_cmds.names[i]->name;
+
+		/* match prefix */
+		if (!strncmp(cmd, gitcmd, len))
+			goto ok_expand;
+
+		if (*cmd !=3D *gitcmd)
+			continue;
+		dst =3D strchr(gitcmd, '-');
+		if (!dst)
+			continue;
+
+		/* cmd is foo-bar, match foo*-bar* */
+		if (src &&
+		    !strncmp(cmd, gitcmd, src-cmd) &&
+		    !strncmp(src+1, dst+1, cmd+len-src-1))
+			goto ok_expand;
+
+		/* cmd is foobar,match f*-oobar* */
+		if (!src && !strncmp(cmd+1, dst+1, len-1))
+			goto ok_expand;
+
+		continue;
+ok_expand:
+		trace_printf("expand: %s\n", main_cmds.names[i]->name);
+		if (n !=3D -1)
+			return NULL;
+		n =3D i;
+	}
+
+	if (n !=3D -1) {
+		const char *assumed =3D main_cmds.names[n]->name;
+		main_cmds.names[n] =3D NULL;
+		clean_cmdnames(&main_cmds);
+		return assumed;
+	}
+	else
+		return NULL;
+}
+
 int cmd_version(int argc, const char **argv, const char *prefix)
 {
 	printf("git version %s\n", git_version_string);
--<--
--=20
Duy

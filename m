From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [1.8.0] Remove deprecated commands
Date: Sat, 12 Feb 2011 14:24:10 +0100
Message-ID: <4D5689FA.90804@lsrfire.ath.cx>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <7vwrll57ha.fsf@alter.siamese.dyndns.org> <4D4852EE.6080605@lsrfire.ath.cx> <20110202005748.GA13803@elie> <4D543FB4.1040709@lsrfire.ath.cx> <20110210205620.GD21144@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 12 14:24:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoFSd-0001OQ-La
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 14:24:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753496Ab1BLNYX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Feb 2011 08:24:23 -0500
Received: from india601.server4you.de ([85.25.151.105]:55495 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077Ab1BLNYW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Feb 2011 08:24:22 -0500
Received: from [192.168.2.103] (p4FFDABF3.dip.t-dialin.net [79.253.171.243])
	by india601.server4you.de (Postfix) with ESMTPSA id 0733A2F804F;
	Sat, 12 Feb 2011 14:24:19 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <20110210205620.GD21144@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166612>

Am 10.02.2011 21:56, schrieb Jonathan Nieder:
> Ren=C3=A9 Scharfe wrote:
>> Am 02.02.2011 01:57, schrieb Jonathan Nieder:
>>>>     git-repo-config  2008-01-17       git config
>>>
>>> giggle[1] still uses it
> [...]
>>> Likewise darcs2git[2] and the stgit testsuite.
> [...]
>> Well, the release notes for 1.5.4 promised that the "next feature
>> release will remove it".  Perhaps notifying the developers of the
>> projects you discovered is enough?
>=20
> The list is probably not exhaustive.  On the bright side, repo-config
> tends to be run in user-visible contexts, so I think a deprecation
> notice could be effective.
>=20
>> That said, the benefit for final removal of this command, which is
>> effectively just an alias, is the smallest of the four.
>=20
> After adding a deprecation notice and filing some bugs, I think we
> can forget about it and wait another year. ;-)

-- >8 --
Subject: [PATCH] repo-config: add deprecation warning

repo-config was deprecated in 5c66d0d4 on 2008-01-17.  Warn the
remaining users that it has been replaced by config and is going to
be removed eventually.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin.h        |    3 ++-
 builtin/config.c |    6 ++++++
 git.c            |    2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin.h b/builtin.h
index 904e067..0e9da90 100644
--- a/builtin.h
+++ b/builtin.h
@@ -57,6 +57,7 @@ extern int cmd_clone(int argc, const char **argv, con=
st char *prefix);
 extern int cmd_clean(int argc, const char **argv, const char *prefix);
 extern int cmd_commit(int argc, const char **argv, const char *prefix)=
;
 extern int cmd_commit_tree(int argc, const char **argv, const char *pr=
efix);
+extern int cmd_config(int argc, const char **argv, const char *prefix)=
;
 extern int cmd_count_objects(int argc, const char **argv, const char *=
prefix);
 extern int cmd_describe(int argc, const char **argv, const char *prefi=
x);
 extern int cmd_diff_files(int argc, const char **argv, const char *pre=
fix);
@@ -110,7 +111,7 @@ extern int cmd_reflog(int argc, const char **argv, =
const char *prefix);
 extern int cmd_remote(int argc, const char **argv, const char *prefix)=
;
 extern int cmd_remote_ext(int argc, const char **argv, const char *pre=
fix);
 extern int cmd_remote_fd(int argc, const char **argv, const char *pref=
ix);
-extern int cmd_config(int argc, const char **argv, const char *prefix)=
;
+extern int cmd_repo_config(int argc, const char **argv, const char *pr=
efix);
 extern int cmd_rerere(int argc, const char **argv, const char *prefix)=
;
 extern int cmd_reset(int argc, const char **argv, const char *prefix);
 extern int cmd_rev_list(int argc, const char **argv, const char *prefi=
x);
diff --git a/builtin/config.c b/builtin/config.c
index ca4a0db..dad86fe 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -500,3 +500,9 @@ int cmd_config(int argc, const char **argv, const c=
har *prefix)
=20
 	return 0;
 }
+
+int cmd_repo_config(int argc, const char **argv, const char *prefix)
+{
+	fprintf(stderr, "WARNING: git repo-config is deprecated in favor of g=
it config.\n");
+	return cmd_config(argc, argv, prefix);
+}
diff --git a/git.c b/git.c
index 23610aa..65ed68f 100644
--- a/git.c
+++ b/git.c
@@ -392,7 +392,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "remote-ext", cmd_remote_ext },
 		{ "remote-fd", cmd_remote_fd },
 		{ "replace", cmd_replace, RUN_SETUP },
-		{ "repo-config", cmd_config, RUN_SETUP_GENTLY },
+		{ "repo-config", cmd_repo_config, RUN_SETUP_GENTLY },
 		{ "rerere", cmd_rerere, RUN_SETUP },
 		{ "reset", cmd_reset, RUN_SETUP },
 		{ "rev-list", cmd_rev_list, RUN_SETUP },
--=20
1.7.4

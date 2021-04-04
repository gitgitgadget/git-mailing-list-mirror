Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BF0C433ED
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 17:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D15C36128D
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 17:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhDDROZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Apr 2021 13:14:25 -0400
Received: from mout.web.de ([212.227.17.11]:42285 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231152AbhDDROX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Apr 2021 13:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1617556456;
        bh=DUTGqprVq+fdrNsCq7G09jPRAeoOKWwYBO1Vke6qusw=;
        h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
        b=nLxFoCmT1rKSKpWHzwG4jVy3AdH2SxGqyzDV8C/VV7mVge7se5wqVqrFe6OmObJnH
         MArPNs/bLU3jshuKem4JdIHzePJuQrMJS6B86G+kQoiqh9RFnzbDeBc82QG0wCFxG/
         pk582nnHeBcUdKHmiwOyfCGtIx8B54zMiclTqbnw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([62.20.115.19]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LcgVn-1luhdX1h8J-00k7E0; Sun, 04
 Apr 2021 19:14:16 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org, d.torilov@gmail.com
Subject: [PATCH v3 2/2] MacOs: Precompose startup_info->prefix
Date:   Sun,  4 Apr 2021 19:14:14 +0200
Message-Id: <20210404171414.32322-1-tboegi@web.de>
X-Mailer: git-send-email 2.30.0.155.g66e871b664
In-Reply-To: <xmqqtuotfre5.fsf@gitster.g>
References: <xmqqtuotfre5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AIryYfpbaDe8ywQdnZYlYOBIEDtRlpce00InNhFcVq2pnaDK0JW
 MiqCFTdX5eTK0HCiEk1KAQcySMZBegelfPS2wTfYqHrh7PzN8QH/NfU9wFk0lEcVaIQC98u
 witZAEMPd6Tarr7hRITGrENWv7rrOhASRZGdvxJHUgst5lOuEWlPElmZMGK+eYdEKxD3rUz
 2ftQeoC9Uv5DmTjldqnVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zBBX/k0L0Ik=:cwfMnvMG0mgEgH+PCUJ9hl
 ii4+s2iZnOVS4MDibk8ty4jkhDnmAXtYZcbdVU70gDcGQrITq7gyrHV9kPuLahKbnlTWsSLAe
 Rx1MmlPAQGo0//L0qR1v3M/nrk0f2J/O5tMCQZKBJYMnheMwSLYmboywnmtCKkALC2VKN8las
 joRtj6MA7ypPMF40kYDOvSHz1W5VEBX776bNQm0kMEhJtGOwyq4F+ip92XjMBemGe7PIIYsaY
 KVNCZQJCx+cavGmYTRORqwE/2gO0Ti+oe/uDT7DC8SMo/h2liUjeCDffho3X52B/hapQDn5xN
 rKC+3FNApC1MAaRgWYcpCRLWBOQzXtmtT6a0zvWVcJDVaW+aFd/54EfjqU7CBNqUhzXCciqNL
 Hu1LbqUnwrANljCESjHHuovsIoTFSEWCEmt4qTDogrjAaszg0OHSIkyZXN40OHzbqIBkyQt8p
 2KPb+M4aMvtqkbAPZAJqHclOBm5Z9irIqzqCnST2fZbuV9EA2UCSm4FD2Pp4Hij4FQmMi+qAy
 XuhwV1DHaMXijCrP8rx5yaAuOf8MfvU6IELUfR1OW2Hbw/QRV3YKgf97el+C/e01bZtcj0CHE
 WJ3jbfe9OOMEgcA9IbZ6RSVZNzI+SlW5FynZhKDwxH6CK8Z30lFjGnyI0L5Aa6/mm2q3STPMC
 S4eMx43uTTUCAgOVFXAhq/2dbqx1mAGEb8Qf4yOM7UWyIcE/HdHd8ThlDHiUuiyqdEt0UjTrK
 eNly5ngOunTVDy5qFCnzmgpbGSpGOgfuF9Tt6G26GqEHpeozePiTZvEZgnY/FSACL/iMhUcTN
 FZOCrx0/igiN/9WBqlsEURWPSJjLJz7L9Ia+Xw3/euPs2g946HefSj0mBH/nl2T2oCKmwkGU7
 vmO5HPU9UZD68e9QOpNyEO8/bHwv9j47rZjFOXWUkjDMjfnfWfoI0Mbx0sdJQF4dJlPT25aNm
 ppVw7l8mTwFixpvZcSybLoQZgS1RKPl/U0VklZLD2xp96oHT8k5PPrQxAMy73LefRH69lAIZn
 TH9faH+izNlXONwDNAMA8EssP6l/B1/3JDNh4vtzxHfuysDGPChIFj/3iEypOgatZWpvavlrR
 19Ij5vSANHwjfU6dy6BSvbOALff9IN+t2Wpwqyg+a+3tOl+cxvaAb+8+YoosK/DpZOo4LeiXr
 YLJ/0YZBH9F4BxdvVHrnPPxqlpU2ldGlRPrnZxf3q+M1iOl7EtUMmabbr7fvM7zPqJOFU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten B=C3=B6gershausen <tboegi@web.de>

The "prefix" was precomposed for MacOs in commit 5c327502db,
MacOS: precompose_argv_prefix()

However, this commit forgot to update "startup_info->prefix" after
precomposing.

Move the (possible) precomposition towards the end of
setup_git_directory_gently(), so that precompose_string_if_needed()
can use git_config_get_bool("core.precomposeunicode") correctly.

Keep prefix, startup_info->prefix and GIT_PREFIX_ENVIRONMENT all in sync.

And as a result, the prefix no longer needs to be precomposed in git.c

Reported-by: Dmitry Torilov <d.torilov@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--

 Changes since V2:
 - Re-arranged code in setup.c to be more consistent
 - Added the longer comment block, as suggested by Junio, thanks for that.

 git.c   |  2 +-
 setup.c | 28 ++++++++++++++++++----------
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/git.c b/git.c
index 9bc077a025..b53e665671 100644
=2D-- a/git.c
+++ b/git.c
@@ -423,7 +423,7 @@ static int run_builtin(struct cmd_struct *p, int argc,=
 const char **argv)
 			int nongit_ok;
 			prefix =3D setup_git_directory_gently(&nongit_ok);
 		}
-		prefix =3D precompose_argv_prefix(argc, argv, prefix);
+		precompose_argv_prefix(argc, argv, NULL);
 		if (use_pager =3D=3D -1 && p->option & (RUN_SETUP | RUN_SETUP_GENTLY) &=
&
 		    !(p->option & DELAY_PAGER_CONFIG))
 			use_pager =3D check_pager_config(p->cmd);
diff --git a/setup.c b/setup.c
index c04cd25a30..59e2facd9d 100644
=2D-- a/setup.c
+++ b/setup.c
@@ -1274,18 +1274,10 @@ const char *setup_git_directory_gently(int *nongit=
_ok)
 	 * the GIT_PREFIX environment variable must always match. For details
 	 * see Documentation/config/alias.txt.
 	 */
-	if (nongit_ok && *nongit_ok) {
+	if (nongit_ok && *nongit_ok)
 		startup_info->have_repository =3D 0;
-		startup_info->prefix =3D NULL;
-		setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
-	} else {
+	else
 		startup_info->have_repository =3D 1;
-		startup_info->prefix =3D prefix;
-		if (prefix)
-			setenv(GIT_PREFIX_ENVIRONMENT, prefix, 1);
-		else
-			setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
-	}

 	/*
 	 * Not all paths through the setup code will call 'set_git_dir()' (which
@@ -1311,6 +1303,22 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
 		if (startup_info->have_repository)
 			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
 	}
+	/*
+	 * Since precompose_string_if_needed() needs to look at
+	 * the core.precomposeunicode configuration, this
+	 * has to happen after the above block that finds
+	 * out where the repository is, i.e. a preparation
+	 * for calling git_config_get_bool().
+	 */
+	if (prefix) {
+		prefix =3D precompose_string_if_needed(prefix);
+		startup_info->prefix =3D prefix;
+		setenv(GIT_PREFIX_ENVIRONMENT, prefix, 1);
+	} else {
+		startup_info->prefix =3D NULL;
+		setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
+	}
+

 	strbuf_release(&dir);
 	strbuf_release(&gitdir);
=2D-
2.30.0.155.g66e871b664


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D2FC433ED
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 06:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B91186115A
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 06:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhDDGSG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Apr 2021 02:18:06 -0400
Received: from mout.web.de ([212.227.15.14]:59019 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229565AbhDDGSG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Apr 2021 02:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1617517080;
        bh=NQI3TEDgZlG2KJ4wwHBXpAY8t0yd3qLFlhe0b72vHME=;
        h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
        b=ZgJE43GgbIMM/9jJkQTX3Hz4obNvNFHH1gAlsN+V9oEe69Xccq7pIlnINysZ66AXZ
         fRKHL4b5f3jal/oqiNgKhEGs32EM/SsCRj7aAwsL1zQQ/ri5RpUIKUqYdDJUCKNkWX
         E7cxeIZH2ZK+8ComiKcZF9wPfP1HCIGjjq2GRXEU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([62.20.115.19]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lx2Wv-1ldju52N6v-016bo7; Sun, 04
 Apr 2021 08:18:00 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org, d.torilov@gmail.com
Subject: [PATCH v2 2/2] MacOs: Precompose startup_info->prefix
Date:   Sun,  4 Apr 2021 08:17:54 +0200
Message-Id: <20210404061754.19428-1-tboegi@web.de>
X-Mailer: git-send-email 2.30.0.155.g66e871b664
In-Reply-To: <xmqqtuotfre5.fsf@gitster.g>
References: <xmqqtuotfre5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JAeDzMxxIM38Pguen4Y5ZYvfpdehsAKxX16NYoDpjtwoDhj5d6H
 HLOX1Z9Lyde/l1mTU2f6FfPMuqaVWMeajffVPEAV3PrXAkryWGTPtQtHgh14hQ+Hi2VeJJB
 JNuXuOIrsX1yt++UYE8jw3a9Ry2lmOAe/nptUCv5qfFbiwZlZ6KVU0uXeeXjuy43y4Oh/gy
 mx5GPez2fF1pTSdBEfPJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+rEf9TLQ1jE=:CW/FguOqG4mECNZtRaJ1jL
 RXSsS4CMkjZTGUpiIs2IQOh5NcTztnvEnGwvyal1crMenYDN32SCVs2whgdJVjF9oN6bu0Dat
 5Gm24MxEapviT6QtGfmmd3lXBfXrH+QBOAyjVkm+mfRIl28PQPVufNHcY+JeCJmmI6PMN/HD2
 8wdYpBB2g78PjdAmwKCHARcI7/lNrRKNrFCOmvKNw7Xtn3ppQTRTqvK2Ijv/HIGJEcUDowJYb
 jt9Y5d7njvvMovX+O2fyhnsCRh2gyA16Om3ihuqk/vwFjfy66GZ3G2IMSaP+U8ju5JG30CYbf
 84Wj9HLfRQbQiWV0mnxVJRGFiO8OmPfE8/OMfcJakxG+GYNZDdxDrl9fvULsJ66B/sSod9IDX
 L+HWe4lXGMQwZfKrUwQqgUw9tB/1sJ5z3L4q7IExsx8Yd4QdOSNUDuj0yIId+5JsYjbCVBV+D
 uEZ3lsH4kVOSD6r7yiYAbI8kuXH8uGngKu7deapcuJa6SWwnXyc15/w1D1O6A53H2eTalee8Z
 6pNv9qzAqZYC4II+IEE+SQ8KSVhi9hUZE3q8Fo0CX/bq56AjCawpJ3NI/8LUyDsYu1rcAwk6k
 FTxDLkR+JgEdhH1XU9Mtt7vXvamHUFBueQVE1YooK+TUiOUv3w2XfZWAJBuqmduOwKPPElAEP
 EsDVn2TwryH7X/TnjF5/EWzfk0iTEYhghSBeH2imiIlZMPtev3qXPaOuz3Ah2+fJLYSX+o8SL
 WSqkQ27kireyJ+dL38KnLHbvEcj+1WtbsWe2Sc2ds5EhlEaU3/LZZ99boRIQ07hnVgjOzP9lf
 1tOaJYmma7uWUzJf0dm5/0NwBhHkiIy4l66EG0uXIyVP1UnBhgaXTrszSOcHGTgtwrZEDySX1
 lg4brXNPcGO48udN2MSX6jvVZJtGbKRnFYt9evEGCEdHzpMmBm95WO9Uk/j8x7yzNlYovj4dI
 742/6DCeBvl1aiXadX1XJlUF7hfueSK6pPSrgwtBJ81LRkK+lruWN805zh23go0s4exPUi//M
 3yNI/nyJxmk9uZGdQu1pUtBNXe7hc64jcBq1NQ4m5sddBL+HGM63UHNPJb55YrwVoTVdBwVV0
 ukwJObtq1lqnJuXgc2SpfH1RdpnenSJo66sn1rmjlevMLRPru+dgiljLf+x9QLJytwrsi7lST
 A/djeeElgX2ELP9zulTP84gUInZ1mWBcem8KOnELvhwiljlJnjkru5J7TB+4MAogkxIHI=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten B=C3=B6gershausen <tboegi@web.de>

The "prefix" was precomposed for MacOs in commit 5c327502db,
MacOS: precompose_argv_prefix()

However, this commit forgot to update "startup_info->prefix" after
precomposing.
Re-arrange the code in setup.c:
Move the (possible) precomposition towards the end of
setup_git_directory_gently(), so that precompose_string_if_needed()
can use git_config_get_bool("core.precomposeunicode") correctly.

Keep prefix, startup_info->prefix and GIT_PREFIX_ENVIRONMENT all in sync.

And as a result, the prefix no longer needs to be precomposed in git.c

Reported-by: Dmitry Torilov <d.torilov@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--

 This part did never made it to the list - it should have gone only
 to tboegi@web.de
 git send-email decided to cc to the "Helped-by" and "Reported-by" address=
es,
 a feature that I was not aware of - and can be turned off with --suppress=
-cc=3Dall
 In other words, I typically send these emails only to my self first, re-r=
ead
 with fresh eyes, and then send them out. End of of blabla.

Changes since V1:
 Add a comment in setup.c, to make more clear that git_config_get_bool()
 is called, and the setup_XXX() must have prepared everything needed.

 git.c   |  2 +-
 setup.c | 14 ++++++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

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
index c04cd25a30..dcc9c41a85 100644
=2D-- a/setup.c
+++ b/setup.c
@@ -1281,10 +1281,6 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
 	} else {
 		startup_info->have_repository =3D 1;
 		startup_info->prefix =3D prefix;
-		if (prefix)
-			setenv(GIT_PREFIX_ENVIRONMENT, prefix, 1);
-		else
-			setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
 	}

 	/*
@@ -1311,6 +1307,16 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
 		if (startup_info->have_repository)
 			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
 	}
+	/* Keep prefix, startup_info->prefix and GIT_PREFIX_ENVIRONMENT in sync =
*/
+	prefix =3D startup_info->prefix;
+	if (prefix) {
+		/* This calls git_config_get_bool() under the hood (MacOs only) */
+		prefix =3D precompose_string_if_needed(prefix);
+		startup_info->prefix =3D prefix;
+		setenv(GIT_PREFIX_ENVIRONMENT, prefix, 1);
+	} else {
+		setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
+	}

 	strbuf_release(&dir);
 	strbuf_release(&gitdir);
=2D-
2.30.0.155.g66e871b664


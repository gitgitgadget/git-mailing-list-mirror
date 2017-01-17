Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 335C220756
	for <e@80x24.org>; Tue, 17 Jan 2017 21:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751291AbdAQVTm (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 16:19:42 -0500
Received: from mout.gmx.net ([212.227.17.21]:55805 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751108AbdAQVTl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 16:19:41 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MRocn-1c1N2a17Q9-00T0av; Tue, 17
 Jan 2017 22:19:25 +0100
Date:   Tue, 17 Jan 2017 22:19:24 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Andrew Arnott <Andrew.Arnott@microsoft.com>
Subject: [PATCH 2/2] Be more careful when determining whether a remote was
 configured
In-Reply-To: <cover.1484687919.git.johannes.schindelin@gmx.de>
Message-ID: <41c347f22c80e96c54db34baa739b6e37e268b61.1484687919.git.johannes.schindelin@gmx.de>
References: <cover.1484687919.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NRG/w7iv8wkFYExoyTMLHLSbIqMjIrYb/dnr/xAYErN/Nt4wBJG
 9OCX9Zs4bgEDyFy65S41e//5J7VwsQgU/mVn+/Tm80wmlA8eTzTnPPiRn08QIKwrS55Bh8L
 MuB3HgcmrnIpeXM/SHpCXW0pNkxz2ty/fyjhf4wy11StqWpVOJ83HT0Ah0+LrcQBVgGLrjm
 ZPhGJ1OU3cVZCPHcgsPoA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zFRkAwYhQOk=:1zXQPF+8SjOqWoe0XjgXh0
 Taa7acACApi9DysqbJDUTlzryfGt4zKNnTpIS1KXL/Sw6NAAXmKUR5bEGYlngjrlY1yZPBMnq
 UoQoDJQ6BdKczyQNDsgDDYf8c3m52gModMRePjpPv3ofG+xkCmLx4CbzI0ONam5xQtkAKtqkT
 iRoNVEVQvxrw9ZfUVt6GN/8nIQqxgoYEGOa6ZNC87mV9p5aLKY8QUcVa4QhXp52tNYE2ne3Pr
 4J968HF75wxrjFLv7KRmWQQhYz5ubcGOniVpM730lAv/k3OsFkUukV6Ht6OYgr6MEXPTKyaur
 4CZkBD3j/SOGys3aYEMeTOkN9ltE9JLuqZ9cNIquqikpI1sWF+N4WWBmYUY8XJZLUlPm2WJyJ
 lJCPIExvtDU20fG91gnrx6+9daAoAQxgaZOcUdXggxMW4kmNQvm1jrjWHx8zaPapXj8a+Jrzf
 PktXJHLASF4ArgAltTeKSD/WKVuHlZFI2GC4lAIocmRQwp10wCZqnpWYm7aTjBlRSjTEFd7va
 paWSvi7+Fau/l+KSJfb5hlVAq9umA8vIn5k0a5H3sfAJVXXIRHF+FdSB8Cwc7nY5YvqFoRlxc
 9Xd/yISbAoctWsliESqBNS0mEpknRxti9p6Zbcmk8yRWzIRoiRTGpDRFc/N/5h4nMj/ksgoGa
 yerQaVQFLBhY36TuekjQNmcY9A1LlslSaEsWYLUH9rhCl4i5MMcntfLTWXSEHJxmd3fqXqB4T
 gvtAY2xD94AnVDcOOV5IG2kV11FrOZUFNBHisqC2+QxnEIhpBZJZVR5lFZqezJ8KI3tOEh3LO
 jv3mrOhY9ZgDfhISakmGk6V1KLpEfCOchMzikyyFDqjriHN/5bW8EKtQoDnUUuzbkIX8sQVLZ
 DNoC2n/7hiStkzx41XnHBnVXmunxnu/FbaxtL82s541lnGMv0ZgqrreZTJgdyZ+pKo3aYJIe5
 53N+5c/O9CQNvec7eMOeQbjXLP77NnxUV//BQUv08+w9Ij1x/94cb0lXMm8V0QkHp5mCXLtNd
 eVz60Jd2nkBIOv2UZrUEH7M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of the really nice features of the ~/.gitconfig file is that users
can override defaults by their own preferred settings for all of their
repositories.

One such default that some users like to override is whether the
"origin" remote gets auto-pruned or not. The user would simply call

	git config --global remote.origin.prune true

and from now on all "origin" remotes would be pruned automatically when
fetching into the local repository.

There is just one catch: now Git thinks that the "origin" remote is
configured, as it does not discern between having a remote whose
fetch (and/or push) URL and refspec is set, and merely having
preemptively-configured, global flags for specific remotes.

Let's fix this by telling Git that a remote is not configured unless any
fetch/push URL or refspect is configured explicitly.

As a special exception, we deem a remote configured also when *only* the
"vcs" setting is configured. The commit a31eeae27f (remote: use
remote_is_configured() for add and rename, 2016-02-16) specifically
extended our test suite to verify this, so it is safe to assume that there
has been at least one user with a legitimate use case for this.

This fixes https://github.com/git-for-windows/git/issues/888

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 remote.c          | 9 ++++++++-
 remote.h          | 2 +-
 t/t5505-remote.sh | 2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index ad6c5424ed..298f2f93fa 100644
--- a/remote.c
+++ b/remote.c
@@ -255,6 +255,7 @@ static void read_remotes_file(struct remote *remote)
 
 	if (!f)
 		return;
+	remote->configured = 1;
 	remote->origin = REMOTE_REMOTES;
 	while (strbuf_getline(&buf, f) != EOF) {
 		const char *v;
@@ -289,6 +290,7 @@ static void read_branches_file(struct remote *remote)
 		return;
 	}
 
+	remote->configured = 1;
 	remote->origin = REMOTE_BRANCHES;
 
 	/*
@@ -384,21 +386,25 @@ static int handle_config(const char *key, const char *value, void *cb)
 		if (git_config_string(&v, key, value))
 			return -1;
 		add_url(remote, v);
+		remote->configured = 1;
 	} else if (!strcmp(subkey, "pushurl")) {
 		const char *v;
 		if (git_config_string(&v, key, value))
 			return -1;
 		add_pushurl(remote, v);
+		remote->configured = 1;
 	} else if (!strcmp(subkey, "push")) {
 		const char *v;
 		if (git_config_string(&v, key, value))
 			return -1;
 		add_push_refspec(remote, v);
+		remote->configured = 1;
 	} else if (!strcmp(subkey, "fetch")) {
 		const char *v;
 		if (git_config_string(&v, key, value))
 			return -1;
 		add_fetch_refspec(remote, v);
+		remote->configured = 1;
 	} else if (!strcmp(subkey, "receivepack")) {
 		const char *v;
 		if (git_config_string(&v, key, value))
@@ -427,6 +433,7 @@ static int handle_config(const char *key, const char *value, void *cb)
 		return git_config_string((const char **)&remote->http_proxy_authmethod,
 					 key, value);
 	} else if (!strcmp(subkey, "vcs")) {
+		remote->configured = 1;
 		return git_config_string(&remote->foreign_vcs, key, value);
 	}
 	return 0;
@@ -716,7 +723,7 @@ struct remote *pushremote_get(const char *name)
 
 int remote_is_configured(struct remote *remote)
 {
-	return remote && remote->origin;
+	return remote && remote->configured;
 }
 
 int for_each_remote(each_remote_fn fn, void *priv)
diff --git a/remote.h b/remote.h
index 924881169d..7e6c8067bb 100644
--- a/remote.h
+++ b/remote.h
@@ -15,7 +15,7 @@ struct remote {
 	struct hashmap_entry ent;  /* must be first */
 
 	const char *name;
-	int origin;
+	int origin, configured;
 
 	const char *foreign_vcs;
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index d7e41e9230..09c9823002 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -764,7 +764,7 @@ test_expect_success 'rename a remote with name prefix of other remote' '
 	)
 '
 
-test_expect_failure 'rename succeeds with existing remote.<target>.prune' '
+test_expect_success 'rename succeeds with existing remote.<target>.prune' '
 	git clone one four.four &&
 	(
 		cd four.four &&
-- 
2.11.0.windows.3

From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 48/86] builtin/checkout: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:41 +0100
Message-ID: <20131109070720.18178.2421.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:10:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2gO-00044O-Tb
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:10:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933328Ab3KIHJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:09:58 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:36401 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933283Ab3KIHIk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:40 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id D3245AD;
	Sat,  9 Nov 2013 08:08:39 +0100 (CET)
X-git-sha1: f1b76bf150a72c49d97a6426acd53e4c780956f9 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237508>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/checkout.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0f57397..7ce15dd 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -781,7 +781,7 @@ static int switch_branches(const struct checkout_opts *opts,
 	if (!(flag & REF_ISSYMREF))
 		old.path = NULL;
 
-	if (old.path && !prefixcmp(old.path, "refs/heads/"))
+	if (old.path && has_prefix(old.path, "refs/heads/"))
 		old.name = old.path + strlen("refs/heads/");
 
 	if (!new->name) {
@@ -816,7 +816,7 @@ static int git_checkout_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	if (!prefixcmp(var, "submodule."))
+	if (has_prefix(var, "submodule."))
 		return parse_submodule_config_option(var, value);
 
 	return git_xmerge_config(var, value, NULL);
@@ -1108,9 +1108,9 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		const char *argv0 = argv[0];
 		if (!argc || !strcmp(argv0, "--"))
 			die (_("--track needs a branch name"));
-		if (!prefixcmp(argv0, "refs/"))
+		if (has_prefix(argv0, "refs/"))
 			argv0 += 5;
-		if (!prefixcmp(argv0, "remotes/"))
+		if (has_prefix(argv0, "remotes/"))
 			argv0 += 8;
 		argv0 = strchr(argv0, '/');
 		if (!argv0 || !argv0[1])
-- 
1.8.4.1.566.geca833c

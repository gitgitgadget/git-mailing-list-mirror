From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 8/9] push.c: add an --atomic argument
Date: Mon, 29 Dec 2014 13:35:14 -0800
Message-ID: <1419888915-31760-9-git-send-email-sbeller@google.com>
References: <1419888915-31760-1-git-send-email-sbeller@google.com>
Cc: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 22:35:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5hyi-0001nx-4Z
	for gcvg-git-2@plane.gmane.org; Mon, 29 Dec 2014 22:35:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569AbaL2Vfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 16:35:36 -0500
Received: from mail-ig0-f170.google.com ([209.85.213.170]:36234 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517AbaL2Vfc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 16:35:32 -0500
Received: by mail-ig0-f170.google.com with SMTP id r2so12918478igi.1
        for <git@vger.kernel.org>; Mon, 29 Dec 2014 13:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YNNV1yRF2GeFp6xydDmOkiznLkrCKJb5G6wbwhmbZWQ=;
        b=o68RWWIiuuSVyRHnG2SkoHwljx41YGxrd7IW7urKO+GCg0UkT+de2BeGH4f9Yqtszd
         bg8VvIPqlTDwkw2DNUGD+i8NBBphVrABNF2r8YDbkrNaCDxQwv+1SAGWPB0X/KyF9zAO
         9ISksRc+t+Vqq1Z8FUsYJ0jEcFcTx97gmVgJGb+uL28jPhab9SzrGVuIY1CGXzN8UIjh
         UWT/9EjT+TkiwpotsejbztMvWLNo/X0fQLOHJ0qruxmVqylgZqzWrS+HDpalSZ+KZp6s
         A1WZB1XNpTVbUatSNMxcI+RcFJjxpU3KCfwmIPyzdgZtjosdhgdtE3lmJ0/2szP83kDb
         s5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YNNV1yRF2GeFp6xydDmOkiznLkrCKJb5G6wbwhmbZWQ=;
        b=ehAPTr/4lH+PIZldi04acxKryTDE6q5XfPsdkryf12mRMDKkLKHOfqCLNtn0ckzcFp
         PAjpHSnWH7yOwQjwCsoODi79tJfZrW3FQVueYXuOXU+EBpCFkrqcRT0RgLOEdfzvNonI
         Uxih2PW1ZMZi2iEOnzHqxUptHbWekYaSHb4Hn35nxPolE3w2fvGIR2Rya1V+aHarsJRh
         gq/iGW78qmZNFw5ssnlI0IyedevL1kPT6XJxM2lUAfan6jHGIH7CvStoMgT+OaRPv/tf
         14KRPxdKs27P4y5SHwMW6EQppBReByUQLNa2EUROCxKSmrcip/SbTji0eoFbTEXMmVoP
         63aw==
X-Gm-Message-State: ALoCoQmJNi5KMhCdtwso4e5IzmrL7KGGViIRLEazhb9Ir1oNiSaok1QjHY1cDTVCYuh5+TGEZ45z
X-Received: by 10.43.44.201 with SMTP id uh9mr42989663icb.51.1419888931699;
        Mon, 29 Dec 2014 13:35:31 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5860:dcf1:88a4:141b])
        by mx.google.com with ESMTPSA id s10sm14771397igr.2.2014.12.29.13.35.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Dec 2014 13:35:31 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1419888915-31760-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261889>

From: Ronnie Sahlberg <sahlberg@google.com>

Add a command line argument to the git push command to request atomic
pushes.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:   
    Changes v1 -> v2
    	It's --atomic now! (dropping the -push)
    
    v2->v3:
    	* s/atomic-push/atomic/
    	* s/the an/an/
    	* no serverside, but just remote instead
    	* TRANSPORT_PUSH_ATOMIC instead of TRANSPORT_ATOMIC_PUSH
    
    skipped v4 v5
    
    v6:
    -		OPT_BIT(0, "atomic", &flags, N_("use an atomic transaction remote"),
    +		OPT_BIT(0, "atomic", &flags, N_("request atomic transaction on remote side"),
    
    v7:
    	Use OPT_BOOL instead of OPT_BIT.
    	This allows for --no-atomic option on the command line.

 Documentation/git-push.txt | 7 ++++++-
 builtin/push.c             | 5 +++++
 transport.c                | 1 +
 transport.h                | 1 +
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 21b3f29..4764fcf 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -9,7 +9,7 @@ git-push - Update remote refs along with associated objects
 SYNOPSIS
 --------
 [verse]
-'git push' [--all | --mirror | --tags] [--follow-tags] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
+'git push' [--all | --mirror | --tags] [--follow-tags] [--atomic] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
 	   [--repo=<repository>] [-f | --force] [--prune] [-v | --verbose]
 	   [-u | --set-upstream] [--signed]
 	   [--force-with-lease[=<refname>[:<expect>]]]
@@ -136,6 +136,11 @@ already exists on the remote side.
 	logged.  See linkgit:git-receive-pack[1] for the details
 	on the receiving end.
 
+--[no-]atomic::
+	Use an atomic transaction on the remote side if available.
+	Either all refs are updated, or on error, no refs are updated.
+	If the server does not support atomic pushes the push will fail.
+
 --receive-pack=<git-receive-pack>::
 --exec=<git-receive-pack>::
 	Path to the 'git-receive-pack' program on the remote
diff --git a/builtin/push.c b/builtin/push.c
index a076b19..8f1d945 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -487,6 +487,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	int flags = 0;
 	int tags = 0;
 	int rc;
+	int atomic = 0;
 	const char *repo = NULL;	/* default repository */
 	struct option options[] = {
 		OPT__VERBOSITY(&verbosity),
@@ -518,6 +519,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "follow-tags", &flags, N_("push missing but relevant tags"),
 			TRANSPORT_PUSH_FOLLOW_TAGS),
 		OPT_BIT(0, "signed", &flags, N_("GPG sign the push"), TRANSPORT_PUSH_CERT),
+		OPT_BOOL(0, "atomic", &atomic, N_("request atomic transaction on remote side")),
 		OPT_END()
 	};
 
@@ -533,6 +535,9 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	if (tags)
 		add_refspec("refs/tags/*");
 
+	if (atomic)
+		flags |= TRANSPORT_PUSH_ATOMIC;
+
 	if (argc > 0) {
 		repo = argv[0];
 		set_refspecs(argv + 1, argc - 1, repo);
diff --git a/transport.c b/transport.c
index c67feee..1373152 100644
--- a/transport.c
+++ b/transport.c
@@ -830,6 +830,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	args.dry_run = !!(flags & TRANSPORT_PUSH_DRY_RUN);
 	args.porcelain = !!(flags & TRANSPORT_PUSH_PORCELAIN);
 	args.push_cert = !!(flags & TRANSPORT_PUSH_CERT);
+	args.atomic = !!(flags & TRANSPORT_PUSH_ATOMIC);
 	args.url = transport->url;
 
 	ret = send_pack(&args, data->fd, data->conn, remote_refs,
diff --git a/transport.h b/transport.h
index 3e0091e..18d2cf8 100644
--- a/transport.h
+++ b/transport.h
@@ -125,6 +125,7 @@ struct transport {
 #define TRANSPORT_PUSH_NO_HOOK 512
 #define TRANSPORT_PUSH_FOLLOW_TAGS 1024
 #define TRANSPORT_PUSH_CERT 2048
+#define TRANSPORT_PUSH_ATOMIC 4096
 
 #define TRANSPORT_SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
 #define TRANSPORT_SUMMARY(x) (int)(TRANSPORT_SUMMARY_WIDTH + strlen(x) - gettext_width(x)), (x)
-- 
2.2.1.62.g3f15098

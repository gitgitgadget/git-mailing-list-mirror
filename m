From: "Sidhant Sharma [:tk]" <tigerkid001@gmail.com>
Subject: [PATCH v2] builtin/receive-pack.c: use parse_options API
Date: Wed,  2 Mar 2016 01:51:01 +0530
Message-ID: <1456863661-22783-1-git-send-email-tigerkid001@gmail.com>
References: <1456846560-9223-1-git-send-email-tigerkid001@gmail.com>
Cc: matthieu.moy@grenoble-inp.fr, sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 01 21:21:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaqnL-0001rA-U5
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 21:21:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718AbcCAUVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 15:21:19 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36823 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845AbcCAUVS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 15:21:18 -0500
Received: by mail-pf0-f195.google.com with SMTP id q129so5269448pfb.3
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 12:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=YN2bEPHJKq5yNW54xE+/jl6JpmV16a0wyWYYyXRODVg=;
        b=FPb8I6EZKD6KMwug3HhFl1RzondUvgyId795Ev0QKcjau59S9lK0Qr+/jgjJmpxJrJ
         2OOfBkfDWmGQJ4fOsajNPGxTaZ0PbJfppBXn8BSWKeyORSg1SmmOlNOFn6c4uQvekpQ6
         MOKyifA4oO+CXlOWEj0G5v8UR90EZn4DQ15OhX9hi9a76ehu+P5k6/qpl27tEzMGPUL3
         H1r9tpxsVrwxihT4H64j3u5jKGl0ngpsdsUCrXc14AKsotX3YxVQdiiMnB+Kp74P+y2T
         V+ygo/h2Xlif3NZ25D0UfF/5bN3XO4K4H+f72l6c5X+XGCnVKN/7FSdE98qjnVlxuMkL
         r/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=YN2bEPHJKq5yNW54xE+/jl6JpmV16a0wyWYYyXRODVg=;
        b=cEeo6M3CbwqhRtgG2n3bGWCepku0lkKFRzse4NMnUiovFJf33ANOy/5UHoTQYHYgHq
         k48tPlZqx967IHX8MBj96b4Mw0YXcwZQeBHY9WjJxzIMEA9PhPaUXB38Md+MJ3n53br7
         AW3MvQTbXI47nLTYknAu+ExHd3uyRbLm6eXZb4LohmPYao27m/sSo5eS8udP5ILiZrXC
         ozuXXT/eiv8KSwgH86eYElNVegXm1tjUTxTDhlCAhoUN9VnyDPcbcrhJDFVPJCXc1+2D
         kmi290+uZhVZdwAlUw9TmC5Zs3t5mezm0+HFXRZQJ+49lfOOftUiGIwMsRWS0ho3H8XV
         b4Cw==
X-Gm-Message-State: AD7BkJJB8556Tj27qC6f6Yv3IfyWddJC2hmwWUIeJpwfWkpIe56jmNMXl/MynSugjgjP5A==
X-Received: by 10.98.89.200 with SMTP id k69mr32206273pfj.56.1456863677837;
        Tue, 01 Mar 2016 12:21:17 -0800 (PST)
Received: from localhost.localdomain ([182.68.185.50])
        by smtp.gmail.com with ESMTPSA id ez6sm6655758pab.12.2016.03.01.12.21.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Mar 2016 12:21:17 -0800 (PST)
X-Mailer: git-send-email 2.7.2
In-Reply-To: <1456846560-9223-1-git-send-email-tigerkid001@gmail.com>
In-Reply-To: <1456846560-9223-1-git-send-email-tigerkid001@gmail.com>
References: <1456846560-9223-1-git-send-email-tigerkid001@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288060>

Make receive-pack use the parse_options API,
bringing it more in line with send-pack and push.

Helped-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Sidhant Sharma [:tk] <tigerkid001@gmail.com>
---

 Link to previous version: $gmane/288035

 builtin/receive-pack.c | 53 +++++++++++++++++++-------------------------------
 1 file changed, 20 insertions(+), 33 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c8e32b2..220a899 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -21,7 +21,10 @@
 #include "sigchain.h"
 #include "fsck.h"

-static const char receive_pack_usage[] = "git receive-pack <git-dir>";
+static const char * const receive_pack_usage[] = {
+	N_("git receive-pack <git-dir>"),
+	NULL
+};

 enum deny_action {
 	DENY_UNCONFIGURED,
@@ -49,7 +52,7 @@ static int quiet;
 static int prefer_ofs_delta = 1;
 static int auto_update_server_info;
 static int auto_gc = 1;
-static int fix_thin = 1;
+static int reject_thin;
 static int stateless_rpc;
 static const char *service_dir;
 static const char *head_name;
@@ -1548,7 +1551,7 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		if (fsck_objects)
 			argv_array_pushf(&child.args, "--strict%s",
 				fsck_msg_types.buf);
-		if (fix_thin)
+		if (!reject_thin)
 			argv_array_push(&child.args, "--fix-thin");
 		child.out = -1;
 		child.err = err_fd;
@@ -1707,45 +1710,29 @@ static int delete_only(struct command *commands)
 int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 {
 	int advertise_refs = 0;
-	int i;
 	struct command *commands;
 	struct sha1_array shallow = SHA1_ARRAY_INIT;
 	struct sha1_array ref = SHA1_ARRAY_INIT;
 	struct shallow_info si;

+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("quiet")),
+		OPT_HIDDEN_BOOL(0, "stateless-rpc", &stateless_rpc, NULL),
+		OPT_HIDDEN_BOOL(0, "advertise-refs", &advertise_refs, NULL),
+		OPT_HIDDEN_BOOL(0, "reject-thin-pack-for-testing", &reject_thin, NULL),
+		OPT_END()
+	};
+
 	packet_trace_identity("receive-pack");

-	argv++;
-	for (i = 1; i < argc; i++) {
-		const char *arg = *argv++;
+	argc = parse_options(argc, argv, prefix, options, receive_pack_usage, 0);

-		if (*arg == '-') {
-			if (!strcmp(arg, "--quiet")) {
-				quiet = 1;
-				continue;
-			}
+	if (argc > 1)
+		usage_msg_opt(_("Too many arguments."), receive_pack_usage, options);
+	if (argc == 0)
+		usage_msg_opt(_("You must specify a directory."), receive_pack_usage, options);

-			if (!strcmp(arg, "--advertise-refs")) {
-				advertise_refs = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--stateless-rpc")) {
-				stateless_rpc = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--reject-thin-pack-for-testing")) {
-				fix_thin = 0;
-				continue;
-			}
-
-			usage(receive_pack_usage);
-		}
-		if (service_dir)
-			usage(receive_pack_usage);
-		service_dir = arg;
-	}
-	if (!service_dir)
-		usage(receive_pack_usage);
+	service_dir = argv[0];

 	setup_path();

--
2.7.2

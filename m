From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/26] fetch-pack: use a common function for verbose printing
Date: Wed, 13 Apr 2016 19:54:55 +0700
Message-ID: <1460552110-5554-12-git-send-email-pclouds@gmail.com>
References: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 14:56:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKLH-0004Jx-77
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 14:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030754AbcDMM4R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 08:56:17 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36847 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030725AbcDMM4O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 08:56:14 -0400
Received: by mail-pf0-f194.google.com with SMTP id q129so4049300pfb.3
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 05:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RVBaLEoU/WImwLCnU/bLWTOzeluriJRaSrWH6/C+QPU=;
        b=sA9tc19nHY3i7X5pQq5cVCS0jP2yrd4xc1cJtP/Q88fKdB3heaNRPMr4xIargxrbv4
         dTdWvdBABctPO/HcP6MYELmPY5GS+Wz4qPQl30iPXWfOih2+HjLuz69dFTdcOGp/dtnZ
         1t/iPMcohsBKL88BZ46Vzffe3gJK76xpyW7m/IM8lcsHiz0M34Tt6JSMrDaHMYV7NH7l
         dgBcqgNMuGI6bdkN/uKWvcDRsz6f35DMUaNno0ho5vu+TdjSh7NcMSzvTJL99ECHk4bV
         hZmADT31HIHRtPF3rVp4foSi1Vkn4IOtqoGyS5ZpE4YMiAUCreq2Tf+4Gg/qHsR87m3H
         3Rwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RVBaLEoU/WImwLCnU/bLWTOzeluriJRaSrWH6/C+QPU=;
        b=iknMb/YUSq1QzlqHE6in/YyamCtUqXCKplqVoHkotiOVpV0C1E6U9Fgr5t3TNKqcXe
         F156Hm87hyvMhqubNlri+4B08ktcDsMQIFSNBDohaJNmJzW6DZVmjVAi6DScfO4gEM5z
         LXxyHr6l93IfhS/QsZPOBxFEHiiJlYLbOLRRZbYKfriW9ToCp7Y9C+t2ybEX8PIsZF2V
         MSlXtcn8HJ+63CuZddQiumtUJ+QNkaXuW/XBl9wGhs5LsLkXZ1Q7YYuqEoCH4XzrKeks
         LdJgorkrNn9Jf0hpar1wzIJCCnTk8o4eLp6X7O+i6z1hDh+4pE4LVOTEfCxt2rZY/gRl
         9FxA==
X-Gm-Message-State: AOPr4FWTCMENVAI7oYU+lwtVgbg4Iai12X5+bBIQI8e62HsYQgOq4knWMYhWHwe2vxkbFA==
X-Received: by 10.98.20.150 with SMTP id 144mr10725513pfu.144.1460552169054;
        Wed, 13 Apr 2016 05:56:09 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id u64sm51026488pfa.86.2016.04.13.05.56.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 05:56:07 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 19:56:14 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291404>

This reduces the number of "if (verbose)" which makes it a bit easier
to read imo. It also makes it easier to redirect all these printouts,
to a file for example.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 fetch-pack.c | 88 +++++++++++++++++++++++++++++-----------------------=
--------
 1 file changed, 42 insertions(+), 46 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 01e34b6..4020744 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -50,6 +50,21 @@ static int non_common_revs, multi_ack, use_sideband;
 #define ALLOW_REACHABLE_SHA1	02
 static unsigned int allow_unadvertised_object_request;
=20
+__attribute__((format (printf, 2, 3)))
+static inline void print_verbose(const struct fetch_pack_args *args,
+				 const char *fmt, ...)
+{
+	va_list params;
+
+	if (!args->verbose)
+		return;
+
+	va_start(params, fmt);
+	vfprintf(stderr, fmt, params);
+	va_end(params);
+	fputc('\n', stderr);
+}
+
 static void rev_list_push(struct commit *commit, int mark)
 {
 	if (!(commit->object.flags & mark)) {
@@ -375,8 +390,7 @@ static int find_common(struct fetch_pack_args *args=
,
 	retval =3D -1;
 	while ((sha1 =3D get_rev())) {
 		packet_buf_write(&req_buf, "have %s\n", sha1_to_hex(sha1));
-		if (args->verbose)
-			fprintf(stderr, "have %s\n", sha1_to_hex(sha1));
+		print_verbose(args, "have %s", sha1_to_hex(sha1));
 		in_vain++;
 		if (flush_at <=3D ++count) {
 			int ack;
@@ -397,9 +411,9 @@ static int find_common(struct fetch_pack_args *args=
,
 			consume_shallow_list(args, fd[0]);
 			do {
 				ack =3D get_ack(fd[0], result_sha1);
-				if (args->verbose && ack)
-					fprintf(stderr, "got ack %d %s\n", ack,
-							sha1_to_hex(result_sha1));
+				if (ack)
+					print_verbose(args, "got ack %d %s", ack,
+						      sha1_to_hex(result_sha1));
 				switch (ack) {
 				case ACK:
 					flushes =3D 0;
@@ -438,8 +452,7 @@ static int find_common(struct fetch_pack_args *args=
,
 			} while (ack);
 			flushes--;
 			if (got_continue && MAX_IN_VAIN < in_vain) {
-				if (args->verbose)
-					fprintf(stderr, "giving up\n");
+				print_verbose(args, "giving up");
 				break; /* give up */
 			}
 		}
@@ -449,8 +462,7 @@ done:
 		packet_buf_write(&req_buf, "done\n");
 		send_request(args, fd[1], &req_buf);
 	}
-	if (args->verbose)
-		fprintf(stderr, "done\n");
+	print_verbose(args, "done");
 	if (retval !=3D 0) {
 		multi_ack =3D 0;
 		flushes++;
@@ -462,9 +474,8 @@ done:
 	while (flushes || multi_ack) {
 		int ack =3D get_ack(fd[0], result_sha1);
 		if (ack) {
-			if (args->verbose)
-				fprintf(stderr, "got ack (%d) %s\n", ack,
-					sha1_to_hex(result_sha1));
+			print_verbose(args, "got ack (%d) %s", ack,
+				      sha1_to_hex(result_sha1));
 			if (ack =3D=3D ACK)
 				return 0;
 			multi_ack =3D 1;
@@ -509,9 +520,8 @@ static void mark_recent_complete_commits(struct fet=
ch_pack_args *args,
 					 unsigned long cutoff)
 {
 	while (complete && cutoff <=3D complete->item->date) {
-		if (args->verbose)
-			fprintf(stderr, "Marking %s as complete\n",
-				oid_to_hex(&complete->item->object.oid));
+		print_verbose(args, "Marking %s as complete",
+			      oid_to_hex(&complete->item->object.oid));
 		pop_most_recent_commit(&complete, COMPLETE);
 	}
 }
@@ -652,18 +662,12 @@ static int everything_local(struct fetch_pack_arg=
s *args,
 		o =3D lookup_object(remote);
 		if (!o || !(o->flags & COMPLETE)) {
 			retval =3D 0;
-			if (!args->verbose)
-				continue;
-			fprintf(stderr,
-				"want %s (%s)\n", sha1_to_hex(remote),
-				ref->name);
+			print_verbose(args, "want %s (%s)", sha1_to_hex(remote),
+				      ref->name);
 			continue;
 		}
-		if (!args->verbose)
-			continue;
-		fprintf(stderr,
-			"already have %s (%s)\n", sha1_to_hex(remote),
-			ref->name);
+		print_verbose(args, "already have %s (%s)", sha1_to_hex(remote),
+			      ref->name);
 	}
 	return retval;
 }
@@ -810,39 +814,32 @@ static struct ref *do_fetch_pack(struct fetch_pac=
k_args *args,
 	if ((args->depth > 0 || is_repository_shallow()) && !server_supports(=
"shallow"))
 		die("Server does not support shallow clients");
 	if (server_supports("multi_ack_detailed")) {
-		if (args->verbose)
-			fprintf(stderr, "Server supports multi_ack_detailed\n");
+		print_verbose(args, "Server supports multi_ack_detailed");
 		multi_ack =3D 2;
 		if (server_supports("no-done")) {
-			if (args->verbose)
-				fprintf(stderr, "Server supports no-done\n");
+			print_verbose(args, "Server supports no-done");
 			if (args->stateless_rpc)
 				no_done =3D 1;
 		}
 	}
 	else if (server_supports("multi_ack")) {
-		if (args->verbose)
-			fprintf(stderr, "Server supports multi_ack\n");
+		print_verbose(args, "Server supports multi_ack");
 		multi_ack =3D 1;
 	}
 	if (server_supports("side-band-64k")) {
-		if (args->verbose)
-			fprintf(stderr, "Server supports side-band-64k\n");
+		print_verbose(args, "Server supports side-band-64k");
 		use_sideband =3D 2;
 	}
 	else if (server_supports("side-band")) {
-		if (args->verbose)
-			fprintf(stderr, "Server supports side-band\n");
+		print_verbose(args, "Server supports side-band");
 		use_sideband =3D 1;
 	}
 	if (server_supports("allow-tip-sha1-in-want")) {
-		if (args->verbose)
-			fprintf(stderr, "Server supports allow-tip-sha1-in-want\n");
+		print_verbose(args, "Server supports allow-tip-sha1-in-want");
 		allow_unadvertised_object_request |=3D ALLOW_TIP_SHA1;
 	}
 	if (server_supports("allow-reachable-sha1-in-want")) {
-		if (args->verbose)
-			fprintf(stderr, "Server supports allow-reachable-sha1-in-want\n");
+		print_verbose(args, "Server supports allow-reachable-sha1-in-want");
 		allow_unadvertised_object_request |=3D ALLOW_REACHABLE_SHA1;
 	}
 	if (!server_supports("thin-pack"))
@@ -851,17 +848,16 @@ static struct ref *do_fetch_pack(struct fetch_pac=
k_args *args,
 		args->no_progress =3D 0;
 	if (!server_supports("include-tag"))
 		args->include_tag =3D 0;
-	if (server_supports("ofs-delta")) {
-		if (args->verbose)
-			fprintf(stderr, "Server supports ofs-delta\n");
-	} else
+	if (server_supports("ofs-delta"))
+		print_verbose(args, "Server supports ofs-delta");
+	else
 		prefer_ofs_delta =3D 0;
=20
 	if ((agent_feature =3D server_feature_value("agent", &agent_len))) {
 		agent_supported =3D 1;
-		if (args->verbose && agent_len)
-			fprintf(stderr, "Server version is %.*s\n",
-				agent_len, agent_feature);
+		if (agent_len)
+			print_verbose(args, "Server version is %.*s",
+				      agent_len, agent_feature);
 	}
=20
 	if (everything_local(args, &ref, sought, nr_sought)) {
--=20
2.8.0.rc0.210.gd302cd2

From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 29/32] Add command fetch-narrow-base
Date: Wed, 25 Aug 2010 08:20:19 +1000
Message-ID: <1282688422-7738-30-git-send-email-pclouds@gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 00:25:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo1ve-0004Dg-Fl
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756140Ab0HXWYP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 18:24:15 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49107 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755545Ab0HXWYN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 18:24:13 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so2814108pvg.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=aHXswGTpvXWI7d3DRnR06CCVgPJOQB5VmtDLEiy6rgY=;
        b=vtZe9iEzjIL791HNOxDEjTfdsKHAfZGchXeInm6+z1jxmuO6LVSe+ZrHmRhOuhzE9C
         7LqVJRqvftcm31oIGnV73jsnpwWArboZxWbIsQENSRHHspZQb39Hwcu8zU3IXhw3tSi8
         p6MAFo8wJIyjvkjdFA2lxOxYS7u7t5DlFfGVg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Lc0J3nU75xw8bJq8wH+qBgLl0VqsKObqWx4LlUn4JvtULwzFTzvfmZcolpv0Ls4IEc
         C9qhJkDktRiXVKWXmX/fpgis8ffT3jaMJW28WNZj4IxN40UuZPzWDntqArKabaRzyTn+
         eJMrEl+sIMdVMA0aHQiPYPXJZYDcNtSWj7Ns0=
Received: by 10.114.113.9 with SMTP id l9mr8481283wac.109.1282688652950;
        Tue, 24 Aug 2010 15:24:12 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id s5sm948149wak.12.2010.08.24.15.24.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 15:24:10 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 25 Aug 2010 08:24:05 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154372>

This is the client side of upload-narrow-base. It sends two commits, a
narrow prefix, receives a pack and unpacks it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile                    |    1 +
 builtin.h                   |    1 +
 builtin/fetch-narrow-base.c |   89 +++++++++++++++++++++++++++++++++++=
++++++++
 git.c                       |    1 +
 narrow-tree.h               |    4 ++
 5 files changed, 96 insertions(+), 0 deletions(-)
 create mode 100644 builtin/fetch-narrow-base.c

diff --git a/Makefile b/Makefile
index 7b33a0e..a10eb00 100644
--- a/Makefile
+++ b/Makefile
@@ -676,6 +676,7 @@ BUILTIN_OBJS +=3D builtin/diff-index.o
 BUILTIN_OBJS +=3D builtin/diff-tree.o
 BUILTIN_OBJS +=3D builtin/diff.o
 BUILTIN_OBJS +=3D builtin/fast-export.o
+BUILTIN_OBJS +=3D builtin/fetch-narrow-base.o
 BUILTIN_OBJS +=3D builtin/fetch-pack.o
 BUILTIN_OBJS +=3D builtin/fetch.o
 BUILTIN_OBJS +=3D builtin/fmt-merge-msg.o
diff --git a/builtin.h b/builtin.h
index 0383328..9eefa0f 100644
--- a/builtin.h
+++ b/builtin.h
@@ -66,6 +66,7 @@ extern int cmd_diff(int argc, const char **argv, cons=
t char *prefix);
 extern int cmd_diff_tree(int argc, const char **argv, const char *pref=
ix);
 extern int cmd_fast_export(int argc, const char **argv, const char *pr=
efix);
 extern int cmd_fetch(int argc, const char **argv, const char *prefix);
+extern int cmd_fetch_narrow_base(int argc, const char **argv, const ch=
ar *prefix);
 extern int cmd_fetch_pack(int argc, const char **argv, const char *pre=
fix);
 extern int cmd_fmt_merge_msg(int argc, const char **argv, const char *=
prefix);
 extern int cmd_for_each_ref(int argc, const char **argv, const char *p=
refix);
diff --git a/builtin/fetch-narrow-base.c b/builtin/fetch-narrow-base.c
new file mode 100644
index 0000000..0162ad0
--- /dev/null
+++ b/builtin/fetch-narrow-base.c
@@ -0,0 +1,89 @@
+#include "cache.h"
+#include "builtin.h"
+#include "commit.h"
+#include "pkt-line.h"
+#include "transport.h"
+#include "sideband.h"
+#include "run-command.h"
+#include "parse-options.h"
+
+int fetch_narrow_base(const unsigned char *c1,
+		      const unsigned char *c2,
+		      unsigned char *newsha1,
+		      const char *narrow_prefix,
+		      const char *remote,
+		      const char *exec)
+{
+	char buf[LARGE_PACKET_MAX];
+	int fd[2], len;
+	struct transport *transport;
+	struct remote *_remote;
+	const char *argv[] =3D { "unpack-objects", "-q", NULL };
+	struct child_process cmd;
+
+	_remote =3D remote_get(remote);
+	if (!_remote->url[0])
+		die("narrow-base: Remote with no URL");
+	transport =3D transport_get(_remote, _remote->url[0]);
+	if (!exec)
+		exec =3D "git-upload-narrow-base";
+	transport_connect(transport, "git-upload-narrow-base", exec, fd);
+
+	packet_write(fd[1], "narrow-tree %s\n", narrow_prefix);
+	packet_write(fd[1], "parent %s\n", sha1_to_hex(c1));
+	packet_write(fd[1], "parent %s\n", sha1_to_hex(c2));
+	packet_flush(fd[1]);
+
+	len =3D packet_read_line(fd[0], buf, sizeof(buf));
+	if (!len)
+		die("narrow-base: expected ACK/NAK, got EOF");
+	if (buf[len-1] =3D=3D '\n')
+		buf[--len] =3D 0;
+	if (prefixcmp(buf, "ACK "))
+		die("narrow-base: protocol error");
+
+	get_sha1_hex(buf+4, newsha1);
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.argv =3D argv;
+	cmd.in =3D fd[0];
+	cmd.git_cmd =3D 1;
+
+	if (run_command(&cmd))
+		die("unable to run %s", argv[0]);
+
+	return transport_disconnect(transport);
+}
+
+int cmd_fetch_narrow_base(int argc, const char **argv, const char *pre=
fix)
+{
+	unsigned char c1[20], c2[20], sha1[20];
+	const char *remote;
+	const char *exec;
+	const char *narrow_prefix =3D get_narrow_prefix();
+	struct option options[] =3D {
+		OPT_STRING(0, "remote", &remote, "remote", "remote host"),
+		OPT_STRING(0, "upload-narrow-base", &exec, "path", "path to upload-n=
arrow-base"),
+		OPT_STRING(0, "narrow-tree", &narrow_prefix, "narrow prefix", "narro=
w prefix"),
+		OPT_END()
+	};
+	const char *usage[] =3D { "git narrow-base [options] parent1 parent2"=
, NULL };
+
+	argc =3D parse_options(argc, argv, prefix, options, usage, 0);
+
+	if (argc !=3D 2)
+		die("Insufficient arguments");
+
+	if (get_sha1(argv[0], c1) ||
+	    get_sha1(argv[1], c2) ||
+	    !lookup_commit_reference(c1) ||
+	    !lookup_commit_reference(c2))
+		return 1;
+
+	if (!fetch_narrow_base(c1, c2, sha1, narrow_prefix, remote, exec)) {
+		printf("%s\n", sha1_to_hex(sha1));
+		return 0;
+	}
+
+	return 1;
+}
diff --git a/git.c b/git.c
index edb379f..f4370b1 100644
--- a/git.c
+++ b/git.c
@@ -322,6 +322,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "diff-tree", cmd_diff_tree, RUN_SETUP },
 		{ "fast-export", cmd_fast_export, RUN_SETUP },
 		{ "fetch", cmd_fetch, RUN_SETUP },
+		{ "fetch-narrow-base", cmd_fetch_narrow_base, RUN_SETUP },
 		{ "fetch-pack", cmd_fetch_pack, RUN_SETUP },
 		{ "fmt-merge-msg", cmd_fmt_merge_msg, RUN_SETUP },
 		{ "for-each-ref", cmd_for_each_ref, RUN_SETUP },
diff --git a/narrow-tree.h b/narrow-tree.h
index 78d6f39..614d677 100644
--- a/narrow-tree.h
+++ b/narrow-tree.h
@@ -3,3 +3,7 @@ extern int join_narrow_tree(const unsigned char *base, =
unsigned char *newsha1,
 			    const unsigned char *subtree_sha1, const char *prefix);
 int same_narrow_base(const unsigned char *t1, const unsigned char *t2,=
 const char *prefix);
 int oldest_narrow_base(const unsigned char *sha1, unsigned char *newsh=
a1);
+int fetch_narrow_base(const unsigned char *c1, const unsigned char *c2=
,
+		      unsigned char *newsha1,
+		      const char *narrow_prefix,
+		      const char *remote, const char *exec);
--=20
1.7.1.rc1.69.g24c2f7

From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH/RFC 11/11] mingw: compile git-daemon
Date: Thu, 26 Nov 2009 00:39:18 +0000
Message-ID: <1259195958-2372-12-git-send-email-kusmabite@gmail.com>
References: <1259195958-2372-1-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-2-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-3-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-4-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-5-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-6-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-7-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-8-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-9-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-10-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-11-git-send-email-kusmabite@gmail.com>
Cc: git@vger.kernel.org, dotzenlabs@gmail.com,
	Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlecode.com
X-From: git-owner@vger.kernel.org Thu Nov 26 01:40:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDSPN-00086w-Ag
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 01:40:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbZKZAkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 19:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbZKZAkO
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 19:40:14 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:41835 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965043AbZKZAkL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 19:40:11 -0500
Received: by mail-ew0-f219.google.com with SMTP id 19so295613ewy.21
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 16:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=l0EDOT/fXsIo/3bf4cYpZuCIuEYTtBTQ/e89TlGmzxE=;
        b=mBImBsxigSRSa/laPY1NQdFuroB+59ULMeMDHSH2DOXRA7ofH8A7n8MRVsBXcaEIxc
         IQrmWOblQMv+05ahXmhczDAMp0zyzXKQ780/zwXh2WlFuNDapJy/N/ZNq0eQ8IiNHiXN
         Yj8IkbXA9FMaPBAjcu2OWa03KOSxR9REEHSTI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UPToZrpRSccupDb2xt+GwLiha8T+nXJjlpSlaccAkIpP+HVvpQWJDaObPA2bN1G/bW
         Pni6AWGvOLoTLP8l/p1/NsI4H7TB9w4KzWXb+OwI1MSXIat9zKhHu57+GStdBVkhMtWl
         NSdYx/CeFBKV0+6CCvT542g5xTkHvmlbIWwBA=
Received: by 10.216.86.137 with SMTP id w9mr819816wee.104.1259196017095;
        Wed, 25 Nov 2009 16:40:17 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 5sm3857034eyf.0.2009.11.25.16.40.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 16:40:16 -0800 (PST)
X-Mailer: git-send-email 1.6.4
In-Reply-To: <1259195958-2372-11-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133729>

--user and --detach are disabled on Windows due to lack of
fork(), setuid(), setgid(), setsid() and initgroups().

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 Makefile       |    6 +++---
 compat/mingw.h |    1 +
 daemon.c       |   19 ++++++++++++++-----
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 3b01694..406ca81 100644
--- a/Makefile
+++ b/Makefile
@@ -352,6 +352,7 @@ EXTRA_PROGRAMS =
 
 # ... and all the rest that could be moved out of bindir to gitexecdir
 PROGRAMS += $(EXTRA_PROGRAMS)
+PROGRAMS += git-daemon$X
 PROGRAMS += git-fast-import$X
 PROGRAMS += git-hash-object$X
 PROGRAMS += git-imap-send$X
@@ -981,6 +982,8 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
 	NO_REGEX = YesPlease
 	BLK_SHA1 = YesPlease
+	NO_INET_PTON = YesPlease
+	NO_INET_NTOP = YesPlease
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/fnmatch
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	# We have GCC, so let's make use of those nice options
@@ -1079,9 +1082,6 @@ ifdef ZLIB_PATH
 endif
 EXTLIBS += -lz
 
-ifndef NO_POSIX_ONLY_PROGRAMS
-	PROGRAMS += git-daemon$X
-endif
 ifndef NO_OPENSSL
 	OPENSSL_LIBSSL = -lssl
 	ifdef OPENSSLDIR
diff --git a/compat/mingw.h b/compat/mingw.h
index 576b1a1..1b0dd5b 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -6,6 +6,7 @@
 
 typedef int pid_t;
 typedef int socklen_t;
+typedef unsigned int gid_t;
 #define hstrerror strerror
 
 #define S_IFLNK    0120000 /* Symbolic link */
diff --git a/daemon.c b/daemon.c
index 130e951..5872ec7 100644
--- a/daemon.c
+++ b/daemon.c
@@ -616,7 +616,7 @@ static struct child {
 	struct sockaddr_storage address;
 } *firstborn;
 
-static void add_child(struct async *async, struct sockaddr *addr, int addrlen)
+static void add_child(struct async *async, struct sockaddr *addr, socklen_t addrlen)
 {
 	struct child *newborn, **cradle;
 
@@ -679,7 +679,7 @@ int async_execute(int fd, void *data)
 	return ret;
 }
 
-static void handle(int incoming, struct sockaddr *addr, int addrlen)
+static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 {
 	struct sockaddr_storage *ss;
 	struct async async = { 0 };
@@ -884,7 +884,7 @@ static int service_loop(int socknum, int *socklist)
 		for (i = 0; i < socknum; i++) {
 			if (pfd[i].revents & POLLIN) {
 				struct sockaddr_storage ss;
-				unsigned int sslen = sizeof(ss);
+				socklen_t sslen = sizeof(ss);
 				int incoming = accept(pfd[i].fd, (struct sockaddr *)&ss, &sslen);
 				if (incoming < 0) {
 					switch (errno) {
@@ -916,6 +916,7 @@ static void sanitize_stdfds(void)
 
 static void daemonize(void)
 {
+#ifndef WIN32
 	switch (fork()) {
 		case 0:
 			break;
@@ -930,6 +931,9 @@ static void daemonize(void)
 	close(1);
 	close(2);
 	sanitize_stdfds();
+#else
+	die("--detach is not supported on Windows");
+#endif
 }
 
 static void store_pid(const char *path)
@@ -950,10 +954,12 @@ static int serve(char *listen_addr, int listen_port, struct passwd *pass, gid_t
 		die("unable to allocate any listen sockets on host %s port %u",
 		    listen_addr, listen_port);
 
+#ifndef WIN32
 	if (pass && gid &&
 	    (initgroups(pass->pw_name, gid) || setgid (gid) ||
 	     setuid(pass->pw_uid)))
 		die("cannot drop privileges");
+#endif
 
 	return service_loop(socknum, socklist);
 }
@@ -966,7 +972,6 @@ int main(int argc, char **argv)
 	const char *pid_file = NULL, *user_name = NULL, *group_name = NULL;
 	int detach = 0;
 	struct passwd *pass = NULL;
-	struct group *group;
 	gid_t gid = 0;
 	int i;
 
@@ -1110,6 +1115,7 @@ int main(int argc, char **argv)
 		die("--group supplied without --user");
 
 	if (user_name) {
+#ifndef WIN32
 		pass = getpwnam(user_name);
 		if (!pass)
 			die("user not found - %s", user_name);
@@ -1117,12 +1123,15 @@ int main(int argc, char **argv)
 		if (!group_name)
 			gid = pass->pw_gid;
 		else {
-			group = getgrnam(group_name);
+			struct group *group = getgrnam(group_name);
 			if (!group)
 				die("group not found - %s", group_name);
 
 			gid = group->gr_gid;
 		}
+#else
+		die("--user is not supported on Windows");
+#endif
 	}
 
 	if (strict_paths && (!ok_paths || !*ok_paths))
-- 
1.6.5.rc2.7.g4f8d3

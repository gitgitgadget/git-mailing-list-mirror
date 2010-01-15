From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v2 01/14] mingw: add network-wrappers for daemon
Date: Fri, 15 Jan 2010 22:30:20 +0100
Message-ID: <1263591033-4992-2-git-send-email-kusmabite@gmail.com>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Cc: git@vger.kernel.org,
	j6t@kdbg.org,
	Mike Pape <dotzenlabs@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: 3k95QSwkOBw4y860opw7su22uzs0owz.q2006C6uw7u22uzsu52836.q20@listserv.bounces.google.com Fri Jan 15 22:31:19 2010
Return-path: <3k95QSwkOBw4y860opw7su22uzs0owz.q2006C6uw7u22uzsu52836.q20@listserv.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f161.google.com ([209.85.211.161])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVtlF-0005YL-6n
	for gcvm-msysgit@m.gmane.org; Fri, 15 Jan 2010 22:31:17 +0100
Received: by ywh33 with SMTP id 33sf2129132ywh.24
        for <gcvm-msysgit@m.gmane.org>; Fri, 15 Jan 2010 13:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:received
         :from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe;
        bh=hNLTGYf08FzPiBAA1hRWK1yOEFxJ4spVRIBbSTTxMAg=;
        b=nbznG4YmwtZgA8GoXMaZrAYg6xmyfr7r13+mDFfMftBaU+AxBRWtXYmx9+4+2z+F6t
         PbudfR3RJ9/VzZK83DR2g9bNg4YNMpgnxNukFstMn8DLFVClqJ3ouzfJ8nuabmCQoKRt
         BIsocpYOHZM35I+mz1on6XSgMuU/yMJu3oNUA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe;
        b=O843s4SsLtRGvhbbq9/zg0moHtri6k1/g3KDkgPN0+q+Ooo7O64sFhRIERepaEmBUZ
         mJ1UC/xBp9rwSEPwRS1ppluhAxg7gxInCvQJzRb5kdlSHcREVbIOs8DsKiQe3kudjbd+
         0oVHrN1dCLQUUQfUsC0w16vKmdHHKJclWhJ6w=
Received: by 10.101.188.3 with SMTP id q3mr221220anp.35.1263591059757;
        Fri, 15 Jan 2010 13:30:59 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.213.62.209 with SMTP id y17ls58872ebh.1.p; Fri, 15 Jan 2010 
	13:30:58 -0800 (PST)
Received: by 10.213.24.25 with SMTP id t25mr451793ebb.19.1263591057740;
        Fri, 15 Jan 2010 13:30:57 -0800 (PST)
Received: by 10.213.24.25 with SMTP id t25mr451792ebb.19.1263591057716;
        Fri, 15 Jan 2010 13:30:57 -0800 (PST)
Received: from mail-ew0-f217.google.com (mail-ew0-f217.google.com [209.85.219.217])
        by gmr-mx.google.com with ESMTP id 11si168815ewy.5.2010.01.15.13.30.56;
        Fri, 15 Jan 2010 13:30:56 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.217 as permitted sender) client-ip=209.85.219.217;
Received: by ewy9 with SMTP id 9so1379054ewy.31
        for <msysgit@googlegroups.com>; Fri, 15 Jan 2010 13:30:56 -0800 (PST)
Received: by 10.213.41.145 with SMTP id o17mr2961759ebe.38.1263591056443;
        Fri, 15 Jan 2010 13:30:56 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 14sm692629ewy.7.2010.01.15.13.30.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Jan 2010 13:30:55 -0800 (PST)
X-Mailer: git-send-email 1.6.6.95.g5f22c
In-Reply-To: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of kusmabite@googlemail.com designates 209.85.219.217 as permitted 
	sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) 
	header.i=@googlemail.com
X-Original-Sender: kusmabite@googlemail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=>
X-Thread-Url: http://groups.google.com/group/msysgit/t/43ea563cecdc45de
X-Message-Url: http://groups.google.com/group/msysgit/msg/2daf827738457fa7
Sender: msysgit@googlegroups.com
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+subscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137120>

From: Mike Pape <dotzenlabs@gmail.com>

git-daemon requires some socket-functionality that is not yet
supported in the Windows-port. This patch adds said functionality,
and makes sure WSAStartup gets called by socket(), since it is the
first network-call in git-daemon. In addition, a check is added to
prevent WSAStartup (and WSACleanup, though atexit) from being
called more than once, since git-daemon calls both socket() and
gethostbyname().

Signed-off-by: Mike Pape <dotzenlabs@gmail.com>
Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.c |   43 ++++++++++++++++++++++++++++++++++++++++++-
 compat/mingw.h |   16 ++++++++++++++++
 2 files changed, 58 insertions(+), 1 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 0d73f15..42ef9e2 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1095,7 +1095,10 @@ int mingw_getnameinfo(const struct sockaddr *sa, socklen_t salen,
 int mingw_socket(int domain, int type, int protocol)
 {
 	int sockfd;
-	SOCKET s = WSASocket(domain, type, protocol, NULL, 0, 0);
+	SOCKET s;
+
+	ensure_socket_initialization();
+	s = WSASocket(domain, type, protocol, NULL, 0, 0);
 	if (s == INVALID_SOCKET) {
 		/*
 		 * WSAGetLastError() values are regular BSD error codes
@@ -1125,6 +1128,44 @@ int mingw_connect(int sockfd, struct sockaddr *sa, size_t sz)
 	return connect(s, sa, sz);
 }
 
+#undef bind
+int mingw_bind(int sockfd, struct sockaddr *sa, size_t sz)
+{
+	SOCKET s = (SOCKET)_get_osfhandle(sockfd);
+	return bind(s, sa, sz);
+}
+
+#undef setsockopt
+int mingw_setsockopt(int sockfd, int lvl, int optname, void *optval, int optlen)
+{
+	SOCKET s = (SOCKET)_get_osfhandle(sockfd);
+	return setsockopt(s, lvl, optname, (const char*)optval, optlen);
+}
+
+#undef listen
+int mingw_listen(int sockfd, int backlog)
+{
+	SOCKET s = (SOCKET)_get_osfhandle(sockfd);
+	return listen(s, backlog);
+}
+
+#undef accept
+int mingw_accept(int sockfd1, struct sockaddr *sa, socklen_t *sz)
+{
+	int sockfd2;
+
+	SOCKET s1 = (SOCKET)_get_osfhandle(sockfd1);
+	SOCKET s2 = accept(s1, sa, sz);
+
+	/* convert into a file descriptor */
+	if ((sockfd2 = _open_osfhandle(s2, O_RDWR|O_BINARY)) < 0) {
+		closesocket(s2);
+		return error("unable to make a socket file descriptor: %s",
+			strerror(errno));
+	}
+	return sockfd2;
+}
+
 #undef rename
 int mingw_rename(const char *pold, const char *pnew)
 {
diff --git a/compat/mingw.h b/compat/mingw.h
index b3d299f..07513bb 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -6,6 +6,7 @@
  */
 
 typedef int pid_t;
+typedef int socklen_t;
 #define hstrerror strerror
 
 #define S_IFLNK    0120000 /* Symbolic link */
@@ -34,6 +35,9 @@ typedef int pid_t;
 #define F_SETFD 2
 #define FD_CLOEXEC 0x1
 
+#define EAFNOSUPPORT WSAEAFNOSUPPORT
+#define ECONNABORTED WSAECONNABORTED
+
 struct passwd {
 	char *pw_name;
 	char *pw_gecos;
@@ -197,6 +201,18 @@ int mingw_socket(int domain, int type, int protocol);
 int mingw_connect(int sockfd, struct sockaddr *sa, size_t sz);
 #define connect mingw_connect
 
+int mingw_bind(int sockfd, struct sockaddr *sa, size_t sz);
+#define bind mingw_bind
+
+int mingw_setsockopt(int sockfd, int lvl, int optname, void *optval, int optlen);
+#define setsockopt mingw_setsockopt
+
+int mingw_listen(int sockfd, int backlog);
+#define listen mingw_listen
+
+int mingw_accept(int sockfd, struct sockaddr *sa, socklen_t *sz);
+#define accept mingw_accept
+
 int mingw_rename(const char*, const char*);
 #define rename mingw_rename
 
-- 
1.6.6.211.g26720

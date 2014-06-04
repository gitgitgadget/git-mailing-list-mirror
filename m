From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH] Add a Windows-specific fallback to getenv("HOME");
Date: Wed, 4 Jun 2014 13:47:30 +0200
Organization: <)><
Message-ID: <20140604114730.GB22250@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Braun <thomas.braun@virtuell-zuhause.de>, msysgit@googlegroups.com
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRBVEOXSOAKGQESOK6IEI@googlegroups.com Wed Jun 04 13:47:36 2014
Return-path: <msysgit+bncBCU63DXMWULRBVEOXSOAKGQESOK6IEI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f192.google.com ([74.125.82.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBVEOXSOAKGQESOK6IEI@googlegroups.com>)
	id 1Ws9fI-0000DD-Rx
	for gcvm-msysgit@m.gmane.org; Wed, 04 Jun 2014 13:47:32 +0200
Received: by mail-we0-f192.google.com with SMTP id k48sf691432wev.29
        for <gcvm-msysgit@m.gmane.org>; Wed, 04 Jun 2014 04:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:mime-version:organization
         :user-agent:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition;
        bh=W3htqdyPttdcVbBU8PIkCKlTmGnM7Z84lvUEO0oS+/E=;
        b=anPuImPW9E2S050ziEzkYadpd2ONJiOD2dOQrOveRpJ4Qx4U4Z9y7SzjeoDmFxWT9U
         QYqAyfctgplu9+NgO0r1lfiDHZkGcxExtUlS3riJJMSrhxRdwWdvxrtGOGGXZrrgqILG
         DqOC+gCF6pCMcmgz+mYCWXmyAp/E/LEMVXQ8NCkyClK0K7HICZMTgNRTR9pzBTZhaWGo
         977zHQWGhuDbEw5PaTuE+MO22+gzTGOxZEKndJfWtm5Ap7MqnJiHGtprS+w8jGb6uOdc
         93P6/DtnTYzN0e9+tREaIJiUS0mftTOFNyykru1gBK43EQq1TaAIq/4VF8J/XhGDzUID
         VxnA==
X-Received: by 10.180.97.199 with SMTP id ec7mr8401wib.17.1401882452455;
        Wed, 04 Jun 2014 04:47:32 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.24.102 with SMTP id t6ls251499wif.33.gmail; Wed, 04 Jun
 2014 04:47:31 -0700 (PDT)
X-Received: by 10.180.82.98 with SMTP id h2mr471049wiy.0.1401882451615;
        Wed, 04 Jun 2014 04:47:31 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id se3si1124394wic.3.2014.06.04.04.47.31
        for <msysgit@googlegroups.com>;
        Wed, 04 Jun 2014 04:47:31 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 0CBD81C0076;
	Wed,  4 Jun 2014 13:47:31 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s54BlUfE022287;
	Wed, 4 Jun 2014 13:47:30 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s54BlURU022286;
	Wed, 4 Jun 2014 13:47:30 +0200
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250723>

From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Wed, 2 Jun 2010 00:41:33 +0200

If HOME is not set, use $HOMEDRIVE/$HOMEPATH

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
Hi,
   this patch is present in msysGit for 4 years.
Stepan

 compat/mingw.c    | 18 ++++++++++++++++++
 compat/mingw.h    |  3 +++
 git-compat-util.h |  4 ++++
 path.c            |  4 ++--
 shell.c           |  2 +-
 5 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index a0e13bc..8eb21dc 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1847,3 +1847,21 @@ int mingw_offset_1st_component(const char *path)
 
 	return offset + is_dir_sep(path[offset]);
 }
+
+const char *get_windows_home_directory(void)
+{
+	static const char *home_directory = NULL;
+	struct strbuf buf = STRBUF_INIT;
+
+	if (home_directory)
+		return home_directory;
+
+	home_directory = getenv("HOME");
+	if (home_directory && *home_directory)
+		return home_directory;
+
+	strbuf_addf(&buf, "%s/%s", getenv("HOMEDRIVE"), getenv("HOMEPATH"));
+	home_directory = strbuf_detach(&buf, NULL);
+
+	return home_directory;
+}
diff --git a/compat/mingw.h b/compat/mingw.h
index 3eaf822..a88a7ab 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -386,3 +386,6 @@ static int mingw_main(c,v)
  * Used by Pthread API implementation for Windows
  */
 extern int err_win_to_posix(DWORD winerr);
+
+extern const char *get_windows_home_directory();
+#define get_home_directory() get_windows_home_directory()
diff --git a/git-compat-util.h b/git-compat-util.h
index b6f03b3..409e644 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -740,4 +740,8 @@ struct tm *git_gmtime_r(const time_t *, struct tm *);
 #define gmtime_r git_gmtime_r
 #endif
 
+#ifndef get_home_directory
+#define get_home_directory() getenv("HOME")
+#endif
+
 #endif
diff --git a/path.c b/path.c
index bc804a3..09b362c 100644
--- a/path.c
+++ b/path.c
@@ -133,7 +133,7 @@ char *git_path(const char *fmt, ...)
 void home_config_paths(char **global, char **xdg, char *file)
 {
 	char *xdg_home = getenv("XDG_CONFIG_HOME");
-	char *home = getenv("HOME");
+	const char *home = get_home_directory();
 	char *to_free = NULL;
 
 	if (!home) {
@@ -274,7 +274,7 @@ char *expand_user_path(const char *path)
 		const char *username = path + 1;
 		size_t username_len = first_slash - username;
 		if (username_len == 0) {
-			const char *home = getenv("HOME");
+			const char *home = get_home_directory();
 			if (!home)
 				goto return_null;
 			strbuf_add(&user_path, home, strlen(home));
diff --git a/shell.c b/shell.c
index 5c0d47a..edd8c3a 100644
--- a/shell.c
+++ b/shell.c
@@ -55,7 +55,7 @@ static char *make_cmd(const char *prog)
 
 static void cd_to_homedir(void)
 {
-	const char *home = getenv("HOME");
+	const char *home = get_home_directory();
 	if (!home)
 		die("could not determine user's home directory; HOME is unset");
 	if (chdir(home) == -1)
-- 
1.9.2.msysgit.0.655.g1a42564

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

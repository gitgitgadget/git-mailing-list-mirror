From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH 2/2] config: use chmod() instead of fchmod()
Date: Wed, 16 Jul 2014 00:54:30 +0200
Message-ID: <53C5B126.6020404@gmail.com>
References: <20140712075035.GA12400@ucw.cz>	<1405431797-20899-1-git-send-email-kasal@ucw.cz> <xmqq38e2wkkh.fsf@gitster.dls.corp.google.com> <53C5B0A1.4060502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>, GIT Mailing-list <git@vger.kernel.org>, 
 msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>, Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBCH3XYXLXQDBBJXCS2PAKGQEAQJ4AKY@googlegroups.com Wed Jul 16 00:54:31 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBJXCS2PAKGQEAQJ4AKY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f187.google.com ([74.125.82.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBJXCS2PAKGQEAQJ4AKY@googlegroups.com>)
	id 1X7BcF-0006zx-0W
	for gcvm-msysgit@m.gmane.org; Wed, 16 Jul 2014 00:54:31 +0200
Received: by mail-we0-f187.google.com with SMTP id u57sf9206wes.24
        for <gcvm-msysgit@m.gmane.org>; Tue, 15 Jul 2014 15:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=Q99shSqwaouOmgKwm7QDgVq45jryNk845R/Xmtm5/nM=;
        b=Y4tOHgVv+n3M9aA+XS57/S+u1AODFqvaagaMITMVSk70gx9iHcKShCgBpP/5K6Msk3
         wkeHlZ8wY1BY1Hr3VAOM5ynwX0ccmquq0cuinMeoyxuSrHQWDBreeZ6nGwF90vgh7cnz
         M2Z4d5y47NdREmQMDn5GAfRoj4VMb91RfAuf7C90MFTzYOLsJ+mIYoWJZJegEk4h9HaH
         KlJVchbXhvY4d5e76UfOTYoY2MW9bJh0Cb/JEvi8W3+FS6wasdOIkUov25NWsey0jqk1
         uMV+PaVwuaqcRY3+tSy6uyRixD/bZBOSoeZrDMqKZdSUL1fDJ64v6znVhBeoGo5GbWFx
         b/nQ==
X-Received: by 10.180.36.234 with SMTP id t10mr39352wij.6.1405464870436;
        Tue, 15 Jul 2014 15:54:30 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.96.73 with SMTP id dq9ls485735wib.27.canary; Tue, 15 Jul
 2014 15:54:29 -0700 (PDT)
X-Received: by 10.180.212.18 with SMTP id ng18mr665289wic.3.1405464869760;
        Tue, 15 Jul 2014 15:54:29 -0700 (PDT)
Received: from mail-wg0-x22b.google.com (mail-wg0-x22b.google.com [2a00:1450:400c:c00::22b])
        by gmr-mx.google.com with ESMTPS id mx7si718976wic.1.2014.07.15.15.54.29
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Jul 2014 15:54:29 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::22b as permitted sender) client-ip=2a00:1450:400c:c00::22b;
Received: by mail-wg0-f43.google.com with SMTP id l18so79284wgh.14
        for <msysgit@googlegroups.com>; Tue, 15 Jul 2014 15:54:29 -0700 (PDT)
X-Received: by 10.194.60.110 with SMTP id g14mr16227717wjr.101.1405464869698;
        Tue, 15 Jul 2014 15:54:29 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id o12sm48938846wiw.5.2014.07.15.15.54.28
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Jul 2014 15:54:29 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53C5B0A1.4060502@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::22b
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253615>

There is no fchmod() on native Windows platforms (MinGW and MSVC), and the
equivalent Win32 API (SetFileInformationByHandle) requires Windows Vista.

Use chmod() instead.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 config.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index ba882a1..9767c4b 100644
--- a/config.c
+++ b/config.c
@@ -1636,8 +1636,8 @@ int git_config_set_multivar_in_file(const char *config_filename,
 			MAP_PRIVATE, in_fd, 0);
 		close(in_fd);
 
-		if (fchmod(fd, st.st_mode & 07777) < 0) {
-			error("fchmod on %s failed: %s",
+		if (chmod(lock->filename, st.st_mode & 07777) < 0) {
+			error("chmod on %s failed: %s",
 				lock->filename, strerror(errno));
 			ret = CONFIG_NO_WRITE;
 			goto out_free;
@@ -1815,8 +1815,8 @@ int git_config_rename_section_in_file(const char *config_filename,
 
 	fstat(fileno(config_file), &st);
 
-	if (fchmod(out_fd, st.st_mode & 07777) < 0) {
-		ret = error("fchmod on %s failed: %s",
+	if (chmod(lock->filename, st.st_mode & 07777) < 0) {
+		ret = error("chmod on %s failed: %s",
 				lock->filename, strerror(errno));
 		goto out;
 	}
-- 
2.0.1.779.g26aeac4.dirty

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

From: David Turner <dturner@twopensource.com>
Subject: [PATCH v8 19/19] untracked-cache: config option
Date: Thu,  5 May 2016 17:47:11 -0400
Message-ID: <1462484831-13643-20-git-send-email-dturner@twopensource.com>
References: <1462484831-13643-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Thu May 05 23:48:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayR7z-0008DU-OD
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 23:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757954AbcEEVr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 17:47:57 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:33583 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757474AbcEEVru (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 17:47:50 -0400
Received: by mail-qg0-f42.google.com with SMTP id f92so47409195qgf.0
        for <git@vger.kernel.org>; Thu, 05 May 2016 14:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mQViSQ3OwLitq48P2q2e5TlABLIDIPhIwR3OWkEDiks=;
        b=1oRBj+RXXQ1NtIB7QrkLOjDgBNrr2ApQ5/UAgmSx8kg9X0tJIERw2fBaz9BEmWjwZ7
         M+bViydexDtbdzoEB91GdSsU7SsixrZpNktb1pSrKn5cOXQgr++guEitExMYlF/+/BJ7
         DLgJCO2z9DMTNcDtNx6Ub0tBT2qL6yM9FtqevJak9hWGd3oLz0oAgzwjo9pAxNwcs7Yl
         qLWueQk5McZLRjwxSWSySGzh/c52bPr8TBojaGQzIYW7B9n/Zh7G2Q2gkZvWabtmQQqW
         p2/ODiG8iP/K8+kLFGarVAboibRbqn4pTTzbqg44jU8QcZyNgeWEhAl70iHKiUal1StR
         h+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mQViSQ3OwLitq48P2q2e5TlABLIDIPhIwR3OWkEDiks=;
        b=P/AnpTjtq1VSnJqtKdEWs+LMxaW65j9teAHKlDgAGN3GciUV13QRWPFOwOVgeASeac
         /CPbLvE05vtjVVq75IGZ1vQL4ohW0YuybXB7YH2pcjc5I1Sm5lFWdsjrn4mQq848+dXp
         v1ZEdEoMu7NefyyrzBnCVOPAOxW8K5C8gVjoIE6arVj8AMcq2Yl0O5xWs1zTYWJDRjNR
         X9LKvN01zvrnNvtnO8CmIu0qo5UTSnAyrJ13mvO1jSNH4k7DaaeaoCAxfybDr4up81Kx
         Xl1KopgMAR6Dl8Xb1hU2X4JUtSQLAKurVLrGauUyOTQW538Tz+oMRTPY6w3sg6hRE9k1
         52Qg==
X-Gm-Message-State: AOPr4FVQU8+P8PQaLoj8ALyV0751FguwWLFk9403aGIZ1gETGuulvFVmUpxVhBQw8nKofw==
X-Received: by 10.140.133.5 with SMTP id 5mr5409512qhf.19.1462484869334;
        Thu, 05 May 2016 14:47:49 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g186sm4393740qke.49.2016.05.05.14.47.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 May 2016 14:47:48 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1462484831-13643-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293696>

Add a config option to populate the untracked cache.

For installations that have centrally-managed configuration, it's
easier to set a config once than to run update-index on every
repository.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/config.txt | 4 ++++
 read-cache.c             | 7 ++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 385ea66..c7b76ef 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1848,6 +1848,10 @@ imap::
 	The configuration variables in the 'imap' section are described
 	in linkgit:git-imap-send[1].
 
+index.adduntrackedcache::
+	Automatically populate the untracked cache whenever the index
+	is written.
+
 index.addwatchmanextension::
 	Automatically add the watchman extension to the index whenever
 	it is written.
diff --git a/read-cache.c b/read-cache.c
index a32bd54..ee1d4c0 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2471,7 +2471,7 @@ static int do_write_index(struct index_state *istate, int newfd,
 	int entries = istate->cache_nr;
 	struct stat st;
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
-	int watchman = 0;
+	int watchman = 0, untracked = 0;
 	uint64_t start = getnanotime();
 
 	for (i = removed = extended = 0; i < entries; i++) {
@@ -2501,6 +2501,11 @@ static int do_write_index(struct index_state *istate, int newfd,
 	    !the_index.last_update)
 		the_index.last_update = xstrdup("");
 
+	if (!git_config_get_bool("index.adduntrackedcache", &untracked) &&
+	    untracked &&
+	    !istate->untracked)
+	    add_untracked_cache(&the_index);
+
 	hdr_version = istate->version;
 
 	hdr.hdr_signature = htonl(CACHE_SIGNATURE);
-- 
2.4.2.767.g62658d5-twtrsrc

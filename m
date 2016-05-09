From: David Turner <dturner@twopensource.com>
Subject: [PATCH v9 19/19] untracked-cache: config option
Date: Mon,  9 May 2016 16:48:49 -0400
Message-ID: <1462826929-7567-20-git-send-email-dturner@twopensource.com>
References: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Mon May 09 22:50:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azs7k-0004LM-3M
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 22:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569AbcEIUtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 16:49:32 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:36311 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823AbcEIUta (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 16:49:30 -0400
Received: by mail-qg0-f49.google.com with SMTP id w36so95745915qge.3
        for <git@vger.kernel.org>; Mon, 09 May 2016 13:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LSoRgGvykdSGIWioF7FLiE03BC7y3bSbQigZbM2mOdk=;
        b=CUASyCJldONictweng8htEs3plTpy/F5fUGCinLwyqCnhLIckOkkQsbNRT6OFKolSk
         MedFXp6IL+Pi9WutoAEpu0PxvvnIz4aiHwLxyMoy7KI7LajK4yPCw7XTdyQRd5N0G+xB
         rucIZz0bx28Xhk9/Fd2ebO4LLLWQ6niSSl5PqX+Al5DqayiO6etcoocmSOOps3we/DaJ
         gy0BaDOnI+CfLmAkiN2lPi5aZDgE11kLyG7rRqNPvcRtUFhc6k98LOrzZ/2dI5JHMkxq
         pB3Yctbwd+ZGFzizbiRs/tKC+oO9fhF9svjVhFXdIG5N5sdmu7YtFzdFz/9irPiVVQ0+
         TmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LSoRgGvykdSGIWioF7FLiE03BC7y3bSbQigZbM2mOdk=;
        b=dfZ7iZGjTjdrJzh/4Ccj0jc6VI2GrEXDsx/A4qL4sQFa3wb22Awt3Tuy+9hpLf+4KY
         vH2Lybk4PKFKUxnHtzg1X57+sqEjngG+T+6PWthL4R5TJZsx8AOpPiT+t67ZXDPsDP2P
         2kfTbZUpjosgrbu2DfagZF4VKJZi/N138JZKex+EOKhGEe8LQb6FvzEvkOFG9xLaE3HC
         /MmKSt6JhuOYBI0nPJaWbQQnOI703RI189Dou/JLDIzR8S0bvJIf7JxOVzoQPuvCGesB
         Dpcu2oy+vEqeKn1yv4JwO+NormD0SFgj67vfvMQKENuZLsgauSTQAMyO8QSWbVVznr1Y
         OHXA==
X-Gm-Message-State: AOPr4FXUu3x+lHuFvohMV8kz+nAMctFA+9wtqg+yTDuBcipcakwVlsOO3lY396lV5IUEpA==
X-Received: by 10.140.92.39 with SMTP id a36mr38058809qge.39.1462826969250;
        Mon, 09 May 2016 13:49:29 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id n1sm12729182qkn.3.2016.05.09.13.49.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 May 2016 13:49:28 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294055>

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
index c547b0b..7e735e2 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2470,7 +2470,7 @@ static int do_write_index(struct index_state *istate, int newfd,
 	int entries = istate->cache_nr;
 	struct stat st;
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
-	int watchman = 0;
+	int watchman = 0, untracked = 0;
 	uint64_t start = getnanotime();
 
 	for (i = removed = extended = 0; i < entries; i++) {
@@ -2500,6 +2500,11 @@ static int do_write_index(struct index_state *istate, int newfd,
 	    !the_index.last_update)
 		the_index.last_update = xstrdup("");
 
+	if (!git_config_get_bool("index.adduntrackedcache", &untracked) &&
+	    untracked &&
+	    !istate->untracked)
+		add_untracked_cache(&the_index);
+
 	hdr_version = istate->version;
 
 	hdr.hdr_signature = htonl(CACHE_SIGNATURE);
-- 
2.4.2.767.g62658d5-twtrsrc

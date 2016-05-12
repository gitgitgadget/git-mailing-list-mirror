From: David Turner <dturner@twopensource.com>
Subject: [PATCH v10 20/20] untracked-cache: config option
Date: Thu, 12 May 2016 16:20:15 -0400
Message-ID: <1463084415-19826-21-git-send-email-dturner@twopensource.com>
References: <1463084415-19826-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu May 12 22:21:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0x6Z-0005AB-Ei
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 22:21:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbcELUVC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 16:21:02 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:35602 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbcELUU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 16:20:57 -0400
Received: by mail-io0-f173.google.com with SMTP id d62so109293043iof.2
        for <git@vger.kernel.org>; Thu, 12 May 2016 13:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V6mK/vwNm+/KGuCdLztm3/8dbCaRb93rmAEKSxuR+48=;
        b=BIEOqojdCep2bjIVPSZZr4IzO73PR1XkvHjJxpkzYp83AsBS/mXLXQGEFeh1e0Zo+f
         beZWXppMW+bHwUOQQEfVmC9zAK9ly8L+YCaRrtFd41AX2cPCm9zQPousDw8H3gTqRH+h
         bAMdX//SLYp40QWI42wCDqzjDE5FP38K9+HgaOCoX8toQJd7ybI/M4Bwv12iy39UdR6L
         gkCIGQf4g3+gJSZQuvgjkMKLzRluKmq+Gb6IrAbfKl6O4ot6yTSUeYKQydS/5Gy75p9J
         Ty7e9jnni17zH5RHgICs/XT3L+6kJZfjMZhF+GwXcwTnbqoE43sk0ZHyxDZImXVkVr+x
         xJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V6mK/vwNm+/KGuCdLztm3/8dbCaRb93rmAEKSxuR+48=;
        b=KvV4rz3ZmYX72GMGgg5A1DKSSW48HFDeoHWdx05NSA/CPvHCq29sf931WhLFRWnCeM
         n9pxjCNm2jJkFtFT1t0ZXv/j8I1dW6Got4kPRaVZh3tqfzoaK2kq7Ac+e2imbXuK7AoN
         /HwSgz5/mx/sK1K7R5NR4+/aJIMhHDY6ky833tw7Eo1mrT2R+SGsaXKIFay8OsxgviU0
         zFbbhqZMdXtYyQc/Ebde+o7Vi6ZHwygY38LYuOYCUEhvuhmItnmzvnp2fjD6UOXNbuSn
         i+zmwhs0JaMCJrU3WSiA/O2csgVY3u0ZQ6jRpLdD/HVIdMEDUESAU4IrN5H8sR6CwOt0
         Lxqg==
X-Gm-Message-State: AOPr4FUDd/uKKxahzvJ/wgM6owC/3ZbVEyBhGGw9M1NJCFgZYlBfkCmcnh4RLD2O0+9MZA==
X-Received: by 10.107.161.140 with SMTP id k134mr9648489ioe.190.1463084456143;
        Thu, 12 May 2016 13:20:56 -0700 (PDT)
Received: from twopensource.com ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id s8sm5055496igg.17.2016.05.12.13.20.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 May 2016 13:20:55 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1463084415-19826-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294462>

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
index 22c64d0..4a1cccf 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2472,7 +2472,7 @@ static int do_write_index(struct index_state *istate, int newfd,
 	int entries = istate->cache_nr;
 	struct stat st;
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
-	int watchman = 0;
+	int watchman = 0, untracked = 0;
 	uint64_t start = getnanotime();
 
 	for (i = removed = extended = 0; i < entries; i++) {
@@ -2502,6 +2502,11 @@ static int do_write_index(struct index_state *istate, int newfd,
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

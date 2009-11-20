From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] submodule.c: Squelch a "use before assignment" warning
Date: Fri, 20 Nov 2009 03:33:53 -0800
Message-ID: <1258716833-49974-1-git-send-email-davvid@gmail.com>
References: <7v8we17ha9.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Nov 20 12:34:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBRkd-0007qm-4T
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 12:34:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768AbZKTLd4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 06:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751869AbZKTLdz
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 06:33:55 -0500
Received: from mail-yw0-f202.google.com ([209.85.211.202]:54753 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266AbZKTLdz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 06:33:55 -0500
Received: by ywh40 with SMTP id 40so2138040ywh.33
        for <git@vger.kernel.org>; Fri, 20 Nov 2009 03:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Cr5szayzOrhVVaOalxqF+HfZ3+/KqG/TLPFaX4uFc1E=;
        b=bUHOmgx2M4tRq5rVA0MX+wzZnMfs39yxhE+P+ZQPTid5cDHmtrJSnhvzCzyVoVQejQ
         i2EoQ63Op7gWu0+t5ZbzxEjbB+LMAn1ytDOfEIZGXSIYpELHGG8aM/M2hQFpvLU/ybBc
         yt4Du/Wzx/pq+O8Sh1jxxsjM8VRg8Ue5Rs8mU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=APHroo9sN3jMD9cqJv5qu4Hd9aKa9jdR2LpFqtVaDktSGkbQTSUCFq6sgyAdD6nLEL
         BV6cGa2okYiggVobJWvkQlDHS9AH1ZXs5tohBNjXcFkC2F8fjqO1j3m3/zFu2hYX1B3K
         cUzmuI6RXhUbiRI+E3Qi+on3Kicp8YdyZSp0Q=
Received: by 10.150.179.12 with SMTP id b12mr2406661ybf.156.1258716839220;
        Fri, 20 Nov 2009 03:33:59 -0800 (PST)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 23sm528194ywh.18.2009.11.20.03.33.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Nov 2009 03:33:58 -0800 (PST)
X-Mailer: git-send-email 1.6.5.3.171.ge36e
In-Reply-To: <7v8we17ha9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133338>

i686-apple-darwin9-gcc-4.0.1 (GCC) 4.0.1 (Apple Inc. build 5493) compiler
(and probably others) mistakenly thinks variable 'right' is used
before assigned.  Work around it by giving it a fake initialization.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 submodule.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/submodule.c b/submodule.c
index 461faf0..86aad65 100644
--- a/submodule.c
+++ b/submodule.c
@@ -38,7 +38,7 @@ void show_submodule_summary(FILE *f, const char *path,
 		const char *del, const char *add, const char *reset)
 {
 	struct rev_info rev;
-	struct commit *commit, *left = left, *right;
+	struct commit *commit, *left = left, *right = right;
 	struct commit_list *merge_bases, *list;
 	const char *message = NULL;
 	struct strbuf sb = STRBUF_INIT;
-- 
1.6.5.3.171.ge36e

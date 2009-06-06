From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 06/23] t5550-http-fetch: test fetching of packed objects
Date: Sat, 6 Jun 2009 16:43:32 +0800
Message-ID: <20090606164332.6c11b93b.rctay89@gmail.com>
References: <cover.1244277116.git.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 06 10:49:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCraY-0003mT-97
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 10:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754032AbZFFItK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 04:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753503AbZFFItI
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 04:49:08 -0400
Received: from mail-pz0-f171.google.com ([209.85.222.171]:57058 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754032AbZFFItG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 04:49:06 -0400
Received: by mail-pz0-f171.google.com with SMTP id 1so1305125pzk.33
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 01:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=h+xQ7yjK8rqqXOQDqfcHISCXZzyqq4ElmczYQxNNqKA=;
        b=SEIrwH46tvz+wWbc0JUoXEgJKdl7nduqv9uFwmabfj9RqBCT4anCXJQgx4bc1JFJE3
         /Ks2b+A8Z1IDNWWUdU46lNUEEiqvNd1ZqFjicsF9wpql6PgqzXSwqCH01JiwBpH4ap4t
         UMbNmZUwyn5qKRuxPVAUesLSmGr3XrgscybeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=o8Z6hDm1yZ3ecafbiy8y9ywy/Kq0dbx3RTLdjaoDN2Oo7cztNdj27+InCS1pU+RTDs
         Nh5V7KOpUzs2vJS2Pz2ryXGpOYEyzspKiKmsMI0OzjZk1CX+I5an1WVo3uWqrfbdJmRS
         jKCzaCpklcZaVYSru5aAhJkRSM7hN4fRvmxFM=
Received: by 10.143.11.11 with SMTP id o11mr1497711wfi.193.1244278148929;
        Sat, 06 Jun 2009 01:49:08 -0700 (PDT)
Received: from your-cukc5e3z5n (cm97.zeta149.maxonline.com.sg [116.87.149.97])
        by mx.google.com with ESMTPS id 28sm2812436wfd.23.2009.06.06.01.49.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Jun 2009 01:49:08 -0700 (PDT)
In-Reply-To: <cover.1244277116.git.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120887>


Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/t5550-http-fetch.sh |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index 05b1b62..0e69324 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -53,5 +53,13 @@ test_expect_success 'http remote detects correct HEAD' '
 	)
 '

+test_expect_success 'fetch packed objects' '
+	cp -R "$HTTPD_DOCUMENT_ROOT_PATH"/repo.git "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git &&
+	cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git &&
+	git --bare repack &&
+	git --bare prune-packed &&
+	git clone $HTTPD_URL/repo_pack.git
+'
+
 stop_httpd
 test_done
--
1.6.3.1

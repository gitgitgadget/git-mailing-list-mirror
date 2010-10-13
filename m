From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 1/3] t5523-push-upstream: add function to ensure fresh upstream repo
Date: Thu, 14 Oct 2010 03:31:49 +0800
Message-ID: <1286998311-5112-2-git-send-email-rctay89@gmail.com>
References: <1286998311-5112-1-git-send-email-rctay89@gmail.com>
Cc: "Jeff King" <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Chase Brammer <cbrammer@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 13 21:32:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P673V-0006D5-JI
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 21:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552Ab0JMTb6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 15:31:58 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47692 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476Ab0JMTb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 15:31:57 -0400
Received: by mail-iw0-f174.google.com with SMTP id 9so165884iwn.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 12:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=I0mmOCATxRVYNI7OClV6uFL3o3xebmzkCneJgPJbjvo=;
        b=NwEv6cIVcib4qwUahb2/p3//z7Vorxb2IW8tUqPx7aYz0XCXO6XAqOfoAxO3CdoGxt
         XQGEc31Lk3WRkUYA7zf9ny2wZQcr5HGiyEww39lTtPrbIo7IkvaUDviM+agbsCo5FBeQ
         8E5KOUvzUYAJe2tGrnnnmW5QqWVM9ZgqchJro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gP2pby83oSB4t/RLXv9/2ZpWn1If/fA19nxIBk2zBPD3SsJHS1XNQvz0r9s0VOZwlQ
         ocB1tmE+MXNAcEFiRwzjZNiE9gFfTVz5SbBe9dOCux4lhTEli7wboxO33Jsgw+tEhbPt
         a0pXYLHAk6CkD9RkWeFhFfI7LXK/hNQKWhvoA=
Received: by 10.231.157.11 with SMTP id z11mr7403167ibw.147.1286998317261;
        Wed, 13 Oct 2010 12:31:57 -0700 (PDT)
Received: from localhost.localdomain (cm147.zeta152.maxonline.com.sg [116.87.152.147])
        by mx.google.com with ESMTPS id 8sm3050710iba.16.2010.10.13.12.31.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 12:31:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.513.ge1ef3
In-Reply-To: <1286998311-5112-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158966>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/t5523-push-upstream.sh |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
index 00da707..337a69e 100755
--- a/t/t5523-push-upstream.sh
+++ b/t/t5523-push-upstream.sh
@@ -3,8 +3,14 @@
 test_description='push with --set-upstream'
 . ./test-lib.sh
 
+ensure_fresh_upstream() {
+	test -d parent &&
+	rm -rf parent
+	git init --bare parent
+}
+
 test_expect_success 'setup bare parent' '
-	git init --bare parent &&
+	ensure_fresh_upstream &&
 	git remote add upstream parent
 '
 
-- 
1.7.2.2.513.ge1ef3

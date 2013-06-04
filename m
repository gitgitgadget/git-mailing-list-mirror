From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 6/6] test-send-email: test for pre-sanitized self name
Date: Tue, 4 Jun 2013 10:56:19 +0300
Message-ID: <1370332482-12329-7-git-send-email-mst@redhat.com>
References: <1370332482-12329-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 04 09:55:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujm60-0004RU-6B
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 09:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760086Ab3FDHzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 03:55:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35703 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759930Ab3FDHzu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 03:55:50 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r547tkA4019009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 4 Jun 2013 03:55:46 -0400
Received: from redhat.com (vpn-203-14.tlv.redhat.com [10.35.203.14])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id r547tivO019662;
	Tue, 4 Jun 2013 03:55:45 -0400
Content-Disposition: inline
In-Reply-To: <1370332482-12329-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226329>

Users can sanitize from address manually.
Verify that these are suppressed properly.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 t/t9001-send-email.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 0d50fa7..38f407d 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -241,6 +241,11 @@ test_expect_success $PREREQ 'non-ascii self name is suppressed' "
 		'non_ascii_self_suppressed'
 "
 
+test_expect_success $PREREQ 'sanitized self name is suppressed' "
+	test_suppress_self_unquoted '\"A U. Thor\"' 'author@example.com' \
+		'self_name_sanitized_suppressed'
+"
+
 test_expect_success $PREREQ 'Show all headers' '
 	git send-email \
 		--dry-run \
-- 
MST

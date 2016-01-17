From: David Greene <greened@obbligato.org>
Subject: [PATCH 1/1] contrib/subtree: Make testing easier
Date: Sun, 17 Jan 2016 17:47:59 -0600
Message-ID: <44704afe6f728263b5200da2b343783a5a209eca.1453074427.git.greened@obbligato.org>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	davidw@realtimegenomics.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 18 00:48:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKx3P-0000BU-IO
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 00:48:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023AbcAQXsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2016 18:48:12 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:33023 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752916AbcAQXsK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2016 18:48:10 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.us.cray.com)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1aKx4g-0003hP-An; Sun, 17 Jan 2016 17:49:34 -0600
X-Mailer: git-send-email 2.6.1
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  From: David A. Greene <greened@obbligato.org> Add some Makefile
    dependencies to ensure an updated git-subtree gets copied to the main area
    before testing begins. Signed-off-by: David A. Greene <greened@obbligato.org>
    --- [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
  0.0 URIBL_BLOCKED          ADMINISTRATOR NOTICE: The query to URIBL was blocked.
                             See
                             http://wi 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284277>

From: David A. Greene <greened@obbligato.org>

Add some Makefile dependencies to ensure an updated git-subtree
gets copied to the main area before testing begins.

Signed-off-by: David A. Greene <greened@obbligato.org>
---

Notes:
    v1 - Initial patch

 contrib/subtree/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
index 3071baf..6afa9aa 100644
--- a/contrib/subtree/Makefile
+++ b/contrib/subtree/Makefile
@@ -37,6 +37,7 @@ GIT_SUBTREE_DOC := git-subtree.1
 GIT_SUBTREE_XML := git-subtree.xml
 GIT_SUBTREE_TXT := git-subtree.txt
 GIT_SUBTREE_HTML := git-subtree.html
+GIT_SUBTREE_TEST := ../../git-subtree
 
 all:: $(GIT_SUBTREE)
 
@@ -71,7 +72,10 @@ $(GIT_SUBTREE_HTML): $(GIT_SUBTREE_TXT)
 	$(ASCIIDOC) -b xhtml11 -d manpage -f $(ASCIIDOC_CONF) \
 		-agit_version=$(GIT_VERSION) $^
 
-test:
+$(GIT_SUBTREE_TEST): $(GIT_SUBTREE)
+	cp $< $@
+
+test: $(GIT_SUBTREE_TEST)
 	$(MAKE) -C t/ test
 
 clean:
-- 
2.6.1

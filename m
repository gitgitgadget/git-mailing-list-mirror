From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: [PATCH] Use fixed-size integers for the on-disk pack structure.
Date: Wed, 17 Jan 2007 09:07:23 +0100
Message-ID: <20070118003108.1F8FEA907@diphong.localdomain>
X-From: git-owner@vger.kernel.org Thu Jan 18 01:31:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7LBR-0004k1-Du
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 01:31:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbXARAbL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 19:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbXARAbL
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 19:31:11 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:53692 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbXARAbK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 19:31:10 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 4282728133;
	Thu, 18 Jan 2007 01:31:09 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id h81YDB02pjXJ; Thu, 18 Jan 2007 01:31:09 +0100 (CET)
Received: from diphong.localdomain (ppp-62-216-203-221.dynamic.mnet-online.de [62.216.203.221])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id EBFDE28124;
	Thu, 18 Jan 2007 01:31:08 +0100 (CET)
Received: by diphong.localdomain (Postfix, from userid 1001)
	id 1F8FEA907; Thu, 18 Jan 2007 01:31:08 +0100 (CET)
To: undisclosed-recipients:;
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37050>

Plain integer types without a fixed size can vary between platforms.  Even
though all common platforms use 32-bit ints, there is no guarantee that
this won't change at some point.  Furthermore, specifying an integer type
with explicit size makes the definition of structures more obvious.
---
 pack.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/pack.h b/pack.h
index 4814800..8aab5bb 100644
--- a/pack.h
+++ b/pack.h
@@ -10,9 +10,9 @@
 #define PACK_VERSION 2
 #define pack_version_ok(v) ((v) == htonl(2) || (v) == htonl(3))
 struct pack_header {
-	unsigned int hdr_signature;
-	unsigned int hdr_version;
-	unsigned int hdr_entries;
+	uint32_t hdr_signature;
+	uint32_t hdr_version;
+	uint32_t hdr_entries;
 };
 
 extern int verify_pack(struct packed_git *, int);
-- 
1.5.0.rc1.g8bef

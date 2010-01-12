From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 14/18] sha1_file.c: remove unused function
Date: Mon, 11 Jan 2010 23:52:57 -0800
Message-ID: <1263282781-25596-15-git-send-email-gitster@pobox.com>
References: <1263282781-25596-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 08:53:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUbZV-0004h8-50
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 08:53:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483Ab0ALHxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 02:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753480Ab0ALHxj
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 02:53:39 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41203 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753470Ab0ALHxh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 02:53:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 953E58E8A8
	for <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=JCBg
	UbZ7I+XRV4ylzRYSgIRbKG4=; b=MJwBY5WPfpnbK1FepicYWUdjlqHpqZLeSOWx
	bA/4zCvIw4ZkEqVXb7OOQeEbcW6m8fwaa+VUQVaIam0AZJoW9g52paQLd6bzwwX0
	8taSh7FfDxf572M15bkX/FJqSVmt/KcCEM6sXsevV+m3nEFV4nIFc56l0Oe4xEra
	pk08ARk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Oum92B
	FFvDP9UqvNjiVUgn866Sc7WA35qNb+zX+U3gLBtbpc5NUDxvesspJIBor/ZSzwKt
	8NSy66XimXZK/7lTL2c+cFJYPs4jrHecIR5actYGXYyEdJTsR8cQW/6ZeUCo//E4
	bfeqrGv1oJA2PGAAFeUDsMAy0Z7eBMnw5Epq4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 835D28E8A7
	for <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BE5588E8A6 for
 <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:35 -0500 (EST)
X-Mailer: git-send-email 1.6.6.280.ge295b7.dirty
In-Reply-To: <1263282781-25596-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 96CB4380-FF4F-11DE-99AA-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136687>

has_pack_file() is not used anywhere.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h     |    1 -
 sha1_file.c |    8 --------
 2 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/cache.h b/cache.h
index e7bb6b7..90edb5b 100644
--- a/cache.h
+++ b/cache.h
@@ -683,7 +683,6 @@ extern int has_sha1_pack(const unsigned char *sha1);
 extern int has_sha1_file(const unsigned char *sha1);
 extern int has_loose_object_nonlocal(const unsigned char *sha1);
 
-extern int has_pack_file(const unsigned char *sha1);
 extern int has_pack_index(const unsigned char *sha1);
 
 extern const signed char hexval_table[256];
diff --git a/sha1_file.c b/sha1_file.c
index 63981fb..7086760 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2458,14 +2458,6 @@ int has_pack_index(const unsigned char *sha1)
 	return 1;
 }
 
-int has_pack_file(const unsigned char *sha1)
-{
-	struct stat st;
-	if (stat(sha1_pack_name(sha1), &st))
-		return 0;
-	return 1;
-}
-
 int has_sha1_pack(const unsigned char *sha1)
 {
 	struct pack_entry e;
-- 
1.6.6.280.ge295b7.dirty

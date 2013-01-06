From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH] api-allocation-growing.txt: encourage better variable naming
Date: Sun,  6 Jan 2013 15:35:05 +0000
Message-ID: <1357486505-21357-1-git-send-email-git@adamspiers.org>
References: <20130106152716.GB2396@pacific.linksys.moosehall>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 06 16:35:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrsG0-00050G-0s
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 16:35:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756049Ab3AFPfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 10:35:08 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:45390 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756039Ab3AFPfH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 10:35:07 -0500
Received: from localhost (f.4.d.7.f.d.e.f.f.f.3.7.3.0.a.1.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:1a03:73ff:fedf:7d4f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id C220C2E5D3
	for <git@vger.kernel.org>; Sun,  6 Jan 2013 15:35:05 +0000 (GMT)
X-Mailer: git-send-email 1.7.11.7.33.gb8feba5
In-Reply-To: <20130106152716.GB2396@pacific.linksys.moosehall>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212810>

The documentation for the ALLOC_GROW API implicitly encouraged
developers to use "ary" as the variable name for the array which is
dynamically grown.  However "ary" is an unusual abbreviation hardly
used anywhere else in the source tree, and it is also better to name
variables based on their contents not on their type.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 Documentation/technical/api-allocation-growing.txt | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/api-allocation-growing.txt b/Documentation/technical/api-allocation-growing.txt
index 43dbe09..3894815 100644
--- a/Documentation/technical/api-allocation-growing.txt
+++ b/Documentation/technical/api-allocation-growing.txt
@@ -5,7 +5,9 @@ Dynamically growing an array using realloc() is error prone and boring.
 
 Define your array with:
 
-* a pointer (`ary`) that points at the array, initialized to `NULL`;
+* a pointer (`array`) that points at the array, initialized to `NULL`
+  (although please name the variable based on its contents, not on its
+  type);
 
 * an integer variable (`alloc`) that keeps track of how big the current
   allocation is, initialized to `0`;
@@ -13,22 +15,22 @@ Define your array with:
 * another integer variable (`nr`) to keep track of how many elements the
   array currently has, initialized to `0`.
 
-Then before adding `n`th element to the array, call `ALLOC_GROW(ary, n,
+Then before adding `n`th element to the array, call `ALLOC_GROW(array, n,
 alloc)`.  This ensures that the array can hold at least `n` elements by
 calling `realloc(3)` and adjusting `alloc` variable.
 
 ------------
-sometype *ary;
+sometype *array;
 size_t nr;
 size_t alloc
 
 for (i = 0; i < nr; i++)
-	if (we like ary[i] already)
+	if (we like array[i] already)
 		return;
 
 /* we did not like any existing one, so add one */
-ALLOC_GROW(ary, nr + 1, alloc);
-ary[nr++] = value you like;
+ALLOC_GROW(array, nr + 1, alloc);
+array[nr++] = value you like;
 ------------
 
 You are responsible for updating the `nr` variable.
-- 
1.7.11.7.33.gb8feba5

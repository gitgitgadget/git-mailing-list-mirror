From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 1/6] Reduce PushOperationResult contructor visibility, accept null instead
Date: Wed, 27 Aug 2008 20:41:41 +0200
Message-ID: <1219862506-11075-2-git-send-email-marek.zawirski@gmail.com>
References: <1219862506-11075-1-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Aug 27 20:43:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYPz2-0005bI-72
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 20:43:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330AbYH0Sl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 14:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752233AbYH0Sl5
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 14:41:57 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:64959 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786AbYH0Sl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 14:41:56 -0400
Received: by yw-out-2324.google.com with SMTP id 9so199790ywe.1
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 11:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Zd0dWF1msV3ws14tY4dk/m3rSvL7xR1TQpL72e3TwEc=;
        b=F+IbP/zo0iIyvANWv6BfzoMW7AEtQ+ghFnZ9/Cov8ECDFI4o8NJKO317PFMErR+u83
         hg/pTN9K4DNYK+SfJvlo4cr0pjGkBzq6pKI/+mjI/43RSSbUcynKbXRgpnoDSBz27zjD
         MIAHUqK8YfSJVq2mLWldG01G5cppzbtaA4sNk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=v2snU+460pA9goSn03OuhF6YpI6fMz43srGBrARQFGwX9krP3xzQequHbEirU5+7dS
         LEo6IT/3ZrOkJRaLDrttgjWHJBA5Uitwc+k0pKvmOK1EmaGe4S40ORgvOSR2DgVUNlSW
         CMPDopb/GpWkTe9zHD2Nt4Kupiy0EUEWgy2Xc=
Received: by 10.103.249.7 with SMTP id b7mr201362mus.51.1219862514256;
        Wed, 27 Aug 2008 11:41:54 -0700 (PDT)
Received: from localhost ( [62.21.4.140])
        by mx.google.com with ESMTPS id i5sm42353656mue.11.2008.08.27.11.41.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Aug 2008 11:41:53 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219862506-11075-1-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93917>

This constructor should be instantiated only by PushOperation.

Some changes were needed in RefUpdateContentProvider (and related) - to
accept null value instead of empty PushOperationResult.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../spearce/egit/core/op/PushOperationResult.java  |    2 +-
 .../egit/ui/internal/push/ConfirmationPage.java    |    2 +-
 .../egit/ui/internal/push/PushResultTable.java     |    9 +++++++--
 .../ui/internal/push/RefUpdateContentProvider.java |    8 ++++++--
 4 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperationResult.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperationResult.java
index 6ffe998..e3a392d 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperationResult.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperationResult.java
@@ -35,7 +35,7 @@
 	/**
 	 * Construct empty push operation result.
 	 */
-	public PushOperationResult() {
+	PushOperationResult() {
 		this.urisEntries = new LinkedHashMap<URIish, Entry>();
 	}
 
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/ConfirmationPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/ConfirmationPage.java
index c8cdf29..08d21b3 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/ConfirmationPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/ConfirmationPage.java
@@ -139,7 +139,7 @@ private void checkPreviousPagesSelections() {
 
 	private void revalidate() {
 		// always update this page
-		resultPanel.setData(local, new PushOperationResult());
+		resultPanel.setData(local, null);
 		confirmedResult = null;
 		displayedRepoSelection = repoPage.getSelection();
 		displayedRefSpecs = refSpecPage.getRefSpecs();
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/PushResultTable.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/PushResultTable.java
index 2cf2be4..c5e476b 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/PushResultTable.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/PushResultTable.java
@@ -120,7 +120,7 @@ public int hashCode(Object element) {
 			}
 		});
 		tableViewer.setContentProvider(new RefUpdateContentProvider());
-		tableViewer.setInput(new PushOperationResult());
+		tableViewer.setInput(null);
 	}
 
 	void setData(final Repository localDb, final PushOperationResult result) {
@@ -128,7 +128,7 @@ void setData(final Repository localDb, final PushOperationResult result) {
 		for (final TableColumn tc : tableViewer.getTable().getColumns())
 			tc.dispose();
 		// Set empty result for a while.
-		tableViewer.setInput(new PushOperationResult());
+		tableViewer.setInput(null);
 
 		// Layout should be recreated to work properly.
 		final TableColumnLayout layout = new TableColumnLayout();
@@ -171,6 +171,11 @@ public String getText(Object element) {
 			}
 		});
 
+		if (result == null) {
+			tablePanel.layout();
+			return;
+		}
+
 		int i = 0;
 		for (final URIish uri : result.getURIs()) {
 			final TableViewerColumn statusViewer = createColumn(layout, NLS
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/RefUpdateContentProvider.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/RefUpdateContentProvider.java
index 862fe59..884c9a3 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/RefUpdateContentProvider.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/RefUpdateContentProvider.java
@@ -21,13 +21,17 @@
  * Content provided for push result table viewer.
  * <p>
  * Input of this provided must be {@link PushOperationResult} instance, while
- * returned elements are instances of {@link RefUpdateElement}.
- *
+ * returned elements are instances of {@link RefUpdateElement}. Null input is
+ * allowed, resulting in no elements.
+ * 
  * @see PushOperationResult
  * @see RefUpdateElement
  */
 class RefUpdateContentProvider implements IStructuredContentProvider {
 	public Object[] getElements(final Object inputElement) {
+		if (inputElement == null)
+			return new RefUpdateElement[0];
+
 		final PushOperationResult result = (PushOperationResult) inputElement;
 
 		final SortedMap<String, String> dstToSrc = new TreeMap<String, String>();
-- 
1.5.6.3

From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 0/6] Fetch UI, minor improvements/fixes
Date: Wed, 27 Aug 2008 20:41:40 +0200
Message-ID: <1219862506-11075-1-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Aug 27 20:42:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYPyr-0005Y2-AK
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 20:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877AbYH0Slx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 14:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbYH0Slx
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 14:41:53 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:64959 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768AbYH0Slw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 14:41:52 -0400
Received: by yw-out-2324.google.com with SMTP id 9so199790ywe.1
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 11:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=sjNlndl1zX/cxRB3udhvqgraaG55Wx/iYo8UMNlx0Jk=;
        b=kI/rvkNI2oMQbCmZKhODUs8UzsErXpOhd+EuUUz9YTRphniTIhmlFF8YrP9oPsdRmV
         PaO6Mh52OSDaJH3DyDGZFt4Qo3abDV0Yi4efAgwg3jhX0q+ojUhFfcSY7ahlC/HFTqhv
         krdIAX5FOBgln3rG8jl3dQKcWXgAJ1+zpKQds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Z1BTQS61njOtpMizYHzQTaiP1MwYrE4e286Pv8iHCTharXQ7pAw3886WHHhOp/kbrI
         bop6xCtpM0PQTq0cTLcyphUfqa9LTqn7PYzJiv3o1ktZlxFEVtgWzlGRjSc4EY6bOYZT
         4lgvwLcSbinxOXLuDxbxG1TX8pjxzrde1AytE=
Received: by 10.103.251.3 with SMTP id d3mr193469mus.73.1219862510712;
        Wed, 27 Aug 2008 11:41:50 -0700 (PDT)
Received: from localhost ( [62.21.4.140])
        by mx.google.com with ESMTPS id j10sm11079541mue.17.2008.08.27.11.41.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Aug 2008 11:41:50 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93916>

Simple fetch UI - made smiliar as push UI: no surprise, the same
components are used, code is analogous.

We can later decide to switch to some more complex result displaying
component, like common Transport View as suggested by Shawn. Anyway,
now we have working UI for push and fetch, and other signifficant
changes were introduced in both jgit and egit in the mean time...
isn't that right time to release next version?

OT(?): The only strange thing I observe now is how "refresh" resources
works in egit (master), but maybe I'll open new issues for that.

Marek Zawirski (6):
  Reduce PushOperationResult contructor visibility, accept null instead
  Fix RefSpecPanel to not display mode column in fetch version
  Handle null remoteName in RefSpecPanel better
  Add tag fetching strategy selection to fetch version of RefSpecPage
  Rename ResultDialog to PushResultDialog
  Fetch GUI

 .../spearce/egit/core/op/PushOperationResult.java  |    2 +-
 org.spearce.egit.ui/plugin.properties              |    3 +
 org.spearce.egit.ui/plugin.xml                     |   15 ++
 .../src/org/spearce/egit/ui/UIText.java            |  102 ++++++++++
 .../egit/ui/internal/actions/FetchAction.java      |   51 +++++
 .../egit/ui/internal/components/RefSpecPage.java   |   70 ++++++-
 .../egit/ui/internal/components/RefSpecPanel.java  |   36 +++-
 .../FetchResultDialog.java}                        |   35 ++-
 .../egit/ui/internal/fetch/FetchResultTable.java   |  213 ++++++++++++++++++++
 .../egit/ui/internal/fetch/FetchWizard.java        |  189 +++++++++++++++++
 .../fetch/TrackingRefUpdateContentProvider.java    |   41 ++++
 .../egit/ui/internal/push/ConfirmationPage.java    |    2 +-
 .../{ResultDialog.java => PushResultDialog.java}   |    4 +-
 .../egit/ui/internal/push/PushResultTable.java     |    9 +-
 .../spearce/egit/ui/internal/push/PushWizard.java  |    5 +-
 .../ui/internal/push/RefUpdateContentProvider.java |    8 +-
 .../src/org/spearce/egit/ui/uitext.properties      |   38 ++++
 17 files changed, 784 insertions(+), 39 deletions(-)
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/FetchAction.java
 copy org.spearce.egit.ui/src/org/spearce/egit/ui/internal/{push/ResultDialog.java => fetch/FetchResultDialog.java} (67%)
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/fetch/FetchResultTable.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/fetch/FetchWizard.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/fetch/TrackingRefUpdateContentProvider.java
 rename org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/{ResultDialog.java => PushResultDialog.java} (95%)

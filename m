From: "Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com>
Subject: [PATCH EGIT] Fix NPE on missing git data
Date: Thu, 30 Apr 2009 22:59:22 +0800
Message-ID: <1241103562-6658-1-git-send-email-git@sdiz.net>
Cc: git@vger.kernel.org, "Daniel Cheng (aka SDiZ)" <git@sdiz.net>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 16:59:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzXjY-0005w7-Pz
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 16:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762323AbZD3O73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 10:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762247AbZD3O72
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 10:59:28 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:51042 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753117AbZD3O71 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 10:59:27 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1475746rvb.1
        for <git@vger.kernel.org>; Thu, 30 Apr 2009 07:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=TPwDW5I/gECG3+sv9xFoNiKCIfcuzIPrbr1/LV2xiyc=;
        b=kGkEtGYL0Dbq5y5MsehVF/Dclp6MV58eHfcGBXjpWZ09LLsvydOZEuMDqojxb87wgA
         MVGuKXRbrdRIygZ0r/2tGxuJs+/xfb/s2RQGcsnTADv62xPeJ5syXXtKJjzFRVZ1E8XK
         jc+NL11AwIY94XXFIJRpIP9oY/pTDtJLSU8sE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=gv2ApKj9RtsWHPnJ3Y0cYj6F1szddVWAigrb87ztE8TR+Px0zTOL/i9edtwJSBCRE4
         W5iCZXCtCmxrEaChBMMbRRhBJ0awgShep3rVY5U0jNXjSQVktln2p/qNhauYW/TU9E2h
         BjyJ2KiZ/Bl8vvA+Ud01SYNt4D8H3CWq+shWg=
Received: by 10.142.218.4 with SMTP id q4mr494164wfg.76.1241103567104;
        Thu, 30 Apr 2009 07:59:27 -0700 (PDT)
Received: from localhost.localdomain (n1164956087.netvigator.com [116.49.56.87])
        by mx.google.com with ESMTPS id 29sm5906759wfg.28.2009.04.30.07.59.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Apr 2009 07:59:26 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118022>

Fix the following NPE:
!ENTRY org.eclipse.core.resources 4 2 2009-04-30 22:52:47.117
!MESSAGE Problems occurred when invoking code from plug-in: "org.eclipse.core.resources".
!STACK 0
java.lang.NullPointerException
    at org.spearce.egit.core.project.RepositoryMapping.getMapping(RepositoryMapping.java:235)
    at org.spearce.egit.ui.internal.decorators.GitLightweightDecorator$2.visit(GitLightweightDecorator.java:492)
    at org.eclipse.core.internal.events.ResourceDelta.accept(ResourceDelta.java:68)
    at org.eclipse.core.internal.events.ResourceDelta.accept(ResourceDelta.java:79)
    at org.eclipse.core.internal.events.ResourceDelta.accept(ResourceDelta.java:79)
    at org.eclipse.core.internal.events.ResourceDelta.accept(ResourceDelta.java:79)
    at org.eclipse.core.internal.events.ResourceDelta.accept(ResourceDelta.java:79)
    at org.eclipse.core.internal.events.ResourceDelta.accept(ResourceDelta.java:79)
    at org.eclipse.core.internal.events.ResourceDelta.accept(ResourceDelta.java:55)
    at org.spearce.egit.ui.internal.decorators.GitLightweightDecorator.resourceChanged(GitLightweightDecorator.java:477)
    at org.eclipse.core.internal.events.NotificationManager$2.run(NotificationManager.java:288)
    at org.eclipse.core.runtime.SafeRunner.run(SafeRunner.java:37)
    at org.eclipse.core.internal.events.NotificationManager.notify(NotificationManager.java:282)
    at org.eclipse.core.internal.events.NotificationManager.broadcastChanges(NotificationManager.java:148)
    at org.eclipse.core.internal.resources.Workspace.broadcastPostChange(Workspace.java:313)
    at org.eclipse.core.internal.resources.Workspace.endOperation(Workspace.java:1022)
    at org.eclipse.core.internal.resources.InternalWorkspaceJob.run(InternalWorkspaceJob.java:45)
    at org.eclipse.core.internal.jobs.Worker.run(Worker.java:55)

Signed-off-by: Daniel Cheng (aka SDiZ) <git@sdiz.net>
---
 .../egit/core/project/RepositoryMapping.java       |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java b/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java
index b49f380..029c56a 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java
@@ -232,6 +232,9 @@ public static RepositoryMapping getMapping(final IResource resource) {
 		if (!(rp instanceof GitProvider))
 			return null;
 
+		if (((GitProvider)rp).getData() == null)
+			return null;
+
 		return ((GitProvider)rp).getData().getRepositoryMapping(resource);
 	}
 
-- 
1.6.2.1

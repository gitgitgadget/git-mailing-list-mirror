From: Stephen Bannasch <stephen.bannasch@deanbrook.org>
Subject: Re: [EGIT RFC PATCH(was Re: egit problem with sym linked eclipse project dirs)] Add some support for symlinked
 projects.
Date: Wed, 18 Mar 2009 12:02:15 -0400
Message-ID: <p06240820c5e6c6a7d62a@[63.138.152.192]>
References: <p0624081cc5928e2885fd@[192.168.1.114]> <200903112317.41380.robin.rosenberg.lists@dewire.com>
 <p06240814c5de27cbf520@[63.138.152.192]> <200903120756.07853.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 17:04:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjyFM-0000hX-B8
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 17:04:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753894AbZCRQCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 12:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753654AbZCRQCa
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 12:02:30 -0400
Received: from deanbrook.org ([72.52.70.192]:35768 "HELO deanbrook.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753563AbZCRQC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 12:02:29 -0400
Received: from ::ffff:70.109.253.176 ([70.109.253.176]) by deanbrook.org for <git@vger.kernel.org>; Wed, 18 Mar 2009 09:02:24 -0700
In-Reply-To: <200903120756.07853.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113624>

At 7:56 AM +0100 3/12/09, Robin Rosenberg wrote:
>torsdag 12 mars 2009 03:57:09 skrev Stephen Bannasch 
><stephen.bannasch@deanbrook.org>:
>>  OK ... I'm a bit confused now because I no longer have Git listed as
>>  a repository type for Team Sharing.
>>
>  > I deleted the existing org.spearce.* eclipse plugins

...

>  > The new plugins are there:
>>
>>     [eclipse]$ ls plugins/org.spearce.*
>>     plugins/org.spearce.egit.core.test_0.4.0.200903112237.jar
>>     plugins/org.spearce.egit_0.4.0.200903112237.jar
>>     plugins/org.spearce.egit.core_0.4.0.200903112237.jar
>>     plugins/org.spearce.jgit_0.4.0.200903112237.jar
>>     plugins/org.spearce.egit.ui_0.4.0.200903112237.jar
>>
>>  Quit and restarted Eclipse.
>>
>>  When I select a project with an existing git repository and try to
>>  enable team/sharing only CVS and SVN are listed.
>
>You don't have the a matching feature. That could be it, but I'm not sure.
>You can also try starting eclipse witth the -clean switch. Looking at the
><workspace>/.metadata/.log could also give you some hints.

I figured out the problem I had when testing the patched egit plugin. 
If I had installed egit from the update site I had to do more than 
just delete the jars -- I had to delete the whole feature from within 
Eclipse -- and then install the new plugin built from source.

In figuring this out I ended up testing the original problem with the 
master branch from earlier today and didn't see the issue I 
originally reported.

Did you already integrate the experimental patch?

Here's a documentation patch:

 From feb1ae0ccf7f671506853f4f49e9041950404b3d Mon Sep 17 00:00:00 2001
From: Stephen Bannasch <stephen.bannasch@gmail.com>
Date: Wed, 18 Mar 2009 11:51:56 -0400
Subject: [PATCH] clarify how to delete egit plugin when installing new build

---
  EGIT_INSTALL |   11 ++++++++++-
  1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/EGIT_INSTALL b/EGIT_INSTALL
index 3a8f249..3a9c209 100644
--- a/EGIT_INSTALL
+++ b/EGIT_INSTALL
@@ -21,7 +21,16 @@ things.

  INSTALLATION INSTRUCTIONS

-- Delete any old versions of the plugin in the 
<eclipse-path>/plugins/org.spearce.*
+First remove any existing egit plugin.
+
+If you have installed egit from the egit update site 
http://www.jgit.org/update-site:
+
+  delete the plugin from Software Updates and Add-ons from within  Eclipse
+
+If you have installed the plugin from source:
+
+  delete any old versions of the plugin jars in the 
<eclipse-path>/plugins/org.spearce.*
+
  - Start eclipse
  - Make sure a recent JDK 1.5.0_11 or JDK 1.6.x is among your 
installed JRE's. Which
    one is the default should not matter but Java 6 is recommended.
--
1.6.1.2


>For debugging/testing in general it is often easier to launch Eclipse from
>eclipse (Run As) without reinstalling.

As part of this test I need to switch to another workspace and I 
couldn't get that working with "Run As".

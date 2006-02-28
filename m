From: "Aneesh Kumar K.V" <aneesh.kumar@hp.com>
Subject: Re: [PATCH 2/2] Don't use excessive non-standard border width
Date: Tue, 28 Feb 2006 11:23:00 +0530
Message-ID: <20060228055300.GD5934@satan.india.hp.com>
References: <20060228045629.21880.19007.stgit@dv.roinet.com> <20060228045631.21880.27670.stgit@dv.roinet.com> <20060228051611.GB5934@satan.india.hp.com> <1141104931.22029.5.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Feb 28 06:55:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDxp6-0001Au-Cg
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 06:55:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWB1Fyz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 00:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbWB1Fyz
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 00:54:55 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:8353 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1750900AbWB1Fyz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Feb 2006 00:54:55 -0500
Received: from localhost (unknown [15.76.101.80])
	by atlrel9.hp.com (Postfix) with ESMTP id C48CE3449B
	for <git@vger.kernel.org>; Tue, 28 Feb 2006 00:54:51 -0500 (EST)
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1141104931.22029.5.camel@dv>
User-Agent: mutt-ng/devel-r655 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16918>

On Tue, Feb 28, 2006 at 12:35:31AM -0500, Pavel Roskin wrote:
> Hi, Aneesh!
> 
> On Tue, 2006-02-28 at 10:46 +0530, Aneesh Kumar K.V wrote:
> > I am not sure about this. I guess it looks much better with a border.
> > 
> > Not applied.
> 
> I think what really annoyed me was the menu with lone "Help" on the
> right hand side, and excessive borders only made it look worse.  Maybe
> the border should not be used on the menu?  It looks wrong to me that
> the menu is appended to the top pane rather than to the whole window.
> 

how about this

diff --git a/contrib/gitview/gitview b/contrib/gitview/gitview
index aded7ed..e57c53b 100755
--- a/contrib/gitview/gitview
+++ b/contrib/gitview/gitview
@@ -482,19 +482,10 @@ class GitView:
 
 	def construct(self):
 		"""Construct the window contents."""
+		vbox = gtk.VBox()
 		paned = gtk.VPaned()
 		paned.pack1(self.construct_top(), resize=False, shrink=True)
 		paned.pack2(self.construct_bottom(), resize=False, shrink=True)
-		self.window.add(paned)
-		paned.show()
-
-
-	def construct_top(self):
-		"""Construct the top-half of the window."""
-		vbox = gtk.VBox(spacing=6)
-		vbox.set_border_width(12)
-		vbox.show()
-
 		menu_bar = gtk.MenuBar()
 		menu_bar.set_pack_direction(gtk.PACK_DIRECTION_RTL)
 		help_menu = gtk.MenuItem("Help")
@@ -506,8 +497,20 @@ class GitView:
 		help_menu.set_submenu(menu)
 		help_menu.show()
 		menu_bar.append(help_menu)
-		vbox.pack_start(menu_bar, False, False, 2)
 		menu_bar.show()
+		vbox.pack_start(menu_bar, False, False, 2)
+		vbox.pack_start(paned, True, True, 2)
+		self.window.add(vbox)
+		paned.show()
+		vbox.show()
+
+
+	def construct_top(self):
+		"""Construct the top-half of the window."""
+		vbox = gtk.VBox(spacing=6)
+		vbox.set_border_width(12)
+		vbox.show()
+
 
 		scrollwin = gtk.ScrolledWindow()
 		scrollwin.set_policy(gtk.POLICY_NEVER, gtk.POLICY_AUTOMATIC)

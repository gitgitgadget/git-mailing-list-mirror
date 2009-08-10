From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Droppable Git Gui in Mac OS X
Date: Mon, 10 Aug 2009 08:26:11 -0700
Message-ID: <20090810152611.GR1033@spearce.org>
References: <loom.20090807T090458-788@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tobia Conforto <tobia.conforto@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 17:26:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaWlP-0005Y4-EB
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 17:26:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375AbZHJP0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 11:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753155AbZHJP0K
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 11:26:10 -0400
Received: from george.spearce.org ([209.20.77.23]:36048 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbZHJP0J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 11:26:09 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0A983381FD; Mon, 10 Aug 2009 15:26:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <loom.20090807T090458-788@post.gmane.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125463>

Tobia Conforto <tobia.conforto@gmail.com> wrote:
> I noticed that Git Gui cannot be launched on an existing repository by
> simply dragging the repository folder onto Git Gui's icon in the dock,
> but this is a standard UI feature in OS X.
> 
> Here is a fix "Git Gui.app" (which MacPorts installs in
> /opt/local/share/git-gui/lib) to enable this feature.

Interesting.

Two comments:

1) Commit message?  What should we record in the project history
   for this change?

2) Signed-off-by line?  Please see git.git's SUBMITTING_PATCHES
   file for details of what this means, and why it is necessary:

   http://repo.or.cz/w/alt-git.git?a=blob;f=Documentation/SubmittingPatches;hb=HEAD

 
> --- Git Gui.app/Contents/Info.plist
> +++ Git Gui.app/Contents/Info.plist
> @@ -24,5 +24,16 @@
>  	<string>GITg</string>
>  	<key>CFBundleVersion</key>
>  	<string>0.12.0</string>
> +	<key>CFBundleDocumentTypes</key>
> +	<array>
> +		<dict>
> +			<key>CFBundleTypeOSTypes</key>
> +			<array>
> +				<string>fold</string>
> +			</array>
> +			<key>CFBundleTypeRole</key>
> +			<string>Viewer</string>
> +		</dict>
> +	</array>
>  </dict>
>  </plist>
> --- Git Gui.app/Contents/Resources/Scripts/AppMain.tcl
> +++ Git Gui.app/Contents/Resources/Scripts/AppMain.tcl
> @@ -19,4 +19,9 @@
> 
>  unset gitexecdir gitguilib
>  set argv [lrange $argv 1 end]
> -source $AppMain_source
> +
> +proc ::tk::mac::OpenDocument {args} {
> +	cd [lindex $args 0]
> +}
> +
> +after 1 { source $AppMain_source }
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Shawn.

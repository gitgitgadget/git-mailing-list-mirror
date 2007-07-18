From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Move bundle specific stuff into bundle.[ch]
Date: Tue, 17 Jul 2007 23:13:18 -0700
Message-ID: <7vy7he8cjl.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707172346450.14781@racer.site>
	<Pine.LNX.4.64.0707172216420.14596@iabervon.org>
	<Pine.LNX.4.64.0707172302560.14596@iabervon.org>
	<20070718032907.GY32566@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jul 18 08:13:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IB2mp-0005r0-0R
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 08:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbXGRGNU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 02:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbXGRGNU
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 02:13:20 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:62515 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbXGRGNT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 02:13:19 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070718061319.LWLW1358.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 18 Jul 2007 02:13:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id QuDJ1X00R1kojtg0000000; Wed, 18 Jul 2007 02:13:19 -0400
In-Reply-To: <20070718032907.GY32566@spearce.org> (Shawn O. Pearce's message
	of "Tue, 17 Jul 2007 23:29:07 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52830>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> What about a patch format like this?  I doubt people move more than
> 26 blocks in the same patch of the same file, so using a single
> character block prefix when the before/after images are identical
> might work OK.
>
> diff --git a/git-gui.sh b/git-gui.sh
> index 0443129..f13fa80 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> a@@ -632,6 +632,43 a@@ You are using [git-version]:
>   
>   ######################################################################
>   ##
> a+## feature option selection
> ...
> a+
> a+######################################################################
> a+##
>   ## repository setup
>   
>   if {[catch {
> a@@ -1598,43 +1635,6 a@@ apply_config
>   
>   ######################################################################
>   ##
> a-## feature option selection
> ....
> a-##
>   ## ui construction
>   
>   set ui_comm {}

Gaah, my eyes, my *eyes*!!

	runs, stays in bathroom for 10 minutes and washes, and
        comes back...

It might not be actually so bad.  But I wonder if it would be
more obvious if you do not show the whole "a-" lines but leave
just a marker there.  That is (ugliness of "a@@" and "a-" that
made me wash my eyes needs to be fixed, though -- but that is
only the syntax):

a@@ -1598,43 +1635,6 a@@ apply_config
  
  ######################################################################
  ##
a-<<< Block a was originally here >>>
  ## ui construction
  
  set ui_comm {}

You are coming up with a new output format that is only used
when it is a straight move and nothing else, so by definition
there is really no need to show both removal and addition.

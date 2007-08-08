From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout_entry: only try to create directories when no file existed there
Date: Wed, 08 Aug 2007 15:40:25 -0700
Message-ID: <7vejid1wh2.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0708082200240.14781@racer.site>
	<7v4pj93evc.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0708082239120.21857@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 09 00:40:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIuCe-0007MO-6B
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 00:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763177AbXHHWk1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 18:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762936AbXHHWk1
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 18:40:27 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:36692 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762684AbXHHWk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 18:40:26 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070808224026.WIMB26965.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 8 Aug 2007 18:40:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ZagR1X00R1kojtg0000000; Wed, 08 Aug 2007 18:40:26 -0400
In-Reply-To: <Pine.LNX.4.64.0708082239120.21857@racer.site> (Johannes
	Schindelin's message of "Wed, 8 Aug 2007 22:42:27 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55385>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Now, if we have to remove it, we did a stat() before that.  It succeeded.  
> So we know that "a/b/c/d/e/f/" exists.  It might contain some symlinks, 
> but it exists.

Yes, it is exactly the thing.  It might contain a/b/c as symlink
but the index does not say a/b/c _IS_ a symlink, and the code
"fixes" that.  Otherwise, you would get inconsistent result from
"git checkout" depending on random symlink you happen to have in
your working tree.

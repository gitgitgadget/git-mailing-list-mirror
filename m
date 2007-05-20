From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 07/16] git-read-tree: take --submodules option
Date: Sun, 20 May 2007 11:33:17 -0700
Message-ID: <7vbqgfmjki.fsf@assigned-by-dhcp.cox.net>
References: <11795163053812-git-send-email-skimo@liacs.nl>
	<11795163061588-git-send-email-skimo@liacs.nl>
	<20070518215312.GB10475@steel.home>
	<20070518220826.GM942MdfPADPa@greensroom.kotnet.org>
	<20070518224209.GG10475@steel.home>
	<7vd50x1n0r.fsf@assigned-by-dhcp.cox.net>
	<20070519130542.GR942MdfPADPa@greensroom.kotnet.org>
	<7v4pm8y8tf.fsf@assigned-by-dhcp.cox.net>
	<20070520155407.GC27087@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: skimo@liacs.nl, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sun May 20 20:33:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpqDf-0003W1-Ks
	for gcvg-git@gmane.org; Sun, 20 May 2007 20:33:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757416AbXETSdV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 14:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757567AbXETSdV
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 14:33:21 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:55488 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757416AbXETSdU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 14:33:20 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070520183318.BILV13995.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sun, 20 May 2007 14:33:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 1WZH1X00M1kojtg0000000; Sun, 20 May 2007 14:33:18 -0400
In-Reply-To: <20070520155407.GC27087@efreet.light.src> (Jan Hudec's message of
	"Sun, 20 May 2007 17:54:07 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47881>

Jan Hudec <bulb@ucw.cz> writes:

> IMHO it makes more sense to fetch during fetch of superproject:
>
>  - If you don't fetch the superproject, it won't start refering to
>    unavailable commit of subproject. So should only need to fetch subproject
>    after fetching superproject.

Eh, I was suggesting that the subproject fetch would come after
checkout in "fetch and then checkout" sequence of the
superproject, and if you are arguing against it, you should
justify why it should not happen before checkout, as we both
agree it should come after fetch of superproject.  Your argument
is like saying you have to git-init before doing anything so
you should fetch when you git-init.  That's not a justification.

>  - If you fetch from more than one location, you want to fetch subproject
>    from location corresponding to where you fetch superproject from.

Not at all.  There is no reason to believe that the case that
superproject and subproject come from related URLs is more
common.  One of the reasons to do a separated project
organization is to allow looser bindings of the project from
project administrative viewpoint. The integrator may not
necessarily have any control over what the subproject guys do,
and more importantly, the subproject people do not even care nor
be aware of the fact that their project is sometimes bound
inside other peoples' superprojects.  Think of the embedded
appliance vendor binding the kernel, libc and busybox in their
superproject that holds them together with the build
infrastructure. The kernel folks certainly do not particularly
care about the vendor.

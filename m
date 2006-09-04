From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-repack: create new packs inside $PACKDIR, not cwd
Date: Mon, 04 Sep 2006 02:36:51 -0700
Message-ID: <7vveo4nfbg.fsf@assigned-by-dhcp.cox.net>
References: <11573485523752-git-send-email-martin@catalyst.net.nz>
	<20060904090833.GF17042@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Mon Sep 04 11:36:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKAse-00078U-KF
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 11:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWIDJgd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 05:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWIDJgd
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 05:36:33 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:34987 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751267AbWIDJgc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 05:36:32 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060904093632.HBXO18458.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Mon, 4 Sep 2006 05:36:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id J9cY1V00U1kojtg0000000
	Mon, 04 Sep 2006 05:36:33 -0400
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20060904090833.GF17042@admingilde.org> (Martin Waitz's message
	of "Mon, 4 Sep 2006 11:08:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26410>

Martin Waitz <tali@admingilde.org> writes:

> hoi :)
>
> On Mon, Sep 04, 2006 at 05:42:32PM +1200, Martin Langhoff wrote:
>> Avoid failing when cwd is !writable by writing the
>> packfiles directly in the $PACKDIR.
>
> what if other GIT commands are being called while you repack?
> Wouldn't they try to use the new packs, even while they are not
> completely written?

Given that a new pack is created first by writing out .pack and
then .idx, and that the using side ignores .pack without
corresponding .idx, we are talking about very small window, but
you are right.

Writing into $cwd was certainly a carelessness; we tend to use
$GIT_DIR/ for this kind of thing.



-- 
VGER BF report: U 0.926108

From: Junio C Hamano <junkio@cox.net>
Subject: Re: support for large packs and 64-bit offsets
Date: Mon, 09 Apr 2007 12:49:17 -0700
Message-ID: <7vtzvpz5tu.fsf@assigned-by-dhcp.cox.net>
References: <11760951973172-git-send-email-nico@cam.org>
	<20070409171925.GS5436@spearce.org>
	<alpine.LFD.0.98.0704091328130.28181@xanadu.home>
	<20070409174305.GU5436@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Apr 10 02:31:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hazrf-0000xq-BJ
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 21:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468AbXDITtT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 15:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753469AbXDITtT
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 15:49:19 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:49507 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753468AbXDITtS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 15:49:18 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070409194917.SSEE792.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Mon, 9 Apr 2007 15:49:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id l7pH1W0151kojtg0000000; Mon, 09 Apr 2007 15:49:18 -0400
In-Reply-To: <20070409174305.GU5436@spearce.org> (Shawn O. Pearce's message of
	"Mon, 9 Apr 2007 13:43:05 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44092>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Nicolas Pitre <nico@cam.org> wrote:
> ...
> Here's something we didn't think about, but that occurred to me today
> when reading this series: If we move the SHA-1 table out of the index
> and into the packfile (like we are planning) dumb commit-walkers
> (http-fetch) will have problems.  Right now they download the
> indexes of every available packfile to determine if they need to
> download the corresponding packfile to obtain a needed object.

If we really care about older dumb clients, one option is to
generate not .idx but .idx2, and have a corresponding .idx only
to support them.  But at that point, it's probably cleaner to
have an explicit option to produce .idx file of a particular
version, and tell people to pack public repositories they expect
older dumb clients to access with that option to keep things
backward compatible.

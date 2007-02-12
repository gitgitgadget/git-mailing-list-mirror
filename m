From: Junio C Hamano <junkio@cox.net>
Subject: Re: how to speed up "git log"?
Date: Sun, 11 Feb 2007 22:11:30 -0800
Message-ID: <7vmz3jaorx.fsf@assigned-by-dhcp.cox.net>
References: <200702111252.28393.bruno@clisp.org>
	<Pine.LNX.4.63.0702111745170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<200702120041.27419.bruno@clisp.org>
	<200702120059.17676.robin.rosenberg.lists@dewire.com>
	<7vmz3kaugq.fsf@assigned-by-dhcp.cox.net>
	<20070212060641.GC699@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Bruno Haible <bruno@clisp.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 12 07:11:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGUPb-0007d4-9I
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 07:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933020AbXBLGLe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 01:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933022AbXBLGLe
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 01:11:34 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:64282 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933020AbXBLGLd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 01:11:33 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070212061133.GRWM21668.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Mon, 12 Feb 2007 01:11:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id NWBW1W00o1kojtg0000000; Mon, 12 Feb 2007 01:11:31 -0500
In-Reply-To: <20070212060641.GC699@spearce.org> (Shawn O. Pearce's message of
	"Mon, 12 Feb 2007 01:06:41 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39374>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> I doubt it -- sliding mmap() in the current git, while is a good
>> change overall for handling really huge repos, would most likely
>> perform poorer than the fixed mmap() in 1.4.4 series on
>> platforms with slow mmap(), most notably on MacOS X.
>> 
>> It _might_ be possible that turning some sliding mmap() calls
>> into pread() makes it perform better on MacOS X.
>> 
>> I wonder what happens it git is compiled with NO_MMAP there...
>
> So I ran three trials, v1.5.0-rc4-26-gcc46a74 with and without
> NO_MMAP against v1.4.4.4 on a freshly repacked git.git.

I do not think freshly repacked git.git is a good test case for
a real-world workload where this really matters.  Doesn't your
default pack window large enough to cover it with a single
window, or perhaps two at most?

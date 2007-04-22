From: Junio C Hamano <junkio@cox.net>
Subject: Re: Today's 'master' leaves .idx/.pack in 0400
Date: Sun, 22 Apr 2007 11:52:05 -0700
Message-ID: <7v3b2snsx6.fsf@assigned-by-dhcp.cox.net>
References: <7vhcrml4wx.fsf@assigned-by-dhcp.cox.net>
	<7v1widrl0o.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0704221019100.9964@woody.linux-foundation.org>
	<7vvefonvdz.fsf@assigned-by-dhcp.cox.net>
	<7vmz10nv1h.fsf_-_@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0704221422250.28339@xanadu.home>
	<7vejmcnu28.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0704221431430.28339@xanadu.home>
	<alpine.LFD.0.98.0704221443070.28339@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Apr 22 20:52:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfhAU-0006bS-Ue
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 20:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbXDVSwK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 14:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbXDVSwJ
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 14:52:09 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:51158 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932290AbXDVSwI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 14:52:08 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070422185207.MMXR1268.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sun, 22 Apr 2007 14:52:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id qJs51W00k1kojtg0000000; Sun, 22 Apr 2007 14:52:06 -0400
In-Reply-To: <alpine.LFD.0.98.0704221443070.28339@xanadu.home> (Nicolas
	Pitre's message of "Sun, 22 Apr 2007 14:47:13 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45266>

Nicolas Pitre <nico@cam.org> writes:

> On Sun, 22 Apr 2007, Nicolas Pitre wrote:
>
>> On Sun, 22 Apr 2007, Junio C Hamano wrote:
>> 
>> > Nicolas Pitre <nico@cam.org> writes:
>> > 
>> > > On Sun, 22 Apr 2007, Junio C Hamano wrote:
>> > >
>> > >> With recent glibc, mkstemp() creates 0400 file.  Updated
>> > >> pack-objects uses it in pack/idx writing without fixing this,
>> > >> hence this problem.
>> > >
>> > > Oops.  I guess I'm guilty for this.  I didn't bother looking at the 
>> > > permission on the pack for git-pack-objects since git-repack seemed to 
>> > > take care of that.  But it only _remove_ write permissions.
>> > 
>> > Ok, then probably we can change the 0444 in my "quickfix" patch
>> > to 0644.  That should also let the 5300 test pass.
>> 
>> Well, actually there is no point making pack files writable.  If they're 
>> modified, they get corrupted.
>
> OK there are those test cases.
>
> Well...  Either we chmod to 0644, or we fix the tests to 'chmod +w' like 
> it is already done in t5302.
>
> In any case I wouldn't die() but only error() on a failure to chmod().  
> It is sure inconvenient if the pack isn't world readable, but it is not 
> a "fatal" problem for the repack.

If it DIED, I would not have to have been embarrassed in public
like this!

Grumble.

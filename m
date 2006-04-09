From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFH] Exploration of an alternative diff_delta() algorithm
Date: Sun, 09 Apr 2006 13:45:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604091340540.2215@localhost.localdomain>
References: <20060409143117.GA23908@erlang.gbar.dtu.dk>
 <Pine.LNX.4.64.0604091307460.2215@localhost.localdomain>
 <20060409173409.GB23908@erlang.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 09 19:45:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSdyJ-0004jS-D6
	for gcvg-git@gmane.org; Sun, 09 Apr 2006 19:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWDIRpI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Apr 2006 13:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWDIRpI
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Apr 2006 13:45:08 -0400
Received: from relais.videotron.ca ([24.201.245.36]:20390 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750826AbWDIRpG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Apr 2006 13:45:06 -0400
Received: from xanadu.home ([74.56.105.38]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IXG00C14UN0IJ70@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 09 Apr 2006 13:45:01 -0400 (EDT)
In-reply-to: <20060409173409.GB23908@erlang.gbar.dtu.dk>
X-X-Sender: nico@localhost.localdomain
To: Peter Eriksen <s022018@student.dtu.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18554>

On Sun, 9 Apr 2006, Peter Eriksen wrote:

> On Sun, Apr 09, 2006 at 01:14:31PM -0400, Nicolas Pitre wrote:
> ...
> > Nothing outside diff-delta.c and patch-delta.c is aware of the delta 
> > data format.  So if your version is meant to be a transparent 
> > replacement then it should pass all tests.  If it doesn't then it is 
> > broken.
> > 
> > To help you play around you could try the test-delta utility (make 
> > test-delta to build it).
> > 
> > So:
> > 
> > 	test-delta -d file1 file2 delta_file
> > 	test-delta -p file1 delta_file file3
> > 	cmp file2 file3
> 
> My tests of these kinds doesn't show any errors. 

Try this with the README file from the git source tree:

	sed s/git/GIT/g < ./README > /tmp/README.mod
	test-delta -d ./README /tmp/README.mod /tmp/README.delta
	[BOOM!]

> Though, if file2 is empty, test-delta writes: "file2: Invalid 
> argument".

We never delta against or towards empty files.


Nicolas

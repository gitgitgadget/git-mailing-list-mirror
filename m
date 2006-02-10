From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] count-delta.c: Match the delta data semantics change in
 version 3.
Date: Fri, 10 Feb 2006 10:20:40 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602101017420.5397@localhost.localdomain>
References: <Pine.LNX.4.64.0602091736500.5397@localhost.localdomain>
 <7v7j846qco.fsf@assigned-by-dhcp.cox.net>
 <7vbqxg3tdd.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602092053200.5397@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 11 03:17:37 2006
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1F7ajU-0002YM-00
	for <gcvg-git@gmane.org>; Fri, 10 Feb 2006 17:02:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWBJPUo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 10:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWBJPUo
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 10:20:44 -0500
Received: from relais.videotron.ca ([24.201.245.36]:46176 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932132AbWBJPUo
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2006 10:20:44 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IUH004ZM9AH4L00@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 10 Feb 2006 10:20:41 -0500 (EST)
In-reply-to: <Pine.LNX.4.64.0602092053200.5397@localhost.localdomain>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15916>

On Thu, 9 Feb 2006, Nicolas Pitre wrote:

> On Thu, 9 Feb 2006, Junio C Hamano wrote:
> 
> > Junio C Hamano <junkio@cox.net> writes:
> > 
> > > The bit is however _already_ looked at by the count_delta(),
> > > to assess the extent of damage, IIRC.  Should we be
> > > futureproofing that bit as well?
> > 
> > Something like this?
> 
> Right.

I'm not sure to fully understand what you meant in the comment below. 
but if it was related to the removed code, maybe this patch would make 
sense:

diff --git a/count-delta.c b/count-delta.c
index 978a60c..058a2aa 100644
--- a/count-delta.c
+++ b/count-delta.c
@@ -16,11 +16,7 @@
  *
  * Number of bytes that are _not_ copied from the source is deletion,
  * and number of inserted literal bytes are addition, so sum of them
- * is the extent of damage.  xdelta can express an edit that copies
- * data inside of the destination which originally came from the
- * source.  We do not count that in the following routine, so we are
- * undercounting the source material that remains in the final output
- * that way.
+ * is the extent of damage.
  */
 int count_delta(void *delta_buf, unsigned long delta_size,
 		unsigned long *src_copied, unsigned long *literal_added)

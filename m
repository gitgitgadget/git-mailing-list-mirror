X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-fetch fails with error code 128
Date: Fri, 15 Dec 2006 17:13:35 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612151706150.18171@xanadu.home>
References: <200612142308.45376.andyparkins@gmail.com>
 <7vfybiyqk0.fsf@assigned-by-dhcp.cox.net>
 <200612150946.14439.andyparkins@gmail.com>
 <7vy7p8omdh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Fri, 15 Dec 2006 22:13:45 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <7vy7p8omdh.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34566>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvLJD-0000OJ-Hv for gcvg-git@gmane.org; Fri, 15 Dec
 2006 23:13:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964866AbWLOWNh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 17:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965187AbWLOWNg
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 17:13:36 -0500
Received: from relais.videotron.ca ([24.201.245.36]:22830 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S964866AbWLOWNg (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 17:13:36 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JAC00M065QNVM40@VL-MO-MR002.ip.videotron.ca> for git@vger.kernel.org; Fri,
 15 Dec 2006 17:13:35 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Fri, 15 Dec 2006, Junio C Hamano wrote:

> Andy Parkins <andyparkins@gmail.com> writes:
> 
> > I hadn't realised it was quite a serious as these responses
> > are making it sound.  I'll gather more precise data upon my
> > return home.
> > ...
> > Clearly it is version-specific.  I'll do a bit of bisection
> > later and see if I can nail the problem down.
> 
> Thanks --- very much appreciated.  When it comes to
> inter-repository object transfer, we take compatibility very
> seriously.

I really doubt it is a compatibility problem.  The provided error 
message may only result from the fact that patch_delta() has returned 
NULL.

And since patch-delta is really simple, it doesn't have many reasons for 
returning NULL: either the object store on either the remote or local 
side is corrupted in which case a git-fsck-objects --full should catch 
that, or the system ran out of memory.



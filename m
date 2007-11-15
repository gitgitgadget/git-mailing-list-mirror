From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] rehabilitate some t5302 tests on 32-bit off_t machines
Date: Thu, 15 Nov 2007 13:51:47 -0500 (EST)
Message-ID: <alpine.LFD.0.9999.0711151349480.21255@xanadu.home>
References: <alpine.LFD.0.9999.0711151211330.21255@xanadu.home>
 <200711151938.29617.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Thu Nov 15 19:52:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Isjow-0001d0-5f
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 19:52:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757609AbXKOSvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 13:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758131AbXKOSvt
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 13:51:49 -0500
Received: from relais.videotron.ca ([24.201.245.36]:47994 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbXKOSvt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 13:51:49 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JRK00B1O9QB1GH0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 15 Nov 2007 13:51:48 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <200711151938.29617.johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65149>

On Thu, 15 Nov 2007, Johannes Sixt wrote:

> On Thursday 15 November 2007 18:24, Nicolas Pitre wrote:
> > Commit 8ed2fca458d085f12c3c6808ef4ddab6aa40ef14 was a bit draconian in
> > skipping certain tests which should be perfectly valid even on platform
> > with a 32-bit off_t.
> >
> > Signed-off-by: Nicolas Pitre <nico@cam.org>
> > ---
> > diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
> > index d93abc4..2a2878b 100755
> > --- a/t/t5302-pack-index.sh
> > +++ b/t/t5302-pack-index.sh
> > @@ -129,17 +129,15 @@ test_expect_failure \
> >      '[index v1] 6) newly created pack is BAD !' \
> >      'git verify-pack -v "test-4-${pack1}.pack"'
> >
> > -test "$have_64bits" &&
> >  test_expect_success \
> >      '[index v2] 1) stream pack to repository' \
> >      'rm -f .git/objects/pack/* &&
> > -     git-index-pack --index-version=2,0x40000 --stdin 
> < "test-1-${pack1}.pack" &&
> > +     git-index-pack --index-version=2 --stdin <  "test-1-${pack1}.pack" && 
> git prune-packed &&
> >       git count-objects | ( read nr rest && test "$nr" -eq 1 ) &&
> >       cmp "test-1-${pack1}.pack" ".git/objects/pack/pack-${pack1}.pack" &&
> > -     cmp "test-3-${pack1}.idx"  ".git/objects/pack/pack-${pack1}.idx"'
> > +     cmp "test-2-${pack1}.idx"  ".git/objects/pack/pack-${pack1}.idx"'
> 
> Since you changed this test, I assume that the remaining tests that you put 
> back failed only because this one did something wrong. If so, please mention 
> that in the commit message.

It did nothing wrong.  It was simply relying on the product of a 
previous test that might still be disabled.


Nicolas

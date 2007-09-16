From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: metastore
Date: Sun, 16 Sep 2007 17:45:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0709161731490.5298@iabervon.org>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151507310.28586@racer.site> <20070915145437.GA12875@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151430040.5298@iabervon.org> <Pine.LNX.4.64.0709152310380.28586@racer.site>
 <Pine.LNX.4.64.0709151737400.24221@asgard.lang.hm> <7vwsur590q.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0709161054380.5298@iabervon.org> <Pine.LNX.4.64.0709161346150.24221@asgard.lang.hm>
 <7vbqc25mgi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: david@lang.hm, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?utf-8?Q?H=C3=A4rdeman?= <david@hardeman.nu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 23:45:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX1w5-0007OT-QW
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 23:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753095AbXIPVpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 17:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753052AbXIPVpq
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 17:45:46 -0400
Received: from iabervon.org ([66.92.72.58]:43651 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752991AbXIPVpp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 17:45:45 -0400
Received: (qmail 6112 invoked by uid 1000); 16 Sep 2007 21:45:43 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Sep 2007 21:45:43 -0000
In-Reply-To: <7vbqc25mgi.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58353>

On Sun, 16 Sep 2007, Junio C Hamano wrote:

> david@lang.hm writes:
> 
> > my initial thoughts were to have git do all it's normal work and hook
> > into git at the point where it's writing the file out (where today it
> > chooses between writing the data to a file on disk, pipeing to stdout,
> > or pipeing to a pager) by adding the option to pipe into a different
> > program that would deal with the permission stuff. this program would
> > only have to write the file and set the permissions, it wouldn't have
> > to know anything about git other then where to find the permissions it
> > needs to know.
> >
> > it sounds like you are suggesting that the hook be much earlier in the
> > process,...
> 
> Well, you misread me or what I said was confusing or both.  I
> was suggesting totally opposite.  Let git do all its normal
> work, and then call your hook to munge the work tree in any way
> you want.

I think he was replying to me, not you. I was suggesting that git stop at 
the index, and let him take care of deciding how the index relates to the 
work tree. That is, he'd get called instead of check_updates() in 
unpack-trees. (And we might have to funnel more code paths through this 
function, so that checkout-index does what read-tree -m would do, wrt 
changes to the filesystem).

	-Daniel
*This .sig left intentionally blank*

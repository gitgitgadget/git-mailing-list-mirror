From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: linux-2.6.git/packed-refs???
Date: Tue, 13 Feb 2007 19:41:24 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702131937240.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v7ium1k7s.fsf@assigned-by-dhcp.cox.net> <20070213181610.GA2782@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, torvalds@linux-foundation.org,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Feb 13 19:41:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH2ao-0000Ox-2p
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 19:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbXBMSl1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 13:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751572AbXBMSl1
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 13:41:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:50769 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751573AbXBMSl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 13:41:26 -0500
Received: (qmail invoked by alias); 13 Feb 2007 18:41:25 -0000
X-Provags-ID: V01U2FsdGVkX1+qZIox+A2q2I28u8xNGi3u2aWrWmqBelN/5JRobq
	sOrw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070213181610.GA2782@thunk.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39579>

Hi,

On Tue, 13 Feb 2007, Theodore Tso wrote:

> On Tue, Feb 13, 2007 at 01:27:03AM -0800, Junio C Hamano wrote:
> > I noticed while scanning #git log that it appears that pack-refs
> > was run in your public repo and some people cannot clone over
> > dumb protocols with older git.
> > 
> >     commit 2986c02217f98809d8990e7679edf0f5d99f904d
> >     Author: Junio C Hamano <junkio@cox.net>
> >     Date:   Wed Nov 22 22:24:09 2006 -0800
> > 
> >     git-fetch: fix dumb protocol transport to fetch from pack-pruned ref
> > 
> > was the first revision that aligned dumb protocol clients with
> > pack-ref; unfortunately anything older will not find the ref
> > that was packed.
> 
> Stupid question.  Suppose someone has run git pack-refs on a
> repository.  What is the recommended way to reverse the process.  Is
> the answer is to clone the repository and then throw away the original
> one?  Is there another way to do it?

The easiest way I found here was to do

git-for-each-ref | while read sha1 tag name; do
	git update-ref -m "undo pack-ref" $name $sha1
done

Beware: this is tested once, and copied from memory.

Ciao,
Dscho

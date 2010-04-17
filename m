From: Sebastian Bober <sbober@servercare.de>
Subject: Re: Git import of the recent full enwiki dump
Date: Sat, 17 Apr 2010 02:48:52 +0200
Message-ID: <20100417004852.GA32053@post.servercare.de>
References: <w2x2d460de71004161647z41492baav3685249fa05145d6@mail.gmail.com> <m2ofabb9a1e1004161719h977b53b7oc2c452c2a2b0025e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Richard Hartmann <richih.mailinglist@gmail.com>,
	Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sam Vilain <sam@vilain.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 03:21:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2wjE-0000oo-E4
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 03:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758705Ab0DQBVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 21:21:43 -0400
Received: from tix64.net ([81.169.172.224]:37393 "EHLO
	h4945.serverkompetenz.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758134Ab0DQBVn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 21:21:43 -0400
Received: from bob by h4945.serverkompetenz.net with local (Exim 4.69)
	(envelope-from <sbober@servercare.de>)
	id 1O2wDM-0007XA-Dc; Sat, 17 Apr 2010 02:48:52 +0200
Mail-Followup-To: Sebastian Bober <sbober@servercare.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Git List <git@vger.kernel.org>, Avery Pennarun <apenwarr@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sam Vilain <sam@vilain.net>
Content-Disposition: inline
In-Reply-To: <m2ofabb9a1e1004161719h977b53b7oc2c452c2a2b0025e@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-bounce-key: tix64.net-1;sbober@servercare.de;1271467303;39728f79;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145105>

On Sat, Apr 17, 2010 at 02:19:40AM +0200, Sverre Rabbelier wrote:
> Heya,
> 
> [-wikitech-l, if they should be kept on the cc please re-add, I assume
> that the discussion of the git aspects are not relevant to that list]
> 
> On Sat, Apr 17, 2010 at 01:47, Richard Hartmann
> <richih.mailinglist@gmail.com> wrote:
> > This data set is probably the largest set of changes on earth, so
> > it's highly interesting to see what git will make of it.
> 
> I think that git might actually be able to handle it. Git's been known
> not to handle _large files_ very well, but a lot of history/a lot of
> files is something different. Assuming you do the import incrementally
> using something like git-fast-import (feeding it with a custom
> exporter that uses the dump as it's input) you shouldn't even need an
> extraordinary machine to do it (although you'd need a lot of storage).

The question would be, how the commits and the trees are laid out.
If every wiki revision shall be a git commit, then we'd need to handle
300M commits. And we have 19M wiki pages (that would be files). The tree
objects would be very large and git-fast-import would crawl.

Some tests with the german wikipedia have shown that importing the blobs
is doable on normal hardware. Getting the trees and commits into git
was not possible up to now, as fast-import was just to slow (and getting
slower after 1M commits).

I had the idea of having an importer that would just handle this special
case (1 file change per commit), but didn't get around to try that yet.


bye,
  Sebastian

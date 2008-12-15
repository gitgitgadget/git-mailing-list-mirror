From: Johan Herland <johan@herland.net>
Subject: Re: "git gc" doesn't seem to remove loose objects any more
Date: Mon, 15 Dec 2008 17:59:43 +0100
Message-ID: <200812151759.44420.johan@herland.net>
References: <808wqhzjl9.fsf@tiny.isode.net> <20081215155610.GA11502@mit.edu> <20081215161212.GE31145@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@sirena.org.uk>, Theodore Tso <tytso@mit.edu>,
	Bj?rn Steinbrink <B.Steinbrink@gmx.de>,
	Mikael Magnusson <mikachu@gmail.com>,
	Bruce Stephens <bruce.stephens@isode.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 15 18:02:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCGpP-0003Ut-2L
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 18:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753925AbYLORAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 12:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753244AbYLORAh
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 12:00:37 -0500
Received: from sam.opera.com ([213.236.208.81]:59151 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753925AbYLORAg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 12:00:36 -0500
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id mBFGxiiu018007
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 15 Dec 2008 16:59:50 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <20081215161212.GE31145@sirena.org.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103183>

On Monday 15 December 2008, Mark Brown wrote:
> On Mon, Dec 15, 2008 at 10:56:10AM -0500, Theodore Tso wrote:
> > On Mon, Dec 15, 2008 at 03:08:34PM +0100, Bj?rn Steinbrink wrote:
> > > To clarify that a bit more: git gc keeps unreachable objects
> > > unpacked, so that git prune can drop them. And git gc invokes git
> > > prune so that only unreachable objects older than 2 weeks are
> > > dropped.
> >
> > To be even more explicit, "git gc" will **unpack** objects that
> > have become unreachable and were currently in packs.  As a result,
> > the amount of disk space used by a git repository can actually go
> > **up** dramatically after a "git gc" operation, which could be
> > surprising for someone who is running close to full on their
> > filesystem, deletes a number of branches from a tracking
> > repository, and then does a "git gc" may get a very unpleasant
> > surprise.
>
> It can also cause things like the "please repack" warning in git gui
> to go off.  This is especially unhelpful since they tend to tell you
> to go and do a gc to resolve the problem.

Instead of exploding all unreachable objects into loose objects, does it 
make sense to repack them into a separate pack? AFAICS, that would 
solve both the disk usage problem and the git-gui-"please repack" 
problem. Also, it might make git-prune's job much easier, since 
unreachable objects are now located in a single pack only?


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net

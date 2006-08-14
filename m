From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Compression and dictionaries
Date: Mon, 14 Aug 2006 16:45:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608141641330.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910608132037t4297c3bbq9b0cd6ebaa03b979@mail.gmail.com> 
 <Pine.LNX.4.63.0608141415560.10541@wbgn013.biozentrum.uni-wuerzburg.de>
 <9e4733910608140708i45e3d6day6b87676783fd6511@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 14 16:46:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCdhE-0007sw-Gp
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 16:45:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbWHNOph (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 10:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWHNOph
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 10:45:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:21996 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932378AbWHNOpg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Aug 2006 10:45:36 -0400
Received: (qmail invoked by alias); 14 Aug 2006 14:45:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 14 Aug 2006 16:45:34 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910608140708i45e3d6day6b87676783fd6511@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25357>

Hi,

On Mon, 14 Aug 2006, Jon Smirl wrote:

> Does a zlib dictionary just changes the probabilities in the histogram 
> or does it turn the dictionary into a pre-loaded encoding tree?

I have to admit that I do not know zlib well enough to tell off the top of 
my head, but I guess it would make more sense to have it as a preloaded 
encoding tree.

> The other compression schemes I looked at let you load in a
> precomputed huffman/arithmetic encoding tree. By preloading an
> encoding tree you avoid storing the encoding of "void => 010101' in
> every  item. Removing 1M encoding maps and using one common one should
> be a win. Items not in the map would still be stored using internal
> additions to the map.
> 
> Changing the probabilities probably won't help much, but there may be
> good gains from partially eliminating 1M encoding maps.

I _think_ that it would not matter much. The deltas have a more important 
impact.

> > Further, if the pack-file becomes corrupt, you usually still have the 
> > pack index, or the start of the pack-file, and can reconstruct most of 
> > the objects. If you use a dictionary, and just one bit flips in it, 
> > you're screwed.

I still think that this is important to think through: Is it worth a 
couple of kilobytes (I doubt that it would be as much as 1MB in _total_), 
and be on the unsafe side?

Ciao,
Dscho

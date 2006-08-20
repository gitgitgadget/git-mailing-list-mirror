From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Object hash (was: Re: [ANNOUNCE] git-rev-size: calculate sizes of repository)
Date: Sun, 20 Aug 2006 20:41:19 +0200
Message-ID: <200608202041.19644.Josef.Weidendorfer@gmx.de>
References: <20060820105452.GA19630@nospam.com> <200608201837.33577.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.63.0608201846110.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 20 20:41:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEsEf-00011G-Uh
	for gcvg-git@gmane.org; Sun, 20 Aug 2006 20:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWHTSlX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Aug 2006 14:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWHTSlX
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Aug 2006 14:41:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:53730 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751137AbWHTSlW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Aug 2006 14:41:22 -0400
Received: (qmail invoked by alias); 20 Aug 2006 18:41:20 -0000
Received: from p5496A45F.dip0.t-ipconnect.de (EHLO noname) [84.150.164.95]
  by mail.gmx.net (mp003) with SMTP; 20 Aug 2006 20:41:20 +0200
X-Authenticated: #352111
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0608201846110.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25762>

On Sunday 20 August 2006 18:51, Johannes Schindelin wrote:
> > > +static unsigned int hash_index(struct hash_map *hash, const char *sha1)
> > > +{
> > > +	unsigned int index = *(unsigned int *)sha1;
> > 
> > If you have the same SHA1, stored at different addresses, you get different
> > indexes for the same SHA1. Index probably should be calculated from the
> > SHA1 string.
> 
> Actually, it does! "*(unsigned int *)sha1" means that the first 4 bytes 
> of the sha1 are interpreted as a number.

Ah, yes. That's fine.

> > > +void hash_put(struct hash_map *hash, struct object *obj)
> > > +{
> > > +	if (++hash->nr > hash->alloc / 2)
> > > +		grow_hash(hash);
> > 
> > If you insert the same object multiple times, hash->nr will get too big.
> 
> First, you cannot put the same object multiple times. That is not what a  
> hash does (at least in this case): it stores unique objects (identified by 
> their sha1 in this case).

I put it the wrong way; I should have said "if you call hash_put() multiple
times with the same object". You get the same index, and nothing should
change. However, you still increment hash->nr, but this error is not really
important as you correct it in grow_hash().

So... sorry for the noise ;-)

Josef

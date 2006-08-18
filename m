From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] adding support for md5
Date: Fri, 18 Aug 2006 12:21:11 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608181209210.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0608172259280.25827@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 12:21:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE1Tl-0008TR-S7
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 12:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWHRKVO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 06:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWHRKVO
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 06:21:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:14030 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751346AbWHRKVN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Aug 2006 06:21:13 -0400
Received: (qmail invoked by alias); 18 Aug 2006 10:21:11 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp018) with SMTP; 18 Aug 2006 12:21:11 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: David Rientjes <rientjes@google.com>
In-Reply-To: <Pine.LNX.4.63.0608172259280.25827@chino.corp.google.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25644>

Hi,

On Thu, 17 Aug 2006, David Rientjes wrote:

> I'd like to solicit some comments about implementing support for md5 as a 
> hash function that could be determined at runtime by the user during a 
> project init-db.

Make it a config variable, too, right?

It would be interesting to have other hashes, for three reasons:

1. they could be faster to calculate,
2. they could reduce clashes, and related to that,
3. it is possible that some day SHA1 is broken, i.e. that there is an 
   algorithm to generate a different text for a given hash.

As for 2 and 3, it seems MD5 is equivalent, since another sort of attacks 
was already successful on both SHA1 and MD5: generating two different 
texts with the same hash.

So, 1 could be a good reason to have another hash. IIRC SHA1 is about 25% 
slower than MD5, so it could be worth it.

However, you should know that there is _no way_ to use both hashes on the 
same project. Yes, you could rewrite the history, trying to convert also 
the hashes in the commit objects, but people actually started relying on 
naming commits with the short-SHA1.

I think it would be a nice thing to play through (for example, to find 
out how much impact the hash calculation has on the overall performance 
of git), but I doubt it will ever come to real use.

Ciao,
Dscho

From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Object hash (was: Re: [ANNOUNCE] git-rev-size: calculate sizes of repository)
Date: Sun, 20 Aug 2006 18:37:33 +0200
Message-ID: <200608201837.33577.Josef.Weidendorfer@gmx.de>
References: <20060820105452.GA19630@nospam.com> <20060820152404.GA5679@nospam.com> <Pine.LNX.4.63.0608201805070.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Rutger Nijlunsing <git@wingding.demon.nl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 20 18:37:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEqIx-0002Nf-SF
	for gcvg-git@gmane.org; Sun, 20 Aug 2006 18:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWHTQhi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Aug 2006 12:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbWHTQhi
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Aug 2006 12:37:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:47793 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750834AbWHTQhh (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Aug 2006 12:37:37 -0400
Received: (qmail invoked by alias); 20 Aug 2006 16:37:35 -0000
Received: from p5496A45F.dip0.t-ipconnect.de (EHLO noname) [84.150.164.95]
  by mail.gmx.net (mp023) with SMTP; 20 Aug 2006 18:37:35 +0200
X-Authenticated: #352111
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0608201805070.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25756>

On Sunday 20 August 2006 18:09, Johannes Schindelin wrote:
Hi,

> Most notably, it adds an object hash map structure to the library.

Aside from the given command of this thread, this is interesting
(even more interesting would be a persistent cache for arbitrary object data).
As this could be used in other contexts, some general comments:

> +static unsigned int hash_index(struct hash_map *hash, const char *sha1)
> +{
> +	unsigned int index = *(unsigned int *)sha1;

If you have the same SHA1, stored at different addresses, you get different
indexes for the same SHA1. Index probably should be calculated from the
SHA1 string.

> +void hash_put(struct hash_map *hash, struct object *obj)
> +{
> +	if (++hash->nr > hash->alloc / 2)
> +		grow_hash(hash);

If you insert the same object multiple times, hash->nr will get too big.

Josef

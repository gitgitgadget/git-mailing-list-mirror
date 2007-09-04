From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Rework strbuf API and semantics.
Date: Tue, 4 Sep 2007 12:11:45 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709041209280.28586@racer.site>
References: <buobqcjrycl.fsf@dhapc248.dev.necel.com>
 <11888956802504-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Sep 04 13:12:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISWKM-0000Fp-FX
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 13:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753027AbXIDLL7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 07:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752997AbXIDLL7
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 07:11:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:42499 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752931AbXIDLL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 07:11:58 -0400
Received: (qmail invoked by alias); 04 Sep 2007 11:11:57 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp049) with SMTP; 04 Sep 2007 13:11:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+hxNoJQG2hwDqi44B4n7/qnYGzp0TVDtLjwvns+9
	3tLiXyIKSu5xdZ
X-X-Sender: gene099@racer.site
In-Reply-To: <11888956802504-git-send-email-madcoder@debian.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57551>

Hi,

On Tue, 4 Sep 2007, Pierre Habouzit wrote:

>   A strbuf can be used to store byte arrays, or as an extended string 
> library. The `buf' member can be passed to any C legacy string function, 
> because strbuf operations always ensure there is a terminating \0 at the 
> end of the buffer, not accounted in the `len' field of the structure.
> 
>   A strbuf can be used to generate a string/buffer whose final size is 
> not really known, and then "strbuf_detach" can be used to get the built 
> buffer, and keep the wrapping "strbuf" structure usable for further work 
> again.
> 
>   Other interesting feature: buffer_ensure(sb, size) ensure that there 
> is enough allocated space in `sb' to put `size' new octets of data in 
> the buffer. It helps avoiding reallocating data for nothing when the 
> problem the strbuf helps to solve has a known typical size.

I like the general idea of this!

However, some comments are due:

- IMHO strbuf_grow() would be more descriptive than buffer_ensure(),

- IMHO the same goes for strbuf_free() instead of strbuf_wipe(), and

- it would be nice to split this patch into

	- the API change (with _minimal_ changes to anything outside of 
	  strbuf.[ch]), and

	- the cleanups in the rest of the code.

Ciao,
Dscho

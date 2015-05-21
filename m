From: Philippe De Muyter <phdm@macq.eu>
Subject: Re: identical hashes on two branches, but holes in git log
Date: Thu, 21 May 2015 09:05:23 +0200
Message-ID: <20150521070523.GA8026@frolo.macqel>
References: <20150519132958.GA21130@frolo.macqel> <20150519233925.GA22748@peff.net> <20150520131359.GA7043@frolo.macqel> <20150520132534.GI10518@serenity.lan> <20150520141238.GA13990@frolo.macqel> <20150520161815.GA12521@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 21 09:05:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvKXt-0004qP-FH
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 09:05:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752915AbbEUHF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 03:05:29 -0400
Received: from smtp2.macqel.be ([109.135.2.61]:63239 "EHLO smtp2.macqel.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751656AbbEUHF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 03:05:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp2.macqel.be (Postfix) with ESMTP id C8AA2130CBF;
	Thu, 21 May 2015 09:05:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at macqel.be
Received: from smtp2.macqel.be ([127.0.0.1])
	by localhost (mail.macqel.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fFjJqh0Vvohm; Thu, 21 May 2015 09:05:24 +0200 (CEST)
Received: from frolo.macqel.be (frolo.macqel [10.1.40.73])
	by smtp2.macqel.be (Postfix) with ESMTP id 2D4B1130DAD;
	Thu, 21 May 2015 09:05:24 +0200 (CEST)
Received: by frolo.macqel.be (Postfix, from userid 1000)
	id 12E39DF06BF; Thu, 21 May 2015 09:05:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150520161815.GA12521@peff.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269563>

On Wed, May 20, 2015 at 12:18:15PM -0400, Jeff King wrote:
> On Wed, May 20, 2015 at 04:12:38PM +0200, Philippe De Muyter wrote:
> 
> > After reading the man page of 'git log', should --topo-order not be the
> > default log order ?
> 
> The problem with --topo-order is that it has to traverse all of the
> commits before starting output. So:
> 
>   $ time git log | head -1
>   commit 64fb1d0e975e92e012802d371e417266d6531676
> 
>   real    0m0.038s
>   user    0m0.032s
>   sys     0m0.008s
> 
>   $ time git log --topo-order | head -1
>   commit 64fb1d0e975e92e012802d371e417266d6531676
> 
>   real    0m4.247s
>   user    0m4.140s
>   sys     0m0.108s
> 
> -Peff

So we trade correctness for speed :(

Is there a way to set topo-order as the default log order via git config ?

Is topo-order already implemented as starting with the default order followed
by an ancestor check or does it switch immediately to topological sort ?

Philippe

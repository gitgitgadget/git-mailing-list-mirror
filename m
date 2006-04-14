From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Default remote branch for local branch
Date: Fri, 14 Apr 2006 20:26:43 +0200
Message-ID: <200604142026.44070.Josef.Weidendorfer@gmx.de>
References: <1143856098.3555.48.camel@dv> <200604021817.30222.Josef.Weidendorfer@gmx.de> <20060414161627.GA27689@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 14 20:26:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUT0M-0005SK-JN
	for gcvg-git@gmane.org; Fri, 14 Apr 2006 20:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWDNS0s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Apr 2006 14:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWDNS0s
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Apr 2006 14:26:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:20907 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751388AbWDNS0r (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Apr 2006 14:26:47 -0400
Received: (qmail invoked by alias); 14 Apr 2006 18:26:46 -0000
Received: from p5496B49F.dip0.t-ipconnect.de (EHLO linux) [84.150.180.159]
  by mail.gmx.net (mp001) with SMTP; 14 Apr 2006 20:26:46 +0200
X-Authenticated: #352111
To: Petr Baudis <pasky@suse.cz>
User-Agent: KMail/1.9.1
In-Reply-To: <20060414161627.GA27689@pasky.or.cz>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18694>

On Friday 14 April 2006 18:16, you wrote:
> Dear diary, on Sun, Apr 02, 2006 at 06:17:29PM CEST, I got a letter
> where Josef Weidendorfer <Josef.Weidendorfer@gmx.de> said that...
> > > I would write the config like this:
> > > 
> > > [branch-upstream]
> > > master = linus
> > > ata-irq-pio = irq-pio
> > > ata-pata = pata-drivers
> > 
> > That is not working, as said above. But with above syntax extension,
> > with s/=/for/ it would be fine.
> 
> I'm sorry but I'm slow and I don't see it - why wouldn't this work?
> (Except that the key name is case insensitive, which isn't too big a
> deal IMHO.)

Hmm...
* IMHO "keys are case insensitive" is enough to not qualify for branch
names: currently, branch names are case sensitive, and with above syntax you
effectively change this rule (you can not distinguish upstreams for "master"
vs. "MASTER").
* a dot currently seems to be allowed in branch names. For config keys, the
dot separates subkeys.
* I thought it is a convention for config keys to be alphanum only,
eg. "/" isn't allowed, too (which is mandatory for branch names).
Unfortunately, I found nothing about allowed chars for config keys in the
documentation.
 
> I for one think that the 'for'-syntax is insane - it's unreadable (your
> primary query is by far most likely to be "what's the upstream when on
> branch X", not "what branches is this upstream for"), would convolute
> the configuration file syntax unnecessarily and would possibly also
> complicate the git-repo-config interface.

As far as I remember, the "... for ..." syntax was suggested by Linus for the
proxy.command config a long time ago. The original proposal there was to
use an URL as key part (as far as I can remember).

That said,

> Pavel's syntax is much nicer. 

... I agree with you here.

My suggestion would be to allow an optional syntax in the config file which is mapped
by git-repo-config to the normalized "... for ..."-scheme.
Eg. it should not be mandatory to specify "for ..." after the value of a key.
So instead of

  branch.upstream = linus for master

you should be able to say

  [branch]
  upstream for master = linus


Josef

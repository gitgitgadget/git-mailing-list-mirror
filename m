From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] diff: resurrect the traditional empty "diff --git" behaviour
Date: Fri, 31 Aug 2007 15:37:56 -0700
Message-ID: <46D89844.8050605@midwinter.com>
References: <20070830063810.GD16312@mellanox.co.il>	<7v7inda5ar.fsf@gitster.siamese.dyndns.org>	<20070830072748.GF16312@mellanox.co.il>	<7vmyw85uml.fsf@gitster.siamese.dyndns.org>	<20070831080651.GA17637@mellanox.co.il>	<7vabs82kcq.fsf@gitster.siamese.dyndns.org>	<20070831081517.GB17637@mellanox.co.il>	<7v4pig2j91.fsf@gitster.siamese.dyndns.org>	<20070831152120.GC17637@mellanox.co.il>	<7vr6lj1zg3.fsf@gitster.siamese.dyndns.org>	<20070831160335.GA17761@coredump.intra.peff.net> <7vtzqfzcll.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 01 00:38:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRF7q-0002Tf-NH
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 00:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754968AbXHaWh6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 18:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754933AbXHaWh6
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 18:37:58 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:38760 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1754898AbXHaWh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 18:37:57 -0400
Received: (qmail 22624 invoked from network); 31 Aug 2007 22:37:57 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=tyoyoU/DjHsXmn76jmFn2uqw9Wrms4dgW3JelszNWZw6mIceU/AXFmAWj6wXWVFc  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 31 Aug 2007 22:37:57 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <7vtzqfzcll.fsf_-_@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57229>

Junio C Hamano wrote:
> This commit reinstates the traditional behaviour as the default,
> but with a twist.
>
> If you set diff.autorefreshindex configuration variable, it
> squelches the empty "diff --git" output, and at the end of the
> command, it automatically runs "update-index --refresh" without
> even bothering the user.  In other words, with the configuration
> variable set, people who do not care about the cache-dirtyness
> do not even have to see the warning.
>   

As the person who submitted the patch you're reversing with this, I 
agree 100% this is the better approach. Having the system self-heal is 
far preferable to requiring user action.

I would vote for reversing the sense of that config variable, actually: 
my guess is that most users, especially new ones who won't necessarily 
know about the config variable, would rather have git just keep itself 
healthy without user intervention. Having to manually update the index 
is (by virtue of requiring you to run a command that you wouldn't 
otherwise need to run) a mode more suited to advanced / experienced 
users, who are more likely to already be comfortable with the idea of 
flipping config switches. Making the more novice-friendly mode require 
that you know how to set a particular configuration variable doesn't 
seem right to me.

-Steve

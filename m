From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFH] convert shortlog to use parse_options
Date: Mon, 17 Dec 2007 08:36:53 +0100
Message-ID: <47662715.9070200@op5.se>
References: <20071213091055.GA5674@coredump.intra.peff.net>	<20071213093536.GC12398@artemis.madism.org>	<7vbq8u4ho8.fsf@gitster.siamese.dyndns.org>	<20071213180347.GE1224@artemis.madism.org>	<1197570521.28742.0.camel@hinata.boston.redhat.com>	<1197571656.28742.13.camel@hinata.boston.redhat.com>	<20071214040803.GA10169@sigill.intra.peff.net>	<7vir31vmsn.fsf@gitster.siamese.dyndns.org>	<20071214083943.GA24475@artemis.madism.org>	<7v63z1qakt.fsf@gitster.siamese.dyndns.org>	<20071215110311.GA11321@artemis.madism.org> <7vir2xeq76.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>, Jeff King <peff@peff.net>,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 08:37:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4AXR-00025m-67
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 08:37:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757409AbXLQHg7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 02:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbXLQHg7
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 02:36:59 -0500
Received: from mail.op5.se ([193.201.96.20]:37134 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751228AbXLQHg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 02:36:58 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id E6E911F08038;
	Mon, 17 Dec 2007 08:36:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hydYxdOuVEux; Mon, 17 Dec 2007 08:36:56 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 320E61F08033;
	Mon, 17 Dec 2007 08:36:54 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <7vir2xeq76.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68511>

Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
> 
>>   Yep, let's do it then. Note that's the reason why I felt we need a
>> manual page about this, because we should give some guidelines of what
>> is safe for scripting.
> 
> There are some fallouts from the series, though.  I've fixed up git-tag
> but I strongly suspect all of parseopt users now need careful auditing.
> If we cannot be confident with the parseoptified commands within
> reasonably short timeframe by -rc1, we may end up having to revert the
> parseopt changes from them, which I'd rather avoid, but if you look at
> the git-tag change (especially for -l) you would understand it.  The
> "must stick" restriction feels Ok on paper but in practice it looks
> rather draconian and very user unfriendly.
> 

Usually, optional arguments warrant adding a second parameter. This can
often even improve usability, as it's never unclear or ambiguous what's
happening. For the 'git tag -l' case, I'd use something like
'git tag -l --match="regex"' or some such, or perhaps make "-l" its own
subcommand ("list") with a built-in alias of -l. That means "-l" has to
be the first argument after "git tag" on the command-line, but I suspect
it doesn't make much sense to use it along with other options anyway, so
perhaps that's not much of an issue.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

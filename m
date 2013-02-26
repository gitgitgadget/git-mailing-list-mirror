From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] pkt-line: Fix sparse errors and warnings
Date: Tue, 26 Feb 2013 19:02:59 +0000
Message-ID: <512D06E3.5020109@ramsay1.demon.co.uk>
References: <51290DF4.4040309@ramsay1.demon.co.uk> <20130223223134.GA2504@sigill.intra.peff.net> <20130223223700.GB2504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 26 20:08:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAPsu-0004CI-68
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 20:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759602Ab3BZTHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 14:07:48 -0500
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:46534 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754791Ab3BZTHl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 14:07:41 -0500
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 55152384086;
	Tue, 26 Feb 2013 19:07:40 +0000 (GMT)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 8774B384081;	Tue, 26 Feb 2013 19:07:39 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;	Tue, 26 Feb 2013 19:07:38 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <20130223223700.GB2504@sigill.intra.peff.net>
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217160>

Jeff King wrote:
> On Sat, Feb 23, 2013 at 05:31:34PM -0500, Jeff King wrote:
> 
>> On Sat, Feb 23, 2013 at 06:44:04PM +0000, Ramsay Jones wrote:
>>
>>> Sparse issues the following error and warnings:
>>>
>>>     pkt-line.c:209:51: warning: Using plain integer as NULL pointer
>>>     sideband.c:41:52: warning: Using plain integer as NULL pointer
>>>     daemon.c:615:39: warning: Using plain integer as NULL pointer
>>>     remote-curl.c:220:75: error: incompatible types for operation (>)
>>>     remote-curl.c:220:75:    left side has type char *
>>>     remote-curl.c:220:75:    right side has type int
>>>     remote-curl.c:291:53: warning: Using plain integer as NULL pointer
>>>     remote-curl.c:408:43: warning: Using plain integer as NULL pointer
>>>     remote-curl.c:562:47: warning: Using plain integer as NULL pointer
>>>
>>> All of these complaints "blame" to commit 17243606 ("pkt-line: share
>>> buffer/descriptor reading implementation", 20-02-2013).
>>>
>>> In order to suppress the warnings, we simply replace the integer
>>> constant 0 with NULL.
>> [...]
>> Oddly, you seemed to miss the one in connect.c (which my sparse does
>> detect).
> 
> Ah, I saw why as soon as I finished off the rebase: that (NULL, 0) goes
> away in the very next patch, and you probably ran sparse just on the tip
> of the topic (via pu). 

Yes, sorry I should have mentioned that! Ahem, *blush* [Having created and
tested the patch (including running "make test") on the tip of pu, I applied
the patch directly to commit 17243606 (using git-am). Since it applied
cleanly and git-show looked OK, I said to myself "yep, that's OK, send it" ;-) ]

>                         I still think it's worth fixing since we are
> squashing anyway. Junio, it will give you a trivial conflict on patch
> 16, but you can just resolve in favor of what patch 16 does. If it's
> easier, here's the revised patch 16:

So, sorry for being a bit sloppy guys!

ATB,
Ramsay Jones

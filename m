From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] format-patch: Use --mbox by default.
Date: Mon, 09 Jan 2006 03:01:30 +0100
Message-ID: <43C1C3FA.8070609@op5.se>
References: <20060108140109.909925BE8D@nox.op5.se> <7vhd8ezcol.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 09 03:01:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvmLp-0007JV-4r
	for gcvg-git@gmane.org; Mon, 09 Jan 2006 03:01:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215AbWAICBd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jan 2006 21:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbWAICBc
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jan 2006 21:01:32 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:43653 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751512AbWAICBc
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 8 Jan 2006 21:01:32 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 0D70E6BCBE; Mon,  9 Jan 2006 03:01:31 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhd8ezcol.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14346>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
> 
>>This patch enables a slightly modified and more correct --mbox
>>output by default. The --date, --author and --mbox options
>>are obsoleted and removed.
> 
> 
> I always use format-patch with -k -m (or -k --stdout), so I have
> no objections to making --mbox the default.  I do not think
> anybody uses --date or --author in their scripts, but removing
> the --mbox option _might_ break things for people's scripts.
> Maybe it is worthwhile to keep it as a no-op option for a while.
> 

The reworked patch (which works for sending patches to myself, so far), 
prints a warning to stderr that a deprecated option is used and then 
silently ignores it.

> 
>>The patches generated also had bad mail headers for sendmail (of
>>postfix 2.2.2 at least) to use directly (From: line must be on top,
>>Subject: last of header),...
> 
> 
> I do not think RFC2822 specifies that.  See "3.6 Field
> definitions", third paragraph, first two sentences.
> 
> In that sense, technically they are not "bad mail headers", but
> at the same time, since it is valid in any order, if _one_
> popular MTA is unconfortable with a particular ordering, we
> could order things differently to make it happier (mind you,
> this would not work for more than one such broken MTAs).
> 


The only thing I've seen break is if Subject: is placed on top. It's 
easier, script-wise, to put it last and that seems to work with qmail 
and postfix both.


> Another thing I've been considering is to handle UTF-8 (or
> i18n.commitencoding in general) a bit better.  We currently do
> not have Content-Type: header, so if you pipe the output to
> "am", it must be invoked without "-u" to make sure that it takes
> things as-is ("am -u" assumes things are in latin1 without
> Content-Type:).  If we start to tackle that issue, we might also
> want to do RFC2047 in headers.
> 
> 

You'll have to ask someone else for that. I have no idea how it works 
and I wouldn't know how to begin doing it in shell.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

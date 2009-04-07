From: Andreas Ericsson <exon@op5.com>
Subject: Re: [PATCH RFC 1/6] Re: send-email: Add --delay for separating emails
Date: Wed, 08 Apr 2009 00:17:54 +0200
Message-ID: <49DBD112.5000705@op5.se>
References: <1239139522-24118-1-git-send-email-mfwitten@gmail.com> <20090407215143.GA18144@coredump.intra.peff.net> <20090407220854.GA12908@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Michael Witten <mfwitten@gmail.com>,
	git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
X-From: git-owner@vger.kernel.org Wed Apr 08 00:19:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrJdk-0003IC-Ig
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 00:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbZDGWSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 18:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760042AbZDGWR7
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 18:17:59 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:51482 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759954AbZDGWR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 18:17:58 -0400
Received: by fxm2 with SMTP id 2so2542557fxm.37
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 15:17:56 -0700 (PDT)
Received: by 10.86.95.8 with SMTP id s8mr532058fgb.36.1239142675899;
        Tue, 07 Apr 2009 15:17:55 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.163.94])
        by mx.google.com with ESMTPS id l19sm1442183fgb.16.2009.04.07.15.17.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Apr 2009 15:17:55 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090407220854.GA12908@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116004>

Nicolas Sebrecht wrote:
> On Tue, Apr 07, 2009 at 05:51:43PM -0400, Jeff King wrote:
> 
>>> When sending a patch series, the emails often arrive at the final
>>> destination out of order; though these emails should be chained
>>> via the In-Reply-To headers, some mail-viewing systems display
>>> by order of arrival instead.
>>>
>>> The --delay option provides a means for specifying that there
>>> should be a certain number of seconds of delay between sending
>>> emails, so that the arrival order can be controlled better.
>>>
>>> Signed-off-by: Michael Witten <mfwitten@gmail.com>
> 
>> I think it may still be reasonable to implement a solution that only
>> covers some of the cases, but I what I am asking is if we know what
>> percentage of the cases that is. If we are preventing only 1% of
>> out-of-order deliveries with this, I question whether it is worth the
>> bother.
> 
> IMHO, this improvement is broken by design. We try to fix a
> receiver-only issue by a sender side fix.
> 
> If the receiver wants the patch series be in a good ordered _for sure_, he
> has to switch to a client mail supporting the In-Reply-To chains.
> 

The biggest problem with in-reply-to chains is that they're absolutely
horrible for patch-series of more than five or so messages. The "worst"
one this week was a series of 14 patches, I believe. If any of the
deeper nested patches gets any sort of commentary, it usually eats so
much horizontal screen estate that it becomes hopeless to actually
find anything.

Besides that, most mua's I've worked with list emails in a thread
like this:

 First
  +------ second
  |         +------ third
  |         |
  |         +---- reply to second
  |                 +
  |                 |
  |                 + reply to reply to second
  |
  +-- reply to first

etc. etc, but when asked for "next unread message in thread", they
jump to the *deepest* message in the thread first, so you end up
reading the replies to the patches in the wrong order anyway.

For those two reasons, I absolutely loathe deeply nested
in-reply-to chains.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.

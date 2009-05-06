From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] 64-bit fix for date.c.
Date: Tue, 05 May 2009 22:51:43 -0700
Message-ID: <7vvdoeye1c.fsf@alter.siamese.dyndns.org>
References: <20090406172637.GA17437@jenna.bytemine.net>
	<20090406190657.GC28120@coredump.intra.peff.net>
	<20090504142614.GE8658@jenna.bytemine.net>
	<20090504143112.GA14214@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bernd Ahlers <bernd@ba-net.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 06 07:51:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1a2q-0004f5-2L
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 07:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbZEFFvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 01:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbZEFFvo
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 01:51:44 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:40885 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131AbZEFFvn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 01:51:43 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090506055145.LATG20976.fed1rmmtao102.cox.net@fed1rmimpo03.cox.net>;
          Wed, 6 May 2009 01:51:45 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id o5rj1b0094aMwMQ045rj5e; Wed, 06 May 2009 01:51:43 -0400
X-Authority-Analysis: v=1.0 c=1 a=djCEkewo4IcA:10 a=PKzvZo6CAAAA:8
 a=vOVq3bzyF2JzJJtH1KEA:9 a=WCZ9_0EsjMJSQfZ8ekYeiRagZxUA:4 a=OdWmie4EkE0A:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118323>

Jeff King <peff@peff.net> writes:

> On Mon, May 04, 2009 at 04:26:14PM +0200, Bernd Ahlers wrote:
>
>> Jeff King [Mon, Apr 06, 2009 at 03:06:58PM -0400] wrote:
>> >On Mon, Apr 06, 2009 at 07:26:37PM +0200, Bernd Ahlers wrote:
>> >
>> >> @@ -871,13 +871,15 @@ unsigned long approxidate(const char *date)
>> >>  	struct timeval tv;
>> >> +	time_t time_sec;
>> >> [...]
>> >>  	gettimeofday(&tv, NULL);
>> >> -	localtime_r(&tv.tv_sec, &tm);
>> >> +	time_sec = tv.tv_sec;
>> >> +	localtime_r(&time_sec, &tm);
>> >
>> >Hmph. According to POSIX, tv_sec _is_ a time_t. But I see on FreeBSD,
>> >also, it is actually a "long". So I think this fix makes sense.
>> >
>> Okay. So what's the next step to get this committed? :)
>
> Looks like Junio missed it the first time around, so re-send it to him,
> cc'ing the list. And you can add my
>
>   Acked-by: Jeff King <peff@peff.net>

Thanks.

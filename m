From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] Cygwin has trustable filemode
Date: Sat, 20 Jul 2013 21:12:11 +0100
Message-ID: <51EAEF1B.6090300@ramsay1.demon.co.uk>
References: <1373818390-14451-1-git-send-email-mlevedahl@gmail.com> <1374245631-15955-1-git-send-email-mlevedahl@gmail.com> <7vtxjqwlj2.fsf@alter.siamese.dyndns.org> <51E982D0.5040505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 20 22:19:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0dcZ-0001cT-GY
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 22:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754903Ab3GTUTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jul 2013 16:19:12 -0400
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:43061 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754860Ab3GTUTL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jul 2013 16:19:11 -0400
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id C0779A6484A;
	Sat, 20 Jul 2013 21:19:09 +0100 (BST)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id C3E38A6483E;
	Sat, 20 Jul 2013 21:19:07 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;
	Sat, 20 Jul 2013 21:19:02 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <51E982D0.5040505@gmail.com>
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230909>

Mark Levedahl wrote:
> On 07/19/2013 12:40 PM, Junio C Hamano wrote:
>> Thanks, will replace.
>>
>> What do we want to do with the compat/regex build-time switch?
>>
>> IIRC, this was only needed for 1.7 and not 1.5, and I also would
>> expect (without anything to back-up, so this is more a faith than
>> expectation) over time the "new library" would have a working regex
>> library.
>>
> 
> The situation is that Cygwin uses newlib rather than glibc, and does so 
> for licesnsing reasons (redhat sells licenses to developers allowing 
> closed source applications built using Cygwin). So, there must be a 
> compelling need to fix the library - git has a simple work around, so 
> isn't the case. Also, Cygwin has a perl regex library for those 
> demanding more complete / correct regex solution. So, I make no 
> prediction on when the newlib regex functions are fixed.
> 
> Related: Should we have separate settings for 1.5 and 1.7 for several 
> variables?

We already do.

>               Conflicts I see not reflected in config.mak.uname on pu:
>      trustable filemode   (1.7 has, 1.5 does not)

I see no need for any difference here. puzzled.

>      MMAP/Pread (1.7 pread is thread safe, 1.5 I dont think was, MMAP 
> utility is convolved in this)

pread() is now thread-safe? great! (It must have been a fairly recent
change; last time I looked it was still not thread-safe on 1.7.)

>      regex - 1.7 is broken, per Ramsay 1.5 works

I don't see any reason not to use the compat/regex routines on both
cygwin 1.5 and 1.7.  However, I wouldn't object to restricting the use
of the compat routines to cygwin 1.7 either!

> If you think its worth it, I'll create a patch series with the above and 
> justifications for the different settings that I know.

As far as I can see, only the pread() and maybe MMAP and regex setting
need to change from the current setup.

ATB,
Ramsay Jones

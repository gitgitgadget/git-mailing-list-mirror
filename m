From: Andreas Ericsson <ae@op5.se>
Subject: Re: Possible regression in git-rev-list --header
Date: Thu, 04 Jan 2007 16:18:23 +0100
Message-ID: <459D1ABF.8010500@op5.se>
References: <e5bfff550612300956mef4691fqf607fad173c571da@mail.gmail.com>	 <7vlkkphvrb.fsf@assigned-by-dhcp.cox.net>	 <Pine.LNX.4.63.0612310211300.25709@wbgn013.biozentrum.uni-wuerzburg.de>	 <7v64bsj0s4.fsf@assigned-by-dhcp.cox.net>	 <e5bfff550612310345j4c882b7av51879ca1175a1c6b@mail.gmail.com>	 <Pine.LNX.4.63.0612311613180.22628@wbgn013.biozentrum.uni-wuerzburg.de>	 <e5bfff550612310743t4ca1b017ubceddffafd06ac59@mail.gmail.com>	 <7vodpja0u8.fsf@assigned-by-dhcp.cox.net>	 <e5bfff550701030121n700fab25x63278457c884a3f7@mail.gmail.com>	 <8c5c35580701030221w5c04e2eaq757d12c4ca0b0780@mail.gmail.com> <e5bfff550701030235g6f26044h8dd73e8abe1ec9e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Lars Hjemli <hjemli@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 04 16:18:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2UMP-0002cs-NU
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 16:18:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbXADPS0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 10:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbXADPSZ
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 10:18:25 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:54550 "EHLO
	smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964893AbXADPSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 10:18:25 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 9E8AD6BCC2; Thu,  4 Jan 2007 16:18:23 +0100 (CET)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550701030235g6f26044h8dd73e8abe1ec9e3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35932>

Marco Costalba wrote:
> On 1/3/07, Lars Hjemli <hjemli@gmail.com> wrote:
>> On 1/3/07, Marco Costalba <mcostalba@gmail.com> wrote:
>> >         - one blank line
>> >         - zero or one line with log title
>> >         - zero or more lines with log message
>> >         - a terminating '\0'
>>
>> I think the should be:
>>   -zero or more blank lines
> 
> Isn't it zero or _one_ blank line? Why more then one? would be it
> useful? surely is slower to parse.
> 

I've imported a repository from CVS to git (the nagiosplugin repo), 
where one author consistently put an empty line before the "commit 
subject". I'm fairly certain this is done by the tool he uses (some GUI 
thing, no doubt).

I'm currently looking into stripping optional empty lines appearing 
postheaders-prebody from rev-list output, as it completely fudges qgit 
and gitk viewing alike. Good thing the author in question only does 
translations and no code work, or I'd be screaming with frustration 
trying to figure out which commit does what. Mind you, CVS's lack of 
forensic tools doesn't exactly inspire the clear and concise commit 
messages we see in git, but still...


>>   -zero or more non-blank lines with log title
> 
> multi lines titles are allowed? never saw one of them.
> 

They aren't disallowed. The log message part only by convention consists 
of a title line followed by a blank and then the message body. It's 
entirely possible to just start writing the message straight off, or put 
any number of blank lines wherever.

>>   -zero or more blank lines
> 
> Why? this is necessary only to disambiguate muti (non blank) lines
> titles, but as Junio pointed out distinction between log title and log
> message is only in the Porcelain, not encoded in git. So the Porcalain
> is going to show _one_line title if any an the remaining stuff in the
> log message.
> 

Sensible. There's no (reliable) way of knowing if the first line with 
text on is actually a title or just the start of a 25-line sentence, or 
even the signoff line, or completely empty.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

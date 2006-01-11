From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 2/2] Remember and use GIT_EXEC_PATH on exec()'s
Date: Wed, 11 Jan 2006 01:10:26 +0100
Message-ID: <43C44CF2.5050808@op5.se>
References: <1136849678.11717.514.camel@brick.watson.ibm.com>  <1136849810.11717.518.camel@brick.watson.ibm.com>  <7vwth8bxqd.fsf@assigned-by-dhcp.cox.net>  <1136900174.11717.537.camel@brick.watson.ibm.com> <43C3CC4A.4030805@op5.se>  <1136910406.11717.579.camel@brick.watson.ibm.com>  <7vzmm36f1x.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.63.0601102054200.27363@wbgn013.biozentrum.uni-wuerzburg.de> <1136925066.11717.605.camel@brick.watson.ibm.com> <Pine.LNX.4.63.0601102200040.31923@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jan 11 01:10:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwTZP-00032o-Aa
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 01:10:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161004AbWAKAK2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 19:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161000AbWAKAK2
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 19:10:28 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:14741 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1161004AbWAKAK1
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2006 19:10:27 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 5CC9C6BD03
	for <git@vger.kernel.org>; Wed, 11 Jan 2006 01:10:26 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0601102200040.31923@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14467>

Johannes Schindelin wrote:
>>>>>git programs exec other git programs, but they also exec non-git
>>>>>programs.  I think it is not appropriate to change PATH (via
>>>>>prepend_to_path) because this may result in unexpected behavior when
>>>>>exec'ing non-git programs:
>>>>
>>>>This is a valid concern.
>>>
>>>Why? If what is prepended to PATH only contains git programs?
>>>
>>
>>
>>If git is installed with prefix=/usr, then that won't be the case.
> 
> 
> Okay, so here we have the problem: Two completely different setups. One 
> into a standard location on the PATH (which used to be the default), the 
> other with a libexec/ directory (which some want in the future). And a git 
> wrapper which makes no difference between both.
> 
> Wouldn't it make much more sense to have a switch in the Makefile, which 
> says *if* we have a libexec/ directory?


No, it wouldn't, because then we can't use a different release of the 
git-tools without re-compiling the potty.

void prepend_to_path(old_path, to_prep)
{
	if (strstr(old_path, to_prep))
		return;

	really_prepend_to_path(old_path, to_prep);
}

would work just fine though.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

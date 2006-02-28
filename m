From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 2/3] apply --whitespace: configuration option.
Date: Tue, 28 Feb 2006 10:46:45 +0100
Message-ID: <44041C05.3030103@op5.se>
References: <20060225174047.0e9a6d29.akpm@osdl.org>	<7v1wxq7psj.fsf@assigned-by-dhcp.cox.net>	<20060225210712.29b30f59.akpm@osdl.org>	<Pine.LNX.4.64.0602260925170.22647@g5.osdl.org>	<20060226103604.2d97696c.akpm@osdl.org>	<Pine.LNX.4.64.0602261213340.22647@g5.osdl.org>	<20060226202617.GH7851@redhat.com> <1141008633.7593.13.camel@homer>	<Pine.LNX.4.63.0602271004130.5937@wbgn013.biozentrum.uni-wuerzburg.de>	<20060227011832.78359f0a.akpm@osdl.org>	<7vhd6kxuea.fsf@assigned-by-dhcp.cox.net>	<7vacccuvxz.fsf@assigned-by-dhcp.cox.net> <440414D6.8050407@op5.se> <7vzmkbn7qx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 10:46:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FE1RS-0001v2-Ad
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 10:46:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbWB1Jqs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 04:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbWB1Jqr
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 04:46:47 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:57528 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750977AbWB1Jqr
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2006 04:46:47 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id D48056BD00; Tue, 28 Feb 2006 10:46:45 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmkbn7qx.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16929>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
> 
>>Junio C Hamano wrote:
>>
>>>The new configuration option apply.whitespace can take one of
>>>"warn", "error", "error-all", or "strip".  When git-apply is run
>>>to apply the patch to the index, they are used as the default
>>>value if there is no command line --whitespace option.
>>
>>I would think "warn-all" would be the logical thing, since "error"
>>either breaks out early or prints all warnings before denying the
>>patch anyway.
> 
> 
> Actually there is some thinking behind why I did not do warn-all.
> I did consider it at first but rejected.
> 
>  * If you are a busy top echelon person but cares about tree
>    cleanliness, --whitespace=error is good enough.  The patch is
>    rejected on WS basis whether it introduces one such trailing
>    WS or hundreds.  The patch is returned to the submitter and
>    the tree remains clean.
> 
>  * --whitespace=warn-all, if existed, would apply the patch
>    _anyway_, so if you notice you got warnings, and if that
>    bothers you enough that you would want to do something about
>    it, you will have to rewind the HEAD, fix up .dotest/patch
>    and reapply.  This means you are willing to clean up other
>    peoples' patches.
> 
>  * But if you are that kind of person, --whitespace=error-all is
>    a better choice for you.  Your tree stays clean and you do
>    not have to rewind.  Instead, you get all the errors you can
>    go through with your editor (e.g. Emacs users can use C-x `;
>    I hope vim users have similar macros) and fix things.
> 

Good Thinking. Thanks for explaining.

> 
> The last one is somewhat risky, and the output may need to be
> examined carefully depending on the contents (e.g. programming
> language) the project is dealing with.
> 
> 

echo Makefile >> .git/no-ws-strip
echo '*.[ch]' >> .git/ws-strip

Perhaps not viable, and probably stupid as well. Mixed content repos 
would likely just keep the 'warn' policy.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

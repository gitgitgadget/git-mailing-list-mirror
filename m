From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 1/3] remote-testsvn.c: Avoid the getline() GNU extension function
Date: Thu, 30 Aug 2012 18:25:42 +0100
Message-ID: <503FA216.8070704@ramsay1.demon.co.uk>
References: <503907B3.9040101@ramsay1.demon.co.uk> <CABPQNSZfUO-vjVmBU2+CMbxTXMj_HT=cTFfVbnehUjqOL-vkxw@mail.gmail.com> <7v3939wofb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: kusmabite@gmail.com, florian.achleitner.2.6.31@gmail.com,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 19:30:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T78Zg-0007Zy-Tl
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 19:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246Ab2H3RaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 13:30:25 -0400
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:41620 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751928Ab2H3RaX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 13:30:23 -0400
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 28AE04002B2;
	Thu, 30 Aug 2012 18:30:22 +0100 (BST)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 6B0B04002AF;	Thu, 30 Aug 2012 18:30:21 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta010.tch.inty.net (Postfix) with ESMTP;	Thu, 30 Aug 2012 18:30:20 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7v3939wofb.fsf@alter.siamese.dyndns.org>
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204557>

Junio C Hamano wrote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
> 
>> On Sat, Aug 25, 2012 at 7:13 PM, Ramsay Jones
>> <ramsay@ramsay1.demon.co.uk> wrote:
>>>
>>> The getline() function is a GNU extension (you need to define
>>> _GNU_SOURCE before including stdio.h) and is, therefore, not
>>> portable. In particular, getline() is not available on MinGW.
>>
>> Actually, getline is a POSIX-2008 feature, so it's not (simply) a GNU extension:
>>
>> http://pubs.opengroup.org/onlinepubs/9699919799/functions/getline.html
> 
> True, thanks for pointing it out.  Justify the change with something
> like this instead, perhaps?
> 
> 	The getline() function, even though is in POSIX.1-2008, is
> 	not available on some platforms.  Use strbuf_getline() for
> 	portability.
> 
> By the way, the remainder of the proposed log message talks about
> the difference between getline() that keeps the terminating LF vs
> strbuf_getline() that drops it.  Would strbuf_getwholeline() be a
> better alternative?

I don't think it matters; I was just making sure Florian was aware
of the difference (it will not appear in the commit message anyway),
including the memory leak in the original code.

ATB,
Ramsay Jones

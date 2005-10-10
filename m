From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Fix cygwin install issues
Date: Mon, 10 Oct 2005 08:02:56 -0700
Message-ID: <434A82A0.7060608@zytor.com>
References: <20051010085259.GA18009@diku.dk> <7vmzlh7n7h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 10 17:07:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOzBP-0004pm-9t
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 17:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbVJJPDQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 11:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbVJJPDQ
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 11:03:16 -0400
Received: from terminus.zytor.com ([192.83.249.54]:65508 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750839AbVJJPDP
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 11:03:15 -0400
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9AF2u2Z019697
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Oct 2005 08:02:57 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzlh7n7h.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9891>

Junio C Hamano wrote:
> Jonas Fonseca <fonseca@diku.dk> writes:
> 
> 
>>Support installing to paths including spaces.
>>Remove any old .exe files so ln will succeed.
>>
> 
> This is not a complaint but I am just wondering if:
> 
> 
>>-	$(INSTALL) -d -m755 $(DESTDIR)$(bindir)
>>+	$(INSTALL) -d -m755 "$(DESTDIR)$(bindir)"
> 
> this is the right way to quote things.  I suspect it might be
> the responsibility of the user to quote them if she chooses to
> set bindir or DESTDIR to a funky value, like this:
> 
>     $ make bindir="'My Documents\Programs'"

I don't think that's the right approach.

	$(INSTALL) -d -m755 '$(DESTDIR)$(bindir)'

... at least handles everything except embedded single quotes.  Note 
that the single quote is not a special character for make.

> Because depending on how funky the values of bindir and DESTDIR
> are, we cannot say double-quote you are giving them is even the
> right quoting (think double-quote itself as part of the name).
> 
> The other "$X" change to cmd-renames is a good change (I thought
> I heard HPA talking about that; maybe he sent one to me and I
> dropped it on the floor by mistake, I dunno).  Thanks.

If I dropped it on the floor, it was mentally :-/

	-hpa

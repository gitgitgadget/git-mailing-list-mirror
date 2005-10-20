From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Revamping the git protocol
Date: Thu, 20 Oct 2005 08:50:20 -0700
Message-ID: <4357BCBC.1020706@zytor.com>
References: <43571DA1.6030907@zytor.com> <7vwtk8pvju.fsf@assigned-by-dhcp.cox.net> <20051020091245.GY30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 17:51:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESch2-0007dp-SI
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 17:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbVJTPu6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 11:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbVJTPu6
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 11:50:58 -0400
Received: from terminus.zytor.com ([192.83.249.54]:45471 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932204AbVJTPu5
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 11:50:57 -0400
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9KFoKqD003259
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 20 Oct 2005 08:50:23 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051020091245.GY30889@pasky.or.cz>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10366>

Petr Baudis wrote:
> Dear diary, on Thu, Oct 20, 2005 at 08:11:17AM CEST, I got a letter
> where Junio C Hamano <junkio@cox.net> told me that...
> 
>>I am wondering if we can just get away with a simpler scheme
>>Linus outlined instead.  One drawback of that approach is it
>>does not easily allow things like challenge-response uniformly
>>across different commands (admittedly we only have "upload-pack"
>>command right now, but we could add list of supported commands
>>easily in execute()), but you could do something along this, I
>>presume?
> 
> What's wrong with my scheme? That is, _reply_ with challenge to the
> upload-pack command. This should be equally powerful to the Linus'
> scheme and the crucial advantage is that you do not need to tell at
> the client side whether you are talking to a new server or an old one.
> 
> I was convinced that the authentication part of the challenge-resposne
> isn't such a good idea after all, though. ;-)
> 

Anyone noticed that either of those schemes aren't actually 
backward-compatible in any way (old client talking to new server will be 
disconnected), and that unfortunately is the best thing one can do with 
the current setup, exactly because there is no option negotiation phase?

Another issue is that currently there is no error information propagated 
back to the client; the server logs an error in its own logs, but the 
client is simply disconnected.

	-hpa

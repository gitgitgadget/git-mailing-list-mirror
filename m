From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/5] Library code for user-relative paths, take three.
Date: Fri, 18 Nov 2005 12:33:31 -0800
Message-ID: <437E3A9B.1070801@zytor.com>
References: <20051117193714.2B8995BF93@nox.op5.se> <7v8xvmsu9o.fsf@assigned-by-dhcp.cox.net> <437DA828.6020207@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 21:34:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdCwF-00068S-00
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 21:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161189AbVKRUdv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 15:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161195AbVKRUdu
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 15:33:50 -0500
Received: from terminus.zytor.com ([192.83.249.54]:63917 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1161191AbVKRUdr
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 15:33:47 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jAIKXaXG012222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 18 Nov 2005 12:33:36 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <437DA828.6020207@op5.se>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12256>

Andreas Ericsson wrote:
> Junio C Hamano wrote:
> 
>>
>>> +    /* This is perfectly safe, and people tend to think of the 
>>> directory
>>> +     * where they ran git-init-db as their repository, so humour 
>>> them. */
>>> +    (void)chdir(".git");
>>
>>
>> It might be safe, but I think it changes the behaviour of
>> upload-pack with strict case.  My gut reaction is we would want
>> "if (!strict)" in front.  Thoughts?
> 
> As it says in the comment; People tend to think of the directory where 
> they ran "git init-db" as their repository, so humour them. It's nice 
> for sharing files between devs in the office, and it *is* safe.

No, it's not.

The whole point with --strict is that it shouldn't DWIM.  DWIMming is 
*NOT* safe if the data has previously passed through a security screen.

Don't DWIM in strict mode, ever.  If you do, you create security holes. 
  If not immediately, then later.

	-hpa

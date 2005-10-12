From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] git-fetch --tags: deal with tags with spaces in them.
Date: Wed, 12 Oct 2005 08:47:12 -0700
Message-ID: <434D3000.5020601@zytor.com>
References: <46a038f90510062014l7f5740e0l77fc53b50f822e8f@mail.gmail.com>	<46a038f90510082014i6b296f2bvbac56e25344cbdf2@mail.gmail.com>	<4349ED5D.6020703@catalyst.net.nz>	<7v4q7p927d.fsf@assigned-by-dhcp.cox.net>	<7vzmpgznfj.fsf_-_@assigned-by-dhcp.cox.net>	<7virw4zlod.fsf_-_@assigned-by-dhcp.cox.net>	<7vzmpgy4g4.fsf@assigned-by-dhcp.cox.net> <7vk6gjl2uu.fsf@assigned-by-dhcp.cox.net> <434D2D8F.2020407@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	"Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Wed Oct 12 17:50:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPipJ-0001dG-Fz
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 17:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbVJLPra (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 11:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbVJLPra
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 11:47:30 -0400
Received: from terminus.zytor.com ([192.83.249.54]:43170 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751465AbVJLPra
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2005 11:47:30 -0400
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9CFlD1s008689
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 12 Oct 2005 08:47:13 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <434D2D8F.2020407@zytor.com>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10039>

H. Peter Anvin wrote:
> 
> We can disallow whitespace, and we *have* to disallow at least newline 
> due to the file format; I believe we should disallow all control 
> characters (0-31, 127-159.)
> 

Actually, disallowing anything 128 and above means knowing the encoding 
system.  If we enforce UTF-8, we should presumably disallow at the very 
least U+FFFE and U+FFFF too.

C99 contains a list of Unicode characters allowed in C identifiers.  I 
believe we should allow those characters (plus at a minimum -+.#:@) as 
well, but I'd much rather we didn't make those kinds of decisions for 
the user.  If we have *specific* characters we can't tolerate we should 
rule them out (like control characters), but even that occationally 
leads to major frustration on the part of the user: "why can't I use '.' 
in tag names in CVS"?

	-hpa

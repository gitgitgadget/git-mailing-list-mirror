From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Trivial warning fix for imap-send.c
Date: Sun, 12 Mar 2006 18:59:12 -0800
Message-ID: <4414E000.9030902@zytor.com>
References: <20060311192954.GQ16135@artsapartment.org> <slrne17urp.fr9.mdw@metalzone.distorted.org.uk> <Pine.LNX.4.64.0603120847500.3618@g5.osdl.org> <slrne18of5.fr9.mdw@metalzone.distorted.org.uk> <4414747B.7040700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Wooding <mdw@distorted.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 13 03:59:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIdHT-0004sn-Ca
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 03:59:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWCMC7Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Mar 2006 21:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWCMC7Z
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Mar 2006 21:59:25 -0500
Received: from terminus.zytor.com ([192.83.249.54]:3461 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750712AbWCMC7Z
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Mar 2006 21:59:25 -0500
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k2D2xC2I019622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 12 Mar 2006 18:59:13 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: gitzilla@gmail.com
In-Reply-To: <4414747B.7040700@gmail.com>
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.7 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17539>

A Large Angry SCM wrote:
> Mark Wooding wrote:
> 
>> Linus Torvalds <torvalds@osdl.org> wrote:
>>
>>> So in modern C, using NULL at the end of a varargs array as a pointer 
>>> is perfectly sane, and the extra cast is just ugly and bowing to bad 
>>> programming practices and makes no sense to anybody who never saw the 
>>> horror that is K&R.
>>
>> No!  You can still get bitten.  You're lucky that on common platforms
>> all pointers look the same, but if you find one where `char *' (and
>> hence `void *') isn't the same as `struct foo *' then, under appropriate
>> circumstances you /will/ unless you put the casts in.
> 
> Please explain how malloc() can work on such a platform. My reading of 
> the '89 ANSI C spec. finds that _ALL_ (non function) pointers _are_ 
> cast-able to/from a void * and that NULL should be #defined as (void *). 
> See 3.2.2.3 and 4.1.5 if interested.

Consider the non-hypothetical example of a word-addressed machine, which 
has to have extra bits in a subword pointer like char *.  The C standard 
requires that void * has those bits as well, but it doesn't means that 
any void * can be cast to any arbitrary pointer -- the opposite, 
however, is required.

	-hpa

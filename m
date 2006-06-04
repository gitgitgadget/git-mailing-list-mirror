From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Clean up sha1 file writing
Date: Sun, 04 Jun 2006 11:25:30 -0700
Message-ID: <4483259A.7090806@zytor.com>
References: <Pine.LNX.4.64.0605240820560.5623@g5.osdl.org> <E1Fixs4-0005pD-10@moooo.ath.cx> <Pine.LNX.4.64.0605241145490.5623@g5.osdl.org> <44808710.1080000@zytor.com> <Pine.LNX.4.64.0606021416040.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthias Lederhofer <matled@gmx.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 04 20:25:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmxIJ-00057O-F3
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 20:25:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWFDSZo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 14:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbWFDSZn
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 14:25:43 -0400
Received: from terminus.zytor.com ([192.83.249.54]:48333 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750916AbWFDSZn
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 4 Jun 2006 14:25:43 -0400
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.6/8.13.4) with ESMTP id k54IPUxM009303
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 4 Jun 2006 11:25:31 -0700
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606021416040.5498@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.88.2, clamav-milter version 0.88.2 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.7 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21274>

Linus Torvalds wrote:
> 
> On Fri, 2 Jun 2006, H. Peter Anvin wrote:
>> Linus Torvalds wrote:
>>> Any POSIX-conformant OS/filesystem should always do a full write for a
>>> regular file, unless a serious error happens.
>>>
>> Actually, at least Linux won't, if the object is larger than 2 GB on a 64-bit
>> system :)
> 
> Yeah, true.
> 
> In the end, you should always have the loop. That way, you never have to 
> worry about what kind of file descriptor it is, what kind of filesystem 
> you're running on, and what the limits of ssize_t might be.
> 

Or if you're getting a SIGWINCH in the middle of it.

Any POSIX system will interrupt the transfer and return a short read on 
receiving a signal.

	-hpa

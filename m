From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: MinGW port usable
Date: Thu, 01 Feb 2007 13:05:18 -0800
Message-ID: <45C2560E.6090504@zytor.com>
References: <200701292320.43888.johannes.sixt@telecom.at> <45C18A3B.2070004@zytor.com> <45C1C24A.471F40AD@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Thu Feb 01 22:05:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCj7i-0006Xq-En
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 22:05:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423010AbXBAVFe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 16:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423011AbXBAVFe
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 16:05:34 -0500
Received: from terminus.zytor.com ([192.83.249.54]:54951 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423010AbXBAVFd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 16:05:33 -0500
Received: from [10.0.6.0] (yardgnome.c2micro.com [69.104.58.50])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l11L5L7d024911
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 1 Feb 2007 13:05:22 -0800
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
In-Reply-To: <45C1C24A.471F40AD@eudaptics.com>
X-Virus-Scanned: ClamAV 0.88.7/2513/Thu Feb  1 08:48:53 2007 on terminus.zytor.com
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.7 required=5.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_96_XX autolearn=no version=3.1.7
X-Spam-Checker-Version: SpamAssassin 3.1.7 (2006-10-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38403>

Johannes Sixt wrote:
> "H. Peter Anvin" wrote:
>> Johannes Sixt wrote:
>>> (*) The reason is that on Windows read() and write() cannot operate on
>>> descriptors created by socket(). A work-around is to implement a (threaded)
>>> proxy, but that's almost the same as if netcat were used as
>>> GIT_PROXY_COMMAND.
>>>
>> Actually, I believe it can for the NT series kernels (at least 2000 or
>> later, not sure about the earlier ones), but not for the DOS-based ones.
>>
>> The trick is to use _open_osfhandle() to convert the file handle (a
>> WinAPI construct) to a file descriptor (which in Windows is a construct
>> of the C library.)
> 
> I tried this, but it doesn't seem to work. I get an EINVAL at the first
> write() to the socket. I conclude that the things returned by socket()
> are not WinAPI file handles that are valid for WriteFile(). :(
> 

Except they are (for NT-based Windows), so you're doing something goofy. 
  This is a widely used construct, so it can't be that broken.

	-hpa

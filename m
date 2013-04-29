From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 6/6] compat/nedmalloc: Fix compiler warnings on linux
Date: Tue, 30 Apr 2013 00:01:09 +0100
Message-ID: <517EFBB5.9040502@ramsay1.demon.co.uk>
References: <517C1CF9.2080903@ramsay1.demon.co.uk> <7v7gjmqwxn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 01:33:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWxZV-0000M4-UV
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 01:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588Ab3D2XdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 19:33:12 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:51177 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932572Ab3D2XdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 19:33:09 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id AEAE0384083;
	Tue, 30 Apr 2013 00:33:08 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 11C41384081;
	Tue, 30 Apr 2013 00:33:08 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Tue, 30 Apr 2013 00:33:07 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <7v7gjmqwxn.fsf@alter.siamese.dyndns.org>
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222883>

Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
>> On linux, when the build variable USE_NED_ALLOCATOR is set, gcc
>> issues the following warnings:
>>
>>     In file included from compat/nedmalloc/nedmalloc.c:63:
>>     .../malloc.c.h: In function 'mmap_resize':
>>     .../malloc.c.h:3762: warning: implicit declaration of function 'mremap'
>>     .../malloc.c.h: In function 'sys_trim':
>>     .../malloc.c.h:4195: warning: comparison between pointer and integer
>>
>> The warnings are caused by the <sys/mman.h> header not enabling the
>> (conditional) declaration of the mremap() function.  The declaration
>> can be enabled by defining the _GNU_SOURCE symbol prior to including
>> certain system header files. In particular, it may not be sufficient
>> to simply define _GNU_SOURCE just prior to including the <sys/mman.h>
>> header. (e.g. defining the symbol after including <sys/types.h> will
>> be completely ineffective.)
>>
>> In order to suppress the warnings, we define the _GNU_SOURCE symbol
>> at the start of the malloc.c.h header file.
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>> ---
> 
> Hmmmm, is this even worth worrying about?  I somehow thought this
> was only meant to replace malloc on non GNU systems...

Maybe not. I certainly won't be using it on Linux. But I wanted to
test the previous patch on Linux and it didn't compile cleanly, so ...
(It passed all tests BTW).

ATB,
Ramsay Jones

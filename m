From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 6/6] compat/nedmalloc: Fix compiler warnings on linux
Date: Tue, 30 Apr 2013 00:09:15 +0100
Message-ID: <517EFD9B.4020608@ramsay1.demon.co.uk>
References: <517C1CF9.2080903@ramsay1.demon.co.uk> <20130429050616.GB8031@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 01:33:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWxZW-0000M4-Ds
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 01:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624Ab3D2XdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 19:33:15 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:51186 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932600Ab3D2XdM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 19:33:12 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 69251384083;
	Tue, 30 Apr 2013 00:33:11 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id D166B384081;
	Tue, 30 Apr 2013 00:33:10 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Tue, 30 Apr 2013 00:33:10 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <20130429050616.GB8031@elie.Belkin>
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222885>

Jonathan Nieder wrote:
> Hi,
> 
> Ramsay Jones wrote:
> 
>> --- a/compat/nedmalloc/malloc.c.h
>> +++ b/compat/nedmalloc/malloc.c.h
>> @@ -484,6 +484,10 @@ MAX_RELEASE_CHECK_RATE   default: 4095 unless not HAVE_MMAP
>>  #define DLMALLOC_VERSION 20804
>>  #endif /* DLMALLOC_VERSION */
>>
>> +#if defined(linux)
>> +#define _GNU_SOURCE 1
>> +#endif
> 
> If we want to do this, I'd suggest defining _GNU_SOURCE
> unconditionally.  Other platforms using glibc would benefit from it,
> too, and other platforms not using glibc shouldn't care.

My original version was unconditional, then I came over all
conservative ... :-D

Actually, in order to reduce the chance of future breakage, it
should really be placed at the beginning of the translation unit
(i.e. at the start of nedmalloc.c, before *any* #includes).

ATB,
Ramsay Jones

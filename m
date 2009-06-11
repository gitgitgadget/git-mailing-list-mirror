From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [RFC/PATCH 1/2] Teach Solaris that _XOPEN_SOURCE=600 really menas
 XPG6
Date: Thu, 11 Jun 2009 10:50:21 -0500
Message-ID: <bUVdoksYaP8iWWwjmEaaKuJWLMjhg9vaKu35QNnhoSMM0G7B3XoanQ@cipher.nrlssc.navy.mil>
References: <1243106697-6424-1-git-send-email-gitster@pobox.com> <1243106697-6424-2-git-send-email-gitster@pobox.com> <B96700A1-EC8C-4DDE-A158-CE298FCCA09F@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 17:51:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEmZ6-00027m-Sl
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 17:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760015AbZFKPuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 11:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759662AbZFKPuu
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 11:50:50 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:55707 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755547AbZFKPut (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 11:50:49 -0400
Received: by mail.nrlssc.navy.mil id n5BFoMTD017197; Thu, 11 Jun 2009 10:50:22 -0500
In-Reply-To: <B96700A1-EC8C-4DDE-A158-CE298FCCA09F@dbservice.com>
X-OriginalArrivalTime: 11 Jun 2009 15:50:22.0103 (UTC) FILETIME=[53FB6A70:01C9EAAC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121345>

Tomas Carnecky wrote:
> 
> On May 23, 2009, at 9:24 PM, Junio C Hamano wrote:

>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index c7cf2d5..4236647 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -41,8 +41,10 @@
>>
>> #if !defined(__APPLE__) && !defined(__FreeBSD__)  &&
>> !defined(__USLC__) && !defined(_M_UNIX)
>> #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD
>> needs 600 for S_ISLNK() */
>> +#ifndef __sun__
>> #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
>> #endif
>> +#endif
>> #define _ALL_SOURCE 1
>> #define _GNU_SOURCE 1
>> #define _BSD_SOURCE 1
>> -- 
>> 1.6.3.1.145.gb74d77
>>
> 
> Until this commit a simple 'make prefix=...' worked just fine. Now I
> have to explicitly add '-std=c99' to the gcc commandline. Is there a
> reason why the makefile doesn't add this switch automatically?

There are additionally patches on 'next' and more in the pipeline on 'pu'
which adjust these feature macros when compiling on Solaris.  See the
bc/solaris series 8fccb00 which was merged to 'pu'.

Also, if you happen to be using the Sun Studio suite 12 with c-compiler
version 5.9, I'd be interested to know whether you can compile diff-delta.c,
or whether you get an error (see commit 203ee91f).

-brandon

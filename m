From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 7/7] Windows: Revert to default paths and convert them by RUNTIME_PREFIX
Date: Mon, 22 Sep 2008 07:57:04 +0200
Message-ID: <627E3F3B-D557-474B-BA20-3ABDEC9E2813@zib.de>
References: <1222014278-11071-1-git-send-email-prohaska@zib.de> <1222014278-11071-7-git-send-email-prohaska@zib.de> <1222014278-11071-8-git-send-email-prohaska@zib.de> <200809212358.48125.johannes.sixt@telecom.at>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Sep 22 08:03:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KheVd-0006Il-5y
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 08:02:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbYIVF6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 01:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751570AbYIVF6P
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 01:58:15 -0400
Received: from mailer.zib.de ([130.73.108.11]:47735 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751481AbYIVF6O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 01:58:14 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m8M5uigE005808;
	Mon, 22 Sep 2008 07:56:49 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db9004c.pool.einsundeins.de [77.185.0.76])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m8M5ugOw018227
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 22 Sep 2008 07:56:43 +0200 (MEST)
In-Reply-To: <200809212358.48125.johannes.sixt@telecom.at>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96450>


On Sep 21, 2008, at 11:58 PM, Johannes Sixt wrote:

> On Sonntag, 21. September 2008, Steffen Prohaska wrote:
>> The RUNTIME_PREFIX mechanism allows us to use the default  
>> (absolute) paths
>> on Windows too.  Defining RUNTIME_PREFIX explicitly requests for
>> translation of paths during runtime, depending on the path to the
>> executable.
>>
>> Signed-off-by: Steffen Prohaska <prohaska@zib.de>
>> ---
>> Makefile |    4 +---
>> 1 files changed, 1 insertions(+), 3 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 8181f74..98278f0 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -767,6 +767,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
>> 	SNPRINTF_RETURNS_BOGUS = YesPlease
>> 	NO_SVN_TESTS = YesPlease
>> 	NO_PERL_MAKEMAKER = YesPlease
>> +	RUNTIME_PREFIX = YesPlease
>> 	NO_POSIX_ONLY_PROGRAMS = YesPlease
>> 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
>> 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/ 
>> regex
>> -Icompat/fnmatch @@ -775,9 +776,6 @@ ifneq (,$(findstring
>> MINGW,$(uname_S)))
>> 	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o
>> compat/regex/regex.o compat/winansi.o EXTLIBS += -lws2_32
>> 	X = .exe
>> -	gitexecdir = ../libexec/git-core
>> -	template_dir = ../share/git-core/templates/
>> -	ETC_GITCONFIG = ../etc/gitconfig
>> endif
>> ifneq (,$(findstring arm,$(uname_M)))
>> 	ARM_SHA1 = YesPlease
>
> This cannot be the complete patch. The part that sets $(prefix) to  
> the empty
> string is missing, otherwise the runtime prefix discovery would never
> trigger, right? (But see also my comment on [PATCH 1/7].)

Right.  There are still some differences between msysgit's Makefile and
the official one, so I forgot to include all necessary changes.

I'll modify the implementation as you propose in your comment
on [PATCH 1/7].

	Steffen

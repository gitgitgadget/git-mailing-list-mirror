From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: Version 1.8.1 does not compile on Cygwin 1.7.14
Date: Tue, 15 Jan 2013 18:47:17 +0000
Message-ID: <50F5A435.5090408@ramsay1.demon.co.uk>
References: <2491041.bQ51Qu8HcA@thunderbird> <1890551.8jTmplCF6O@thunderbird> <BB541ECCD3F04E479F06CA491DDB598D@black> <50E92675.4010907@web.de> <20130106093211.GB10956@elie.Belkin> <50E946EB.1000709@web.de> <20130106095757.GC10956@elie.Belkin> <50E9647F.4090209@gmail.com> <20130106120917.GC22081@elie.Belkin> <7vfw2enl2l.fsf@alter.siamese.dyndns.org> <50E9F7C2.1000603@gmail.com> <FBDECCA565D94DF9838DD81FE2E2543A@black> <7v1udxladc.fsf@alter.siamese.dyndns.org> <50EB8EB5.6080204@gmail.com> <CALxABCYHRp17rcoOca1xWG9S19fq2rotz8FEKo09jNdrgMLiyQ@mail.gmail.com> <CALxABCavvW77djKQnbQsjCBcahmMfrP24SDz609NG-94_ifZ9Q@mail.gmail.com> <50F303D8.20709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Stephen & Linda Smith <ischis2@cox.net>,
	Eric Blake <eblake@redhat.com>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 19:55:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvBfg-0008LO-76
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 19:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757260Ab3AOSzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 13:55:14 -0500
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:43983 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753305Ab3AOSzM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 13:55:12 -0500
X-Greylist: delayed 353 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jan 2013 13:55:12 EST
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 2AF4D4004F2;
	Tue, 15 Jan 2013 18:49:16 +0000 (GMT)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 9DF8C400445;	Tue, 15 Jan 2013 18:49:14 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta010.tch.inty.net (Postfix) with ESMTP;	Tue, 15 Jan 2013 18:49:12 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <50F303D8.20709@gmail.com>
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213659>

Mark Levedahl wrote:
> On 01/11/2013 03:17 PM, Alex Riesen wrote:
>> On Fri, Jan 11, 2013 at 9:08 PM, Alex Riesen <raa.lkml@gmail.com> wrote:
>>> This short discussion on GitHub (file git-compat-util.h) might be relevant:
>>>
>>> https://github.com/msysgit/git/commit/435bdf8c7ffa493f8f6f2e8f329f8cc22db16ce6#commitcomment-2407194
>>>
>>> The change suggested there (to remove an inclusion of windows.h in
>>> git-compat-util.h) might simplify the solution a little. Might even
>>> remove the need for auto-configuration in Makefile (worked for me).
>> Just to be clear, the change is this:
>>
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index 4a1979f..780a919 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -85,12 +85,6 @@
>>   #define _NETBSD_SOURCE 1
>>   #define _SGI_SOURCE 1
>>
>> -#ifdef WIN32 /* Both MinGW and MSVC */
>> -#define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
>> -#include <winsock2.h>
>> -#include <windows.h>
>> -#endif
>> -
>>   #include <unistd.h>
>>   #include <stdio.h>
>>   #include <sys/stat.h>
>>
> That change alone seems fine, no apparent change building on current 
> cygwin. However, with that change the build still fails if 
> CYGWIN_V15_WIN32API is defined, so unless someone can show the 
> compilation works on cygwin1.5 WITHOUT defining CYGWIN_V15_WIN32API this 
> change does not help. I do not have an older installation available, so 
> cannot test. Frankly, assuming you can compile with that macro defined, 
> I would suggest leaving well enough alone - an unsupported configuration 
> is unsupported :^)

I haven't been following this thread too closely, so I may have misunderstood
what you would like to test but, since I use cygwin 1.5, I tried the patch
given below.

I only had time to compile test this patch (ie I have *not* run any of the
tests - it takes over 3 hours for me), but it seems to work to that extent.
(I also tried a few simple commands: status, diff, branch; seems to work OK.)

If you would like me to test something else, just let me know.

HTH

ATB,
Ramsay Jones

-- >8 --
diff --git a/Makefile b/Makefile
index 1b30d7b..1c84f68 100644
--- a/Makefile
+++ b/Makefile
@@ -281,10 +281,6 @@ all::
 #
 # Define NO_REGEX if you have no or inferior regex support in your C library.
 #
-# Define CYGWIN_V15_WIN32API if you are using Cygwin v1.7.x but are not
-# using the current w32api packages. The recommended approach, however,
-# is to update your installation if compilation errors occur.
-#
 # Define HAVE_DEV_TTY if your system can open /dev/tty to interact with the
 # user.
 #
@@ -1402,9 +1398,6 @@ ifdef NO_REGEX
 	COMPAT_CFLAGS += -Icompat/regex
 	COMPAT_OBJS += compat/regex/regex.o
 endif
-ifdef CYGWIN_V15_WIN32API
-	COMPAT_CFLAGS += -DCYGWIN_V15_WIN32API
-endif
 
 ifdef USE_NED_ALLOCATOR
        COMPAT_CFLAGS += -Icompat/nedmalloc
diff --git a/compat/cygwin.c b/compat/cygwin.c
index 5428858..0a9aa6d 100644
--- a/compat/cygwin.c
+++ b/compat/cygwin.c
@@ -1,13 +1,8 @@
 #define WIN32_LEAN_AND_MEAN
-#ifdef CYGWIN_V15_WIN32API
-#include "../git-compat-util.h"
-#include "win32.h"
-#else
 #include <sys/stat.h>
 #include <sys/errno.h>
 #include "win32.h"
 #include "../git-compat-util.h"
-#endif
 #include "../cache.h" /* to read configuration */
 
 static inline void filetime_to_timespec(const FILETIME *ft, struct timespec *ts)
diff --git a/config.mak.uname b/config.mak.uname
index bea34f0..5e493c9 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -158,7 +158,6 @@ ifeq ($(uname_O),Cygwin)
 		NO_SYMLINK_HEAD = YesPlease
 		NO_IPV6 = YesPlease
 		OLD_ICONV = UnfortunatelyYes
-		CYGWIN_V15_WIN32API = YesPlease
 	endif
 	NO_THREAD_SAFE_PREAD = YesPlease
 	NEEDS_LIBICONV = YesPlease
diff --git a/git-compat-util.h b/git-compat-util.h
index e5a4b74..3186e55 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -85,12 +85,6 @@
 #define _NETBSD_SOURCE 1
 #define _SGI_SOURCE 1
 
-#ifdef WIN32 /* Both MinGW and MSVC */
-#define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
-#include <winsock2.h>
-#include <windows.h>
-#endif
-
 #include <unistd.h>
 #include <stdio.h>
 #include <sys/stat.h>

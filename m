From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 02/14] msvc: git-daemon.exe: Fix linker "unresolved externals"
 error
Date: Wed, 08 Dec 2010 00:11:32 +0000
Message-ID: <4CFECD34.3080809@ramsay1.demon.co.uk>
References: <4CFA8EB7.9070000@ramsay1.demon.co.uk> <AANLkTi=cVTcaQTQqNeQoNHhUrEBZvE5B=aFDy=r+k0uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Dec 08 01:30:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ7vn-0007Zf-27
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 01:30:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754730Ab0LHAah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 19:30:37 -0500
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:54435 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754660Ab0LHAah (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Dec 2010 19:30:37 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1PQ7vX-00073Z-Yu; Wed, 08 Dec 2010 00:30:36 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <AANLkTi=cVTcaQTQqNeQoNHhUrEBZvE5B=aFDy=r+k0uQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163154>

Erik Faye-Lund wrote:
> On Sat, Dec 4, 2010 at 7:55 PM, Ramsay Jones <ramsay@ramsay1.demon.co.uk> wrote:
>> The msvc linker complains about external symbols referenced by
>> the new poll() emulation code. In particular, it complains about
>> the DispatchMessage(), PeekMessage(), TranslateMessage() and
>> MsgWaitForMultipleObjects() functions.
>>
>> In order to satisfy the external references, we link against the
>> user32.lib library.
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>> ---
>>  Makefile |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 1d42413..bda9fa6 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1087,7 +1087,7 @@ ifeq ($(uname_S),Windows)
>>        COMPAT_OBJS = compat/msvc.o compat/fnmatch/fnmatch.o compat/winansi.o compat/win32/pthread.o compat/win32/syslog.o compat/win32/sys/poll.o
>>        COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/fnmatch -Icompat/regex -Icompat/fnmatch -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
>>        BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
>> -       EXTLIBS = advapi32.lib shell32.lib wininet.lib ws2_32.lib
>> +       EXTLIBS = user32.lib advapi32.lib shell32.lib wininet.lib ws2_32.lib
>>        PTHREAD_LIBS =
>>        lib =
>>  ifndef DEBUG
> 
> Looks sane. But it's a bit odd - it currently builds fine without this
> patch from the IDE, but not from the makefile. Is the linker-libs
> different between these?

Er... dunno! ;-) I don't use the IDE (except to read the msdn docs), I'm
*much* more productive in vim (yeah, I'm a luddite!).

So, how did you create your project file? What does it say?
ie. you tell me! :-P

ATB,
Ramsay Jones

From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC (take 3)] autoconf: Add test for OLD_ICONV (squelching compiler warning)
Date: Fri,  7 Dec 2007 02:27:20 +0100
Message-ID: <1196990840-1168-1-git-send-email-jnareb@gmail.com>
References: <alpine.LFD.0.9999.0712061628070.13796@woody.linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Blake Ramsdell <blaker@gmail.com>,
	Wincent Colaiuta <win@wincent.com>,
	Junio C Hamano <gitster@pobox.com>,
	Pascal Obry <pascal@obry.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Arjen Laarhoven <arjen@yaph.org>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 07 02:24:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0RxK-0004DF-8u
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 02:24:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881AbXLGBYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 20:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752838AbXLGBYF
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 20:24:05 -0500
Received: from mu-out-0910.google.com ([209.85.134.191]:51483 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828AbXLGBYC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 20:24:02 -0500
Received: by mu-out-0910.google.com with SMTP id i10so185645mue
        for <git@vger.kernel.org>; Thu, 06 Dec 2007 17:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=d4icd2G41MaEyYAKuPVVhSMWUNIhIs/D1W7bxWIYQhg=;
        b=CkdFQj143JXJfeARGLDeLh11UvEnMjzHAXt5c89L0fC/vOGq0GbEhfu3n63bYv/HKgkKU5am7nCtF7C/zNPmANTqvA9PN6L1Hg7Twm8cQWh2WMYgWL1vLwJ5KeVtpoJr4U3qd/yZsW4bHe/gX7e/lXVx4hmtvozuYl6/15YcTQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vQXMSNBR0XkNEYeo0yNw4eiwsYec4w3op+Q2J8RMgIKnKv6OhylgjyS5JVb047HIazQnFTISZFepDxJKfyrZM8X321o0SXHLx1qSCYNnrUDdT/dJkDsmGz8C1n8LnSwltRk1dBaAAFy+fGxpCAyHm63q/eufJAoeHUxE124HSto=
Received: by 10.86.97.7 with SMTP id u7mr1622057fgb.1196990639769;
        Thu, 06 Dec 2007 17:23:59 -0800 (PST)
Received: from roke.D-201 ( [83.8.224.19])
        by mx.google.com with ESMTPS id e9sm81660muf.2007.12.06.17.23.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Dec 2007 17:23:58 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lB71RUwg001184;
	Fri, 7 Dec 2007 02:27:31 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lB71RMmr001182;
	Fri, 7 Dec 2007 02:27:22 +0100
X-Mailer: git-send-email 1.5.3.7
In-Reply-To: <alpine.LFD.0.9999.0712061628070.13796@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67363>

Update configure.ac (and config.mak.in) to keep up with git
development by adding [compile] test whether your library has an old
iconv(), where the second (input buffer pointer) parameter is declared
with type (const char **) (OLD_ICONV).

Test-proposed-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
CC-ed to all parties (in this and previous thread).

I should probably used AC_LANG_PROGRAM like for NO_C99_FORMAT instead
of generating whole programlet^W test program by hand (I hope that for
example I haven't missed some header file which needs to be included);
I have followed example for NO_ICONV / NEEDS_LIBICONV and
NO_DEFLATE_BOUND test.  I'm also not sure if I have put this test in
the correct autoconf section, but that is probably matter of taste.

On Fri, 7 Dec 2007, Linus Torvalds wrote:
> 
> On Fri, 7 Dec 2007, Jakub Narebski wrote:
>>
>> The problem is that it should be check that tests for compile time 
>> _warnings_; my solution was to use '-Werror' flag to make warning into 
>> error, and AC_COMPILE_IFELSE, but this might be gcc only solution.
>> 
>>   Message-ID: <1196895948-25115-1-git-send-email-jnareb@gmail.com>
>>   http://permalink.gmane.org/gmane.comp.version-control.git/67209
>> 
>> So please send it.
> 
> Umm. Why not just make the test be whether the following compiles cleanly?
> 
> 	#include <iconv.h>
> 	
> 	extern size_t iconv(iconv_t cd,
> 	  char **inbuf, size_t *inbytesleft,
> 	  char **outbuf, size_t *outbytesleft);
> 
> because if the compiler has seen a "const char **inbuf", then it  should 
> error out with a "conflicting types for ?iconv?" style message..

[...]

> Totally untested. I don't do autoconf.

Thanks for a suggestion. Implemented in the patch below. It should
work correctly, but could those who have old iconv(), or used to have
old iconv() please check if works correctly for them?

By the way, perhaps the previous idea would work using AC_LANG_WERROR
instead of passing adding [temporarily] GCC `-Werror' option to
`CFLAGS', or use parts of its implementation.

 - Macro: AC_LANG_WERROR
     Normally Autoconf ignores warnings generated by the compiler,
     linker, and preprocessor.  If this macro is used, warnings will be
     treated as fatal errors instead for the current language.  This
     macro is useful when the results of configuration will be used
     where warnings are unacceptable; for instance, if parts of a
     program are built with the GCC `-Werror' option.  If the whole
     program will be built using `-Werror' it is often simpler to put
     `-Werror' in the compiler flags (`CFLAGS' etc.).


On Fri, 7 Dec 2007, Blake Ramsdell wrote:
> On Dec 6, 2007 4:41 PM, Blake Ramsdell <blaker@gmail.com> wrote:
>> On Dec 6, 2007 4:30 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>> Umm. Why not just make the test be whether the following compiles cleanly?
>>>
>>>         #include <iconv.h>
>>>
>>>         extern size_t iconv(iconv_t cd,
>>>           char **inbuf, size_t *inbytesleft,
>>>           char **outbuf, size_t *outbytesleft);
>>>
>>> because if the compiler has seen a "const char **inbuf", then it  should
>>> error out with a "conflicting types for 'iconv'" style message..
>>
>> Yeah, this is what I did:
> 
> My apologies. Your suggestion is completely different, and should work
> without -Werror. Let me try that.

Is something like the patch below what you wanted to try?

 config.mak.in |    1 +
 configure.ac  |   22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index 11d256e..7d5df9b 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -41,4 +41,5 @@ NO_STRTOUMAX=@NO_STRTOUMAX@
 NO_SETENV=@NO_SETENV@
 NO_MKDTEMP=@NO_MKDTEMP@
 NO_ICONV=@NO_ICONV@
+OLD_ICONV=@OLD_ICONV@
 NO_DEFLATE_BOUND=@NO_DEFLATE_BOUND@
diff --git a/configure.ac b/configure.ac
index 5f8a15b..86be19a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -212,6 +212,28 @@ test -n "$NEEDS_SOCKET" && LIBS="$LIBS -lsocket"
 
 
 ## Checks for header files.
+AC_MSG_NOTICE([CHECKS for header files])
+#
+# Define OLD_ICONV if your library has an old iconv(), where the second
+# (input buffer pointer) parameter is declared with type (const char **).
+AC_DEFUN([OLDICONVTEST_SRC], [[
+#include <iconv.h>
+
+extern size_t iconv(iconv_t cd,
+                    char **inbuf, size_t *inbytesleft,
+                    char **outbuf, size_t *outbytesleft);
+
+int main(void)
+{
+	return 0;
+}
+]])
+AC_MSG_CHECKING([for old iconv()])
+AC_COMPILE_IFELSE(OLDICONVTEST_SRC,
+	[AC_MSG_RESULT([no])],
+	[AC_MSG_RESULT([yes])
+	OLD_ICONV=UnfortunatelyYes])
+AC_SUBST(OLD_ICONV)
 
 
 ## Checks for typedefs, structures, and compiler characteristics.
-- 
1.5.3.7

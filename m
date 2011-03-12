From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: What's cooking in git.git (Feb 2011, #05; Wed, 23)
Date: Sat, 12 Mar 2011 16:16:47 +0300
Organization: Marine Bridge & Navigation Systems
Message-ID: <20110312131646.GA14621@tugrik.mns.mnsspb.ru>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org> <AANLkTinUtqJJHNyS9CxrC=VnS87v=GH=pOw9yr4r=pii@mail.gmail.com> <AANLkTimWy+W+rcZHsac_n--y9iMeaoO66CPZVbN1VBp2@mail.gmail.com> <20110225090544.GA3783@tugrik.mns.mnsspb.ru> <alpine.DEB.1.00.1102251208380.1561@bonsai2> <20110225192455.GA7130@tugrik.mns.mnsspb.ru> <alpine.DEB.1.00.1102252251140.15247@pacific.mpi-cbg.de> <20110226110740.GA3096@tugrik.mns.mnsspb.ru> <alpine.DEB.1.00.1102271509540.1561@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 12 14:16:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PyOgN-0006h8-0x
	for gcvg-git-2@lo.gmane.org; Sat, 12 Mar 2011 14:16:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845Ab1CLNQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2011 08:16:29 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:46635 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752858Ab1CLNQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2011 08:16:28 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1PyOg9-0000kt-O2; Sat, 12 Mar 2011 16:16:21 +0300
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1PyOgZ-0003px-1O; Sat, 12 Mar 2011 16:16:47 +0300
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1102271509540.1561@bonsai2>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168942>

 [ Sorry for silence, completly buried under load... ]

On Sun, Feb 27, 2011 at 03:28:43PM +0100, Johannes Schindelin wrote:
> Hi Kirill,
> 
> On Sat, 26 Feb 2011, Kirill Smelkov wrote:
> 
> > On Fri, Feb 25, 2011 at 10:54:40PM +0100, Johannes Schindelin wrote:
> > > 
> > > On Fri, 25 Feb 2011, Kirill Smelkov wrote:
> > > 
> > > > On Fri, Feb 25, 2011 at 12:11:59PM +0100, Johannes Schindelin wrote:
> > > > 
> > > > > Further, I think that my beloved Shift+Insert will no longer work 
> > > > > with your [2].
> > > > 
> > > > Probably yes,
> > > 
> > > In my experiment after rebuilding msys-1.0.dll, it still works.
> > 
> > xser32.dll has nothing to do with msys - it's just a fake stub for
> > sh.exe. Before testing, have you "patched" sh.exe the way it is done in
> > my ks/xser32.dll
> > (http://repo.or.cz/w/msysgit/kirr.git/commit/9d952c74a52f577b2d16d4e4a489541a8fa7fbbd)
> 
> Ah. I had to add -Wl,-kill-at to the LDFLAGS so it works. 
> 
> See the ks/xser32 branch (and the ks/msys branch) of msysgit.git.

Hm, strange how it used to work on my side :) but you are right, thanks.

> 
> > > The problem for now is that when I time /share/msysGit/run-tests.sh, 
> > > there is hardly any gain from your patches:
> > > 
> > > Old:
> > > 
> > > 
> > > real    18m1.031s
> > > user    6m17.861s
> > > sys     19m25.257s
> > > 
> > > New:
> > > 
> > > real    17m54.500s
> > > user    6m12.319s
> > > sys     19m28.567s
> > 
> > Did you patch sh.exe to link to xser32.dll instead of user32.dll?
> 
> Now I did, and the difference is quite noticable:
> 
> real    15m37.281s
> user    5m6.934s
> sys     15m53.911s

This is on real windows, yes?


> (Note that I did not spend time to increase the N, so there is no point in 
> putting a percentage on the difference.)
> 
> I wonder whether we could patch sh.exe so it loads user32.dll _lazily_ 
> rather than using the xser32.dll hack?
> 
> (This would also fix the issue that I can no longer use Shift+Insert to 
> paste the clipboard into the Git Bash...)

The patch for bash would be simple enough to re-link it with user32.dll
`dlltool -y` 'ed (-y creates delay-load import lobrary), or simply to
patch lib/readline/kill.c to delay-load clipboard functions manually
here:

    /* A special paste command for users of Cygnus's cygwin32. */
    #if defined (__CYGWIN__)
    #include <windows.h>

    int
    rl_paste_from_clipboard (count, key)
         int count, key;
    {
      char *data, *ptr;
      int len;

      if (OpenClipboard (NULL) == 0)
        return (0);

      data = (char *)GetClipboardData (CF_TEXT);
      if (data)

    ...


Now this is simple only after we have infrastructure for rebuilding bash
in place, and untill we don't, something like this could help in the
meantime (sorry, can't test it properly under wine):

---- 8< ----
From 92151fe8325aa8c39e1b77b9780ed562703ba008 Mon Sep 17 00:00:00 2001
From: Kirill Smelkov <kirr@mns.spb.ru>
Date: Sat, 12 Mar 2011 15:20:19 +0300
Subject: [PATCH] xser32: be a delay-load proxy to real user32.dll

This way we'll hopefully make clipboard work in shell again. The proper
way is of course to rebuild sh.exe with user32 being `dlltool -y` 'ed.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 src/xser32/Makefile   |    3 +-
 src/xser32/release.sh |    2 +-
 src/xser32/xser32.c   |   61 ++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/src/xser32/Makefile b/src/xser32/Makefile
index 818ab49..f201768 100644
--- a/src/xser32/Makefile
+++ b/src/xser32/Makefile
@@ -2,9 +2,10 @@ CC      = gcc
 CFLAGS  = -Wall -Wwrite-strings
 LD      = gcc
 LDFLAGS = -nostdlib -Wl,-kill-at
+LIBS    = -lkernel32
 
 xser32.dll: xser32.o
-	$(LD) $(LDFLAGS) -shared -o $@ $^ -e _DllMain@12
+	$(LD) $(LDFLAGS) -shared -o $@ $^ -e _DllMain@12 $(LIBS)
 
 clean:
 	-rm -f xser32.o xser32.dll
diff --git a/src/xser32/release.sh b/src/xser32/release.sh
index 981f5e8..64e31b4 100644
--- a/src/xser32/release.sh
+++ b/src/xser32/release.sh
@@ -5,4 +5,4 @@ cd "$(dirname "$0")" &&
 make &&
 install -m 775 xser32.dll $DEST &&
 git add $DEST &&
-git commit -s -m "xser32.dll: Fake user32.dll like stub (for sh.exe not to load user32.dll)" $DEST
+git commit -s -m "xser32.dll: Delay-load proxy to real user32.dll (for sh.exe not to load user32.dll on every call)" $DEST
diff --git a/src/xser32/xser32.c b/src/xser32/xser32.c
index 27375ab..362a80b 100644
--- a/src/xser32/xser32.c
+++ b/src/xser32/xser32.c
@@ -1,22 +1,77 @@
 /* fake clipboard routines for sh.exe not to load user32.dll */
 #include <windef.h>
+#include <stdarg.h>
+#include <winbase.h>
+
+static HMODULE user32;
+
+static void die(const char *msg)
+{
+    const char *p;
+    DWORD msglen;
+    DWORD written;
+
+    /* hand-made strlen */
+    for (p=msg, msglen=0; *p; ++p, ++msglen)
+        ;
+
+    WriteFile (GetStdHandle (STD_ERROR_HANDLE), msg, msglen, &written, 0);
+    ExitProcess(1);
+}
+
+static void import_user32()
+{
+    if (user32)
+        return;
+
+    user32 = LoadLibrary("user32.dll");
+    if (!user32)
+        die("E: cannot load user32.dll\n");
+}
 
 __declspec(dllexport)
 BOOL WINAPI OpenClipboard(HWND hWndNewOwner)
 {
-    return FALSE;   /* always fails */
+    static BOOL WINAPI (*pOpenClipboard) (HWND);
+
+    if (!pOpenClipboard) {
+        import_user32();
+        pOpenClipboard = GetProcAddress(user32, "OpenClipboard");
+        if (!pOpenClipboard)
+            die("E: cannot import OpenClipboard from user32.dll\n");
+    }
+
+    return pOpenClipboard(hWndNewOwner);
 }
 
 __declspec(dllexport)
 BOOL WINAPI CloseClipboard(void)
 {
-    return TRUE;    /* ok */
+    static BOOL WINAPI (*pCloseClipboard) (void);
+
+    if (!pCloseClipboard) {
+        import_user32();
+        pCloseClipboard = GetProcAddress(user32, "CloseClipboard");
+        if (!pCloseClipboard)
+            die("E: cannot import CloseClipboard from user32.dll\n");
+    }
+
+    return pCloseClipboard();
 }
 
 __declspec(dllexport)
 HANDLE WINAPI GetClipboardData(UINT uFormat)
 {
-    return NULL;    /* always fail */
+    static HANDLE WINAPI (*pGetClipboardData) (UINT);
+
+    if (!pGetClipboardData) {
+        import_user32();
+        pGetClipboardData = GetProcAddress(user32, "GetClipboardData");
+        if (!pGetClipboardData)
+            die("E: cannot import GetClipboardData from user32.dll\n");
+    }
+
+    return GetClipboardData(uFormat);
 }
 
 
-- 
1.7.4.1.225.g83c3c

---- 8< ----


> 
> > Also I can't say for sure (hope yet) how sh-intensitive git tests are, 
> > but at least running configure for say gettext or whatever should be 
> > visibly faster, at least on wine.
> 
> They are pretty intensive, as they are shell scripts all over the place in 
> their own right.

Yes, thanks, your timing justifies that.

> I fear, however, that the real problem (maybe not on 
> WINE, but with real Windows) is that sh.exe needs to provide too many 
> POSIX-like things when starting new processes.
> 
> I fear, further, that the only way to make things more efficient on 
> Windows is to get rid of the many exec() calls and do more things 
> in-process. (If this is true, JGit should kick msysGit's ass.) This would 
> not apply to the test suite, though, which needs to stay a shell script 
> suite.
> 
> But maybe I am wrong, and the performance is lost through memory 
> management and filesystem interaction.

I'd say we should not fear and we should not guess. The user32.dll
stripping was low-hanging-fruit, and judging from it I'd say there
should be other such places where time is wasted because nobody cared
yet.

Only could we please move forward, and try to integrate somehow the
result to devel? Or else I fear we'll have too many half-done work/* branches...

> Ciao,
> Dscho

Thanks,
Kirill

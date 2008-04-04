From: Michele Ballabio <barra_cuda@katamail.com>
Subject: Re: [REGRESSION] git-gui
Date: Fri, 4 Apr 2008 23:04:42 +0200
Message-ID: <200804042304.42794.barra_cuda@katamail.com>
References: <007901c89590$a827f7c0$93a7c10a@LGE.NET> <57518fd10804031615m5c299df6hf31de3c689e16521@mail.gmail.com> <20080404012723.GL10274@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	=?utf-8?q?Andr=C3=A9_Goddard_Rosa?= <andre_rosa@lge.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 04 23:04:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jht57-0007l6-Ro
	for gcvg-git-2@gmane.org; Fri, 04 Apr 2008 23:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbYDDVDe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Apr 2008 17:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbYDDVDe
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 17:03:34 -0400
Received: from smtp.katamail.com ([62.149.157.154]:34287 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751378AbYDDVDd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Apr 2008 17:03:33 -0400
Received: (qmail 31284 invoked by uid 89); 4 Apr 2008 21:03:24 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp1-pc
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_50,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO host170-57-static.104-80-b.business.telecomitalia.it) (barra?cuda@katamail.com@80.104.57.170)
  by smtp1-pc with SMTP; 4 Apr 2008 21:03:17 -0000
User-Agent: KMail/1.9.7
In-Reply-To: <20080404012723.GL10274@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78819>

On Friday 04 April 2008, Shawn O. Pearce wrote:
> > Anyone else got any opinions on an appropriate shortcut? =C2=A0How =
about
> > '=3D' and '-' (+ and - without the shift), or are those not necessa=
rily
> > together either? =C2=A0(Are there really layouts where '[' and ']' =
aren't
> > next to each other?)
>=20
> I don't know, [ and ] seem reasonable to me. =C2=A0Git is mostly a so=
urce
> code control system. =C2=A0A lot of languages use [ and ] as part of
> their syntax. =C2=A0If you are typing on a keyboard that is difficult=
 to
> access these keys on, you are probably already used to contorting
> your fingers. =C2=A0:-|

To clarify, [ and ] are quite easy to type for me: the first problem
is that to type [ I have to press AltGr-=C3=A8 (or AltGr-8). With Ctrl,=
 it
makes three keypresses: I can handle this, but - second problem - it
seems Tcl/Tk cannot (unless I'm wrong, which can also be very likely):

keys.tcl:
-->8--
#!/usr/bin/wish
bind . <Key> {
	puts "            %%K - %%k - %%N - %%T - %%D - %%A - %%d"
	puts "You pressed %K - %k - %N - %T - %D - %A - %d"
}
--8<--

Trying Ctrl+[:
$ ./keys.tcl=20
            %K - %k - %N - %T - %D - %A - %d=20
You pressed Control_R - 109 - 65508 - 2 - 109 - {} - ??=20
            %K - %k - %N - %T - %D - %A - %d=20
You pressed ISO_Level3_Shift - 113 - 65027 - 2 - 113 - {} - ??=20
            %K - %k - %N - %T - %D - %A - %d=20
You pressed ?? - 34 - 0 - 2 - 34 - ?

Trying [:
$ ./keys.tcl=20
            %K - %k - %N - %T - %D - %A - %d=20
You pressed ISO_Level3_Shift - 113 - 65027 - 2 - 113 - {} - ??=20
            %K - %k - %N - %T - %D - %A - %d=20
You pressed ?? - 34 - 0 - 2 - 34 - [ - ??=20

So, it doesn't recognize [ at all at the keysym (%K) level.
No idea why. This is Tcl/Tk 8.4.15 on Linux.

> I wrote up a patch today based on Michele's suggested change.
> It works everywhere I can test, but I don't have an 8.4.0
> installation like the original poster.
>=20
> Unless someone posts a patch to change the keys away from [ and ]
> I say leave them as-is. =C2=A0But I'm willing to entertain a change i=
f
> someone who cares writes a patch for it.

Here it is. Of course if I'm the only one that has problems with ]/[,
forget it. But it seems reasonable to me to do:

ctrl-+ and ctrl-=3D	-> more context
ctrl--			-> less context

Since these keybindings are used in gitk too, they should be safe. If
someone doesn't like this change, just say so. If someone thinks my
setup is strange and knows what to do to fix it up, let me know.

-->8--
=46rom 4334c7690d80f7c05ec40f2efa4306ef88933469 Mon Sep 17 00:00:00 200=
1
=46rom: Michele Ballabio <barra_cuda@katamail.com>
Date: Fri, 4 Apr 2008 18:29:48 +0200
Subject: [PATCH] git-gui: use +/- instead of ]/[ to show more/less cont=
ext in diff

On some systems, brackets cannot be used as event details
(they don't have a keysym), so use +/- instead (both on
keyboard and keypad) and add ctrl-=3D as a synonym of ctrl-+
for convenience.

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 git-gui.sh |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 748efcc..744b51c 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2064,11 +2064,11 @@ if {[is_enabled multicommit] || [is_enabled sin=
glecommit]} {
=20
 	.mbar.commit add command -label [mc "Show Less Context"] \
 		-command show_less_context \
-		-accelerator $M1T-\[
+		-accelerator $M1T-\-
=20
 	.mbar.commit add command -label [mc "Show More Context"] \
 		-command show_more_context \
-		-accelerator $M1T-\]
+		-accelerator "$M1T-+ $M1T-=3D"
=20
 	.mbar.commit add separator
=20
@@ -2715,8 +2715,11 @@ bind $ui_comm <$M1B-Key-v> {tk_textPaste %W; %W =
see insert; break}
 bind $ui_comm <$M1B-Key-V> {tk_textPaste %W; %W see insert; break}
 bind $ui_comm <$M1B-Key-a> {%W tag add sel 0.0 end;break}
 bind $ui_comm <$M1B-Key-A> {%W tag add sel 0.0 end;break}
-bind $ui_comm <$M1B-Key-bracketleft> {show_less_context;break}
-bind $ui_comm <$M1B-Key-bracketright> {show_more_context;break}
+bind $ui_comm <$M1B-Key-minus> {show_less_context;break}
+bind $ui_comm <$M1B-Key-KP_Subtract> {show_less_context;break}
+bind $ui_comm <$M1B-Key-equal> {show_more_context;break}
+bind $ui_comm <$M1B-Key-plus> {show_more_context;break}
+bind $ui_comm <$M1B-Key-KP_Add> {show_more_context;break}
=20
 bind $ui_diff <$M1B-Key-x> {tk_textCopy %W;break}
 bind $ui_diff <$M1B-Key-X> {tk_textCopy %W;break}
@@ -2760,8 +2763,11 @@ bind .   <$M1B-Key-t> do_add_selection
 bind .   <$M1B-Key-T> do_add_selection
 bind .   <$M1B-Key-i> do_add_all
 bind .   <$M1B-Key-I> do_add_all
-bind .   <$M1B-Key-bracketleft> {show_less_context;break}
-bind .   <$M1B-Key-bracketright> {show_more_context;break}
+bind .   <$M1B-Key-minus> {show_less_context;break}
+bind .   <$M1B-Key-KP_Subtract> {show_less_context;break}
+bind .   <$M1B-Key-equal> {show_more_context;break}
+bind .   <$M1B-Key-plus> {show_more_context;break}
+bind .   <$M1B-Key-KP_Add> {show_more_context;break}
 bind .   <$M1B-Key-Return> do_commit
 foreach i [list $ui_index $ui_workdir] {
 	bind $i <Button-1>       "toggle_or_diff         $i %x %y; break"
--=20
1.5.4.5

From: Pavel Roskin <proski@gnu.org>
Subject: Re: [ANNOUNCE qgit-1.0rc1]
Date: Mon, 19 Dec 2005 22:04:25 -0500
Message-ID: <1135047865.2259.46.camel@dv>
References: <e5bfff550512180706y42bebd3frc142ade7f4d318ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 20 04:06:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EoXoE-0008Su-2S
	for gcvg-git@gmane.org; Tue, 20 Dec 2005 04:05:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbVLTDE7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Dec 2005 22:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbVLTDE7
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Dec 2005 22:04:59 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:47808 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750754AbVLTDE6
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2005 22:04:58 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EoXmI-0006oR-59
	for git@vger.kernel.org; Mon, 19 Dec 2005 22:03:03 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EoXnd-0005J8-Kk; Mon, 19 Dec 2005 22:04:25 -0500
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550512180706y42bebd3frc142ade7f4d318ae@mail.gmail.com>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13844>

Hello, Marco!

On Sun, 2005-12-18 at 16:06 +0100, Marco Costalba wrote:
> A good amount of small fixes and just few non intrusive features
> added, biggest one are speed-up of ref reading at startup, a per
> repository charset encoding using i18n.commitencoding git config
> variable and an annotation progress bar.
> 
> I plan to relase 1.0 for end of next week, so I would like to catch
> last minutes bugs with this rc1.

OK, here you go.  qgit just crashed on me.  I opened the patch pane, the
tree pane and the annotate window.  While the annotate window was
focused, I tried to select multiple files in the tree pane.  Then I
reproduced the crash in the debugger with qgit compiled without
optimization.


Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 46912496291552 (LWP 19362)]
0x0000000000415943 in Annotate::doAnnotate (this=0x7e6bd0, fileName=@0x7fffffc81f70, 
    sha=@0x7e2dc0) at src/annotate.cpp:102
102                     if (!pa->isValid) {
(gdb) p pa
$1 = (FileAnnotation *) 0x0
(gdb) bt
#0  0x0000000000415943 in Annotate::doAnnotate (this=0x7e6bd0, fileName=@0x7fffffc81f70, 
    sha=@0x7e2dc0) at src/annotate.cpp:102
#1  0x000000000041596d in Annotate::doAnnotate (this=0x7e6bd0, fileName=@0x7fffffc81f70, 
    sha=@0x7e4d10) at src/annotate.cpp:103
#2  0x000000000041596d in Annotate::doAnnotate (this=0x7e6bd0, fileName=@0x7fffffc81f70, 
    sha=@0x7e27d0) at src/annotate.cpp:103
#3  0x000000000041596d in Annotate::doAnnotate (this=0x7e6bd0, fileName=@0x7fffffc81f70, 
    sha=@0x8db560) at src/annotate.cpp:103
#4  0x000000000041596d in Annotate::doAnnotate (this=0x7e6bd0, fileName=@0x7fffffc81f70, 
    sha=@0x872bc0) at src/annotate.cpp:103
#5  0x000000000041596d in Annotate::doAnnotate (this=0x7e6bd0, fileName=@0x7fffffc81f70, 
    sha=@0x7b5c80) at src/annotate.cpp:103
#6  0x000000000041596d in Annotate::doAnnotate (this=0x7e6bd0, fileName=@0x7fffffc81f70, 
    sha=@0x7c2a50) at src/annotate.cpp:103
#7  0x000000000041596d in Annotate::doAnnotate (this=0x7e6bd0, fileName=@0x7fffffc81f70, 
    sha=@0x790c20) at src/annotate.cpp:103
#8  0x000000000041596d in Annotate::doAnnotate (this=0x7e6bd0, fileName=@0x7fffffc81f70, 
    sha=@0x7b9a30) at src/annotate.cpp:103
#9  0x000000000041596d in Annotate::doAnnotate (this=0x7e6bd0, fileName=@0x7fffffc81f70, 
    sha=@0x7e3d58) at src/annotate.cpp:103
#10 0x0000000000415f5f in Annotate::run (this=0x7e6bd0, fileName=@0x7fffffc81f70, 
    histRevOrder=@0x7fffffc81f80, annotateOk=@0x7fffffc81f5f, canceled=@0x7fffffc81f5e)
    at src/annotate.cpp:73
#11 0x0000000000435a54 in Git::runAnnotate (this=0x6cb5b0) at src/git.cpp:166
#12 0x00000000004832ab in Git::qt_invoke (this=0x6cb5b0, _id=9, _o=0x7fffffc82070)
    at src/moc_git.cc:132
#13 0x000000308a452d3a in QObject::activate_signal () from /usr/lib64/qt-3.3/lib/libqt-mt.so.3
#14 0x000000308a760923 in QSignal::signal () from /usr/lib64/qt-3.3/lib/libqt-mt.so.3
#15 0x000000308a46c581 in QSignal::activate () from /usr/lib64/qt-3.3/lib/libqt-mt.so.3
---Type <return> to continue, or q <return> to quit---
#16 0x000000308a473d09 in QSingleShotTimer::event () from /usr/lib64/qt-3.3/lib/libqt-mt.so.3
#17 0x000000308a3f7cfa in QApplication::internalNotify ()
   from /usr/lib64/qt-3.3/lib/libqt-mt.so.3
#18 0x000000308a3f8674 in QApplication::notify () from /usr/lib64/qt-3.3/lib/libqt-mt.so.3
#19 0x000000308a3edc4c in QEventLoop::activateTimers ()
   from /usr/lib64/qt-3.3/lib/libqt-mt.so.3
#20 0x000000308a3a9d3b in QEventLoop::processEvents () from /usr/lib64/qt-3.3/lib/libqt-mt.so.3
#21 0x000000308a40de37 in QEventLoop::enterLoop () from /usr/lib64/qt-3.3/lib/libqt-mt.so.3
#22 0x000000308a40dd42 in QEventLoop::exec () from /usr/lib64/qt-3.3/lib/libqt-mt.so.3
#23 0x000000000046e976 in main (argc=1, argv=0x7fffffc82688) at src/qgit.cpp:29
(gdb)

That's Fedora Core 4 on x86_64.

Also, qgit doesn't look well with large fonts (not excessively large,
mind you, just with Sans 12):

http://red-bean.com/proski/qgit/

I see sizes are hardcoded in the *.ui files.  Probably there should be a
way to make the widgets resize together with the font.

I don't want to be asked about range every time I start qgit.  Can it be
an option?  In half of the cases I just want to see commits in the last
2-4 days.  In other cases, I want to see the whole history.  Tags are
usually irrelevant.

The "Show All" checkbox in the range select dialog doesn't seem to have
any effect.  I think it should disable "top" and "bottom" comboboxes.

Finally, if I close the range select window by using the window manager
button, I don't want qgit to continue.  Maybe it's just because I'm
annoyed by the useless range dialog :-)

-- 
Regards,
Pavel Roskin

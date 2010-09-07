From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [RFC/PATCH] Force using Tcl/Tk 8.4 on Mac OS X
Date: Tue, 07 Sep 2010 20:11:08 +0100
Message-ID: <87r5h5pdwz.fsf@fox.patthoyts.tk>
References: <1283792854-45023-1-git-send-email-lists@haller-berlin.de>
	<CB6C69E6-7943-49B7-96E7-4C00831C3C9D@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Haller <lists@haller-berlin.de>, git@vger.kernel.org,
	Stefan Haller <stefan@haller-berlin.de>,
	Shawn O Pearce <spearce@spearce.org>,
	Daniel A Steffen <dsteffen@apple.com>
To: "Daniel A. Steffen" <das@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Sep 07 21:11:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot3Zl-0005EI-E7
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 21:11:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758089Ab0IGTLV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 15:11:21 -0400
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:35014 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756992Ab0IGTLT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Sep 2010 15:11:19 -0400
Received: from [172.23.170.139] (helo=anti-virus01-10)
	by smtp-out3.blueyonder.co.uk with smtp (Exim 4.52)
	id 1Ot3Zb-0002xq-PF; Tue, 07 Sep 2010 20:11:15 +0100
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out3.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1Ot3ZV-0003pk-Na; Tue, 07 Sep 2010 20:11:09 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id C090C21981; Tue,  7 Sep 2010 20:11:08 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <CB6C69E6-7943-49B7-96E7-4C00831C3C9D@users.sourceforge.net>
	(Daniel A. Steffen's message of "Mon, 6 Sep 2010 12:36:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155731>

"Daniel A. Steffen" <das@users.sourceforge.net> writes:

>Hi Stefan,
>
>On Sep 6, 2010, at 10:07 AM, Stefan Haller wrote:
>
>> When using Git Gui.app on a Snow Leopard system with Tcl/Tk 8.5,
>> there are two problems:
>> 
>> 1) Menu commands that open a dialog (e.g. "Push" or "Revert changes")
>>   don't work when invoked via their keyboard shortcuts. You get a
>>   dialog without a title bar, and the application then hangs without
>>   further responding to any user input; you need to kill it. Invoking
>>   the same commands with the mouse by choosing from the menu works fine.
>
>first time I hear of this (or see this myself, and I use git gui every
>day on Mac OS X); in part this may be due to the fact that many of the
>menu shortcuts assigned by git gui conflict with existing OS X
>shortcuts and don't work anyway e.g. cmd-A (esp if a text widget is in
>focus)...
>
>personally I would hate for my git gui to be downgraded to Tk 8.4 and
>Carbon because of this small issue, and I'm unlikely to be alone.
>

I will not force 8.4 on anyone. If someone wants to force it locally
they can just edit the wish command in their git-gui script file to use
wish8.4.

I'm happy - even eager - to apply patches to improve the MacOSX git gui
experience but I can't test them as I don't have such a system.

>
>diff --git i/git-gui.sh w/git-gui.sh
>index 0d5c5e3..ec7ed7d 100755
>--- i/git-gui.sh
>+++ w/git-gui.sh
>@@ -2723,6 +2723,9 @@ if {[is_enabled multicommit] || [is_enabled singlecommit]} {
>                -accelerator $M1T-J
>        lappend disable_on_lock \
>                [list .mbar.commit entryconf [.mbar.commit index last] -state]
>+       if {[is_MacOSX]} {
>+               .mbar.commit entryconf last -accelerator {}
>+       }
> 
>        .mbar.commit add separator
> 
>

This removes the Cmd-J accelerator from the "Revert Changes" menu
item. I assume that just changing the menu command to 
 {after idle [list do_revert_selection]}
doesn't work either?

Do you want this applied or will you produce a patch that removes more
such inappropriate accelerators?

Also - got any other MacOS specific patches?

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD

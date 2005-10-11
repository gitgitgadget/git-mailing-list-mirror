From: Paul Eggert <eggert@CS.UCLA.EDU>
Subject: Re: [PATCH] Try URI quoting for embedded TAB and LF in pathnames
Date: Mon, 10 Oct 2005 23:20:01 -0700
Message-ID: <87mzlgh8xa.fsf@penguin.cs.ucla.edu>
References: <7vu0ftyvbc.fsf@assigned-by-dhcp.cox.net>
	<20051007232909.GB8893@steel.home>
	<7vpsqgyjrj.fsf@assigned-by-dhcp.cox.net>
	<20051008064555.GA3831@steel.home>
	<7vachks7aq.fsf@assigned-by-dhcp.cox.net>
	<20051008133032.GA32079@localhost>
	<7v64s7svya.fsf@assigned-by-dhcp.cox.net>
	<7vu0frpxs1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Fitzsimons <robfitz@273k.net>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Kai Ruemmler <kai.ruemmler@gmx.net>
X-From: git-owner@vger.kernel.org Tue Oct 11 08:29:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPDaG-00059Z-Hp
	for gcvg-git@gmane.org; Tue, 11 Oct 2005 08:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbVJKGZt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 02:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbVJKGZt
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 02:25:49 -0400
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:49311 "EHLO kiwi.cs.ucla.edu")
	by vger.kernel.org with ESMTP id S1751388AbVJKGZs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Oct 2005 02:25:48 -0400
Received: from penguin.cs.ucla.edu (Penguin.CS.UCLA.EDU [131.179.64.200])
	by kiwi.cs.ucla.edu (8.11.7p1+Sun/8.11.7/UCLACS-5.2) with ESMTP id j9B6Jx415358;
	Mon, 10 Oct 2005 23:19:59 -0700 (PDT)
Received: from eggert by penguin.cs.ucla.edu with local (Exim 4.50)
	id 1EPDUX-0000hI-1f; Mon, 10 Oct 2005 23:20:01 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0frpxs1.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 08 Oct 2005 13:19:10 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9956>

Junio C Hamano <junkio@cox.net> writes:

> Although 'GNU patch' has --quoting-style flag, it seems to be
> used only on its output side

Yes, that's right.

The convention I had been thinking of adding is to have GNU diff
use shell-quoting style, e.g.,

'three
o'\''clock'

to represent a file name with a newline and an apostrophe in it.
This sort of file name can be cut and pasted into the shell.
The quoting could be used with any file name containing a
troublesome character.

Perhaps another quoting style would be better.

An issue I hadn't really had time to think about is the character
encoding of file names.  E.g., suppose one file system uses UTF-8
encoding for Japanese file names, and another file system uses EUC-JP.
I suppose it would be nice to handle this problem too.  Perhaps GNU
'diff' could standardize on using UTF-8 in its file names, regardless
of what the underlying file system uses.  Another option is to pass
the bytes of the file name through, no matter what.  This might
require a runtime flag to diff, or to patch, or both.

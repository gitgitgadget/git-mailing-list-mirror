From: Junio C Hamano <junkio@cox.net>
Subject: Re: master has some toys
Date: Thu, 17 Nov 2005 03:16:32 -0800
Message-ID: <7vsltvwmlr.fsf@assigned-by-dhcp.cox.net>
References: <20051115144223.GA18111@diana.vm.bytemark.co.uk>
	<b0943d9e0511160311k725526d8v@mail.gmail.com>
	<7vr79g8mys.fsf@assigned-by-dhcp.cox.net>
	<7v7jb83w8m.fsf_-_@assigned-by-dhcp.cox.net>
	<81b0412b0511170029xac34cdbtddf74eb766281b3c@mail.gmail.com>
	<Pine.LNX.4.63.0511171207580.20898@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 12:17:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Echkv-0006LV-T6
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 12:16:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbVKQLQe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 06:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbVKQLQe
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 06:16:34 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:40389 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750756AbVKQLQe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 06:16:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051117111534.TICV26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 17 Nov 2005 06:15:34 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511171207580.20898@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 17 Nov 2005 12:08:20 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12101>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Thu, 17 Nov 2005, Alex Riesen wrote:
>
>> On 11/17/05, Junio C Hamano <junkio@cox.net> wrote:
>> > Along with the git wrapper fixes and git-apply bugfix (it did
>> 
>> cygwin is completely broken. Still debugging, but it looks like the
>> old "windows can't unlink/rename open files" problem.
>
> FWIW I had no problems on cygwin (NO_MMAP=YesPlease).

It appears we'd better have something like this in the main
Makefile, so people do not have to do it themselves everywhere?

---

diff --git a/Makefile b/Makefile
index 7ce62e8..93d51c6 100644
--- a/Makefile
+++ b/Makefile
@@ -213,6 +213,7 @@ endif
 ifeq ($(uname_O),Cygwin)
 	NO_STRCASESTR = YesPlease
 	NEEDS_LIBICONV = YesPlease
+	NO_MMAP = YesPlease
 	NO_IPV6 = YesPlease
 	X = .exe
 endif

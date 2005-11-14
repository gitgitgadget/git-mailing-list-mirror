From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Add expat and expat-devel dependencies (for http-push) to RPM spec.
Date: Mon, 14 Nov 2005 00:10:54 -0800
Message-ID: <7vr79j1wfl.fsf@assigned-by-dhcp.cox.net>
References: <4376C797.3050600@matysik.co.nz>
	<Pine.LNX.4.64.0511130942490.3263@g5.osdl.org>
	<437788A0.6030103@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 09:11:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbZQe-0008I4-21
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 09:11:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbVKNIK7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 03:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbVKNIK7
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 03:10:59 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:32712 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750986AbVKNIK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 03:10:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051114081032.KKGR3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 14 Nov 2005 03:10:32 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <437788A0.6030103@op5.se> (Andreas Ericsson's message of "Sun, 13
	Nov 2005 19:40:32 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11772>

> Linus Torvalds wrote:
>> Quite frankly, I'd really prefer to see the git-core-http as a
>> separate package.
>>
>> I think it's ludicrous that people want to split out gitk (because
>> it wants tcl/tk), but that we then add all of these really obscure
>> dependencies for the http part.

One thing we could do is to push http-push out of the common
package and keep http-fetch.  I personally feel that the http
commit walker is as much core as gitk is.  If you are git://
capable that is great, and if you are git+ssh:// capable that
may be even nicer because you could push.  But let's face it:
there are always more pullers than pushers, and everybody can
talk http over his firewall.

Andreas Ericsson <ae@op5.se> writes:

> git-email; This one only uses Email::Valid->address(), so I'll import 
> that function from the perl module so this dependency can be dropped and 
> git-send-email can be in the 'git' package.

Hmph.  This should have occurred to somebody when we did the same
with subprocess.py, but obviously it went unnoticed.

> Programs introducing obscene or plain weird dependencies (cvsimport, 
> svnimport) can be put into their own package, but we should really try 
> to keep those extra packages to a minimum and simply force users who 
> want all the fluffy niceties of the 'git' package to install whatever's 
> required (or install with --nodeps, or from source, or...).

I am not so sure about that.  Why should the number of packages
matter?  We could argue that the current splitting of RPM
packages is half-done in that sense --- we lack the "tying
together" package which itself is empty but depends on
subpackages that implements common client-side.  Call that
git-scm (or "git") and have the end users install it, then it
would pull what it depends on along with it.  No?

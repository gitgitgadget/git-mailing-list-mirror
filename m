From: Junio C Hamano <junkio@cox.net>
Subject: Re: Test fails on ubuntu breezy
Date: Sat, 15 Apr 2006 00:24:44 -0700
Message-ID: <7vbqv3jo77.fsf@assigned-by-dhcp.cox.net>
References: <20060413115447.11819.qmail@science.horizon.com>
	<7vpsjl1ezb.fsf@assigned-by-dhcp.cox.net>
	<cc723f590604142347p7646aa40r52506a0d85b7d817@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 15 09:25:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUf9R-0000M1-Et
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 09:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWDOHYq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 03:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWDOHYq
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 03:24:46 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:43908 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750740AbWDOHYq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Apr 2006 03:24:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060415072445.FNPK20569.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 15 Apr 2006 03:24:45 -0400
To: "Aneesh Kumar" <aneesh.kumar@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18729>

"Aneesh Kumar" <aneesh.kumar@gmail.com> writes:

> I am still having failure with the top of the tree. I guess it is
> because git rm exit with status 0.

Please don't guess, but validate (I know you are capable of
doing so).

What I would do to see what is happening would be to do
something like the attached patch and re-run the test.

BTW, you did "sh -x t3600-rm.sh" which is very good.  I usually
do it when debugging hard-to-debug testsuite problem, especially
ones which I do not know intimately, written by somebody else,
like this:

	sh -x tXXXX-that-test.sh -i

The -i option makes it immediately stop at the first test failure.

-- >8 --
diff --git a/git-rm.sh b/git-rm.sh
index fda4541..622ffca 100755
--- a/git-rm.sh
+++ b/git-rm.sh
@@ -43,6 +43,8 @@ case "$#" in
 	;;
 esac
 
+set -x
+
 if test -f "$GIT_DIR/info/exclude"
 then
 	git-ls-files -z \

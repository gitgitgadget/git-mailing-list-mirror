From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-svn: split the path from the url correctly with limited perms
Date: Fri, 11 Aug 2006 16:40:39 -0700
Message-ID: <7vac6asux4.fsf@assigned-by-dhcp.cox.net>
References: <11553198891741-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 12 01:41:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBgce-00088n-Rs
	for gcvg-git@gmane.org; Sat, 12 Aug 2006 01:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWHKXkl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Aug 2006 19:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWHKXkl
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Aug 2006 19:40:41 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:2041 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751088AbWHKXkl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Aug 2006 19:40:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060811234040.PZGP23903.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 11 Aug 2006 19:40:40 -0400
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <11553198891741-git-send-email-normalperson@yhbt.net> (Eric
	Wong's message of "Fri, 11 Aug 2006 11:11:28 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25243>

Eric Wong <normalperson@yhbt.net> writes:

> This version of the splitter (that only affects SVN:: library
> users) works when one only has limited read-permissions to
> the repository they're fetching from.

This seems to break all of t9100 series test without
GIT_SVN_NO_LIB environment set.

"dpkg -l libsvn-core-perl" reports 1.3.2-3 here.

$ for i in t91*; do echo $i; sh $i; done
t9100-git-svn-basic.sh
define NO_SVN_TESTS to skip git-svn tests
*   ok 1: initialize git-svn
FATAL: Unexpected exit with code 255
t9101-git-svn-props.sh
*   ok 1: checkout working copy from svn
*   ok 2: setup some commits to svn
*   ok 3: initialize git-svn
FATAL: Unexpected exit with code 255
t9102-git-svn-deep-rmdir.sh
*   ok 1: initialize repo
FATAL: Unexpected exit with code 255
t9103-git-svn-graft-branches.sh
FATAL: Unexpected exit with code 255
t9104-git-svn-follow-parent.sh
*   ok 1: initialize repo
FATAL: Unexpected exit with code 255
t9105-git-svn-commit-diff.sh
*   ok 1: initialize repo
FATAL: Unexpected exit with code 9

$ sh t9100-git-svn-basic.sh -i -v
define NO_SVN_TESTS to skip git-svn tests
* expecting success: git-svn init file:///git/t/trash/svnrepo/test-git-svn
*   ok 1: initialize git-svn
* expecting success: git-svn fetch
11 at /git/t/../git-svn line 422
        main::fetch_lib() called at /git/t/../git-svn line 290
        main::fetch() called at /git/t/../git-svn line 149
FATAL: Unexpected exit with code 255

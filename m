From: Junio C Hamano <junkio@cox.net>
Subject: Re: git log is a bit antisocial
Date: Fri, 14 Apr 2006 15:45:14 -0700
Message-ID: <7vd5fjojyd.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0604141647360.2215@localhost.localdomain>
	<7vlku7q3k7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604141719290.2215@localhost.localdomain>
	<7vhd4vq23h.fsf@assigned-by-dhcp.cox.net>
	<1145051072.27704.1.camel@localhost.localdomain>
	<7vu08volrp.fsf@assigned-by-dhcp.cox.net>
	<1145052905.27704.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 15 00:45:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUX2X-000540-2Z
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 00:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWDNWpR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 14 Apr 2006 18:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWDNWpR
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Apr 2006 18:45:17 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:17846 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751305AbWDNWpP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Apr 2006 18:45:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060414224515.KVVR18224.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 14 Apr 2006 18:45:15 -0400
To: =?iso-8859-1?Q?S=E9bastien?= Pierre <sebastien@xprima.com>
In-Reply-To: <1145052905.27704.8.camel@localhost.localdomain>
 (=?iso-8859-1?Q?S=E9bastien?=
	Pierre's message of "Fri, 14 Apr 2006 18:15:05 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18708>

S=E9bastien Pierre <sebastien@xprima.com> writes:

> Anyway, on git 1.2.3, here is something interesting:
>
>>> git log -h
> fatal: Not a git repository
>
>>> git log --help
> Usage: /home/sebastien/Local/bin/git-log [--max-count=3D<n>]
> [<since>..<limit>] [--pretty=3D<format>] [git-rev-list options]

You are talking about old codebase in the maitenance branch,
which is an independent issue, but thanks for noticing anyway.

The attached patch would help with that.

> Which is confusing, so having a consistent behaviour for "git help cm=
d",
> "git cmd help", "git cmd -h" and "git cmd --help" would be nice.
>
> For instance, Darcs works just like that, which makes it easy for
> newbies to find there ways through.

Patches welcome, but a new development should be based on the
"master" branch, not the maintenance 1.2.X series.

-- >8 --
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 025ef2d..d15747f 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -30,7 +30,7 @@ else
 fi
=20
 case "$1" in
-	--h|--he|--hel|--help)
+	-h|--h|--he|--hel|--help)
 	echo "$LONG_USAGE"
 	exit
 esac

From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-checkout doesn't understand -- separator
Date: Mon, 31 Jul 2006 03:06:09 -0700
Message-ID: <7vvepe6qcu.fsf@assigned-by-dhcp.cox.net>
References: <eakisg$e6j$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 31 12:06:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7UfA-0000eR-2e
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 12:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWGaKGM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 06:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWGaKGM
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 06:06:12 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:23444 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750848AbWGaKGL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 06:06:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060731100610.BUDX1537.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 31 Jul 2006 06:06:10 -0400
To: jnareb@gmail.com
In-Reply-To: <eakisg$e6j$1@sea.gmane.org> (Jakub Narebski's message of "Mon,
	31 Jul 2006 11:35:26 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24508>

Jakub Narebski <jnareb@gmail.com> writes:

> git-checkout doesn't understand '--' as a separator between <branch> (which
> is optional, but you can always write HEAD), and <path>...
>
>   1144:jnareb@roke:~/git> git checkout HEAD^ -- gitweb/gitweb.cgi
>   git-checkout-index: -- is not in the cache
>
> Strange...

Perhaps...

diff --git a/git-checkout.sh b/git-checkout.sh
index 5613bfc..580a9e8 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -67,6 +67,10 @@ while [ "$#" != "0" ]; do
 			set x "$arg" "$@"
 			shift
 		fi
+		case "$1" in
+		--)
+			shift ;;
+		esac
 		break
 		;;
     esac

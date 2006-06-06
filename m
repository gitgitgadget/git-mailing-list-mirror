From: Pavel Roskin <proski@gnu.org>
Subject: Re: New release?
Date: Tue, 06 Jun 2006 12:19:19 -0400
Message-ID: <1149610759.27253.9.camel@dv>
References: <Pine.LNX.4.64.0606052002530.5498@g5.osdl.org>
	 <7vodx6zus2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Jun 06 18:19:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FneH8-0005w8-AG
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 18:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWFFQTX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 12:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWFFQTX
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 12:19:23 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:13952 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751320AbWFFQTW
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 6 Jun 2006 12:19:22 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FneH4-0003e7-1J
	for git@vger.kernel.org; Tue, 06 Jun 2006 12:19:22 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FneH1-0002f6-E4; Tue, 06 Jun 2006 12:19:19 -0400
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vodx6zus2.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.7.2.1 (2.7.2.1-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21386>

Hello, Junio!

On Mon, 2006-06-05 at 23:02 -0700, Junio C Hamano wrote:
>          - http-fetch fixes from Nick, which looked obviously correct.
>            I would appreciate test reports from people who saw breakages
>            on this one.

I'm still getting a segfault with the current git from the "next" branch:

$ git-clone http://www.denx.de/git/linux-2.6-denx.git
...
got 4160b8334c53e0881cdc12c1f7d3d54fff883772
got 5f57f29efee48d84e235a8ff75a35e7e354227a7
got 681a9c73a2a321850404d4856f4738be47e17d15
got 29b0ddaa324e417abf153460d7d94fb67823a6ef
got 23e7a5c7d2c13d98524b69f54378d887e1962fc8
/home/proski/bin/git-clone: line 29: 27271 Segmentation fault      git-http-fetch -v -a -w "$tname" "$name" "$1/"

It takes about an hour with my connection from running the command to
the segfault.  It you have any idea how to speed it up, it would be very
helpful.

If I comment out USE_CURL_MULTI, I get compile errors in http.c and
http-push.c.

http.c: In function 'release_active_slot':
http.c:441: error: 'curlm' undeclared (first use in this function)
http.c:441: error: (Each undeclared identifier is reported only once
http.c:441: error: for each function it appears in.)
http.c:445: warning: implicit declaration of function
'fill_active_slots'

http-push.c: In function 'fill_active_slots':
http-push.c:801: error: 'max_requests' undeclared (first use in this
function)
http-push.c:801: error: (Each undeclared identifier is reported only
once
http-push.c:801: error: for each function it appears in.)
http-push.c:811: error: 'curlm' undeclared (first use in this function)
http-push.c: In function 'add_fetch_request':
http-push.c:855: warning: implicit declaration of function
'step_active_slots'

It may be easy to fix for somebody familiar with the code, but I don't
want to do it blindly.

-- 
Regards,
Pavel Roskin

From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Introduce SHA1_FILE_DIRECTORIES
Date: Fri, 06 May 2005 23:31:34 -0700
Message-ID: <7vbr7nbl89.fsf@assigned-by-dhcp.cox.net>
References: <7vmzr8apxc.fsf@assigned-by-dhcp.cox.net>
	<2637.10.10.10.24.1115425225.squirrel@linux1>
	<7vis1vc27f.fsf@assigned-by-dhcp.cox.net>
	<2721.10.10.10.24.1115425962.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Linus Torvalds" <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 08:25:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUIkE-0007EZ-M6
	for gcvg-git@gmane.org; Sat, 07 May 2005 08:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbVEGGbj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 May 2005 02:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbVEGGbj
	(ORCPT <rfc822;git-outgoing>); Sat, 7 May 2005 02:31:39 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:34774 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262729AbVEGGbg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2005 02:31:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050507063135.TZE19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 7 May 2005 02:31:35 -0400
To: "Sean" <seanlkml@sympatico.ca>
In-Reply-To: <2721.10.10.10.24.1115425962.squirrel@linux1> (seanlkml@sympatico.ca's
 message of "Fri, 6 May 2005 20:32:42 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "S" == Sean  <seanlkml@sympatico.ca> writes:

S> Perhaps I'm just missing something in your code,...

Yes you are.  You have spotted a very inconvenient inconsistency
in the interface to the code.

Only on the very first time when it tries to constructs the
alternate directory list, and if there is no alternate list, it
just returns the name without stat(), which forces the callers
to do stat() themselves all the time.  I think I should make it
always stat, since the reading side needs do it anyway.

Thankfully I think Linus had rejected this part in the series.
I'll fix it up.


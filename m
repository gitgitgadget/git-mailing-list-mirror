From: Junio C Hamano <junkio@cox.net>
Subject: Re: bug: git-repack -a -d produces broken pack on NFS
Date: Thu, 27 Apr 2006 15:17:56 -0700
Message-ID: <7v4q0ek6i3.fsf@assigned-by-dhcp.cox.net>
References: <20060427213207.GA6709@steel.home>
	<Pine.LNX.4.64.0604271500500.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 28 00:18:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZEoD-0005x3-Pn
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 00:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbWD0WR7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 18:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751709AbWD0WR6
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 18:17:58 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:39859 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751678AbWD0WR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Apr 2006 18:17:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060427221757.CZMY4388.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 27 Apr 2006 18:17:57 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604271500500.3701@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 27 Apr 2006 15:11:13 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19247>

Linus Torvalds <torvalds@osdl.org> writes:

> That said, the pack-file should all be written with the "sha1write()" 
> interface, which is very careful indeed.
>
> I wonder if the _pack-file_ itself might be ok, and the problem is an 
> index file corruption. For some reason we check the index file first, 
> which is insane. We should check that the pack-file matches its _own_ SHA1 
> first, and check the index file second.

We need to check both, so I fail to see why the order matters.

> If it's just the index file that is corrupt, you may even have a chance to 
> recover the data.
>
> The index file is also written with sha1write(), though, so I really don't 
> see where it would break. Unless you just simply literally have data 
> corruption on the server for some strange reason.

I haven't seen this, and was wondering why.

Independently, and probably unrelated, but another person
reported failure while cloning, but the log appeared it had
trouble spawning the git-index-pack executable for some reason.

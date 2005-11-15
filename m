From: Junio C Hamano <junkio@cox.net>
Subject: Re: Getting rid of symlinks in .git?
Date: Mon, 14 Nov 2005 18:22:37 -0800
Message-ID: <7vhdaevedu.fsf@assigned-by-dhcp.cox.net>
References: <20051110204543.GZ30496@pasky.or.cz> <43746118.30404@hogyros.de>
	<81b0412b0511110443x48415032k8ca40d999071e8a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 03:22:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbqT3-0007yF-Ml
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 03:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbVKOCWj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 21:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbVKOCWj
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 21:22:39 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:20419 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932284AbVKOCWi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 21:22:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051115022146.BFJQ17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 14 Nov 2005 21:21:46 -0500
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0511110443x48415032k8ca40d999071e8a9@mail.gmail.com>
	(Alex Riesen's message of "Fri, 11 Nov 2005 13:43:18 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11872>

Alex Riesen <raa.lkml@gmail.com> writes:

> But you shouldn't care if you have reasonably recent git everywhere:
> symlinks and their absence already handled: .git/config created by
> init-db contains the configuration parameter for filemode, which
> decides whether it is safe to use the symlinks on the underlying
> filesystem.

No, no no nononononono....

core.filemode is whether the executable bit is trustworthy and
does not have anything to do with symlinked heads, although
these two happen to become problematic on VFAT.

Currently we have USE_SYMLINK_HEAD and have failing symlink()
call fall back on regular file symrefs.

But this may not matter as long as nobody would want to force
regular file symrefs on a filesystem that is capable of doing a
symlink.  That is the only thing we cannot do right now.

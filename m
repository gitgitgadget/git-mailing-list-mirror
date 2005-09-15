From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Remove shell dependency in env.c
Date: Thu, 15 Sep 2005 00:58:39 -0700
Message-ID: <7vy85yahjk.fsf@assigned-by-dhcp.cox.net>
References: <43290BB8.90501@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 15 09:58:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFodp-0000jt-Az
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 09:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbVIOH6m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 03:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbVIOH6m
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 03:58:42 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:14552 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750770AbVIOH6l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2005 03:58:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050915075840.QVES3588.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 15 Sep 2005 03:58:40 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43290BB8.90501@zytor.com> (H. Peter Anvin's message of "Wed, 14
	Sep 2005 22:50:48 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8593>

"H. Peter Anvin" <hpa@zytor.com> writes:

> This patch adds an invocation of "env", so rsh.c works for C-shell users 
> as well as Bourne shell users.

Hmph.  I think the original code is buggy already.  If the path
has a single quote in it, you would get into a problem.  If the
remote end first interprets what is given to it with C-shell,
then it probably would also barf if path had a '!' in it, too,
even though we quote the entire thing within a single-quote
pair.

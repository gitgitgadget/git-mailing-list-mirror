From: Junio C Hamano <junkio@cox.net>
Subject: Re: [zooko@zooko.com: [Revctrl] colliding md5 hashes of
 human-meaningful
Date: Mon, 13 Jun 2005 13:46:29 -0700
Message-ID: <7vd5qqf0ii.fsf@assigned-by-dhcp.cox.net>
References: <20050613195038.9191.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 22:42:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dhvkz-0003sh-6x
	for gcvg-git@gmane.org; Mon, 13 Jun 2005 22:42:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVFMUqn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Jun 2005 16:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbVFMUqn
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jun 2005 16:46:43 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:20931 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261303AbVFMUqb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2005 16:46:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050613204630.SQES8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 13 Jun 2005 16:46:30 -0400
To: linux@horizon.com
In-Reply-To: <20050613195038.9191.qmail@science.horizon.com> (linux@horizon.com's
 message of "13 Jun 2005 19:50:38 -0000")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>> So the problem is totally different from the way git uses a hash. In the 
>> git model, an attacker by definition cannot control both versions of a 
>> file, since if he controls just _one_ version, he doesn't need to do the 
>> attack in the first place!

> You are insufficiently paranoid, Grasshopper.

> The basic attack goes like this:

> - I construct two .c files with identical hashes.  One is something
>   useful; perhaps a device driver for some piece of hardware that my
>   desired target has.  The other is similar, but includes a remote
>   root explot.

>   (With an n-bit hash and an automated way to make harmless changes
>   to source files, I can generate 2^(n/2) variants of each and expect to
>   get a match, even in the absence of a better attack.)

> - I submit the first one to the Linux kernel.  It's valid and gets
>   merged.

I doubt that this part would work in practice.

Wouldn't you have to have some "garbage" in the early part of
that driver source, probably in a C comment block or an
otherwise unused string constant, that serves no apparent
purpose, which is inserted by your "automated harmless changes"
machinery?

Wouldn't that catch people's attention and cause them to
question and reject that patch in the first place?

Wouldn't that mean you do not have control over even _one_
version, let alone _both_ versions?


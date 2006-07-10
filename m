From: Junio C Hamano <junkio@cox.net>
Subject: Re: Revisiting large binary files issue.
Date: Mon, 10 Jul 2006 16:14:19 -0700
Message-ID: <7v7j2l833o.fsf@assigned-by-dhcp.cox.net>
References: <20060710230132.GA11132@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 01:14:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G04xM-0006kM-3X
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 01:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbWGJXOV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 19:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbWGJXOV
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 19:14:21 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:59796 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S964787AbWGJXOU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 19:14:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060710231420.YBLY6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Jul 2006 19:14:20 -0400
To: Carl Baldwin <cnb@fc.hp.com>
In-Reply-To: <20060710230132.GA11132@hpsvcnb.fc.hp.com> (Carl Baldwin's
	message of "Mon, 10 Jul 2006 17:01:32 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23666>

Carl Baldwin <cnb@fc.hp.com> writes:

> First, I would like to be able to set the packing window to 0 for all of
> the git commands.  It would be nice if I could set this in a
> per-repository config file so that any push/fetch operation would honor
> this window.  Is there currently a way to do this?

Should not be hard to add.

> Second, I would like to not pay the penalty to inflate and then deflate
> the objects into the pack when I use a window of 0.  How hard would this
> be?  I am a capable programmer and wouldn't mind getting my hands dirty
> in the code to implement this if someone could point me in the right
> direction.

The problem is that unpacked objects have the single line header
(type followed by its inflated size in decimal) which starts the
deflated stream, while in-pack representation of non-delta does
not.

There was an attempt to help doing this, but I haven't pursued it.

	http://article.gmane.org/gmane.comp.version-control.git/17368

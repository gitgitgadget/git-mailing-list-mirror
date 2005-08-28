From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-repack-script: Add option to repack all objects
Date: Sun, 28 Aug 2005 14:06:31 -0700
Message-ID: <7vbr3hlqjs.fsf@assigned-by-dhcp.cox.net>
References: <43102727.2050206@tuxrocks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 28 23:07:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9UMS-000298-Jj
	for gcvg-git@gmane.org; Sun, 28 Aug 2005 23:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbVH1VGe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Aug 2005 17:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbVH1VGe
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Aug 2005 17:06:34 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:48824 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750802AbVH1VGd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2005 17:06:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050828210633.IWAA19627.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 28 Aug 2005 17:06:33 -0400
To: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7885>

Frank Sorenson <frank@tuxrocks.com> writes:

> This patch adds an option to git-repack-script to repack all objects,
> including both packed and unpacked.  This allows a full repack of
> a git archive (current cogito packs from 39MB to 4.5MB, and git packs
> from 4.4MB to 3.8MB).
>
> Signed-off-by: Frank Sorenson <frank@tuxrocks.com>

While I agree that giving more flexibility to repack objects is
a good idea, I am not sure rolling all existing objects into one
pack and removing the existing one is a good way to go.

I'd do this slightly differently.  I do not think removing
existing pack belongs to this command.  We would probably want a
separate tool to find extra/redundant packs and remove them, or
more generally optimize packs by selectively exploding them and
repacking them ("pack optimizer").

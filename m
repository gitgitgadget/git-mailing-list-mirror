From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] GIT commit statistics.
Date: Mon, 14 Nov 2005 01:27:08 -0800
Message-ID: <7vd5l3zij7.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
	<7v4q6ilt3m.fsf@assigned-by-dhcp.cox.net>
	<43758D21.3060107@michonline.com>
	<7v7jbeia3v.fsf_-_@assigned-by-dhcp.cox.net>
	<46a038f90511120419v70166c60t93d58b7544e03e3b@mail.gmail.com>
	<7vy83s95k0.fsf@assigned-by-dhcp.cox.net>
	<46a038f90511131242p4692c74fn20c015998620b9f4@mail.gmail.com>
	<7vlkzr6gzz.fsf@assigned-by-dhcp.cox.net>
	<46a038f90511132001x6a9109fk17593b7ceaf3177e@mail.gmail.com>
	<7vwtjb4vc4.fsf@assigned-by-dhcp.cox.net>
	<46a038f90511140051o1fa5ef7cyb9dd723fb8161ef9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 10:29:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbacL-0000NI-RR
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 10:27:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbVKNJ1L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 04:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbVKNJ1L
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 04:27:11 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:17130 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751033AbVKNJ1K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 04:27:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051114092637.KRKU6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 14 Nov 2005 04:26:37 -0500
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90511140051o1fa5ef7cyb9dd723fb8161ef9@mail.gmail.com>
	(Martin Langhoff's message of "Mon, 14 Nov 2005 21:51:29 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11778>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> I'm curious. What would be the advantages of this over git-read-tree
> -m for use within a single repo?

On a large tree I had an impression that applying patch and then
falling back on 3-way is faster, but other than that, nothing,
really.  Just being able to use a single mechanism, which does
not buy us much.

> OTOH,  if this is heading towards teaching git-am how to apply changes
> to binary files based on known SHA1s, this will give birth to a type
> of patch that applies only if you have the objects beforehand. Is that
> enough to get by? Perhaps we need a format to fully describe binary
> files?

I'd rather not see our "patch" go in the direction of recording
both pre- and post-image of blob for binary files, which is what
we would end up doing if we really want to do binary flexibly.

Well, that may be nice as an option, but not by default.

An option halfway in between would be to record the pre-image
SHA1 and post- blob, perhaps compressed-uuencoded.  This would
limit us to the case that the recipient has not touched the
binary file and replacing it, but in practice that might be
enough.

I'm willing to do the C hackery myself if there is enough
interest in it.

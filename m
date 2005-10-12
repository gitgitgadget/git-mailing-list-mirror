From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-fetch --tags: deal with tags with spaces in them.
Date: Tue, 11 Oct 2005 22:29:45 -0700
Message-ID: <7vk6gjl2uu.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90510062014l7f5740e0l77fc53b50f822e8f@mail.gmail.com>
	<46a038f90510082014i6b296f2bvbac56e25344cbdf2@mail.gmail.com>
	<4349ED5D.6020703@catalyst.net.nz>
	<7v4q7p927d.fsf@assigned-by-dhcp.cox.net>
	<7vzmpgznfj.fsf_-_@assigned-by-dhcp.cox.net>
	<7virw4zlod.fsf_-_@assigned-by-dhcp.cox.net>
	<7vzmpgy4g4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Wed Oct 12 07:30:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPZBr-0001nl-9C
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 07:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbVJLF3s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 01:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbVJLF3s
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 01:29:48 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:1924 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932450AbVJLF3r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2005 01:29:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051012052938.KIJP16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 12 Oct 2005 01:29:38 -0400
To: git@vger.kernel.org
In-Reply-To: <7vzmpgy4g4.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 10 Oct 2005 23:04:43 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10008>

Junio C Hamano <junkio@cox.net> writes:

> We cannot still do arbitrary reference names, but at least now
> we allow spaces in them.  But I am not sure if this is a good
> change.
>
> Do we in general want to support references with [^-a-zA-Z0-9.]
> in them?  Most notably spaces?
>
> Opinions?

Here is mine.

I do not personally think it is too much of a restriction if we
said we only allow tags using letters from [-a-zA-Z0-9.] (yes I
am trying to be controversial by not allowing even latin-1
names).  Even without going that far, if we just said we do not
allow shell metacharacters in tagnames (i.e. assuming UTF-8
encoded pathnames, non-ascii part of unicode character space is
allowed), I suspect things will get much simpler to handle.

The troublesome tags Martin's repository had were autocreated
with cvsimport.  That is something we could easily fix (I think
we already do certain tagname munging).

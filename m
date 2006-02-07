From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-http-push and hooks
Date: Tue, 07 Feb 2006 13:17:13 -0800
Message-ID: <7vwtg6uaw6.fsf@assigned-by-dhcp.cox.net>
References: <20060206205203.GA20973@guybrush.melee>
	<20060206232231.GK3873@reactrix.com>
	<20060207195458.GA7217@c165.ib.student.liu.se>
	<20060207202351.GA3833@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 22:17:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6aDC-0001Kv-3L
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 22:17:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965172AbWBGVRR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 16:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965185AbWBGVRR
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 16:17:17 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:37566 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S965172AbWBGVRP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2006 16:17:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060207211426.MKMB17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 7 Feb 2006 16:14:26 -0500
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20060207202351.GA3833@reactrix.com> (Nick Hengeveld's message of
	"Tue, 7 Feb 2006 12:23:51 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15716>

Nick Hengeveld <nickh@reactrix.com> writes:

> There are options for a DAV-only environment though.  While the hooks
> themselves can't be run, git-http-push can be modified to update the
> remote pack and ref info (although it's not clear to me under what
> conditions it should do so...)  DAV-specific versions of pack
> management utilities are feasible as well.

If the server info updates is the _only_ problem, then perhaps
that would be the easiest and cleanest.  Whenever you update or
add a ref you would need to update info/refs (otherwise
ls-remote would not give you the latest info), and whenever you
repack you would need to update objects/info/packs.

You may probably want to have a CGI to allow you manage the
repository remotely anyway, to trigger a repack or remove a
stale branch head, for example.  Once you go that route maybe
having the CGI to do something like the pack protocol for more
efficient transfer might become more attractive.

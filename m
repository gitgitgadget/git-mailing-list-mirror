From: Junio C Hamano <junkio@cox.net>
Subject: Re: please pull ppc64-2.6.git
Date: Tue, 30 Aug 2005 15:25:22 -0700
Message-ID: <7v8xyjhxkd.fsf@assigned-by-dhcp.cox.net>
References: <17170.25803.413408.44080@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0508291006440.3243@g5.osdl.org>
	<17171.39652.237263.484079@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0508291706230.3243@g5.osdl.org>
	<1125438048.9705.43.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 31 00:26:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EAEXm-0002QK-W7
	for gcvg-git@gmane.org; Wed, 31 Aug 2005 00:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbVH3WZY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Aug 2005 18:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbVH3WZY
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Aug 2005 18:25:24 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:13047 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751385AbVH3WZX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2005 18:25:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050830222523.MPAF8185.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 30 Aug 2005 18:25:23 -0400
To: Christian Meder <chris@absolutegiganten.org>
In-Reply-To: <1125438048.9705.43.camel@localhost> (Christian Meder's message
	of "Tue, 30 Aug 2005 23:40:48 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7966>

Christian Meder <chris@absolutegiganten.org> writes:

> Is alternates unthinkable with URLs (e.g. remote alternates).

In order to read an object data, the low level core GIT layer
does open()/mmap() of a file on the locally mounted filesystem.
It also does opendir()/readdir()/closedir() to find what's
available.

If you can arrange to automount via luserfs (or whatever; we do
not care much about particular implementation) so that it can do
these filesystem operations, git will happily use it.

Even in that case, the alternate you would tell git should look
like a local filesystem path --- your automounting from remote
specified with URL for such a path would happen outside GIT.

From: Junio C Hamano <junkio@cox.net>
Subject: Re: Can't export whole repo as patches
Date: Fri, 07 Apr 2006 12:18:27 -0700
Message-ID: <7vr749i48s.fsf@assigned-by-dhcp.cox.net>
References: <20060407184701.GA6686@xp.machine.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 07 21:18:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRwTu-0006yz-Ua
	for gcvg-git@gmane.org; Fri, 07 Apr 2006 21:18:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbWDGTSo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Apr 2006 15:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbWDGTSo
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Apr 2006 15:18:44 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:2702 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S964901AbWDGTS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Apr 2006 15:18:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060407191829.KKZU20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 7 Apr 2006 15:18:29 -0400
To: Peter Baumann <peter.baumann@gmail.com>
In-Reply-To: <20060407184701.GA6686@xp.machine.de> (Peter Baumann's message of
	"Fri, 7 Apr 2006 20:47:01 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18503>

Peter Baumann <peter.baumann@gmail.com> writes:

> How can I get the inital commit as a patch?

format-patch is designed to get a patch to send to upstream, and
does not handle the root commit.  In your two revisions
repository, you could do something like this:

	$ git diff-tree -p --root master~1

Or more in general:

	$ git rev-list master |
          git diff-tree --stdin --root --pretty=fuller -p

BTW, I've been meaning to add --pretty=patch to give
format-patch compatible output to diff-tree, but haven't got
around to actually do it.  Another thing I've been meaning to do
is "git log --diff" which is more or less "git whatchanged".

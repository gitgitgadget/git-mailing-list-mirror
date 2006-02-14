From: Junio C Hamano <junkio@cox.net>
Subject: Re: maildir / read-tree trivial merging getting in the way?
Date: Mon, 13 Feb 2006 18:28:00 -0800
Message-ID: <7vy80ewu6n.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.60.0602140217380.19093@mundungus.clifford.ac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 03:28:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8pvJ-0000xB-HK
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 03:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbWBNC2E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 21:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbWBNC2E
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 21:28:04 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:46464 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750942AbWBNC2C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2006 21:28:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060214022537.SKQC17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 13 Feb 2006 21:25:37 -0500
To: Ben Clifford <benc@hawaga.org.uk>
In-Reply-To: <Pine.LNX.4.60.0602140217380.19093@mundungus.clifford.ac> (Ben
	Clifford's message of "Tue, 14 Feb 2006 02:18:19 +0000 (GMT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16103>

Ben Clifford <benc@hawaga.org.uk> writes:

> So basically my question is: should I feel dirty about doing this and
> diddle read-tree so that there's a flag to not do the trivial merges
> automatically?

I am mildly negative about touching read-tree for this kind of
non-SCM'ish usage.

If you are doing read-tree without doing any trivial merge, then
you would use ls-files to inspect each stage, decide what the
final shape of the tree you want, and construct such a tree in
the index.

That would be more naturally done by writing that thing in a
more reasonable scripting language (not shell, but Perl or
Python), call ls-tree three times, do whatever merge to come up
with the final shape of the tree, and then construct the tree
with a single invocation of "update-index --index-info", maybe
even starting from an empty index file.

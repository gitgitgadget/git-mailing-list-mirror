From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: [PATCH 1/3] Prepare for non-interactive merge-preserving rebase
Date: Sat, 27 Sep 2008 14:20:07 -0500
Organization: Exigence
Message-ID: <20080927142007.a75a31a0.stephen@exigencecorp.com>
References: <48D95836.6040200@op5.se>
	<20080923162211.d4b15373.stephen@exigencecorp.com>
	<48DE7386.2080808@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sat Sep 27 21:21:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjfM9-0005Wc-IA
	for gcvg-git-2@gmane.org; Sat, 27 Sep 2008 21:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753697AbYI0TUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2008 15:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753593AbYI0TUU
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Sep 2008 15:20:20 -0400
Received: from smtp142.sat.emailsrvr.com ([66.216.121.142]:56362 "EHLO
	smtp142.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531AbYI0TUT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2008 15:20:19 -0400
Received: from relay4.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay4.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 5A03A27B101;
	Sat, 27 Sep 2008 15:20:17 -0400 (EDT)
Received: by relay4.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id BCCA3277A1F;
	Sat, 27 Sep 2008 15:20:16 -0400 (EDT)
In-Reply-To: <48DE7386.2080808@op5.se>
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96918>


> Stephen, are you using this in production?

Kind of--I have not distributed a patched version of pull. But I have
written test cases on our side and manually executing `GIT_EDITOR=:
git rebase -i -p` works very well.

Past occurrences aside, no one has needed to rebase a local merge yet.

> How's it turning out?

I think it's great, but the primary problem will be getting devs to
actually remember to use it. E.g. I don't think they will type out:

    git pull --rebase --preserve-rebase

Every time they pull. And they definitely don't do our current hack:

    git fetch
    GIT_EDITOR=: git rebase -i -p

I do have a wrapper shell script for people to use, but it hasn't seen
wide adoption yet. We have a draconian hook script that tries to
detect merges that should have been rebases and reject them, but
it's disabled for tweaking right now--when it gets turned back on,
I think more people will use the script.

In the long term, having "branch.name.preservemerges" and
"branch.autosetuppreservemerges" config options to parallel the
"branch.name.rebase" option and get us back to just "git pull"
would be great.

I've been meaning to submit patches for these two config options--I
figure I can hunt down how "branch.name.rebase" works and do the
appropriate copy/paste, but I haven't dedicated any time to it yet.

Thanks,
Stephen

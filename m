From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach git-svn how to catch up with its tracking branches
Date: Wed, 07 May 2008 18:55:28 -0700
Message-ID: <7v63tpd0fj.fsf@gitster.siamese.dyndns.org>
References: <20080508013956.GA24956@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu May 08 03:56:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtvMy-0004uD-0j
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 03:56:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754641AbYEHBzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 21:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755493AbYEHBzh
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 21:55:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63339 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754292AbYEHBzg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 21:55:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 879EC197F;
	Wed,  7 May 2008 21:55:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id CDCD0197D; Wed,  7 May 2008 21:55:30 -0400 (EDT)
In-Reply-To: <20080508013956.GA24956@midwinter.com> (Steven Grimm's message
 of "Wed, 7 May 2008 18:39:56 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D8E8D936-1CA1-11DD-9E7F-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81497>

Steven Grimm <koreth@midwinter.com> writes:

> In environments where a lot of people are sharing an svn repository using
> git-svn, everyone has identical, but individually maintained, tracking
> branches. If the svn repository is very active, it can take a while to
> run "git svn fetch" (which has to individually construct each revision
> by querying the svn server). It's much faster to run "git fetch" against
> another git-svn repository to grab the exact same git revisions you'd get
> from "git svn fetch". But until now, git-svn was confused by this because
> it didn't know how to incrementally rebuild its map of revision IDs.
> The only choice was to completely remove the map file and rebuild it
> from scratch, possibly a lengthy operation when there's a lot of history.
>
> With this change, git-svn will try to do an incremental update of its
> revision map if it sees that its tracking branch has svn revisions that
> aren't in the map yet.

Being able to have a shared git-svn managed git repository that mirrors
svn is something people have asked often enough, but the recommended
practice has always been for each to have his own copy.

Although I do not use git-svn heavily myself, I like this addition.  We
would probably want to update the in-tree doc to cover a recommended
pattern of interacting multiple git repositories with a single svn
repository on the other side?

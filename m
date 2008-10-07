From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: [PATCH RFC] rebase--interactive: if preserving merges, use
 first-parent to limit what is shown.
Date: Tue, 7 Oct 2008 01:36:54 -0500
Organization: Exigence
Message-ID: <20081007013654.274e5cf6.stephen@exigencecorp.com>
References: <48E8DD7E.9040706@redhat.com>
	<20081006102118.3e817a0f.stephen@exigencecorp.com>
	<20081006212021.04ba9214.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Avi Kivity <avi@redhat.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 08:38:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn6Ct-0007AB-O2
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 08:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbYJGGg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 02:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbYJGGg5
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 02:36:57 -0400
Received: from smtp202.sat.emailsrvr.com ([66.216.121.202]:50499 "EHLO
	smtp202.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbYJGGg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 02:36:56 -0400
Received: from relay10.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay10.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id D935B11B0D0F;
	Tue,  7 Oct 2008 02:36:55 -0400 (EDT)
Received: by relay10.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id 757F49B2464;
	Tue,  7 Oct 2008 02:36:55 -0400 (EDT)
In-Reply-To: <20081006212021.04ba9214.stephen@exigencecorp.com>
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97675>


> So, unless I think of something else, I'm done hacking on this and am
> withdrawing the patch.
>
> Though I am curious--with the sequencer, is the Avi/my request of not
> listing out-of-band commits in the todo file going to be handled?
> 
> Some sort of "--first-parent-unless-included-in-rebase" flag.

Okay, I lied--I have a patch that implements this behavior, passes Avi's
script-turned-test, and passes t3404. It implements the above algorithm
of, if in preserving merges mode, start with only first parents in the
todo list, and then recursively prepend right hand side commits to the
todo list only if their parents are going to be rewritten. This drops a
lot of cruft from rebase-i-p with large merges and is very cool, IMHO.

However, lest I burn my "PATCH v2" opportunity, I'm holding off on
posting the updated patch. It works and passes tests but I'm sure I'll
tinker with it some more over the next few days. It will also likely
conflict with my pu sh/maint-rebase3 patch, so I don't know whether to
base it on top of that one or not (guessing not).

Also, I think the patch itself is less interesting than the discussion
of whether this "first parent only" behavior is desired or not.

Obviously I think so--do others agree/disagree?

I've read more into the sequencer, and from what I can tell it still
just drives off a todo of pick/etc. input, and does not generate the
todo itself. So I think my patch is still fair game in terms of how to
generate either the current or the next generation rebase-i-p todo list.

I could be wrong on that though.

Thanks,
Stephen

From: Junio C Hamano <gitster@pobox.com>
Subject: [1.8.0] Summary of the discussions
Date: Thu, 17 Feb 2011 17:02:47 -0800
Message-ID: <7vwrky5f48.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 18 02:03:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqEkP-0001x1-OJ
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 02:03:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754539Ab1BRBC5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 20:02:57 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50040 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752213Ab1BRBC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 20:02:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B6E1C34F8;
	Thu, 17 Feb 2011 20:03:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=/+TH
	BqtwPXHfUHU43WVXnE3u6Qo=; b=lq0PpPoICO0FExv0gjKVB1XAUhWsl9fOKUXK
	Sg5QBdR+Q4TYzSWuTuzkLTM/3ei4MH1Sdzu3lj/d9kBFvtxzu8DrBi3XGUOyEVXO
	6i5rZLbwSKdsnq59xeWCNAjg8yc1lli7NLhA4ntcrp5amlA1bvpUh25ePnU6HyZh
	8dfhEk4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=CsQ
	FMnG0xSYmNqTDchoFll2W7HQDfnjKx4OrmPoO1YnpCK7fwHe5wTXviiD8rxsxri7
	BB8Yo6XawY/3EHEXkgMq20Ir+/3cIn4t79hM8eP5Q4eDXqmytV3+MdpWivf9+m0O
	HR4BkfWnjDOsVhmEpzZcBuQAF8QSWTxYpk2yjhcw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A371D34F7;
	Thu, 17 Feb 2011 20:03:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A5F7D34F3; Thu, 17 Feb 2011
 20:03:56 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F74BD318-3AFA-11E0-8E07-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167149>

It seems that not many things need breaking, but we will break some.

Here are the ones that needed discussion and were discussed that I am
aware of, with my comments (which shouldn't be read as final decision).

The next step will be to design the migration path, and execution.

 * "git branch --set-upstream <name>" should not be about setting the
   upstream of <name> to the current branch.

   From: Jay Soffian <jaysoffian@gmail.com>
   Date: Tue, 1 Feb 2011 01:57:03 -0500
   Message-ID: <AANLkTinUn2SMijphe3EmPMVOOwBjPB5ffFwwqZVxQmW0@mail.gmail.com>

   -- summary --

   The current behaviour is misdesigned. It should be setting the upstream
   of the current branch to <name>.

   -- comments --

   I agree.

 * "git push" default semantics will be "upstream" (renamed from
   "tracking"), not "matching".
   
   From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
   Date: Mon, 14 Feb 2011 22:57:24 +0100
   Message-ID: <vpqr5bath2z.fsf@bauges.imag.fr>

   -- comments --

   Ok.

 * "git merge" without "what to merge" default to @{upstream}

   From: Junio C Hamano <gitster@pobox.com>
   Date: Mon, 31 Jan 2011 12:50:30 -0800
   Message-ID: <7vzkqg4x2h.fsf_-_@alter.siamese.dyndns.org>

   -- summary --

   Instead of failing, "git merge" to behave more in line with "git pull".

   -- comments --

   I think this makes sense.

 * Unify pathspec semantics

   From: Junio C Hamano <gitster@pobox.com>
   Date: Mon, 31 Jan 2011 09:07:14 -0800
   Message-ID: <7voc6x57el.fsf_-_@alter.siamese.dyndns.org>
   
   -- summary --

   Some commands and operations understand leading-path-components but not
   globs, while many others do. This inconsistency leads to some surprises.
   Make everybody understand globs.

   -- comments --

   This is already underway, I think.

 * Making more operations full-tree by default.

   From: Jeff King <peff@peff.net>
   Date: Wed, 9 Feb 2011 18:46:21 -0500
   Subject: Re: "git add -u" broken in git 1.7.4?
   Message-ID: <20110209234621.GA12575@sigill.intra.peff.net>

   -- summary --

   These two commands currently affect only paths within the current
   working directory when run from a subdirectory without a pathspec:

   . "add -u"
   . "add -A"

   Make them to add everything in the working tree, from the root level,
   even when they are run from a subdirectory.

   The following are left as exceptions, keeping the current behaviour to
   work within the current directory given no pathspecs:

   . "grep"
   . "archive"
   . "clean"

   Plumbing like these are also left as exceptions.

   . "ls-files"
   . "ls-tree"

   -- comments --

   As long as transition plan is made carefully, I think this is fine.

 * Extend "separate remote" to tags and notes.

   From: Johan Herland <johan@herland.net>
   Date: Mon, 07 Feb 2011 04:35:31 +0100
   Message-ID: <201102070435.31674.johan@herland.net>

   -- summary --

   Instead of using refs/remotes/origin/$branch to store copies of
   branches, which has two downsides:

    - HEAD as the "primary branch pointer" and as a branch name could
      collide;
    - tags are forced into a single global namespace. 

   Use refs/remotes/origin/{HEAD,heads/$branch,tags/$tag} to track what
   we copy from a remote in separate namespaces.

   -- comments --

   Making this coexist with repositories created before 1.8.0 might be
   tricky, but otherwise this is fine.

 * "git checkout refs/heads/<name>" checks out <name> branch.

    From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
    Date: Mon, 7 Feb 2011 06:01:51 -0500 (EST)
    Message-ID: <alpine.DEB.1.10.1102062234010.3788@debian>

    -- summary --

    In addition to "git checkout <name>" that names an existing branch,
    special case "git checkout refs/heads/<name>" to check the branch out,
    instead of detaching HEAD at the tip of the branch.  If you want to
    detach at a specific commit and wanted to disambiguate <name> that is
    both a branch and another ref by checking out refs/heads/<name>, your
    workflow will be broken by this change, but you can still say
    refs/heads/<name>^0 to work it around.

    -- comments --

    I do not think this backward incompatible breakage would seriously
    hurt in practice, and if people see newbies are hurt by getting a
    detached HEAD when they check out refs/heads/<name>, this proposal
    might be an improvement, but I have a feeling that this may be trying
    to solve a wrong problem.

    Why are these people _tempted_ to type refs/heads/ explicitly?  It
    could be our tutorial or documentation.  That might be the thing to
    fix.

 * "git fetch $from $branch..." to update tracking branches

   From: Thomas Rast <trast@student.ethz.ch>
   Date: Mon, 31 Jan 2011 22:44:09 +0100
   Message-ID: <201101312244.10047.trast@student.ethz.ch>

   -- summary --

   Traditionally, giving explicit refspecs from the command line was a way
   to disable the tracking copy specified with "remote.<name>.fetch"
   configuration. A good workflow should however not rely on such a
   "pretending that a bad update on the other side did not happen".
   Always update tracking branches we observed with "git fetch".

   -- comments --

   I think this makes sense.

 * Moving files around in the source tree, thinning the top-level.

   From: Nicolas Pitre <nico@fluxnic.net>
   Date: Mon, 31 Jan 2011 15:28:37 -0500 (EST)
   Message-ID: <alpine.LFD.2.00.1101311459000.8580@xanadu.home>

   -- summary --

   well not concrete enough concensus to summarize other than "too many
   files at the top is considered ugly".

   -- comments --

   I am not tempted to do the heavy-lifting myself; as long as the
   resulting tree looks sane, I won't object ;-)

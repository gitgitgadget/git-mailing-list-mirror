From: Chris Webb <chris@arachsys.com>
Subject: Re: Editing the root commit
Date: Wed, 20 Jun 2012 10:32:05 +0100
Message-ID: <20120620093205.GB10579@arachsys.com>
References: <20120619091657.GA28005@arachsys.com>
 <7vy5nj1uld.fsf@alter.siamese.dyndns.org>
 <20120619111709.GC10692@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 11:32:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShHGo-0007VI-FY
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 11:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755791Ab2FTJcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 05:32:09 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:41975 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416Ab2FTJcI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 05:32:08 -0400
Received: from [81.2.114.212] (helo=arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1ShHGg-0007kO-RO; Wed, 20 Jun 2012 10:32:07 +0100
Content-Disposition: inline
In-Reply-To: <20120619111709.GC10692@arachsys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200290>

Chris Webb <chris@arachsys.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > Even though I wouldn't bother doing this myself, I wouldn't mind
> > reviewing a patch series ;-)
> 
> Okay, I'll take a look when I finish my current project!

I had a bit of spare time this morning and had a quick look through
git-rebase--interactive.sh.

Apart from the validation, message and reflog code in git-rebase.sh and
git-rebase--interactive.sh that would need fixing up to know about this
case, the essence of this seems to be starting with an orphan commit instead
of a commit descended from $onto right at the end of --interactive.

I'd love to write something like

  git checkout ${onto:---orphan}

(or a variant) but can git be persuaded to have an orphan detached HEAD like
that?

An orphan branch appears to involve HEAD containing 'ref: refs/heads/foo'
where refs/heads/foo doesn't exist yet, but I get 'not a git repo' instead
of an orphan detached HEAD with either :>.git/HEAD or rm .git/HEAD.

Cheers,

Chris.

From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Supporting more gitweb diff possibities
Date: Mon, 26 Mar 2007 18:11:38 +0100
Message-ID: <200703261911.39328.jnareb@gmail.com>
References: <20070325202642.GA20201@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Mon Mar 26 19:11:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVsiu-0003jP-LG
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 19:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012AbXCZRLJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 13:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753029AbXCZRLJ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 13:11:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:59275 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753012AbXCZRLH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 13:11:07 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1654982uga
        for <git@vger.kernel.org>; Mon, 26 Mar 2007 10:11:02 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=tqDvWPAZB/lyJSU/a1LPVz1k7wB1BAPCDm9DfQ7+JQMGDrsCbAT6bZTU3VsxBlnWLBD37gndjPiF/5FLMdscgURhlBp8fhaojGepRokSscZyDsTqPv4Sd8qqC72zQCEdD+IfxmGxpOHh854vmBglXsahIAlCxlrWCREJ05+UvKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=F1VotlWfO6J16pW3t8CBEOR3RzXZFqmx5HAMjeMeEDtVSnZx0TcN3t1XRPFMEABHjtrVozyf8zTpftgtVcWrBfB99saWGsTqNknWj9ug4haz+avZPvdgSO3NsMD8tFDk3++VgCHXtezdSKQtPGic0r7kB8/EyHQNwJokXxJOaKw=
Received: by 10.78.81.20 with SMTP id e20mr3121488hub.1174929062025;
        Mon, 26 Mar 2007 10:11:02 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id e9sm22102910muf.2007.03.26.10.10.58;
        Mon, 26 Mar 2007 10:10:59 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070325202642.GA20201@auto.tuwien.ac.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43162>

On Sun, Mar 25, 2007, Martin Koegler wrote:

> I have done a first series of 6 patches, which improves blobdiff and
> adds treediff.

Just a few nits.

First, I think it would be better to have individual patches to be
replies to this cover letter, either directly (all patch mails
are replies to cover letter) or indirectly (i.e. chained, the later
patch is reply to earlier patch, first patch ir reply to cover letter).

Second, it is a good idea to _number_ patches in series, i.e. have
  "[PATCH 0/6] Supporting more gitweb diff possibities"
as cover letter subject, and number patches respectively. The option
`-n' of git-format-patch (together with --start-number if you make
patches one by one) takes care of that.

> [PATCH] gitweb: show no difference message

This should be I think: 
  "[PATCH 1/6] gitweb: show "no difference" message for empty diff"

> This patch shows an "no difference" message instead of nothing for
> equal objects.

This is a good patch, worth doing even without rest of the patches.

Currently we have only one place (I think) where gitweb can generate
link to "blobdiff", namely "diff to parent" link in "history" view
for plain file, when e.g. some change was (explicitely or accidentally)
reverted.

The few comments about style (variable naming, CSS style for 
"no differences" message) are in the reply to the patch.

> [PATCH] gitweb: Support comparing blobs with different names
> 
> This patch adds support for comparing objects with different file
> names using hb/hbp.

Good idea; I have replied with an alternate solution, involving adding
'fp' to git-diff-tree path limit instead of git-diff with hpb:fp.

I'm sorry for the confusing advice wrt. git_blobdiff and rename diffs.

> [PATCH] gitweb: link base commit (hpb) to blobdiff output
> 
> Add link the parent commit, as there is currently no such link.

I'm rather ambivalent about this patch. Perhaps there is currently no such
link, but you can always click on one of the links to parent blob, and
from blob view to commit, commitdiff or tree.

By the way, the "(from: _commitdiff_)" link in "commitdiff" view
(and similar one in "commit" view) is part of the "next link" family
of "(parent: _commitdiff_)" and "(merge: _commitdiff_ _commitdiff_)"
which allow to go down the line of parents without need to change
views (or go to the 'parent' header in the case of "commit" view),
just like you would press PageDown during "git log" or "git log -p"
invocation from the command line. "(from: _commitdiff_)" was added
only for completeness (and because it was easy to do).

> [PATCH] gitweb: support filename prefix in git_patchset_body
> [PATCH] gitweb: support filename prefix in git_difftree_body

I'm not sure if those patches should or should not be concatenated
together in one commit.

See further comments on style (variable naming) and alternate solution
in the comments to first patch of those two: they refer to both patches.

> [PATCH] gitweb: Add treediff

Shouldn't it be:
  "[PATCH 6/6] gitweb: Add "treediff" and "treediff_plain" views"

> These 3 patches add the treediff method. Its a complete reworked
> verion. As git-diff-tree outputs relative patches (discards part of the
> compared tree objects), the first two patches are necessary to produce
> correct links in the treediff output.

See comments for that patch.

> I do not see many possibilties for code sharing with git_commitdiff:
> The only large portion of common code is calling git-diff-tree. I
> don't think that this would justify the more complex code.

I was not thinking about using git_commitdiff to generate "treediff"
view, but rather about extracting the common code into separate subroutine.
But it might (or might not) be not worth the hassle. And it can always
be done in separate "refactoring" patch.

-- 
Jakub Narebski
Poland

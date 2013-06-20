From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] config doc: rewrite push.default section
Date: Wed, 19 Jun 2013 20:27:37 -0700
Message-ID: <7vhagtwjfa.fsf@alter.siamese.dyndns.org>
References: <1371640304-26019-1-git-send-email-artagnon@gmail.com>
	<1371640304-26019-3-git-send-email-artagnon@gmail.com>
	<7v7ghpzxhu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 05:27:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpVXL-0002Ud-EG
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 05:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935696Ab3FTD1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 23:27:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64906 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935542Ab3FTD1m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 23:27:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 364A01FAEA;
	Thu, 20 Jun 2013 03:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sphRMh6aEH6EhqcH0FZVdbrd0CE=; b=aR37TU
	bI82SPIIzOvPC8KAYV0UgYu8RKc0MFIPzX7CDw93OCx9dJPPu9CRb8oUHCvPg1Ls
	yCfAmehxBuatRjLwwV471TEOb2cLsTqMsiCEP9YCWs1MpmMheznZo4/OTqD91DBW
	3uRHlpslkVAw/nHDIPx04sx58XBZUKfYuETXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LtgR0toLuNNu45x8UW7h6sfqQNzFrhdd
	H3f46Pi2ATYUxelGTK0pQCTDYc8Y0H5iccTPqdWVqP7jwzYvOA1bfB8igytwRG2u
	bx6PvvEZIl9e2YEzDL8jFS3oPa5Ax21V3mPHoR+MNQ/gvzt576YspmWKHD9iEHaU
	07qcvCgEBfE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2ADF01FAE7;
	Thu, 20 Jun 2013 03:27:42 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 627911FAD9;
	Thu, 20 Jun 2013 03:27:40 +0000 (UTC)
In-Reply-To: <7v7ghpzxhu.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 19 Jun 2013 12:55:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5CA4209A-D959-11E2-9509-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228438>

Junio C Hamano <gitster@pobox.com> writes:

> or something like that.

Just for a completeness, in a patch form:

 Documentation/config.txt | 66 ++++++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 27 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 81628e8..4b7fc54 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1833,37 +1833,49 @@ push.default::
 	`upstream` is probably what you want.  Possible values are:
 +
 --
+
 * `nothing` - do not push anything (error out) unless a refspec is
-  explicitly given.  Very safe, but not very convenient.
+  explicitly given. This is primarily meant for people who want to
+  avoid mistakes by always being explicit.
 
 * `current` - push the current branch to update a branch with the same
   name on the receiving end.  Works in both central and non-central
-  workflows.  Equivalent to pushing the refspec "$branch" ($branch is
-  the name of the current branch).
-
-* `upstream` - push the current branch to a branch with the name
-  branch.$branch.merge on the receiving end, and error out if the push
-  destination is not the same as branch.$branch.remote.  The name
-  "upstream" refers to "@{u[pstream]}" in linkgit:gitrevisions[7],
-  which makes sense only if both branch.$branch.remote and
-  branch.$branch.merge are set.  It makes sure that a `push` is
-  symmetrical to `pull` in central workflows, and cannot be used in
-  non-central workflows.
-
-* `simple` - a safer version of `current`; push the current branch to
-  update a branch with the same name on the receiving end, with a
-  safety feature: in central workflows, error out if
-  branch.$branch.merge is set and not equal to $branch, to make sure
-  that a `push` and `push` are never asymmetrical.  It will become the
-  default in Git 2.0.
-
-* `matching` - push all branches having the same name on both ends
-  (essentially ignoring all newly created local branches).
-  Well-suited for those who want to batch-update a specific set of
-  branches they consistently work on.  Use with caution, especially
-  when pushing with '--force'.  Equivalent to pushing the refspec ":".
-  This is currently the default, but Git 2.0 will change the default
-  to `simple`.
+  workflows.
+
+* `upstream` - push the current branch back to the branch whose
+  changes are usually integrated into the current branch (which is
+  called `@{upstream}`).  This mode only makes sense if you are
+  pushing to the same repository you would normally pull from
+  (i.e. central workflow).
+
+* `simple` - a safer version of `current`; push the current branch
+  to update a branch with the same name on the receiving end, with a
+  safety feature: in central workflows, error out if your current
+  branch is not set to integrate with the branch with the same name,
+  to ensure that a `push` and a `push` are symmetrical.
++
+This mode will become the default in Git 2.0.
+
+* `matching` - push all branches having the same name on both ends.
+  This makes the repository you are pushing to remember the set of
+  branches that will be pushed out (e.g. if you always push 'maint'
+  and 'master' there and no other branches, the repository you push
+  to will have these two branches, and your local 'maint' and
+  'master' will be pushed there).
++
+To use this mode effectively, you have to make sure _all_ the
+branches you would push out are ready to be pushed out before
+running 'git push', as the whole point of this mode is to allow you
+to push all of the branches in one go.  If you usually finish work
+on only one branch and push out the result, while other branches are
+unfinished, this mode is not for you.  Also this mode is not
+suitable for pushing into a shared central repository, as other
+people may add new branches there, or update the tip of existing
+branches outside your control.
++
+This is currently the default, but Git 2.0 will change the default
+to `simple`.
+
 --
 
 rebase.stat::
-- 
1.8.3.1-674-gb27e881

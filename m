From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] Update gitworkflows man page to include release
 workflow
Date: Wed, 11 Nov 2009 11:43:37 -0800
Message-ID: <7vzl6soniu.fsf@alter.siamese.dyndns.org>
References: <1257869339-15999-1-git-send-email-rocketraman@fastmail.fm>
 <1257869339-15999-2-git-send-email-rocketraman@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: rocketraman@fastmail.fm
X-From: git-owner@vger.kernel.org Wed Nov 11 20:43:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8J6d-0006Lr-P5
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 20:43:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758621AbZKKTnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 14:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758594AbZKKTnk
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 14:43:40 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43766 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758574AbZKKTnj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 14:43:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F5A67DABC;
	Wed, 11 Nov 2009 14:43:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=K4mkUqOyVFvFul9zwDpDxahxHH0=; b=Kj8hOn4SCtDUC7q8/2/ihBK
	QVfCNXFoxeKkE24kbmO/hlpVm38wkO6T/AIo83q+f65SKt6gTybFQfe4IWVHCoVp
	N9ljjc+auNmlML7KGsaPBWhl/Sq3Zln3bCg6QfXm4H96xxV0ArKQPW2/uonT7mr5
	XZRDVFGmPq1grcHRZuBc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=xRx7YT861dqPtoGFeYxsWopZg1bJIb/ssDTBAqVuMW2zmSt0v
	RoTBJJgcEnHuvgik7Y1XFT+zIjeS2n11dM4K+Y4yIxoKynki6y4lguJIsfEUYv23
	WCGmr8TM2hzeRF3yTX+sjUtaX2Qj3M6hSgQ45BfjNryTZ+78Qk+prWXHds=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7246D7DAB6;
	Wed, 11 Nov 2009 14:43:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 33EA97DAB1; Wed, 11 Nov
 2009 14:43:38 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 844912BC-CEFA-11DE-97C6-7B3EEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132692>

rocketraman@fastmail.fm writes:

> From: Raman Gupta <raman@rocketraman.com>
>
> The gitworkflows man page currently provides an overview of the workflows
> used by git.git itself to serve as inspiration for people to use when
> designing their own workflows. The current man page does a reasonable
> job at describing the development process, but it does not contain any
> guidance as to the workflow used for releases. Now add a basic
> introduction to the branch management required for a release, so that a
> reader may understand how the maint, master, next, and topic branches are
> affected.
> ---

Is this meant to show how git.git does its release to serve as an
inspiration to others?  The document does not seem to describe how I make
releases.

> diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
> index 2b021e3..69b789a 100644
> --- a/Documentation/gitworkflows.txt
> +++ b/Documentation/gitworkflows.txt
> @@ -348,6 +348,103 @@ in patches to figure out the merge base.  See linkgit:git-am[1] for
>  other options.
>  
>  
> +RELEASE WORKFLOW
> +----------------
> +
> +The maintainer may use the following release workflow:

Please set the tone straight.  If this is to suggest various possible
workflows in general vague terms, "may use" would be good.  If this is to
precisely describe what I do, then there won't be "you could do this, or
you could do that."  Your "may use" suggests the former, but the commit
log message claims the latter.  Which document are you writing?

Assuming that you are writing what I do...

> +He first tags the tip of 'master' with a release tag, then he updates
> +the 'maint' branch to the current tip of 'master' for managing future
> +maintenance fixes on the current release, and lastly he optionally
> +rebuilds 'next' from the tip of 'master'.

Not in that order.

	- doubly make sure that there is nothing left in 'maint' that
	  is not in 'master';
	- review 'master' more thoroughly than usual;
	- review RelNotes symlink, Documentation/RelNotes-X.Y.Z.txt,
          the stalenotes section in Documentation/git.git, and
          GIT-VERSION-GEN for the last time;
        - tag it;
        - review it again for the last time;
	- test on buildfarm;
	- cut tarball;
        - cut RPM on FC11 i386 and FC11 x86_64;
        - push the tag and master branch alone to the public server---this
          triggers an autobuilder for documentation pages, updates man and
          html branches and documentation tarballs;

When making a maintenance release, everything is the same except that
'maint' is used instead of 'master'.

Then, after all the release task on 'master' (or 'maint') is done,
propagate that upwards (i.e. merge 'master' to 'next' and 'pu').

Merging 'master' to 'maint' is done totally as a separate step, often a
few days later, "Now the big release is done, let's start maintenance
track for that relase".

And then after that, 'next' may be rebuilt.

> +Release Tagging
> +~~~~~~~~~~~~~~~
> +
> +The new feature release is tagged on 'master' with a tag matching
> +vX.Y.Z, where X.Y.Z is the new feature release version.
> +
> +.Release tagging
> +[caption="Recipe: "]
> +=====================================
> +`git tag -s -m "GIT X.Y.Z" vX.Y.Z master`
> +=====================================

There is no incorrect information here, but I do not think there is
anything particularly worth saying here, either.  It is in "git tag"
manpage and anybody can run "git cat-file tag v1.6.3" to learn what is in
there.

> +Maintenance branch update
> +~~~~~~~~~~~~~~~~~~~~~~~~~

This section largely overlaps with Documentation/howto/maintain-git.txt; I
am starting to doubt if we even need a new section in the workflows
document.  Perhaps we could have a release management section in the
Documentation/howto/maintain-git.txt, though.

> +[caption="Recipe: "]
> +=====================================
> +* `git checkout maint`
> +* `git merge master`
> +=====================================
> +
> +This updates 'maint' from 'master', while preserving the 'maint'
> +reflog.
> +
> +An alternative approach to updating the 'maint' branch is to run
> +
> +  $ git branch -f maint master

As I already said, I never do this "alternative", and I do not want
anybody who will take over git.git maintenance to do so.  There is no
reason to encourage nor even mention "branch -f" here.  As 'maint' is
supposed to be a strict subset, pulling 'master' to 'maint' should fast
forward and otherwise you (the maintainer) would notice that there was a
mistake made.  If you use "branch -f", you will never notice.

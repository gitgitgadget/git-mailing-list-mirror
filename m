From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Add feature release instructions to gitworkflows man
 page
Date: Wed, 25 Mar 2009 23:48:36 -0700
Message-ID: <7veiwksrsr.fsf@gitster.siamese.dyndns.org>
References: <1238032575-10987-1-git-send-email-rocketraman@fastmail.fm>
 <1238032575-10987-2-git-send-email-rocketraman@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: rocketraman@fastmail.fm
X-From: git-owner@vger.kernel.org Thu Mar 26 07:50:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmjPq-0000Pt-7o
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 07:50:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145AbZCZGsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 02:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbZCZGsn
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 02:48:43 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50153 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbZCZGsm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 02:48:42 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 98B3499F8;
	Thu, 26 Mar 2009 02:48:40 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CE17F99F4; Thu,
 26 Mar 2009 02:48:37 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 240A0452-19D2-11DE-9030-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114739>

rocketraman@fastmail.fm writes:

> +Release Tagging
> +~~~~~~~~~~~~~~~
> +
> +The new feature release is tagged on 'master' with a tag matching
> +vX.Y.Z, where X.Y.Z is the new feature release version.
> +
> +.Release tagging
> +[caption="Recipe: "]
> +==========================================
> +`git tag -s -m GIT "vX.Y.Z" vX.Y.Z`
> +==========================================

I actually always do:

	git tag -s -m "GIT X.Y.Z" vX.Y.Z master

The argument to -m in your descriptoin is incorrectly quoted, and has an
extra v.  I also spell out 'master' to avoid mistakes, and I would be
happy to encourage others to follow it.

> +Maintenance branch update
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The current maintenance branch is optionally tracked with the older
> +release version number to allow for further maintenance releases on
> +the older codebase.
> +
> +.Track maint
> +[caption="Recipe: "]
> +=====================================
> +`git branch maint-X.Y.(Z-1) maint`
> +=====================================

This creates maint-X.Y.(Z-1) from maint, but calling this step "track
maint" entirely misses the point.

When people use the word "track", the intention is that they intend to
merge subsequent changes to the original branch (in this case, 'maint') to
the new branch ('maint-X.Y.(Z-1)') from time to time.

That is exactly opposite to what I create maint-X.Y.(Z-1) branch for.
This new "branch to maintain an older codebase" will *never* merge from
'maint' after it forks.

> +Update next branch
> +~~~~~~~~~~~~~~~~~~
> +
> +The 'next' branch may be rebuilt from the tip of 'master' using the
> +surviving topics on 'next'.
> +
> +This step is optional. If it is done by the maintainer, then a public
> +announcement will be made indicating that 'next' was rebased.

The wording I use is more like 'rewound and rebuilt'.

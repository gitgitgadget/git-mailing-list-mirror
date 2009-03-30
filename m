From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Add feature release instructions to MaintNotes
 addendum
Date: Sun, 29 Mar 2009 23:56:14 -0700
Message-ID: <7vr60fijn5.fsf@gitster.siamese.dyndns.org>
References: <1238391319-4953-1-git-send-email-rocketraman@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: rocketraman@fastmail.fm
X-From: git-owner@vger.kernel.org Mon Mar 30 08:58:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoBS2-0000jQ-IH
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 08:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755371AbZC3G4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 02:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754345AbZC3G4W
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 02:56:22 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45743 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675AbZC3G4V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 02:56:21 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6B4C2A6A52;
	Mon, 30 Mar 2009 02:56:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 63632A6A4C; Mon,
 30 Mar 2009 02:56:16 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DF28644A-1CF7-11DE-A629-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115092>

rocketraman@fastmail.fm writes:

> + - The 'maint' branch is updated to the new release.
> +
> +     $ git branch -f maint master

It appears that you are trying to make this document into a canned set of
insns for people who want a ready-to-cut-and-paste-without-thinking
recipe, and I am perfectly fine with such a document, but as I mentioned
already, "how to maintain git" is not a good place to do so.  You seem to
have taken it as a joke, but I am serious.

In any case, I highly doubt we would want to have this "branch -f" here.
Not in "how to maintain git", but especially in a document you would give
to people who do not like to think for themselves but would want to follow
cut-and-paste recipe.

_I_ can do the above, but that is _only_ because I maintain 'master' with
certain discipline---it almost always is a superset of maint (it sometimes
isn't---when I am too tired to do so late at night and the leftover fix on
the 'maint' unmerged to 'master' is really trivial and unimportant in the
grand scheme of things), and especially after a big release it always is.

But for people who want to use a ready-to-cut-and-paste-without-thinking
recipe, it is much better to use:

	$ git checkout maint
	$ git merge master

just in case they have leftover fixes that later need to get merged to
master.  Otherwise they will be discarding the fixes with "branch -f".

An obvious alternative is to firmly describe in the release workflow to
make sure that 'maint' is fully merged to 'master' before a release is
made, but people tend to cherry-pick the parts they want to use without
thinking things through when presented a cut-and-paste recipe, and in
practice I do not think such an alternative would work well.

More important bits of release checklist, a bit outdated, is found in
Checklist.txt file on the 'todo' branch.  

I would need to talk a bit more about how to maintain What's in/cooking,
how the automated maintenance of html/man branches work, and how to set up
RPM building infrastructure for use with Meta/DoKernelOrg, in order to
make the Documentation/howto/maintain-git.txt truly to be usable by
somebody capable to take over when I cease to function as the maintainer
here.

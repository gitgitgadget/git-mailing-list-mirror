From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [FIXED PATCH] Make rebase save ORIG_HEAD if changing current
 branch
Date: Mon, 07 Jul 2008 11:04:45 -0700
Message-ID: <7vlk0d4lky.fsf@gitster.siamese.dyndns.org>
References: <1215379370-34265-1-git-send-email-benji@silverinsanity.com>
 <7v7iby9ucx.fsf@gitster.siamese.dyndns.org>
 <803A3528-2451-4C5D-A48D-5E0C37B8E90E@silverinsanity.com>
 <7vbq1a8ay3.fsf@gitster.siamese.dyndns.org> <20080707111803.GF31490@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Git List <git@vger.kernel.org>
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Mon Jul 07 20:06:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFv69-0000hB-2F
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 20:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217AbYGGSFC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 14:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754040AbYGGSFB
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 14:05:01 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33922 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754023AbYGGSFA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 14:05:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 012472E7A0;
	Mon,  7 Jul 2008 14:04:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4BAD02E79B; Mon,  7 Jul 2008 14:04:53 -0400 (EDT)
In-Reply-To: <20080707111803.GF31490@mit.edu> (Theodore Tso's message of
 "Mon, 7 Jul 2008 07:18:03 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 36684A56-4C4F-11DD-8931-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87637>

Theodore Tso <tytso@MIT.EDU> writes:

> True, but (and please correct me if I'm wrong) ORIG_HEAD will always
> be pointing out HEAD before the user typed pretty much any git
> porcelein command (which saves HEAD into ORIG_HEAD), but with reflogs,
> it you have to paw through multiple HEAD@{n} to find the 'n' which
> corresponds to state before executing the git plumbing command, since
> multiple git plumbing commands could have updated the HEAD's reflog,
> right?

You can inspect HEAD's reflog for individual steps, or the branch's reflog
for the aggregated moves (try rebasing a few patches on 'test' branch and
inspect "git log -g HEAD" and "git log -g test").

> One of the things that's been on my 'twoud be nice list is having an
> option to "git reflog show" which prints the timestamp associated with
> each reflog entry,

	$ git log -g HEAD@{now}
        $ git log -g test@{now}

Please don't complain that interface to specify timestamp output is dirty
to me -- I share the same feeling, and it was not my invention.  But at
least it works ;-)

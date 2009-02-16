From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] GIT 1.6.2-rc1
Date: Mon, 16 Feb 2009 13:42:59 -0800
Message-ID: <7vvdradpng.fsf@gitster.siamese.dyndns.org>
References: <7v8wo6bvn9.fsf@gitster.siamese.dyndns.org>
 <76718490902160902q50c0d730j4f18664455626b93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 22:44:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZBGW-0007mK-0A
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 22:44:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558AbZBPVnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 16:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752304AbZBPVnG
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 16:43:06 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46145 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032AbZBPVnE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 16:43:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C08CA2B467;
	Mon, 16 Feb 2009 16:43:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id ACC8F2B430; Mon,
 16 Feb 2009 16:43:00 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CA13798C-FC72-11DD-813B-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110248>

Jay Soffian <jaysoffian@gmail.com> writes:

>  master> git checkout next
>    next> git branch --track mybranch @{-1}
>
> Creates "mybranch" from master, *not from next*, correct?
>
> Also, the "--track" option is an unnecessary distraction to the
> example, isn't it?

When a new branch is created in "git branch --track A B" form, B is used
in two ways.

 * Obviously, the new branch A initially points at the same commit as
   commit B.  For this, B does not have to be the name of a branch.  It
   only has to be a commit-ish.

 * With --track, the new branch A is marked as a fork of the branch B, but
   obviously for this additional feature to kick in, you cannot give an
   arbitrary commit-ish as B.  It has to be the name of a branch you are
   forking from.

If B were spelled @{1}, the latter does not happen, as @{1} is a way to
say "The _commit_ my current branch was pointing at before it point the
current commit".  On the other hand, @{-1} is a way to say "The _branch_
I switched from my last 'git checkout' command", and the command ought to
behave the same as if you gave it a branch name, and --track takes place.

So having --track explicitly in the example is a good way to clarify the
point that @{-N} notation is a way to spell _a branch name_, and it is not
merely another commit-ish.

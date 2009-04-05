From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: improve error message when branch checkout fails
Date: Sun, 05 Apr 2009 02:46:51 -0700
Message-ID: <7vskknv3ec.fsf@gitster.siamese.dyndns.org>
References: <20090404220226.58a3ac99.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, malc@pulsesoft.com
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Apr 05 11:48:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqOxt-0007bI-8q
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 11:48:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756749AbZDEJrB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 05:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756317AbZDEJrA
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 05:47:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41192 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756020AbZDEJrA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 05:47:00 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4186CA8E2F;
	Sun,  5 Apr 2009 05:46:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CA8BCA8E2E; Sun,
  5 Apr 2009 05:46:53 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B4745384-21C6-11DE-B136-BB14ECB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115646>

Christian Couder <chriscool@tuxfamily.org> writes:

> In "git-bisect.sh" the "git checkout" command is only used to
> change the current branch, but it is used like this:
>
> git checkout "$branch"
>
> which will output the following misleading error message when
> it fails:
>
> error: pathspec 'foo' did not match any file(s) known to git.
>
> This patch change the way we use "git checkout" like this:
>
> git checkout "$branch" --
>
> so that we will get the following error message:
>
> fatal: invalid reference: foo
>
> which is better.

Thanks; will apply.

But I think "git checkout" should either say "unknown branch" (assuming
that most people switch branches, not detach HEAD), or "no such commit"
(which could be a bit confusing for people who have not even heard of
detached HEAD, but may be more technically correct).

"Invalid reference" does not help anybody and is not technically correct,
either.  A git newbie would say "Huh?  what is a ref?" and a git savvy
would say "I admit I made a typo, but you, the git checkout command, are
supposed to take an arbitrary commit object, not necessarily a ref".

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i continue: Don't skip submodule only commits
Date: Mon, 09 Apr 2012 15:09:46 -0700
Message-ID: <7vpqbgtv4l.fsf@alter.siamese.dyndns.org>
References: <1333794053-22226-1-git-send-email-john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Apr 10 00:09:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHMmY-0005Jy-PX
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 00:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757063Ab2DIWJt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Apr 2012 18:09:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38813 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751565Ab2DIWJs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2012 18:09:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CD416A45;
	Mon,  9 Apr 2012 18:09:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8shOQKPai/iUP/qGy5B/SX/j/rY=; b=SqC39W
	qC41VQJSPDJxXs2YQmwUsw3EJZ6ydDdNW5bkSvQZYWOQiKBgSLTmp8ZScBtm8uGA
	qwuKtqS8ZWpFyKLj0eRo+KckasfBcVMq70vxRLv9Lq+UTsRVqD5GadtarrsJledC
	7Ps1+Sw3yl/9pmZuHKjq/A8C5Z5ZOO5UahWVY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GMcddazjw5HbrTlM3kDYOVEiD44tYn0H
	YjboV+yqvQUKh4v7DM2zQT1/FrKAwlmxCFf2NGNYQmbbKX3GfhvFl9S3qp3FUoYg
	/72jEqLHFeswDbf69CDG+58jOpXJppLkQ3qDnlXPs0ClnQnB+HRDoU4HQK7nwFGH
	BHJhKup7lrs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 244ED6A44;
	Mon,  9 Apr 2012 18:09:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 95C0F6A43; Mon,  9 Apr 2012
 18:09:47 -0400 (EDT)
In-Reply-To: <1333794053-22226-1-git-send-email-john@keeping.me.uk> (John
 Keeping's message of "Sat, 7 Apr 2012 11:20:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B844BCB4-8290-11E1-8DF3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195044>

John Keeping <john@keeping.me.uk> writes:

> When git-rebase--interactive stops due to a conflict and the only change
> to be committed is in a submodule, the test for whether there is
> anything to be committed ignores the staged submodule change.  This
> leads rebase to skip creating the commit for the change.
>
> While unstaged submodule changes should be ignored to avoid needing to
> update submodules during a rebase, it is safe to remove the
> --ignore-submodules option to diff-index because --cached ensures that
> it is only checking the index.  This was discussed in [1] and a test is
> included to ensure that unstaged changes are still ignored correctly.
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/188713
>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---

Very well explained and sensible.

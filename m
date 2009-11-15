From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] rebase docs: clarify --merge and --strategy
Date: Sun, 15 Nov 2009 13:05:26 -0800
Message-ID: <7v7htrfqi1.fsf@alter.siamese.dyndns.org>
References: <cover.1258309432.git.trast@student.ethz.ch>
 <b7f805f2497d748b685544b64cd91a36c3bdf5d6.1258309432.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Baz <brian.ewins@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Nov 15 22:05:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9mI9-0004Lu-5R
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 22:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbZKOVFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 16:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbZKOVFi
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 16:05:38 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62657 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbZKOVFh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 16:05:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F7D680259;
	Sun, 15 Nov 2009 16:05:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=OqALCMkfIamS/WJ0T2jKybqJmqA=; b=JORYFtUkPRmh/Z75JCGByjK
	ZUKdSOyQf6SpQciTjpPIqsgGiSk/jNQ8ghcntHRuKV+HdABZjrf1vyabpWYVT8ZB
	lSazBqX6QYP7wMCpS4arXsQGujWnqml07rXQkRgAa8f7IJ2UL7cWIyGsKablWbRf
	ayuCWgpOuGBL8gEdflf4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=PtKB7MmOVJ3TdsTaZYVibQ6lN+dW3BCdb2aIdb8BsxZ60O7MZ
	hzrC1UarpmzMUyY4wOt6V2Q1nkbeN+HlW/1Za5UtRJqs18Ay0Z4OuxDKtMmQKf4g
	pN1M8XFHH1EfE6BUagUpclhw4Kot5L/7RmRc0c4GSxRBwCygFxyA2439/E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E004D80258;
	Sun, 15 Nov 2009 16:05:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC57880257; Sun, 15 Nov
 2009 16:05:27 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9E9748AE-D22A-11DE-AFD6-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132965>

Thomas Rast <trast@student.ethz.ch> writes:

> Add a paragraph about the swapped sides in a --merge rebase, which was
> otherwise only documented in the sources.
>
> Add a paragraph about the effects of the 'ours' strategy to the -s
> description.  Also remove the mention of the 'octopus' strategy, which
> was copied from the git-merge description but is pointless in a
> rebase.

Instead of saying "peculiarities" without saying what is peculiar about
it, it might be better to give an explanation that would help the reader
understand why they appear "swapped".

Here is my attempt.  Thoughts?

 Documentation/git-rebase.txt |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index e802421..a6f8182 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -229,9 +229,11 @@ OPTIONS
 	strategy is used, this allows rebase to be aware of renames on the
 	upstream side.
 +
-Note that in a rebase merge (hence merge conflict), the sides are
-swapped: "theirs" is the to-be-applied patch, and "ours" is the so-far
-rebased series, starting with <upstream>.
+Note that a rebase merge works by replaying each commit from the working
+branch on top of the <upstream> branch.  Because of this, when a merge
+conflict happens, the side reported as 'ours' is the so-far rebased
+series, starting with <upstream>, and 'theirs' is the working branch.  In
+other words, the sides are swapped.
 
 -s <strategy>::
 --strategy=<strategy>::
@@ -239,7 +241,9 @@ rebased series, starting with <upstream>.
 	If there is no `-s` option 'git-merge-recursive' is used
 	instead.  This implies --merge.
 +
-Due to the peculiarities of 'git-rebase' (see \--merge above), using
+Because 'git-rebase' replays each commit from the working branch
+on top of the <upstream> branch using the given strategy,
+(see \--merge above), using
 the 'ours' strategy simply discards all patches from the <branch>,
 which makes little sense.  Thus 'git-rebase' does not accept this
 strategy.

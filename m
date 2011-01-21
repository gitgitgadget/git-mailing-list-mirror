From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: do not treat reset --keep as a special
 case
Date: Fri, 21 Jan 2011 12:35:14 -0800
Message-ID: <7v7hdyov0d.fsf@alter.siamese.dyndns.org>
References: <vpq62ziv788.fsf@bauges.imag.fr>
 <20110120195726.GA11702@burratino> <20110120200827.GB14184@vidovic>
 <201101202134.41911.trast@student.ethz.ch>
 <7vfwsnqn8c.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1101210801210.15247@pacific.mpi-cbg.de>
 <7vsjwmp5cs.fsf@alter.siamese.dyndns.org> <vpqmxmu2nm3.fsf@bauges.imag.fr>
 <4D39C923.20202@workspacewhiz.com> <20110121183734.GB16325@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Eric Raible <raible@nextest.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 21 21:35:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgNhz-0001Uv-8a
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 21:35:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054Ab1AUUfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 15:35:42 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59985 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889Ab1AUUfl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 15:35:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0D4652216;
	Fri, 21 Jan 2011 15:36:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SzPfl0E4aV5Is5broZ+y8QcVjiw=; b=Ro7qgX
	cUKgUgZyhw1ackVWzk/pJ2LMPgih4k73SS4LkbDvcb7pQZo/yYKKGNEmVLE7BFiM
	q2T5F9nybTytDmuHLFQtjSbUe0tTqE8L5SC5XOXYW6RA35zrra8XjP+oF7LaGUSE
	90nk/2zvOXqR2pI7YQzrf9lI2GpBAJ9FVtWcA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D1CAseEXwlR4i6DUEN9XtuR6HwK2Duhe
	ePAK00RfK+xKGI5aqWevKnwOLpOxdfQviVbmIWNI8pYKx5zxaWVpTyxONUFFJ5aB
	ZvEPReLsLW1wM7NTMXosx6qcHCIm9LQpBXEb99CHkoWTu3n8/2MJs9TrJnp3ViK4
	GXygRAG9xrA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 542BC220F;
	Fri, 21 Jan 2011 15:36:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5B5122202; Fri, 21 Jan 2011
 15:36:03 -0500 (EST)
In-Reply-To: <20110121183734.GB16325@burratino> (Jonathan Nieder's message of
 "Fri\, 21 Jan 2011 12\:37\:34 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 18D8D084-259E-11E0-8034-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165392>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The current treatment of "git reset --keep" emphasizes how it
> differs from --hard (treatment of local changes) and how it breaks
> down into plumbing (git read-tree -m -u HEAD <commit> followed by git
> update-ref HEAD <commit>).  This can discourage people from using
> it, since it might seem to be a complex or niche option.
>
> Better to emphasize what the --keep flag is intended for --- moving
> the index and worktree from one commit to another, like "git checkout"
> would --- so the reader can make a more informed decision about the
> appropriate situations in which to use it.

The updated text makes quite a lot of sense ;-) while the old text
doesn't.  What were we smoking when we wrote it and passed it through the
review?

> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>  Documentation/git-reset.txt |    9 ++-------
>  1 files changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
> index fd72976..927ecee 100644
> --- a/Documentation/git-reset.txt
> +++ b/Documentation/git-reset.txt
> @@ -76,15 +76,10 @@ In other words, --merge does something like a 'git read-tree -u -m <commit>',
>  but carries forward unmerged index entries.
>  
>  --keep::
> -	Resets the index, updates files in the working tree that are
> -	different between <commit> and HEAD, but keeps those
> -	which are different between HEAD and the working tree (i.e.
> -	which have local changes).
> +	Resets index entries and updates files in the working tree that are
> +	different between <commit> and HEAD.
>  	If a file that is different between <commit> and HEAD has local changes,
>  	reset is aborted.

I saw "updates files" and one question immediately came to mind: update
how?  "... to match what is in HEAD"?  "Resets index entries" is less of a
problem as the word "reset" already strongly suggests that the current
state does not matter as much as the target state, though.

Thanks.

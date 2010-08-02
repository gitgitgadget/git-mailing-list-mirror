From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Document -B<n>[/<m>], -M<n> and -C<n> variants of -B,
 -M and -C
Date: Mon, 02 Aug 2010 11:18:52 -0700
Message-ID: <7vsk2wlvxv.fsf@alter.siamese.dyndns.org>
References: <7vk4ocrkfa.fsf@alter.siamese.dyndns.org>
 <1280747527-30444-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Aug 02 20:19:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfzbS-0006Ed-AW
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 20:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754212Ab0HBSTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 14:19:05 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57791 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754099Ab0HBSTD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 14:19:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C1379C907D;
	Mon,  2 Aug 2010 14:18:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WlZst6BgTCeoCHw/5+foCiVqevg=; b=v4tthQ
	UuEWRf6/D9+6RN1W3uNCDZAzjjd6jUszQhtGbNIJl7MkZhlnutgHlJXEOkdVK03W
	XhhtzsGox0SUKg20wLDp49cceOLmmgiU+bo8XN2eajbIZvxPYEGx+/hy6mGk3NsF
	BeWfJmqtU6dih43o8nUVPnjRMNYxGVFfipJ+c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p+4RyR0RJZKTlm/3Oxz6NbPX5OtaPsYN
	J/zbLsSVaHHOaq7zLLlftOWH70x3ze2NXaanhoudDpgHCvPhe54mHvGbNTN3T5Tl
	RJqkOBYPvVBU/nc0Lk2Hs8tQ8roBYkwEgnVENbv2LnCRgDtwsPFzr7n1mwgxy/VT
	dEa3ASyuJf0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BD6EC907C;
	Mon,  2 Aug 2010 14:18:57 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D80EBC907A; Mon,  2 Aug
 2010 14:18:54 -0400 (EDT)
In-Reply-To: <1280747527-30444-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Mon\,  2 Aug 2010 13\:12\:07 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6A8E54C6-9E62-11DF-B15B-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152431>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> These options take an optional argument, but this optional argument was
> not documented.
>
> While we're there, fix a typo in a comment in diffcore.h.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> Here's a new version. I've eliminated "line" from the wording. I'm
> still not sure I'm technically correct, especially about the
> interaction between "n" and "m" (the "A rewrite is considered when
> both thresholds are reached par of the patch).

I think they are technically correct, but I doubt diff-options.txt is a
place to be more technically correct than to be useful to the end users.

What does an end user want to know from the list of options?

> +-B[<n>]::
> +-B<n>/<m>::
> +	Break complete rewrite changes into pairs of delete and
> +	create. When `n` and/or `m` are specified, they give threshold
> +	(as a percentage of changed content) above which a change is
> +	considered as complete rewrite. `n` is a threshold on the
> +	similarity index (i.e. amount of addition/deletions compared
> +	to the file's size). For example, `-B90%` means git will
> +	detect a rewrite if more than 90% of the file's content have
> +	been modified. `m` is a threshold on the disimilarity index
> +	(i.e. amount of deletions from the old version). A rewrite is
> +	considered when both thresholds are reached. When either `n`
> +	or `m` is not specified, the default applies (`n` = 50% and
> +	`m` = 60%). See linkgit:gitdiffcore[7] for more details.

After reading this, we know that with magic numbers given to -B, we can
"break" changes into "pairs of delete and create".  What does it mean in
the practical terms?  That is a lot more essential information than how
the magic numbers affect the decision to break or not break.  The user
does not get a motivation to help git "break" a pair from the above.

    The -B option serves two purposes.

    It affects the way a change that amounts to a total rewrite of a file
    not as a series of deletion and insertion mixed together with a very
    few lines that happen to match textually as the context, but as a
    single deletion of everything old followed by a single insertion of
    everything new, and the number <m> controls this aspect of the -B
    option (defaults to 60%).  `-B/70%` specifies that less than 30% of
    the original should remain in the result for git to consider it a
    total rewrite (i.e. otherwise the resulting patch will be a series of
    deletion and insertion mixed together with context lines).

    When used with -M, a totally-rewritten file is also considered as the
    source of a rename (usually -M only considers a file that disappeared
    as the source of a rename), and the number <n> controls this aspect of
    the -B option (defaults to 50%).  `-B20%` specifies that a change with
    addition and deletion compared to 20% or more of the file's size are
    eligible for being picked up as a possible source of a rename to
    another file.

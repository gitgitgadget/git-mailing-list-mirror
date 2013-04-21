From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] git-log.txt: generalize <since>..<until>
Date: Sun, 21 Apr 2013 11:54:33 -0700
Message-ID: <7va9oru32u.fsf@alter.siamese.dyndns.org>
References: <1366534252-12099-1-git-send-email-artagnon@gmail.com>
	<1366534252-12099-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 20:54:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTzPR-0000KQ-It
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 20:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754025Ab3DUSyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 14:54:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60703 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753831Ab3DUSyf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 14:54:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6460C1717F;
	Sun, 21 Apr 2013 18:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3qW6rAijSHCBV2fq0PPDDDoiPQo=; b=Ni3jJn
	d5XjMV4otWrKImryaDJN2BXwxGgALjBsk8HqT/F1pOmtD1ewurxkWlIM7KIE6Mxm
	ulHB52kRKVx31uIvXejW14maSGkc8rixLMbezkekDeI2G2vkLNjKTBYBMsMrlWJL
	gMO46rghC5QJv/DqmJmmFF0eGJ6ngfoTHS3cI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sBuyWmbzDnl2dPT7vmXZEHebt5oeUqYQ
	2+YUSG6yKwgwrNAy+kmwMt0Oumd0BJAd5ctfGvceS1EmfZmcM9v1RIq2u0xw4IRI
	yNALvaAi6xDedTN7ZrMaBzGjrcZQkF/fvhlycVsin1GcxkuyTDb8ezVSN/KcVAIF
	QqeT45bV3N4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 595CC1717E;
	Sun, 21 Apr 2013 18:54:35 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B1BA31717D;
	Sun, 21 Apr 2013 18:54:34 +0000 (UTC)
In-Reply-To: <1366534252-12099-6-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Sun, 21 Apr 2013 14:20:50 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E893C322-AAB4-11E2-9198-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221963>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> '<since>..<until>' is misleading, as there are many other forms that
> 'git log' can accept as an argument.  Replace it with <revision range>,
> referring to the section "Specifying Ranges" in revisions.txt, and
> rewrite the section appropriately.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/git-log.txt | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> index 64cc337..c238475 100644
> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -9,7 +9,7 @@ git-log - Show commit logs
>  SYNOPSIS
>  --------
>  [verse]
> -'git log' [<options>] [<since>..<until>] [[\--] <path>...]
> +'git log' [<options>] [<revision range>] [[\--] <path>...]
>  
>  DESCRIPTION
>  -----------
> @@ -62,12 +62,14 @@ produced by --stat etc.
>  	Note that only message is considered, if also a diff is shown
>  	its size is not included.
>  
> -<since>..<until>::
> -	Show only commits between the named two commits.  When
> -	either <since> or <until> is omitted, it defaults to
> -	`HEAD`, i.e. the tip of the current branch.
> -	For a more complete list of ways to spell <since>
> -	and <until>, see linkgit:gitrevisions[7].
> +<revision range>::
> +	Show only commits in the specified revision range.  When no
> +	<revision range> is specified, it defaults to 'HEAD' (ie. the

s/ie/i.e./; or s/ie/meaning /;

> +	whole history leading to the current commit).  master..HEAD
> +	specifies all the commits reachable from 'HEAD', but not from
> +	'master'. For a complete list of ways to spell
> +	<revision range>, see the "Specifying Ranges" section of
> +	linkgit:gitrevisions[7].

If you want to have a single example (other than 'HEAD' which has to
be there anyway to describe the default), I think it would be more
helpful to use one that would be common for not-so-advanced users,
e.g. "origin..HEAD", without many other prerequisites (e.g. "@{u}.."
may be common among more advanced users but is not appropriate here,
because the reader may not have learned @{upstream} or omission of a
side of a range defaulting to HEAD).

	... `origin..HEAD` specifies all the commits reachable from
	the current commit (i.e. `HEAD`) but not from `origin`.

I could squash these in locally without a reroll, but I haven't read
the remainder of the series yet, so we'll see.

>  [\--] <path>...::
>  	Show only commits that are enough to explain how the files

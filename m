From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/27] t1400: Provide more usual input to the command
Date: Mon, 31 Mar 2014 14:28:03 -0700
Message-ID: <xmqqtxae3voc.fsf@gitster.dls.corp.google.com>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
	<1395683820-17304-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 31 23:28:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUjkb-0001NG-S6
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 23:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbaCaV2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 17:28:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45832 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751043AbaCaV2H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 17:28:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53735799EA;
	Mon, 31 Mar 2014 17:28:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sgvEb75dsWzbW53hQw0YVD3zCBI=; b=NbOzAp
	OM9LWcsfGliVkc0OhSblkQ6h3CyKHDWhYigeOxTy282X5EW4zSmhAYG0F5Tf6o4C
	pINMg2A/UAePiha9GPfXHkFhhjaxGOYnYW9uF38bXyyPE+NnUwJuvZHNeI/tk262
	aAiqQkkuxBWMYcYxNAQefcrZliG1MqQefCha0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qxhz0In7H3cEOy2uD3855xppRQm9/J6I
	ZxsFpQ57z5fS91lGqY5wfQaTQO5jW3ZrVFBWPN3Z3r6xEafaCu4EjLDfC92p2b6D
	xdNvIbuogdP0rjAGex8FPCZEnHlQ/qFz2V53NyaLJPfRbEgRNpATWFDYYQHUsPwE
	rKkVWsoJAuc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EA10799E9;
	Mon, 31 Mar 2014 17:28:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4774D799E7;
	Mon, 31 Mar 2014 17:28:05 -0400 (EDT)
In-Reply-To: <1395683820-17304-3-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Mon, 24 Mar 2014 18:56:35 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 58A586BC-B91B-11E3-99B4-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245534>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Subject: Re: [PATCH v2 02/27] t1400: Provide more usual input to the command

This applies to the patches throughout the series, but during the
microproject reviews, Eric pointed out that we seem to start the
summary after area: on the subject with lowercase and omit the full
stop at the end, so I'll try to tweak the subjects while queueing to
read patches in the series.

> The old version was passing (among other things)
>
>     update SP refs/heads/c NUL NUL 0{40} NUL
>
> to "git update-ref -z --stdin" to test whether the old-value check for
> c is working.  But the <newvalue> is empty, which is a bit off the
> beaten track.
>
> So, to be sure that we are testing what we want to test, provide an
> actual <newvalue> on the "update" line.

Interesting.  So the test used to expect failure, but we couldn't
tell if that was due to giving a "Please update to this value" which
is malformed, or "I am giving 0{40} as the old value, telling you
that you have to make sure the ref does not exist" which does not
hold because we already have that ref?

That would mean that the test may not have been testing the right
thing.  A good change.

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  t/t1400-update-ref.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index fa927d2..29391c6 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -912,7 +912,7 @@ test_expect_success 'stdin -z update refs works with identity updates' '
>  
>  test_expect_success 'stdin -z update refs fails with wrong old value' '
>  	git update-ref $c $m &&
> -	printf $F "update $a" "$m" "$m" "update $b" "$m" "$m" "update $c" "" "$Z" >stdin &&
> +	printf $F "update $a" "$m" "$m" "update $b" "$m" "$m" "update $c" "$m" "$Z" >stdin &&
>  	test_must_fail git update-ref -z --stdin <stdin 2>err &&
>  	grep "fatal: Cannot lock the ref '"'"'$c'"'"'" err &&
>  	git rev-parse $m >expect &&

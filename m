From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/27] t1400: Fix name and expected result of one test
Date: Mon, 31 Mar 2014 14:30:54 -0700
Message-ID: <xmqqppl23vjl.fsf@gitster.dls.corp.google.com>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
	<1395683820-17304-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 31 23:31:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUjnL-0000ik-Fy
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 23:31:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbaCaVa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 17:30:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50883 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750996AbaCaVa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 17:30:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2749A79C1A;
	Mon, 31 Mar 2014 17:30:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=In36BA/aeoIihjcFIa5/ItlXITw=; b=pGVTYz
	cPXsrGzaHlCC+uKidosizUmjkNKrtXrDIZnwNbV9mb9u1OTGcPPcFNbdDjMmNdT8
	rWEW1bHnJRDb7RDVtqgtyJ/jbGt1/1eoBkbQun5P+K0yBGqMCb9mCjvddcuWvjgn
	6ljYTVwR83Lt43t4x/2k6Plku8VvNcOgkoHX0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ADuiCTz/foOjFd5v8Y0yhCTZ01/6U6NY
	b7hUbh3/HJkG6gDJYwQYSc3Lt68H+IQybDfOwWcKagV5oJ/AUuLx7zIMAs64zyQ0
	ojLbK2NHvggp8Vm27y3fPskd6A5X9CQK+QNupb96n7JnFFgWSDJg2kNCcPKSILi9
	dMZwVLI8V6A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1861479C19;
	Mon, 31 Mar 2014 17:30:57 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5AC0D79C18;
	Mon, 31 Mar 2014 17:30:56 -0400 (EDT)
In-Reply-To: <1395683820-17304-2-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Mon, 24 Mar 2014 18:56:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BE9E3CFC-B91B-11E3-B037-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245535>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The test
>
>     stdin -z create ref fails with zero new value
>
> actually passes an empty new value, not a zero new value.  So rename
> the test s/zero/empty/, and change the expected error from
>
>     fatal: create $c given zero new value
>
> to
>
>     fatal: create $c missing <newvalue>

I have a feeling that "zero new value" might have been done by a
non-native (like me) to say "no new value"; "missing newvalue"
sounds like a good phrasing to use.

> Of course, this makes the test fail now, so mark it
> test_expect_failure.  The failure will be fixed later in this patch
> series.

That sounds somewhat strange.  Why not just give a single-liner to
update-ref.c instead?

>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  t/t1400-update-ref.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index 6ffd82f..fa927d2 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -827,10 +827,10 @@ test_expect_success 'stdin -z create ref fails with bad new value' '
>  	test_must_fail git rev-parse --verify -q $c
>  '
>  
> -test_expect_success 'stdin -z create ref fails with zero new value' '
> +test_expect_failure 'stdin -z create ref fails with empty new value' '
>  	printf $F "create $c" "" >stdin &&
>  	test_must_fail git update-ref -z --stdin <stdin 2>err &&
> -	grep "fatal: create $c given zero new value" err &&
> +	grep "fatal: create $c missing <newvalue>" err &&
>  	test_must_fail git rev-parse --verify -q $c
>  '

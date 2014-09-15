From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] t1503: use test_must_be_empty
Date: Mon, 15 Sep 2014 15:33:56 -0700
Message-ID: <xmqqfvfs4ip7.fsf@gitster.dls.corp.google.com>
References: <1410808059-1459-1-git-send-email-davvid@gmail.com>
	<1410808059-1459-2-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Fabian Ruch <bafain@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 00:34:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTeqY-0001RM-Ey
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 00:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759043AbaIOWeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 18:34:01 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55221 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758260AbaIOWd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 18:33:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1BA183B372;
	Mon, 15 Sep 2014 18:33:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ClyMF8FPCd0eqhzn6Glj4clyAP8=; b=qZVAfG
	LCjvv/0hkJ3JnpHx1AnXzwP848BgGYBFou0P7llyo0fglJ/f5LrAfmDgGIuQkT4p
	y3hTg9O1APFKtdiotuMDLCZ6fKoVJ1oz+ykoB2UMUZK9t5PoB09NCbVTHbBwch+e
	atgBRRGnF4aV6cKcGtpGAtjlvr5SlEHkTNeZw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fie1Dwaly+BKZYui64dZFsEJBTf6bu2T
	As5YPKWss+M5haOPeALDyiZipkfrzGTaRliJaVPExD3FUwTml3csMXNDvuH+KF8C
	IkyviSd8ijuErA8Ee5rCpz+aWIW/d2qq+ABURzo4k/StYGWwP+RFMoW9hanaKh7Z
	czJ0BvJnogA=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0EED83B371;
	Mon, 15 Sep 2014 18:33:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 818D03B370;
	Mon, 15 Sep 2014 18:33:58 -0400 (EDT)
In-Reply-To: <1410808059-1459-2-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Mon, 15 Sep 2014 12:07:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6250EC6A-3D28-11E4-8F1B-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257113>

David Aguilar <davvid@gmail.com> writes:

> Use `test_must_be_be_empty <file>` instead of `test -z "$(cat <file>)"`.
>
> Suggested-by: Fabian Ruch <bafain@gmail.com>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> Unchanged since last time, but rebased for the change in the
> previous patch.

It probably makes more sense to have this at the beginning of a
series as preliminary clean-up.  That way, the more interesting
change does not have to have "test -z $(cat ...)" that makes readers
go "Huh?".



>
>  t/t1503-rev-parse-verify.sh | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
> index fd9d0c3..4fe9f0e 100755
> --- a/t/t1503-rev-parse-verify.sh
> +++ b/t/t1503-rev-parse-verify.sh
> @@ -72,15 +72,15 @@ test_expect_success 'fails with any bad rev or many good revs' '
>  
>  test_expect_success 'fails silently when using -q' '
>  	test_must_fail git rev-parse --verify --quiet 2>error &&
> -	test -z "$(cat error)" &&
> +	test_must_be_empty error &&
>  	test_must_fail git rev-parse -q --verify foo 2>error &&
> -	test -z "$(cat error)" &&
> +	test_must_be_empty error &&
>  	test_must_fail git rev-parse --verify -q HEAD bar 2>error &&
> -	test -z "$(cat error)" &&
> +	test_must_be_empty error &&
>  	test_must_fail git rev-parse --quiet --verify baz HEAD 2>error &&
> -	test -z "$(cat error)" &&
> +	test_must_be_empty error &&
>  	test_must_fail git rev-parse -q --verify $HASH2 HEAD 2>error &&
> -	test -z "$(cat error)"
> +	test_must_be_empty error
>  '
>  
>  test_expect_success 'fails silently when using -q with deleted reflogs' '
> @@ -89,7 +89,7 @@ test_expect_success 'fails silently when using -q with deleted reflogs' '
>  	git update-ref -m "reflog message for refs/test" refs/test "$ref" &&
>  	git reflog delete --updateref --rewrite refs/test@{0} &&
>  	test_must_fail git rev-parse -q --verify refs/test@{0} >error 2>&1 &&
> -	test -z "$(cat error)"
> +	test_must_be_empty error
>  '
>  
>  test_expect_success 'no stdout output on error' '

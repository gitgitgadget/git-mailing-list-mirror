From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/4] git-cherry-pick: Add test to validate new options
Date: Wed, 11 Apr 2012 14:06:34 -0700
Message-ID: <7vwr5mhtb9.fsf@alter.siamese.dyndns.org>
References: <1334175716-11391-1-git-send-email-nhorman@tuxdriver.com>
 <1334175716-11391-4-git-send-email-nhorman@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 23:07:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI4kl-0005vR-Qb
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 23:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933318Ab2DKVGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 17:06:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36214 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933267Ab2DKVGg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 17:06:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 131E26586;
	Wed, 11 Apr 2012 17:06:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4QrNLD4qxqh5WOpCvlE+WzF5flo=; b=T2uCN1
	bF6ncYW02DqC2ikJPLp5fBKLLKEfaDj1fRVFuGPLfBXdOdQtL+ee6bxbQUWDasrR
	7tMA6loC4VNJ2GepkQGW4covX57J/AbX2aSNJzemyACtp8MAvYzO6+SuJRD83ruR
	s6Mz8abyPfYVeCI49OPqw3nsF+QGCld7OH4lQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BTaNrirol3n/gDs5LGMBtT4P9IXBHOzg
	eZTnMWIpgd+t1zfGwls6JLsu9KHKNjRyHLDarBTxoq2l0GAVsza8sTuxHYoC1j7K
	b/bjOb2Gfo0stX9UkQcr0sf+F+xWQPckwybvQXC2FE5uTe2EnM/xZ5CeUKoWT8xu
	avXTPiXsWis=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 098736585;
	Wed, 11 Apr 2012 17:06:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8FEEE6584; Wed, 11 Apr 2012
 17:06:35 -0400 (EDT)
In-Reply-To: <1334175716-11391-4-git-send-email-nhorman@tuxdriver.com> (Neil
 Horman's message of "Wed, 11 Apr 2012 16:21:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 38DF7474-841A-11E1-8E4B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195254>

Neil Horman <nhorman@tuxdriver.com> writes:

> Since we've added the --allow-empty and --keep-redundant-commits
> options to git cherry-pick we should also add a test to ensure that its working
> properly

Missing full-stop at the end of the sentence

> Signed-off-by: Neil Horman <nhorman@tuxdriver.com>

> +test_expect_success 'cherry pick an empty non-ff commit without --allow-empty' '
> +	git checkout master &&
> +	echo fourth >> file2 &&
> +	git add file2 &&
> +	git commit -m "fourth" && {
> +		git cherry-pick empty-branch2
> +		test "$?" = 1 
> +	}
> +'

Do we _deeply_ care that it fails with status 1, or should this be test_must_fail?

> +test_expect_success 'cherry pick an empty non-ff commit with --allow-empty' '
> +	git checkout master && {
> +		git cherry-pick --allow-empty empty-branch2
> +		test "$?" = 0
> +	}
> +'

Lose the 'test "$?" = 0' here.

> +test_expect_success 'cherry pick with --keep-redundant-commits' '
> +	git checkout master && {
> +		git cherry-pick --keep-redundant-commits HEAD^
> +		test "$?" = 0

Likewise.

> +	}
> +'
> +
>  test_done

Thanks.

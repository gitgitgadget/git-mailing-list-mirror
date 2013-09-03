From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] peel_onion(): add support for <rev>^{tag}
Date: Tue, 03 Sep 2013 13:10:44 -0700
Message-ID: <xmqq7gexr7i3.fsf@gitster.dls.corp.google.com>
References: <1378237816-28671-1-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, sunshine@sunshineco.com
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 22:10:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGwwC-0004uR-RZ
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 22:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755324Ab3ICUKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 16:10:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37085 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754063Ab3ICUKw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 16:10:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3A4A3FFF2;
	Tue,  3 Sep 2013 20:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q2T8T8IaDQ2XkY9fL6jCCFyZA98=; b=DgnGLF
	xXWCbOH0mv4xH7tYHN6RUzFpJNGTumevVnMX6Bc0S3EuXzyX+lZuHJmuulvOOmOv
	yCputXfgbi/j4Sq+0AH9v3TRRV305nIJFR0qr//Q/fRyfJUyVASZnQb0fGYO8BqK
	Izkm7AewuT72GbVyBwfbt/OidJvgYkvBrXnrk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oRwpTLRVVO1uAszCw9RK4FNA4CP6gjYf
	gqM7194LaJuRWfVM+0cCCXiSNNyvbLTxV9sSe1h5QJzYLRsMmPFDwrg/KF2t3sBb
	2vU+iJ8rRKOPIwDQr3XJ5W4Marvm2A9RrjpBs4xrvhy6wPBg5rflPBLE4B+DxkXh
	YEd0vUa3+00=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D5E53FFEF;
	Tue,  3 Sep 2013 20:10:50 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC5A83FFDF;
	Tue,  3 Sep 2013 20:10:47 +0000 (UTC)
In-Reply-To: <1378237816-28671-1-git-send-email-rhansen@bbn.com> (Richard
	Hansen's message of "Tue, 3 Sep 2013 15:50:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EC8E2082-14D4-11E3-AAA5-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233774>

Richard Hansen <rhansen@bbn.com> writes:

> diff --git a/t/t1511-rev-parse-caret.sh b/t/t1511-rev-parse-caret.sh
> index eaefc77..15973f2 100755
> --- a/t/t1511-rev-parse-caret.sh
> +++ b/t/t1511-rev-parse-caret.sh
> @@ -54,6 +54,13 @@ test_expect_success 'ref^{tree}' '
>  	test_must_fail git rev-parse blob-tag^{tree}
>  '
>  
> +test_expect_success 'ref^{tag}' '
> +	test_must_fail git rev-parse HEAD^{tag} &&
> +	git rev-parse commit-tag >expected &&
> +	git rev-parse commit-tag^{tag} >actual &&
> +	test_cmp expected actual
> +'
> +

Looks good to me.  Testing both failure case and success case.

Thanks; will queue.

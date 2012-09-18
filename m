From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep.c: Fix a sparse warning
Date: Tue, 18 Sep 2012 12:49:32 -0700
Message-ID: <7v7grrm7qr.fsf@alter.siamese.dyndns.org>
References: <5058AFB1.3040600@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Sep 18 21:49:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE3nk-0000ei-Ni
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 21:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754688Ab2IRTtg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 15:49:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47675 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754636Ab2IRTtf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 15:49:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B77BC9F1A;
	Tue, 18 Sep 2012 15:49:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QeMYcPLmg+/R4iemLt2SEnjK7IU=; b=CcKKdf
	n3T/6n1kovb7uHN6EOj6SLqX52P6/wAh82rht58fNsULvZ5qnKc5viqAEq+E3odQ
	19Ici9ifeAadwpAQvrNK8SSGrQgi5Ok59LyWTXmVXVZgbQ5rGD/geeRx58ddBdPT
	M3IomNGq+p6lrnb2qez/wMOUGai6jS7FSZrpI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nzkFZQfD+qvIXfuYd9RODmqdQLY/suCP
	ZKTBk/duMec3RiZXYBabbV7bs/wHgd6TI814SaUGFn9wVRR3qHmPVZG70j/FqxbE
	LXzRJJhbtVJFzne7OP+EVCsOI3evb72ra1tN52nSM1ppX1i7y7JOLkReCCkoY6Vk
	48F9SVqmZiQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A33D09F18;
	Tue, 18 Sep 2012 15:49:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 007DF9F17; Tue, 18 Sep 2012
 15:49:33 -0400 (EDT)
In-Reply-To: <5058AFB1.3040600@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Tue, 18 Sep 2012 18:30:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F848CBC6-01C9-11E2-BDC8-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205860>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> In particular, sparse complains that "... 'dump_grep_expression'
> was not declared. Should it be static?". In order to suppress
> the warning, since this function does not need more than file
> scope, we simply include the static modifier in it's declaration.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>
> Hi Junio,
>
> I prefer to catch these before they progress to next, but it seems
> I've not been quick enough lately! Sorry about that. :(  [I will have
> to git-fetch more frequently; at present I only fetch about 3 times
> a week.]
>
> I've been away for a few days, so I'm well behind ... (I'm just
> about to download 350+ emails for me to read tonight!).

Thanks; doesn't 07a7d65 (grep.c: mark private file-scope symbols as
static, 2012-09-15) cover this already, though?

>
> ATB,
> Ramsay Jones
>
>  grep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/grep.c b/grep.c
> index 925aa92..38c4d75 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -403,7 +403,7 @@ static void dump_grep_expression_1(struct grep_expr *x, int in)
>  	}
>  }
>  
> -void dump_grep_expression(struct grep_opt *opt)
> +static void dump_grep_expression(struct grep_opt *opt)
>  {
>  	struct grep_expr *x = opt->pattern_expression;

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revert: Hide '-r' option in default usage
Date: Mon, 11 Apr 2011 14:06:27 -0700
Message-ID: <7vhba4v6p8.fsf@alter.siamese.dyndns.org>
References: <1302449954-15353-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 23:06:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9OJo-0005HY-Sj
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 23:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755933Ab1DKVGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 17:06:39 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34235 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755899Ab1DKVGj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 17:06:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DE378480A;
	Mon, 11 Apr 2011 17:08:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d0ErnaK6p0p1w9H/alWMjw5oa04=; b=kN83Ym
	EDbHvJGj+31xza2fvKZNODOceIu5fNBBAZ8PhwZbpP6OxKSzAdmBykXyFg3G3+pv
	c6CN0NUcRSP1yUgnd0Inla0YN6rXi5Te+42Fv8QJ7RC23AnlNnsl/Gm1vh7d/P5W
	iE2//3RXnuQQsnj9jUuQ+KGuJGkeAL0+w21QY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Nklr3FAcMKwSkixYY2WU2531L8pHvKlD
	wRnjhQ+7p77e3cJtyQ4EYCtZXz5rgnIv53ZgfKver5NqIA2hB9vnTWaYQzQXiyuN
	AtdzEExozkts/d1tHPUBTvxuGRooNr56cqoT8nD/eCPsQmx38ufVWS0v1cgYO2Af
	Oq+ez7kGH74=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A18AF4809;
	Mon, 11 Apr 2011 17:08:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A4F114808; Mon, 11 Apr 2011
 17:08:27 -0400 (EDT)
In-Reply-To: <1302449954-15353-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Sun, 10 Apr 2011 21:09:14 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DA378CBE-647F-11E0-B919-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171356>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Since the '-r' command-line option is a no-op provided only for
> backward compatiblity, don't advertise it in the default usage.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---

Thanks.

It would have saved me a lot of time if you wrote that this option has
been a no-op since abd6970 (cherry-pick: make -r the default, 2006-10-05),
but the commit didn't remove it from the usage string, and it somehow
survived 9509af6 (Make git-revert & git-cherry-pick a builtin, 2007-03-01)
and later f810379 (Make builtin-revert.c use parse_options, 2007-10-07),
and it is about time to stop advertising it.

> This is a minor detail I noticed while working on the sequencer.
>
>  builtin/revert.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/builtin/revert.c b/builtin/revert.c
> index 2bb13eb..f697e66 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -76,7 +76,8 @@ static void parse_args(int argc, const char **argv)
>  	struct option options[] = {
>  		OPT_BOOLEAN('n', "no-commit", &no_commit, "don't automatically commit"),
>  		OPT_BOOLEAN('e', "edit", &edit, "edit the commit message"),
> -		OPT_BOOLEAN('r', NULL, &noop, "no-op (backward compatibility)"),
> +		{ OPTION_BOOLEAN, 'r', NULL, &noop, NULL, "no-op (backward compatibility)",
> +		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 0 },
>  		OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
>  		OPT_INTEGER('m', "mainline", &mainline, "parent number"),
>  		OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),

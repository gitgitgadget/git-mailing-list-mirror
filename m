From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv7 1/4] wt-status.*: better advices for git status added
Date: Mon, 04 Jun 2012 16:01:45 -0700
Message-ID: <7vtxyqr89y.fsf@alter.siamese.dyndns.org>
References: <1338748217-16440-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338830399-31504-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 05 01:02:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbgHb-00028S-TE
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 01:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761041Ab2FDXBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 19:01:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44840 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757444Ab2FDXBu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 19:01:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F25DB8A11;
	Mon,  4 Jun 2012 19:01:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZJE1ZckcbB5IO3C0AlHP1N/S9qQ=; b=eyOxeR
	qFTowU+D8z+TrHlQog18zd/7VfIsGrCOawXizaX5668I8d6D6xzC0OuURF/wYiuR
	v5TULX5j/Vfs1GaaLA+2GIHOSZXxDUdRjjd5dJcln/gwtviNYN7T6fRwltm59SVp
	qkR5VsqNHV9TuVikl/OVBIKrqof0Q5Wp7YZ+U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pea8A0QBw8Tla6iy9QRgnQ56IOvwdPVO
	9QidjKZiRIYaqxW3SZ8bMnHeACWSardT8GBzJMfknlpy4QpBNJgLCKnUprOCW1xJ
	fSr1L1ns5oBxX6bAteBPvUPxTatkMUttUur4kUcF0h923EpoczhE6EQiAdCKwMEB
	HRxbVVQQ0eM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E80AB8A10;
	Mon,  4 Jun 2012 19:01:49 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB14E8A0F; Mon,  4 Jun 2012
 19:01:46 -0400 (EDT)
In-Reply-To: <1338830399-31504-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 (Kong Lucien's message of "Mon, 4 Jun 2012 19:19:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4288DDCC-AE99-11E1-B21D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199194>

Kong Lucien <Lucien.Kong@ensimag.imag.fr> writes:

> The case of conflicts during a rebase -i is now taken care of. The form
> of the tests has also been modified.

> diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
> index b8cb490..4326df7 100755
> --- a/t/t7060-wtstatus.sh
> +++ b/t/t7060-wtstatus.sh
> @@ -30,6 +30,9 @@ test_expect_success 'Report new path with conflict' '
>  
>  cat >expect <<EOF
>  # On branch side
> +# You have unmerged paths.
> +#   (fix conflicts and run "git commit")
> +#
>  # Unmerged paths:
>  #   (use "git add/rm <file>..." as appropriate to mark resolution)
>  #
> @@ -118,4 +121,65 @@ test_expect_success 'git diff-index --cached -C shows 2 copies + 1 unmerged' '
>  	test_cmp expected actual
>  '

These probably would want to become test_i18ncmp.

Other than that, modulo message details, the code structure is very
pleasant to follow and this patch looks ready to be tested.

Good job.

> diff --git a/wt-status.c b/wt-status.c
> index dd6d8c4..2b19fe3 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -728,6 +729,167 @@ static void wt_status_print_tracking(struct wt_status *s)
> ...
> +static void show_am_in_progress(struct wt_status *s,
> +				struct wt_status_state *state,
> +				const char *color)
> +{
> +	status_printf_ln(s, color,
> +		_("You are in the middle of an am session."));
> +	if (state->am_empty_patch)
> +		status_printf_ln(s, color,
> +			_("The current patch is empty."));
> +	if (advice_status_hints) {
> +		status_printf_ln(s, color,
> +			_("  (use \"git am --abort\" to restore the original branch)"));
> +		status_printf_ln(s, color,
> +			_("  (use \"git am --skip\" to skip this patch)"));
> +		if (!state->am_empty_patch)
> +			status_printf_ln(s, color,
> +				_("  (when you have fixed this problem run \"git am --resolved\")"));
> +	}
> +	wt_status_print_trailer(s);
> +}

Perhaps s/fixed this problem/resolved conflicts/ or a similar
rephrasing is a good idea.

Conflicts from mergy operations are perfectly normal parts of a
regular workday, and it is not a "problem" that needs to be "fixed".
Both words scare the user by implying something is broken (or worse,
"git broke something") in the contents of user's repository.

There are existing messages that use the verb "fix" on "conflicts",
only because it is shorter than "resolve", but this one that calls a
conflict a "problem" goes too far in the wrong direction.

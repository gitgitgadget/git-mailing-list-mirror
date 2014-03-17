From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] wt-status: Make status messages more consistent with others
Date: Mon, 17 Mar 2014 14:51:42 -0700
Message-ID: <xmqq1ty0cx3l.fsf@gitster.dls.corp.google.com>
References: <1394771872-25940-1-git-send-email-andrew.kw.w@gmail.com>
	<1394771872-25940-2-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 22:51:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPfRo-0003OK-5a
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 22:51:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752414AbaCQVvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 17:51:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40010 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752202AbaCQVvq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 17:51:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D524576BC4;
	Mon, 17 Mar 2014 17:51:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dc8ekmKIYgf5dq41o7cGSDIjNAc=; b=yUj5v+
	KzpbWzIh2irRwt2JYqmF5Z2n6fp7D3h2PCJ7VDHXMF+xkYavF6vSbaGr2gi5QgNT
	MNE5pFuoiLKm4Vr783Cg4GDliJRMh34URK0ukEo2TH/0OzF0FF931QT+2Evw1EgK
	mF6/+6SMB4BHlm2I4FVYBmyS1ms3SNA555w8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z9Yu8exVypzQnsnocvYd5kp4YcbWFAkn
	EnC1dxRUrWlPwFBJdidN+Gvjwdlt2Em07xie3RQYBkAJVXbVTmVB+EzVsZO9lvyw
	Z3gb645EBWQVOEdnSfQqrGqxJwsShPMFTFo/ClK17W0eauckCNAI16uzPcYdcQb1
	h2GdwYccupY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C537476BC3;
	Mon, 17 Mar 2014 17:51:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ECA0476BC2;
	Mon, 17 Mar 2014 17:51:44 -0400 (EDT)
In-Reply-To: <1394771872-25940-2-git-send-email-andrew.kw.w@gmail.com> (Andrew
	Wong's message of "Fri, 14 Mar 2014 00:37:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5503A654-AE1E-11E3-8525-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244291>

Andrew Wong <andrew.kw.w@gmail.com> writes:

> This is mainly changing messages that say:
>     run "git foo --bar"
> to
>     use "git foo --bar" to baz

"git foo --bar" is fine, but "to baz" was hard to read without first
realizing that 'baz' stands for some/any verb.  I think rephrasing
it to

	use "git foo --bar" to do baz

would reduce confusion.

> diff --git a/wt-status.c b/wt-status.c
> index a452407..9f2358a 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -899,13 +899,13 @@ static void show_merge_in_progress(struct wt_status *s,
>  		status_printf_ln(s, color, _("You have unmerged paths."));
>  		if (s->hints)
>  			status_printf_ln(s, color,
> -				_("  (fix conflicts and run \"git commit\")"));
> +				_("  (fix conflicts and use \"git commit\" to conclude the merge)"));
>  	} else {
>  		status_printf_ln(s, color,
>  			_("All conflicts fixed but you are still merging."));
>  		if (s->hints)
>  			status_printf_ln(s, color,
> -				_("  (use \"git commit\" to conclude merge)"));
> +				_("  (use \"git commit\" to conclude the merge)"));
>  	}
>  	wt_status_print_trailer(s);
>  }

The above hunk makes sense.

At first glance, I felt that none of the remainder made much sense.
My reaction was: "git foo --continue" to continue?  What else could
the --continue option even mean?

The real value I see in these conversions is by saying "use this to
continue" instead of an unconditional "run this", it implies "*IF*
you wanted to continue, you can do this", meaning that user also has
the option of *not* continuing.  But the proposed update falls short
of realizing the full potential, if that is the value we are trying
to add.  I'd say

	fix conflicts and then use "git am --continue" if you want
	to continue.

or an even more explicit

	fix conflicts and then use "git am --continue" if you want
	to continue; or you can "git am --abort" to discontinue.

would be an improvement, but

	fix conflicts and then use "git am --continue" to continue

is probably not quite.

> @@ -922,7 +922,7 @@ static void show_am_in_progress(struct wt_status *s,
>  	if (s->hints) {
>  		if (!state->am_empty_patch)
>  			status_printf_ln(s, color,
> -				_("  (fix conflicts and then run \"git am --continue\")"));
> +				_("  (fix conflicts and then use \"git am --continue\" to continue)"));
>  		status_printf_ln(s, color,
>  			_("  (use \"git am --skip\" to skip this patch)"));
>  		status_printf_ln(s, color,

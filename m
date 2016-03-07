From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Documentation: talk about pager in api-trace.txt
Date: Mon, 07 Mar 2016 12:23:15 -0800
Message-ID: <xmqqvb4yniks.fsf@gitster.mtv.corp.google.com>
References: <1457347133-31733-1-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 07 21:23:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ad1gb-0007Cj-DF
	for gcvg-git-2@plane.gmane.org; Mon, 07 Mar 2016 21:23:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753147AbcCGUXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2016 15:23:21 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63065 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752958AbcCGUXU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2016 15:23:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 30E1249731;
	Mon,  7 Mar 2016 15:23:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MYg1NHch33X1siAlu8in8XQ7oqY=; b=I6q+lA
	X/v+yWkbYf7QB0ZxZSUqKHd9z58j26+xk7SoXkiotKSrQo2xW7r9dlj/IxuPgLHh
	BqR8htbbNHc/kP2vWFjGGyVCZT1SoiGWDun8fJDleamM2nsy9pnVp+eHyXjJBEQn
	zOGqd0ltEakQ3yfiZOTZxI7P2NYDwr6WsUVbw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r/zr4pazenvSLx1WP2e1AkD0ubWnY/wc
	XF5snwJiJ9AUeQOtV0rHxeAppgwhhbP1u1/EVuL1ciJPYvcLXI80PGtt467bhT13
	Ax103TnSE49DiS1/cllp74uMT92nj9PCDYJ7Djdl/87DtE7YAmBxKbM/L1uPQ42X
	Uhx9knsaVhA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 27C3349730;
	Mon,  7 Mar 2016 15:23:17 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4E3CE4972D;
	Mon,  7 Mar 2016 15:23:16 -0500 (EST)
In-Reply-To: <1457347133-31733-1-git-send-email-chriscool@tuxfamily.org>
	(Christian Couder's message of "Mon, 7 Mar 2016 11:38:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6CAF4FD0-E4A2-11E5-BC21-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288398>

Christian Couder <christian.couder@gmail.com> writes:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/technical/api-trace.txt | 44 +++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)

I think this is fine. I'm not sure how many people would look at the
technical/api documentation in such a case, but I don't think it hurts
to document this stuff.

Having re-read this, I have a feeling that this is purely "Caveats",
not "Bugs & Caveats", though.

Will queue, but this will not be so urgent for 2.8.

> diff --git a/Documentation/technical/api-trace.txt b/Documentation/technical/api-trace.txt
> index 097a651..0e1af02 100644
> --- a/Documentation/technical/api-trace.txt
> +++ b/Documentation/technical/api-trace.txt
> @@ -95,3 +95,47 @@ for (;;) {
>  }
>  trace_performance(t, "frotz");
>  ------------
> +
> +Bugs & Caveats
> +--------------
> +
> +GIT_TRACE_* environment variables can be used to tell Git to show
> +trace output to its standard error stream. Git can often spawn a pager
> +internally to run its subcommand and send its standard output and
> +standard error to it.
> +
> +Because GIT_TRACE_PERFORMANCE trace is generated only at the very end
> +of the program with atexit(), which happens after the pager exits, it
> +would not work well if you send its log to the standard error output
> +and let Git spawn the pager at the same time.
> +
> +As a work around, you can for example use '--no-pager', or set
> +GIT_TRACE_PERFORMANCE to another file descriptor which is redirected
> +to stderr, or set GIT_TRACE_PERFORMANCE to a file specified by its
> +absolute path.
> +
> +For example instead of the following command which by default may not
> +print any performance information:
> +
> +------------
> +GIT_TRACE_PERFORMANCE=2 git log -1
> +------------
> +
> +you may want to use:
> +
> +------------
> +GIT_TRACE_PERFORMANCE=2 git --no-pager log -1
> +------------
> +
> +or:
> +
> +------------
> +GIT_TRACE_PERFORMANCE=3 3>&2 git log -1
> +------------
> +
> +or:
> +
> +------------
> +GIT_TRACE_PERFORMANCE=/path/to/log/file git log -1
> +------------
> +

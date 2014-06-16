From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc git: multivar configuration parameters append to existing values
Date: Mon, 16 Jun 2014 11:43:32 -0700
Message-ID: <xmqqd2e8r8yz.fsf@gitster.dls.corp.google.com>
References: <1402922952-172-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GitList <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Robert Clausecker <fuz@fuz.su>,
	Alex Riesen <raa.lkml@gmail.com>,
	Tanay Abhra <tanayabh@gmail.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Jun 16 20:43:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwbse-0006qq-1R
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbaFPSnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:43:40 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54149 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755369AbaFPSnj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:43:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B1192206E5;
	Mon, 16 Jun 2014 14:43:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c/AkoP5RjgjaBSi3Zj0RN5gNtqI=; b=fXnwFl
	wmcf2Qq/k/fZp7W2JTPxQmRQKwCNkA3NygBfito+oGLtDaC6jkurwi2lxFE+8jZv
	PiXCBmG73bEqvnfRBVNDQvKzd9cuKKVd9tVXvEPpIctRBfE6wRGulWy93qxM+8oS
	G+j6t9p5J8m0r07Ppb6tvEKi/BZDp20Qm9x+g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L6ALf/N5ElM/LmV1XkS/KEk5znu6hOVe
	x7ZrSqOLDcHbXom5zThAQG2qnPvO/1kDS2nEBccbSlUQBynl+cv0lyYAAfXHzyvP
	5x6cq+xVN4ugrT62EBwbU1kQSMJRCXQKm0hQP+QhqnsgNJDUHZZt6WB5IlZrZOfO
	BwHVFue4+do=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A58C5206E4;
	Mon, 16 Jun 2014 14:43:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5C0F9206DD;
	Mon, 16 Jun 2014 14:43:32 -0400 (EDT)
In-Reply-To: <1402922952-172-1-git-send-email-philipoakley@iee.org> (Philip
	Oakley's message of "Mon, 16 Jun 2014 13:49:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1DBC2F40-F586-11E3-AE16-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251797>

Philip Oakley <philipoakley@iee.org> writes:

> When the '-c' option is used to pass alternate URLs or similar
> multivar parameters to git commands the effect is not what the user
> expected [1,2].
>
> Clarify that multivar configuration parameters do not supercede
> previous values. Suggest an alternative style parameter.
>
> [1] http://article.gmane.org/gmane.comp.version-control.git/250427
> [2] http://article.gmane.org/gmane.comp.version-control.git/251529
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
>  Documentation/git.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 3bd68b0..bedbd76 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -440,7 +440,10 @@ example the following invocations are equivalent:
>  
>  -c <name>=<value>::
>  	Pass a configuration parameter to the command. The value
> -	given will override values from configuration files.
> +	given will override single valued variables from configuration
> +	files, and append to multivar variables. Previous multivar values
> +	remain in effect. Use "insteadOf" style config variables when an
> +	over-ride is needed.
>  	The <name> is expected in the same format as listed by
>  	'git config' (subkeys separated by dots).

I have two doubts, while appreciating the overall direction to
clarify things very much.

 * "single overrides, multiple appends" is not a wrong explanation
   per-se, but sounds like an arbitrary rule that forces people to
   memorize.  I wonder if it makes it less burdensome for readers if
   we just said "Git acts as if the given configuration is specified
   at the very end of the configuration files"---once the reader
   understands that Git reads all configuration varilables of the
   same name and the code paths that *use* one of them pick the one
   defined the last, it is easy to realize that "single overrides"
   is merely a natural consequence of the appending nature of "-c".

 * The last sentence added, i.e. "insteadof"-style, will not be
   understood by any reader other than those who tried to use "-c"
   on remote.*.url variables and does not belong here.  A better
   way/place to give that information is needed.

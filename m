From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: update-index: -z applies also to
 --index-info
Date: Thu, 07 Oct 2010 19:49:36 -0700
Message-ID: <7viq1dwg8v.fsf@alter.siamese.dyndns.org>
References: <AANLkTinJhKHxds3e+SwYHCbN4S_tcvE1P8j4mgwh+W00@mail.gmail.com>
 <337062f16e5b354be20b0af53a63f5c540ab0eb8.1286480355.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>,
	git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Oct 08 04:50:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P431y-0007AO-PB
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 04:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514Ab0JHCts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 22:49:48 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49508 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937Ab0JHCtr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 22:49:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DDB95DC8B0;
	Thu,  7 Oct 2010 22:49:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vawRIjcgI/kxoX8UWRp6vjHk7NU=; b=TFGjOy
	w3fBFduMeq0vWzBib+fU+LT0ycUjF47KV0Vl+00koYrvAP3j2ZFk7nw53eEu1dYY
	NIpgFMGTMlksU4MehUenUJ+MD66FuoOPymv300oBKeomQkQojHj80RyfokqI3dwv
	ojSaCt5+EzN0YSI4x4iEDEvkHz9Su+Y64CDFM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L/xYRVJ3swPgN9MakKV+9rLBGXF0bghJ
	r9SFVLc+65CDetH60VvcruPDlVWC1PN4nDfq04Zjx+OSlZk0OeKwSmDnDWWL+wJw
	6KjPI4AQH+K/NF6dtoCOdAwuxjLNKCyq3F5/tc9FedyPJVc1TL/qcuKB6kfslsFf
	Yd0JR3GdneA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A4218DC8AF;
	Thu,  7 Oct 2010 22:49:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BEF73DC8AE; Thu,  7 Oct
 2010 22:49:38 -0400 (EDT)
In-Reply-To: <337062f16e5b354be20b0af53a63f5c540ab0eb8.1286480355.git.bert.wesarg@googlemail.com> (Bert Wesarg's message of "Thu\,  7 Oct 2010 21\:39\:39 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B3AEF1E4-D286-11DF-936F-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158470>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
> index 74d1d49..0999950 100644 Documentation/git-update-index.txt
> --- a/Documentation/git-update-index.txt
> +++ b/Documentation/git-update-index.txt
> @@ -18,9 +18,9 @@ SYNOPSIS
>  	     [--skip-worktree | --no-skip-worktree]
>  	     [--ignore-submodules]
>  	     [--really-refresh] [--unresolve] [--again | -g]
> -	     [--info-only] [--index-info]
> -	     [-z] [--stdin]
> +	     [--info-only]
>  	     [--verbose]
> +	     [[-z] --stdin | --index-info]

Hmm, this requires | to bind tighter than [] around -z, but that is a bit
counterintuitive.

Also, you can put -z much earlier, e.g. "update-index -z --add --stdin",
and your version gives a false impression that we do not allow that.

Writing it as "[-z] [--stdin | --index-info]" would be much easier to
read, even though it won't convey that -z will be no-op unless we are
reading from the standard input, either with --stdin or --index-info.

I actually think we can easily lift the "must be at the end" limitation
from both codepaths.

Move the --stdin codepath to a separate helper like read_index_info(),
remove the limitation, and add a new limitation that --stdin/--index-info
can be given only once (as the reader will read thru EOF and the second
call to the reader won't help us).  And do the reading after processing
all the command line stuff (i.e. move read_index_info() call after the
option parsing loop), to allow "update-index --stdin --add hello.c" to add
new paths read from standard input and also hello.c was given from the
command line.

Wouldn't it make much more sense to spend brain cycles to write and review
such a patch, rather than documenting an unnecessary limitation?

Hmm?

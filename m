From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Allow the user to change the temporary file name for mergetool
Date: Thu, 21 Aug 2014 13:04:24 -0700
Message-ID: <xmqqvbplr4mv.fsf@gitster.dls.corp.google.com>
References: <1933929003.2352.1408519467593.JavaMail.zimbra@dewire.com>
	<1408607240-11369-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 22:04:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKYb9-0007Wz-Dl
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 22:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897AbaHUUEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 16:04:35 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51613 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752665AbaHUUEe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 16:04:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 91E483442D;
	Thu, 21 Aug 2014 16:04:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3OEcDsW+PlS9DYoRrA1ub5meUSE=; b=fA3xFP
	O5JBfGPXvH/wbaoYsb65ooOD6U/G3FxoqV6rxEeGkDsBWP//j9Rx77Ke9Np7hlyP
	x7Yuv7Zpd+YhzKudfvokeXmD/nnvJ+pRX/RpVZUq6I/6XvmG6ka6BJbX59wc21g2
	pHeyGl9v53PjUIStH18rJI/3BYSHhjOnGaxgk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M7GEM0KoJOJ6iJzC/v5XEgDhTeT6z3jw
	zOE2MlB5oyN9OihNiuLrv5s+XtxdvKcuXTkx8Bz2/6nzEtMMNdzyrbO1nodSmnyC
	KCM5DG3zwous8fl6WF82Aes2W9un4hYraXwC5UvCBjojYURKEkpeRQweYxMNMF+m
	CHcR2r7A+Lo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 876FF3442C;
	Thu, 21 Aug 2014 16:04:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id ACBE734425;
	Thu, 21 Aug 2014 16:04:25 -0400 (EDT)
In-Reply-To: <1408607240-11369-1-git-send-email-robin.rosenberg@dewire.com>
	(Robin Rosenberg's message of "Thu, 21 Aug 2014 09:47:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 59C55DCE-296E-11E4-8A5C-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255636>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> Using the original filename suffix for the temporary input files to
> the merge tool confuses IDEs like Eclipse. This patch introduces
> a configurtion option, mergetool.tmpsuffix, which get appended to
> the temporary file name. That way the user can choose to use a
> suffix like ".tmp", which does not cause confusion.
>
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> ---
>  Documentation/config.txt        |  5 +++++
>  Documentation/git-mergetool.txt |  7 +++++++
>  git-mergetool.sh                | 10 ++++++----
>  3 files changed, 18 insertions(+), 4 deletions(-)
>
> Fixed a spelling error.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index c55c22a..0e15800 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1778,6 +1778,11 @@ notes.displayRef::
>  	several times.  A warning will be issued for refs that do not
>  	exist, but a glob that does not match any refs is silently
>  	ignored.
> +
> +mergetool.tmpsuffix::
> +	A string to append the names of the temporary files mergetool
> +	creates in the worktree as input to a custom merge tool. The
> +	primary use is to avoid confusion in IDEs during merge.
>  +
>  This setting can be overridden with the `GIT_NOTES_DISPLAY_REF`
>  environment variable, which must be a colon separated list of refs or

Please read the surrounding text again and answer this question:

    What is "This setting" the continued paragraph of your paragraph
    that describes mergetool.tmpsuffix variable talks about?

Stated in another way, "match any refs is silently ignored." is the
end of the first paragraph for notes.displayRef.  "This setting can
be overridden" is the beginning of the second paragraph for the same
variable.

> +`git mergetool` may also create other temporary files for the
> +different versions involved in the merge. By default these files have
> +the same filename suffix as the file being merged. This may confuse
> +other tools in use during a long merge operation. The user can set

I would suggest these changes:

 - replace "being merged" with "being merged, so that editors and
   IDEs can use the suffix for syntax highlighting".

 - replace "this may confuse other tools" with "this may confuse
   some tools".  The same tool that takes advantage of the suffix to
   syntax-highlight may also be confused in a way that you deem
   undesirable.

 - clarify what kind of confusion this warning is talking about, and
   offer an example to avoid such confusion, and drop "in use during
   a long merge operation", as that phrase alone, without knowing
   in what way the tools are confused, is not useful to the readers.

For the last item, I unfortunately cannot offer a solid replacement
phrasing, as it was not quite clear from your explanation during the
discussion, at least to me.  Is it that Eclipse notices that a new
".java" file in the working tree appeared and offers to add it or
something?  If that is the case, then perhaps I would suggest
something like this:

    This reuse of the same file suffix may however confuse some
    tools.  For example, Eclipse may notice, while resolving
    conflicts on hello.java, that new files hello.LOCAL.java and
    hello.REMOTE.java appear in your working tree and helpfully
    offer to add it to your index and then upon conclusion of the
    merge it would complain because these files are now gone.  To
    avoid causing such confusion, you can use this variable to a
    suffix that your IDE does not treat specially, e.g. ".tmp" (this
    may obviously lose syntax highlighting, though).

But I am not sure what confusion you are trying to work around, so
the single sentence that begins with "For example," above would need
to be completely rewritten, I guess.

Thanks.

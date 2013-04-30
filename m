From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/6] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 15:07:06 -0700
Message-ID: <7v61z3brlh.fsf@alter.siamese.dyndns.org>
References: <1367358554-4257-1-git-send-email-felipe.contreras@gmail.com>
	<1367358554-4257-6-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>,
	"Duy Nguyen\" <pclouds@gmail.com>"@b-sasl-quonix.pobox.com
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 00:07:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXIht-0002Wc-EO
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 00:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933732Ab3D3WHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 18:07:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56904 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933712Ab3D3WHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 18:07:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D49B1B52D;
	Tue, 30 Apr 2013 22:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=on6z4dSf1cPhUCXciGepeOZJLk8=; b=MkKXka
	63c59uQMJYV9PnuL/lhPIsLA/qd9ViR1fgFjawEQAR9RIipbRiBVjoghvXJcnLmg
	VzqeaHbu/xOOZSYZoZd/xUy6F2n0NrURz3gdIN5qt+WSUbtGoSUPbfOhS6+F+nFL
	kCqEQFgJ4wRRogf2LLyt5yJ50Y3xJI07b0sjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rX0Eo8/wpVND2vRB38K+W/asQYjOMQiS
	A+Zh86ru4DrmzbV05r0ndsvc91/oNtzGuqnqkWtZiLHPIVNZYoDxt1L+Fhc5uWJe
	Yp6/rm9YhjcXPa3F/Q3m6SiHIS8lXvwByF+UxkC6Smgogpizy8NQIM0jWtyzhQEv
	ZS/CCgnQAYs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 944001B52C;
	Tue, 30 Apr 2013 22:07:08 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F301A1B52B;
	Tue, 30 Apr 2013 22:07:07 +0000 (UTC)
In-Reply-To: <1367358554-4257-6-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Tue, 30 Apr 2013 16:49:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4C949A7A-B1E2-11E2-9FFB-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223024>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> So HEAD@{0}~0^0 is too much to type, but we can remove '^0', and we can
> remove '~0', and we can remove 'HEAD', which leaves us with @{0}, but we
> can't remove '{0}'?
>
> This patch allows '@' to be the same as 'HEAD'.
>
> So now we can use 'git show @~1', and all that goody goodness.
>
> Until now '@' was a valid name, but it conflicts with this idea, so lets
> make it invalid. Very few people if any probably used this name, if they
> did, they can rename it by using the full-path (e.g. refs/heads/@).
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/git-check-ref-format.txt | 2 ++
>  Documentation/revisions.txt            | 3 +++
>  refs.c                                 | 4 ++++
>  sha1_name.c                            | 6 +++++-
>  t/t1508-at-combinations.sh             | 3 +++
>  5 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
> index ec1739a..e8035ec 100644
> --- a/Documentation/git-check-ref-format.txt
> +++ b/Documentation/git-check-ref-format.txt
> @@ -54,6 +54,8 @@ Git imposes the following rules on how references are named:
>  
>  . They cannot contain a sequence `@{`.
>  
> +. They cannot be the single character `@`.
> +
>  . They cannot contain a `\`.
>  
>  These rules make it easy for shell script based tools to parse
> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> index d477b3f..09896a3 100644
> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt
> @@ -58,6 +58,9 @@ the '$GIT_DIR/refs' directory or from the '$GIT_DIR/packed-refs' file.
>  While the ref name encoding is unspecified, UTF-8 is preferred as
>  some output processing may assume ref names in UTF-8.
>  
> +'@'::
> +  '@' alone is a shortcut for 'HEAD'.
> +
>  '<refname>@\{<date>\}', e.g. 'master@\{yesterday\}', 'HEAD@\{5 minutes ago\}'::
>    A ref followed by the suffix '@' with a date specification
>    enclosed in a brace
> diff --git a/refs.c b/refs.c
> index de2d8eb..4e70b3e 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -72,6 +72,10 @@ int check_refname_format(const char *refname, int flags)
>  {
>  	int component_len, component_count = 0;
>  
> +	if (!strcmp(refname, "@"))
> +		/* Refname is a single character '@'. */
> +		return -1;

This checks the single character "@" which is consistent with the
documentation update, but does not seem to mesh well with "they can
rename it by using the full-path refs/heads/@".

I do not personally think it is wrong to end the log message with
"if they did, too bad.", though ;-).

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/3] parse-options: add cast to correct pointer type to OPT_SET_PTR
Date: Mon, 31 Mar 2014 10:16:44 -0700
Message-ID: <xmqq8urq8f0j.fsf@gitster.dls.corp.google.com>
References: <cover.1396177207.git.marat@slonopotamus.org>
	<55b78495a0a171d0dbe3ec5a39d04359e1989b91.1396177208.git.marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Mon Mar 31 19:16:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUfpM-0004kg-5L
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 19:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753345AbaCaRQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 13:16:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62428 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752943AbaCaRQq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 13:16:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90B22782B6;
	Mon, 31 Mar 2014 13:16:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=spq/cVPria1dDeIw2QI/HWSimNs=; b=wdyTlz
	ve7RTlQmyehxlPVuzWg6LuJ9WMjHXy4AXVaPNrUUNbkmSgvC3hLqs7wpAnGYAa8b
	hh8CMwH34+QtHksewhgsnKx5FbApcCdVHiv1bWypYf8oKs4QvlDU9GrFJ7xSruCk
	Wx+QOHILQcDRTwtlSjvtOnNw0l9mXg6+dHBZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Md4PzlPqg8kxZfmFJ8QivZ/aOyiljeWb
	eaGeF5voemehW0CV1No/vhnxcMCrO6VenyWoxeplAMeo7Rpia7jzYENChiQoLAOj
	t6bmP8ZIatezWdjOQX2y+tLYMEE2B1Dys0nzhNG/flEprb7t3wITAWEVSqrGoOa4
	quwuHJLME+c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79ECA782B5;
	Mon, 31 Mar 2014 13:16:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DCF71782B0;
	Mon, 31 Mar 2014 13:16:45 -0400 (EDT)
In-Reply-To: <55b78495a0a171d0dbe3ec5a39d04359e1989b91.1396177208.git.marat@slonopotamus.org>
	(Marat Radchenko's message of "Sun, 30 Mar 2014 15:08:22 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3C96413C-B8F8-11E3-A87B-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245496>

Marat Radchenko <marat@slonopotamus.org> writes:

> Do not force users of OPT_SET_PTR to cast pointer to correct
> underlying pointer type by integrating cast into OPT_SET_PTR macro.
>
> Cast is required to prevent 'initialization makes integer from pointer
> without a cast' compiler warning.
> ---

Signed-off-by (and probably "From:" too): Junio C Hamano <gitster@pobox.com>

;-)

>  parse-options.h      | 2 +-
>  test-parse-options.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/parse-options.h b/parse-options.h
> index 8fa02dc..54099d9 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -129,7 +129,7 @@ struct option {
>  #define OPT_HIDDEN_BOOL(s, l, v, h) { OPTION_SET_INT, (s), (l), (v), NULL, \
>  				      (h), PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1}
>  #define OPT_SET_PTR(s, l, v, h, p)  { OPTION_SET_PTR, (s), (l), (v), NULL, \
> -				      (h), PARSE_OPT_NOARG, NULL, (p) }
> +				      (h), PARSE_OPT_NOARG, NULL, (intptr_t)(p) }
>  #define OPT_CMDMODE(s, l, v, h, i) { OPTION_CMDMODE, (s), (l), (v), NULL, \
>  				      (h), PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, (i) }
>  #define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v), N_("n"), (h) }
> diff --git a/test-parse-options.c b/test-parse-options.c
> index 6f6c656..10da63e 100644
> --- a/test-parse-options.c
> +++ b/test-parse-options.c
> @@ -60,7 +60,7 @@ int main(int argc, char **argv)
>  		OPT_STRING('o', NULL, &string, "str", "get another string"),
>  		OPT_NOOP_NOARG(0, "obsolete"),
>  		OPT_SET_PTR(0, "default-string", &string,
> -			"set string to default", (intptr_t)"default"),
> +			"set string to default", "default"),
>  		OPT_STRING_LIST(0, "list", &list, "str", "add str to list"),
>  		OPT_GROUP("Magic arguments"),
>  		OPT_ARGUMENT("quux", "means --quux"),

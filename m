From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] builtin/interpret-trailers.c: allow -t
Date: Thu, 07 Apr 2016 09:55:29 -0700
Message-ID: <xmqqr3eh1hq6.fsf@gitster.mtv.corp.google.com>
References: <1460042563-32741-1-git-send-email-mst@redhat.com>
	<1460042563-32741-2-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 18:55:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoDDa-0008Gf-0z
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 18:55:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbcDGQzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 12:55:37 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:58445 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932147AbcDGQzc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 12:55:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 22E7252163;
	Thu,  7 Apr 2016 12:55:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=92eSTdTaDwDO8bkKe8PiuJwGNPw=; b=NAoC3W
	dhsjoV8v1rzR2LA2WwUV8LLtJySJFA8px+WJfDxjpSnnjYg0xVlxM3I+I+VAbDJ5
	4ZUz3iLjwCPbDWLdn+Eu91HCtzo8najFqG3H/lWRl1QZfCRw2VQsDAiCGPbU3VEw
	2HA8p+mqTMqabwLFPctsrqNuuthgXVEnjLSDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u1gMBoSp8l7up6S6N5x0H8CtRnrRcne5
	lyq+T80pkHEZDTpwSVA5FdlD1XA+RbLgYmFAZAMtqOWuPFwkQ1KryLx6rlTvb9Az
	c8Gq4cIocHRo7lSH6peNhTM0zTypo4bOrexjfyY102EovNp/V7g0ikwb+OQNcVFL
	Spwm6xgPMCM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1747952162;
	Thu,  7 Apr 2016 12:55:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6E76152161;
	Thu,  7 Apr 2016 12:55:30 -0400 (EDT)
In-Reply-To: <1460042563-32741-2-git-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Thu, 7 Apr 2016 18:23:07 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8938B856-FCE1-11E5-8852-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290926>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Allow -t as a short-cut for --trailer.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---

As I do not think interpret-trailers is meant to be end-user facing,
I am not sure I should be interested in this step.

I am in principle OK with the later step that teaches a single
letter option to end-user facing "git am" that would be turned into
"--trailer" when it calls out to "interpret-trailers" (I haven't
checked if 't' is a sensible choice for that single letter option,
though).

>  builtin/interpret-trailers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
> index b99ae4b..18cf640 100644
> --- a/builtin/interpret-trailers.c
> +++ b/builtin/interpret-trailers.c
> @@ -25,7 +25,7 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
>  	struct option options[] = {
>  		OPT_BOOL(0, "in-place", &in_place, N_("edit files in place")),
>  		OPT_BOOL(0, "trim-empty", &trim_empty, N_("trim empty trailers")),
> -		OPT_STRING_LIST(0, "trailer", &trailers, N_("trailer"),
> +		OPT_STRING_LIST('t', "trailer", &trailers, N_("trailer"),
>  				N_("trailer(s) to add")),
>  		OPT_END()
>  	};

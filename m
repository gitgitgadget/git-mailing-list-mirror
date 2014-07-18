From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10 1/4] string-list: add string_list initializer helper function
Date: Fri, 18 Jul 2014 10:15:15 -0700
Message-ID: <xmqqvbqumvvg.fsf@gitster.dls.corp.google.com>
References: <1405675142-20300-1-git-send-email-tanayabh@gmail.com>
	<1405675142-20300-2-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 19:15:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8Bku-0002i7-Ru
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 19:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965908AbaGRRP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 13:15:26 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55597 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965879AbaGRRPY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 13:15:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 96C5C28323;
	Fri, 18 Jul 2014 13:15:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8DysyPjEk3FZRos/riqy9HTHEBY=; b=ehjip+
	BqZ2bJjy9FN3wLzGv5JR0Ht8Sdmalf+LtrD5asfs8AKDL5gXwK3yKc/m+ecx7sWR
	iuA+Ghb86D+K5k6r7lvRSH9mImLKbMxXGyRdbarE/j7Sl5uzYuy2B9mK/g1niJc7
	jtQBUaf1nx/jZWlNtD3aAoBgwapzOTIRwQNyo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d1IrfzfxOBWm+NMoI1rVCT0Z29Vbezaa
	uGWqbgcMxa8c6LkxTMBb3jlW+QEI/Q6yxAdP3kAZ/TW4xDebqeAWBWv6j4AqhLNq
	kuk27nIkkQj0SozuzCh/e5h/7lEfr17bPd+YMay7abFx1FyCoKNfTld9m9OmijL9
	FklxuccIlFw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1734528322;
	Fri, 18 Jul 2014 13:15:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B61902831F;
	Fri, 18 Jul 2014 13:15:16 -0400 (EDT)
In-Reply-To: <1405675142-20300-2-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Fri, 18 Jul 2014 02:18:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1678EB1A-0E9F-11E4-8ACD-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253829>

Tanay Abhra <tanayabh@gmail.com> writes:

> The string-list API has STRING_LIST_INIT_* macros to be used
> to define variables with initializers, but lacks functions
> to initialise an uninitialized piece of memory to be used as
> a string-list at the run-time.
> Introduce `string_list_init()` function for that.
>
> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---

Looks sensible, modulo s/initialise/initialize/ which perhaps is
originally my fault.

Will queue; thanks.

>  Documentation/technical/api-string-list.txt | 5 +++++
>  string-list.c                               | 6 ++++++
>  string-list.h                               | 2 ++
>  3 files changed, 13 insertions(+)
>
> diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
> index f1add51..d51a657 100644
> --- a/Documentation/technical/api-string-list.txt
> +++ b/Documentation/technical/api-string-list.txt
> @@ -68,6 +68,11 @@ Functions
>  
>  * General ones (works with sorted and unsorted lists as well)
>  
> +`string_list_init`::
> +
> +	Initialize the members of the string_list, set `strdup_strings`
> +	member according to the value of the second parameter.
> +
>  `filter_string_list`::
>  
>  	Apply a function to each item in a list, retaining only the
> diff --git a/string-list.c b/string-list.c
> index aabb25e..db38b62 100644
> --- a/string-list.c
> +++ b/string-list.c
> @@ -1,6 +1,12 @@
>  #include "cache.h"
>  #include "string-list.h"
>  
> +void string_list_init(struct string_list *list, int strdup_strings)
> +{
> +	memset(list, 0, sizeof(*list));
> +	list->strdup_strings = strdup_strings;
> +}
> +
>  /* if there is no exact match, point to the index where the entry could be
>   * inserted */
>  static int get_entry_index(const struct string_list *list, const char *string,
> diff --git a/string-list.h b/string-list.h
> index dd5e294..494eb5d 100644
> --- a/string-list.h
> +++ b/string-list.h
> @@ -18,6 +18,8 @@ struct string_list {
>  #define STRING_LIST_INIT_NODUP { NULL, 0, 0, 0, NULL }
>  #define STRING_LIST_INIT_DUP   { NULL, 0, 0, 1, NULL }
>  
> +void string_list_init(struct string_list *list, int strdup_strings);
> +
>  void print_string_list(const struct string_list *p, const char *text);
>  void string_list_clear(struct string_list *list, int free_util);

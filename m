From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv8 1/5] string list: improve comment
Date: Thu, 19 May 2016 11:08:18 -0700
Message-ID: <xmqq60u9kjjh.fsf@gitster.mtv.corp.google.com>
References: <20160519010935.27856-1-sbeller@google.com>
	<20160519010935.27856-2-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 19 20:12:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3SQd-0006FC-28
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 20:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933210AbcESSI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 14:08:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61201 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933144AbcESSIX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 14:08:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F0F411BC22;
	Thu, 19 May 2016 14:08:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Oec05x45vHvpGjhdRnNbgBms6vA=; b=FXrKmA
	LdGkzjHe+jo8TlxIdFyBHTggH6878kJZA8af5b9EuppgLYF73skxc5wN7wAuJa1i
	lFM1MxIte21eD+mm228ts4CmfS/kjH7aMLAvs4sZf6Du9SCrQ03eF0jw1AxOQ6Ow
	NQZ1yAlnRZsY5SwdcLIErGQ8yDinj1xTZPLC4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jLiGas5zm2UvT+IdHrYjRvdzX26c3Kdi
	CPD5d4+oPFwpI2CN/yW/Eixu2rWKW7o77HfuZNlPRTwE6bCmv+OMA4zIy95h/yZy
	qwSIMRslHiSsmmt55DvIuLqzZ9VjwP2b+a8WFR0B++PfK2tgOTtlh2Sey6sO3Z1Y
	Yakvdy1uPuA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E905B1BC21;
	Thu, 19 May 2016 14:08:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 70CA21BC20;
	Thu, 19 May 2016 14:08:20 -0400 (EDT)
In-Reply-To: <20160519010935.27856-2-sbeller@google.com> (Stefan Beller's
	message of "Wed, 18 May 2016 18:09:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AB4BCD3A-1DEC-11E6-8120-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295085>

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  string-list.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/string-list.h b/string-list.h
> index d3809a1..465a1f0 100644
> --- a/string-list.h
> +++ b/string-list.h
> @@ -106,7 +106,7 @@ void unsorted_string_list_delete_item(struct string_list *list, int i, int free_
>   * list->strdup_strings must be set, as new memory needs to be
>   * allocated to hold the substrings.  If maxsplit is non-negative,
>   * then split at most maxsplit times.  Return the number of substrings
> - * appended to list.
> + * appended to list. The list may be non-empty already.

I personally find that the original comment is clear enough, though.

When somebody says "resulting elements of the split are appended to
the list" without saying either:

  a. "the list MUST be empty in the beginning", or
  b. "the list will be emptied first before the split result are appended",

wouldn't it be natural to take it as "you can append them to any
list, be it empty or not, and they are _appended_, not replaced"?

So while this is not incorrect per-se, I am not sure if it adds much
value.  If somebody needs this additional clarification, because the
original did not say a. above, she would certainly need more
clarification because the original did not say b. above, either.

"The list may be non-empty already", but she would keep wondering if
the existing contents would be discarded before the result gets
appended to it.

You may say "No, there won't be such a confusion, because we say
'append'; empty and then append is 'replace'".  But then the same
logic would say "There cannot be a requirement for the list to be
empty in the first place, because we say 'append'".

So...

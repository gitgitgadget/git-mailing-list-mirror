From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-reset.txt: Use commit~1 notation over commit^
Date: Thu, 02 Dec 2010 10:54:03 -0800
Message-ID: <7vvd3cqa44.fsf@alter.siamese.dyndns.org>
References: <877hftuvvz.fsf@picasso.cante.net>
 <7vfwuhtafr.fsf@alter.siamese.dyndns.org>
 <AANLkTik8TNedGBQh7KXvRSf3HTTQf2-yMJC4VA4OOBjQ@mail.gmail.com>
 <87sjygspgy.fsf@picasso.cante.net> <buo39qg8zrf.fsf@dhlpc061.dev.necel.com>
 <87bp54s770.fsf@picasso.cante.net> <87mxoos4a8.fsf@catnip.gol.com>
 <20101202132053.GF6537@picasso.cante.net> <m262vcqdb9.fsf@igel.home>
 <7veia0rrew.fsf@alter.siamese.dyndns.org>
 <20101202184617.GA20225@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	jari <jari.aalto@cante.net>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 02 19:54:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POEIU-0004cv-4w
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 19:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757265Ab0LBSyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 13:54:20 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38922 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753274Ab0LBSyU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 13:54:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8E3AD247C;
	Thu,  2 Dec 2010 13:54:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uaHT+5oS2B5YNYlSJp+tm+NRiVA=; b=IA9dI0
	Aqo34EM5S+bCoshT6Ta9p8I7Ltf+5jvLco+ZXQNgy0YXLlZ4/1k5ZTy55jkYGLoO
	08Tt0gUrNk7uTQVr2rzzg7CkIPgPvxr/MryNWU8nuQn4KPl9bcCPg54FmCGFDgfX
	l2vbf/X/gshMh4LHESyZ77zbfhKW5rP7OfB0s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vUR9xUN4adHFwq17ahwLcCz3tx8dLjhq
	xZZ7HmIvuEMWyLIA7Y2OqWKRQRZ50msOPe3Lda5fXnfK2+ENpo4X7nn471ibc4BP
	HsBtbRjfP3swL7jsyoxAA9IP9rrTqkv2wsuJNNxTQEr1ompF+sHxEUEuf+aMjsf3
	eOJg4pIBwBE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3AC842479;
	Thu,  2 Dec 2010 13:54:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2A4D92473; Thu,  2 Dec 2010
 13:54:25 -0500 (EST)
In-Reply-To: <20101202184617.GA20225@sigill.intra.peff.net> (Jeff King's
 message of "Thu\, 2 Dec 2010 13\:46\:17 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9A75AA5C-FE45-11DF-800C-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162731>

Jeff King <peff@peff.net> writes:

> On Thu, Dec 02, 2010 at 09:55:03AM -0800, Junio C Hamano wrote:
>
>> Perhaps we need to also fix "git name-rev master^" which currently does
>> not try to reduce "master~1" to "master^".
>
> This patch does it:
>
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index c946a82..417bae5 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -142,8 +142,12 @@ static const char *get_rev_name(const struct object *o)
>  		int len = strlen(n->tip_name);
>  		if (len > 2 && !strcmp(n->tip_name + len - 2, "^0"))
>  			len -= 2;
> -		snprintf(buffer, sizeof(buffer), "%.*s~%d", len, n->tip_name,
> -				n->generation);
> +		if (n->generation == 1)
> +			snprintf(buffer, sizeof(buffer), "%.*s^", len,
> +				 n->tip_name);
> +		else
> +			snprintf(buffer, sizeof(buffer), "%.*s~%d", len,
> +				 n->tip_name, n->generation);
>  
>  		return buffer;
>  	}
>
> but I am not sure the results are always more readable. I think "foo^"
> is perhaps nicer than "foo~1". But in more complex examples, I kind of
> think the ~1 is easier to read. E.g.:
>
>   # old
>   $ git name-rev 9904fadf
>   9904fadf tags/v1.7.3-rc2~1^2~1
>
>   # new
>   $ git name-rev 9904fadf
>   9904fadf tags/v1.7.3-rc2~1^2^

Curious.  Why does the "first take the first parent of rc2" is left as-is,
while "then lastly take its parent" does get shortened?

> Somehow the visual appearance of "^2^" ends up being more confusing to
> me than ~1^2~1, I guess because in the latter there is a regular set of
> modifier-number pairs.
>
> But I admit that is just my subjective opinion.
>
> -Peff

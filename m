From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/17] Name local variables more consistently
Date: Mon, 27 Aug 2012 09:50:54 -0700
Message-ID: <7vsjb8s2hd.fsf@alter.siamese.dyndns.org>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
 <1345709442-16046-5-git-send-email-mhagger@alum.mit.edu>
 <20120823083918.GB6963@sigill.intra.peff.net>
 <7vvcg5v9hh.fsf@alter.siamese.dyndns.org> <503B3C5C.1020109@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Aug 27 18:51:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T62Wm-0005Wt-RE
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 18:51:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752936Ab2H0Qu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 12:50:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41022 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752232Ab2H0Qu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 12:50:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3F76664B;
	Mon, 27 Aug 2012 12:50:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jBFs51LW73VHnumWN62uEmaho/4=; b=fsfIcF
	gV4JMGsqyZpUZH+roEmIUc93g1HLs17yEfKR4u7ueIb86w63fIyzh0LANymZHICl
	07/yTlBqyNSl1xPN+Ve2JM3vHBvVgY9vRsPfaDHN/azAznjHyPmQo3sfCDlAlIOb
	I8VSo4HIGRBGUIoI5G+ZzKnVZ8skF1xj7JWRA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=quIS/Cw1E3zR+23H8TFi7nUK/trPYvpS
	DSXwVdfr411+bqylfkwNYyHdpAUSbvvQnb04ExvRhQ+xqevY3y7JQ64yQFW7eDKk
	Thrr3JcdIAeaQdAD5b6WpfrtLaqOk+qx8r7IThXygYvRQuKD3TB8Bsi26LFguLJX
	Q20iEQw/yDs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0320664A;
	Mon, 27 Aug 2012 12:50:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 44D666649; Mon, 27 Aug 2012
 12:50:56 -0400 (EDT)
In-Reply-To: <503B3C5C.1020109@alum.mit.edu> (Michael Haggerty's message of
 "Mon, 27 Aug 2012 11:22:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5EEFC218-F067-11E1-88BB-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204355>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 08/26/2012 07:39 PM, Junio C Hamano wrote:
> ...
>> After all, this codepath is not limited to branches these days as
>> the word "head" implies.  Rather, <nr_thing, thing> has what we
>> asked for, and <refs> has what the other sides have, and we are
>> trying to make sure we haven't asked what they do not have in this
>> function.
>> 
>> And the way we do so is to match the "thing"s with what are in
>> "refs" to find unmatched ones.
>> 
>> So between the two, I would have chosen "match" instead of "heads"
>> to call the "thing".
>
> When I decided between "heads" and "match", my main consideration was
> that "match" sounds like something that has already been matched, not
> something that is being matched against.  The word "match" also implies
> to me that some nontrivial matching process is going on, like glob
> expansion.
>
> But I agree with you that "heads" also has disadvantages.
>
> What about a third option: "refnames"?  This name makes it clear that we
> are talking about simple names as opposed to "struct ref" or some kind
> of refname glob patterns and also makes it clear that they are not
> necessarily all branches.  It would also be distinct from the "refs"
> linked list that is often used in the same functions.

"refnames" has a similar issue as "match", as you have pointed out,
and more.  Was it the remote or us who populated the "refnames"
(answer: these are "our" refnames, and the other one "refs" is what
they have)?  What do we have that "refnames" for (answer: these
specify what we are going to pick among what they have)?

Perhaps "asked"?  At the beginning of the processing, we have all
that were asked for, and at the end, we leave what were asked for
but were not fulfilled.

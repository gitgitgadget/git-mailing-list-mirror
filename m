From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] config: add include directive
Date: Thu, 26 Jan 2012 21:23:59 -0800
Message-ID: <7vk44d1zww.fsf@alter.siamese.dyndns.org>
References: <20120126073547.GA28689@sigill.intra.peff.net>
 <20120126073752.GA30474@sigill.intra.peff.net>
 <7vipjy2nbi.fsf@alter.siamese.dyndns.org>
 <20120126225140.GB12855@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 27 06:24:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqeID-00077O-KP
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 06:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752733Ab2A0FYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jan 2012 00:24:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38582 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752229Ab2A0FYD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 00:24:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F00C14129;
	Fri, 27 Jan 2012 00:24:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QdY9yUyr48dq5Onki6G7RJlJ0mU=; b=QLqzzn
	irKrROZCZg8MLNkacRL1inUd1HWU6LpF0K+9hUweccNZ2wWNYcx89kbvrLn9WJlr
	RI8/k03H26b/ThusC45+06NBF0LEnwJXD0T2pQ34QDV/3peabTvb3dy5z/z+NeOg
	8gB0Frs2ZC4FGfGo1Vh8Go8MhTAYjnxFXZ9yM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ojs6FJyCDCNuyhwrQSaKYmi+OCVH1mMB
	lSAZttb4KvkAZjn1LzdfxNfktguumxeQTiicuXzLdi/+e9KaWJ3rZGwsAUK12bor
	fJoJpAXZnEmQkszjwg9qMm/nbM3jL+LxA8EJsT44+7FhXWPd9UApSJTKuMEQlM9B
	HPa4whTX2sk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E76B14128;
	Fri, 27 Jan 2012 00:24:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E8FC4124; Fri, 27 Jan 2012
 00:24:01 -0500 (EST)
In-Reply-To: <20120126225140.GB12855@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 26 Jan 2012 17:51:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1EF5BA72-48A7-11E1-B08F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189190>

Jeff King <peff@peff.net> writes:

> And then because of 1a and 2a, most programs should Just Work without
> any changes, but because of 1b and 2b, any special uses will have to
> decide manually whether they would want to allow includes.
>
> Does that make sense?

In short, the "git config" interface defaults to "--no-includes" when
reading from an explicit file with "-f" and "--includes" otherwise, which
sounds like a 100% sensible default to me.

> I had a similar thought while writing it, but hoped the sentence after
> (that you snipped) would make it clear.

I think the whole paragraph makes it reasonably clear; I was merely being
pedantic to see if you or others can come up with a clear and simple way
to rephrase it that can also satisfy such pedantry.

> How about:
>
>   The included file is processed immediately, before any other
>   directives from the surrounding file.
>
> What I wanted to make clear there is the ordering, which sometimes
> matters.

Hmm, I think the original is probably easier to read.

> The one use I think is to bundle a bunch of related config options, and
> then turn them on selectively.
> ...
> but with this patch, you can do:
>
>   cat >~/.gitconfig.foo <<-\EOF
>   [foo]
>   one = 1
>   two = 2
>   EOF
>   git -c include.path=$HOME/.gitconfig.foo blah

That is quite a sensible use case actually.

Thanks.

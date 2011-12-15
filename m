From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] in rev-parse
Date: Thu, 15 Dec 2011 09:43:14 -0800
Message-ID: <7vvcphohn1.fsf@alter.siamese.dyndns.org>
References: <20111214184926.GB18335@llunet.cs.wisc.edu>
 <20111214210157.GA8990@sigill.intra.peff.net>
 <7vk45yplkm.fsf@alter.siamese.dyndns.org>
 <20111215070521.GB1327@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: nathan.panike@gmail.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 15 18:43:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbFL8-0007tR-7D
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 18:43:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520Ab1LORnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 12:43:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64245 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447Ab1LORnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 12:43:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 384D77357;
	Thu, 15 Dec 2011 12:43:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1raaMOPl7co4PQnGFkQLnJdyNNo=; b=ZiJIWy
	Hh65wAL75T1bT7Pmiy6H3erVH87AMQyXWZe1w9H/7Qlh0A0GL6boW5OWULQg0Wmd
	tidNYrxwn7OaF166JWlhCd8alAIPbrKU8uc3dC9eQNsLjC6xjzkKvq96I72fp904
	pc6ysjB7d+rg9vtYIgXArTidHQfvDQjp9KQ8M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jrQLpSxUSt1mACgC3WUxYb2Y6Y3vbu9n
	EnNyjmCLhGKAAtvQnk05OJqsojZsw0ffwYcYGgzl/bFRqGKJHDBdt5ileaE1BXNg
	zeUUDWMqLuZrw9xf4aR0mkt0gLgmuwqXeEZ1XwgUstPnVfBCyH7KznoFrBSsfig9
	wm4oSLHq9so=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F6F57356;
	Thu, 15 Dec 2011 12:43:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9A6617355; Thu, 15 Dec 2011
 12:43:15 -0500 (EST)
In-Reply-To: <20111215070521.GB1327@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 15 Dec 2011 02:05:21 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 44631AD6-2744-11E1-8D6B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187215>

Jeff King <peff@peff.net> writes:

> Dropping the implied verify is easy (see below). But handling
> non-existant sha1s is a much more complicated change, as the regular
> abbreviation machinery assumes that they exist.

Hmm, I was very sure that I wrote a logic to do the "no such object" case
at least once, so I looked and found one in find_unique_abbrev(). But that
requires the caller to feed the full 160-bit sha1[] and perhaps it is not
easily used in the context of rev-parse (I didn't look further).

> Anyway, I'm not sure it's worth changing at this point. It's part of the
> plumbing API that has been that way forever,...

Ok.

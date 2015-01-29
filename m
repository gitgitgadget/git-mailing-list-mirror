From: Junio C Hamano <gitster@pobox.com>
Subject: Re: All gnupg tests broken on el4 [Re: [ANNOUNCE] Git v2.3.0-rc2]
Date: Thu, 29 Jan 2015 10:48:26 -0800
Message-ID: <xmqqpp9xe83p.fsf@gitster.dls.corp.google.com>
References: <xmqqpp9ziyqh.fsf@gitster.dls.corp.google.com>
	<54CA3169.4020701@statsbiblioteket.dk> <20150129154319.GA742@peff.net>
	<54CA6F3E.4060804@statsbiblioteket.dk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
X-From: git-owner@vger.kernel.org Thu Jan 29 19:48:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGu8t-0000ZC-Us
	for gcvg-git-2@plane.gmane.org; Thu, 29 Jan 2015 19:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754498AbbA2Ssg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2015 13:48:36 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57675 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753234AbbA2Ssf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2015 13:48:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 236DF33033;
	Thu, 29 Jan 2015 13:48:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iVq1JqGdtDobaea8fbg4XA+rVyo=; b=GgB8FR
	pBs2rI0FE+HXCYrUGuJT+Ep4Vhws/oao2kA63vaLaDEtJc/VX4lD3QcA6GtluJBO
	ZD8BHJwlo3ptl9zeFoMhBnTIldKzQ8QB4VWBCE6gCG73QAKDIw7dKRl7pFK5KtxM
	/9SkfzUd0NoivxhqSaPiEcDeoXXQbdkQXpWaI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qe08B+YhG4K/2DyCREjZhTJzv5jZMerI
	Vkitz7l0P5YPAscYSwmo/GkqBEzxZ4NeDyNbRQIvPgS033HScZtBbpsGUis1BFtE
	aM9nh3fW6fJlM0dbSe8St8VtmHn25vnGuPBK/kYJF5iVjdZyOokUs9RHzRN0NqCb
	5/X5a3cxPMA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1804333032;
	Thu, 29 Jan 2015 13:48:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DE87D3302F;
	Thu, 29 Jan 2015 13:48:28 -0500 (EST)
In-Reply-To: <54CA6F3E.4060804@statsbiblioteket.dk> (Tom G. Christensen's
	message of "Thu, 29 Jan 2015 18:34:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6A372604-A7E7-11E4-9E16-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263157>

"Tom G. Christensen" <tgc@statsbiblioteket.dk> writes:

> On 29/01/15 16:43, Jeff King wrote:
>
>> Another option is to just declare that version old and broken, and skip
>> the tests (either by checking its version, or just checking after we
>> import the keys that we can actually _use_ them).
>>
> That would seem a bit heavy-handed as it is otherwise working fine
> with the old gnupg.

Thanks, both, for tracking this one down.

I am tempted to say that we should do both.  This "export public
key, even though new importers do not need" fix to make things
usable with 1.2.6, and the other one to catch and skip breakages
when future versions of GPG breaks us in whichever way we do not
anticipate now.

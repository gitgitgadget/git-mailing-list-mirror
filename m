From: Junio C Hamano <gitster@pobox.com>
Subject: Re: mktree: multiple same-named objects
Date: Wed, 27 Aug 2014 08:17:15 -0700
Message-ID: <xmqqk35uezd0.fsf@gitster.dls.corp.google.com>
References: <1409114517.13351.6.camel@leckie>
	<20140827051341.GB32141@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Turner <dturner@twopensource.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 27 17:17:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMeya-0001W4-L2
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 17:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934825AbaH0PR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 11:17:27 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57349 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934703AbaH0PR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 11:17:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 967D931EAD;
	Wed, 27 Aug 2014 11:17:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GqY9OJDwSgMiBsWTnzgBQ9OWvps=; b=KFLUL8
	e/7Nh2Kzdt3eq8X2SWh/KeSIlgehuV/pOMC3NmWw9m4QYaWQHkUQ7kSOOlAMw8aA
	9wSG8uh4mznSPCRXm2OZrmGBAA3xIRqXlCCz9lfvGWWiL/pD+v4hM6fVDw7RlFBE
	0TK4YeJIiguFFiS6vbsaq/IEChUFjxBu8Kbio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T2xVEZV7QuDYhsV9plxkRbgv6zLMZ0Ri
	EURt8lso7/NcqxvuxIX0fnB59TYFEX/saHHFQhLappVT/MMe4PLFufxPwkeZxuMs
	TlzaQDynf4wj1YoqwokCJaPILZQDtyhrGkHhdhPFxQGoOS4/5CTuTiFsH6ZqXk9O
	RRnGM+jjVDU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8D0B531EA8;
	Wed, 27 Aug 2014 11:17:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 303FA31E98;
	Wed, 27 Aug 2014 11:17:17 -0400 (EDT)
In-Reply-To: <20140827051341.GB32141@peff.net> (Jeff King's message of "Wed,
	27 Aug 2014 01:13:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3B434ABC-2DFD-11E4-A314-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256002>

Jeff King <peff@peff.net> writes:

> On Wed, Aug 27, 2014 at 12:41:57AM -0400, David Turner wrote:
>
>> git mktree seems to allow the creation of a tree object with multiple
>> objects of the same name but different SHAs.
>
> Yeah, I don't think we do many quality checks there. Ditto for "git
> hash-object".

I am somewhat against outright removing the capability to write out
invalid objects deliberately from these low level tools, because we
would need a way to easily reproduce bugs in end-user facing tools
by other people who claim to produce Git objects, but I would agree
that by default that should be forbidden.

In other words, two things must happen; improve checks when these
low level debugging aid tools are creating objects, and allow
bypassing these additional checks with "--experiment" option or
something.

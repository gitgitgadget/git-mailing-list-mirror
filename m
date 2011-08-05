From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: fix has_action
Date: Fri, 05 Aug 2011 10:01:03 -0700
Message-ID: <7v1uwz4wts.fsf@alter.siamese.dyndns.org>
References: <1312450780-5021-1-git-send-email-nrubinstein@proformatique.com>
 <7vliv93r9g.fsf@alter.siamese.dyndns.org> <4E3BFB86.4010408@sohovfx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Noe Rubinstein <nrubinstein@proformatique.com>,
	git@vger.kernel.org
To: Andrew Wong <andrew.w@sohovfx.com>
X-From: git-owner@vger.kernel.org Fri Aug 05 19:01:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpNlo-0006t1-KP
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 19:01:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754320Ab1HERBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Aug 2011 13:01:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58886 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750924Ab1HERBG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2011 13:01:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C709C4C37;
	Fri,  5 Aug 2011 13:01:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KgK+KlwazJUS0jVAp5Jd7au486k=; b=joURkD
	Ny6Od3aApY9iOwk536Q6aEdAgb1sIWHd9lLSd/aIyWvL5ZbRJayIfDxtiyz+1PqG
	8h1F90V3p41bhKOUZjLzuV9d4C+BG+Ug6g5CVVEjZm5dLohCtIFIuUvacpk60I0I
	7vKJjPf2BfpNV7R2rcbSw8etFQWyuIPiD2HsE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TkAFVmioM51v5ToMYImn4uehIxH8pXJ3
	0C6gRnctr5fK+hM0HGX8z3Eg0AwgEXivTSxbPGfFmCkeFb3LEMTJ4zmI4vaco+H6
	ozwtUuJUFtlYi7+fpn4WDpLuJpNTur8NBfc9kl2DRmrcDAZlPpFb6xbBDIIhdniQ
	Y263b/2URw8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABDC04C34;
	Fri,  5 Aug 2011 13:01:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 37E8E4C33; Fri,  5 Aug 2011
 13:01:05 -0400 (EDT)
In-Reply-To: <4E3BFB86.4010408@sohovfx.com> (Andrew Wong's message of "Fri,
 05 Aug 2011 10:17:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 81A2C9A0-BF84-11E0-9625-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178803>

Andrew Wong <andrew.w@sohovfx.com> writes:

> On 08/04/2011 03:34 PM, Junio C Hamano wrote:
>> How about removing the unnecessary negation from the logic and directly
>> ask what we really want to know?
>>
>> That is, "Do we have a line that is _not_ comment?"
>>
>> 	has_action () {
>>           sane_grep -v -e '^#' -e '^[   ]*$' "$1" >/dev/null
>> 	}
> How about also including comments that begins with spaces? i.e.

Not interested.

It would be _clear_ if you inserted extra space before '#'; Noe's issue is
that it is not clear if you have extra space on a blank line, which I am a
bit more sympathetic.

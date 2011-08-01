From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] bisect: Add support for a --no-checkout option.
Date: Sun, 31 Jul 2011 18:00:10 -0700
Message-ID: <7v39hmkkth.fsf@alter.siamese.dyndns.org>
References: <1312014511-7157-1-git-send-email-jon.seymour@gmail.com>
 <201107301548.09815.chriscool@tuxfamily.org>
 <CAH3Anrp8aT1UwfstJ99Ug4MD2CZKB9oE_oRLksbkGGE1xSELsg@mail.gmail.com>
 <201107301619.51438.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org,
	j6t@kdbg.org, jnareb@gmail.com
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 03:00:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qngri-0007XM-Rm
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 03:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403Ab1HABAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 21:00:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58352 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753102Ab1HABAM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 21:00:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DD484602;
	Sun, 31 Jul 2011 21:00:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WzNkybuT5Z6jqA2AIDmnIRfyw2o=; b=fYkbBh
	3SwPve8bNb/ELCSOgM8wvxeAIYa2DwRG+ie53nYrwHyLJVDvO2TPhZa2aZTPbCzS
	OLv092BEawvh/+pLf+Tqo6eDFmMYH+8GJNIISbl1Fj7OUQp9Gk17fyhkyaoZxtyL
	z3SWMcK+i5YnQF2auvlyBR6X8d9U3lGP0aZMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UkVNISaJ1alVxZGoXTj/asd/NONRbQ7E
	te5BGDdg23NnPDYP0mmgpH/aNFnKOMCiGk+1mGZmR8Args4/8wciPAr9QEDKPO08
	LdLUdxot92iaEFCYKo7yNzCbWPEsmda8vnmo/TyrU8uxn3ivlJV6iuh7pd2zLwnX
	2hFOHzSr/t0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 246FA4600;
	Sun, 31 Jul 2011 21:00:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F61345FF; Sun, 31 Jul 2011
 21:00:11 -0400 (EDT)
In-Reply-To: <201107301619.51438.chriscool@tuxfamily.org> (Christian Couder's
 message of "Sat, 30 Jul 2011 16:19:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9BC2FD90-BBD9-11E0-986A-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178288>

Christian Couder <chriscool@tuxfamily.org> writes:

> On Saturday 30 July 2011 15:58:16 Jon Seymour wrote:
>> On Sat, Jul 30, 2011 at 11:48 PM, Christian Couder wrote:
>> > 
>> > Sorry but I didn't reply to your previous email when you asked about a
>> > "--no- checkout[=<ref>]" compromise. I thought that Junio would reply
>> > and then I forgot about it.
>> > 
>> > My opinion is that if you really want to be able to use another ref, then
>> > there should be a special "--update-ref=<ref>" or "--use-ref=<ref>"
>> > option that is different from "--no-checkout".
>> > 
>> > "--no-checkout" looks like a boolean argument. And
>> > "--no-checkout[=<ref>]" may make the user think that this option will
>> > not checkout <ref>, and then it leads to the confusing question "but why
>> > would it checkout this f&#@ing ref in the first place?".
>> 
>> Good suggestions.
>> 
>> So, to confirm that I understand:
>> 
>>     use --no-checkout to control (no-)checkout behaviour and
>> --update-ref to specify a ref other than HEAD?
>
> Yeah, I think it would be less confusing like this.

When used without "--no-checkout" option, "bisect" need to check-out the
candidate version. What good would it do if it does _not_ update HEAD when
it does so?

While you are correct to point out --[no-]checkout is a boolean option,
this "we do not update HEAD but update this other thing" is not orthogonal
to the option. It does not make sense when we actually touch the working
tree.

My preference is not to play games with "we can specify a ref other than
HEAD" until somebody can demonstrate why it is a feature "because we need
to be able to do so in such and such times", not merely "because we can".

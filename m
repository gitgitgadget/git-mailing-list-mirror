From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v2 3/3] status: introduce status.displayCommentChar to disable display of #
Date: Wed, 28 Aug 2013 14:53:07 -0700
Message-ID: <xmqqeh9d8ou4.fsf@gitster.dls.corp.google.com>
References: <vpqhaeaasuf.fsf@anie.imag.fr>
	<1377694024-24173-1-git-send-email-Matthieu.Moy@imag.fr>
	<1377694024-24173-3-git-send-email-Matthieu.Moy@imag.fr>
	<xmqq1u5da8dp.fsf@gitster.dls.corp.google.com>
	<vpq61up5y5s.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, j.sixt@viscovery.net
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 28 23:53:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEng4-0004cf-7u
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 23:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468Ab3H1VxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 17:53:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60641 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755534Ab3H1VxT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 17:53:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2976A3D77F;
	Wed, 28 Aug 2013 21:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TZEKueAnVeQqrs2Nn2k3lnKy5Oo=; b=pi0t7P
	10Z5trP66TMvLv4MU6rC72MwAIC+6di4ewEk+dRU0cAyxcQNVlR2gO3Cbd1iJ90X
	I4rH1kJfMThqwCrpWkggBstrfLnFj4MExNjqV6l4M+u4FbkUhi+KZi2UbxP2Kftv
	lWyxS/ESdYcU6trztJgqFAuhK1mb4or/PXSrw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XJ+tKLPaWIdhqkByPkzF4qIhPuG2Ur93
	mF1LmwHaK07uR3+oIkpgMthWogxrzbiTRPxomuc4HI1aVTX2MKgWnm/GphXrZKtj
	fUTTLd9y3rxFXE1kRZ8LrWltYhx/3HseYoRkTnNXKWTYuk2of4JmwSPTJbsPusRo
	FjVqRROL/CE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B79B3D77E;
	Wed, 28 Aug 2013 21:53:19 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 35D5E3D779;
	Wed, 28 Aug 2013 21:53:17 +0000 (UTC)
In-Reply-To: <vpq61up5y5s.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	28 Aug 2013 22:59:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3EF8307C-102C-11E3-8AF8-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233222>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>>
>>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>>> index ec57a15..dacf4b9 100644
>>> --- a/Documentation/config.txt
>>> +++ b/Documentation/config.txt
>>> @@ -2118,6 +2118,11 @@ status.branch::
>>>  	Set to true to enable --branch by default in linkgit:git-status[1].
>>>  	The option --no-branch takes precedence over this variable.
>>>  
>>> +status.displayCommentChar::
>>> +	If set to false, linkgit:git-status[1] will not prefix each
>>> +	line with the comment char (`core.commentchar`, i.e. `#` by
>>> +	default). Defaults to true.
>>
>> We prefix core.commentchar followed by a single space for non-empty
>> lines; is that worth mentioning, I wonder?
>
> (and sometimes # is followed by a tab)
>
> I don't think it's worth the trouble. The goal is not to document the
> format precisely, but to explain the user how to use the variable.
>
>> Also I envision that we would extend core.commentchar to be more
>> than a single character.  Is "displayCommentChar" still a good name
>> for this setting?
>
> It is as good as core.commentChar ;-).

Not really; taken together with "# has a space after it", calling
it "prefix" in the mechanism to omit it makes tons of sense.

>> What are our plans to help existing scripts people have written over
>> time, especially before "status -s" was invented, that will be
>> broken by use of this?
>
> I don't know what's the best plan, but I think any sensible plan starts
> by waiting for a few releases, so that Git version not implementing
> status.displayCommentChar become rare enough. So we can delay the actual
> plan until next year I guess.

Actually as Peff pointed out, we've already told number of times
that "status" output is for human consumption and scripts should not
attempt to parse it, long before we gave them -s/--porcelain
options, so we are good without "auto".

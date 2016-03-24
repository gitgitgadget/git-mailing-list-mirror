From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] api-parse-options.txt: document OPT_CMDMODE()
Date: Thu, 24 Mar 2016 10:16:31 -0700
Message-ID: <xmqqy49794pc.fsf@gitster.mtv.corp.google.com>
References: <01020153a7e08100-cf66fc9f-7293-4d8c-98c6-f322721c741f-000000@eu-west-1.amazonses.com>
	<xmqqtwjvamhe.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPPhq0HNpJt3mt=AWZw7S3ikEL2XX-SOM8CcRkFie=9vcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 18:16:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj8sD-0004VD-28
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 18:16:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbcCXRQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 13:16:36 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:58206 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750732AbcCXRQf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 13:16:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E067D4C41D;
	Thu, 24 Mar 2016 13:16:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xqE3Rf50VE+Wf8esJJszfDGA7ss=; b=moDaIr
	QxGibbXWBY9pVKDLEW9oqQyJFYjCzlSDGLf49GqJwCiNYkUg6hjUuk7ngNyJeDiw
	8eHpZAFGw98PCXxMVVpUX3trGiQbA1TdcYgHXlZllZX0Op0+KspEGaxkCeXT0ACY
	r0ciMGp8HGSmEq75gDXrrEazbQk73ABBj6XiU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EFdzeOxxABQ07Ttq7mD9mVF4fM/hoy1C
	Pl8Mhz/qYdNQcwTPk4GOP6WloEGZb0NG/l4MMeZowXjPbu89iV3IRtL8sf4m7C8Q
	RVYr/nevSha2T6znCUITgRLZhaU7BdS+Mr9AY3m8dy+NBVQfOb3QL++dCzc1CEUx
	0Nheo2/SNq0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D62484C41C;
	Thu, 24 Mar 2016 13:16:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 344B34C41B;
	Thu, 24 Mar 2016 13:16:33 -0400 (EDT)
In-Reply-To: <CAFZEwPPhq0HNpJt3mt=AWZw7S3ikEL2XX-SOM8CcRkFie=9vcQ@mail.gmail.com>
	(Pranit Bauva's message of "Thu, 24 Mar 2016 22:25:29 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 281A122A-F1E4-11E5-AE46-EB7E6AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289764>

Pranit Bauva <pranit.bauva@gmail.com> writes:

>>> +`OPT_CMDMODE(short, long, &int_var, description, enum_val)`::
>>> +     Introduce an option for subcommands. It is useful when you want to use
>>> +     the command with a particular sub command only and ignore other sub
>>> +     commands it has. It will set `int_var` to enum_val if the argument is
>>> +     invoked.
>>> +
>>
>> Sorry, but I do not get what "when you want to... ignore other sub
>> command it has" wants to say.
>
> What I meant by this statement is that (your example), let's say we
> have "add", "remove" and "edit" sub commands. Now the user has to pick
> between the three. He cannot choose more than 1 from these.

Then I find the word "ignore others" misleading.  Quite the
contrary, the user has to be aware of the others and not to give
them.

	Define an "operating mode" option, only one of which in the
	same group of "operating mode" options that share the same
	`int_var` can be given by the user.  `enum_val` is set to
	`int_var` when the option is used, but an error is reported
        if other "operating mode" option has already set its value
        to the same `int_var`.

or something?

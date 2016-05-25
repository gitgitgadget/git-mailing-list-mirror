From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC-PATCH 1/2] send-email: new option to quote an email and reply to
Date: Wed, 25 May 2016 11:15:05 -0700
Message-ID: <xmqqr3cqypg6.fsf@gitster.mtv.corp.google.com>
References: <1464031829-6107-1-git-send-email-tom.russello@grenoble-inp.org>
	<1464031829-6107-2-git-send-email-tom.russello@grenoble-inp.org>
	<vpq60u4bl4e.fsf@anie.imag.fr>
	<b1752a59-af2b-6e18-fc69-0650440939e3@grenoble-inp.org>
	<vpqh9dmfy5k.fsf@anie.imag.fr>
	<xmqqwpmi16zt.fsf@gitster.mtv.corp.google.com>
	<vpqeg8q5b6f.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Samuel GROOT <samuel.groot@grenoble-inp.org>,
	Tom Russello <tom.russello@grenoble-inp.org>,
	git@vger.kernel.org, erwan.mathoniere@grenoble-inp.org,
	jordan.de-gea@ensimag.grenoble-inp.fr,
	Tom Russello <tom.russello@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 25 20:15:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5dKv-0003xM-2r
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 20:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754259AbcEYSPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 14:15:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62722 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752237AbcEYSPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 14:15:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 14E411D8FA;
	Wed, 25 May 2016 14:15:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BVMb8OoH9e5ISSll8OXuDWggK/M=; b=j+qZRQ
	9ExvrXCIJjee0VBqYO+id7x51MANIGpuHE75nzK9xhITa5AOxNLIGPzXnkdiVBmK
	G49vbwy47d4TgGTG2iRqY/6BtTUtkGj72hEmy3K0XIFWOmvfYZKvhdm4//udtNwE
	Wazj4S65P8p8IZaFL20g0c5nXMbZpBuzPNGgw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aP8XXOIOd5A3A1/oRgfo1soKnW5d9a0a
	YS50ijXyEcRjHhYXPcf+cGtWSoxiWyuWW91qJHJgnpxH3MvENA1N7CjKQyDheOG3
	1LaYHSTdbUncVwxRalw9iqmcFY6xdWdjqUCzotjilbZfrOSSguWjbbPXHTTgVsKi
	2fvjzg+d7wk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F36D71D8F8;
	Wed, 25 May 2016 14:15:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E26E21D8F4;
	Wed, 25 May 2016 14:15:06 -0400 (EDT)
In-Reply-To: <vpqeg8q5b6f.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	25 May 2016 18:56:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9C1647E8-22A4-11E6-A1F5-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295583>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> This should work, but sounds like too much of overloading of
> --in-reply-to IMHO: if given a message id, it would only add a reference
> to this message-id, but if given a file, it would also modify the To:
> and Cc: list.
>
> Not a strong objection, though.

Well, with your "that is the plan indeed", the option would behave
the same whether given a message ID or a filename, no?

But I do agree that those who have accustomed to the behaviour of
--in-reply-to that does not mess with To/Cc:, such a behaviour
change is not desirable.

If we are adding a new --reply-to-email=<file|id>, it should behave
as a superset of --in-reply-to (i.e. it should set In-Reply-to:
using the message ID of the e-mail we are replying to), though.

>> In the future, you might even teach send-email, perhaps via a user
>> configurable hook, a way to get to the message header and text given a
>> message-id, and when it happens, the same logic can be used when
>> --in-reply-to is given a message-id (i.e. you go from the id to the
>> message and find the addresses you would To/Cc: your message).
>
> That is the plan indeed. Fetching from gmane for example should be
> rather easy in perl, and would be really convenient!

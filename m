From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] i18n: mark OPTION_NUMBER (-NUM) for translation
Date: Tue, 05 Feb 2013 18:44:05 -0800
Message-ID: <7vpq0enoui.fsf@alter.siamese.dyndns.org>
References: <20130205121552.GA16601@lanh>
 <883efc2358a0deb48bee48134d45ddd528a732d3.1360080194.git.worldhello.net@gmail.com> <8d6d4d869ea58e0a26b3bb6377fc102728948997.1360080194.git.worldhello.net@gmail.com> <7vd2weu1sq.fsf@alter.siamese.dyndns.org> <CANYiYbF1cS=K9M0cwE5V0pUJMPEYGiJOjJwg5KQScCf8pjyTqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 03:44:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2uzy-0007Wq-44
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 03:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754261Ab3BFCoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 21:44:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35916 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753347Ab3BFCoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 21:44:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E9DFB9C4;
	Tue,  5 Feb 2013 21:44:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6pNY03+CWNdsNQptfuv3oIMM+1g=; b=a3SAMI
	yHNdYU07+K6euomF8sh/6gBa7t2XYhi1rdLfh1Ml/xTG3HLnHkcDDHrtoSro4UDG
	JOjCXqssP34ND1BgHJokVRxlwMBUUb6S9Nn2RbSDzQaMVLben3VvtfwJGv57NRSe
	hjLFB9zVlOinka6xeDf6h6s5GJrdlxKLeztS4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V9WTkZPjhlo9UXjM7RwYCg5h92NwC1mq
	DVULgWiKh+KNlMeE1gS60MfEa76Jlcs0t7ACE8dkI3A1UPWc/jROtM12O+3xA70b
	gjhTPBkGSfBHwoSQxc+36H563iRXcFjhp5KfOoepOd9JBBUGn9jgcfjkQgMLUriJ
	V/l9Sifp1Ik=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 630D1B9C3;
	Tue,  5 Feb 2013 21:44:08 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D38D6B9B8; Tue,  5 Feb 2013
 21:44:07 -0500 (EST)
In-Reply-To: <CANYiYbF1cS=K9M0cwE5V0pUJMPEYGiJOjJwg5KQScCf8pjyTqw@mail.gmail.com> (Jiang
 Xin's message of "Wed, 6 Feb 2013 08:15:33 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1418B180-7007-11E2-99D0-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215558>

Jiang Xin <worldhello.net@gmail.com> writes:

> 2013/2/6 Junio C Hamano <gitster@pobox.com>:
>> I somehow suspect that this is going in a direction that makes this
>> piece of code much less maintainable.
>>
>> Look at the entire function and see how many places you do fprintf
>> on strings that are marked with _().  short_name and long_name are
>> not likely to be translated, but everything else is, especially
>> multiple places that show _(opts->help) neither of these patches
>> touch.
>>
>> I wonder if it makes more sense to add a helper function that
>> returns the number of column positions (not bytes) with a signature
>> similar to fprintf() and use that throughout the function instead.
>
> I agree, a helper named 'utf8_fprintf' in utf8.c is better.
> I will send a patch latter.

Yeah, the idea of a helper function I agree with; I am not thrilled
with the name utf8_fprintf() though.  People use the return value of
fprintf() for error detection (negative return value means an error)
most of the time (even though non-negative value gives the number of
bytes shown), but the primary use of the return value from the
utf8_fprintf() function will be to get the display width, and the
name does not quite capture that.

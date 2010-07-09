From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] war on echo in scripts
Date: Fri, 09 Jul 2010 09:30:43 -0700
Message-ID: <7vk4p4mxcc.fsf@alter.siamese.dyndns.org>
References: <7vpqyz278o.fsf@alter.siamese.dyndns.org>
 <20100707091633.GB31048@genesis.frugalware.org>
 <AANLkTinFu08juNtz5eYyjzxuW6zbyGyn5f4S3wh0TI0E@mail.gmail.com>
 <20100707094620.GC31048@genesis.frugalware.org>
 <7v7hl6stna.fsf@alter.siamese.dyndns.org>
 <20100708103552.GF31048@genesis.frugalware.org>
 <20100708171418.GA18229@burratino> <m2k4p58tum.fsf@igel.home>
 <20100709024633.GA13739@dert.cs.uchicago.edu>
 <7vocehmfe9.fsf@alter.siamese.dyndns.org> <20100709143011.GA1980@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 09 18:31:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXGTo-0005Wx-Co
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 18:31:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757757Ab0GIQbH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Jul 2010 12:31:07 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50269 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757497Ab0GIQbF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jul 2010 12:31:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DECCC3F94;
	Fri,  9 Jul 2010 12:31:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=K9YsZrjCtwXF
	2yoYBpIZXXfJuJs=; b=ZBqD4mNL5y16K3dInRsRnjs8sYQjtvKA6Ekqbe/Ux+N1
	EtG5ch5oxOXfjGQJZU+xZ+AvNOKHIGJCSdLoJlPWe8Bpkf6JcO6taMCUqpP7mMRG
	jmDbPrNVVmQF5A/NGnPM7qx2btAXd+pTdLnjv3MQ/ko4MqDkkW4/U/GB/PTop0A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rK1QcJ
	q4VteXX/qYWvrtHQ67teZvyrD4HteQoOmM2BbJrve1DaTm6B/3nFkwlEmXuJMEph
	aEjXek3JCz//XEVGmahDjkvNsoINslQgimnZs2BqUQuXDJy0Jm+MF9xkM06fCVlJ
	k7lXOXhDM9dyMXCtFpTm+cT1O1YJjZkBvWf4s=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C4899C3F8E;
	Fri,  9 Jul 2010 12:30:56 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C839EC3F8C; Fri,  9 Jul
 2010 12:30:50 -0400 (EDT)
In-Reply-To: <20100709143011.GA1980@burratino> (Jonathan Nieder's message of
 "Fri\, 9 Jul 2010 09\:30\:11 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 59C3B0E4-8B77-11DF-B6E3-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150678>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> +echo() {
>>> +	printf '%s\n' "$*"
>>> +}
>>
>> As long as we don't have "echo -n" and "echo -e", this should
>> work, but...
>
> Yes, it=E2=80=99s ugly.  And it could make for surprises in user scri=
pts.

The latter could be avoided with "s/echo/sane_echo/"; we do that alread=
y
for grep don't we?

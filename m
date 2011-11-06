From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add abbreviated commit hash to rebase conflict message
Date: Sun, 06 Nov 2011 12:27:52 -0800
Message-ID: <7vaa89573r.fsf@alter.siamese.dyndns.org>
References: <1320501759-27236-1-git-send-email-srabbelier@gmail.com>
 <7v39e2852t.fsf@alter.siamese.dyndns.org>
 <CAGdFq_hw1630ELQP3+AEaCmUTEjYq7K1j8ZB-n0_rb1VN=wQgA@mail.gmail.com>
 <7vy5vt7uqo.fsf@alter.siamese.dyndns.org>
 <CAGdFq_j7NxojZ+82s0GJ8ZF0oyd5sH8t0kcMOTQGtKbASXqYTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jonas =?utf-8?Q?Flod=C3=A9n?= <jonas@floden.nu>,
	Eric Herman <eric@freesa.org>, Fernando Vezzosi <fv@repnz.net>,
	Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 06 21:28:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RN9Jx-00030a-75
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 21:28:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753879Ab1KFU14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Nov 2011 15:27:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49223 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752105Ab1KFU1z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2011 15:27:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 592066358;
	Sun,  6 Nov 2011 15:27:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LGrU1nvcM+/DXB6qvj20hBEdkXM=; b=qwNgTC
	YxS43z87Y954aeOogAunSbStHhfOpZ2676JfF1t7bFXwvXEMJMvVkvTJB/DWrMEp
	bSF6UtkF6lKw8FwuI3YPev6Jae+/Mi7ppYyr+juZwzLBryCfwiHq+eJDtYD2bodq
	fwsoUpcobYV+Q7WySuSlYglGI2nm5bCGuFZuA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vNPPYcp2sxek592OyWefJq+qQpbndpSK
	Uc7E5gOLRTYbjOAv+aSfRCJEv7du8w7/WQ4zX16/4WDU/1MbDJ8mlHR0uPLRp9xO
	VPzaBVHDcN0u5EgxoNLufiwFpmvEgQqeSYJieI8Lj6FBHaKsHI7tHmZuv3hrJPIy
	Zr/XupcwAkc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EA676357;
	Sun,  6 Nov 2011 15:27:55 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C5136355; Sun,  6 Nov 2011
 15:27:53 -0500 (EST)
In-Reply-To: <CAGdFq_j7NxojZ+82s0GJ8ZF0oyd5sH8t0kcMOTQGtKbASXqYTA@mail.gmail.com> (Sverre
 Rabbelier's message of "Sun, 6 Nov 2011 20:35:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CE8C20CA-08B5-11E1-8C61-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184931>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Sun, Nov 6, 2011 at 05:14, Junio C Hamano <gitster@pobox.com> wrote:
>> I am puzzled, but that cannot be true. The existing message uses $msgnum
>> and $FIRSTLINE but does not use $commit because it does not necessarily
>> exist.
>>
>> What a value would the variable contain when I am applying your original
>> patch message using "git am -s" (or "git am -s3")?
>
> Aaah, I understand the concern you raise now. In that case a spurious
> [] would be printed, which I agree is less than desirable. Would
> checking 'if test -n $commit' be sufficient?

In what situation does it make sense to say "It came from _this_ commit"?

I think there is a separate variable that allows any part of the script if
we are being run as a backend of rebase or not, and that is the condition
you are looking for.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git cvsimport and case-insensitive config
Date: Wed, 31 Mar 2010 02:45:08 -0700
Message-ID: <7v634cq0yj.fsf@alter.siamese.dyndns.org>
References: <hoscv7$hmn$1@dough.gmane.org>
 <7vy6h9vhuk.fsf@alter.siamese.dyndns.org>
 <cb7bb73a1003301105v691624sdcdadf6809c50b89@mail.gmail.com>
 <7vr5n1v74x.fsf@alter.siamese.dyndns.org>
 <cb7bb73a1003301517r29aed329j4a5f38fbc9b515ca@mail.gmail.com>
 <7vd3yls8pi.fsf@alter.siamese.dyndns.org>
 <y2kcb7bb73a1003302354wea191dd4iced4360b95d31a2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 31 11:45:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwuUJ-0002pA-NQ
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 11:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757448Ab0CaJpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Mar 2010 05:45:21 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47452 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757395Ab0CaJpT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 05:45:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 59D54A6574;
	Wed, 31 Mar 2010 05:45:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YH2GCuCEtMLUmCrGBywJoxOFK3o=; b=VKmyHR
	mqyJTHQrW1mRk+r4oYJ1lklrzdmLEX0vL3HUZxz40H51zNkG2nkenAioFkLhNC2C
	tW6M5j45wPWu4pz9qJyMlEdTCBLuo0zGynIRzrMnNw6wSGyma3WYx7fRW52phyqy
	q4qM0aQ/Qv/FhQ2Ilv6bzm5WZwHtYo/DD5FUg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rdI4m6tQi2jv3AmIYF8BKRO3D8cgvOcW
	hpnZbhFd1MSXr3MAjGxsSsG0SIBKqD0HtPDTwKkwIyIO8X1fYgv70MdaKN5sedso
	8K68/U6iOLbDUqWDSbtjWOUp+ntLfvCC7ucWkblZUYz+Uc+W8bx3MXpd5bYbnNmh
	yYW1+hzIhHE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 34583A6573;
	Wed, 31 Mar 2010 05:45:13 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3374FA6572; Wed, 31 Mar
 2010 05:45:10 -0400 (EDT)
In-Reply-To: <y2kcb7bb73a1003302354wea191dd4iced4360b95d31a2a@mail.gmail.com>
 (Giuseppe Bilotta's message of "Wed\, 31 Mar 2010 08\:54\:50 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1A8B02D6-3CAA-11DF-9C9C-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143656>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> What I wonder is: when would the heuristics not work? Are there git
> repositories that have a cvsimport configuration with both -s and -S
> specified?

You are asking a wrong question.  Setting both -s and -S is not an issue.
Not being able to tell reliably if the value you see for cvsimport.s in
"config -l" output were specified for cvsimport.S or cvsimport.s is only
by inspecting the value is.

> I strongly suspect the answer is NO because such a
> configuration would not work currently (at least not reliably as the
> wrong value would be assigned to at least one of the keys.

So this is a moot point, but people who specified cvsimport.S expecting
that it would stand for -S option are not getting what they want and are
getting -s instead, which is also a case where the configuration is not
working currently.

Silently converting it to an equally non-working configuration is easy;
just treat as if everything were specified for lowercase option.

But that would not help users at all.  I was hoping that you were aiming
for something better than that.  At least that "case-sensitive" patch was.

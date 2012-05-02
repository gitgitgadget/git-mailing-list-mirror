From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is there any way to make hooks part of the repository?
Date: Wed, 02 May 2012 12:27:23 -0700
Message-ID: <7v1un2idt0.fsf@alter.siamese.dyndns.org>
References: <CAE1pOi2hr7ewjo5WVDoW0ipYxDVTckr5M_sHNoOQ323=_k754Q@mail.gmail.com>
 <7vipgf8wve.fsf@alter.siamese.dyndns.org>
 <CAE1pOi0_ETdSYsuT0Udhbr6rDvmEcuTA157d6aKUosgi7w28jw@mail.gmail.com>
 <vpqfwbjnl4a.fsf@bauges.imag.fr>
 <CAE1pOi3RZ+x7YcVZ-dLt70=wwRsvY9D6GQR-T+JZ9S7x8CFjPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 02 21:27:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPfD9-0000OM-E8
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 21:27:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756431Ab2EBT13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 15:27:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36112 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756198Ab2EBT10 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 15:27:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B051770BA;
	Wed,  2 May 2012 15:27:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KXC0Q1VEX7WlCkmRUVoH3WiHcIQ=; b=jVszYG
	VMr4srwS3AJwCcDjx5HDBrInq3d+wstue60K6Ms17fhvHLi2hqdcsHA2AhFrZZf3
	3gZxW96OWNw1unY91SZvgnGX9VLt9bF1yt9YfHnl4WI/yA+U3oXcyCsSU+EW2scI
	38kEjJ1qwCwSdoC4hefX4C0zGMbZ170bfNhBc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F7hbZgB5W3jZ8YBqPumt4PAu7k4jmC7O
	kbVccHYv6dFcyLEZG1eLM4CBc7j7O4q0sjl2uyxHANnQbseBmg0S6l32pRrnUj2O
	GR7F1t/C6OCS3tmCQObecEPT0YyvvUxlZdINaC8Fp4KzD3b4HGlvWr1iMlE3XNUp
	raX7PA/E8HM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A73E570B9;
	Wed,  2 May 2012 15:27:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0DBD070B5; Wed,  2 May 2012
 15:27:24 -0400 (EDT)
In-Reply-To: <CAE1pOi3RZ+x7YcVZ-dLt70=wwRsvY9D6GQR-T+JZ9S7x8CFjPw@mail.gmail.com> (Hilco
 Wijbenga's message of "Wed, 2 May 2012 12:10:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D8C0B746-948C-11E1-B7D2-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196853>

Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:

> On 1 May 2012 23:38, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> ...
>> Yes, but at least, you have the opportunity to examine the other places
>> before they are ran. Hooks would be really, really nasty security-wise.
>> For example, "git clone" does a checkout, so should probably run the
>> checkout hooks.
>
> There is (or, rather, should be) absolutely no difference between code
> changes and hook changes. Both would go through the same review
> process.

Matthieu is *not* talking about auditing nastiness going into the
project's repository; he is talking is about a chance to audit whatever
comes from the project's repository that *could* potentially contain some
nastiness before it causes harm to your working environment. In other
words, not *having* to trust what is in the project's repository, but
having a way to verify.

Read what he wrote again with that in mind, and you will understand his
point.

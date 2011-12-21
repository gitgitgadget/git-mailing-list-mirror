From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] Suppress "statement not reached" warnings under Sun
 Studio
Date: Wed, 21 Dec 2011 12:41:17 -0800
Message-ID: <7vk45pfyj6.fsf@alter.siamese.dyndns.org>
References: <1324430302-22441-1-git-send-email-avarab@gmail.com>
 <1324430302-22441-5-git-send-email-avarab@gmail.com>
 <7vvcp9hjam.fsf@alter.siamese.dyndns.org>
 <CACBZZX4htZRQH+2xvoskwE7KoTz98Ox-3xQf0hyEbbFDYCZYHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jason Evans <jasone@canonware.com>,
	David Barr <david.barr@cordelta.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 21 21:41:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdSyb-00066R-Ku
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 21:41:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198Ab1LUUlW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Dec 2011 15:41:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49956 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750915Ab1LUUlU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Dec 2011 15:41:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D3EC7341;
	Wed, 21 Dec 2011 15:41:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=luqEDFy2Lqdk
	GCf85RHXT04GiP8=; b=pR191Vl6YlS9fTbefFFJfY43ZcC5CWgIhBRtG8Ysgztv
	0+9FGwOo3n6EUGH8xWQqpMYfeQM2ALIbR4pq3t7NpJVFAQN9TkpeFvZ3UnfB7wM7
	exSPK6tC68nG3CNFY38Tt4eNrfYhhntJMPPMxfvpA2psYVJ5BAJV6pOI98E7/8g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=RyFial
	QaOl7/T+Q06ikjTzZp5IBSh2kdezPTs/1Csy2HX47OfzkcQhFVFv6/MIRLYqFF0u
	c+MQFrIV7cCzLsnQDFA6VojcXUi6RCIcpudF1zbKgZI36G+35QEfTQhQMmY/btue
	N2xONLBFLdJjyTlQjmDjtWWQ2QWdR6WFBJPn0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80B1C7340;
	Wed, 21 Dec 2011 15:41:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1349E733F; Wed, 21 Dec 2011
 15:41:18 -0500 (EST)
In-Reply-To: <CACBZZX4htZRQH+2xvoskwE7KoTz98Ox-3xQf0hyEbbFDYCZYHw@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 21 Dec
 2011 20:03:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 22B266D8-2C14-11E1-8206-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187587>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> That would make that warning go away, but I don't know if that change=
s
> the semantics of the code. I was aiming not to change any code, just
> to squash spurious warnings under Sun Studio.

Well, earlier we skipped "if it is NUL return 1 and otherwise make sure=
 it
is a directory separator" check and went directly into whatever happens
after we see a directory separator. The patch causes the same without g=
oto.

If the code is too complex to confuse not so bright compilers, it is
likely to confuse no so bright humans as well, and rewriting the logic =
in
a more straightforward way to help humans is independently a good thing=
=2E

I am not particularly interested in squashing spurious warnings, but if=
 it
falls out of a side effect of helping humans, I wouldn't object to it.

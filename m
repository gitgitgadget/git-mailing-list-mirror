From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] commit: update the index after running the
 pre-commit hook
Date: Wed, 18 Aug 2010 13:30:54 -0700
Message-ID: <7vwrrn8xz5.fsf@alter.siamese.dyndns.org>
References: <6e4c323b0905031620m48769dbdp52684d6b470ebea3@mail.gmail.com>
 <1282139649-21097-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Hinrik =?utf-8?Q?=C3=96rn_Sigur=C3=B0sson?= 
	<hinrik.sig@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 22:31:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlpI0-0007c8-6P
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 22:31:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902Ab0HRUbG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Aug 2010 16:31:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46671 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069Ab0HRUbF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Aug 2010 16:31:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 56B61CE986;
	Wed, 18 Aug 2010 16:31:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QoVrfPWdm+52
	jWhAyPeDnZn5wwE=; b=PjOdNY1U8y+AnIGOax6893hvv9nRBpgLYnUSfcoGAySA
	O3QNDosrZcDQf4hcEBgBQrmkkRvS3/7CHY2HhijCjqrY6jPkm+4uisqAMG7oD8bf
	RJdpzT42NL1ylmaVHkekyi66gS7DCVuOqfK/meznSMiOOmZV/QGKRRdoYW2cPRA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=EXIS5F
	O1S3XcEpVrLCC2+q5V/Gap3qB8OZfRgyBNQhgTgE0Lw+V6O4Tud62Csl4cEiFCv2
	D7CBb94lnAm0vQYldBpO6CJIpPKv9EOIYjkcH0+iUa7cjMWUTihVRG+jEHLMHMsl
	pNn4+8Tr7LMqCPHDM9raRJcVHcv2x0m2ZGONE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 241C2CE985;
	Wed, 18 Aug 2010 16:31:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 69D07CE982; Wed, 18 Aug
 2010 16:30:56 -0400 (EDT)
In-Reply-To: <1282139649-21097-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed\, 18 Aug
 2010 13\:54\:09 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 83598D02-AB07-11DF-B366-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153883>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change git-commit to update the index after running the pre-commit
> hook, but before it constructs the comments that'll accompany the
> commit message displayed in the $EDITOR.

Hmm.

I have always thought that "pre-commit" is about verification, just lik=
e
other pre-anything hooks.  We have never sanctioned it to modify the tr=
ee,
and the document does not say the hook is allowed to.

Although I am not opposed to this patch, it is a change to the defined
semantics that is somewhat worrysome.  We probably should document what=
 it
is and is not allowed to a bit better.

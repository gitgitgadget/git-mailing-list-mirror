From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bikeshedding advice on the ab/i18n-scripts series
Date: Mon, 16 May 2011 13:45:46 -0700
Message-ID: <7vboz2l6h1.fsf@alter.siamese.dyndns.org>
References: <BANLkTi==pxyy7OeZT0mn33iJHrc5R7vHBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 22:46:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM4g8-0000BR-C6
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 22:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755890Ab1EPUqC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 May 2011 16:46:02 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40406 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755739Ab1EPUp7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 May 2011 16:45:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 52224444E;
	Mon, 16 May 2011 16:48:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ITSxE5UV32u7
	MLn8dlz9V/GOKT4=; b=YE/UKId3AF9iMPk8A6pY6A87hktNq2Ku7tmFS7mPvzB9
	T/c/7lp9eh9SGLr5kJ3fTjUMpA75xBoRIPFzCagc/ED0By7eckFlrAPShEVao6EP
	Qn4bwTg3+CLKIWyoEEuS2Y9q1lLFgvFQ58xfC6qZJopg7ULaqcJDyzLQMDy2NxU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Horcjb
	H79af6RC8MItUiD8yEgWNPLRS1Ce+6lupWKMvNRJ/KXM1gAWRZuwHrYYYAfV3IiV
	JsFRMRXh1iOGLSxjt4tXwKt/6tGCyaReuR/R05WEiFmtTLa+nPXPq+OBSohb94wn
	+ixG2p7ZmPcwMujyUGwCbhwyV/XT/oa6tT3dI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B76164445;
	Mon, 16 May 2011 16:48:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5A7134444; Mon, 16 May 2011
 16:47:55 -0400 (EDT)
In-Reply-To: <BANLkTi==pxyy7OeZT0mn33iJHrc5R7vHBw@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 16 May
 2011 18:03:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C993E454-7FFD-11E0-A7C8-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173757>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Oh, and for all the convertion of:
>
>     echo >&2 "$(gettext "foobar")"
>
> I've already done:
>
>     (
>         gettext "foobar" &&
>         echo
>     ) >&2

Sorry, but what problem are you trying to solve?  The output from

    $ gettext "foobar"

may have 0, 1 or more LF at the end, but wouldn't=20

    echo >&2 "$(gettext "foobar")"

terminate with a single LF in any case?

Ahh, perhaps I was the one who said something stupid like:

	echo >&2 "$(cmd)"

should be equivalent to

	cmd >&2

which is not the case when output from cmd does not end with a single L=
=46
(i.e. either an incomplete line, or with trailing blank lines).

Sorry, if that is what you are trying to address, please let me take th=
at
back.

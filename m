From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Our merge bases sometimes suck
Date: Fri, 13 Jun 2014 15:35:18 -0700
Message-ID: <xmqqbntw1lqx.fsf@gitster.dls.corp.google.com>
References: <539A25BF.4060501@alum.mit.edu>
	<539AC690.6000906@drmicha.warpmail.net> <539B1E59.1030604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 14 00:35:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wva4L-0004zG-HO
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jun 2014 00:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753365AbaFMWfZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 18:35:25 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55616 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751262AbaFMWfZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jun 2014 18:35:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4B3211FFE2;
	Fri, 13 Jun 2014 18:35:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=dc1JEeoFpo14
	8/zzrBE705UCWK4=; b=UKyTMSp6l1jju26UTcdXIqcJoNlA0zgp9gc5vtD0VxXR
	jR8+lJCRXoY4E7447m9kWz8dfxJFN/YsQiNPDbOehp5C20WuBpGWkbTrrDUILGVz
	5DzAdYdwtaXJYbcg7dojivU0XUBeFIQxtjkV1DuEzCjbBPPNuh9iQwvsXHKiFLs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JVCRDd
	XTDH9hdD7VV/Hy61Kt21zKWPg+tff7Fju8eMMYNNbA2t1wDw8Yxt0ZVHCiOUnJ2Q
	POcEvRTPQYOcvCasvrH2h3ehemjCQGhVNAzzKtbpqWZSzLpqxZfzgFziT8KJ8L31
	rFsAkHmrIxTJeIvZGqO1PEeFv34vir+hWq2Qw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 427781FFE1;
	Fri, 13 Jun 2014 18:35:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 47FB41FFDD;
	Fri, 13 Jun 2014 18:35:20 -0400 (EDT)
In-Reply-To: <539B1E59.1030604@gmail.com> ("Jakub =?utf-8?Q?Nar=C4=99bski?=
 =?utf-8?Q?=22's?= message of "Fri,
	13 Jun 2014 17:52:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0038954A-F34B-11E3-A4FE-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251646>

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> I don't know if it has been fixed, but there is a difference
> between "git diff A...B" when A and B have one merge base, and
> "git diff A...B" when there are more than one merge base.
>
> When there is one merge base, "git diff A...B" returns simple
> unified diff equivalent to "git diff $(git merge-base A B) B".
> It is unsymmetric.
>
> But where there are more than one merge base, by design or by
> accident for "git diff A...B" git 1.9.2 / 1.7.4 returns
>
>    git diff --cc $(git merge-base --all A B) A B
>
> which is *symmetric*, and is combined not unified diff.

Hmph, the relevant code has not changed very much since c008c0ff
(diff A...B: give one possible diff when there are more than one
merge-base, 2010-07-12) which has been with us since v1.7.2.

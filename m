From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-svn, perl/Git.pm: extend and use Git->prompt
 method for querying users
Date: Wed, 28 Dec 2011 13:38:25 -0800
Message-ID: <7vpqf8z8a6.fsf@alter.siamese.dyndns.org>
References: <4EC52508.9070907@tu-clausthal.de>
 <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com>
 <4EC65DE4.90005@tu-clausthal.de>
 <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com>
 <4ED0CE8B.70205@tu-clausthal.de>
 <20111130064401.GC5317@sigill.intra.peff.net>
 <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain>
 <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de>
 <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org>
 <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5F08.2060705@tu-clausthal.de>
 <7vpqf91kqo.fsf@alter.siamese.dyndns.org> <4EFAF241.9050806@tu-clausthal.de>
 <7v39c41keo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sven Strickroth <sven.strickroth@tu-clausthal.de>,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 28 22:38:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rg1Cj-0008Dq-85
	for gcvg-git-2@lo.gmane.org; Wed, 28 Dec 2011 22:38:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754440Ab1L1Via (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Dec 2011 16:38:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63725 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753261Ab1L1Vi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Dec 2011 16:38:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B2485E47;
	Wed, 28 Dec 2011 16:38:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RQMtjd8XZA9gsA8sHpAO56UK5dg=; b=WV/Asi
	uLeKsC5Mw1rnsocKebdppSmZKaHQh6MVPpuWaTjFuCndds4+aywTg+OkTRwhD2p0
	EnK8szj55mMypVVJ1mQ1JldBflAyiclmqcNPmqIIteRSsYrq98co2IlBZAVAlGFT
	0Pir7jOCvJQ36Z16fkRLNGOSb8CpCQDHU+sW8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aaZFfrRIVvwZDs1ZjMvZfFP3T2sIcl4/
	HDiNn1mU06uLIPlUNT7QMFKdXTINJyrfzufG9wB+EyC/UzN6665MvVdntMzAi77X
	Spz2ujkyKvvFwuH3UpTFHX+DdAP/DeI3AtfIv41vuu6rxoKSocidyPUKrx7peBQk
	p+fY3miOW0E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62C955E46;
	Wed, 28 Dec 2011 16:38:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D64805E45; Wed, 28 Dec 2011
 16:38:26 -0500 (EST)
In-Reply-To: <7v39c41keo.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 28 Dec 2011 13:00:31 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 46B71EA6-319C-11E1-862A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187760>

Junio C Hamano <gitster@pobox.com> writes:

> I actually was hoping that the answer is "it depends on the helper
> specified by *_ASKPASS".
>
> In any case, let's not add that extra "Certificate unknown. " prefix at
> all to avoid regressions and queue this patch series for real.
>
> After somebody comes up with a way to deal with overlong prompt, building
> on top of this series, we can work on making this particular prompt longer
> and more descriptive.

I've queued the two patches with minor tweaks.

I think the first patch is a definite improvement for both GUI users and
terminal users who use the *_ASKPASS environment variable. Other parts of
git already asks the latter their password using *_ASKPASS anyway, so I do
not foresee complaints from them saying that git-svn suddenly stopped
reading the password from the terminal.

I am however not sure if the second patch in this series is a good thing
in the current shape. For GUI users who do not have a terminal, earlier
they couldn't respond to these questions but now they can, so in that
narrow sense we are not going backwards.

But for people who use *_ASKPASS and are working from the terminal, it is
a regression to ask these non-password questions using *_ASKPASS. Most
likely, these helpers that are designed for password entry will hide what
is typed, and I also wouldn't be surprised if some of them have fairly low
input-length restriction that may be shorter than a long-ish pathname that
users might want to give as an answer, which they could do in the terminal
based interaction but will become impossible with this patch.

I suspect that we would need to enhance *_ASKPASS interface first, so that
we can ask things other than passwords. Until that happens, I do not think
we should apply the second patch to use *_ASKPASS for non-passwords.

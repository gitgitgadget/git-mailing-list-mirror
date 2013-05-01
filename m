From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/18] remote-bzr: massive changes
Date: Tue, 30 Apr 2013 22:44:55 -0700
Message-ID: <7vppxb8d9k.fsf@alter.siamese.dyndns.org>
References: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 07:45:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXPqi-0002GN-EN
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 07:45:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752986Ab3EAFpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 01:45:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35116 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751790Ab3EAFo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 01:44:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A30BE1589D;
	Wed,  1 May 2013 05:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YXe50YxFjC9ku8X0Uilsvh+W9GA=; b=VmQir0
	7n2mMqevvZ5t0ENmmpDYj1nnMIhpw6kOJsedzR3j91itBFiZClmmDQoA0vajyT69
	QGMLPF78oCENYdWueuMSAiCh3Ni1DykN4PuzfmEi1CBaGXUt/AOIA5pK08mGd5/o
	NK1aFKjBonAMMV33Vm/sSJ2bnL+5TqnE9PlIM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ihHNSAmj3HlahoSr4doA7b2j115YvmW8
	qgb+y6CDbqxN82LLGjBn2Mft+uh6VJra3KFt62DUTvpMedngjlsbDFry1IdmMjlA
	MsG5BE/dppSQzBGJyAMFROh9BR/pGwpqZ1HENYgJPvwWTNlXUD6k7KtN011wV3yM
	WEnE+dCpYm4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97BE11589C;
	Wed,  1 May 2013 05:44:57 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD22415899;
	Wed,  1 May 2013 05:44:56 +0000 (UTC)
In-Reply-To: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Tue, 30 Apr 2013 20:09:52 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 41535940-B222-11E2-B34C-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223070>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> After being contacted by the emacs developers and others who are stuck with
> Bazaar, which at this point seems to be utterly abandoned, I realized the
> current implementation is too crude.
> ...
> That is of course, if pushing actually worked (which in many cases doesn't).
>
> In short, our support for real-world projects suck.
>
> These patches fix all the issues I encountrered.
> ...
> Finally, after all these changes I was finally able to clone the whole emacs
> repository, all 130685 commits, and 56 branches without running out of memory
> in my modest laptop.

Yay ;-)

I assume that the trees at a handful of key points (e.g. releases)
were verified to be identical with the original history and the
conversion result.

> Since the purpose of remote-bzr is to actually be usable for the
> poor souls stucks in DSCMs that are not git, these changes are a
> must. I propose they be merged for the next major version of git
> (v1.8.3) if no issues are found.  They changes pass all the tests,
> and work on various repositories I've tried.

Nice.

> I'll ask the emacs developers to give them a try, and let's see
> how it goes.

Yeah, that's the least we can do for both existing and future users.

Generally speaking, post -rc0 is too late for "if no issues are
found", simply because no existing user has enough time to find
corner case regressions in her work using the new software (I do
not expect a trivial bug that can be uncovered in a few weeks of use
would remain in a version that has successfully converted the Emacs
history; but real world users always have different needs than what
we anticipate).

I however am finding myself moderately receptive to this series.
That is primarily because this series touches only two files that
are totally isolated from the rest of the system.  Even if they did
not work at all, there is no risk for the remainder of Git.  Nobody
other than existing users of remote-bzr will even notice if we
merged this by the final.

For existing users of remote-bzr that we shipped in 1.8.2, the story
is a bit different, though.  If this series makes things worse in a
way your tests did not reveal, and if such a regression is not
reported and/or cannot be fixed by 1.8.3 final, that will mean a
real regression in the released version for them.

If that ever happens, that would be the time for us to regret the
hasty decision to merge remote-bzr in 1.8.2, justifying that with a
"There wasn't anything working for interoperating with bzr, and here
is one to do so; anything is better than nothing", and learn from
that mistake (it is not an option to say "the 1.8.2 users chose to
use contrib/ material that are clearly marked as sub-par quality
with their own risk".  If we did not ship it in 1.8.2, they did not
have to get burned with any regression and could have kept working
with bzr a bit longer.  "Anything" is not necessarily better than
"nothing").

Hopefully, such a regression will not have to happen (for one thing,
I would expect that the existing 1.8.2 remote-bzr user base would be
very small).  Also I somehow have a feeling that it is very unlikely
to happen, especially given your report:

 (1) the series converts Emacs history without barfing; and

 (2) you have some confidence in the conversion result after
     inspecting at least a handful of key release points and trees
     and metainformation match between the original and the
     converted history.

So let's go ahead and apply these directly on top of 'master', once
we hear from Emacs folks and they are happy with it.  I'll queue it
on 'pu' so that I do not have to go back to the list archive when it
happens.

Thanks.

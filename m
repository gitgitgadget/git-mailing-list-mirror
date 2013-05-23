From: Junio C Hamano <gitster@pobox.com>
Subject: Re: first parent, commit graph layout, and pull merge direction
Date: Thu, 23 May 2013 15:11:05 -0700
Message-ID: <7vli75cpom.fsf@alter.siamese.dyndns.org>
References: <20130522115042.GA20649@inner.h.apk.li>
	<7v4ndukhx0.fsf@alter.siamese.dyndns.org>
	<20130523090657.GB23933@inner.h.apk.li>
	<CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
	<20130523102959.GP9448@inner.h.apk.li>
	<20130523110839.GT27005@serenity.lan>
	<7vd2shheic.fsf@alter.siamese.dyndns.org>
	<20130523164114.GV27005@serenity.lan>
	<7vbo81e7gs.fsf@alter.siamese.dyndns.org>
	<20130523215557.GX27005@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri May 24 00:11:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfdjF-0001cF-Mo
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 00:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759731Ab3EWWLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 18:11:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51552 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759717Ab3EWWLH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 18:11:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F5B921DDD;
	Thu, 23 May 2013 22:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q3ktssMv2MJhc4GcUDUPzMjcQaA=; b=GHU3uu
	BH6wqLIRAAZzsb2Zor6YjW7SCjCsT+vvsM7T9Wyjaw8ZgKJznruwAqHWQ+bl+Xo9
	hkzr00FFI77Zaf92nwNd0HXcz2SlKdN3i0i3a+/bY9Mgx9EgsfaKgAaow0UY390p
	bBiUMfHvRcsF7ZVUgxipW+bkmMba8XNKBFIMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KrhbW+kAAk5olLbr7BlN6yaI9nfIG3Tl
	ScnzqTiUZcqWlo0GjAvqf6EZxVjB+iFwo24FeBWvaNh8RBlC2bMjwCYTGNizeuIX
	h6XsFwwWPtVaV0vfUpnLxm8t3qKPa+izFCDVTSRnFbEa8KeVeKVXmBunoIbPiNWu
	N5CCWnlW26k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4144A21DDC;
	Thu, 23 May 2013 22:11:07 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A09D021DDB;
	Thu, 23 May 2013 22:11:06 +0000 (UTC)
In-Reply-To: <20130523215557.GX27005@serenity.lan> (John Keeping's message of
	"Thu, 23 May 2013 22:55:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AA55EE1E-C3F5-11E2-B0FD-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225309>

John Keeping <john@keeping.me.uk> writes:

> This isn't about "swap parents", it's about helping people realise that
> just "git pull" isn't necessarily the best thing for them to do, and
> that they may want --rebase.
>
> So I was asking if it would be sensible (possibly in Git 2.0) to make
> git-pull pass --ff-only to git-merge by default.

Unless your primary user base is those who use Git as a deployment
tool to always follow along the tip of some external repository
without doing anything on your own on the branch you run your "git
pull" on, defaulting it to --ff-only does not make much sense to me.

If the proposal were to make pull.rebase the default at a major
version bump and force all integrators and other people who are
happy with how "pull = fetch + merge" (not "fetch + rebase") works
to say "pull.rebase = false" in their configuration, I think I can
see why some people may think it makes sense, though.

But neither is an easy sell, I would imagine.  It is not about
passing me, but about not hurting users like kernel folks we
accumulated over 7-8 years.

Also "rebase" of the branch you attempted to push out is sometimes a
good solution (fixing "just a small change on 'master'" that was
beaten by somebody else pushing first), but is a bad workaround (you
had many changes on that branch, which would have been better if
they were done on a topic branch, but you do not want to merge with
the upstream because you worked on 'master') some other times, so I
have this suspicion that 'pull.rebase' is not necessarily a good
thing to encourage in the first place.

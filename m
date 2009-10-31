From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Changed timestamp behavior of options -c/-C/--amend
Date: Fri, 30 Oct 2009 17:10:37 -0700
Message-ID: <7vocnoe83m.fsf@alter.siamese.dyndns.org>
References: <1256931394-9338-1-git-send-email-erick.mattos@gmail.com>
 <7vljisk1m7.fsf@alter.siamese.dyndns.org>
 <7viqdwilx2.fsf@alter.siamese.dyndns.org>
 <55bacdd30910301520h2678d0c2hd8478716d8ce4a17@mail.gmail.com>
 <7v4opgh5qr.fsf@alter.siamese.dyndns.org>
 <55bacdd30910301612xabe2071i1319d920191f080f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 01:11:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N41Yo-0008EG-52
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 01:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933122AbZJaAKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 20:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933116AbZJaAKm
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 20:10:42 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47076 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933115AbZJaAKl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 20:10:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FEA26DE71;
	Fri, 30 Oct 2009 20:10:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S2xij5lYmuH04wMaIG2VI3TWbPQ=; b=N+v8Y8
	PP5F/eXmZFJBNvlVkcGQ3gJtS4j5mXPv2Z27JRqp9OQS79K1shaOtC+0Z5udiSK9
	vW4wiltYeDMBCMabl409BC74OU127QJjvP4sxNt1HYtsnIr+KhbnXQILh4CP/syW
	yYPGHYOdiLQNoNLs5yeEMoechJqMpkcK74Xlk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U2y1HUPXJzTJEqiE2sQiycqh+IYo0OlO
	Ql5hwzV/M8rYwXBUT6QhQ+o/J/zm7jAUktK8NJRbl++g2a33ZM2xRcuShyI/Gy/t
	dwF1bNdQ3R6WWCaHir5tlzymYoRUSKN13SRXfTbOo0wIY7YOTAFrmJHsT3aCuDN0
	RGKk4WtQaXw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AE2C6DE70;
	Fri, 30 Oct 2009 20:10:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A7FD6DE6F; Fri, 30 Oct
 2009 20:10:39 -0400 (EDT)
In-Reply-To: <55bacdd30910301612xabe2071i1319d920191f080f@mail.gmail.com>
 (Erick Mattos's message of "Fri\, 30 Oct 2009 21\:12\:58 -0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D3EB8E96-C5B1-11DE-B7D7-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131781>

Erick Mattos <erick.mattos@gmail.com> writes:

> I don't see a use for comparing the author and committer because I can
> use as template my own commits or others'.

You _can_ use whichever irrelevant commit as a template, but "you _can_"
is different from what it means, and what is and what is not _sensible_.

You may be rewriting somebody else's patch (e.g. fixing up a typo in the
message, or changing the implementation, or both).  If you are going to
keep the authorship, you are saying that "it is still _his_ code, not
mine".  In such a case, it never makes sense to change the timestamp, if
that author is somebody other than you.  After all that other guy may not
even be aware of what you are doing when you make this commit; he may be
in bed sound asleep in a different timezone.

In another scenario, if your fix-up is very significant, even if you
started from somebody else's patch, you may want to say "now this is my
patch, the original author may have given me some inspiration, but the
changes in this commit, including all the bugs, are mine".  The same
applies if you looked at the problem description of somebody' patch, and
did your own solution without using anything from his commit.

At that point, you would want the resulting commit to say it was written
by you at this moment.  You do not want to see -c/-C/--amend to retain any
part of the authorship (not just timestamp) from the original commit.

    Side note. You may be fixing your own patch, in which case you may or
    may not consider your change significant, but at the time of either
    old timestamp or current time, you were working on this change, so
    using the current timestamp instead of using the old one is not a big
    deal, and that is why I think committer==author may be a good
    heuristic when deciding to touch or not touch the timestamp.

    But in general I do not like such dwim that depends on who you are (it
    makes it harder to explain, even if the end result may be useful in
    practice), so I'd rather not to see such a code for this topic if we
    can avoid it.

In short, I do not think it makes sense to change only the timestamp while
keeping the author.  The issue is not "timestamp behaviour" with "use new
timestamp" option, but rather is an ability to declare "Now this is a
commit made _by me_ and _now_; iow, I take authorship for this change",
even when you reuse the commit log message from somewhere else.

So what is needed is an option to tell -c/-C/--amend to reuse _only_ the
message but no authorship information from the original commit, I think.

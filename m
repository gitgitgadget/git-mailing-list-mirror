From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Mon, 12 May 2014 12:50:27 -0700
Message-ID: <xmqq8uq6rd30.fsf@gitster.dls.corp.google.com>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
	<xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com>
	<536a83097302f_76ff7a52ec6c@nysa.notmuch>
	<xmqqvbth8ha9.fsf@gitster.dls.corp.google.com>
	<536a999e2c0c_76ff7a52ec1e@nysa.notmuch>
	<xmqqoaz95ees.fsf@gitster.dls.corp.google.com>
	<536ad9601b73b_3caaa612ecdc@nysa.notmuch>
	<CAGK7Mr4DYuU34Zf_3fRQFkT+1TGOkpfLPUnQh=tYh6EMtBEt9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Philippe Vaucher <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 21:50:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjwFC-0002Kz-Qr
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 21:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094AbaELTuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 15:50:35 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50705 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751692AbaELTue (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2014 15:50:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D338B15225;
	Mon, 12 May 2014 15:50:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=EADAt7lhiH4KPBDgK54jOXifLvo=; b=CSlLSGWGt7wMlIb6/Qk0
	K7yYTi/Sy7mqJCU7UXB2Xyfb3UiJkUFF9tEYDRbBxYAQyB9PFYGc1Ei3K4f06ZKe
	TrosMZArlQypbxoyuNvmL61CvKwA6494uLrceCSdBbitSy+iYPv7g/1WSMkXJKBN
	eZfwPwJOM8t+P2XhTWlipuE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=HIoe1+9T9m6JlYjsnJeielShPvln3goy3b6g491DKDKAa+
	2QIV2oVYHAjNJomWjLpP8wjahj/HMP3IGFTjGJt1ErWR1tca977Mxpcf2Blcs2El
	UPWhhbwK7b4VHtOa+rG4ye4EF2GdNKlqxYxqApCGwR1WjiHGph/ZvYwypYglU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C8DAE15224;
	Mon, 12 May 2014 15:50:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C2E9C15200;
	Mon, 12 May 2014 15:50:28 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AB368C5A-DA0E-11E3-A7AD-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248727>

Philippe Vaucher <philippe.vaucher@gmail.com> writes:

>> It is *way* beyond the quality of any other tool in 'contrib/' and even
>> some tools in the core, like 'git-request-pull' (which has known bugs),
>> and probably even 'git-pt'.
>
> Junio, can you comment on this? I understand this probably doesn't
> really affect the issue at hand, but it'd help clarify if it's ever
> possible to move out of contrib/ nowadays.

I was originally led to believe that its code quality was good
enough, and that was why I merged the bottom three patches of the
series even down to 'next' in the first place.  But after seeing the
"Of course" response that led to [*1*], which made me recall many
patch-review interactions with him, I have started to have doubts.

The code quality of Git that many projects have come to trust their
code with is much more than just "the code at each moment keeps
working for the users as long as the original author is around".
The maintainer of a port to the platform X may lose access to the
platform after switching jobs, the maintainer of a bridge to the
foreign system Y may stop needing to talk to the foreign system
after completing the switch to Git.  Anybody can be hit by a bus,
get sick, or simply lose interest in his past creations.

By reading "git log contrib/remote-helpers" and comparing it with
the logs for the rest of the system, you would realize that the
former would not lead to a quality discussion similar to the one
that led to [*2*], which was only possible because the change was
adequately described to allow anybody to understand the original
issue the change was meant to solve.  The commit that made the
original change made it easy to ask a critical question: "You are
improving B but at the same time breaking A.  Can we do better to
help both A and B?"  And it allowed us to move forward without
having to rob Peter to pay Paul.

Granted, these contrib/ patches were applied with the understanding
that contrib/ stuff can be substandard, because having anything is
often better than having nothing, and you cannot go back in time to
update the history to make these commits more useful to others who
will come later.  But I would be lying if I said that I would expect
that things will suddenly improve and that the codebase will be
maintained for the long haul in a healthy way the minute we move it
out of contrib/ to the core.  Especially after seeing [*1*], which
is just one of the examples that illustrate that there clearly is no
will to explain the changes to help others who come later to help
maintaining the code.  "I'll take good care of the codebase", "I've
spend the time to make it better", "Me, me, me", is not what the
open source process is about.


[References]

*1* http://thread.gmane.org/gmane.comp.version-control.git/248063/focus=248341
*2* http://thread.gmane.org/gmane.comp.version-control.git/248075/focus=248204

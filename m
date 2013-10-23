From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git grep: search whole tree by default?
Date: Wed, 23 Oct 2013 10:23:54 -0700
Message-ID: <xmqqmwlzrjdh.fsf@gitster.dls.corp.google.com>
References: <CAA01CsqgNKdDAc9OL9zdk=3tnK9GAG=6w+wP_XSoiefBOgfzRQ@mail.gmail.com>
	<vpqbo2guff7.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Oct 23 19:24:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ2A6-00056U-Vb
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 19:24:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839Ab3JWRX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 13:23:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48623 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751416Ab3JWRX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Oct 2013 13:23:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B62D4DFAE;
	Wed, 23 Oct 2013 17:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ozEAJG05cBzlOFakJLZxVyYeo4A=; b=sEp2JP
	J4NDbr2WVEtBi1XKlLxMj/3uJ6Uf9mafIs7ANIFwuHQxhyG0IcXEvh6UDGEUmvk7
	3mxXFysFypK6K1Mb0p40WeTrtHyqZia/r1w7AcoDkQhns2thoCIQtnt1NQUDQXdZ
	fLg7c3RQ9XU3CoEpNuwsHH4I/8J4b1lghi3BI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yZAIRC7kofPZA2zw5GAJHB2CU0MjV38V
	ioGCy3xWlWhZB5XPDhKfGu0khm/Wvz0YH4mfSsgjbatGtY1/AIEEKZeAi0dBb0Gv
	nPfFG8vyXXVzVh9q+Wbm5JB6Tpc3JpT5eFk5OhAnVcMsNMTIX8DR8TYpMnpc3CU1
	c1tnEQlyqK0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DF854DFAD;
	Wed, 23 Oct 2013 17:23:57 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A8024DFA7;
	Wed, 23 Oct 2013 17:23:56 +0000 (UTC)
In-Reply-To: <vpqbo2guff7.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	23 Oct 2013 18:21:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E590151A-3C07-11E3-8C12-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236536>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> In summary: changing is painful. The case of "git add" was really bad,
> since the same command had different behavior depending on the options
> given, so it was clearly worth the pain. In the case of "git grep", the
> current behavior is not _that_ bad, so nobody bothered to do the change.
>
> (by "do the change", I mean propose a migration plan, convince people
> that it is good, ...)
>
> I'd personally be slightly in favor of changing to tree-wide, but
> without strong opinion.

After reading that old thread again, I tend to think that the only
reason to favor "git grep" to start at the $(cwd) is the backward
compatibility.  While I do expect that many people will be annoyed
when "git grep" (no pathspecs) that is run in a subdirectory starts
spitting out a large number of hits from places irrelevant for the
current task at hand, hits from outside the $(cwd) is something they
can _notice_ easily and their fingers will quickly learn to add "."
without even thinking.

I suspect that it would be too late for 2.0 we want to do sometime
early next year, though.

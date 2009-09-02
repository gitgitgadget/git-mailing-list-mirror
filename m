From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] status: list unmerged files last
Date: Tue, 01 Sep 2009 22:26:26 -0700
Message-ID: <7vljkxdiil.fsf@alter.siamese.dyndns.org>
References: <20090901145213.GB4194@debian.b2j>
 <200909012213.54611.j6t@kdbg.org> <7vy6oy9z9r.fsf@alter.siamese.dyndns.org>
 <200909012325.45739.j6t@kdbg.org> <7vtyzmxkpr.fsf@alter.siamese.dyndns.org>
 <20090902011513.GA3874@coredump.intra.peff.net>
 <7vmy5egefh.fsf@alter.siamese.dyndns.org>
 <20090902051248.GB12046@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, bill lam <cbill.lam@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 02 07:26:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiiMr-0004IJ-Ne
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 07:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017AbZIBF0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 01:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752974AbZIBF0j
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 01:26:39 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44611 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbZIBF0j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 01:26:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C00B440C15;
	Wed,  2 Sep 2009 01:26:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3ozH4iI4kBwLWQnR1FTNFEEmIsI=; b=sDHUB3
	Ol82ETGrRRpgSuWs1Y//YL3coE6WY0JFOf7p+Es1wo5mRzpaClpjfR+1RZhLUctr
	ABzqPAd58yoQ8lo0LxpIPSW4cbQ+xb6gU1vo9uUHj4oho5rB691NLQlEq6aWv1VD
	5CARl4qh9de/Y5YNM3W9n6oT/WAvRD8+jrSUA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dqK05pkOajOdjpTqDrfKudo0shA2QUvp
	j31OXkJQIPJeQFAlijk1PnCVK/mLnVojAdhtpLvKUIwaKlq09gYeCew/geJUFlWE
	9nNO0R7FfWEOlRt5nQOpB9TDfZHK2jmKH8U0a7AuTGub831N7XUMEWhGaLQ26QLr
	KsBYl3iy/Eg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 885C540C14;
	Wed,  2 Sep 2009 01:26:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 93FF540C11; Wed,  2 Sep 2009
 01:26:29 -0400 (EDT)
In-Reply-To: <20090902051248.GB12046@coredump.intra.peff.net> (Jeff King's
 message of "Wed\, 2 Sep 2009 01\:12\:48 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2F2341DC-9781-11DE-8566-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127580>

Jeff King <peff@peff.net> writes:

> On Tue, Sep 01, 2009 at 09:26:26PM -0700, Junio C Hamano wrote:
>
>> But not everybody is used to such a set-up.  If you rely on terminal's
>> scrollback buffer with mouse and a short terminal, I can see cutting and
>> pasting would be an issue.  I do not have a good answer to "tig status",
>> but the design principle of supporting the lowest denominator is
>> important.
>
> But I'm not sure it is about "lowest common denominator". I think it is
> about different people having different preferences (as a matter of
> fact, I use an 80x25 terminal most of the time, and I think I prefer the
> content at the top. Perhaps it is simply habit, but I do think having it
> right next to "staged for commit" items makes the most sense).
> ...

Here is how I would justify the change (the patch is the same as Hannes's
first version.

From: Johannes Sixt <j6t@kdbg.org>
Date: Tue, 1 Sep 2009 22:13:53 +0200
Subject: [PATCH] status: list unmerged files much later

When resolving a conflicted merge, two lists in the status output need
more attention from the user than other parts.

 - the list of updated paths is useful to review the amount of changes the
   merge brings in (the user cannot do much about them other than
   reviewing, though); and

 - the list of unmerged paths needs the most attention from the user; the
   user needs to resolve them in order to proceed.

Since the output of git status does not by default go through the pager,
the early parts of the output can scroll away at the top. It is better to
put the more important information near the bottom.  During a merge, local
changes that are not in the index are minimum, and you should keep the
untracked list small in any case, so moving the unmerged list from the top
of the output to immediately after the list of updated paths would give us
the optimum layout..

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 wt-status.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

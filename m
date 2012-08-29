From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] teach log --no-walk=unsorted, which avoids
 sorting
Date: Wed, 29 Aug 2012 10:42:46 -0700
Message-ID: <7vharlwq5l.fsf@alter.siamese.dyndns.org>
References: <50289e50.8458320a.7d31.3c46SMTPIN_ADDED@gmr-mx.google.com>
 <1346220956-25034-1-git-send-email-martinvonz@gmail.com>
 <1346220956-25034-2-git-send-email-martinvonz@gmail.com>
 <CAPBPrnstykXxTEH56YFDqU2XW+o8WRKBN6=QOTpLJ1jRU7DXCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin von Zweigbergk <martinvonz@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Dan Johnson <computerdruid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 19:42:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6mI5-00008g-5U
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 19:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754440Ab2H2Rmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 13:42:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45606 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754403Ab2H2Rmt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 13:42:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E04558E9B;
	Wed, 29 Aug 2012 13:42:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j0abGxpnMSlAALnQ8FIC9puQDX0=; b=yNN3cS
	zAwrPIIhsLYE1Dg585WI8Jidfj8hzBwa4zMSTeu5mt7FPa8jBRZfNeEsPW5c48e7
	hqp4x+/pyFxdvPCjE701NCFYi5+sHqr4g/1F3ZVsvGFYCT/e+S4AcVnyHdnqVfBo
	qMPPhVjBmPTTgh1nhWcnA1XD3QihkkkSeLJlI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SHJGl70UozddliKo+55ZASihW6QslPCR
	bGWPIZkXOfjMdiTsEhTz4xwc9FIg9Gufr30LfKij6b1PHfbNmTnrHpB25aiIuXj5
	AzSojqZFZ9yoYsQcLHbTmo7DR0D9uLjlLEiZ6mVen+qnV1yO75k2EkpEWbBU/eiL
	+Ls2TeJSE3o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDE2E8E92;
	Wed, 29 Aug 2012 13:42:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C0CA8E91; Wed, 29 Aug 2012
 13:42:48 -0400 (EDT)
In-Reply-To: <CAPBPrnstykXxTEH56YFDqU2XW+o8WRKBN6=QOTpLJ1jRU7DXCA@mail.gmail.com> (Dan
 Johnson's message of "Wed, 29 Aug 2012 13:34:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F2AD8586-F200-11E1-87A6-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204489>

Dan Johnson <computerdruid@gmail.com> writes:

> Perhaps I am missing something from an earlier discussion, but it is

  http://thread.gmane.org/gmane.comp.version-control.git/203259/focus=203344

> not obvious to me why this is an option to the no-walk behavior and
> not something like --sorted/--unsorted as a separate option.
>
> In other words, I don't understand why you always want to sort if you
> are doing revision walking.

When you have more than one starting points to dig the history from
(e.g. "git log foo bar baz"), you would want to start digging from
the newer ones, as that would help you find the fork points of the
branches involved more efficiently.  But you need to follow the
previous discussion if you want to understand implications around
sorting.

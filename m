From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] bisect: Add support for a --no-checkout option.
Date: Mon, 01 Aug 2011 16:33:00 -0700
Message-ID: <7vaabshfmb.fsf@alter.siamese.dyndns.org>
References: <1312014511-7157-1-git-send-email-jon.seymour@gmail.com>
 <201107301548.09815.chriscool@tuxfamily.org>
 <CAH3Anrp8aT1UwfstJ99Ug4MD2CZKB9oE_oRLksbkGGE1xSELsg@mail.gmail.com>
 <201107301619.51438.chriscool@tuxfamily.org>
 <7v39hmkkth.fsf@alter.siamese.dyndns.org>
 <CAH3AnroxjFiv25L3N1CQWW6S4vMS7C42b5AzXO09u9091S9asA@mail.gmail.com>
 <7vvcuhhw96.fsf@alter.siamese.dyndns.org>
 <CAH3Anrqp3BVMpTz7DhYBL=9nt1F30_20t=FmcmdZHqMHLEqXqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	j6t@kdbg.org, jnareb@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 02 01:33:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qo1z7-00038Z-HU
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 01:33:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061Ab1HAXdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 19:33:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64791 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754040Ab1HAXdD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 19:33:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9673727AE;
	Mon,  1 Aug 2011 19:33:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a2OtatZwFJ3s+PHQcIOQ4Q5BkiA=; b=UvLAeY
	Z9OFO7S2Bof6aXKY+t5EgDKdHVD5xGh2qqdsrpwik34x8R32IwhxPi2DWE+Yr75h
	JQ2h5COBWOrtSKuzHyuItZPoehYeJnnxmBwBEXMmzW1Mh3x8fNdQiOVLPmK1/sr2
	MWhDyuMzzetwfX00rkz0fn1PsDYiTn3GbC24I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FItj6DXVnunsiYjauSlAbzCsOa+L9UhQ
	1q5JacRfeW3addB8iUvMWhpmc8DvZ2W/H/51zZHHdWkQc0RU5P+wY3tWRGcwq1O+
	m+nQQSz/jdtXOfo59REi8Ir8UCaRCM948gcGjG/GgWm9xsy9Aifb866lhYHtd0cz
	gkJcV6CVPcw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D5EA27AC;
	Mon,  1 Aug 2011 19:33:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EDA732798; Mon,  1 Aug 2011
 19:33:01 -0400 (EDT)
In-Reply-To: <CAH3Anrqp3BVMpTz7DhYBL=9nt1F30_20t=FmcmdZHqMHLEqXqA@mail.gmail.com> (Jon
 Seymour's message of "Tue, 2 Aug 2011 08:19:59 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 990C85EA-BC96-11E0-A899-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178427>

Jon Seymour <jon.seymour@gmail.com> writes:

> On Tue, Aug 2, 2011 at 3:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jon Seymour <jon.seymour@gmail.com> writes:
>>
>>> It might become more important if someone ever writes a tool that does
>>> a bisection on the user's behalf. In this case, aborting the tool
>>> might leave the HEAD in, what appears to the user, a confused state.
> ...
> In this hypothetical additional series, are you happy for
> --no-checkout to become a synonym for --update-ref=HEAD in the manner
> of v8? From a technical perspective, it doesn't seem necessary to
> duplicate the state variables and parameters.

Well, from a technical perspective, which ref is to be updated is an
option that is valid _only_ under no-checkout mode, and no-checkout mode
could be using HEAD, so I think you would need two variables. One for
"what mode are we running", and the other that is only valid under "we are
in no-checkout mode" that says "we update BISECT_HEAD".

If no-checkout mode _never_ updates HEAD, because the normal mode _always_
updates HEAD, you could reduce them into a single variable (i.e. if we are
updating HEAD then we are in normal mode, otherwise we are in no-checkout
mode).  I actually have a mild suspicion that the no-checkout mode may
turn out to be too confusing for people if it by default updates HEAD, and
we may want to have it update something that is not HEAD by default (or
forbid --update-ref from specifying HEAD), so if that turns out to be the
approach we are going to proceed, we _might_ end up needing only one
variable, but I do not think we know it just yet.  At least I don't.

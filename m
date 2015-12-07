From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2015, #01; Tue, 1)
Date: Mon, 07 Dec 2015 11:24:52 -0800
Message-ID: <xmqqvb8am58b.fsf@gitster.mtv.corp.google.com>
References: <20151202002450.GA27994@sigill.intra.peff.net>
	<xmqq4mg05wmj.fsf@gitster.mtv.corp.google.com>
	<20151202223114.GA20542@sigill.intra.peff.net>
	<20151207134014.GA1105@pks-xps.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Mon Dec 07 20:25:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a61P9-000299-Gy
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 20:24:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbbLGTYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 14:24:55 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59253 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932301AbbLGTYy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 14:24:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BDF4E307DB;
	Mon,  7 Dec 2015 14:24:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xk1/kGE+fBycECDGaEA3t8/XNYk=; b=IDUqzf
	4AVXMpyC83cOA9lETzMgBNkh5Spa3k3J0IDugFiiEPhetr2kNgAT3RLpcTLLL5jc
	qWaIebe0jMn2Xno4uRpcUqYoRF70lLL9Xgsnv+xFXGDBu9FNqFdvQCgU3KAEwEL4
	Fmy5r1BvCTAdVUC5gvphqDYGtZ8zsgJZbFMmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nWY9ZgFbwJ/V1kHyQy4qspAWqN64d/R0
	HdP5mHWCyD/1xBquw8owJhPnfWYZcyD8JTVkr9rNGwESMC2SFUiALIMfePYhoKUg
	lPNKLeDri543TRbLplsukK2ClWP5vvH49fafGPGeZdTN+ypU9kLkpY4SNKavVbKx
	Dju7XO9l26w=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B62B7307DA;
	Mon,  7 Dec 2015 14:24:53 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2DCD6307D9;
	Mon,  7 Dec 2015 14:24:53 -0500 (EST)
In-Reply-To: <20151207134014.GA1105@pks-xps.fritz.box> (Patrick Steinhardt's
	message of "Mon, 7 Dec 2015 14:40:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3107358C-9D18-11E5-89F4-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282107>

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Dec 02, 2015 at 05:31:14PM -0500, Jeff King wrote:
>> On Wed, Dec 02, 2015 at 02:11:32PM -0800, Junio C Hamano wrote:
> [snip]
>> > "--keep-empty" has always been about keeping an originally empty
>> > commit, not a commit that becomes empty because of rebasing
>> > (i.e. what has already been applied to the updated base).  The
>> > documentation, if it leads to any other interpretation, needs to be
>> > fixed.
>> > 
>> > Besides, if "--keep-empty" were to mean "keep redundant ones that
>> > are already in the updated base", the patch must do a lot more,
>> > e.g. stop filtering with git-cherry patch equivalence.
>> > 
>> > I'm inclined to eject this topic.
>> 
>> That was my thinking too (and I notice it didn't get any review from
>> anybody else).
> [snip]
>
> Well, I kind of agree. The cherry-pick command has both
> --allow-empty and --keep-redundant flags, where the second one is
> the kind of behavior I want to achieve in my case. As an
> alternative to the proposed change to `--keep-empty` I could
> instead introduce a new flag `--keep-redundant-commits` to `git
> rebase` which would then pass the flag through to the
> cherry-pick.
>
> Any opinions on this?

Honestly, I am not interested if that is only about passing that
option and doing nothing else.

Imagine that you have two changes from the branch being rebased
already in the updated base, one was accepted verbatim, while the
other one was accepted with a slight tweak.  Perhaps there were some
conflicts in the context, or something.

When you run your rebase, the former will not even be considered
because command will notice, via patch equivalence, that you do not
need it, even before it attempts to replay it.  But not the latter.
The command will attempt to replay it, and only in this step it may
notice, by seeing that the result becomes a no-op change, that the
change has already been included in the updated base.

I cannot quite see how adding "--keep-redundant-commits" to the
command would help anybody by allowing the latter in the history but
not the former.  That is primarily because you can imagine a future
in which the patch equivalence determination becomes smarter.  With
or without "--keep-redundant-commits", both of these two changes
would not appear in the resulting history when that happens.

The "--keep-redundant" option to "cherry-pick" makes sense, as the
user will be the one who is deciding which commit to replay on top
of a new base.  If the user fed a commit that is already in the new
base, and the command is run with the option, that is a deliberate
request to leave a no-op cruft.

We cannot say the same thing for "rebase", as it tries to avoid
redundant cruft, and it cannot do as good a job as humans in doing
so.  The "--keep-redundant-commits" option will become a way to make
a distinction between what got dropped by the command automatically
and what didn't get dropped because the command did not look deeply
enough.  That distinction is not at all useful, as that can change
as the tool improves.

A "--keep-redundant-commits" to "rebase" that also disables the
patch equivalence filtering (not just keeping empty crufts in the
resulting history) might make sense, but I do not see myself (or
anybody sane) using it.  "In what situation would such a feature be
useful?" is a question I cannot answer offhand.

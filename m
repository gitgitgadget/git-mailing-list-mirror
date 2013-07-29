From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: correct advice about aborting a cherry-pick
Date: Mon, 29 Jul 2013 08:15:25 -0700
Message-ID: <7vy58p1joy.fsf@alter.siamese.dyndns.org>
References: <1374862320-22637-1-git-send-email-artagnon@gmail.com>
	<20130726191631.GD29799@sigill.intra.peff.net>
	<CALkWK0=qYF=r+Ocb1Z1E=Oteau=AAXR7wnKakt-8Cejwz6Usrg@mail.gmail.com>
	<20130726212438.GA1388@sigill.intra.peff.net>
	<20130726213705.GJ14690@google.com>
	<20130726214036.GB1388@sigill.intra.peff.net>
	<20130726224359.GA3928@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 29 17:15:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3pAg-0002eA-9X
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 17:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757232Ab3G2PPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 11:15:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59461 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755571Ab3G2PP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 11:15:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94C9034CB2;
	Mon, 29 Jul 2013 15:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p55GLeueTWm90FieBZhcS2mn+/I=; b=sBd7VJ
	tiKUzqbvGmfXD1Sz1eib0TJzBn/y+QeSfX6Y19czv7LBbs/TpmDxPzwCpYItw8s5
	cKcdFKoNmiq7bKP+2zEUeDX8mFXqYTxbdzkwPoH8wKdBaXiKHocuhpSo0r3hYYUQ
	XG1SuUh8takNnfe9iSmjVty9YY18W2MORazQM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O1cGlf9sC69ir1b6/07opLIDHS5G5COT
	QIeSFsWU9SZoWZZJDFrV6TbBH2el7RqYdcTmM+UZnsTyWIJeFr1dIPAaYkb4IN1o
	Yv3g8HE9EiCRQFcBcFVMusDpwj1EME02p+P/HqPUfKFiD6yvyPVwJFw3UagF8yjI
	fTsOVRYxUks=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85E5834CB1;
	Mon, 29 Jul 2013 15:15:27 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B786C34CAE;
	Mon, 29 Jul 2013 15:15:26 +0000 (UTC)
In-Reply-To: <20130726224359.GA3928@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 26 Jul 2013 18:43:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B2AB2552-F861-11E2-8D80-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231287>

Jeff King <peff@peff.net> writes:

> On Fri, Jul 26, 2013 at 05:40:36PM -0400, Jeff King wrote:
>
>> > Jeff King wrote:
>> > 
>> > > Your patch is just swapping out "git reset" for "cherry-pick --abort",
>> > > so I think that is a good improvement in the meantime.
>> > 
>> > Um, wasn't the idea of the original message that you can run "git
>> > reset" and then "git cherry-pick --continue"?
>> 
>> Maybe. :)
>> 
>> I missed that subtlety. Of my "three things you would want to do", that
>> means it was _trying_ say number 2, how to skip, rather than 3, how to
>> abort. If that is the case, then it should probably explain the sequence
>> of steps as "reset and then --continue" to make it more clear.
>> 
>> I.e., a patch is needed, but Ram's is going in the opposite direction.
>
> I played around a bit with the test cases that Ram showed. It seems like
> the advice needed is different depending on whether you are in a single
> or multi-commit cherry-pick.
>
> So if we hit an empty commit and you want to:
>
>   1. Make an empty commit, then always run "git commit --allow-empty".
>
>   2. Skip this commit, then if:
>
>      a. this is a single commit cherry-pick, you run "git reset" (and
>         nothing more, the cherry pick is finished; running "cherry-pick
>         --continue" will yield an error).

Yes, the single-replay mode never required "cherry-pick --continue"
to clean sequencer cruft when discarding a failed cherry-pick, so it
is a natural consequence of a conscious design decision that
"cherry-pick --continue" will say "you are not running a
cherry-pick", exactly because you no longer are.

>      b. this is a multi-commit cherry-pick, you run "git reset",
>         followed by "git cherry-pick --continue"

True.

>   3. Abort the commit, run "git cherry-pick --abort"
>
> Let's assume that the instructions we want to give the user are how to
> do options 1 and 2. I do not mind omitting 3, as it should be reasonably
> obvious that "cherry-pick --abort" is always good way to abort.
>
> So we give good instructions for the single-commit case, but bad
> instructions for the multi-commit case.

Yeah, that matches what I thought.  It appears that when we did a
shoddy job when teaching commit to give this advice-message and only
considered a single-pick mode, perhaps because multi-replay mode was
relatively new back then.

> I think instead we would want to leave the single-commit case alone, and
> for the multi-commit case add "...and then cherry-pick --continue". That
> message is generated from within git-commit, though; I guess it would
> need to learn about the difference between single/multi cherry-picks.

Sounds very sensible.

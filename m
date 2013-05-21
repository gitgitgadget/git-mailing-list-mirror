From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2013, #05; Mon, 20)
Date: Tue, 21 May 2013 08:35:15 -0700
Message-ID: <7vtxlwqrbg.fsf@alter.siamese.dyndns.org>
References: <7v38thrxwo.fsf@alter.siamese.dyndns.org>
	<CALKQrgcmmaqAt-oVtFeem_xvqsjehacVoVJ2bYOyfKWTUzV0AA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue May 21 17:35:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ueob0-0000mf-ES
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 17:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754472Ab3EUPfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 11:35:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39311 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752394Ab3EUPfV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 11:35:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EFC75206F1;
	Tue, 21 May 2013 15:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=COK+yXCIhKShaAyJ2nIpyVcVjz0=; b=vGsbmr
	Vr6Uk2sSXxTGuN5GKZlz1HbY2pQDU4/CPK27ahaGYh+0oSXXRtx8KZK2N8Begkud
	NqV4Q/9sl6yx0qRz7cwfr3fBKEN6KGOD7FtusSW0zdXT/9nJ+EpVsgbU7RIJPE3P
	uPjaGdk/riZjalenLMQP4N3/6nUw7Uuw0LV2k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QXYx8HWh+zJXTOf8cX6+Lcww47uxpZyl
	i1LJceMC7RW3Ptw2BLszZBaJ/8iiOpF3J79NjMtP1kvsZgKvg4sqzSsEt8TRXfg0
	FGl4E+R2rxY92TyeSFWCxl34ya9p6AyJfA1380dbnhVF/q1qVFhvTA7TWZhrN+bA
	zISn4G+JjDs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4BA3206F0;
	Tue, 21 May 2013 15:35:20 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 359C0206ED;
	Tue, 21 May 2013 15:35:20 +0000 (UTC)
In-Reply-To: <CALKQrgcmmaqAt-oVtFeem_xvqsjehacVoVJ2bYOyfKWTUzV0AA@mail.gmail.com>
	(Johan Herland's message of "Tue, 21 May 2013 03:16:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0B86F2D0-C22C-11E2-A605-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225033>

Johan Herland <johan@herland.net> writes:

> On Tue, May 21, 2013 at 2:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> * jh/shorten-refname (2013-05-07) 4 commits
>>  - t1514: refname shortening is done after dereferencing symbolic refs
>>  - shorten_unambiguous_ref(): Fix shortening refs/remotes/origin/HEAD to origin
>>  - t1514: Demonstrate failure to correctly shorten "refs/remotes/origin/HEAD"
>>  - t1514: Add tests of shortening refnames in strict/loose mode
>>
>>  When remotes/origin/HEAD is not a symbolic ref, "rev-parse
>>  --abbrev-ref remotes/origin/HEAD" ought to show "origin", not
>>  "origin/HEAD", which is fixed with this series (if it is a symbolic
>>  ref that points at remotes/origin/something, then it should show
>>  "origin/something" and it already does).
>>
>>  I think this is being rerolled using strbuf_expand().
>
> Actually, that was not on my TODO. Sure, my other series ([PATCHv2
> 00/10] Prepare for alternative remote-tracking branch location) builds
> on top of this one, and changes a lot of the same code, but I
> considered jh/shorten-refname a good set of changes in its own right,
> and I didn't want it to be held up by the much longer (and probably
> much longer-running) series.

On the other hand, this itself is fixing the case nobody encounters
in real life, and in that sense it is not urgent at all even though
it may be a correct fix, no?  When was the last time you saw a
refs/remotes/*/HEAD that is not a symbolic ref?

If it makes it is easier for you to work on the follow-on series to
have this shorter one already cast in stone, I do not mind merging
this early post 1.8.3 cycle at all.  If on the other hand you are
hit by a realization that this part could be done in a different and
a better way (I am not saying that that is the likely outcome) when
you will look at redoing the follow-on series using strbuf_expand
post 1.8.3, we would regret it if we cast this part in stone too
early.  I think we can go either way, and the above "I think this is
being rerolld" was primarily keeping the options open.

> The strbuf_expand refactoring is nice, but not really necessary until
> we start using multi-wildcard patterns.

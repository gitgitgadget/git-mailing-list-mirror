From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Transaction patch series overview
Date: Tue, 19 Aug 2014 15:28:34 -0700
Message-ID: <xmqqfvgsunal.fsf@gitster.dls.corp.google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
	<CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
	<CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
	<CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 00:28:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJrtY-0007sh-QJ
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 00:28:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbaHSW2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 18:28:45 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51454 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939AbaHSW2o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 18:28:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C917A33928;
	Tue, 19 Aug 2014 18:28:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Kh8lfdLoHR50q3an6pRuUspAILs=; b=Bj5I6j
	cKOTQVPcwYf3kqUfWMbeJiO7kcI8ravJLg/8BRJgUhoFdTRmaqrgAvxcz216H+dq
	stCZXgM9acrJ7ILbcK+zBR9Pr6JqGbzZly5Z3qWByCFTqArfXIR9/fEFjdCDEsyf
	m3J3LQjdTuOk75itNv5IzC97Re4vNa6c9seSg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iqlhJPI5vN5hKCiGdziLiSWP+y0K5Cn0
	4hatgtXy/gHsF5Yi89I6KC95mbZSGiPtDuqD9VaZtbOWSm3oNXsePi8Czwt4FZ9P
	vEsyNuzUxLlJljSF8bdpwiikPyH/o++tvcaYeBBaWyrYI72hQB1/NyuU86CruaAC
	wCrfW+rbR7c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BF96A33926;
	Tue, 19 Aug 2014 18:28:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5245C3391C;
	Tue, 19 Aug 2014 18:28:36 -0400 (EDT)
In-Reply-To: <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
	(Ronnie Sahlberg's message of "Tue, 19 Aug 2014 12:54:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 291F0C26-27F0-11E4-89BA-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255540>

Ronnie Sahlberg <sahlberg@google.com> writes:

> List, please see here an overview and ordering of the ref transaction
> patch series.
> These series build on each other and needs to be applied in the order
> listed below.
>
> This is an update.
>
> rs/ref-transaction-0
> ---------------------------
>     Early part of the "ref transaction" topic.
>
>     * rs/ref-transaction-0:
>       refs.c: change ref_transaction_update() to do error checking and
> return status
>       refs.c: remove the onerr argument to ref_transaction_commit
>       update-ref: use err argument to get error from ref_transaction_commit
>       refs.c: make update_ref_write update a strbuf on failure
>       refs.c: make ref_update_reject_duplicates take a strbuf argument
> for errors
>       refs.c: log_ref_write should try to return meaningful errno
>       refs.c: make resolve_ref_unsafe set errno to something meaningful on error
>       refs.c: commit_packed_refs to return a meaningful errno on failure
>       refs.c: make remove_empty_directories always set errno to something sane
>       refs.c: verify_lock should set errno to something meaningful
>       refs.c: make sure log_ref_setup returns a meaningful errno
>       refs.c: add an err argument to repack_without_refs
>       lockfile.c: make lock_file return a meaningful errno on failurei
>       lockfile.c: add a new public function unable_to_lock_message
>       refs.c: add a strbuf argument to ref_transaction_commit for error logging
>       refs.c: allow passing NULL to ref_transaction_free
>       refs.c: constify the sha arguments for
> ref_transaction_create|delete|update
>       refs.c: ref_transaction_commit should not free the transaction
>       refs.c: remove ref_transaction_rollback
>
> Has been merged into next.

I gave a quick re-read-thru on this and did not find anything
questionable, nor recall any issue pending.  Unless somebody
objects in the coming few days, let's move it to 'master' as part of
the first batch for 2.2.

> ref-transaction-1 (2014-07-16) 20 commits
> ...
>  The second batch of the transactional ref update series.
>
> Has been merged into pu
>
> rs/ref-transaction (2014-07-17) 12 commits
> ...
> The third and final part of the basic ref-transaction work.
> 
> Has been merged into pu.

I'll re-read these two before deciding to merge them to 'next'.  Any
pending issues from the previous discussions?

> This series is for once the previous transaction changes are in and
> this series will add
> a new backend for refs: refs-be-db.c which offloads all refs access to
> an external database daemon.
> An example reference implementation for an external daemon is also
> provided and can be used as basis for
> creating a daemon to plug into, say, a SQL database or similar.

A filesystem based backend/external daemon that is compatible with
the traditional on-disk format might be another fun demonstration.

Looking forward to shepherding the whole thing ahead ;-)  The most
fun part awaits us but there is a long way.

Thanks.

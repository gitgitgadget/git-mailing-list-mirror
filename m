Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1375F27AC48
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962026; cv=none; b=Wxp6a9IBV4OWPTAryPgjJbhB5va/tqtmZBdi1noNHAR5TREXqjnKA59JyU8im2h+3zC5013KplrevoVAPW52YU7gh1ZM+kjDEGrJ4lSvqXzClMVOcps9mRQHu0Cm9B7BKgkzQU2fWqMEqvKeH3tPYchyQqYCleOjUWE4Nk+LoU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962026; c=relaxed/simple;
	bh=n+RdYbO1X4l6a/FOC/nQ+ULtiI/WrOZvBOnNjYsK8PA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Srfm6Zl8LgGQ7kx494/2qPY1JAIYpcidK4Xe0sSj8sllOD6umLdDQMZiR1M7yx0/GPimvfvplFgEaeW9xalJvOifR7kjpRDGckNlxtnD9UhyetsOEvXJlGqMobQSi/KYj8WBQsb877I9X8V/8IR2i5V45kUW0ZbwqhvqsyzOCdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FSeGm8aU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DTJB/LVG; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FSeGm8aU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DTJB/LVG"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5527D1400155;
	Mon, 13 Jul 2026 13:00:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 13 Jul 2026 13:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783962024;
	 x=1784048424; bh=2thoU7+0M86x18FL86C7aEGUz+B+O5He6RsO1KFSZvk=; b=
	FSeGm8aUE5K/p52PjO83L4kCl84XMxu9aZcoZQMVV3tASM1NMaEymMkaApylhMEu
	cZ1qNaEOKxA1Xx03aDsJZBGQrBAxL3ePO7fiZG/gnhr4Qe0xVfvr4AX+4cTke8yc
	vpshVJEzwm826Yzfh07hh5znft7+YHlTWaYy8RM5eFMbxIRhoCI21dBpjrdBv1oo
	SWghJD/LVN2ooE7fV9XWuDrw/JsaGOcCnfwh7kPqkniENilQElJ94jJ/YOlE4qdL
	EuHRcmKRc3V+MeBXAD5TinHQYNv/qTSDfRRoaT8dwZ7048TcIrB2p4UkLFf4unRC
	+nbQ7O3W5Y5rCAIfD916Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783962024; x=
	1784048424; bh=2thoU7+0M86x18FL86C7aEGUz+B+O5He6RsO1KFSZvk=; b=D
	TJB/LVGah36lXFufFq5vI7fMGCLcNAajYuRiq9uCv6KmcSjf3gOzKXTyNTOC7KgH
	EhjEjlxFAJbXNjyqN9qaoIVDXM45ZN6lqks9mQpz6LQltzQH7vGD3nCZCKCzsWfk
	OS67IrJUZ3ehcI8LXdvCgsJoLLzT77W3hksUCNjYRRZQ5mvu9KDsVx1xngyVT5Qm
	byvoSrgevfDtt1o0DE3wbIdVdkDhdntTrPo1+jT+pIcQJ7sYUzXF8j4R5+iYW+Bd
	DXnN0vXaIHtG+lN8sYXBF5+j1hEgISYxCKZWiGU72jL617i2Ngh66qIZPI5UfgST
	0f+EiSaZ12Njez6rClmww==
X-ME-Sender: <xms:pxlVavZRKwIrFdI8p8BCHQlt4Zm5Mud_EFUqedmx7rEuiymPA01Jyg>
    <xme:pxlVaiErTrJEAOwhXY-ZKl9_JB__VfbsB3nzDJCwVf3OH2vqEj81OPxZmUHERSsfm
    _65GJPJF11Sak0yiq54gvuHUh6hB9ZdjzM59pbHaom9GRTzxEQTkng>
X-ME-Received: <xmr:pxlVarxdN8_0UkrnM-A4XAGP57dveqyWR6838KrMgLyFoVs1M7Q4i31pvV9Y4QkyCcqZOIfi78S1jcNYx5O7K6JXoRFLo2TgU-ePPTc>
X-ME-Proxy-Cause: dmFkZTEzp2aBCknhqBav/ZS8/FGbWFOXS0QkywrqCpgSgg8nPfXuOMHb/OAE7emiaM3hht
    a0wr+q1+PI4cSFO3c/TeXXaLg24OP7AAHezyCXkb4q8p6z3HU81Sa3qBSl49cQmSfE5STI
    rKTWOFTGzWivFrZFjU7frTjcFTvhoQ/2EROCNtTY5AHSZFwXqx7lsQVcGjG+WQqbGZiV4L
    WKxd/GT4Q4z74GWItGq/uvb7Uuaak2mgKVw3qJ4bGdxTF+ZcEn+JQBc2nRK75LFaPuZsDD
    wXugZPo8EJET1TZI9SZiAaNJZNs9dX5KEQ+dm6SfV+vLwUR7tRadoBaQn172Kr4+zTNpkc
    eH93KB6XorkzaYt1rRdQ5Fj8+Dwo5ugg5PdDqus3+a8eLRGnS8vzwGq5c543Sel+i1/BCE
    d/CwIP+17wIx/932PZwviJiNWv1Gw0KpoMKxeuReUCLV9zV77F6GfCX9ZMlVcG4Pp80aWR
    rZEkLqvbgw5nlk6keRC2/qaCWJGrfiF5GYOKQPHML4nvryHgEUkJe5GOTBn43O2FYqIoWM
    kf9Px2MWPggPGDGAFdYgL/Sl+CEqH2P7fewy9oK5mHaLqekpADCwyYQoOe9dsceR0Y1Cpr
    D8wUemQBS65DI3//v3TtIJUxWSUUYQzNFfdzHf+Zwr76+sn+wY7bbxaah/xg
X-ME-Proxy: <xmx:pxlVaslAB07z428wsRJ1VBCW67T2WqPuwrGvyfSSzqddeEeIT04ssg>
    <xmx:pxlVasn6DCvRYKWYoyjPx0GZIxHIU9qBy3wbMN1JZPkuAu2qnpEWhg>
    <xmx:pxlVamx8Uwx4z6uyuaUV1jDPLGqOEMWZIQoQ1aGrQBSLjmEirwDNZQ>
    <xmx:pxlVapp47armDpw2r_tyVoi7VLCmt3YBYGi45dp-FSb2LB3y04H_sQ>
    <xmx:qBlVamuItXTkDOlzektbz1ZWgwHAG4XI-89O0OD9BlzUS3iMSqvA2VbT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 13:00:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>,
  Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,  Farid Zakaria
 <farid.m.zakaria@gmail.com>
Subject: Re: [PATCH v2 00/10] sequencer: do not record dropped commits as
 rewritten
In-Reply-To: <cover.1783948637.git.phillip.wood@dunelm.org.uk> (Phillip Wood's
	message of "Mon, 13 Jul 2026 14:17:17 +0100")
References: <cover.1782833268.git.phillip.wood@dunelm.org.uk>
	<cover.1783948637.git.phillip.wood@dunelm.org.uk>
Date: Mon, 13 Jul 2026 10:00:21 -0700
Message-ID: <xmqq5x2iygd6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Phillip Wood <phillip.wood123@gmail.com> writes:

> Thanks to everyone who commented on v1. I've squashed the fixups that
> Junio had in "seen", squashed patches 8 & 9 together as suggested by
> Oswald and expanded the commit message, and added Uwe's Tested-by:
> trailer to the final patch. Oswald suggested extended the use of the
> enum which I think is a good idea in the long-term but I punted on
> that for now because I think it would be fairly invasive and this
> series has enough refactoring in it already.

Thanks for a concise yet very informative summary of the changes
upfront.  This may be a format we want to encourage to contributors.

> If a commit gets dropped because its changes are already upstream
> then we should not record it as rewritten. As well as confusing any
> post-rewrite hooks this means we end up copying the notes from the
> dropped commit to the commit that was picked immediately before the
> one that was dropped.

Very well.  I did not see anything questionable in this edition.
The contents of the tree at the end of the series is unchanged since
the previous iteration.

Shall we mark the topic ready for 'next' now?

Thanks.

> This series is structured as follows:
>
> Patch 1 restores some test coverage that was lost when the default
> rebase backend was changed.
>
> Patch 2 moves a function so it can be called without a forward
> declaration in Patch 11.
>
> Patches 3 & 4 fix the return value of do_pick_commit() when an external
> command fails (this is in preparation for patch 9).
>
> Patches 5-8 try and simplify the control flow in pick_one_commit()
> in preparation for patch 9.
>
> Patch 9 changes the return type of do_pick_commit() to an enum.
>
> Patch 10 adds a new member to the enum from patch 9 for commits that
> are dropped when they become empty and uses that to stop them from
> being recorded as rewritten.
>
> base-commit: 6c3d7b73556db708feb3b16232fab1efc4353428
> Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Frebase-drop-notes-with-commit%2Fv2
> View-Changes-At: https://github.com/phillipwood/git/compare/6c3d7b735...c89234dd9
> Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/rebase-drop-notes-with-commit/v2
>
>
> Phillip Wood (10):
>   t3400: restore coverage for note copying with apply backend
>   sequencer: move definition of is_final_fixup()
>   sequencer: be more careful with external merge
>   sequencer: never reschedule on failed commit
>   sequencer: remove unnecessary "or" in pick_one_commit()
>   sequencer: simplify handing of fixup with conflicts
>   sequencer: remove unnecessary condition in pick_one_commit()
>   sequencer: simplify pick_one_commit()
>   sequencer: use an enum to represent result of picking a commit
>   sequencer: do not record dropped commits as rewritten
>
>  sequencer.c                   | 154 +++++++++++++++++++++++-----------
>  t/t3400-rebase.sh             |  16 +++-
>  t/t3404-rebase-interactive.sh |  11 +++
>  t/t5407-post-rewrite-hook.sh  |  23 +++++
>  4 files changed, 155 insertions(+), 49 deletions(-)
>
> Range-diff against v1:
>  1:  65af2ac07a2 =  1:  65af2ac07a2 t3400: restore coverage for note copying with apply backend
>  2:  02670f57e7d =  2:  02670f57e7d sequencer: move definition of is_final_fixup()
>  3:  16fba1e823b !  3:  3d79362332c sequencer: be more careful with external merge
>     @@ sequencer.c: static int do_pick_commit(struct repository *r,
>      +					opts->xopts.nr, opts->xopts.v,
>       					common, oid_to_hex(&head), remotes);
>      +		/*
>     -+		 * If the there were conflicts, try_merge_command() returns 1,
>     ++		 * If there were conflicts, try_merge_command() returns 1,
>      +		 * any other no-zero return code means that either the merge
>      +		 * command could not be run, or it failed to merge.
>      +		 */
>  4:  3ffd06d6509 !  4:  fc89e77c6e8 sequencer: never reschedule on failed commit
>     @@ sequencer.c: static int do_pick_commit(struct repository *r,
>       			*check_todo = 1;
>       		}
>      +		/*
>     -+		 * If "git commit" failed to run than res == -1 but we dont
>     ++		 * If "git commit" failed to run then res == -1, but we don't
>      +		 * want reschedule the last command because the picking the
>      +		 * commit was successful.
>      +		 */
>  5:  cb286ac70d7 !  5:  26eef6c0958 sequencer: remove unnecessary "or" in pick_one_commit()
>     @@ Commit message
>      
>          If error_with_patch(..., res, ...) succeeds then it returns "res", if
>          it fails then it returns -1. This means that or-ing the return value
>     -    with "res" is pointless the result is the same as the return value.
>     +    with "res" is pointless as the result is the same as the return value.
>      
>          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>      
>  6:  1585d47e2ea =  6:  26dc48951ce sequencer: simplify handing of fixup with conflicts
>  7:  4386ca67d10 =  7:  71ed717d322 sequencer: remove unnecessary condition in pick_one_commit()
>  8:  f51751fa3ec !  8:  e8b7fa4c59e sequencer: simplify pick_one_commit()
>     @@ Commit message
>          sequencer: simplify pick_one_commit()
>      
>          Unless we're rebasing all we do in pick_one_commit() is call
>     -    do_pick_commit() and return its result. Simplify the code by returing
>     +    do_pick_commit() and return its result. Simplify the code by returning
>          early if we're not rebasing so that we don't have to continually call
>          is_rebase_i() in the rest of the function. Note that there are a couple
>          of conditions that do not call is_rebase_i() but they check for either
>          an "edit" or a "fixup" command, both of which imply we're rebasing.
>     +
>     +    The only block that does not return early is the one guarded by
>     +    "!res". Move the return into that block to make it clear that after
>     +    recording the commit as rewritten all we do is return from the function.
>      
>          As the conditional blocks are all mutually exclusive (either the
>          conditions are mutually exclusive, or an earlier conditional block
>          that would match a later one contains a "return" statement) chain
>          them together with "else if" to make that clear.
>     +
>     +    While we could remove "res" from the conditions below "if (!res)"
>     +    they are left alone because, when we start using an enum in the next
>     +    commit, it makes it clear that these clauses are handling cases where
>     +    there are conflicts.
>      
>          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>      
>     @@ sequencer.c: static int pick_one_commit(struct repository *r,
>       		record_in_rewritten(&item->commit->object.oid,
>       				    peek_command(todo_list, 1));
>      -	if (res && is_fixup(item->command)) {
>     ++		return 0;
>      +	} else if (res && is_fixup(item->command)) {
>       		return error_failed_squash(r, item->commit, opts,
>       					   item->arg_len, arg);
>     @@ sequencer.c: static int pick_one_commit(struct repository *r,
>       		int to_amend = 0;
>       		struct object_id oid;
>       
>     +@@ sequencer.c: static int pick_one_commit(struct repository *r,
>     + 		return error_with_patch(r, item->commit, arg, item->arg_len,
>     + 					opts, res, to_amend);
>     + 	}
>     +-	return res;
>     ++
>     ++	BUG("Unhandled return value from do_pick_commit()");
>     + }
>     + 
>     + static int pick_commits(struct repository *r,
>  9:  2541a4d6e3d <  -:  ----------- sequencer: return early from pick_one_commit() on success
> 10:  e4050ead27f =  9:  4fb641afb3c sequencer: use an enum to represent result of picking a commit
> 11:  26551f2687b ! 10:  c89234dd949 sequencer: do not record dropped commits as rewritten
>     @@ Commit message
>          when rewording a fast-forwarded commit.
>      
>          Reported-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
>     +    Tested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
>          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>      
>       ## sequencer.c ##

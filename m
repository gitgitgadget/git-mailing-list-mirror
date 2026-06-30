Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCF433EB10
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 19:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782849456; cv=none; b=CqYRLQeMAVpmTq7kSc+rPFUEtqIBsdfveWzh5ZzkuP4XAtfZ191HoWe+h779L23LT6td+p3VEeQiGs0LcYlPxl7n+5FAe3u/9UKm7RHqxrWS5jQrMp4szawZwUSyEFxPEzvm3XAuoLj6A+fFaRyZpkRaoLBNdn0GF5VWmjtJveQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782849456; c=relaxed/simple;
	bh=s6gvxQEyz0PPVGrC7igXBmCmYFuwE7ZF7waUcn0F8XY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MK6xVPF3Z9g4hk4PnlQ/SDuw3PMJ6a9ImAGa5mV6qlh3TlA+ZJvw8swHYXYTM6GTHjQ3NBO282BPugwn4Is1NguT/7izVE4l/09prxPn9VYALT/4fnPcvPSq0VmEi3duw1csCW8KVwuPzm99QiXD8Nu4JLEwxCTQYHGrpFZahDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=az2+z8GK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y4UeAEAy; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="az2+z8GK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y4UeAEAy"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 1F8DDEC00F3;
	Tue, 30 Jun 2026 15:57:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 30 Jun 2026 15:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1782849454;
	 x=1782935854; bh=1RAf9tay1jnZ6O1XqiHUjJc14Cu/0sHYZRJDk4co4hQ=; b=
	az2+z8GKD9Y1EiqX0hx5nrrPbrcprK2ry5ohEswxF4duH2jka9VxXhKoRyQB6/Fn
	WUzTIt5JXl/otEE+u/koZjnCHpbilYYbUQ0E0KPnVSJKcGw/hdmIc7Bm/hCf23LQ
	rFdxKZ+pUHtXXHPnFuFFMQO2SDrmJpOBO4Ry7gUuAbWLKdh+aciKTEjju/ph9vrK
	//TIpldtq4jqbg+d8RSw2GseiCprp5KyJxiLFEoJU+0EGfj0kZuCQIr8kyAdnel/
	5Z0qw5ig/vUJ2egrBsY4fuUdA/rHxM6z3nP7uBDZcR5qnFmOgYwXQnVyh9e23YcX
	UdSPc79Y2wnk+fNkJA40Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782849454; x=
	1782935854; bh=1RAf9tay1jnZ6O1XqiHUjJc14Cu/0sHYZRJDk4co4hQ=; b=Y
	4UeAEAyJBk3hYD3ZQOoAH/hOAoIYAaACRoqm6U1dLLHQCVvb43wMsZYC+Lo71BMT
	C5P8texO8JC6YP+D53QJH7Gw6o+iw09xWo+Yjsgtt/h12VKTatogn8S4DhkoR47C
	exUI+ygkYkaWSeuwlNPweEDglUiXkFu9adJkYaTo+XSAkZCvO6gM3W3pKHx1eT8f
	lZfoQ78liRWPdZgz3AsvC65fVujToKa1CfdDIRfAIzRqqzH9nVypoADZkmUHPBKT
	pkoe17c2rPUU7ecYCEqedZfWYV4CKEkN+qcK3C5mjqzryzx6zf33QRH9t+ICCHsA
	mfjDuqTJOv404yNAi+Gmg==
X-ME-Sender: <xms:rR9EasHzICPeVz3Jb1jIZgS00lBtitVZoyMxSir1RkoKsKs2VX6Ylw>
    <xme:rR9EasMVIL9EwGGOCH7NH5nOk_-fw7jbEH1B8v166K6dafoikuhoAR1ErJ0wp0eDW
    N4Qqd6zf04LGIiMtOD1CXHFjiTKTWj6OjvYcy2RpWHc6zQklb37>
X-ME-Received: <xmr:rR9EaucIDQGh-ysD53nGWYLyiT0O8PyAEEC5szleQtkFHhGVdj01SE3vDS4nGQa8qsE8piaBtOfuqWYaGVxFMa433e3lGT0lYf-8wIg>
X-ME-Proxy-Cause: dmFkZTE1nHUtXm2LemECI4rASFsNmmvUIRVMWhVTUzTaqywaT3DWEHScOgZ8hdKFzSy6Qt
    Fq9kEauQo+0/r7OXKxbdnBMto84qT5c9bgFTyxP9Z7Zvpu3rwXFtm0OPiwlzdiGwUj2wbA
    wDnqnSHeaEPVUEY44gVWroljvJsQEhpsB2+PnB7B8TfpeMYwB69nXeCNrmvFw9b3Y4UOVb
    7J+YB5rTW5B1nmdXekIg44KEE4sVPTMUvqKHoobrZ0SJivdtdNaOPb4ewu04fDra28TL86
    lGsSJWwzwx1z8nqt8xHoqlL1vM2dJI4+4N7bN/ojblL3EjKRtwgJZsBqCofy8PH4mTPvXI
    /3RaUYy1FWcC9SOCfrnQv9kRYV/rCLUw/oxqFw4XwCvtNo5tZm+ccpv+Zy6ph3jLIDZKP9
    HCXMb9rb/IKEtV4sVs+jF31NZ206JZ6ugb8ZNBa5BuI9jzETAKieRmZ6Ulw/lzQCLhnK65
    pcsLKNUD7xgHR3as2ZDGSQ+zEp0f9gs6zOuqeTFzWK7GIRkO6qQdcIjh7bvvpEaHcm3roh
    07Wgok+6yJ6S33F1ESlUdpLhfZ2BvsofO9NTwWXnmXu5Qyd6rWJ+ZV+dv8qsh7FpfJBIKC
    fGYlW7iDrf2nxazz5Rvfpkkk6Wh2TJJdd/8R7BCJZTs4eT1slwEOEP3H8IBA
X-ME-Proxy: <xmx:rR9Eapt-ITV9uvF9FTnjXa45etWX4WcWbPOFVp9hDxEMeo4MQ5suIw>
    <xmx:rR9Eavnm-wzmtCMfxWrbWyE8WN_UitBN6RL2VRZZVHClD6ZcI36zyg>
    <xmx:rR9EarxnTbj6u1l6rxm4wIzKxNgY3sep5cn9iC_XRaUolrxmL-KdDg>
    <xmx:rR9EahNbsQNPL8lO7hKU3avGejCbLFkHHA-pQBrr2y22gv-5nY5-pA>
    <xmx:rh9EassxIdO4m2UWNpn6YGpRaTDCEAXSo6ieLUedQm-embLsK4HdHFRj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 15:57:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>,
    Konstantin Ryabitsev <mricon@kernel.org>
Subject: Re: [PATCH 00/11] sequencer: do not record dropped commits as
 rewritten
In-Reply-To: <cover.1782833268.git.phillip.wood@dunelm.org.uk> (Phillip Wood's
	message of "Tue, 30 Jun 2026 16:28:50 +0100")
References: <67dbfb5c-5f07-49b8-aa32-a4635c585028@gmail.com>
	<cover.1782833268.git.phillip.wood@dunelm.org.uk>
Date: Tue, 30 Jun 2026 12:57:32 -0700
Message-ID: <xmqqpl17rec3.fsf@gitster.g>
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

> On 19/06/2026 11:13, Phillip Wood wrote:
>> I'm happy to take this forward and try and fix at least some of the
>> other bugs I've listed above. Uwe - if I don't cc you on some patches
>> within the next couple of weeks please feel free to send a reminder.
>
> Here is the first batch that fixes the same problem as Uwe's patch. I've
> taken a slightly different approach that uses the return value from
> do_pick_commit() to signal that a commit was dropped rather than
> adding another function argument. That involves a number of preparatory
> patches, but they are hopefully reasonably small and easy to follow.
>
> If a commit gets dropped because its changes are already upstream
> then we should not record it as rewritten. As well as confusing any
> post-rewrite hooks this means we end up copying the notes from the
> dropped commit to the commit that was picked immediately before the
> one that was dropped.
>
> This series is structured as follows:
>
> Patch 1 restores some test coverage that was lost when the default
> rebase backend was changed.
>
> Patch 2 moves a function so it can be called without a forward
> declaration in Patch 11.
>
> Patches 3 & 4 fix the return value of do_pick_commit() when an external
> command fails (this is in preparation for patch 10).
>
> Patches 5-9 try and simplify the control flow in pick_one_commit()
> in preparation for patch 10.
>
> Patch 10 changes the return type of do_pick_commit() to an enum.
>
> Patch 11 adds a new member to the enum from patch 10 for commits that
> are dropped when they become empty and uses that to stop them from
> being recorded as rewritten.
>
> Base-Commit: 6c3d7b73556db708feb3b16232fab1efc4353428
> Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Frebase-drop-notes-with-commit%2Fv1
> View-Changes-At: https://github.com/phillipwood/git/compare/6c3d7b735...26551f268
> Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/rebase-drop-notes-with-commit/v1

Thanks.

A tangent (I Cc'ed Konstantin for this), but

    $ b4 am -o- '<cover.1782833268.git.phillip.wood@dunelm.org.uk>' >b4am.mbx

failed to produce a usable mailbox.  It somehow did not think [2/11]
existed.  I manually examined the References and In-Reply-To headers
of that particular message and compared them with those from other
messages but did not find anything suspicious X-<.

I have a bunch of typofixes queued on top of these 11 patches (made
with "git commit --fixup reword:<sha1>"); please double check when
you reroll after seeing more substantial reviews than mere typofixes,
possibly from others.

Thanks.


Here is the transcript of failed b4 am invocation.
---- >8 ----
Looking up https://lore.kernel.org/all/cover.1782833268.git.phillip.wood@dunelm.org.uk/
Grabbing thread from lore.kernel.org/all/cover.1782833268.git.phillip.wood@dunelm.org.uk/t.mbox.gz
Analyzing 17 messages in the thread
WARNING: duplicate messages found at index 1
   Subject 1: sequencer: Skip copying notes for commits that disappear during rebase
   Subject 2: t3400: restore coverage for note copying with apply backend
  2 is not a reply... assume additional patch
Looking for additional code-review trailers on lore.kernel.org
Analyzing 0 code-review messages
Checking attestation on all messages, may take a moment...
---
  ✗ [PATCH] sequencer: Skip copying notes for commits that disappear during rebase
    ✗ No key: openpgp/u.kleine-koenig@baylibre.com
    ✗ BADSIG: DKIM/baylibre.com
  ✓ [PATCH 1/11] t3400: restore coverage for note copying with apply backend
    ✓ Signed: DKIM/gmail.com
  ✓ [PATCH 3/11] sequencer: be more careful with external merge
    ✓ Signed: DKIM/gmail.com
  ✓ [PATCH 4/11] sequencer: never reschedule on failed commit
    ✓ Signed: DKIM/gmail.com
  ✓ [PATCH 5/11] sequencer: remove unnecessary "or" in pick_one_commit()
    ✓ Signed: DKIM/gmail.com
  ✓ [PATCH 6/11] sequencer: simplify handing of fixup with conflicts
    ✓ Signed: DKIM/gmail.com
  ✓ [PATCH 7/11] sequencer: remove unnecessary condition in pick_one_commit()
    ✓ Signed: DKIM/gmail.com
  ✓ [PATCH 8/11] sequencer: simplify pick_one_commit()
    ✓ Signed: DKIM/gmail.com
  ✓ [PATCH 9/11] sequencer: return early from pick_one_commit() on success
    ✓ Signed: DKIM/gmail.com
  ✓ [PATCH 10/11] sequencer: use an enum to represent result of picking a commit
    ✓ Signed: DKIM/gmail.com
  ✓ [PATCH 11/11] sequencer: do not record dropped commits as rewritten
    ✓ Signed: DKIM/gmail.com
  ERROR: missing [12/2]!
---
Total patches: 11
---
WARNING: Thread incomplete!
 Link: https://patch.msgid.link/cover.1782833268.git.phillip.wood@dunelm.org.uk
:

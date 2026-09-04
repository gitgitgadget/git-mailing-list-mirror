Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E7B4A8421
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788533329; cv=none; b=FjjpECEDN4b2IwrymLQ8iS5GoFV2DmO8fp1eVtDsbDTPKeW8RwsQunDxGNEWqbDKhkVNZJK6rg5aEjcVvHQVkiKOHVW2odah/drfXTBsIvox5EglOhhU2VmivjPehnnfEp7H0ii68MgngK2+MUETN0gqMfCPBQH4Cf9slq+DhK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788533329; c=relaxed/simple;
	bh=5PcHuIXc8cim4qUs7tQ+kdyR+Erg4xF5itN7X02O6t0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=emdqfMBaJt7ynBTvVOXmBhw8mb9uPK2QEHlmfGoknR7+yT7jmwpf58vasqkOk3Mf+Vs0swMNSSlWN3MxSdmHmK8RSRNwHVsX7MAZpyGE9tHMh5WZORtiGCq75aGE0uAwIhYWnvMVYP4wY2M+dLh4AKSB8hyGlwAPpSTjqU2yisE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qm5pfzG7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G2+yQpij; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qm5pfzG7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G2+yQpij"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 0DFD8EC01B8;
	Fri,  4 Sep 2026 10:48:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 04 Sep 2026 10:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788533327; x=1788619727; bh=zvZcS6gHbv
	ezxb4Oui8mRxLecO2RkD0y96CKiV7bAmU=; b=qm5pfzG7psXxjbvzowT41QGHIp
	bqF3pn7mTEV46ZIF9ybwlOcsUNDF/Exsrlht5eXvxmFRU5kjXdo5VpwDsJxBB/hr
	mgCH7JIOotP2aAlLwJYDBLxomh4Jzy2OfJARP8fq73+F1wycCQNJ8iSEE2/WYD4y
	2iiUIrel9WO5JPw5jyq2T/tqW8bPAGK0E0kfKPT80+Nu0Ha3qFmAVftCY+uojuWA
	iOlibZfURTEUMSuQjvk5vDYgqo2euZTWF7BgJXaLDXu9Ex+OR6PMxtVFR53tV5o+
	Fuhv29Gq9XOGnAmVuhynY8Lv9lycn3XUSweuLkF+WB2xEiTb1doKEPS0cGZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788533327; x=1788619727; bh=zvZcS6gHbvezxb4Oui8mRxLecO2RkD0y96C
	KiV7bAmU=; b=G2+yQpijdHwn53aBbvMNhanxe+wYbGYxAlRQPd2Vveuk9JcEqu0
	CSmbHOIk/ZuHmQEUUIDuJLmfxH/vhmc9qd90o4NRWdFzcB45S+sceXzwVPP5f5+U
	YJEj2OZsMW1NZkEQU12fzGb0DkfTvt7S/eO6gzV/dHwq4YUlmalN9WbZnw619HNS
	VZreJLtyz44kbiXe40wgryv9wNVw4ig8+Iqy6/lklhe3tUQpsPifSievUA/K/lAt
	2RKPIWdFU6PTAdbwsiB44ZPkiiW1gbnighGor/hYsvmQWTu1FTrV4CoVI5x+KBca
	xNMjzDFp+2N/6iWRJxDMiE5jOaGDaoHsmNw==
X-ME-Sender: <xms:Ttqaan5imt_RyVDC8hu_Ck0_wI02vkml3IEc0JDs6-ZVv_M3WkwHMA>
    <xme:TtqaamOTTt3pFYOSMaH7SNkjyXHIN2btvhxA10coIZvHmm_Z7sMuDO-0wRGBTV_m_
    0HGkiKw6Z4otI1RQj9Zr76NsgIy-LYCyw5WXBNFvKA5BshViiMvmTc>
X-ME-Received: <xmr:TtqaaluCmfIxCOMdVHLGoDUhYBoO9nBV-hpR9YTJUFlOvT1vTLUZpZGC7-2H7m-wBQJBZ74Zx1IHzCnnPKygU10_7GZsg0esVQ>
X-ME-Proxy-Cause: dmFkZTE+piac41jgfrdat1jU8t76bFIAjVogqIzBn2M8p6/TZXQnAi1fRCwXqyNiCp1Mwv
    Qg9c9MmLEnxO1WFgxx+O+tLl+4+0/QLBVtWl5slbf4eUOvLMyMze6wgLXYMQwisTjuw8hd
    iEFR0iqFXYTe+WYbqCIRBBl2n7F/6G4ku8ykl2rRphXqMRcpJkEmsRWt4I153jKZFBZGiu
    xXHUKg9U+me3JIKyLNyYBMCPo66u62uDragw6zb496CzD1oIp4VUylz1cP9+9h8UA6xTKO
    BtBBYMgmMO4u2llAi+f0R7kPkVoSLMRqR9Nus36krbqh0Vp4XnynALINORYA9UXqrwZ8ZJ
    pEia5QSjUWrfNcmYaD7nOxh8LXnjlD4/2cNfQmKfSoQCfrvVkE5TzZ5E6YZ7hBbbTVfHeg
    0jEYAzwcs9iitlvbxN0MjtqlySG+NII+/vVX8GFCO5/Re426jqCH4LEEg7gj1hjkvOS0xh
    D5wGEj5RkH0hHrMzi7spwSlEL8TjaB1pbiJDBSf8jPbJDKAwA7zbvnxrHHAwaHOATJcr73
    oDkopP6e5ISbWvSzoi5G69GDe47sCYrimz0cUg6WXnzN/HldzMmGCLRM+qUv0jIDQhv1Rj
    e56Wqwjg+xAgJs3D3iVUorssCRbrLIv71UxAOME2yYyw0pm0Qf3YTOufoBPA
X-ME-Proxy: <xmx:TtqaapZhjtsJ9xqsGXhI7TFsIyMcsGfjq0i9oD2_MxoetnOsGVpbCg>
    <xmx:TtqaanzHnH8IDIk54OwELPj7LWzCZ0Xm8uJ6V-wMoDlghUBfWt7Pjw>
    <xmx:TtqaahhcGJ5w7UjsZVb4tnSFNuAwFrz1XNzf2-M9c1oiLAihMHWzRQ>
    <xmx:TtqaajmigNTrhYD_gJ2LjXseu_QWZZQ4aBq924bAAyrh7TmnWgJI0Q>
    <xmx:T9qaahxYdNhl99YRuQWeBTrEjW7OhRMyBMWgdl-RSNd-vVY43kIaZtIy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 10:48:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Thomas Bachem <mail@thomasbachem.com>,  Derrick
 Stolee <stolee@gmail.com>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/2] builtin/maintenance: improve heuristic for
 "rerere gc"
In-Reply-To: <20260904-b4-pks-maintenance-rerere-gc-heuristic-v2-0-b1691121fe1c@pks.im>
	(Patrick Steinhardt's message of "Fri, 04 Sep 2026 09:03:04 +0200")
References: <20260903-b4-pks-maintenance-rerere-gc-heuristic-v1-0-9929c45a9788@pks.im>
	<20260904-b4-pks-maintenance-rerere-gc-heuristic-v2-0-b1691121fe1c@pks.im>
Date: Fri, 04 Sep 2026 07:48:44 -0700
Message-ID: <xmqqfqzp6pir.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> as reported and discussed in [1]. Thanks!

Can you, and everybody else, refrain from forcing all readers to
visit a different message to understand what it is?  It does not
help that [1] is a full description of both problem and solution
that is not designed to be a summary to begin with, and to add
insult to injury, it is AI slop wall of text that mistakenly thinks
that more is better.

Perhaps you could have distilled the essense down to several lines?

    Since Git 2.54, background maintenance triggers after a commit
    runs "git rerere gc", which acquires the MERGE_RR.lock.  During
    rebase, a subsequent sequencer commit also tries to acquire this
    lock within milliseconds.  Due to use of LOCK_DIE_ON_ERROR,
    whichever arrives second aborts, causing rebase failures.

I'll leave it as an exercise to readers to summarize the solution
part that this series (not the original one) proposes to make.

> Changes in v2:
>   - Restore `prune_one()`.
>   - Handle "maintenance.rerere-gc.auto" values explicitly.
>   - Rename `rerere_gc_estimate()` to `rerere_gc_needed()`.
>   - Link to v1: https://patch.msgid.link/20260903-b4-pks-maintenance-rerere-gc-heuristic-v1-0-9929c45a9788@pks.im

I find that all the changes between v1 and v2 that came as response
to Derrick's review highly valuable.  The "cute" expression is gone
and the result is much easier to read ;-).

Thanks.

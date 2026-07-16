Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3C143F8C9
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 17:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784223978; cv=none; b=IXjkyad5PDGbqt1W/bRlbMM/l175r8vbqqOpdpluynq+cmwQrH4wrSNK3rgLqWosIU3ZnDkjP+5UA7bk5cgbQJrenIPImKa9p+vrmo4gbOrI9ic/hznCKZBduPkNlOCRE7UitlIGYi78xwdpkAn6N/sI6rcfXoOgLzLOpSi14UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784223978; c=relaxed/simple;
	bh=6ooGJQwJ2woXuJM5SUwtTmLRYqnMcl82B0bpQybH/Lg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F2MwEO5dHmbVBs1FyrNmHTEY5bbuASZJAuJTNh2+D8PgLZpaL2KIEP4LV/Gw2ohOJUbwR+PJP2+qDKhVOcLvRDbD1BU2g/H03udfMSQWbkHK/BdVeTzs3yWmPLG4Kp9YnvBTum/3X5yVJS2HqexotAIYmbJm+Df31/JbvJk/3iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=R1zJVEfW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AhGHUcip; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="R1zJVEfW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AhGHUcip"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B3144EC00CA;
	Thu, 16 Jul 2026 13:46:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 16 Jul 2026 13:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784223975; x=1784310375; bh=u0a16s/2RC
	8CrEw7r8mYGM5SxIKc5c66NXciy0ZY45Y=; b=R1zJVEfWfxjaO51XJsqO2AC424
	rf511aLwvdloK0qOv5EF8zhsmkKJ3FrDhJZQQuav9EtCyDzD8UAaNLin/9joth1y
	z01F8KbNZTkPBbKoq+k3cGawPg05UsriOeQ81FDA+r/YWPnqjmPkCwanaMZXmyVU
	0X2OcXHgb73l1tMot5RruH7D0g14RHOZPt5RPsFLFgmbeINSllVxZeLxmFBrAQUr
	LrZbb07yiCtqxUzSUHGTghHVoc2D7aZ3szuZPRT6ClpGRW+qwUoW1CHxonDUmPv5
	7Eo4EvmrqWqStf3AQIu1LL8U/nTjX4lG0FrOZa8lOyJn5PIcVtSJ/lKQcb2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784223975; x=1784310375; bh=u0a16s/2RC8CrEw7r8mYGM5SxIKc5c66NXc
	iy0ZY45Y=; b=AhGHUcippD8WK4dWw2MiiiXrp5zwMlss6/EMxGnJdNtYXsc3hU0
	F91HD80oqmOJC/QtPNVONQVDbpqxyVhR0DdwjfbhWkKQduJPizHgWqb6Kn3twzGY
	IZW+8E+mLQsi86qdY3k77GwD+WhbzvcsmtIw0rodQ6gt0j6gml9rs1SXIprKuaNb
	TFjDW7Rdbmentpxsh7GUKXOoPphp9/kT+YuGhrWicdop5VQaH0FnRSBnMuGXBjYJ
	53pwSDTx1eWQFE+JLda7WUdNulkL5UYbPT39evFtwhhUGvpRIqJViirAY6YdHIhr
	oNlghLD4WcxKhADXsq6d9vyeUx14qoMPZzQ==
X-ME-Sender: <xms:5xhZapFqk5YLYb9iOUU2y7z6WMpau8R3AlW6PZViqmqShIDDXMVDMQ>
    <xme:5xhZajRbu5djqQzThyhKTp2bkyxOZxC6CmYUxuhyca1cK60CBo6KOn0YadiDYuXCI
    ArdtmMEYwHZtJOzyXu8PRdTBoePGuBKetx41wmZcg5LVjGx7Kriuw>
X-ME-Received: <xmr:5xhZava8JpwGYyKo233SSof0A4rSzyYnQb1vEPOgmfeSytcp38YDWFqPxalibPTcaVJmz1NpFD_SNKbz3DhOURgZ1UP0UIaopHy2Rjw>
X-ME-Proxy-Cause: dmFkZTF4fdJJMT/I7HO2STPaGBGSq4beBBfkYWRIQXe3l9XuQ94tGMDNWzCnmXWoo66iWL
    HdjUCztG2oIUwPf+y1hovMLj8Rt4VQJocZsULuLlREKqC0qSKmRJOQsA8T4EHyjUfiQ25s
    kORWmtjeBCzwVcE2YFAyD3L8jcI+vlnr4izWPaOZe2giqQg+BI0tYUr63/n5TlBqVVsdXZ
    0Ia/e3j2Shn93R0Zhsbg7VoqxdhF6L/ns6AZcxvfA6teeDSk9bNFgxIAcO0X/djg8gbhCB
    7q0Rj0NQPLHYgReDQjEoJHsm6h2lZtqlrMYJmedPwX+agqD/FxXFyePeIMKN30/0Ig3KNf
    BbJTLRzjVEO5QTlQWCnApW0lkEFxyjg3OFNX0V5nw2roeBaJW5TMrpXb0n37t2rBewfRRr
    wh1+mbmDIzgqYvUFMpHNrSlQR4u+IKdsYaHwT1jQzuzJ+5HxQ/qFCnnn5vL+G9t77lgD3S
    VQUj3tZbcnD2Pn8QbRkhXdPVSR+53ICDcTCYDSoXo4mfV3a2h9sXBc29wfOYqsyi+RWuYT
    NApi5yXt5iy4D7wcjWrPbK8qKgIwS1axOvkhcL6QelJMfG8VWL92jxrqlnVVcVsoX/ltjZ
    +ERmGFOOFq3QP/xdHPn3FVG7EqZVlDZLFs5HkwpXMDg4GP/WE6KyDEfSi1Qw
X-ME-Proxy: <xmx:5xhZau0ureJfwwihgbT9O1KiyycygK3Bv1_aCB-4jAksFM13nOM7OQ>
    <xmx:5xhZairlaK1FhtY7JZOUu8Y-XmEZ-ZtX3jK8NE6VtLk2-t7A8ODYfw>
    <xmx:5xhZatM1ETo66gpdVDBdzK_LS42GXzY2IaYyOSuGBSaC45ZRYD3dAQ>
    <xmx:5xhZarq12TujmPjUF4QCtqeHQYU_rW6vcZbtaULWYotUR9NG-f8DNA>
    <xmx:5xhZagBEhMnGulMsfC-LmQR1PDN4-mu-WJxfyqMMoS86xErY1XfsMsFQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 13:46:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Emin =?utf-8?Q?=C3=96zata?= via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Greg Hewgill <greg@hewgill.com>,  Micheil Smith
 <micheil@brandedcode.com>,  Michael Haggerty <mhagger@alum.mit.edu>,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,  Emin
 =?utf-8?Q?=C3=96zata?= <eminozata@proton.me>
Subject: Re: [PATCH] stash: add 'rename' subcommand
In-Reply-To: <alitkCsplW_DIaRw@pks.im> (Patrick Steinhardt's message of "Thu,
	16 Jul 2026 12:08:16 +0200")
References: <pull.2180.git.1784190706028.gitgitgadget@gmail.com>
	<alitkCsplW_DIaRw@pks.im>
Date: Thu, 16 Jul 2026 10:46:13 -0700
Message-ID: <xmqqh5lyhlp6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Hm. It's good to refer to to previous discussions. But I think it would
> make sense to also document why explicitly _you_ want to have this
> functionality. Like, what use case does it enable that you currently
> cannot have right now? How is this different to what was proposed back
> then that should make us reconsider whether or not to include it now?

We have one previous discussion thread on this, and there is no
need to refer to every single message in it.  Just pointing to
the discussion starter should be enough to let us read what was
said.  It was also very nice of Emin to summarize the viewpoints
expressed there, so that readers can follow along without having to
dig up external resources.

Asking for the actual use case is indeed very useful, and I highly
appreciate the nudge.

"I cannot reword the message shown in 'git stash list' without this
change" is not a use case.  It would be far more useful to know
what real-world task you are blocked from accomplishing just
because you cannot reword a misspelled entry in 'git stash list'.

Personally, I cannot think of any such roadblock.  If I find that
a stash entry is worth tweaking right now, I would probably
create a new branch for the task, unstash it there, and either
make further changes or record the exact state with an updated
message to help my future self.  After all, having a branch I
can start working on immediately is far more useful than having
the same stash entry with its spelling corrected.

Thanks.

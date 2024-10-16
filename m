Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B235C18F2F9
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 21:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729112454; cv=none; b=e9+c0J0YGoIeq2D3Ir8ja5QrffDEkMlDccYltE75Du63/f8FBdLqaVxHAx8wsH83g7A0xtawILCjXq0VGingxxLuia1aAA8KDR5mcEGwuuAAJf2taN5yjH14HCRrQFNEMTSmHNRD/vR7dRLK2QdYmiwIfJwOBdFKQCC+q+hTw/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729112454; c=relaxed/simple;
	bh=SQtwddg6XUVeAzMrqSx2F8D6mUVD2wPKV0H/03XgX88=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VKdHSnJkfw8y7AUkJr8ffClss8OOVCQ/jZ5BlYaBxPCKz06AGWR0H5NuNcdp5ZAATqr12nlwYX+uYSDtKF4557m6VP2RGKjjIfGi+PnAHWTPx0iA3rCZRR1ygvd9X6gD8Jp/11mUbJrjdDrrT0seTlgX3a2YycATlGdepmXEf80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ECl8PeVa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SMkT0ys4; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ECl8PeVa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SMkT0ys4"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CE76911401F1;
	Wed, 16 Oct 2024 17:00:51 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 16 Oct 2024 17:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729112451;
	 x=1729198851; bh=tUsXPQ1DZx9qlHAfGDcwCWOCWMH2jJ9dmt8gSTeqNec=; b=
	ECl8PeVaxZCt3syXsV1db7V5sLoAqwVi9pwZmI7JtwdOyaGIEdkm23/L2YEFZ22w
	f7SPWL5rILkA80RmORDcWo6z1YwAoqNWq/z3sgRc6sYJ0H7PoeHp3GXPwpcMuJzr
	RZWDQieobj7actjuZqwxHQ0xJwQYg2xEsOIhP9tSwjofDc+Ruw4vD5FupWvODJQy
	JZ43OMZT+EHSHUH97klY4Qu96fdyNuGFw8wYPCMXJhEobrJmjJ1dxhX9ktqOl5uH
	00hqe8xOa3Pi+g5ml5PDRKp/s+0x34sdnqqIlfm35nv1oQ92dl4hzYMMX2b64Odd
	7yREgbOQ019x2ez7XYFX9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729112451; x=
	1729198851; bh=tUsXPQ1DZx9qlHAfGDcwCWOCWMH2jJ9dmt8gSTeqNec=; b=S
	MkT0ys4doPTpFe3x368c7IKBNj64p5fQgHvdg/aN9IkvsUgPpCyBw6Hg/pysCh27
	dCXloJKaIyfSU/GqAEA9wEy0aIVjUhUWKEzaupq9M9GH4ae8a0/7cdrONiMM78cS
	AwCK7Jp6wE6eRSoOVKqieYUm9edg256pcagIbDQ6XF9dy79IlJABmIn4audB7ZEd
	FJ7htt4G/jS/OJ3T3np8srnOqm7ddWIy9rDtvRq0A5ZcQChm0gI/80JcB6xiykjO
	URQAAlS56VtIVVSV91nlVa1QxY02vSNpkEF6+6Ts7NLqvYDzXWxuLPhAa0A3bO62
	so+zhP3hRLiepAIpFrmhA==
X-ME-Sender: <xms:gykQZ2Nwmdm9NB_EooOCdNK-4_qginx0ovkELY-L6xMnkEzn9m2ZYAs>
    <xme:gykQZ0_ohz6LT-aN3r7urZ7pFkk8FEQC1HMb1ly4hCfLedqcGcdEoGk_vX7SG2aXT
    Oi35wM6ziNGAXCspQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegledgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveejgfeigf
    efkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnh
    gspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepsggvnhgtvg
    esfhgvrhguihhnrghnugihrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkees
    ghhmrghilhdrtghomhdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrg
    hmvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    mhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:gykQZ9Q7yVyZuCT3jniCvzkBkRrmrZ0otjP3TuFro7MsWJKB_8mGEQ>
    <xmx:gykQZ2tdwpF7-AgzgvYJZuse4Zb3v2RLdmyRNJ0FZ0H7CaX92RWgFg>
    <xmx:gykQZ-esl9SFRvESUCG91pFmFWXWxYgGztCA2HepKKGNlFgCEGzkJw>
    <xmx:gykQZ63ExgHjZWWkUXZkYMiuG9a8JvDbvzD3kI7XWkcb6DJTrkretg>
    <xmx:gykQZ2S0Hytp6rjTg7NiWKPXhXmCekMiSy2GAAnDN1fS00hRmMjkzTf0>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 534CD780068; Wed, 16 Oct 2024 17:00:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 16 Oct 2024 23:00:30 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Taylor Blau" <me@ttaylorr.com>
Cc: git@vger.kernel.org, "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Junio C Hamano" <gitster@pobox.com>,
 "Bence Ferdinandy" <bence@ferdinandy.com>,
 "Karthik Nayak" <karthik.188@gmail.com>
Message-Id: <9b8925d3-3f2b-4396-a0b0-3b72bba5e53b@app.fastmail.com>
In-Reply-To: <ZxAoFUDmdfZ8rlLs@nand.local>
References: 
 <CAOLa=ZQJy1ZkQqBoWwJJvL0f+NCP=3SAfyeSNuztgApzNH1mGg@mail.gmail.com>
 <cover.1729017728.git.code@khaugsbakk.name> <ZxAoFUDmdfZ8rlLs@nand.local>
Subject: Re: [PATCH 0/6] doc: update-ref: amend old material and discuss symrefs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024, at 22:54, Taylor Blau wrote:
> Thanks for working on this. These changes generally looked good to me
> (although seeing smart-quotes in the commit messages was a little
> surprising ;-)).
>
> I'm making a note for the next WC report to expect a new round that
> corrects the subject line of the penultimate patch "doc: update-ref:
> discuss symbolic links".
>
> As a general note, prefixing commits with "doc: update-ref: " is a
> little strange to me. I think I might have instead written:
>
>     Documentation/git-update-ref.txt: remove safety paragraphs
>
> , and so on. I left a couple of other small notes, but I don't think a=
ny
> of them are urgent to address, though it would be nice.
>
> Thanks for working on this and improving Git's documentation.
>
> Thanks,
> Taylor

Thanks for the review overview.  I=E2=80=99ll change the subjects/area p=
arts in
the next round.

I looked through the commit subjects for `Documentation` in the past
and, seeing several different styles, landed on one of the shorter ones.
According to my recollection.

--=20
Kristoffer Haugsbakk


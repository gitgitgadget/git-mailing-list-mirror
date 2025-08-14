Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347BC2FF663
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 03:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755140421; cv=none; b=Py2moFbnNMs5lZPaZTuAvbS9CYwpW8zdDPkAwuHthooJhfYkShYtbf127gK6gq0a10jjVGCiwCF6G+N1J+0t6Cl2h+hqSPd2ORBgsPht1J/ChcPYBgoIbxyxO2F30KCKhlviOrEA8T9/JTnuefJD8Y5z8rG1lxW94s3Qm/ZWpdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755140421; c=relaxed/simple;
	bh=uLojdr5rE0MzkqrPl/JEAPy3xoaHV8QooRfP51hhalw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Cd+eY9C+sBiTPnxeeiGujvqiFWJDq1aSCzq3FaEusgfngkvmqgKj35/sO5zfgtgdvm4bhGcJXGge6RucmeoTncPzO1wPoYtDdkpU7AEdG0Vx4OX/ysgPNp6YChlCQrZ1KSkvBT9ceW7UUGs+7z7RAoxfO3THxukPwV6glhRu3QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=f4dOAFyS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jow+JdKQ; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="f4dOAFyS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jow+JdKQ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1C0B67A007D;
	Wed, 13 Aug 2025 23:00:17 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Wed, 13 Aug 2025 23:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755140416;
	 x=1755226816; bh=kTdTIg5aIL4yuLvy4MdVzrVOpxuReHy98EHTw+1YX/A=; b=
	f4dOAFySRJFNBvAY73/XfeYjn8e2g3DjxorDntOKnjOKOYhuN42XH4Z7vGSDrznq
	HTZpXbYVROZgskgOqpkBzCM5WUVSIPv8Uy5c+KANbxNUWFIHZlMK/ZxbQYEib/iG
	wyNDk9TFpsMzmAINM48J+ML2eY7NM+xhgNIklCNwPPeG9j7iZz0EnD8RXRw10fcu
	KJ4T3XceZP72tpfZYYs4r3ekAYVegymBPM0rgPSYpKx4pVMlpnEqTdxvhDraUsaC
	oN+0Cfend/39khQe4svczt/Pd+AUSziqo5YKDHn/1hr6+7k7cxR13sNlyIyP1PWX
	LCmvQ00PnRlZkjFQcSdwLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755140416; x=
	1755226816; bh=kTdTIg5aIL4yuLvy4MdVzrVOpxuReHy98EHTw+1YX/A=; b=j
	ow+JdKQO2ig6u1uQUKTJvoAGiT925w6hhuoSfUAAfWGTqwCm4l5ZGC4D0gMOW4Bf
	VC2rBpqhGnLg94H17TZl5xRm8s/Hg6ul/RwiIURf/DA22L3rCkEzAUbUcFu/geeH
	/biTSsNxfxLEDFQ19TkNt9+MJLhqiAMowB0uVCL12q8vRi8g/UO6YE1uuBem3Ln2
	UfBIAMuEjKjsCrzZUgqaBTEQF0RKpPc5nA6t3q5krWadsz7flzxlGNITqraiA+t2
	z9+GiwPlWJYEy3IKp3mwXuIcJyv28eCjQa6oqSwn5Wd83Xic7I+NCTH6nc1Jh+Qk
	qiFuP8P/x+Uy3eWwyT5kQ==
X-ME-Sender: <xms:QFGdaHq3BF8bicuEjctqT0BXMpGymgiX5CAZfrmMpfcVuyQmrh1UzQ>
    <xme:QFGdaBrXR-oGPXPrq3WBw3HBE2auz41bEs0pqufbM-G0-wNBnoy_dn6S4FawVh3uS
    AKrlkL3ArFU3lZhyXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeelleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthhqre
    dtredtjeenucfhrhhomhepfdfluhhlihgrucfgvhgrnhhsfdcuoehjuhhlihgrsehjvhhn
    shdrtggrqeenucggtffrrghtthgvrhhnpeefieeigeegtdefkeejgfdvteejfffhveeuud
    dttedvjefggeevfffhleegvddvudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehjuhhlihgrsehjvhhnshdrtggrpdhnsggprhgtphhtthhope
    efpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:QFGdaGzj-fHieMxPl3dOy_T8EDpX0YvCC8q6W38lT8sbcxCAiD8lXQ>
    <xmx:QFGdaJJYqkN3ZppMer2F3jbWSXSr3kQTjECoonHwTetoGzdf1VRC0Q>
    <xmx:QFGdaFRjRCiQodGazotbvlovNC_BQafRJczp3ozUUYiswvEHFrBJvQ>
    <xmx:QFGdaJrMnm3098dlv7a-6zohWSe3wvCpS8N3PIK1OBZuiaVy6AqLMQ>
    <xmx:QFGdaHzFZ0S90dySFZm6TkCRWsz85NHJuJgJ39OfbiuG_g_pQkkfjyFS>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9786B7840B0; Wed, 13 Aug 2025 23:00:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T445d42a894a29bdd
Date: Wed, 13 Aug 2025 22:59:18 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org
Message-Id: <e1c9f388-f72c-4bb4-b05d-b5b183501456@app.fastmail.com>
In-Reply-To: <xmqq4iuabup7.fsf@gitster.g>
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
 <310d2c1d8f7f68ae52ddd29f0ccb0a0364aba1a2.1755029249.git.gitgitgadget@gmail.com>
 <xmqqbjoks19f.fsf@gitster.g>
 <152d47a3-7744-476a-8ab8-43b7b52b67ea@app.fastmail.com>
 <xmqq4iuabup7.fsf@gitster.g>
Subject: Re: [PATCH 2/5] doc: git-add: start man page with an example
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> There is an easier-to-understand example.  If you pretend that you
> "add" series of "diff/patch" to the index as you repeat "edit &&
> add" three times, in the mental model of the users, there would be
> three set of patches stored in the index somehow.  It would be a
> fair wish for the users to have to be able to revert only the change
> you added with your second "git add" while keeping the first one and
> the third (latest) one.  You cannot explain why you fundamentally
> cannot give them such a new "feature", until you admit that what is
> recorded is the latest snapshot and earlier snapshots are discarded.

Thanks, I think this is the perfect example and it gets at something abo=
ut git
add that i=E2=80=99ve never totally understood: why are the earlier snap=
shots discarded?

Naively, one might think that:

1. the git index is just a tree object
2. when you commit, Git takes that tree object, attaches a
   message, and makes a commit with it
3. git maintains some sort of history (like the reflog) for the past "in=
dex"
   tree objects

If Git worked that way, I imagine it would be possible to implement the =
feature
you describe, and I feel like there's some sort of obvious reason (somet=
hing
to do with performance?) for why the index isn't implemented this way th=
at
I've never learned.

This example makes me think that if we want people to understand the
limitations of the index, it's important to communicate that the past
index snapshots are *discarded* and not just that the index is a snapsho=
t.

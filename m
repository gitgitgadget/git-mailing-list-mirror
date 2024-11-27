Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44239192B71
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 09:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732699470; cv=none; b=Czzinhx+DIpNoWiKZj8jWLoTk0017bk9KlfuRDPEYpfuogZVezQcjwO5P86GutQdEHtrD97THJza9IBki3ehDF5mgnSAH0TAx+CCnOhKNyA19sQPRzGowPecm8rnqFS+Iu92v0VdxMth0sR8ZTZKO/piw5ql95o1DqLUEDvJtFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732699470; c=relaxed/simple;
	bh=MEJNS4gVuEuT91y7H3BjLEa/Lkj6ZfBViRr6jveryvg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Nl0lUFRb7OySwdxhM8HjPV7ljz3lUXDMNcZxsh4fe8mxSFY0daFqVZ9tyhxOXPDupYQfWJoQ8z9PUZr8smm1uEAP+Em5vfP8oj7uuYA9PDbkC4jzXv8xsbNnYD1/VjiQ6Z999yequUlz6lEt8ir5gUtZuxx7yKZsBSr5jUPVa1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Bt8RlcV9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OX3hhxRX; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Bt8RlcV9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OX3hhxRX"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 43F4413805F1;
	Wed, 27 Nov 2024 04:24:27 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 27 Nov 2024 04:24:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732699467;
	 x=1732785867; bh=I2q8higSoAsXrK+ORJjyrezeGuPRwM6HutWusgI2DmM=; b=
	Bt8RlcV935dj9Jd4Q9Cxr3ewytH7yrRm08dxlmUEoUemVNYKsq0Hn1Qeqhp78Hyf
	p97HG4o6bKMF5cE8O1Rt6P8BJSgEy+F839yJsKtkqhAwgzhRGZzlISsK+xIIN8qh
	uLBFzPtQVDbMogDdLzr3XHRg0kxhjWk1cTpPURInj+B0RSNjURuie/6sf/omdzbo
	JFhUclwK+K/eW+rqYlT55gd3igtpNeY8XXJlD7dk8krTRtfDA9MORa4Ni1HTSOKH
	xriZENLdcSnI+FIz7BxTAvCyWekjSBJC/uufl7NIvpqk9kYqf34J0Z/W1uj8GNdo
	VjeGKDM7Hfvm5ewYlLdqtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732699467; x=
	1732785867; bh=I2q8higSoAsXrK+ORJjyrezeGuPRwM6HutWusgI2DmM=; b=O
	X3hhxRXC6X1ZY7ocNU8J4S5OE3TCJcjXN+HfSbpDeD2DHwIpC4wdnNVR9tFkYKY/
	LAOqjcDpsrQhAVBbBgLYpUcaeNN6CaHCv4g05o57Gq/Nah9PpsJ2okCaMiaWWODt
	g1NPGoD5rAytWMx4emEZBNuWyL9l/3zUqZBFDC5Dre4x+5vjuLBXn33/r4oK1V8D
	/w8PLWIroiYWkjB37VTiewI3mkVm6TukMCme6J8et8Q9oLQxGtc0sKdewXkDgrzW
	xxFOo0KQuk14CRADfqOWqw9PuFsPTvqLz8l88Wd0gL8sNcNgZh7hn6AwiV3xFoek
	Bmo8OVWhJZ3dJQ1163+nA==
X-ME-Sender: <xms:S-VGZ0C8RC3qegMSNT4W7ify59qhGOZfMQGRlIBt8m7FgEYiKeQzfdc>
    <xme:S-VGZ2jDW1rK4CHSj-B7TAs-HWagheQT_J52qUE1SnapVLvTexXqwWjgWIgj6TNOJ
    bHQcjkwq2f6vZ12zQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeelgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrght
    thgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveejgfeigfefke
    dugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspg
    hrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhi
    khdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvg
    htpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehm
    vgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:S-VGZ3n74TV0czLQoewYGlqVdFXB1AY95bfqAvgqt2gX-hwvOGIAjg>
    <xmx:S-VGZ6w0lv_nw4JB6WqH7KOLdLTlcuygfIpZTpGXmRbn1ThZgloO0Q>
    <xmx:S-VGZ5S5GrntY-3CZB3TbE7SWMdbjdGsJsQDi2eluO4cC99ZoTjo3g>
    <xmx:S-VGZ1aYcsAmyLWQUAnPM5vrmlery4Zi-hU2xJ7Z_9XdVhJaTq9JWA>
    <xmx:S-VGZ3PhDT_IWcImarSEudR_l6apUCHcBpBwR8s_8Btr__fEZFHnmEu4>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 07707780068; Wed, 27 Nov 2024 04:24:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 27 Nov 2024 10:24:04 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Karthik Nayak" <karthik.188@gmail.com>
Cc: git@vger.kernel.org, "Taylor Blau" <me@ttaylorr.com>,
 "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>
Message-Id: <9ca6bb8a-6597-400f-860f-3546296c441d@app.fastmail.com>
In-Reply-To: 
 <d1fdd6996a6ee94534905fd993f3472ad318611d.1732618495.git.karthik.188@gmail.com>
References: <cover.1732618495.git.karthik.188@gmail.com>
 <d1fdd6996a6ee94534905fd993f3472ad318611d.1732618495.git.karthik.188@gmail.com>
Subject: Re: [PATCH v9 01/10] packfile: add repository to struct `packed_git`
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024, at 11:57, Karthik Nayak wrote:
> We do need to consider that a pack file could be part of the alternates
> of a repository, but considering that we only have one repository stru=
ct
> and also that we currently anyways use 'the_repository'. We should be
> OK with this change.

The =E2=80=9Cbut considering=E2=80=9D needs for a conclusion to come in =
the same
sentence.  But it seems that the conclusion has been put off to the next
sentence: =E2=80=9CWe should be OK with this change=E2=80=9D.  That does=
n=E2=80=99t read right
to me.

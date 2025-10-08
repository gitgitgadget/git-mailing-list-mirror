Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F151C1A3166
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759940116; cv=none; b=sI8uxssgduB/pt1njgiPB248N+3cBduLWDspt6nFzd6HTbYnDgySlZaXR5hPtnRvkCrh1B25IOGsIfHtrKMdWsGE+IGn4RS7miSPN7ZdHl6SM5BDzPHnaCL2ZctqDagtfupTCf4Ji+1tybpK/mZa0dgDge/BpyNcnRVSlMqhNIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759940116; c=relaxed/simple;
	bh=jn7ujGaN9G1OByZbS6Gi/iyBMkC9dL6rFApMvf15r9U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=R+fcEGwbjUnnWXslmYrpvsa8reANstt8/j4dpGXG0X27CphuUZoxvWVAUxZ/NHSZTA3UJ+I9Pi29/p6sK7U3Ca7OMqFO7W/ly7McvsnOxgym+kUDRxx2uSxmsBFSGmJAMbse853h+ZO38RXe104oEy3fyoexY6xu7RUz8bxWrGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=StvDpdoU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xf9Img9F; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="StvDpdoU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xf9Img9F"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 04DE9140023E;
	Wed,  8 Oct 2025 12:15:14 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 08 Oct 2025 12:15:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759940114;
	 x=1760026514; bh=J6V3sMiqdjf6cxv3gmNAHv8qe42v9wcSgaMBh4qHEIc=; b=
	StvDpdoU3OQLYZ1nchr2REnTlQvJUVcXa1lZulIRPfW+ZB1W/2CGYbDXF/6AM4NX
	OLCUgHhp7Wx6FOwivXApyf7efgYTxbQ1/aQkLx3J6E0PDZe81gkoziP2O0/Al1tL
	FrRTmNvBL5/E7QZI2gha0KEEDmhJ4VRUnNDDek1mk08O8niP2tBRjmtkRjSmpayA
	MUCkqyT9A95NB/gFGX7vC4S7I01aoTwTDbKQroxVbB8wMh51+ozh3Dk23liob+mI
	F6vNcFCr9HaiIqCkmmJ4orZ4aXeLicUktl6dLH5g8EeQk1o1+kPwwXGhepbXr/os
	GPo4SnhU2t9Jvp1sW9m63w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759940114; x=
	1760026514; bh=J6V3sMiqdjf6cxv3gmNAHv8qe42v9wcSgaMBh4qHEIc=; b=x
	f9Img9FSt6kecj0cd7WvXo05V+TlmrQkdPOG4Lg7VM+Zh+gAxs3qQWhC54DuyIbW
	rGqrKZyfX8GMd9Zfg+9QuHEQ5MU4DI7+kJ8O6Uk+2DtlQmInibOLQrQp9xy5s6H1
	9HsaXu2rX/YtEFkc74CLYzW8/oGNbnQ3IZ/x4lHdWzYq2R+bgFdppH4+IGN0AoUM
	R0Jf/T34BrEi7xwRN5x7XuQCESRw6byKiweu/dakfhZXL4X6ewP0B6Jq9IxTHlF0
	RIsna+uA3s/sVbhwZ1LiFLgbg2EbTk+VqtShzyZN8hL6qWjBZi+nu6EJYdCBfbct
	Lq5OBpjMxYk3Y/8VA7+2A==
X-ME-Sender: <xms:EY7maJMWreG3b5sAanMJBm4fyD-Q1vvxir1oc0YpcF5tgYrOEajbKXo>
    <xme:EY7maGyCDb4l2ezxzfZ8fOBXWiKtmq1hNHnG-SN_FgDqSnZDVL1EOBR4px4sLD7P6
    NTOw4Dt6W2DhqvDc026EEQixBtpAqaA4OhYSiB0SkCUYaLDXLDMbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephedugfevgfef
    gfffvdfhffdvveevgeehhedutedvgfeuffejveejudegveefvdefnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:EY7maI1mNWMVWEGpxZmJB_-qndGhTRYwy9TenteI4yrSLkWVGHOboQ>
    <xmx:EY7maA5m--BhIxqobWB1Vczw0I3i2SvmJId_5O4Ex8Wt71AyPfZcKQ>
    <xmx:EY7maLU95I6NEsfd9upsv6NJTk6nb9sHqdHn1c013oSCQ6ekSKU_qA>
    <xmx:EY7maPAxEQ5lDIXvoPmb6C7iOGbEFai1G5sSZjzA7IQ1uXmuPaExig>
    <xmx:EY7maHNsXktRoCy8QIHs5lip3CNNMfFpSyQN7u_JAhtTFLwBfBnNisZw>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 902781EA0062; Wed,  8 Oct 2025 12:15:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AtAKOKhqNxG3
Date: Wed, 08 Oct 2025 18:14:42 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Taylor Blau" <me@ttaylorr.com>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>, "Elijah Newren" <newren@gmail.com>
Message-Id: <85dbe67e-f252-4548-910d-4af29939806a@app.fastmail.com>
In-Reply-To: 
 <d7931dcc4380757cfd4c6f24b5d746da2294f40b.1759873165.git.me@ttaylorr.com>
References: <cover.1759873165.git.me@ttaylorr.com>
 <d7931dcc4380757cfd4c6f24b5d746da2294f40b.1759873165.git.me@ttaylorr.com>
Subject: Re: [PATCH 1/2] SubmittingPatches: extend release-notes experiment to topic
 names
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025, at 23:39, Taylor Blau wrote:
> In d255105c99 (SubmittingPatches: release-notes entry experiment,
> 2024-03-25), we began an experiment to have contributors suggest a top=
ic
> description to appear in our RelNotes and "What's cooking?" reports.
> Extend that experiment to also welcome suggested topic branch names in
> addition to descriptions.

This is a nice idea for keeping track of the upstream topic.

>[snip]
> diff --git a/Documentation/SubmittingPatches b/Documentation/Submittin=
gPatches
> index 86ca7f6a78a..f48688e3700 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -579,14 +579,19 @@ line via `git format-patch --notes`.
>  [[the-topic-summary]]
>  *This is EXPERIMENTAL*.
>
> -When sending a topic, you can propose a one-paragraph summary that
> -should appear in the "What's cooking" report when it is picked up to
> -explain the topic.  If you choose to do so, please write a 2-5 line
> -paragraph that will fit well in our release notes (see many bulleted
> -entries in the Documentation/RelNotes/* files for examples), and make
> -it the first paragraph of the cover letter.  For a single-patch
> -series, use the space between the three-dash line and the diffstat, as
> -described earlier.
> +When sending a topic, you can optionally propose a topic name and/or a
> +one-paragraph summary that should appear in the "What's cooking"
> +report when it is picked up to explain the topic.  If you choose to do
> +so, please write a 2-5 line paragraph that will fit well in our
> +release notes (see many bulleted entries in the
> +Documentation/RelNotes/* files for examples), and make it the first
> +(or second, if including a suggested topic name) paragraph of the
> +cover letter.  If suggesting a topic name, use the format
> +"XX/your-topic-name", where "XX" is a stand-in for the primary
> +author's initials, and "your-topic-name" is a brief, dash-delimited

Is there a precedent for =E2=80=9Cprimary=E2=80=9D author? Why not just =
=E2=80=9Cauthor=E2=80=9D?

This seems to be referring to the fact that patches might have
co-authors (trailers) and similar, or that it could be sent from someone
else but the author, but I don=E2=80=99t think this adjective makes it c=
lear
that the topic name should stick to the author (in the Git model=E2=80=99s
sense) name only.

> +description of what your topic does.  For a single-patch series, use
> +the space between the three-dash line and the diffstat, as described
> +earlier.
>
>  [[attachment]]
>  Do not attach the patch as a MIME attachment, compressed or not.
> --
> 2.51.0.435.gf7a65e208c7

I like the format in the cover letter:

     * tb/submitting-patches

       Extend the experimental protocol used by contributors to propose a
       topic branch name in addition to a description, and describe how =
to
       name multi-series efforts.

     ---

Everything is nicely *delimited* so to speak.

But it was noted[1] that the-topic-summary doesn=E2=80=99t seem to have =
been
used much. That=E2=80=99s not surprising given that the instruction makes
the-topic-summary blend in with the rest of the cover letter and doesn=E2=
=80=99t
signal that the author intends for the first paragraph to be used as
such. This patch shares the same problem.

I think it would be nice to distinguish these things with some initial
paragraph text.  In the case of the-topic-summary:

    1. Start a paragraph with `Topic summary:`
    2. Then continue the paragraph with an explanation that would fit we=
ll
       in our release notes (see many bulleted entries in the
       Documentation/RelNotes/* files for examples). Aim for 2-5 lines.

In the case of topic-name:

    - Add a paragraph with `Topic name: XX/your-topic-name` where XX is
      the author's initials.

Then it might be possible to drop =E2=80=9Cat the start of=E2=80=9D *if*=
 the aim of that
part is to be able to pick up the intended paragraphs reliably. (Maybe
the intent is for the maintainer to be able to read the cover letter in
a predictable order.)

=F0=9F=94=97 1: https://lore.kernel.org/git/xmqqv7kqgs4x.fsf@gitster.g/

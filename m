Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ED92701BB
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 19:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767641031; cv=none; b=hlcGTq5Zn4/owVKeEWQnD7KntUXJBSaMmUYy4pe1vurpT0uh1xKr20kwS4nAYl09Vq4FFto0jER+YOqyDQlKKixR79uRgYiYhWof/8XaPteQwZwCXwUBTXj6t0jOl5vgCqERaQLZ1nEqrkqodKaBG/1wzJUzLtikoYstHt7S1GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767641031; c=relaxed/simple;
	bh=rODsNAHL8e61XqgOSLRtJ1SSN/EIhI766PSHGZSyjso=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OLJrDWeIIp8YzAzH68bwomUfpJFmRN6mQGEl/PDqF4GWgA9o4Hvteren/mPFucbrd59IeHG+3U7MzhQKgvTuIwssx8uAdd9u7d+UiwGcUXXhEaqCuXWeEalyRukMf5FG36o8WS27ZLuFJbouas2KxShWAyVuKUVSvsOr5k1g+CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=jFFGkRS8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gFvwlvlQ; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="jFFGkRS8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gFvwlvlQ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0C8327A0086;
	Mon,  5 Jan 2026 14:23:48 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 05 Jan 2026 14:23:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767641027;
	 x=1767727427; bh=rODsNAHL8e61XqgOSLRtJ1SSN/EIhI766PSHGZSyjso=; b=
	jFFGkRS8Mib02cq7FXB5rKC8vhlxzzSfpj3MsX23nB3RNNycMI8ylN2VWZ5GGkvs
	dlIpqi2d/CTlkJuSysXF9VTSpRAgOrxwNI3XeG37ko/9Vz1EKfWC7SpTVupmZYsW
	hb235wda0A4ffIJow42aFX/lvnp07kdnqH35SdVGhFv+0sb4E2JmGJoNAXfOZLOC
	3ALgbjjFuPoU8BXgP6zBfl+7Ui4NqpRh8aR1DkGrOEzuG7i16yI+IYDDpoya8d+p
	+9DH5QeWQ1b1Spe+TSQ8Lc3WmkZGA/jiYFwtavskUO7zuNMk68LL+urdrN11YYo9
	24cWeLXkmpi8nossK6C1qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1767641027; x=1767727427; bh=r
	ODsNAHL8e61XqgOSLRtJ1SSN/EIhI766PSHGZSyjso=; b=gFvwlvlQhN9hhwVGJ
	2IOQr27u1aq8A7FpbGRUxmrXp5k90A/k708FTooZVFo6Nk3QWapaFuXmYTJOtKLo
	mfpEtE88xY6TVkMK0Q/i4ESArgwotfbN0sqTgKvj+6Xm1OzBytIEwOBXlxsy8awS
	Iwl+LNpnorw4ewa4BkE/opL1Cmk1szxq8ETfONO76LImlu1i0I5NyCnXnDjEQidp
	Svl0kW0GJD5G5l7CwJoHk09NSwFdp0zxA5SOFRNl9E8T2lgiVAzb2M1no4f6ly2H
	68Lj3V6a8zL0euUjFxt2dEjdFcrk46+ZFpzQyOqIo7xGjB1emCbrcfM8ZN7WBT/z
	jqN5w==
X-ME-Sender: <xms:ww9cacvqVoP6aiOZrNMBRhVloajoAG4edQ5Hqx1jzUyS_hlQJZGFpXg>
    <xme:ww9caUQup1von-gs2dAnqmjIYhrOsvCa-WtAZnKsZzaeoohW5LnYNydZQR04UxDQR
    x41exPdesVvvFndBvYeOZ-jJv3DMqQK8fUMWYUBXipqo8x85BAp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelkedufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthho
    fhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdfgffettedulefh
    feekheetgfegfeejveeikeeffeeikeekhfevieeltdekgfeunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopeifrhhofigtlhhifhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ww9cabaaLYaGVp4OZnF9r-tO5l90kXivxy78khLc9IYY0dIVVUojPQ>
    <xmx:ww9caYWsDLbYga97SPs8Sce8lO6CNFcKdvdKmI6SCCTIAn31UGN_sA>
    <xmx:ww9caVhwxzD_gyBFPKC2MgmE04YYXW7bPK8dkkjwXYZlGIFVkwx1Eg>
    <xmx:ww9caeXQkXKwcJYcGPDhoEqWNxhkJsZm71GaByye9JJK05C37wW-0Q>
    <xmx:ww9caZDrJ7G0Simz_Xgn7_tbNjnabclnjSbttXQvKuNwS3yWuqw94vpE>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B2C491EA0066; Mon,  5 Jan 2026 14:23:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AVsxfiaMTaNs
Date: Mon, 05 Jan 2026 20:23:26 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Wayne Rowcliffe" <wrowclif@gmail.com>, git@vger.kernel.org
Message-Id: <1ee133df-2bb0-4aaa-b628-e7e2655d4332@app.fastmail.com>
In-Reply-To: 
 <CANG6c1XhaL1poT2Myo2sy4xbu86vAXO0xQKe33vg7pERmx=TbA@mail.gmail.com>
References: 
 <CANG6c1XhaL1poT2Myo2sy4xbu86vAXO0xQKe33vg7pERmx=TbA@mail.gmail.com>
Subject: Re: I still use git whatchanged
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026, at 19:05, Wayne Rowcliffe wrote:
> I tried using git whatchanged, which I use probably daily, and it said
> I needed to send you an email that I use it.
>
> It's very handy for figuring out what files changed in a commit.

This command is being removed because it was supplanted by git-log(1) a
long while ago. Both commands use the same machinery, just with
different defaults.

You can replace it with `git log` in this way:

=E2=80=A2 Given: `git whatchanged <opts>`
=E2=80=A2 Replace with: `git log <opts> --no-merges --raw`

Additionally for the sake of readability, you might have more
use for `--stat` or `--name-only` rather than `--raw` if you are only
reading the output (not feding the output to another program).

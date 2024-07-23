Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19DA13B599
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 15:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721747259; cv=none; b=dTQ7NHzUOetW9cQZLzu7KQBVM35I5OF6Vas05D/UbuuLpTDL985Y+C5CtaPrxo2UvtdkIgjC8/Drc7BaozZnlwiEVIySPzcu6E2RGBdnkO9FOWcXEx+WEllIAuxSFD0hwmgbFn0MG0t/fk9HIm0szvNp5ZI9ILZqDcmbgWo3Z6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721747259; c=relaxed/simple;
	bh=XywsUoqkZnbz8+vy4qSTKywKS5b1M1CQc7YUaTsYIOM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EuXG3cw+IGGysBnvajuMHBqrNOIngOVkr2SWzjexs+ZFTDjpJGRupBm2DkEBLCe+SeLluxQ3W8FDAvId363g0OryQOFioU7C6P+NXRS4vCYtXz4YuWeOkz3oizIiAymyMPQh6SDYEQuY7P7jbukbtLc+ugTepjnh1oOb4tAtWvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dwim.me; spf=pass smtp.mailfrom=dwim.me; dkim=pass (2048-bit key) header.d=dwim.me header.i=@dwim.me header.b=UEvUsXD0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TxrhcjxI; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dwim.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dwim.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dwim.me header.i=@dwim.me header.b="UEvUsXD0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TxrhcjxI"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 82B0311400B3;
	Tue, 23 Jul 2024 11:07:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Tue, 23 Jul 2024 11:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dwim.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1721747255;
	 x=1721833655; bh=cyJ7rp8TOe6oWsOQx2x5sq5vCQCTBaVAHpjP1d2F0b4=; b=
	UEvUsXD0thYuEfFsSTkl+1GLUEl9cTH7xZ59GbLn9mzEVIEAscbqp5E97HRZn7ng
	aIsKbKJluUCr59N/08TRpPalgi2BY9J4yWfRMDyXbTyV//Y/FySBSPiJCyv88f1X
	JKvQdOW5E6RiES966BXC/qxPGS49ukEM+mVl0XNmrHLYrHTo/AmNEdSbq7E3W1W7
	/6LeuhNSWUWLOAtt23nFIHN88zRr/LqxrgM6DaFcUo2alD5pP7KBR1Quzi3yv2Np
	w5Pr7uN2p+P5f0GtEQbNOpj12cLW4YbuzKCBpCjdRCp5HpK4mp5RCmf3QXR2yRRv
	aP/PE7mq9esZJZSXCumzDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1721747255; x=
	1721833655; bh=cyJ7rp8TOe6oWsOQx2x5sq5vCQCTBaVAHpjP1d2F0b4=; b=T
	xrhcjxIxVxtUx8KF1lfaZy6jYy2Y+oOcQdWGpxoij7e51XJR48unzSdHTBk/60o0
	0kFg3dJZczFxnyn+drXLDY3Mt683f36UiAlPc7gIt+N5Kh3YpoFg5cOYx6797N2U
	DS4s6z5VDp+HiOIyWvkW9swkUON6bDOZlIOOpYT5GXdLquXAJR92hkdzWGHCWiOj
	WR4GCqKJ82R4oGBkHNDOJmIGZbbszBw2QvAQzViapE9a3bCypYDJw2cf8oJJb8jJ
	5pRyeNTiltyh5xFdhKjXtiqgzf3xdS2Z8iPq/aGTc75HBNelDn7YFunH0IkOTqo3
	7Xwz6eJWB5c+tS1mj1fNA==
X-ME-Sender: <xms:N8efZmtZNrjbsemmLiqKjSZMv7NiDHrbcp4ZAg2-aVfVZB9MDeBTTg>
    <xme:N8efZrdQFMSvaJ5NkFJshyUrsuNq_0hwLX1L2l6NPqZlYoOFRJ9v9ldpmq_-PheY9
    NcQsrQZNiR4I1Vjmg>
X-ME-Received: <xmr:N8efZhwgP8_j2jgbznHRGu_Zg4qPrXDCm4JqN_gUofK2KunVTrgxVFc2vd84dAeaMVo6s3rWsDH3S82iu47EWdat88Axv03T4GABdOt3yAhj4RQwIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheelgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepkffuhffvveffjghftgfgfgggsehtqh
    ertddtreejnecuhfhrohhmpeevrghrlhhoshcuofgrrhhtvohnucfpihgvthhouceotghm
    nhesugifihhmrdhmvgeqnecuggftrfgrthhtvghrnhepleetgfektddugedtveevleekgf
    elkeejheelleeijeeiffejueefvedtgfelleegnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheptghmnhesugifihhmrdhmvgdpnhgspghrtghpth
    htoheptd
X-ME-Proxy: <xmx:N8efZhNAbRu0O-cUJDoCXYfm5LqEDmQqjFMZzkr9RcUPFQWl0lghfQ>
    <xmx:N8efZm8e3ZyQF4xUdjFaMLqXkjtoD-g7EDUKvTgSENHNchs7olLCaw>
    <xmx:N8efZpVLuETHrXYYyxcGDEKhKRbdReE_B8vkPIYQNCrCk5T3Prf73A>
    <xmx:N8efZvedWSzazIxyZSg5W8JIhZBheFdZWHbQymphrYEvxhrqRsBSVw>
    <xmx:N8efZoLqPaIQxLaUUSN4XGk7_dBuFooAeaWT7zNTZJ5kJiyMKKdsmqjf>
Feedback-ID: ifc4b4307:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jul 2024 11:07:34 -0400 (EDT)
Message-ID: <520d3ed0d5822e1587d28c25c7843214f15573fb.camel@dwim.me>
Subject: Re: [PATCH 4/4] remote-curl: read in the push report even if we
 fail to finish sending data
From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@dwim.me>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Date: Tue, 23 Jul 2024 17:07:31 +0200
In-Reply-To: <20240613095542.GA817573@coredump.intra.peff.net>
References: <20240612115028.1169183-1-cmn@dwim.me>
	 <20240612115028.1169183-5-cmn@dwim.me>
	 <20240613095542.GA817573@coredump.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-1 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-13 at 05:55 -0400, Jeff King wrote:
> On Wed, Jun 12, 2024 at 01:50:28PM +0200, Carlos Mart=C3=ADn Nieto wrote:
>=20
> > If we just consume send-pack's output and don't send anything to
> > remote-helper, it will not update any of its structures and will report
> > "Everything up-to-date" next to the error message.
>=20
> OK, consuming the output at the helper level makes some sense to me.
> But...
>=20
> > diff --git a/remote-curl.c b/remote-curl.c
> > index 0b6d7815fdd..9e45e14afec 100644
> > --- a/remote-curl.c
> > +++ b/remote-curl.c
> > @@ -1114,15 +1114,25 @@ static int rpc_service(struct rpc_state *rpc, s=
truct discovery *heads,
> > =C2=A0
> > =C2=A0	close(client.in);
> > =C2=A0	client.in =3D -1;
> > -	if (!err) {
> > -		strbuf_read(rpc_result, client.out, 0);
> > -	} else {
> > -		char buf[4096];
> > -		for (;;)
> > -			if (xread(client.out, buf, sizeof(buf)) <=3D 0)
> > -				break;
> > +
> > +	/*
> > +	 * If we encountered an error, we might still get a report. Consume t=
he
> > +	 * rest of the packfile and an extra flush and then we can copy
> > +	 * over the report the same way as in the success case.
> > +	 */
> > +	if (err) {
> > +		int n;
> > +		do {
> > +			n =3D packet_read(rpc->out, rpc->buf, rpc->alloc, 0);
> > +		} while (n > 0);
> > +
> > +		/* Read the final flush separating the payload from the report */
> > +		packet_read(rpc->out, rpc->buf, rpc->alloc, 0);
> > =C2=A0	}
>=20
> Isn't this existing code already trying to read everything? I think
> rpc->out and client.out are synonyms.

The existing code will read to EOF if we saw an error, ignoring
anything including any reports.

>=20
> So now instead of reading to EOF, we are reading some set number of
> packets. This function is used for both fetches and pushes, isn't it? Is
> the expected number of packets the same for both? What about
> stateless-connect mode?
>=20
> > +	/* Copy the report of successes/failures */
> > +	strbuf_read(rpc_result, client.out, 0);
>=20
> OK, so this is where we read the result. Which again, only makes sense
> for send-pack. And in theory we've synchronized the protocol through the

The existing code already tries to read the report regardless of
pushing or fetch in the non-err case.

> packet reads above (are we sure that we always enter the read loop above
> from a predictable synchronization point in the protocol, given that we
> saw an error?).

That's what the loop is trying to do. It reads the rest of the
packfile, and it's trying to get to the flush at the end. This is what
the while loop above does, that copies between packet_read and
post_rpc. Given that send-pack is still sending the rest of the
packfile, it should be the same as if we had been sending the data over
the network.

It doesn't quite work which is why there's an extra read there but I
take your point that I forgot that we also run fetches through this so
it's probably going to be more complicated anyway.

>=20
> What if send-pack doesn't send us anything useful (e.g., it hangs up
> without sending the report). Shouldn't we take the presence of "err"
> being non-zero as an indication that things are not well, even if we
> never get to the send-pack report?

In this case err is non-zero because we got a non-200 HTTP response, if
I followed the code correctly, so it does mean there was an error, and
it's true that we don't necessarily know why with just that variable.


It's still nicer if we can try to get more data out of send-pack (and
fetch-pack if it does have more information there), but yes this code
isn't quite it.

I might just step back on this a bit and split my fixes here as a
change to make send-pack return an error message should just need a
change to still forward non-2xx responses if the server claims it to be
the Git protocol. That still shows the error message from the server
even if we provide the "Everything up-to-date" message as well.

Cheers,
   cmn

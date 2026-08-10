Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399083EC82E
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 14:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371208; cv=none; b=KJwITXmBdZlrQT+ck97lymb8taDuqrAKYSwTu8JZlR7SYpDdA0wFOMccPBJsCt7y2DiQrlNRLrT/JOuevF/dfQjJ95OEDbxnpQSoJgS1uucoxi1+t8MjxyX+FoIDvsP1azcQK0g+A4FRF8/OYdseq82aNs3myxTxbvcZ67i4R+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371208; c=relaxed/simple;
	bh=82ogir5vVCFIl0GvE1GgEvBFkmggUYZ7527WQYWTm0E=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lH3PZjg8GoX45TV/fB9yXOTNUmZa+FzojtgIX0m9Gk8OccmUPQqHUC8ZgbJNXQqQBxFotWB7q1zqWKu7i83Z2ZxuSW9YULnoVKMHAqSlnmA9eHn+GDYCDCWrk5XvzrKksB8PikZdVpLj7YiyqLPbyPC5AlysUhTPCBZOnYMpx3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=INWt60eP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TlGtfyj8; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="INWt60eP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TlGtfyj8"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id 62DC9EC0143;
	Mon, 10 Aug 2026 10:13:24 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Mon, 10 Aug 2026 10:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786371203;
	 x=1786457603; bh=82ogir5vVCFIl0GvE1GgEvBFkmggUYZ7527WQYWTm0E=; b=
	INWt60ePmpF1dkt4bXg9GB5gyDkVm5Ntzc+HoILi9su+zTv+B+n0faPseVeBguHQ
	P5/9WTQG0tkpZx7Fi4Mj0Pz3ZDfJVnr4YRCMvhKxx2NeKx+JfOLLVzlPIBSJhypX
	cjM1LpLvm3wfb5cHiv+rwXmIorxGwqnmN8uBPKz6jl79Bf2Z3DAkkivTQIR460Fw
	xlydB3l3rI+xSMtuOVpHD7zGdXVHw0ECk7Wc5Blr/HuzhF68ZwyS5vdknAH8N8uq
	WpHt2e9fw9zhgLXI5rL/Qr6vQ55KiQR8GEukpJWVrE6DoYYeXBjImPlcf9jbWpaE
	imNnFhywSgYO9GWYnsnstg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786371203; x=
	1786457603; bh=82ogir5vVCFIl0GvE1GgEvBFkmggUYZ7527WQYWTm0E=; b=T
	lGtfyj8tZCEhPT+zi37gTcGkNV7efGqDKv2hVTAlEMxzr0MJVBOIQ6aNo2bnjFph
	ir7LH1hMl3y4XcKug4jVP6mWtaQEyS0lik3KJQan7l8wOy2H6vkzZqLzaWhVRbTn
	unA2MA1OQsUqfJUz3byw9epabTCCPPTizHTcNY8svhIfeW2tFu4Nzh31pqFZ0BlI
	g1OYB1F5aD10kDi89rsNKDmziZ4kxpfCaoXGWyjxlnyHmUQ47FTLxQTrxo8yt96v
	5wr//CpzqDgdAZAgaHiD+XUF0Tl0Y3ny8h9lxArdBgJudhvQAMeeYdBk5gJui83T
	4pagyehhfnaI8fkp6cXhA==
X-ME-Sender: <xms:f9x5ajrL5qWozbzJXYJipxHPo0HoGqtO7abgs3VBGN_-dn2AfQEcJ_A>
    <xme:f9x5aod34X7sMf8hosxd5Ur7nNQwJBarH1HTMiGbA8cw_JEt2Mm-iKXnyt_qGYmqa
    Pnj6aoDroDZElYiAHmw1NKzDegVo5jzSvOHn4YvRa5Ibo5TNU7rzg>
X-ME-Proxy-Cause: dmFkZTGp2vBCLvMfc0quK0Xx98kgXsxZdpk0ZEUgrKr0YqafRYvJPzSktGlvAukS2pf3X6
    LwsZhC4FrwHtXMyZRigREUEaRPRrWfk4ksFQi48Rtcn3PFNlZqTJ2IRbYGllcKMO/tzAUj
    eynlWyALyTdpEyVhhO6Eu3C/dMuMPmZRzVagpmQiESJf0Ri/zRIY1F+SSdx0BYQ2FPbBAh
    7UAxiV7akOZtPXCLhjbabNW8716LjejvvugOSoca7QbAcTYZA6FJeQSTtyx5k8mF8zIl7x
    bDP8+9P6LRYOjLMhGm3MGSYDpuDy+Ivg/jVGUIfr3shbh9YNRjLnbTevgnnf8NkkDVvKGp
    buPEi7T9JN+WpFmL9J9f5kdcxX5PmNqblXzhkt/5D7e8xSubQnzuNGYAfcVjAuSGUl+fJ3
    yXIjI1Vve23u5z0gGmY75Og2wWqkgFtYJFSgfUGVYUBpV0HRUygdQduQ7Agr7gxOObiRo7
    iQL5vUz0UFMZb5p3D2f2LjRiUXrUPM51bjtUD8TNBS8/gzIf64rY83/o3h0tG+/Cm3gWnr
    paGFjHWUQuSpdvYtoF0QUlFPVcXtw+GpVnk01NXQSEbn01zgxSEbM1gpGlO952+PdnhQLW
    V2OcvrG3XgYjbDUxo9KF6lQ9s4D2cQ7C/XrLOq5Mv6aQzyfKoBUNCu1hrTsQ
X-ME-Proxy: <xmx:gdx5an-WiebuWrUboNMsjSxDH4zrd9qoZgqyxJVOtfhQfXUruzMl5A>
    <xmx:gdx5attLyBnvHmrtBInn4Fb5BKouah-uqiHsx80kHNh1k3SwnDL1aQ>
    <xmx:gdx5arqcke5xJ_IS7Keyc4t-zw1_j3tJJqv873UxLYQy_sC66cosQA>
    <xmx:gdx5ahrV_g6qYkCvnoAXNhsFg6LANhy16eLHM_NO1YRQeHVfv7p7Ow>
    <xmx:g9x5akbDUp5Zk1i-_Xs71vWlihFQgwQnzhG5YBTQqD0AkkLf4nXXKN2F>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 71D1E22C006F; Mon, 10 Aug 2026 10:13:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 10 Aug 2026 16:12:59 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 "Christian Couder" <christian.couder@gmail.com>,
 "Brendan Jackman" <bhenryj0117@gmail.com>, "Linus Arver" <linus@ucla.edu>,
 "Matt Hunter" <m@lfurio.us>, "Junio C Hamano" <gitster@pobox.com>
Message-Id: <707ccba1-22bc-4673-9536-7110a96ae05b@app.fastmail.com>
In-Reply-To: <0687D60D-DF6B-4547-868C-FCFC5B27ECAF@gmail.com>
References: <V5_CV_doc_int-tr_key_format.b26@msgid.xyz>
 <0687D60D-DF6B-4547-868C-FCFC5B27ECAF@gmail.com>
Subject: Re: [PATCH v5 00/11] doc: interpret-trailers: explain key format
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026, at 13:16, Ben Knoble wrote:
>> Le 9 ao=C3=BBt 2026 =C3=A0 16:07, kristofferhaugsbakk@fastmail.com a =
=C3=A9crit :
>>[snip]
> I=E2=80=99m trivially satisfied with the range-diff (note again I=E2=80=
=99ve reviewed=20
> primarily the end result, not the per-commit history).

Thank you for the review and for sticking
with this series.

Kris

sent from mobile

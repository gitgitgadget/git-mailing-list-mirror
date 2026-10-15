Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65F3380FEA
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 18:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792089787; cv=none; b=QoZi1Rbyw/peLZ+2sShlaKXX+Hqa/5/LE4Cl5Dq5vTslHYWx6wuknpFKWVt++amaPVPa0WhiUbole95pD+ZgiG0tyoLJ3ColY26RAslWD3fLdX+QEtDZm2xTEIzeRFcVXBlaA4zuhWNzmd8sYSy5Ou8fWe6uR4Oyg6GbllI4AX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792089787; c=relaxed/simple;
	bh=vchulz360xqRyTbCJLlsUnXGH0mUTdMBz8UxWl0u/Gc=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dA2959+SYnrjYBPCYabWNJbBMd4DocGCHnKVDRnZXm0Z0+OuhfStWsJcZonHROx0UiZe61nWMGnbWNYOzKtcbloNSL8A73xYlZD4rlQwkE33qzeNJ1ibSYXDBXi5JBKKu0H/Ye/UkgY0ub0SymgpimRyD20wgib+Ywip6VNpRLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=f6k1KSNa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KPe8JdcF; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="f6k1KSNa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KPe8JdcF"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id 979581D0014B
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 14:43:03 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Thu, 15 Oct 2026 14:43:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792089782;
	 x=1792176182; bh=KBdjruLDH7AGZGXN9oVW8GclKy/5zcszR+G1LJz+ACI=; b=
	f6k1KSNa4Fe10Bs2hacmL+AaHmKxrZ2f9m5AMOcvvknEVGgq3cAEChNnDdQOCSku
	r9YMPteUTaSaqkZGqTI187LM7uR9NVLSWJnc7n7/WW1rI8M+EDtq5bgdyyZJD3rZ
	jZL+YK9WA57cGO35ADVS5l291q6btIXc2BU4l+y1bDspgsVuCZGZJ0PoZJ61S9lB
	ladpRPK5FUOAWc93BV5dkw3vg4ltTdMkiONA/7zJZnB4ZRD156zUgBhfK58TVK00
	0GMk9lBhU3rIv4U+6EoHPrdRqjmNgXYinsPigeFfqro+LvHJhLxfMAe/gQrRtVIv
	HGDI7bRI2fSHTAz9GtFoFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1792089782; x=1792176182; bh=K
	BdjruLDH7AGZGXN9oVW8GclKy/5zcszR+G1LJz+ACI=; b=KPe8JdcFfMGyA4ucj
	YXhMHEKF5ypn3vvcgT+ChZgONE7Pm7vJWKwUK0CeMcks3OkU5AwSzdGjkIKS+67C
	ZQ5fgjmmqPSclLLu3VPOK8hi7roO0K6XJKEsj/dmd8icsGenl6zY0Cqgx3TxrfBH
	nxI88CPwKi/7K/+GSdNxV7EtWlTdNz35LwULW+zyViaD6VCbasp+8p6ZDY29qDEu
	Myy590m6Ugz6FNXuP7xXIUqcR59CI4ZSlT3wRClPOZkln4ZmpcO8wmL4lldR1Mrl
	VZ6qwg8P/ko/Z29nog4xl3se8jtB0bpGXOr8Xb/O1uXcUHtI/am+rjn99RHVwcsz
	FSdtQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792089782; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Q8MgAJckLAsar7KqHBApPWDtyI65xZnbYmUFfDeYixQSFaF
	trgiYBGpTIzV99i7OMgHlrevLPmj3v8D22kMaGeMfECN8hrtnj4yz0h1OLgmPw5v
	Gc3zINbyb/pg6u8m4iXDTWmmlKnxVU90Hy0+iMGCWSxQ5ZM7DCC6NsGYF1zqhfUH
	oOiWr/dPRflu5u/9eY9i23XVlB0rcX2rJrhOeWLNJtYtqf2TG38kJ++gWMFvLFno
	ot7EegmaCMipU8qpCqyczSVLelD/v6o3EQGI5Nohci1XJbLd1BH7jf3aHgK0Y6cn
	B7RLG180pBoJxVfrKco4L2MKoqT0UybE0NU5NzA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=content-transfer-encoding,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:N7oqN5hbGXh9fT7lwJ07fvnewuXwyOabW+NscWn99As=:vchulz360xqRyTbCJLlsUnXGH0mUTdMBz8UxWl0u/Gc=;
X-ME-Sender: <xms:tR7RalN9UtC-nW0lFWkmYDMMpVwa8MsGk_zizbaDJxo1wGYTykEcOQI>
    <xme:tR7RaizCyi2BHK3ryeNtksGtNFT9XFwkwojwhn-Oxu_kp1fBLObOV1bAJtm2Lsvmn
    7Acpfdnl12XN3dBrFlnCNMpNwCXdsb0adDHY9l5j1SYfyiVvn-5B9g>
X-ME-Proxy-Cause: dmFkZTEyhh/brPhozvEg85aIcvVR+fUy+OH+XUj5v3ieCBbd/INHShsJGqS9OHkszJEYy1
    z60yVMioKIcDsxn8qzBODlFsRPS/HaaEv8ozVArPrwXUJ0LzyhPrRTI3/ND179ooN5t2BR
    4YaJiI/zO+ayLgUdiLFvGYOavsatPFrnPe8Tfsxb2kotR0XyhsyB+b3SVRBKxv95YfY8Zu
    d1PZMBx4G/K77FBb92T0K6n/l2QjeKagVmKceiCnjDankcmBO1OLv07qTguZI0/eNoPex+
    hT6/SPFDlHZOyi5Q6fXP9gOyJFbkWb9lG1O8ogW2QhsAVl/zZwklV5RpKINYHDVcdXtYgX
    PKy+LdWzTUhJis9RFe/mHbeZZkK6z/Xs1Rlvyb3aHwVKeqwlwnyeHlZP1LNOFK0czlen9p
    AOtmXd/n+omIkOcj+Xl39VDqrT13fpSQBv4eCFYtrDlmCXFdtTXMyYu3CU8luGX05oRq99
    idVb+G6h8oe7oP7NXHz4Pac8Md2lAQ1dmvvswOkdA0O+T13NEx2IEe+ySZsqaloa81C/a9
    SyUQbqjiyaP3YfvZQ57MwyahgjZmsOb4Y/8YWJU+e4LaXw4bzth7y5VZAhvJp1vDkjZfaK
    s9yXBGLhL1qzkBWfphgpFLcM4z913BObw0spKPoN/fdG3c8rglFPPyyufjNQ
X-ME-Proxy: <xmx:th7Raj88DsVTmIoxuSEYfF1eHINdUTLEhas8FV2qxpS9ag5SWfCxDg>
    <xmx:th7RavrBuUVTF-2WuaxYHrY3na7n8oOcQwVeym0CzV1k9l6vVgg2OA>
    <xmx:th7Rat4o-9PIX7sd_jC8PvyjRXnarvUZmL28srgo0j-JuxFTBLZWvQ>
    <xmx:th7RanPH-tqbKrEaS-2tnS0BwMAMMjctBnx5bV9wJhsJi9HFiESKHA>
    <xmx:th7RaiRMLxCVyPCEMemu5Oe78G63EWJBVFCpcwEL1I94YRtzO2DzVB-v>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 75F0F22C00A2; Thu, 15 Oct 2026 14:43:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A-pxXllTXubF
Date: Thu, 15 Oct 2026 20:42:36 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: git@vger.kernel.org
Message-Id: <2c1656e2-a054-43c2-94cc-31625f8c69e9@app.fastmail.com>
In-Reply-To: <ce69d94e-7329-449d-b3c3-47d4f3aa608c@app.fastmail.com>
References: <ce69d94e-7329-449d-b3c3-47d4f3aa608c@app.fastmail.com>
Subject: Re: git-diff-tree(1) can already do the important parts of git-format-rev(1)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026, at 12:35, Kristoffer Haugsbakk wrote:
> git-format-rev(1) is an experimental command from Git 2.55.0. It was
> introduced because no command was found for the use case of pretty
> formatting one revision at a time from standard in (stdin). See
> [Discussion] on the doc.
>
> =F0=9F=94=97 Discussion: https://git-scm.com/docs/git-format-rev#_disc=
ussion
>
> But yesterday someone was reading through all of git-rev-list(1). And
> this is one of the examples:
>
>     git rev-list HEAD |
>     git diff-tree --stdin --format=3Dmedium -p
>
> And if one turns on merge display and off patch display.
>
>     git rev-list HEAD |
>     git diff-tree --stdin --format=3Dmedium --no-patch -m
>
> You have =E2=80=9Con-demand pretty formatting=E2=80=9D

But for multiline pretties you need NUL termination. And this is what
`-z` says:

    When --raw, --numstat, --name-only or --name-status has been given,
    do not munge pathnames and use NULs as output field terminators.

    Without this option, pathnames with "unusual" characters are quoted
    as explained for the configuration variable core.quotePath (see
    git-config(1)).

So `-z` only applies to some primitive and name-centric diff
formats. And that=E2=80=99s why my later footnote is wrong:

>[snip]
>
> =E2=80=A0 1: git-format-rev(1) also supports NUL-terminated input in o=
rder to
>      deal with multiline revision expressions.[3] And `-Z` for
>      git-cat-file(1) does that too (both input and output), so the pair
>      git-cat-file(1)/git-diff-tree(1) is equally expressive.
>
>      =F0=9F=94=97 3: https://lore.kernel.org/git/e8bb57a2-8eff-4f72-96=
ca-72d8880901e0@gmail.com/

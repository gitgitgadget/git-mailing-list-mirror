Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44E9239E81
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 07:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759389175; cv=none; b=ld8yK8bGTie+ydR7v2D7k6D4c89vmVGTlFsdKj56+MGTi2e/gdwEspezGPsIje7Z58cGjMa1TBgmcBdL50I2W41C0AxeofBnVd9DeQt6mOAx6S08UZhL/bym7zFlDQ6QOFsyflktskkKSJ7XNYfZocjwCTZhbCswC681oK805AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759389175; c=relaxed/simple;
	bh=JynxwKwn5sgsnXMNnonDG4XPeXWUVsUW/uoKaz7YbEQ=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=K0aURm8eoMoP1sSP5row7ppSBDnW/8hqJqwhOjUnEU/Zpt3eyAeteQIHFJXf0XBdfBGaB2aCxKHE2gqj//vJl0cpiLcmSv0Jmg4vZtjUriZHITFkNI1gldcQsXvRzqjbp+kCZWsu19EPeGrxofbIaA7k2Lq+svdpsULpJqNscAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=pX49hgIf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b6Ch68eU; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="pX49hgIf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b6Ch68eU"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 948E31D007DF;
	Thu,  2 Oct 2025 03:12:52 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 02 Oct 2025 03:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759389172;
	 x=1759475572; bh=JynxwKwn5sgsnXMNnonDG4XPeXWUVsUW/uoKaz7YbEQ=; b=
	pX49hgIfRBUzGP9ya8fctgeEkDRuJqQGbQjW2bA3fFqRaKA13Ox6zeJMT8/T7alR
	arQtYBKALKU2fqo3pm//mfIttQ9+mWKk720rFQaItPAc3EcndZa1o+4ocZV6bfUX
	JHX65253P1n6lJ+sg8VcMaKI/fI2P67NvM8Nj8WqepJqCbT6dTwGYQV0DsFBaETm
	c0aSHiQ44O7I18ok7O5uaWJoLiRpIO/fpjeWEXs5D8UT9m4q9IlUwXapIKkUA9s+
	Yc+aJFwr3KHhnwBn7UwDczYLf7hvCVu8N8VSBb3JUEdORGNY3gUnM+h1BnOcZZNf
	T2PEgSUiHeiJyx3tRG8pqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1759389172; x=1759475572; bh=J
	ynxwKwn5sgsnXMNnonDG4XPeXWUVsUW/uoKaz7YbEQ=; b=b6Ch68eU4bGLVBIMs
	PXmwaJYKy9Pijd5Z5yY/CQRHv7Faxc/bVQQVpRZU1x0n7A0i9bnG7YNpP6JarXtZ
	qCHfMe0PdIoCcZtIyZQB2PI+IBmRdt34/8VibHupiRTU8qq2FnUhFzdYnD5NqEas
	ikZljq77+CNfLypUS83oNo/LFAngMLU+fISeXKeCb2WRSDo1pIyTEq/jJuN2AcDR
	GxNzpeqkCXx6bBb5AF6vYd2BnsVjl2XSXIc15zOtiVUAzkFW1tlZ0d/gNxnZn+io
	4are10egPgVyQsp2P6BI/C8J/qDKEFiJgg3TcGgT0cmBlvdmQ2Qkg6W22M6MywL3
	EtGeA==
X-ME-Sender: <xms:9CXeaM1anviiImSWCYtXcj0hnerVAkbvbFOlycs47IJDMAPGu_9ly_w>
    <xme:9CXeaB6ri3dwVErQziNmafaMKxuOp3cGTVgMqfzRWdYvpX3GLlRtTJwSuUDDQFYvq
    DcnM0hAA4sCpe2SzY4zA_JWRsnZE-T9bCXQR7C0nsMGn3OHE05P>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekheefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthho
    fhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdfgffettedulefh
    feekheetgfegfeejveeikeeffeeikeekhfevieeltdekgfeunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehjihhrihdrsggrshgvkhesrghvvggtohdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:9CXeaDgPGV17tjgpcfbWxSez8gtxWRwu1HRiJWECbUR_yQM8z_Bu9A>
    <xmx:9CXeaN8T0uYzGBA6Fxj2nn2ofWV3qlpUP1phXH9pr1VuxsFBrXLFFw>
    <xmx:9CXeaKpNp6IjwKg0p_2fdC1YffZh-usx-8Bq6L4VU_kc05Gx8XeO4g>
    <xmx:9CXeaM-4UjOupO8m0cRvNDLXk4muDW_inZcMYHIGx16PfDhh0IlgaA>
    <xmx:9CXeaD202ro5cyE2hpNvgrca0F6W-gAAcjSSlRuAgEJ0mMNBp3Pcz-aT>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 262751EA0068; Thu,  2 Oct 2025 03:12:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A8hd7xWeTExg
Date: Thu, 02 Oct 2025 09:12:31 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Ji=C5=99=C3=AD_Ba=C5=A1ek?= <jiri.basek@aveco.com>,
 git@vger.kernel.org
Message-Id: <a1367c80-63ec-4dfc-b02b-cf506d82a202@app.fastmail.com>
In-Reply-To: <003601dc3368$9ac8f9b0$d05aed10$@aveco.com>
References: <003601dc3368$9ac8f9b0$d05aed10$@aveco.com>
Subject: Re: git whatchanged
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Good morning

On Thu, Oct 2, 2025, at 08:48, Ji=C5=99=C3=AD Ba=C5=A1ek wrote:
> I am still using this very convenient command.

This command is being removed because git-log(1) supplanted it over 12
years ago. Both commands use the same machinery, just with different
defaults.

Here=E2=80=99s how you can replace your git-whatcanged(1) use with `git =
log`:

=E2=80=A2 Given: `git whatchanged <opts>`
=E2=80=A2 Replace with: `git log <opts> --no-merges --raw`

Additionally for the sake of readability, you might have more
use for `--stat` or `--name-only` rather than `--raw` if you are only
reading the output (not feeding the output to another program).

--=20
Stoffi

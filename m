Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72B21DA60D
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 01:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791164702; cv=none; b=Y/DlrwrVAzeJRPyniGklIDOgC7rMZimNASASlNMAUOpSpGxpGBDYZtyyWqjST7U2nlGqK8hSWXJZ8rSrVfgpK8aymNRUaeDAxrJuu48//MS/qNx/TaqIccgmk6LBoDi8pVRUnS4POJu/v+AWLGcNkNoQGJWkxtw6SRSZinjJ3II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791164702; c=relaxed/simple;
	bh=O/AYfU22MtEX03DaFxHnRz0AS1hTNyOOlg2avkuOvKQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HXeFM8aOs/rz7lYJLIr7JvGP5Tq9ZgFesJkjCrhswg9CtS+GSg12tkTDIDk7erB/Ogz11b6c/jvTdQTGj+MzGgi8Mw9N6yky1Soh+IuNtgX4y8sZ30Th//2CkkrXMVtQfyD7oNJzIUJW1js+rWEPPKP4gwD0rB9xotXN280iIQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fionn.email; spf=pass smtp.mailfrom=fionn.email; dkim=pass (2048-bit key) header.d=fionn.email header.i=@fionn.email header.b=sSJGd3dk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eio/jxjH; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fionn.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fionn.email
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fionn.email header.i=@fionn.email header.b="sSJGd3dk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eio/jxjH"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9CDDD14000DA
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 21:44:59 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-03.internal (MEProxy); Sun, 04 Oct 2026 21:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fionn.email; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791164699;
	 x=1791251099; bh=O/AYfU22MtEX03DaFxHnRz0AS1hTNyOOlg2avkuOvKQ=; b=
	sSJGd3dkP9i5JBaRl+6sOQrOe6KiSu/nzIrWZbInCq5mYMSGnmSg7fh1hUiHAArR
	JpdK/wC7hFOKLZMaRvEQAEU/jBacwtdbdDg43SpHd1oW1a3fG+QdY5czGorv+0in
	UyIu7Wqv4gVqQJyrRPaxGuq8gLibueIeM3CX0alWCGZa/Rdnob/MmhIKzCpI8+Hh
	s0gz6fhFq1deS1DdVSSi54I7AyiuaxetoVYGO/eodkDJj8R8mmUBItUKMW2IGSuv
	ZfIL9iDIOY7yn7e5niMOdHgsmX7HD7VQ71R9HpaIsLbwWMezuCUuxTMNaV2HqGVj
	Q0IkYYENMdo2YQBHNFTiWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791164699; x=
	1791251099; bh=O/AYfU22MtEX03DaFxHnRz0AS1hTNyOOlg2avkuOvKQ=; b=e
	io/jxjHvayHnG+AfYOJirhWnnZzxhJbWZAik+apSzrxzWO4yh/ot+HI9ImqZn7tf
	6Rb1sedkG9XC/FIz9lEcDrivVKuCJfy0Ze8hn+9KkPmBHvCkDp4jdLy+LxCCAr+0
	eEqtwxtJ26uMrB0dFC7HwIVYZIB3YW9+0Xjju9/pxmQ+ZNbJo6Ciyr+lvHXTGh8B
	chUeMNAt/uNdmjoBxhBmWhiEee+rDoIFqqOsdDYYm7Z3nZttUDBusLvEuHHraQP4
	6GGzpaWzGS5k+wMMmBVvf9Tme3Q0FMvC+Nt5RW11ZVeNyLiTQwqlBGRIKmIJfv7u
	5wlpUHGjQqqMYZYw6T4JA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=fionn.email a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791164699; d=fionn.email;
	mf=PGZpb25uQGZpb25uLmVtYWlsPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:lTvdW84Ub17e8+Ma1n8Op5Pf0lVZqd/6M5N+7Ky4tWrMGTh
	fCw09mZZLh7kVjdQx+DcKpV4sJrcsLuRXgtWk3hWqRQBY86nZx5MVbellkCYJ2pK
	LD1CAJEM/tcrLFEz5Q9Iai6FhUjTjgMEd4h82cfgLIzCtLHmIAgt9P+tQd7y/Vaa
	SSLALR+sSIyxpGTuaCByQuvwyl+PSyx2BS+lsZ2DnPhmKrQMoPVVCiqc9OZD9u6Y
	vqu6hxblijUO3+poq85kQota0ch6S7nBkEGdxWWhj1HCIUzxt5rITI4kB/aOy184
	iui5q6SZV/qHcZ565cc3cAaK44OFFVSEuJBRNug==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:RS0Efx++red0UxXA3kd9KeCEu5MVU/BNASam8JYKsQA=:O/AYfU22MtEX03DaFxHnRz0AS1hTNyOOlg2avkuOvKQ=;
X-ME-Sender: <xms:GwHDakLhRNXXff2SjCdZW1Ugpb1V-at3NvhuBxdMW7uY3LgImrONUg>
    <xme:GwHDau8IHHEVTllsNv2gpbk_75kaxbVWdQvOKhnpcsJfFCULeqbwjO2QIc5IucQ2Q
    PANqSkD3kV0xlInnadt8LzPVf7BI-6Mp33HYWvwHuAbU864oucVQPw>
X-ME-Proxy-Cause: dmFkZTE5kDo0A4CBeRan1dfVDnGNLMbIuEdqZNTbBZB6mJ/g5ksXVYyzjrFldTeQnRLhkI
    oUXmaW1mwnHqK8+L+BKfduzP3BRbMI71TfJ+K8ojeUGXQRLWOCDT4MGb/gj61UsswYVauG
    zV7g26j5zCrLzbwmuIVZo3r+WbwtkM/r2GDDLOgRg8OLJCn0WIi8HKYBICofqB7kfgEPhb
    Fd91PoQqVQYJev0sx1AAQpldCzhwITYftQHfbL7bfSTb2VyCsgl754g5g5MKJaUCMvs6hZ
    4dBxq6kO0m9eXoNzSbj6QEJ5xb+7kiIfykZ8XqOGYxSwl4maPn4P6t0jUv3oiNVy2WkAnG
    bsCoMkjQy/55tIpHAyqY2Z5VDPDLaRN65RY4BrOPk6QRpI8/L5xLe4W1+ZrCj3dZSr0DsL
    TM2Oo6LxgnY3WtKnoDjW8c+vEzDhyIsE2hb8z5J9hwidMzm1DIoL2saa5V/n6HP9sPVBjU
    HTxmSuNnRjutY5M/jE4jGXHKIW07g9UwSzIHAeAxLpq89E0MPUj6LFkOU489rJmKC3HJVW
    jHY5eHPh6JveXnVzD1N6qHTwqhSx8td0KWyelJO/B6lN4OcxJ3kE4Q0KTwIe884N8XGMt3
    ErxOC3YF9AyepsfzHRk+KeWpCn4NJzkaj64/Ma0BRbh4ZXsXIHwe3jfUmrVQ
X-ME-Proxy: <xmx:GwHDaj2V4i_qYlW7sepYpB8NIpcV4tXdbCcjGfKN9D8MAt3ecfBe0Q>
    <xmx:GwHDarbIt1OJzdLj_oS0OdfQ--6QRgoss_gAsOUnnbCES7PDW-lrUA>
    <xmx:GwHDarLI0QURsoAQVW9RfgKC8DP-hZ-tc0m5DuZEoZzBTta9X5cFNw>
    <xmx:GwHDaqF-6uN_WIf7NjuIwO2ogu2y4RFoiUiZS5sZoRKDvobFNJrc3Q>
    <xmx:GwHDaoM8k1ybJlrK3VqsTiXQ8iSCGvlQ4VKfVI4FJK0qiDdqRdaSa9S6>
Feedback-ID: idee64834:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 23615700065; Sun,  4 Oct 2026 21:44:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed
Date: Mon, 05 Oct 2026 09:44:58 +0800
Message-Id: <DLWIW6XTLW5S.3B270NSZYIQDE@fionn.email>
Cc: "Fionn via GitGitGadget" <gitgitgadget@gmail.com>,
 <git@vger.kernel.org>, "Felipe Contreras" <felipe.contreras@gmail.com>,
 "Fionn" <git@fionn.email>
Subject: Re: [PATCH] completion: exclude previous file arguments in Zsh
From: "Fionn" <git@fionn.email>
To: "Junio C Hamano" <gitster@pobox.com>, =?utf-8?q?SZEDER_G=C3=A1bor?=
 <szeder.dev@gmail.com>
X-Mailer: aerc 0.22.0
References: <pull.2216.git.git.1791026527023.gitgitgadget@gmail.com>
 <asIJO3CZ/P/2L4qi@szeder.dev> <xmqqcxtprwyd.fsf@gitster.g>
In-Reply-To: <xmqqcxtprwyd.fsf@gitster.g>

> If you had a file called 'add' in the working tree and then typed
> "a<TAB>" to complete, is 'add' offered together with other files
> whose name begins with 'a'?

It is indeed.

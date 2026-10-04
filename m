Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DB4353EC0
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 16:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791130629; cv=none; b=S9uVVKc7/+hs9WE2di0bjKoLgwvcMZSvW42PIAe3vdvmO3j/4RYjzZ/TO3t6aLx2qUDXeMrmBjuK5w7dBDN8xElf7SnX7XNoIlpBAK2PfVONB4amCThH0iHVEJP7yOO2a3hbtKgKBwLUkejBXc4r2g3kgXdMldz4mVEls1U3vtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791130629; c=relaxed/simple;
	bh=e0ITVnE0q9+k4NFl+VhehxVVBSXzlYp5kxxFirgdHiw=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=aZOcfByDIlWy3prJfJQJJcTrAnRGC1L/Sjv7BRCOkGoegZJ4Ah0EzOHtz36dpnCoZzy+ttTl0MR57JHx2u2/kS2Hzyn5Npu3G0rN3Znf0b9t1/69aSsi5xl56HxKups8rxgjQaixDW8JxtD02p8tGXn9xKgfGJFdsqA5qQiK6II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fionn.email; spf=pass smtp.mailfrom=fionn.email; dkim=pass (2048-bit key) header.d=fionn.email header.i=@fionn.email header.b=J9OPERDK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e/WIoTVg; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fionn.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fionn.email
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fionn.email header.i=@fionn.email header.b="J9OPERDK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e/WIoTVg"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4298C14000B3
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 12:17:06 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-03.internal (MEProxy); Sun, 04 Oct 2026 12:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fionn.email; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791130626;
	 x=1791217026; bh=PMctTMxaziFbFjcNga4rOQA/3GYzHRgW2E3g2Cx/3JU=; b=
	J9OPERDKi6Fxsv4VzM2UkmW6bk66ozcqQNPGtJUq/+NxbABNx/Xu6Z6Wd+CfDrYq
	yDe7dFLSZy/2oo8Ab0C0AxxOKstYfJfW/RPEFgXO8x5BmIFxrcJpkp4JKY3nYGAg
	o2ahlu2iBgKmBBUUPDpH9nh8R9vNkTHdd3wwmBPLKK/kUor9mNv7h6+0sLmzhBP/
	Lh9a7Hiu2N9xiWjZFxHMWCj+KWEI1orbn6q2uakw3GPQr5DK7HH/W8O4uOm2PFx4
	VNvf7Sg3CtNUJfF/Wfg/JJGdS6kGW9GO9ppnNkp8iDJSHQkHrbSN9Vk23atPCCkY
	db4d4nIFMWgYSX3uNv7NUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791130626; x=
	1791217026; bh=PMctTMxaziFbFjcNga4rOQA/3GYzHRgW2E3g2Cx/3JU=; b=e
	/WIoTVg5Ipkoy0si8e519XR497DZu8Vk2tdqTPc7YkR1avkDrlMw5ctrMRX6PtPS
	mSq/6BefohUvZSEtGV5QQbue28r1XJXt1unLQQjPkxmQ+9t9EN0E0lawhHNqu73n
	0NLWDG2M8xtz1EAs0GzUlU4qpBD1kh9lj1GdADuajU/LZmn5wctqNMv5ZQNr8gJa
	aIaf50Xi4qQN+Hkvmlf8XEjrb8+TbNgaNDi5DbOWMbNuM9EQAmft3qlb/cLDWrXD
	skP5Ef4tjJy3znI79uIVSrA8cH+67hABIta6Zx5cApd7c+WjJuvfTqDTlz9lU8ZY
	MTN2PjUIvNQ62nyuGvIsA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=fionn.email a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791130626; d=fionn.email;
	mf=PGZpb25uQGZpb25uLmVtYWlsPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:NTPIxDoLQUv5eFEgPX7H2Ixnr4/vFwpVz9adbIw/vglCI9q
	GEMF19RtaQVx2q7tVqitgnCOv/pJBziZsiU55lD7wnkwnm9XR/iOkxQnWcWTEWOZ
	JCaT0HY5BnuXBRGXM0o2D62MxihoBEclBv7b3qpgOzHPxgB1i6/G+7FhxyxS4qUJ
	u2qMBJ5ZfSVTtPfu3M1R3aqm1gZaUNDKdRpFTtryGt/C6oes7irpT8NEfzEwsoSF
	8KSMTxxDE09Q6NA1PNkj8+ppOj7FwooWlDnGi+ywJqDiGHudiq1ffCbqu2stbUDA
	gtSAPIc5epCRzAO4dqkULMyBGllMSxk7TuFoqZA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:yMU5mZb+9u2ViBa3boZ370Kf01qL67RbzN2YmQ0S184=:e0ITVnE0q9+k4NFl+VhehxVVBSXzlYp5kxxFirgdHiw=;
X-ME-Sender: <xms:AXzCakqIeudcowJcCktfGnsN9rHBNmESXaXj46VnPjws-5cZSdfdpA>
    <xme:AXzCaldXZVHOLZ4yPmaEy0OSsnOk7GoDePoCNBHjcGacf3lZpywfC4xaLZTZTVg5v
    Ki6Po-u8YdIv7k0BpjzX6DDSiUB8gxNfdrRHMRekMWM2I7ix7SpRw>
X-ME-Proxy-Cause: dmFkZTFlkmp2QDk29tvjGfgcBhBteKNJjebdjkRYAB7SOSwrsWp8/wAJPfs7eAHb/6MpPK
    o6p0zF1INN79GQ/ckzbcZb7+W2Dh+RmXKvecGML9rEUfDrvjglisJGPBYIgGkjjkzMZs3V
    p7ef08JPc64bRH5I2zvlOd4vy01SdwcT2n6Cv0oJEOZzte3JDbsRgRDb3Q+T5jdTOuWahR
    hhQ6PVQpHqDC54o7aIlPE+3UQ88nU8L6GvISNP/DvSYffRb0C2JzYQztyRYddFfreJsEof
    3QQGt+gXzHmSOQJMhuLVxgM0HGcqe8CYM31+9JBd7UfZGkKqqZHXrJq20BNQibDyY8YqXU
    J3tmaY8nsaTUK3pRWo1ZbR4fi+Uz7xF9MEAoKmIwgNGbBoMd4hRIcT//+VgS2OUz7F6W4i
    UPVuNreAJvY8wUF03QxO1TiA0ninRxgVeAVJtRcs7U0Fs9UG6+Kgz90oRdb9l+K0lVaMXL
    MgxDgbqdcL8FW0y/BUu110zqwe9IzTRtF3GGqydk3rccS25KCEX5I/MUjGYMhU/W3MLBTQ
    rLOe7olsqGIu5iQylPWXaY2BhUShXkd0RJYBM88IqbNwfPGNurt5cWlwzQJyBzOrIXzNc8
    SFnk4uKz2t64WJ81noSA6C9Kazd9pJW2AdJ3skNM1OuUhBENyVI/rcH7+rWg
X-ME-Proxy: <xmx:AXzCaqt7O7BvVb6iEMRT8mOxTICQSoNIP7KTxeMHXuhuLwDLwACAsA>
    <xmx:AXzCag90tEvmY0A6jKGM4X7R10zEDF_rgJk7LYIuSOa8K5GBe3bRdg>
    <xmx:AXzCal2hBJEQSwu2F5fFEKwjO0xDxySXDnqd7GUPKgJZrg38L7Q1GA>
    <xmx:AXzCalCcqlPbduehE9DrqXhy3FEC4xoPyOIUS-alY-eYQj19e4cXxw>
    <xmx:AnzCavAA4iUhNCkhteW9wUUhYz8vio6P12E0TYRwNSzTvxdhQ6mIACT3>
Feedback-ID: idcb64834:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CBB37700065; Sun,  4 Oct 2026 12:17:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed
Date: Mon, 05 Oct 2026 00:17:04 +0800
Message-Id: <DLW6TDPQ9DA8.3CY39XL14GO9E@fionn.email>
To: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, "Fionn via
 GitGitGadget" <gitgitgadget@gmail.com>
Cc: <git@vger.kernel.org>, "Felipe Contreras" <felipe.contreras@gmail.com>,
 "Fionn" <git@fionn.email>
Subject: Re: [PATCH] completion: exclude previous file arguments in Zsh
From: "Fionn" <fionn@fionn.email>
X-Mailer: aerc 0.22.0
References: <pull.2216.git.git.1791026527023.gitgitgadget@gmail.com>
 <asIJO3CZ/P/2L4qi@szeder.dev>
In-Reply-To: <asIJO3CZ/P/2L4qi@szeder.dev>

> "existing arguments" of what?

Of a subcommand that takes paths.

> I don't do Zsh, but that 2 as index looks suspicious.

Fair to be suspicious. word[1] is the subcommand (e.g. "add"), so we=20
index from 2 on in order to skip it. This is independent of where the=20
subcommand appears in the entire command line.

> What will be excluded in the following command line:
>
>   git -C dir -C subdir -c foo.bar=3Dbaz add file1 file2 <TAB>
>
> I think we should exclude only those arguments that come after the git
> command, in this case after "add", i.e. "file1" and "file2", but I
> suspect that everything starting with "dir" will get excluded.

In my testing this works correctly (i.e. file1 and file2 are not offered=20
as completion candidates any more, but if e.g. dir or foo exist in the=20
subdirectory, they would be offered).

I've been dogfooding this for about 8 months on and off. Occasionally=20
completion candidates I'd hope would be excluded are present, but this=20
is because the fallback completion bypasses __gitcomp_file, which is a=20
separate issue. I have not yet encountered completion candidates being=20
unexpectedly excluded.

An easy way to test this is to link git-completion.zsh to _git and then=20
add

    fpath=3D(/path/to/directory/containing/_git/file $fpath[@])

to ~/.zshrc, or similar.

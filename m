Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2D93B059F
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 12:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791894462; cv=none; b=Gl84FbhFFqnFjbNMTlHHpB9QenPv24cNC5M29rYvElNFPNWVs2GqCSAGF9HczJsGJT8Zz62Dui3ZOuMaIpD2Dv+GoWIEVIdkO7B7cHMZQOPpd0Ugf/Vfc+/AK/UFCTvMviG5RQg7LUlecGHNq0LerEbbZfluWaNVk6wpIUaSnac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791894462; c=relaxed/simple;
	bh=7OydOpMVsQMOj60mBkLOF+1qE/yJ0DwVxxb48FI7o68=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JLHIVd2w0uN3xW35CSeuEPEgYMwA9x8quAwl2XvxJerRicODxBR/0OzRdopnqaGMp/vawsuOxfC5AKFk0gOZAqX6DHyzJsUbm9pOIwK/wxJDq/1DeDYY/MBJCXPXcitc+tyvI2ohlFOy5KrBmPozxMql577CYNVb6+R/U3o0gvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=FxLhqhib; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wzgLytbq; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="FxLhqhib";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wzgLytbq"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id DFE321D000D8
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 08:27:39 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Tue, 13 Oct 2026 08:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791894459;
	 x=1791980859; bh=5eqZ5Zg+xq/3I8fOv1/skCKpuFOcY5f+1sQXgC77Eo8=; b=
	FxLhqhibkTilfDuLICUSrM1Kih5Cl8AtBM7H4yIaXwzT2jTjSMuVOIonPhTnpnSP
	b0gnNgH5kWsfL1LmMlNsyTNOJvpkJ8zar3afoYmOWg3jxZa7XaQ9dOieeslslnh8
	IT5HRk62jIHF164azzzJIvAfo+Iu4cbiSvHL+4QfdFxN+qTeTSzFsysvOyQiDmSr
	T8VJDq3+wdpK5t5kKMm9NrpmAgs0kb+rM1E0cytOAT5A03nPcPropb2oZYF1cU9v
	i6HBNS83ijEXq5h5LUuc50QgD979LzYH9CrlU0HFDsM22U6pyYVBsZKDhaBQ/+PL
	MaENOh6A2JZDBaoMpE8RaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1791894459; x=1791980859; bh=5
	eqZ5Zg+xq/3I8fOv1/skCKpuFOcY5f+1sQXgC77Eo8=; b=wzgLytbqCZYfxfxYK
	iKz0El9xXXQzvmVnnogaNZxL6DZgdE6SneZ+UPf/K/6XMc64NVNIn9w9Yup9Qvqg
	xr2Axrv0vmB/cKRQ6BPyqx/ADRM0m858p1hHCIbVneoryAJOneqYe5u9+6GXXMP3
	xemTIPcT8EvKkfrZF595PV3ymOdRg6AmA2SfVnC03S94qSDn+3qTFl6NDN0IExYT
	vAqrOgyiXb9B3I8x+NgtcSIu3TnNHAYA8/SKE8m/d2w42qJLU044mmhoVxxrTBLY
	MWh2Af3oK8yXbU48JDN8Hd+rfTdgdCp467tDFqir1Oj+BhFbJxAyUzHwimuDq24g
	cO7KA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791894459; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:QseaARX/+iChXWqPnbf/cAc8UrU82t6ipzGWy66fkpJWhjl
	lQNuQkxaDjOb2QprG3m7ocETCidLqnmqlpT1EiYwvtIXtZjGenwotoNkAVtyOVGn
	4yEFXCbpalosHSJtSSMPAdixrn0eObBCJ7blDi2sgYGD4rNDXpqMA+G7b/9PbSCK
	ARS318WlQieRNJBL/GM5yXhqK1Yk0R857z7BMd0H/vhQdp1i4f7dKOmb746MaG/L
	FLFxE9cRSsWXPTdWii2dIo9jqdGcUDOD2n2CFF+sYbS3mgv65zbUmRlvKxwHR5NS
	XVPmlq0J3TgSydW8skHLthbXtTGq826DUUNeaYQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=content-transfer-encoding,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:I9+lcUR6degjOQIqwxRrIAC+i6iKReF5oEu0gj84RAc=:7OydOpMVsQMOj60mBkLOF+1qE/yJ0DwVxxb48FI7o68=;
X-ME-Sender: <xms:uyPOagQAez-Gy0hzd1SaS-xcL6bTumYtesDFcICDO-awTo2_4LHaMA>
    <xme:uyPOaoltoeDNJVIZHVoRdXKDJ_bst3p6DUnkO34qv751uS9Ig8ya14Wrj4DHg0Klp
    Q1lfSyPIuQFoCktKhmyAsdeX1dDH8xdC2MGhzsM92bp6RoVuWjZdJ5U>
X-ME-Proxy-Cause: dmFkZTEJlfH/bKjF0th09WrAuI0IrAor9MA+hrlRF9dmKUyODpj/Q2JewtEvVLZppc1yta
    Lk1aJUhHet6kL9I/ZqQBP9ms+CVtq5HkgNLV+Hb57nKwIVe6yFY0ap0qquTQnzYGm5Xi4m
    NsLbv3x3PC1LSIdQHDvwNSs+OuXZ0qcfrA50OvKigXTL/or8ym9QTkc/p4J37ajrqHJdXl
    eIk5/Uv+R8ioIr9gQ41lySkFe0f5ydK3heVynt33Zsfbbc7VZVqupgPq7ioOoJNNmf5XTk
    njmCgIUj1ndPubaXCDYwTYJoZxmZ6lXftbnqH3sjNdETVTMRPUFODvXOlXhghRH07zbMGa
    qEbL+h+loFVDgVKzjRrkL61pRqreFJHaSQwjixujHpYFyvkJOiwX0rjzUTXUOvLoFbh7il
    VpeqiKOlSdLo2PmybRmsl1S94IcARISSt71czVcsOuXG6qBjedE0ClVdwV8tA+do6fgFfn
    KpnHzksbCS35sYd/5MiXtkIxGlPRjXXAwNCpV4fmnznTTQQVw8lju+2HrzCKBbp6+jNmjI
    Ugx5nseMhdH8uXLx9yAM9nlqec4Nw64jCSB9xwlZkRs/AAbN8FWp2Af4kIcUPuXlGbDV3O
    JGhQAku01lCKsp7Z62P4yKbhBfO6pnbVd2drmRHCQiIT5ceQdcTnLkoPBkFw
X-ME-Proxy: <xmx:uyPOajvOJZs4ID8VhYc5lTVraNFKCECzgJnhC4iD6Gj6d37wXQhsmA>
    <xmx:uyPOasNUkDe9J7BHeAj3POrZjHtGOl3PAzNEw4vwJH8TUcded55zWA>
    <xmx:uyPOap3EwPwy0ENe9m9AVxMKEQ9mWwtCYq0SfY1pKLVzCCF2coYCVg>
    <xmx:uyPOagNGBkA-76XbXVWx8Ub860w65Bnl4H4F0OsIuvRyM5nRk9gOtg>
    <xmx:uyPOaoLx8HziYjglb14UUa8-q72TwX8HpM9W1OQDI1lMe9CryFbrmA8C>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3A92878273B; Tue, 13 Oct 2026 08:27:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1sfaQj8oK1o
Date: Tue, 13 Oct 2026 08:27:18 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org, "Julia Evans" <gitgitgadget@gmail.com>
Message-Id: <1637a8fb-d689-47fe-a008-e8e90d9889b9@app.fastmail.com>
In-Reply-To: <2642391e-1cef-4071-ae3f-db6fee3fab74@app.fastmail.com>
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
 <cb482e6d-0c76-4f34-b72c-03b5234d4f37@app.fastmail.com>
 <5dad29e9-24e6-494a-9b0f-701af856ae69@app.fastmail.com>
 <2642391e-1cef-4071-ae3f-db6fee3fab74@app.fastmail.com>
Subject: Re: [PATCH] doc: checkout: rewrite detached HEAD state explanation
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Tue, Oct 13, 2026, at 8:20 AM, Kristoffer Haugsbakk wrote:
> On Tue, Oct 13, 2026, at 13:48, Julia Evans wrote:
>> On Wed, Oct 7, 2026, at 3:02 PM, Kristoffer Haugsbakk wrote:
>>>>[snip]
>>>>  Documentation/detached-head.adoc   |  43 ++++++++++
>>>>  Documentation/git-checkout.adoc    | 129 +------------------------=
----
>>>>  Documentation/gitdetachedhead.adoc |  14 ++++
>>>
>>> Why in one word instead of hyphenating `detached-head`?
>>> (gitdetached-head(7))
>>
>> Currently the guides are all one word with no hyphens.
>> Happy to use a different style if folks think we shouldn't use
>> the current naming convention for the guides
>
> I=E2=80=99m confused. It doesn=E2=80=99t look like that to me?
>
>     $ git help --guides
>     The Git concept guides are:
>        core-tutorial    A Git core tutorial for developers
>        credentials      Providing usernames and passwords to Git
>        cvs-migration    Git for CVS users
>        diffcore         Tweaking diff output
>        everyday         A useful minimum set of commands for Everyday =
Git
>        faq              Frequently asked questions about using Git
>        glossary         A Git Glossary
>        namespaces       Git namespaces
>        remote-helpers   Helper programs to interact with remote reposi=
tories
>        submodules       Mounting one repository inside another
>        tutorial         A tutorial introduction to Git
>        tutorial-2       A tutorial introduction to Git: part two
>        workflows        An overview of recommended workflows with Git
>
>     'git help -a' and 'git help -g' list available subcommands and some
>     concept guides. See 'git help <command>' or 'git help <concept>'
>     to read about a specific subcommand or concept.
>     See 'git help git' for an overview of the system.
>
> What is definitely the case is that there is no hyphen between `git` a=
nd
> the first word, maybe in order to distinguish section 1 commands) and
> section 5 and 7 manpages.

Thanks, I'll change the naming, I didn't realize that. For some reason I=
 felt
sure it was the other way. Maybe we should rename `gitmergeconflicts`
to `gitmerge-conflicts` in the other patch series too.

My best guess is that I made that mistake because I (maybe idiosyncratic=
ally)
always use `man <page>`  to access the Git man pages, and typing
`man gitdetached-head` feels awkward to me.=20
But of course we're recommending that folks use `git help detached-head`,
and `git help detached-head` is much nicer than `git help detachedhead`.

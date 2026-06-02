Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B3836AB7C
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 07:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780386866; cv=none; b=Ar9DWWSCIl1SP+0P/OuAAy1E3gDgUM9YpYBgsfHFUpit2h6aPR/HxEla6E7mhs4kxR8p5g8p6zdachq5U4GDzohMORZbZ1GIapmz8FTUDJb2A2y3NptVo9fgJIcS/HciyD2M3qQc/L7qjRN1VkZn8MylGzsZIoY7ivGP0QTd07s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780386866; c=relaxed/simple;
	bh=Q403iBH/H/Kx387DjeePK6lOPBNEaZTy7Z2uQdR2XIM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=M0dG8TSIlYx0+BEwUVFdihDBRGP8St55E3yvE57wT28vG0hVNvXT1/m0su5uj/PNAUp0qB91qSDHGODJAfnFFPmZBCfwmIvxDqU/dPZGm9xWwmVXVCRVObWOWCQV0UixEPe+MWP2n3h5V8WdIECpwY1+5lJHLpx8S0/4+ElJRCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=QP8+3kWr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DOaqiPFg; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="QP8+3kWr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DOaqiPFg"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A7F2DEC0110;
	Tue,  2 Jun 2026 03:54:23 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 02 Jun 2026 03:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780386863;
	 x=1780473263; bh=MAJ6VH5pwlicxYH8Ivl8EFo0QBBHvhZhnuauuGQ2izw=; b=
	QP8+3kWrCyKh6Fw6OT6MUSSZUtfsZTeyQw99tn8wO/XC+T1TJipp3eY02HDgXlC+
	1SefxxBKfnYhe0KsMSNDoDLW6kC+BGOnXe+cRdFT1d4PQa3QeO7v4LUj5h2bZKG4
	swOKiFJYEujliR306L9J/QlJukbsexmVI8Ozy3oi/Skuk7lZWE69GxjUvj9XoCaT
	CKHMb3cOPygCZ9Qk7rkgZl1dHA3wZ82DlJGSnWAG0pOYfkoO0lRpCDiC9bsSRysp
	S3scNegzK2Y7xlbEjO2HoHynPEFie8Mh+9NDQw2I3B2JWXwn9T9VDYIDc8FN2AQS
	fuu56MQMiT0TDVvwQoZzmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780386863; x=
	1780473263; bh=MAJ6VH5pwlicxYH8Ivl8EFo0QBBHvhZhnuauuGQ2izw=; b=D
	OaqiPFgptpaUFS9M9qzin/Vazzd+G1V+ZaBD9UxWsrmwMlKgXAo6boaK0KsWOirg
	/8IGAYlk9SGyWYV/3yy3oASXnGcqiKxkVgiGpUeWSL1ncpcZFdDdXMlRmmWQ+1rZ
	x3wiB0Uk1IBuLfvYqWUQHIdX2e6mlsFWbAQQGQXjVqXfyjv/x3EouktEV+81kdS7
	i+P9DvbVcdA8Hdtum3j36O3GeTAijdeuh+WNxjxjfGte88+YZPKBztW+3nRU+dYM
	v1Ac4Xz+VXnIDEv1kvfk1wD0Jsz1szpamf7bc1pCDJ6BUoL/jrSbOe3Xo2dGo4Mp
	+Rp8ZeodOhdeKulPJvznQ==
X-ME-Sender: <xms:L4weanC_VS3WEHYimVkRaCWv1E1m7WXvVc9IaEzNIfEf_pdv8FiKIhg>
    <xme:L4weaoX2T86vd3pubUmS1IDIwhbRks8Y8f8Sxryq3_-Ep_YBDcMoKMMPbprM1Lmz0
    L1aroQI2Fs8sBBc3pKrbVMjWrKPYa7DFp_CeWD49eETkwT4hnrWrQ>
X-ME-Proxy-Cause: dmFkZTEo1zBf9IlorVKsRo9UKEFTnVX4zBtf59K1THGKJ6GjccN7V8pm6fZBwJSIUvj7s6
    RC2zVbwK8CLdBTM2rp/uHjokBbdHGvKCX5VCKmySUL5naWySZkqmmptFP29o8Ny8yLuwZU
    zVZyCUzp9fYnQO4jSliuFjaBSH3K+FK3FzZujdKQussAdvM4O8JxCkvYtFtPPB/v9yh+zE
    p5pPa2Zp4Xg8APQGYWutdyWJqWUeY66gjo7vbg+T281P6gZRzBh7srYCAOTkqVG14PFyT0
    1G1/NMcTz+cTAxa5fYdg8Tnx0DxOAh5w6s2O/wDp2iDV7xz09dM1BzziFi221ut7Am1uhT
    ql8o7xheFIENaSx/XzNC0Le97W/66AvnRGGO+JqOG/qkP7ZcBLGulzOHNC8aOH4DAnS8Ti
    77H0U/cg/tJMNos77AQ4C9SJY+oYstok7XXc7nIookzb4EndMGT9NB6zIQdFhfyTV3CGIB
    rB9iI0pZRXXUTB+06x+z276n9907TM7kc6TUnkUQokgM/nuqCcrINJDbOAhxhVji+9U3/g
    TRETf5c2X9Jd009ZSiMppDysf93EVpjTXausB7IEC2JoohE3OxSY3uVlxQvCGCinjRUrdw
    nk1aMkFGSr08hjzQegn6/kLKCAhT1dAZnjKRyjBsEL9ihdd0xx8WztlUzffg
X-ME-Proxy: <xmx:L4weaoogY37BJGq9wMRymPrfpr6nRCvOmEN9qf667PbivBDC6oWmVQ>
    <xmx:L4weaqEkP9lDtFBvFldkGK4YOGqqJwl4u0HYGp2GWVb-n73EPF2-XA>
    <xmx:L4weagtSIiWHWCVda9mIC4sl9UCL36fFX-6AoHd15Knw7FKjs3YHLQ>
    <xmx:L4weakW3o-wymgDTnkdAxdeIQqgSvP_5syTl1EmvpcKUUU6kldswEQ>
    <xmx:L4weahEvpPCtq_nUJVdVHgwtWg4tINBP_8ubzpplzTaaJDwNFiNI15rH>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1523F302008E; Tue,  2 Jun 2026 03:54:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AjWID8gagZ8N
Date: Tue, 02 Jun 2026 09:54:02 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, "Junio C Hamano" <gitster@pobox.com>
Cc: "Phillip Wood" <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Message-Id: <455fc75a-444f-4760-a22f-54a2ec29618b@app.fastmail.com>
In-Reply-To: <ah58IJ8DgSZYRjMM@pks.im>
References: <20260601-pks-deprecate-git-init-db-v1-0-ea3e6eebe674@pks.im>
 <20260601-pks-deprecate-git-init-db-v1-2-ea3e6eebe674@pks.im>
 <276a92ac-b2cb-4a89-96d0-9071ab6200be@app.fastmail.com>
 <ah12uk7IFxS92OR1@pks.im> <042e66b5-122b-4c86-a9a9-f75f763666a7@gmail.com>
 <ah2VL-ftCQelNoOc@pks.im>
 <2e266786-4ccd-4300-9b53-6f13fbaa2933@app.fastmail.com>
 <xmqqcxy93nph.fsf@gitster.g> <ah58IJ8DgSZYRjMM@pks.im>
Subject: Re: [PATCH 2/2] builtin/init-db: deprecate alias for git-init(1)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026, at 08:45, Patrick Steinhardt wrote:
> On Tue, Jun 02, 2026 at 07:22:50AM +0900, Junio C Hamano wrote:
>> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>>>[snip]
>> Or just leave it without deprecation.  It does not cost much to keep
>> "init-db", and because we expanded what "git database" means in
>> later versions of Git since its invention, the name still makes
>> sense.  Thank Linus for not naming it "init-odb"---that might have
>> been a valid excuse to rename it because it does not cover the ref
>> database and config database and others.
>
> I wouldn't mind that outcome much, either. What triggered this series =
is
> that I'm always annoyed that it's "builtin/init-db.c" instead of
> "builtin/init.c", and the same for `cmd_init_db()`. But I intentionally
> constructed the series in a way that the first commit can be picked
> as-is, so that we can adjust our code to the modern world while not
> doing the deprecation dance.
>
> So I'd be equally happy if we just drop the second commit in this
> series.

Could it be worthwhile to mark it as soft deprecated? In the sense that
it is a legacy alias that is not planned for removal?

What I think was mistake in topic jc/you-still-use-whatchanged was that
git-whatchanged(1) was not explicitly marked as deprecated before that
series, and then it started failing without a new `--i-still-use-this`
flag. The doc before that said:

    New users are encouraged to use git-log(1) instead.  The
    `whatchanged` command is essentially the same as git-log(1) but
    defaults to showing the raw format diff output and skipping merges.

    The command is primarily kept for historical reasons; fingers of
    many people who learned Git long before `git log` was invented by
    reading the Linux kernel mailing list are trained to type it.

Reading between the lines, this looks like a soft deprecation. Then
there were emails that said that there was no prior warning. And then
someone replied to that saying that it had really been deprecated for
over a decade because that was the intent.[1] But IMO just saying
something to the effect of soft deprecated would have been better
(before it got hard deprecated).

Trying to simulate amnesia, I think just the word =E2=80=9Cinit-db=E2=80=
=9D looks
slightly legacy, and the fact that the documentation just links to
git-init(1) solidifies that. On the other hand git-stage(1) was
introduced as a better name for =E2=80=9Cstaging=E2=80=9D files and that=
 too just links
to git-add(1). So you have two commands which just link to other
commands, but one is definitely more deprecated than the other.

=E2=80=A0 1: But =E2=80=9Ctrained fingers=E2=80=9D reading the man page =
every other year on the
     off chance that there are new developments? That=E2=80=99s another
     question.

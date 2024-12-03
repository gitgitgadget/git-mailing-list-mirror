Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7331F75BC
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239877; cv=none; b=Zoh/lRvL0hENie10uq/EWBOkTZVsbdAc9eIBNFZBiKs4y83XzrZXdNJTANKK5WnjzcZpqbJvaT5v04Y/+0RpEHGW/Ucgjt3qHCdqKXzldUYFZw8jPdRxg86FkPfd/7lWr1HZS9Tpk2+kkcK/Y+saIbmn4eH12+cC4/HivZUu/qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239877; c=relaxed/simple;
	bh=djtxu0nmcGdC50+UIRm4mznF2eFRT7flYQdV8+ZTvfM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GlOXGzuLXdSJ83imzzAGKzImvo3ULWzebX/uTtRognUT8TJAG4Gr1aU/oTPAXLdM14gELZyDlVWFSezMMGoqg2aPn/8rRTt+mbDdhyZDSjLfxDFVAPwsK/+S70aH2AhegqCVECWCvhADzXXvE4lVAUu119A0pC1nob+ezQFFemI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=CMGF6yYW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nIUkbNDO; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="CMGF6yYW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nIUkbNDO"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A3C1E13807C6;
	Tue,  3 Dec 2024 10:31:13 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 03 Dec 2024 10:31:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733239873;
	 x=1733326273; bh=GeP3LX/mRslHpq3ViSo5a8piseA5KgSrQrIg9BKaky4=; b=
	CMGF6yYWf8zfRm+tmBHh9UNCNSOTpDNJsAccysO1FVhdtYpoF9qM0CDRHCjNrfq1
	Vds2Q9mgdR5ltxJdKzv6Pyjy8ClCKno8jUXT7LyxyX6ErZTqdKIajiRDArR6QQV1
	FhZtJuK3goMCIbT0EJREMrYBqx/gV8htLvI1eaRrpEmXmmn1Dtg9AbxLcCY/PmGU
	FwNcjAjxVTXa/T+BZ8+K4J4uXZyCaY2xM1JcvhSXjD+hVarqYYnpDnMKSxu+mYen
	jJLnrIlS55/bJisTa9AddzXX69YOnVE73/XOPzRLfhC0mS0jF3E/0s1Laav/BZnc
	GA/kQaixKcqsskpBGk81jA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733239873; x=
	1733326273; bh=GeP3LX/mRslHpq3ViSo5a8piseA5KgSrQrIg9BKaky4=; b=n
	IUkbNDOJY0JS7/fBuZliN87Pz/vazxm36o+lGisfJpHbnNq0IkBhIYWFG8Ng87Jq
	H+h0kVs9mmSlAD8Eb+F0b4SHEET8aO5GyfgamrSAVt/941W6TkfhFE+TG6+A+Jqk
	0KMNY2TBtMhOlDMVu1zmMWy77HRjGvFZuqVFZGi8Goa3zd/86DhadA36+y10kVTX
	81SNCHw9AmCwJsvmHgPH9qi2NRAP2C0XkdA6SybddDqVSx06OpVExv0AJatxd72t
	28oXqYd2eyDs8/PTUMOu/T8OxnMwBtlxR0c2Fbj8k6uZwDdmPrZAlDTTJvt/XVtU
	ODrsrXnjyx0kN51xBkRtQ==
X-ME-Sender: <xms:QSRPZ6Rs2moKMkwYVKptURWz4Cwsj-jndZQls2zUY5XTMsipAmtEBzo>
    <xme:QSRPZ_y1wWMYE64kdGRB9wpRApyEUOpbuKn1oBCPoefxtnCYk1m6v_FmZk3I47szu
    mvgXCVqDHCLHymcLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieefgdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrght
    thgvrhhnpeelfeejudejfffgleduheegheeufeeffedtgfeffeevudeuleffgeektdelue
    ekieenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehlihhurdguvghnthhonhesghhmrghilhdrtghomhdprh
    gtphhtthhopehmghesmhgrgidrghgruhhtihgvrhdrnhgrmhgvpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:QSRPZ308q8Zh5sy_ViV6N2WgcDoq5lRyUOQ406MyDGOmib8f2Ofs4g>
    <xmx:QSRPZ2B7YN0Zwv-dlg7IVUdxM2GZMeE6Nbcx969Qh-IqwxP-3Bpw7w>
    <xmx:QSRPZziMsCmE3GZf1PZjRa5O5DBLyYxdhJnnmYzNScfNRozPt4zpYg>
    <xmx:QSRPZyqgrLI8p-XVhqeIDGQOFP8kleFqoTTxc7weWn6L0sv_aTgW5Q>
    <xmx:QSRPZ2vou88Yh4chUwVKV25sp4pFl7be9QJvd_cxEGF04VKjF-M3JavB>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 68C1178006B; Tue,  3 Dec 2024 10:31:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 03 Dec 2024 16:30:53 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Max Gautier" <mg@max.gautier.name>, git@vger.kernel.org
Cc: "Denton Liu" <liu.denton@gmail.com>
Message-Id: <75269425-49ee-4a16-beef-614da392d528@app.fastmail.com>
In-Reply-To: <Z08N4AlQKiNi-IOI@framework>
References: <Z08N4AlQKiNi-IOI@framework>
Subject: Re: Detecting squash-merged branches (and question about git-diff-tree)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Max

On Tue, Dec 3, 2024, at 14:55, Max Gautier wrote:
> Hi,
>
> I tend to work on project which do a lot of "squash-merging" e.g, merge
> branches by having a robot squash the branch in a new commit on top of
> the main branch.
>
> This makes it a bit hard to remove my branches when they are
> "squash-merged" (in contrast to using `git branch --merged`)
>
>
> I started a little script to detect such branches; initially I used git
> cherry, but this only detect the case where the branch has 1 commit,
> which is not enough.

I=E2=80=99m working on a program/script to detect merged/squashed/rebase=
d (or
cherry-picked) refs.  Is it okay if I contact you if I finish it? ;)

There=E2=80=99s also this program which says it can do the same thing (n=
ot tried):

https://github.com/foriequal0/git-trim

My program tries to be like a for-each-ref for merged etc. refs.
More focused on reporting first since that can then be used for
deletion or whatever else.

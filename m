Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD61D378D6B
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 06:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791353208; cv=none; b=fw10TE1jdpgIuidcQctjGgxGB0oaY307l+LFPWThNlvoyBWX8+iCercPrHS8wwdlhSdq4jXaBQnnAPvK2RzIi4GEJe9wKqhkPKsHXEx1cLLPO7h9tGzU8yQ9x/bBoEihzkKrvXzrNuAEfF/tcAMWex2LSlEU4uMqrKbIhMuv+Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791353208; c=relaxed/simple;
	bh=Pf0zHR907rsw6GdohjrF9wqMa6aeHss7NoJcxBlFblg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NudSqYmq6V/XGPAdmL2n24Dny11CgOH8nPb8EntE8j808VftpqzsoPLrrZUEW9QDTjf4cyTEZSgCZWjWV9IJgf8tlt5N/Jp3iSqCLQYn/fq4uObsfqhBjVPjX8PCbitPJESCHDaTzQdaIl5udiYVVPpP6mqL5LIl1nBeghEkk9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=h1QuTj3G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KcxLB6F0; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="h1QuTj3G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KcxLB6F0"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id 8A54BEC01BD
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 02:06:45 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Wed, 07 Oct 2026 02:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791353203;
	 x=1791439603; bh=w9z1X8vlNbdJS6n/ekacnXwgH1CEYfyF4klsEydKB74=; b=
	h1QuTj3GPYL4fxQ0MyrQ0P8ulR+4EqRPbCg1uPXIux3Ns6et3LRNma2HLcKHxn4n
	Zb0kl8VzCn0el0bq8x/sorD6QcQZmR5eBbriZnR0NGl/791Ds1jytDguu5q1MLFj
	8Wjw99qAQkN8P3P88h5/9kd40nq7yoevApT21m7rlAkWnPshyjij5K/JAE1eciTd
	J1pzcu1+tD1wbaPowmOW9TwEA0C7xmpcOf1fpBe/BmT4aExs71Ql3DcWZbdpucBj
	SrEHIdhIt5970q5Wcv9Wz84jsRH9Yheqyqxz1uTta+ek30vOKyCuqzkxR011W0EX
	key66jXKjYDyLgjZKgWBdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791353203; x=
	1791439603; bh=w9z1X8vlNbdJS6n/ekacnXwgH1CEYfyF4klsEydKB74=; b=K
	cxLB6F0LCzC0oEd40NsIgcVKVia3OXkrU5+geEkAS2r7cv8jRAl/a0xbEc1/F+AG
	3MiIrzFOVZOZZjyKLvlE4ToQy+dtaOOM0KgccpnjqKozFRbFgEXEvE4JjhPGr1ev
	Vdow/AQRBugXvUZoGOFY+6POp08mJ4BuUhEgF8vWgk9aD4YRKpIF9jWAggkh+W1O
	396RuQ9BFwPZTT7ViCiXCvU6SIOTyonsJgeHvZVHzd7nxSbsKgEKY8v/hYRy0Hfx
	NBfaJUyr+mLAQ4xmPm2xYVAuJGUXUT7WlUmGdSubhnGo1PDrTQ1dtIxeCHYvO7p8
	PUHHeN+QIBryXkkYJYuiw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791353203; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:cUdajYK7yxDvoV1ftDLYJC+JqxqXHWcIoXjkROIjiP5M/sY
	hpqQZ2ptj726JQJOavVEZzsUW5fiUn+LqmYeojG0KSj4E4fA5eqq8a6UTzsiMc1m
	HMoG1wvErziUmGyjKBBgBYeAGqvSCPLoufH05Fu/j6dI7Bnn7mwNUIiTbfBgMrjv
	j50AcJVR72aTrbZ/AjtilhVzfB9s+aGduDvpbM0f5zHr4FbyIZhhArYb2i5xdg1W
	/WFyo/fYFajAMbimEjnh7YJRUbQSgW+VA1c0JDuPZ69qcN6d0Cnqq6bvoavvl5kf
	hY4uT+dTxvCm2Y4g4gw1z9dy+L9xV95eqsmdCnw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:2drdHYiZTlUfGWOr3AeL0ezE7C70KsD+w0VVWxF/SEA=:Pf0zHR907rsw6GdohjrF9wqMa6aeHss7NoJcxBlFblg=;
X-ME-Sender: <xms:cOHFaqoeR0y48hwduP2D7pKDzoSFxJhwu6a-QgGmlfPHtsxG6FEM0o4>
    <xme:cOHFajeeG-z2fl127NVw6EoAnyY53Of9WvIAJXlQDLdnEcDf8s7_-DHjimf93PkgI
    jfXfp50oJnSKkA1fOrmZLwKE6fTmecj9DQQfbUpVBRbW5K0diL9eQ>
X-ME-Proxy-Cause: dmFkZTGZf9zUXosmVuSM7EdXT53z4kVqFzcON46vfg6I35zVRzmEUxiUSXs2e7H+kTcO+K
    1i4dTm2y4OEoHdeRayXSMYGO6ue1VLvcglBlrKar07FqRKtHXxQTLbgkTbPfwNzkstSrSt
    HuOLYPRLTGUk1nzK8ZAbRktuHHUhShZ00oYhlfktwlR6IrxYAF90dJwViiuU37gV2nMrnp
    ksRg29LfFvxJstIhZTXfuCAI/J4il84R+U2ul3XKbA1llQ1ug+fzZKSrbXjrqR1byt+AsN
    w+OWgppUfqMpmoSd+AEDcT2mLNzj75xhLFv6eCryk9Omm1GQpdH9oUDzBcsUu/0QcOWcZt
    cYd+HCbr1fG4eabfH2Pps87ohfc1d2bi3ZyblNVtGA4VYHKdLxYkhCnRPd/nIj1KIOsGHR
    9gFZXqTagbUbSgX5gx3esPbPjm9prw3/2CYix8lKEpjbEIZIC+ayWbfpPc4PgI0zexn7C1
    cvp9XVzxipx/oY45YgdDMLb2BrngwVtQC4kSqQLv4LrUQwBHB2LYIHsJDcGheDv4DWpGRm
    NOUbSZc7Frs/33Y4TqHk/DLQ2B1g5nUjViIAERJxY0v1TSmO3qJMBpjpPv2owmf9C5OSQw
    170RvATHAQvzTlf1vw3VGBNrE0gjPebg5xKvXTJW6IIRfnOBaRu2l7J8wNUQ
X-ME-Proxy: <xmx:cuHFarSK_645aI7lDx37GWDULk5_9tVDQGtCVIlOjKhDffQ8Y3Qzfw>
    <xmx:cuHFaqnUe-icWBt7ii6NSj7ZJ_vjG9H21MaoN0nk_xtd1WMMlc3Ysw>
    <xmx:cuHFarSX1oSFF2Im7aNJ6C_6feoyc_W22FHUTcZQNDUpFV7m8BAM0g>
    <xmx:cuHFaoOdMJw7cW9Nhri3308S9IV9qj-R1RJEspTPXiileV-BERf38Q>
    <xmx:c-HFauyZQ827z5QIdy1w5_9LVD90yTdqxTEfQt9WiQCana_HEaSXTrXm>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id DE2D322C0098; Wed,  7 Oct 2026 02:06:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Abh5d3WMFOiR
Date: Wed, 07 Oct 2026 08:06:20 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: git@vger.kernel.org, GGG <gitgitgadget@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, "Julia Evans" <julia@jvns.ca>
Message-Id: <ea29fe74-7f76-440c-9597-fdbc173be90f@app.fastmail.com>
In-Reply-To: <pull.2242.v2.git.1791317163584.gitgitgadget@gmail.com>
References: <pull.2242.git.1790627574093.gitgitgadget@gmail.com>
 <pull.2242.v2.git.1791317163584.gitgitgadget@gmail.com>
Subject: Re: [PATCH v2] doc: use `man git` to teach users how to navigate the docs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026, at 22:06, Julia Evans via GitGitGadget wrote:
> From: Julia Evans <julia@jvns.ca>
>
> Many existing users of Git don't know how Git's documentation is
> structured, and a lot of folks have expressed frustration that `man gi=
t`
> doesn't make it easy to find out how to get help with using Git.

Yeah I can imagine.

>
> Explain how Git's help system works in `man git`
> (`git push -h` gives a short help, `git push --help` is the full docs),
> since it's a slightly unusual approach.

I recall only relatively recently learning that `-h` is not just a
shorter way to type `--help`.

> Remove the references to gittutorial and giteveryday since they're
> unlikely to help new users learn Git. Currently they feel very
> aspirational (it would be nice to have a tutorial and a guide to
> everyday Git commands!), but we should give users a realistic view of
> what the documentation actually provides.

Right, aspirations are not good enough when it comes to the bread and
butter everyday howtos.

> Mention `git help` instead of `giteveryday` for now, which does a bett=
er
> job of giving an overview of everyday commands.
>
> Also mention `git help --guides` and `git help --user-interfaces`,
> since those parts of the documentation are useful and hard to discover.
>
> Do not mention `git help --developer-interfaces` since it's not releva=
nt
> to users.

Okay, so now we don=E2=80=99t have to list out every guide that might be=
 of
interest. That=E2=80=99s cool.

I see that this would conflict with my topic
kh/doc-gitbreaking-changes7.[1] Just would since my topic hasn=E2=80=99t
been integrated yet (RFC). I use the old style of mentioning the
new gitbreaking-changes(7) (=E2=80=9Csee <here> for ...=E2=80=9D. I will=
 remove
that change in order to stay consistent with this topic.

=F0=9F=94=97 1: https://lore.kernel.org/git/CV_gitbrchanges7_please.d1c@=
m5gid.xyz/

>
> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>     [doc] Use man git to teach users how to navigate the docs
>
>     Changes in v2:
>
>      * mention the git help push form too
>      * mention you can get HTML docs with git help --web push at the e=
nd to
>        advertise git help's great features, and remove
>        https://git.github.io/htmldocs/git.html since
>        https://git-scm.com/docs has a nicer view and 3 different optio=
ns is
>        a lot.

Nitpick: Okay, but with the current commit message I don=E2=80=99t really
understand why the git.github.io link is gone. I have to guess that it
is an effective duplicate of git-scm or something since git-scm does
remain after this change.

>      * some minor wording changes
>      * fix commit message style (doc: not [doc])
>
>[snip]

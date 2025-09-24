Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D45531283E
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758728070; cv=none; b=YLUCuBDk/U4a/gQGj7l7uDVRukhtSNvEoHgNT5bOjuiZ88Y5NAreEtop3aO31di4XPOcFbrwqUtY7+f+otWgp8mOoWs0opYW4aiyiyyQfQwNPX/jvbSzLATx6Rg1FWJ8ojGOOEgNK67ADvWRfbeZv9ZdgIsKw31IdtZKxzv38Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758728070; c=relaxed/simple;
	bh=NAG+mZQQPpjhGD8Ao3Dr1FLQP0E7qMLVCOapI8hEv9M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pc/CRG18u3d8CYrCMHlKWi8BKhLPIdaBKxCI7r9tbsJdgW0Bqfjuh8kHlK8sE38+tGyQgwS0LGBqUdWVLueBrfFrx8fGf1JK0EnKv2FslO/cEZj7/umy2jLXskk/THitzE8DYxKQFuyj2LKVtCpu8VNaoXxOB9YCWPk7LU1EYYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Aer2XBEf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eNgCHN81; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Aer2XBEf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eNgCHN81"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 4B53EEC0198;
	Wed, 24 Sep 2025 11:34:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 24 Sep 2025 11:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1758728067;
	 x=1758814467; bh=jLtF9Z8NhxLCWLYtgHAmyxk1RmmSe99Jp0MQUkUVkKg=; b=
	Aer2XBEfAisVUaeoPQQhsNarDiUJ8Uc2EzVzCksUfc57Anif/vThs/xkLzBea69g
	vJ0AnRWbqfm/9HQAOOeHa6ZeTOMpPJiIOcdKld7hcw3iafolY5Q0wbG8kS7wjZlu
	xcRiud4h47qCKcQj9Q0PZbltDdYQTk/TEM4SI314FZS9jG1qFIgHHH4Ylcs+svbA
	2cGAnY2oonkdV3dzrmboUnyG+g3LpsCk68oSvjFtuogPkiUqKXX9x8RsJ2sB/jh4
	z0fQpucFV3V1waN3vI7CAIjo9drS/axyd3Ow63U6thBnu+kMCHpdTtSkghalzTfm
	29E72Qq8mY3JsdFMBWMVCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758728067; x=
	1758814467; bh=jLtF9Z8NhxLCWLYtgHAmyxk1RmmSe99Jp0MQUkUVkKg=; b=e
	NgCHN81kJPCkwC1/ZSer3ducyV21Nq1lMIc0144IQqx9Vul7n+hKYIK7sJ5sLtOm
	lcIzqUfSfWzNuaOKdTEFVbHseRZEKwh/+MR+t8YJ2/YcZaUyWkNWrQnYv8hSTl3p
	UVe8T+YOMZj8O+zSKPofvuanZZd79zV/vz675U7jfYvOSuvPk8QUBOy10/437JsI
	3mD2Sub7qfuO4xZCrNPTuuSQ5wlMoH11D5agN7jcl9+Mepo90KQkIYm6aqsgg3FS
	nootfD29P4apQ1j123xFhVbaV5/jwfwEvLZZ6eSQorhDwoIpGpDXgxWRTxPNOeQG
	+MvUZHBTMmNuhliEDYDwg==
X-ME-Sender: <xms:gg_UaDhhjLcM8zHraz27sgV43sdax9f6AuG5ltlP5-zdq-GMiTOjRw>
    <xme:gg_UaM9ySgkYw2NFHNNP7hp4y1HWGAiL5-TU2kpEcX3qgrKugxFh6X7ASgE7PR1pb
    HuNrX7W9lVdHH3ja7827XfygFuRuPV3SgguBIQWd92BKfZTwy-SlA>
X-ME-Received: <xmr:gg_UaOv5laUQ7cpKXFjB1imzNUcQtu7jK5SSqy38ePsu2UXESOqw6BebVDeIvRQlPNNnpkr527HpAsTwdYoJQWDsnRE5LbWRiwYX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifeelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgv
    nhesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilh
    drtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:gw_UaIoZR5YrBsXnMwNrMMMbWk78-w9FkNdQ4oXtMwkGaXgRCnx8Jg>
    <xmx:gw_UaKrZJ_UT_dRXCamg1KwsIWiK_mFrYSUdWYiBMP-jTwTmvBuDlw>
    <xmx:gw_UaPa5AcetQ_v-NaybPpSj68FMTOMF2fGiTzYrp_o4vJLOJpeHUA>
    <xmx:gw_UaA8SSz7RMAgq4ASHkck_CsrQSNaM5a4w4sw8XOolelMzzf7dEQ>
    <xmx:gw_UaM1QSY7JHFsa0zKjISkzmJYwCJzkLrmsfOP0Rt66ubw-mjFklE9w>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 11:34:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  Ezekiel Newren via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Elijah
 Newren <newren@gmail.com>,  Ben Knoble <ben.knoble@gmail.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v5 10/13] xdiff: delete rchg aliasing
In-Reply-To: <CAH=ZcbCf7bUTL=BwCD8B6-AVHZg+K3JafvksLQWUx2D-XR58wA@mail.gmail.com>
	(Ezekiel Newren's message of "Wed, 24 Sep 2025 09:01:17 -0600")
References: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
	<pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
	<7b0856108a29f42e5a4d3faf7489d5522b683f71.1758662670.git.gitgitgadget@gmail.com>
	<0bb4f30b-6737-43a2-9aeb-3903c0dc5ce6@gmail.com>
	<CAH=ZcbCf7bUTL=BwCD8B6-AVHZg+K3JafvksLQWUx2D-XR58wA@mail.gmail.com>
Date: Wed, 24 Sep 2025 08:34:25 -0700
Message-ID: <xmqqqzvvn9tq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ezekiel Newren <ezekielnewren@gmail.com> writes:

> On Wed, Sep 24, 2025 at 4:21 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> On 23/09/2025 22:24, Ezekiel Newren via GitGitGadget wrote:
>> > From: Ezekiel Newren <ezekielnewren@gmail.com>
>>
>> The commit message should explain why this change is being made
>
> Reasons to delete local variable aliasing:
>   * Usage tracking: Tools are better able to follow the usage.
>   * Refactor churn: Later commits will refactor rchg.
>   * No additional meaning: The local variables express the same meaning
>     as the struct field itself.
>
> Would that suffice?

In general, I do not view the first one is a good excuse.

When using a separate local variable enhannces readability of the
code (which often is true, with a pointer that points deep into a
nested structure member) to humans, we shouldn't blindly bend the
code to cater to less intelligent tools; it needs balancing.

The third one alone is not a good excuse for the same reason.  It
(and the first one) depends on how much benefit we are gaining from
having a short-and-sweet local variables that may make the expressions
and statements they are involved in easier to read.

For this particular change, I would think it is on borderline, and
subjective.  I would be OK with the third point if you rephrase it
to additionally say that the conditional and the inner loop is easy
enough to follow without using the local aliases to make the code
shorter (which of course is the commit author's opinion, but they
deserve to have and express their opinion as part of the rationale
for a change).

Thanks.

-	char *rchg1 = xe->xdf1.rchg, *rchg2 = xe->xdf2.rchg;
 	long i1, i2, l1, l2;
 
 	/*
 	 * Trivial. Collects "groups" of changes and creates an edit script.
 	 */
 	for (i1 = xe->xdf1.nrec, i2 = xe->xdf2.nrec; i1 >= 0 || i2 >= 0; i1--, i2--)
-		if (rchg1[i1 - 1] || rchg2[i2 - 1]) {
-			for (l1 = i1; rchg1[i1 - 1]; i1--);
-			for (l2 = i2; rchg2[i2 - 1]; i2--);
+		if (xe->xdf1.rchg[i1 - 1] || xe->xdf2.rchg[i2 - 1]) {
+			for (l1 = i1; xe->xdf1.rchg[i1 - 1]; i1--);
+			for (l2 = i2; xe->xdf2.rchg[i2 - 1]; i2--);

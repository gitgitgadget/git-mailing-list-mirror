Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3E5261588
	for <git@vger.kernel.org>; Sun, 14 Sep 2025 17:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757872730; cv=none; b=SmSoGMhSxKjlQ4Xb1PaGzYOEqy9Cxbz9X5AUrdujld7LFFeFRjUHCqb4iB2OzXFaWu+AG5CI+1zTvsJjNnKGhMVdMg4YZR7b6OgnKgaax4CzFQUNeXxbFycSwiRAE8O1tG9qiqTPb+uIp+RKeu3437w0HrXu67f/K6/CfvaqnXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757872730; c=relaxed/simple;
	bh=rTX3OBiKqO8b0+k8DDEfrQlvVo2K0l50d11dqJegnUg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qWLo6nSUkqr+vnq80RlcnLW0CRuAWYnnuIiOtTczJwGev2Dx69oEWuXhZ+NxApZKSnNw0Scj5kcymbZFLlV4uaK3Ya2QiviZPCCKsfJt6aWe+ZWWBEEnG1BCYe93o/YgLqprOwqYOcbi30omXSbEiYf5NOV9QtTKd96Z0d8QN2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=V6Pa70o4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iCe4dHih; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="V6Pa70o4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iCe4dHih"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 668C6EC12D4;
	Sun, 14 Sep 2025 13:58:47 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Sun, 14 Sep 2025 13:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757872727;
	 x=1757959127; bh=y7uYLMrO+48HeO77uEBi8XsGHDbRM8bcTcYVJzhiIzU=; b=
	V6Pa70o49Aw77YdJ/5RSunRekmlvn22NrBVt0lOM7ya1AVw0zr4EfAd/+hLuDEiF
	6B2LspIDjne127UjQ3c4qBm0KgRNkzHxY7qE8+Fd7eKF5JeTvwrntvGMwYxit9pp
	SywS0Y7f8M4JBNZ5cYNIlo4Q3babeWapdtZB1EmUxul1oy33FxuqCS2yCCQSeOk6
	rOP5LRmwAAqgqxjPVs2oI1pQ/UisI+MJdatMzk3Kirn0h4I9Ws2lDN+QfAF6yc5A
	r/AXMrchZLgovhwYz9s3eGZ2M9F8lak2RRRSeU/HRw26VjzO2UK/NzJCcumObJSI
	QSNsKkDYIgfvtIgtkx+NsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757872727; x=
	1757959127; bh=y7uYLMrO+48HeO77uEBi8XsGHDbRM8bcTcYVJzhiIzU=; b=i
	Ce4dHihNCThBXdKGPNUsBN8fLTeEEjQwR3cS4MvGZjnQI0o+flWiBkpgOLWBk/4z
	KO9q8LIUWE+KX/CxVAhza+Ph6vfkXIcOz9JrItKf4tY3VmUankw3PF7zV5cf7J/B
	y1qh/H2bmC/iHo2DkAKMHwRH4BurQcM8+9rtlYSy/TmKZsQ5xZDrlMGgc322Rwd3
	WJmnImkdLBJJl7fE+YwyaB65ydUjQLSLD/sMMIpnu80FCCrF/fdidm6TEw9ZaaGc
	eYYtQZcfkVMtEBE2VlaCkKK6MnfiDHU4C0lE1tUL5YxPx4mabWA2Yq0NiOqU9C+L
	qtl+E5RYiXfAiRBPOH2Wg==
X-ME-Sender: <xms:VwLHaIUpuv3YCrDplZlnWR_oEG3ovRMJmpYwVndhY_Dm1lF2F1TyNiA>
    <xme:VwLHaMlHIy69ip1aOnT0gNqm1_bPfxRZtHY9ZjZfXCE7q5AaWnQp2bb_8by0RREFE
    elbmb6vHgOcp4lUug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefheegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpefhvedvfefhjedu
    gfduffeuueelhfelhfdufeehueelveeuteevtdffueefjefhffenucffohhmrghinhepgh
    hithdqshgtmhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepsghjohgvrhhnsggrshhtihgrnhesphhoshhtvghordguvgdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:VwLHaAb6SDx8Mlid3JW_EZb_EP5KzM_8isDcIyMDy6tm4shSR1Nqwg>
    <xmx:VwLHaEVWAtedBpwn93DSK82T5Hzc_Tft8lKWf_IUMw-CV3Ih4hmayg>
    <xmx:VwLHaM6ktKBrM0-ElcIfkXenUNe0Dhf9Vd4ngsLbp_u9_5o5akTTAg>
    <xmx:VwLHaHjydybSjjbgXP_QK9fdBDbUBAx42dQK7V5INrovL0dEKDrD9w>
    <xmx:VwLHaJX7dww-BpLjr8cUR_ngoXABso7gKFSKg5wLBrqm_mZ1MTdq3MZG>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E501F1EA0068; Sun, 14 Sep 2025 13:58:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ApBtbmhnwsVo
Date: Sun, 14 Sep 2025 19:58:26 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Bjoern Bastian" <bjoernbastian@posteo.de>
Cc: git@vger.kernel.org
Message-Id: <8637f911-6887-41d5-b9af-cd2376376461@app.fastmail.com>
In-Reply-To: <aMbIqD4c5JY60fK1@eismeer>
References: <aMa5kSQVlhVX7Iii@eismeer>
 <7897d2d0-5564-4514-ab3b-7310b626f4c3@app.fastmail.com>
 <aMbIqD4c5JY60fK1@eismeer>
Subject: Re: Usage of git whatchanged
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 14, 2025, at 15:52, Bjoern Bastian wrote:
> Hi Kristoffer,
>
> I simply followed the invitation printed upon `git whatchanged` to
> join in giving feedback from those who frequently use the command.
>
> I did not expect a thoughtful reply, so thank you very much for it!
>
>> `git log --raw --no-merged` is the closest equivalent.
>
> Thanks for pointing this out, true (actually `--no-merges`).

Yep.

>
>> What if you made a `wh` alias?
>>
>>     wh =3D log --raw --no-merges
>
> Sure an alias will be the next obvious workaround. With bash I need to
> include `git ` though and just type `wh` on the command line which is
> okay. To get `git wh` I could maybe modify the bash completion.

You can also make a Git alias.

    git config set --global alias.wh 'log --raw --no-merges'

> One can live without, but the statement "whatchanged is not even short=
er
> to type than log --raw." on https://git-scm.com/docs/git-whatchanged is
> a weak one

I have a proposal to remove it.

> that misses obvious use cases of `whatchanged`.

The thing with git-whatchanged is that it uses the same underlying
machinery as git-log.  So there=E2=80=99s nothing that git-whatchanged c=
an do
that git-log cannot do.

... and I guess vice versa.  But historically git-log ended up as the
new-and-better replacement (according to the devs) with git-whatchanged
being kept around for people who was used to typing it.

--=20
Kristoffer Haugsbakk

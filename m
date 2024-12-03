Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E921FAC5B
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 17:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733247787; cv=none; b=i5Cb5XmpvuClX+JMGGoFjph1vSHxPtIZcsroKHuMFNzG+uG10Sx15NFN2znSLcd3EkUxNdW1XZwaZ3ZVlT7gNbqW6ar663s9qQrhquPbFVRdJMIPMlaFTLeFDayrEAhyVA9LxormEnZGzs82pTbvBo3RlObvPJ9MEF98gMAFqfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733247787; c=relaxed/simple;
	bh=Qk3595ZWeT1JsXMuRz9rcR8u7tTUIcP9v3i39jeLHHw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HlHAwZtEfz66+YSPUostoB92GJJypGiZXHMxQCwPFCMlLlvVuWNthUHpXsh3PnVWnX7KtlzXV3Tsp2shDGSBQiH6yii8fafSsr8Pl60cu+flgKGU8VsJWJlyIhq9kcBcjSn8gnYyuYhnsne4QaAOTSY0gCNWBuzhINt0x6aewKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=US4PjHEh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W5vtrtbq; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="US4PjHEh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W5vtrtbq"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8D83313806AE;
	Tue,  3 Dec 2024 12:43:04 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 03 Dec 2024 12:43:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733247784;
	 x=1733334184; bh=u0xVzZAYPBhjJA53igJG3AHsKEP5nQUd8M8vhy6UMsE=; b=
	US4PjHEhkRpgSRT6FE5hgd1PlBU5Du7wJ8U1UfgVuCEObWdrUGxLO+i/OuZ0e1NC
	aU4vEhh1V4t94ChApLziMoIs98wHQ/P9ScggMkuFRL1R8AJIjx2k2kNSVs3th4/l
	JzvEFVv/mpmiIP2jMESE4zGorXuSs44SgcC4Q7XcXyq2W9O3/Pw8Si9LiNT09466
	M6uVwHBm7GNQXq4ng1tWlRI+tkp6Fl0Gth28WQBk7bEtcTjNsvBxhonk05LRUCro
	lU7CUPun3Py1eomaM6VoegB/FqA35bDa/Hg/fUbsmui2oIZuDvLTAELMQpXh+JyG
	G2CDjWL1oA32LpYyiKXGkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733247784; x=
	1733334184; bh=u0xVzZAYPBhjJA53igJG3AHsKEP5nQUd8M8vhy6UMsE=; b=W
	5vtrtbqfZjK+Rh6qlZsrplr+SnAfs/5zyPJgVYyhhaaCkw6qssyQs9qEzo+wSS9E
	sNHBYzJuggtFHj711ScVLbjc08a9Y+BmSbEIKQ3Viz3NqmuALfMiYu5aiwA3CPy2
	eIGOXMDa3ukirDa/HEajpSOYaAAyxhCaC7MqwOKKKEnKjWFws0igkvDq6weLVt53
	VyZ1QjNbq0AYOZ7Az5xeq4ORGCE49H+Xdtcd3ga6tgz5ufRI1bAyQOZsBiAKOfMS
	x4Ma6B4uhFIE3xlal82zymvDbkc1WJGB+ZnZU7N/Xhtu/4ngD/hVAjKCLIZ/3LAN
	b6MmnYgSezsA6zkwJzZCA==
X-ME-Sender: <xms:KENPZ-WnktJXtOu8FwGPZixpWBCfZVMHaum4DLGozvPPksC6r1UP7w4>
    <xme:KENPZ6lWWxAHdgFrR3EwNZaUBNu1hyIiUgTsY_-tfcxZmVQM4zDAVH_CjXGOcoZ-G
    oM-fLAGfik_wH6bPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieefgdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrght
    thgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveejgfeigfefke
    dugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhiuhdruggv
    nhhtohhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhgsehmrgigrdhgrghuthhivg
    hrrdhnrghmvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:KENPZyYU7G-QmkOBD7QCLQoNqbyCHVRPlph0TuWk3ShcINav0k69VQ>
    <xmx:KENPZ1Ukio1z1rQgOt0zZqtT5dDse1Vh5qo5p0BLE9tGQU-g3a-qJQ>
    <xmx:KENPZ4maFdE7rH7WfeVRLw6i0aIU1wenRO1YpZWI0U-6ggoXwj0ZJA>
    <xmx:KENPZ6d-PDRDbUC0HqICkc9h8evRFOhOki7qLOmRMzdj1tsYJ_wikA>
    <xmx:KENPZ9wPXIiu6bvJWDv8E-ijFYd6i7S8s6GqQJz8lWksEDgpF5GRidKz>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 50DDA780068; Tue,  3 Dec 2024 12:43:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 03 Dec 2024 18:42:43 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Max Gautier" <mg@max.gautier.name>
Cc: git@vger.kernel.org, "Denton Liu" <liu.denton@gmail.com>
Message-Id: <95b88ece-8188-46aa-b263-61bb371e4293@app.fastmail.com>
In-Reply-To: <Z08o-O5eiu_ZsYrp@framework>
References: <Z08N4AlQKiNi-IOI@framework>
 <75269425-49ee-4a16-beef-614da392d528@app.fastmail.com>
 <Z08o-O5eiu_ZsYrp@framework>
Subject: Re: Detecting squash-merged branches (and question about git-diff-tree)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024, at 16:51, Max Gautier wrote:
>> My program tries to be like a for-each-ref for merged etc. refs.
>> More focused on reporting first since that can then be used for
>> deletion or whatever else.
>
> Hum, I'm wondering why it didn't find this earlier, I did search thoug=
h.
> It apparently use git commit-tree to create a temporary commit, and git
> cherry on that to check if it's in the target branch.
> I wonder if this wouldn't cause problems in case of conflicts though,
> during the git commit-tree process ?

Maybe, I haven=E2=80=99t tried.  But using something that creates a comm=
it in
the DB seems a bit unnecessary/excessive in any case.

Your diff approach seems more direct.

--=20
Kristoffer Haugsbakk


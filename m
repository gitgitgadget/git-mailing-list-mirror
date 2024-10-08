Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127FE137C2A
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 20:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728420518; cv=none; b=Sv+nudAVAO9otv2x0LKg+ITBCrgBQxJb6llMInH/cg5Bq4cJ8Od2rmfx/By8kHK1pn/fvSIzVwife4vdm7nzj9jZWHi0SbmVuTegAjzZIVL377iE9Zt3Y2O2bocBtQtZK2tIqtekUmcAbneE2PTOXT9fYyFqD1beiCecO/22iMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728420518; c=relaxed/simple;
	bh=jk3L4UV9Kc/Hbao2oMUzCjIkYZzs9zwiU4RZFNsFOmQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=B4bZqZvunLE6sida1aeyK2RgCuTunc9VswKlAQuXgKmAp855wDgFAOHyZEufQSeClX/DXuo5lvfjxJL+CjsNU93dWjpNX6q2QU7bqtyL4DgkZloJ2R9pVj8zqZ7T3SLgtGKMhksblnjsW1tXWg4oDLfQ1YeU9Zmy064LfWKEJsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=aZtoQac+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MnHPmnZQ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="aZtoQac+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MnHPmnZQ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 273B3138074F;
	Tue,  8 Oct 2024 16:48:36 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 08 Oct 2024 16:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728420516;
	 x=1728506916; bh=/SP5lyU3dR3k5vml3n4U8pk4gvJDVvxxWyH44CGq5Sk=; b=
	aZtoQac+ZYv9TKSilGmcx9CR3RCQW2WR+OAzE/QuZHtcXGi9VgAcVcG7o+7iUk0w
	5+WZ66q7eV1v7MSSoTs6wZk0ss12T/ULMk8RlCSFhjWE2hJ3MQyzt+oBh4aVO5YD
	k2B4Dz7PvLKBHkzNvjXNYlXMdT/lCEFHsR2L+qUmG0fQHa+ncqK8Is8gfrUSxXLI
	EdUIhXdzAjITmvcTZTz7vIDqqbm10ZCq2VE1hG4OEh9P9hXTrhR7AhrJilycE0Vj
	3QIkcgtnPaEcxJPw2LkUQ/gkKPNSSuFZT26KcEFv+DBoJ1uHCOidqCaekDslq7Is
	c+yQDm7cCKkuQ0bw3wbrqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728420516; x=
	1728506916; bh=/SP5lyU3dR3k5vml3n4U8pk4gvJDVvxxWyH44CGq5Sk=; b=M
	nHPmnZQjk4LHOha1AhWen/c5i+tw4u5NuMvg/45h9W7g6JXshGo96zFgV0PZTW/8
	783ix/P1alGjCIa+hjja0tfgpP2/UwXorUh9GmSkufRtaKOYBgniOLP0EBhADXyY
	vxLqoSk8BagPcVFszw50LzFmUSCgsQ2nj/0qeJvrdchmlnw2EftSU/s8oRKSHVD1
	SGRUmaNI1XGwIpVBBjuG8hkWPp1v0fZnXIOjjzMkcW6Q0qsRxLHmVrOMAnaXGBRr
	s0cFqDyJS+eZszXzn8XlIxs2JosWuq1kTRb98EIpz8wMvzJkXixqKRxUi7YCA1LQ
	2EPQDpcIAGMVN0otwFQFQ==
X-ME-Sender: <xms:pJoFZzqz2u1FC8Ep-w6ZDcq69ZunMhi2Mc6glfXZB94NxbS0bq26aKg>
    <xme:pJoFZ9qHkpCgM3VD9paPxiVis_Cwv6zZDBqqgKE_JA-I3CcaLqc8cQliYueK9DeAI
    x8Zve-BV9YgbbMdhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddgudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpeegtdejieetgefhuedtuedttdeigfdvgeetkedtuedtudfgkeeluefgle
    etffejffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihr
    vghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:pJoFZwMMynQrOg9CUxKkfHYuTtkNFeJVg8qgTDEYeE2M8tH10XIBiw>
    <xmx:pJoFZ247eTJqsqcvP2kI_SKiJhKTsujcOUbigQm-frY--BwPavIg1Q>
    <xmx:pJoFZy7mrtIyyU4lLZlQpC0p6ot9bjkudftRdoJH9KwTvotOg9YSFg>
    <xmx:pJoFZ-jxk27Jji-u1X7Zaq4pgi-PWWbmBuLltXiq3GZXYZq5IK6__Q>
    <xmx:pJoFZ4msgRgiGXo4GFnxSMwPRhc5Ol_gXkRxiLTHjFOqrj1yZwNuTyhw>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E703D780068; Tue,  8 Oct 2024 16:48:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 08 Oct 2024 22:48:15 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Eric Sunshine" <sunshine@sunshineco.com>,
 "Elijah Newren" <newren@gmail.com>
Message-Id: <17013309-80a9-4cf6-8881-40df56413603@app.fastmail.com>
In-Reply-To: <xmqqjzeiz5ne.fsf@gitster.g>
References: <cover.1728298931.git.code@khaugsbakk.name>
 <cover.1728413450.git.code@khaugsbakk.name>
 <13e0f3bed5dd894ee692c672b301697e0a909e04.1728413450.git.code@khaugsbakk.name>
 <xmqqjzeiz5ne.fsf@gitster.g>
Subject: Re: [PATCH v2 2/2] doc: merge-tree: use || directly
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Oct 8, 2024, at 22:44, Junio C Hamano wrote:
> Kristoffer Haugsbakk <code@khaugsbakk.name> writes:
>
>> -       NEWTREE=$(git merge-tree --write-tree $BRANCH1 $BRANCH2)
>> -       test $? -eq 0 || die "There were conflicts..."
>> +       NEWTREE=$(git merge-tree --write-tree $BRANCH1 $BRANCH2) || {
>> +           echo "There were conflicts..." 1>&2
>> +           exit 1
>> +       }
>
> Makes sense.  Was there a particular reason why these two patches
> had to be done in two separate steps?
>
> Looking good otherwise.  Thanks.

Just my usual do-one-thing-per-commit.

In this case a simple Also-paragraph can connect the two. So squashing
them is fine too.

-- 
  Kristoffer Haugsbakk
  kristofferhaugsbakk@fastmail.com


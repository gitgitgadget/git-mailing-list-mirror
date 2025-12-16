Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B19C285071
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 01:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765850401; cv=none; b=PdQF84TJuQgcADAtPIE6fIZVj/ofTX3dxEps4AY2VO6EonQTxyaCfSH0AcYRxaIGMNz2xP7POqbS8WODh1+Ot/PcmKCvdhap0HzFymydq3rEq+IxfoV6JVCKt7dXOjyy4YwyuIvPhGHKGvK1FKEhtERNpfgThH6yahUdyidOfGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765850401; c=relaxed/simple;
	bh=p61XHDM7bCnM2m9wiQzKjiMddm7QaijdYhu4VPf2cZg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sx3gl5zqUSpytSvdwtpvvZ7qDwDc1PqlYtXPVaPH1UXRflYJHHPUuoWGIkdO9tAF4uumuXuYKSUmjlvX3MdmOY6rRuU8/gaU0PRoY5shKEQvOrVIDqs7TmffyFJgnTocvPvv83sR7bsDY+5EB0ZwsgKA+stNl0Lyev55/N8Lw0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WaDfnwHg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DKJEDp0O; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WaDfnwHg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DKJEDp0O"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 302261D00111;
	Mon, 15 Dec 2025 20:59:58 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 15 Dec 2025 20:59:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765850398; x=1765936798; bh=yxz8glmpBR
	dR3u/jlTzcqOeZAezRtreOwMcyQJwQ9iw=; b=WaDfnwHg6lZSODEU5cxywrGxii
	xj29O71PhMVYK3pkljDrwVaG5beySZLCgz1oN/UAEohWMrylER1wHqKEpUU8/Qvz
	vEqP5IDkvt+tL4HBHdJrbRQEqUbuI4qxVMN4GyvAzJjNhoqyRHm4FXR0e/iHr5Ob
	hMhnCrIBWkzlNmndS4D0tjVKwieKYtAMrrgvcY1caAmve5RQFHafuivNVjTEGr68
	7u+Ce0YWvfMAuJjdtuh1ZNChxaeXjsdFmywldl3vADBLc2jLZEJ2do5336RZjHb4
	Y9USesFi+79zQXIzvE2UAG/fMfbXnw+gfS5qt64BEwspLIRmoFXLlrYmONeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765850398; x=1765936798; bh=yxz8glmpBRdR3u/jlTzcqOeZAezRtreOwMc
	yQJwQ9iw=; b=DKJEDp0O3leq4m1ZyjNtlWczHIth4HX+8+EKa0Tde/EydLp5+7F
	Ux6fnAjrDI6gPT2hDm0fbQE34xeCSJv9CEg0U7K4Bv5DmHH75rbejQBdT/hwjFNB
	eFyE0x42myUs96wvaai08rPtjPK3vJQpCJF2jcrRvHALZhZ1E2xrh5PtRCdH/E5/
	gGC0uFs7TRhQaJUh+4qiTW9uzeZzu/07glhziLlb3o4k2YdFAJwCIHWCLdCvxlGk
	ozsbsYnNwT40aF/rCeqkaCYroGB18Q9wkMTXJuoLmdspEZs74Rt6aBaZ7tFsHGSm
	MY4h2kc9oesySt4/NeXeEj/XPPhP69KW2eQ==
X-ME-Sender: <xms:Hb1AaQac-oD0eutcwGrNPlmpF4doG_G8i1_ySRN_c5OCY0B-ZXpb3A>
    <xme:Hb1AaXM9m9lqy7wDaOKLxGYQ32gXDXkbtU4g-Szje3bRgCk6r9cDqXBX6SLh-Ayfa
    s63kAiGhjKPkBH7CghYNh5J7_jB7QAnyi7FVZBnp_9_ChhjCETO>
X-ME-Received: <xmr:Hb1AaWW1o0gbr2fmCZIr6yCUMnVGPXiahvz2JlFR6cREu55unVSaxiGzIJlzDfwY7tHUhf6zAIugKVS8-pzzWNIOXc_yJDuEZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefkeegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegvmhhilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    eprhgurghmrgiiihhosehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhope
    hsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgs
    lhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfe
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Hb1AaUI3dwTvynk10luxOCG8euFj3peOZWjndDYj8bQi9cFGC2r9bA>
    <xmx:Hb1AaZppynVCvkKH6DIMVi4cm1E0ZUPgEx33CSYTPgjF3hhHUwr-mg>
    <xmx:Hb1AaTwkBhMf-uYGNuKnKQw1rbAAXBDigliATKT87GD9up1x3f1pnA>
    <xmx:Hb1AaVtjFNd8-FRqtvl2mU5uNYTdWbXGX6Z4zZ9q9LLvpNnrDRAQNQ>
    <xmx:Hr1AaR2IjpMfSBI9bSef1EmHtbeDZkQAOzoqaT48dyAGG_XryJ-7W2ZI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Dec 2025 20:59:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,
    Emily Shaffer <emilyshaffer@google.com>,
    Rodrigo Damazio Bovendorp <rdamazio@google.com>,
    Junio C Hamano <gitster@pobox.com>,
    Patrick Steinhardt <ps@pks.im>,
    Josh Steadmon <steadmon@google.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: Re: What's cooking in git.git (Dec 2025, #03)
In-Reply-To: <87ldj6x1ys.fsf@gentoo.mail-host-address-is-not-set> (Adrian
	Ratiu's message of "Sat, 13 Dec 2025 09:42:03 +0200")
References: <xmqq4ipwc7y2.fsf@gitster.g>
	<87ldj6x1ys.fsf@gentoo.mail-host-address-is-not-set>
Date: Tue, 16 Dec 2025 10:59:56 +0900
Message-ID: <xmqq1pkv5gpv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> On Fri, 12 Dec 2025, Junio C Hamano <gitster@pobox.com> wrote:
>> * ar/run-command-hook (2025-12-04) 11 commits
>> ...
>>  Use hook API to replace ad-hoc invocation of hook scripts with the
>>  run_command() API.
>>
>>  Will merge to 'next'?
>>  source: <20251204141535.1986263-1-adrian.ratiu@collabora.com>
>
> I think this can be merged to next, since the latest iteration has been
> sitting for a few weeks with no more feedback and all tests are green.

"tests being green" tells us that with the current coverage we
didn't see any regression but not more than that.  Especially, it
does not say anything about the quality of new code (and test) and
if it is in good shape to build on top.  

It also is very hard to tell from "no more feedback" if there is no
room for further improvements, or people are simply disinterested in
the topic and are not tempted to spend their brain cycles to help
improve the topic.

If there is no more comments, I'll try to see if I can block some
time to read the topic over myself with a pair of fresh eyes before
deciding.

Thanks for pinging.



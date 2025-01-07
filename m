Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142AF155300
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 21:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736283944; cv=none; b=b6rYdGjLnIBbz+ghDIxtHB/s+thkyrWtiT7XBE8cCbDmSxE9d1TZ5XKlQaGsz4BlpbSoHV7pAxWCB0hnog8S2oTt1h09AQP+l937S7CayNfPjGBqfNpTCKi1G472yjCdXiz1S7/haNF3ZW6SDEFOAOLnMZxzHGKj4BB0J+bOtQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736283944; c=relaxed/simple;
	bh=cocn8eAicYYCHdmGpTkXw2VfA4Uk+w2fxAgwA9YOdSI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BhGj+cHyZzkB81YaY9tQYIBa+QCNSTWMJR17+1c88Pi2w0TTQxZMKseWLaArBUz+09KnDT1PSRAdD8SDK2xW1i7Fu2aOMEwgghl6WS9beAS47TOZZNn3I9Zz9dM48GvgPzTJQLyBbU4CPHu/2E/Hpx93b6f8GOj1g1oxhueLeg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kFlInG0J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rx9Bbk8C; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kFlInG0J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rx9Bbk8C"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id F3364138021D;
	Tue,  7 Jan 2025 16:05:41 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Tue, 07 Jan 2025 16:05:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1736283941;
	 x=1736370341; bh=JICjbvjmk91+I1k+fXAVlMfkFZFyBa6YOkpQtnTVwNU=; b=
	kFlInG0JGI90SiJv/KvRqO9fnVW+r6Ee+qKq8j059GVxk9fBZ1d5+1l51rppHDak
	l2bf2VVAbO6bTXL2bz8XXiJ27DdAzRuR2AYmpc6zUphwgcBGdWa8zeHxrWVYFylO
	bJ/+rLT3j4bFiVy0uFOgEVTIH2k1yJpxTUfbdNSsQKGQFk0kQNQqnui0zOEIfSmu
	/K/GkzAXUHQJDTOOyFC/pcsS1hDULpuVynqrOQEX6efdfQ7MU87mCFb2a2zCqj8Z
	Ypb9VPLhzeiFfTG9uMRzEU53cUvnu7U20zF4AKGgbroyq0nbM9Ax2U3rMpYnWcGu
	qB4lAYCd1KpaK3pRzNd/KA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736283941; x=
	1736370341; bh=JICjbvjmk91+I1k+fXAVlMfkFZFyBa6YOkpQtnTVwNU=; b=r
	x9Bbk8C+rXJW1aYzKhKbAJMiwV0fmo9wqEqwiO7ffEoG718AXP6JW0D2RfR/Bqk3
	vIQKBJfClgaOegjyIHFeHVHGd8w4eb5C24dByQdzCco+64T/99AioeP4NFGyFNFA
	7pSVSqpUbcIeKb9NfTRToDMUqdJBHUXUdQZ8UTzx//rv2ox7Wf44mN3UdCzM8VGu
	qLY2o3kdjzq7R+tJ+wIZ2nq5r6cQcdQkR0AmIi6e0aboASStKp2WGVR5KlBZsiqK
	knQNgTc9mDrH3SIUm7G4iz2QYYrRE+yjBuHfnWeLdD3bkpPqqDUHc1cjy2zxn1zA
	L5yfJc8WCfMk5bxhv4aAA==
X-ME-Sender: <xms:JZd9Z6wZOK6Nvbw3erUrh9EMggkkwGpmaIoGJkxv3U8K14l6b1HfcQ>
    <xme:JZd9Z2SSea_W7AdbwagfJx8Lp7NdU7vxKhWjuKh19YlMVUNJ2FkHmbzj67IR-uPTM
    pWMPMkGOAuwsBM4XQ>
X-ME-Received: <xmr:JZd9Z8WE2ZPvDACh-Ctr84uYLLMTvTogxdElglRt4y_f-rD9zfuvntZcLwg8HrS7e3gTmRRmgQIStX3MdSW47U4d-a2CrXul6Q6j>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddgudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgtvghplhestg
    gvphhlrdgvuhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:JZd9ZwjyZeGLTvay4U7DkANs4Gri9AOh6QAMChcmAlHS0ttM4rFkTA>
    <xmx:JZd9Z8ABf9tVHosxTklA7iQmYPrzEnxnwnr2cWbU6wmUo8TO62aFeA>
    <xmx:JZd9ZxLbjC5I-0GieD_dSsdDk1v6pGzivi4_SutzOCnovBfLFaDtCg>
    <xmx:JZd9ZzAEAWJVLoQFmOZonqbSgMD81mAffO34o5G4yUc4UzHXAM_NVg>
    <xmx:JZd9Z_PQejkjz8xGu7DsKcRnBukRCTtBaIdtF7OfamVC_I74NeF1eJyR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 16:05:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Mat=C4=9Bj?= Cepl <mcepl@cepl.eu>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH] RFC: git-request-get maintainer receiving from
 git-request-pull
In-Reply-To: <D6W4BSVAQ3VY.1GWVRAIDTBX3W@cepl.eu> (=?utf-8?Q?=22Mat=C4=9Bj?=
 Cepl"'s message of
	"Tue, 07 Jan 2025 21:20:28 +0100")
References: <20250107185716.1562311-1-mcepl@cepl.eu>
	<xmqqcygys9e3.fsf@gitster.g> <D6W4BSVAQ3VY.1GWVRAIDTBX3W@cepl.eu>
Date: Tue, 07 Jan 2025 13:05:39 -0800
Message-ID: <xmqqr05eqqqk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Matěj Cepl <mcepl@cepl.eu> writes:

> On Tue Jan 7, 2025 at 8:37 PM CET, Junio C Hamano wrote:
>> There are a handful of scripts written in Perl still in our
>> codebase; study the way how their sources are written (e.g., notice
>> that they all end with ".perl") and are made into executables by
>> Makefile rules, and mimick them.
>
> OK, no shell scripts any more. Got it.

Sorry, no, we do have shell scripts.  The story is the same, though.
Look for SCRIPT_SH in the Makefile (instead of SCRIPT_PERL).  I
simply thought you had a perl script but what you had was a bash
script, I think.

> OK, no RFCs any more, just submission-ready contributions. Got it.

That is not what I meant, either.  [PATCH/RFC] is just fine.  But
make sure what you are sending can be applied cleanly by those who
receive to avoid wasting their time.

THanks.


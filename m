Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960C8306B32
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 21:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760476408; cv=none; b=PPH7euKTGNajLMRMJoi7W++dgstSD+hnTUArJYgdsMtKdbc9bDoq7hkCGv5dPXhE0Hqd3lQr/ob9jLb5A8zHFLm6BKDGHHiF7EgEZvZkF/PPCzItihWlKsD2dnhTdsnO/S0xVhhl2gcVqEL6kXOPaxieP+QbX2m9xMmtwHmGPec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760476408; c=relaxed/simple;
	bh=TKaL2abg/YoCtMW62G1qMFbJb3sXOL3kg4/FRMY5i38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r9dX3QaJa526tiKVK+niETG+tQQjscdz5BuObBtZ76KA1bdGOFfqAt58qqnOOipBcEtlb8KfpiMk/Q53FD/Dq3fj3cq9jfCMSQrR/6fuw2/sKjQkh3OC4xrz3Z914ZYLE5BmrpGkJgDA1HViIC9WewuQ9L/DFQvO89rMNNA6oXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fvVGv566; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qpiGlX1g; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fvVGv566";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qpiGlX1g"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 616FF7A0109;
	Tue, 14 Oct 2025 17:13:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 14 Oct 2025 17:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760476405; x=1760562805; bh=pCX2aEJjxS
	tYVEhYjwTZ6XbtpoxS6Awpq4CosQGSDpY=; b=fvVGv566WXNN30J7B0pjGgId4f
	0Ai/3xGo2GSQvAP9h0BhXtl4Y/8RmirCWo2nymjp8ucVEuPZ5sLdWnRZcVwXbqbM
	GKekxRNJ9XTBXqoTAk/INq192DO5vV3WPPIJwJSjnEZvnV+CCdrb/rb+cM9YpMAA
	3pL00CCN4knpZnf2sjs0e/Hon5XXTkmztMuy3rnWtKQQIRNe69ELY4LWO5q5fWsZ
	tOXVVdqbojQ8T+SWQP5dfmr6Iuykk7zf0YExFv5e6orF3SNZjvF/GQn6ad9C5XN4
	rn+UQ4XcEiMVZeHCF5+STsOuzhA9zJzvrccnctmiX1DwNw50tkETbA20y7DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760476405; x=1760562805; bh=pCX2aEJjxStYVEhYjwTZ6XbtpoxS6Awpq4C
	osQGSDpY=; b=qpiGlX1gzgmYg6Pre+bK8dCkYtm2XncUjzwhSuA2or6NhkN7Es/
	35U8wrlMvRpylVg7t6PU/7Jh/GIsyWR4Sj7G96cgx7Hjpb3n1+mBRF8XNde0yMlR
	88dyiHx7h+5A19NhfZ8OJ1LFobgaNT+Dgrsbr12EX0hScCOPwfSw8lecbXRlwf/M
	374kVxqT9NT+8Ou5EhMOKw87T29SJjeAa+cvJk2OwFK6od0r8jQ6zdOvLcksg/Y2
	CYK5RCybLwDUj28IIOxBednSZCy+McSzRubeLSjsN+yU691mq+qLeVWnrB9/lztX
	W1auzIxz75yaNHGDdWb9H/MtkpD1excgT2w==
X-ME-Sender: <xms:9LzuaKI2FwrJQZeoGqN6AjbDdiyx5pKsZuIhmxYtxdo0dqi-unC5Yg>
    <xme:9LzuaMjjhIemliuO7q5-6HuDiP6zxgwDwGBuGSHUaBylbfGdwSPHJ7z4i_c8B4uAv
    MT-UnOJcdew2dWVsGsTP2c-bnu_3ObKfcVXU7QcODXChF4G9oY9jXM>
X-ME-Received: <xmr:9LzuaA1MYTH_ek9HvJcZ-63pnmXE5BhQhjrHAOk7t259cQNzxNEvh2-FhWD_DBzL8jsMrY5Zw5UqNWYUcoRokJlEf_4HSTw-JGcE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdduheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptefhudfgvdekgfefheetleevffdtfeeggedtheeviefhueeifeffgfevkefg
    hfeknecuffhomhgrihhnpehrvghplhgrhidrtgifnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsih
    guughhrghrthhhrghsthhhrghnrgefudesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnh
    drtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfiho
    ohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhoug
    esughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdr
    tghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopegtohguvgeskhhhrghughhssggr
    khhkrdhnrghmvg
X-ME-Proxy: <xmx:9LzuaKgzJO7tOjeTU3qUJlHyThJltCVWxnTM5G3vJZ4N8zsOl6YDUQ>
    <xmx:9LzuaJ_z3c6Xi1EjDZH9a57BoWrbClwPMHOP1SrmPKJa6EuQ-99BRA>
    <xmx:9LzuaOIHoCnktmRTaziANMZovEuzJTBH3otfdovhPc-qKWzeX_T_Mg>
    <xmx:9LzuaGzXcyEsSBdsoKGPCo5FMK8f3g1-ysnVTqno62hAHQhPUdgQTw>
    <xmx:9bzuaPlEAeg17XGgQ5TCicRe8lvKB5iAlM4uQYAL6kGcqVCLSeDYJtAa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 17:13:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  phillip.wood123@gmail.com,  phillip.wood@dunelm.org.uk,
  newren@gmail.com,  ps@pks.im,  karthik.188@gmail.com,
  code@khaugsbakk.name,  rybak.a.v@gmail.com,  jltobler@gmail.com,
  toon@iotcl.com,  johncai86@gmail.com,  johannes.schindelin@gmx.de
Subject: Re: [PATCH v3 0/3] replay: make atomic ref updates the default
In-Reply-To: <20251013182530.33041-1-siddharthasthana31@gmail.com> (Siddharth
	Asthana's message of "Mon, 13 Oct 2025 23:55:27 +0530")
References: <20251013182530.33041-1-siddharthasthana31@gmail.com>
Date: Tue, 14 Oct 2025 14:13:22 -0700
Message-ID: <xmqqtt01w5jh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

When merged to 'seen', this breaks t0450; from the way the test
breaks, I suspect that it has the same breakage if the topic gets
tested standalone.

    $ make
    $ cd t
    $ sh t0450-txt-doc-vs-help.sh -i -v
    ...
    --- adoc        2025-10-14 21:02:48.680184914 +0000
    +++ help        2025-10-14 21:02:48.688184867 +0000
    @@ -1,2 +1 @@
    -(EXPERIMENTAL!) git replay ([--contained] --onto <newbase> | --advance <branch>)
    -           [--update-refs[=<mode>]] <revision-range>...
    +(EXPERIMENTAL!) git replay ([--contained] --onto <newbase> | --advance <branch>) [--update-refs[=<mode>]] <revision-range>...
    not ok ...

In short, "git replay -h" and the initial part of "git replay --help"
must match.

Minimally you'd need to squash in something like the following
patch.  Alternatively, you could match the documentation page (which
is shown by "git replay --help") to match what "git replay -h" gives.


 builtin/replay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git i/builtin/replay.c w/builtin/replay.c
index 3c618bf100..d0f0492790 100644
--- i/builtin/replay.c
+++ w/builtin/replay.c
@@ -330,7 +330,7 @@ int cmd_replay(int argc,
 
 	const char *const replay_usage[] = {
 		N_("(EXPERIMENTAL!) git replay "
-		   "([--contained] --onto <newbase> | --advance <branch>) "
+		   "([--contained] --onto <newbase> | --advance <branch>)\n"
 		   "[--update-refs[=<mode>]] <revision-range>..."),
 		NULL
 	};

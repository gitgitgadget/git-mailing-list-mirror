Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B099A4399C4
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 13:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785935062; cv=none; b=nT2VF/73lOL0aQfIma0WpY8Cb+wgcIkQpjqP543Nd9uqb515YIB1IvOaHsu2mW96NGXTPs5SvvGVIrRDXhBbX4/0LfYlvVx3mxLsp/IsL8CLYJaAXvsHvGho0FVhujzd21z+fiIIHYLuXQ4T3hSC3J7A6MzTNAdiTEVHJIOTYzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785935062; c=relaxed/simple;
	bh=cwerZuoMnPpIH4RnXo3szXM4V3FW/cKSUi1QDBdCCco=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rHdV2JkWEUijF3MTpdwLwS9scYjINwDSldQqMfzLYU0FWn5JXj6+YEwyt/D95SucY1ZhpPMNCQD4LCBpaQfQE2y0qI2sI88wWcK3P2r3uqdHL6bkjgqk+Dqu1tjndxMz+CpGN6lKMwJqncFsf3McHgMyl/kyuwpqOizCacBJSLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BVu5EBI9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dih7TIsr; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BVu5EBI9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dih7TIsr"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id D4B281D00112;
	Wed,  5 Aug 2026 09:04:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 05 Aug 2026 09:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785935055;
	 x=1786021455; bh=9GAfM99r6/PUkOZlvTX8AdO9Fucq0icfuK+NMD0mwLE=; b=
	BVu5EBI9U16n1n5ceXKnJdOvage5IaopO/WqEyp3jcLSdkrggTlWmjAuRIcdEWom
	H15plEH3VQfbAz0Ou63H7hYDmm4AoD9CboGR6hN48sUlf3hCnyVw7tb12KNLHWJG
	9u+1QmUCcxYMnZkN22+Zr45fKw28PZhk+zMdLl0odlQ5prakiNP6wBwAH7DZFp6Q
	wSEx1un/ugDztE/s1GvDkAxrVGA64TdIeNuY5KDSRHt79SV6HMJBhtVWCvK1k6Ty
	9cstJ3A3woVtW6lAdq6TjPpr/HwvpoHocbw+JfJWn7bmdNl7DfSE1XZASr7Khh1U
	xxusvYvXfVE6/qMsI6HxwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785935055; x=
	1786021455; bh=9GAfM99r6/PUkOZlvTX8AdO9Fucq0icfuK+NMD0mwLE=; b=D
	ih7TIsrgTjGPhuWguIuVzjueiwnxFsxJY+0jNLFnfgBpmB8UXjoZJiH0k5iRokTK
	yWL1uOArldj1G23j0jQJ2LgKOfAxXo3RjtFje/R9SFzUjeUWAQmfb3GbwIi5rxRG
	KN9tn3Ti/uowf0gZkVYVEocHWF/AmIqJOxUUjA2r38Hj+mlW78+r2TdAwNpt9i/z
	OMhykxiOmY7qm1qEkqm2XH9RZBjmMIgD847HmSiMe5WVbJyIjahPw+Xe+Zg3BooR
	dQxIjumpb934b77xHazlP9etDk6fnOW8yZqdlX9/BCk/bfOsr94lbWjd3S5QCgA5
	eHwL0ezvgEwdpMX8qVuEg==
X-ME-Sender: <xms:zzRzatxk97y7fpLiejZfDHS7EZw3SYGb0zbdgukg-Ryu4gDbLp93mw>
    <xme:zzRzakKA8JfxpY44tZ1PVrF1aI4tdANoYuYtU6t1R11x_x30hlms2_A3TfNpDOt7N
    JgitnyCeW1760hlXf8ou86VSrwXKokBu5sFx9J-k9S6UJ-RZf2paQ4>
X-ME-Received: <xmr:zzRzavp6jOCh7gZZhCIaZhZX6v_1R1wS0xDaSSVS1_qn2k1h5Qz76L7AbYHs9n53MGv4CxA2_jwRqppzR_ZP1axNF7-xW2cq1g>
X-ME-Proxy-Cause: dmFkZTF23e0ViDJOGL5yqy3AzQFtL5oXonDmhJZmM64yi5UXkw0CnLbRatZG2rJuk8+267
    rSZ8VGOe1eAVaSOTZsn1Jv/5sxra9Np9UgYMj7YnTkMyhpXJwsFQxmgXp7Nc65BUqhdGEu
    m6EgcxgmpQNeH7ziJoSTk0RslXE7JSr53bhNdVB76+6MTrZjMu2anzYuZXsEc+fQdO7n+I
    DNk5ohacQ0O+DC2UNNrw8tKLR+b8ifDckYNXX+QupL+/cSaLKf9KpHc3dWSvIKmk6kbc7V
    /NNPE6trvnSQB3gCfr0QHbHL0DSo7N6BBxOkWcPmua0JoRKFec6ASUgzc8PlqlQVHoKMl1
    OpThDNQQ7iWxXqZNhAK6x25Ei91tenQUMM/6qmz8SprdJaUsY4HOSn4Yoa0saF1dn/hTdS
    IItJv08rxWwcQdqOtI+a4vth2oPcAd6FYixL/hbdkxkX1m9OKPV61PPX86KBZbs0ksbBqc
    ifvI4Yvi0vwS77Gs29FhNRZx9Ih42/vWshcSWhJUIkjrW7cD8bqkU4h4HyT9YQNoxxRKn0
    nHbN0oNDZoDOUJSu3zfmgFyxkocFeS2BOedSAa9mxzx8IsNTdnHBAHKO5+a+lrLZkcgZkS
    7ZxUYrDkh1Uck468Sn8586ni+qhNbY2K0SOw6Tyc5JyTYCQHmMCs609GBzpg
X-ME-Proxy: <xmx:zzRzarIiZoL4SxQ8Y2JQoulyMV2eVxH1fjETZ749RybKFEMaNeVblA>
    <xmx:zzRzasRu1tUPmBL0CxZqMK_P7TmIg7dRVTQVZTc9z9tcP4E8AX6x1A>
    <xmx:zzRzaiubfczVQ3iOm3Yo94GITXkVJJO69OA1CsNMZpmncT6lUulH_Q>
    <xmx:zzRzalb7wJbh4SKMxzOaUX3S2oiLn9yndgAQ6psDwOTXCPzsnqjVfw>
    <xmx:zzRzamYXlvdjmDzqAjAkEnY9YRuouMF2sxmq8ZMd04WulKbKwjGqyT_2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 09:04:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  Git <git@vger.kernel.org>,
  Elijah Newren <newren@gmail.com>
Subject: Re: git-replay/git-history lose notes
In-Reply-To: <anLXz2vos4zbIciW@pks.im> (Patrick Steinhardt's message of "Wed,
	5 Aug 2026 08:27:27 +0200")
References: <CALnO6CAN1=dgRsYjABfa3CJkGnvb139EcrzS9EnX43i3szOgtQ@mail.gmail.com>
	<anLXz2vos4zbIciW@pks.im>
Date: Wed, 05 Aug 2026 06:04:13 -0700
Message-ID: <xmqqv79osoqa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Patrick Steinhardt <ps@pks.im> writes:

>> It looks like git-replay and git-history will drop notes (or rather,
>> not carry them over) when rewriting history. I've seen this both with
>> "git replay --onto=… …" and "git history fixup" recently, though I
>> suspect it affects all the modes.
>> 
>> Fortunately when I check range-diffs before pushing out new versions,
>> I notice notes have disappeared and can "git notes copy @{1}" or
>> similar for a note at the tip. Recovery for the intermediate commits
>> is a little more… involved… as I'm sure you can imagine.
>
> This somehow rings a bell -- wasn't there a recent discussion about this
> on the mailing list somewhere? I might be confusing it with a different
> command though that's loosing notes.

I recall mentioning the reason why rebase and cherry-pick behave
differently with respect to notes, and why that is a good thing, but
that may not be what is ringing a bell for both of you.

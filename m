Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8963126BC
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 00:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781829289; cv=none; b=bvsVW+ASKryyJajQuyKITyn0aDFpUqEYeSADGXsc/a19gq52B72NJay5ryz9fQzaA/bbJnr1JUfktvXk9BNXQHt+JeNCRxn8nPsACNzb0g9mg30ZWqhAkpI1OQ+rRp6w6zRorflQkoxxF4Sfh+3LgDvRBHCyfucqFtFV4jotGEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781829289; c=relaxed/simple;
	bh=ROr33kuSwIW0nlcGx2HnUYLTPmQlYrke8QLknHzh9R0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vGVWs4/SAu5JF4lXTh9uEO1nOZ1DtnPgMhAmkRa2O/U5okICr2C6lzAXR66n5Y7d8FGKRhXfWIiAZpC05SUkbDi+WqX2yPBuRvpOFKcA4s6RguOihCODJ9nZX4tKgtlMUlqiZpx065ohcldgWZpWkaj6Mx0m1/9T9HrnHwzyySQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nJhTxwlF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KdMj5oUF; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nJhTxwlF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KdMj5oUF"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A1D947A016A;
	Thu, 18 Jun 2026 20:34:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 18 Jun 2026 20:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781829286; x=1781915686; bh=P//cQ0Feqm
	bCKarNURnQNxSTzyB5YboJlmQ1pEXuMuw=; b=nJhTxwlFUjsCG2u/GilYdLQ8/m
	7O4Eguh8/8qDOp5X3huDx+Nm8CxcTyIPMGLqxbkUZrxtJGO1VHsVxBUbFQJ3LkR4
	f2aUEoYawkVRVjd58iHC2lxBUkyq3kCskC5XT4erSwpYkzsaa3cl78WUZoBRad0b
	QR1ngJCcm6YXCROr+Deubg2kUdnpSmmxTSihtAkVSiEhQFHQZZctfC/VrUwaXc+P
	YvRhk1+cd3Zr4rIYJ6nyqJEGYQqtBgS8tBiGcJRyPJFO5Icq2f5VpetiuBT6l6YH
	OFZMgZhxn6V4Zgccy7zs45ek1i4PF04G5YI0XjN33T4ME9zA93+y2Azzxvjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781829286; x=1781915686; bh=P//cQ0FeqmbCKarNURnQNxSTzyB5YboJlmQ
	1pEXuMuw=; b=KdMj5oUFDMc7qZpTOqTOwWdbumMNLTpnPyOYMI3vGL4fB99LykY
	C+RroXYUgFM77ftqD9/e4qgsdMHzouNvtXi8rCoQL0XcO6uh/nx0dntxM4j50bfs
	9SrhxSe61xAsv3SKrnCOLRgF8rI5djjAOZQ+rJxgeZe39gMU3ulSdM+Aw0HU2v4v
	bxzYAsSdhKRvdjBfj5DngLYMjwD6HqxRH0A52y58vxWV5XoKPkDEzJSCYyapse2q
	Xwv3TlgtH3myOsjXhQPrYwtGPwN6olU2oiAmKyZvA/eogvug0xAbx1QhM2u5cnRH
	n1UCxHuwlfymk05S6sHDKwFmu98pd+8Prhg==
X-ME-Sender: <xms:po40aoIsum5v2ujeJ64cmeT6eQcS7KuZ4FWdeligNnewR91MzUFiWw>
    <xme:po40avClRkhD0e5jd-wzu4c1OuIVkxAmX_lolQ_OqE_2ZA9hiqpg3-oe7ltAfms3e
    X_zpx2cdYuXAP94XVaOrXYrXsNAuwHtSMo_kMYK8qsgo3tKhBYGZg>
X-ME-Received: <xmr:po40ahDafPubXPSbrKTRxw7oyOpi0t5F9U9VjXLmP0W11ACRwBFsYkTvwuM4l5eguUepjL6jwpola8LSQIpRw6JoQwAZTPSVHI3r>
X-ME-Proxy-Cause: dmFkZTGDf/aQecQIn0BpkDUpkYfkQ+2M3X4FOr8FVM2CfCnJv/0Pz7rwXTtZ7LSojQqj9C
    qZJFAHdegaP6zM0+0BCLV0llFsX7W2IX76YTZgjN6/jE3xJUv/m2xif8jQMNhqEZ8/drct
    nSCro/Z4RMCKybiR2l8mcn4q6KeneqtKp/ajEvRU78shB1qW6s/TmR1Au7ESiLpnixjLeK
    suiPT5NN2kELedboCb+/KVhrOC/kwGo5esG1VjMpukGN2lxZzEyNUpF9V5k1ksYF1PK4dg
    bDQOAWjMKlylKrtXe3+Gg+AA8HAaFh0+VMnx7zDht4ihQjhJFulxoWqEVHk7oAr9plTzSw
    BG+vJ2qgMVLCqXSPys3Bs05EaYfcHm4D9npxgWs5WS0Gx4opRoeK2eYt7k8BhprTzVfldg
    61WQcHmmLjVjUTU84gn5GuTav8lG5tYamCzmu+sdFQ8tBM+dfWOZmgcrl83yi7UI/fHBFG
    paWry2UfRvJLgZ4I94mNdMQIHzX1oTfR67BZvK04Vv+yGau22ArEzJrIkhIEMg6Xwu/0RI
    RLG3BQvf4zKjEgaoJoVxFLNHyJ1GT8nQTwAPGGQ96t+LZg7QHJkBPesVLwc8bMtB+QFieh
    xM0/Hke+51Xexz/7dLVVymkFH5+Xwe548w/af4SgtY+yGxaly3+oNQ3jx8Wg
X-ME-Proxy: <xmx:po40ahBjdKzwidQON2mnBTl82CMefSvf1Gf_juK5PefQ50zCiO2hFw>
    <xmx:po40aspKZGZL5-Qc_Ne9zS0mW7N7AR3H9GEybdRKTOwRrRpMll5U6g>
    <xmx:po40armtGdYUIS8jlMN5Few2Qm0qUe2005x9Z6FBjl--rwLCfRcK2A>
    <xmx:po40asx1yCVvbLxJ6aKNSyd44tngxRG2FX5Y3o1OLAeQx-G-sS1Wbg>
    <xmx:po40akQ5t3KEtnYbzIEC1PO82IJDB6X26cPTKIfTAyVrSh0Alb6o6bsQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 20:34:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>,
 git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v3 0/4] history: add squash subcommand to fold a range
In-Reply-To: <pull.2337.v3.git.git.1781810226.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Thu, 18 Jun 2026 19:17:02
	+0000")
References: <pull.2337.v2.git.git.1781512625.gitgitgadget@gmail.com>
	<pull.2337.v3.git.git.1781810226.gitgitgadget@gmail.com>
Date: Thu, 18 Jun 2026 17:34:44 -0700
Message-ID: <xmqqo6h7nza3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Adds git history squash <revision-range> to fold a range of commits into its
> oldest one, reusing that commit's message and replaying any descendants on
> top.

One thing that just occurred to me.

When you have a linear history

    o---A---B---C

you run "git history squash A..C" and come to

    o---X

where the tree of X is the same as C, with the log message of A
reused for it.  That is simple, clean, and easy to explain.

But what should happen to refs (i.e., branch head) that point at A
or B?

I am adressing this message to Patrick as this question relates to
the grand vision for the "git history" command.  I think "git
replay" wants to rewrite all the refs that are involved in the
rewrite operation, while "git rebase" (without "--update-refs")
wants to leave all others refs intact and update only the branch it
was told to rewrite.  Is it the same design as "rebase" and
"--update-refs" controls if we update _other_ refs that happened to
be in the range that are rewritten?

Now, assuming that there do exist a mode where the command can
update these refs that point into the history that got rewritten,
there probably are at least two possibilities.

On one hand, I think it is reasonable to _remove_ these refs that
used to point at a section of history that disappeared (like the one
that were pointing at A or B).  Perhaps A and B were pointed at by
two branches or tags that were used to mark "up to this point things
are broken" and "from here on things are fixed" (i.e., imagine a
manual bisection).  After squashing all of the commits in this
section of history, the result no longer has such transition points.

It also is plausible that users may want these refs that used to
point at A or B to point at X, just like the ref that used to point
at C would now point at X, even though I cannot offhand think of a
good story (like "there used to be transtion points, now there
isn't" I said above to explain why these refs should disappear) to
support such a behaviour.

Thoughts?

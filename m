Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED6E1B808
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 00:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790729069; cv=none; b=QCrCypkmQUot/pYyWV8Pprvox3s2tAdp6oqmeg69xs2Zp9zBQkYxjZZyppat7ebFJ1KwnvU5aC/4goYozbHKPiD2vN6/CDS6ukJD0lSy4hkTcpDO4munJmbhos4cAuS/pwR2xJDxoQN1R5rtToAO7+mbBbj7VIy6Yj8mMn7+Acg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790729069; c=relaxed/simple;
	bh=uh0h08BP0so5WQkSBw+g9oDelkzQqL4mugSzEy/BCx0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XhDFkUkg8YjjOKuKGLAWZv5BZYe0bsYx7om9ILQpkF61cUEYhU5gCGrtx9AMiafef+IOlwONexDxVjMQgTnS9PuPI/w76njnlu3dmCHVevpCMHL1iZC7AS+Gb8aljLfWNZmD0ErZzYKqEQfC2xidhAYMJXw2w0gC/KMJaQEZXDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kTGEW323; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=defJUQZW; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kTGEW323";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="defJUQZW"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 9FD6E1D006DE;
	Tue, 29 Sep 2026 20:44:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 29 Sep 2026 20:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790729066; x=1790815466; bh=Q8qCwaidmm
	JU4tDfzlEx4KQim6dqk2yL0eM8lWpt6Mk=; b=kTGEW323pQRq8Glm6iEsP7iyOM
	1kZ/8O0OL64Leg3l+S+gxEqA25cjA1gFukQWWfTFzMJPPTLb6mjEsOCPij+3RAjD
	z9ZWkFiMVmqnIdtShY9b+tgj7m6T8J4t+hMdCi76N53V33tv29Ysk8pcFuVWz7fq
	7eT3dXs9CgBT3AwU2bB2gzcSEHVns4i+ZLAtVJgRDz9CG5GoUQpICVbCwgzznAEa
	sFWEIyUK98FVY+kSh1WLV00+CTW3GSj4uNkireeQX5hLM2jsJeEe03Aj0EfsgTe1
	ncwGjAT9p0VIyDzB9UkTq2vJxG91pzVrxAuz7WwgWa2GOxSzhQkD8HC/d9Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790729066; x=1790815466; bh=Q8qCwaidmmJU4tDfzlEx4KQim6dqk2yL0eM
	8lWpt6Mk=; b=defJUQZWpDh7SnshsgefKUcTW7RPjVm4ceobBazKUbg5026/E5W
	g+qy3uV39JNMYkArrNkKQsEa16iNne00IDErORcREtZXSku8rNz98dZSywNSH7c1
	MEAe8/O3XvUZ33bVs6fEtXX1o9BZJeVWVwsly3SISasG1y7wn3KMvHvkPSi2Pjhx
	mPY47xut8YftBUJImlt4ZesSW78FMaFxpS4qYT3gU+AG9+fhCu7H27LLeXe1tHX1
	g9/C6WT3MGgFdDY+8vvkd8XdITuS3TSMnqJms2NU+fieCDNVp3KhPXxoS6VC0E36
	C5oepvPVJtvuGFn0f5kW64W9m+ftMz0PjKQ==
X-ME-Sender: <xms:alu8akUq3yXxYyT9uQzGsMM_182tIedRrNg5obl3aMZdRChffljrqQ>
    <xme:alu8apRrSvzhc0DLUiu65poP8F-Vz6NfwuoAnT_at0t8UjrTdyjYL-Fw_hdz3bzYh
    D8KGc7CqLNhk_TvnK0ptZESTF5eNVJmTemVXYiW3v0fBU9kv6360lk>
X-ME-Received: <xmr:alu8ammaexQuwfIljyq86wQHmUbq9HlpuT6hsF7QVLdAqhiyhAXHXtwGjsO-oEPQSbAU-0eBl2TOA3BH-fUefReHSyDJK7T-eoB5>
X-ME-Proxy-Cause: dmFkZTGt1zQ+EP82k2AtlEyklSEYptHFFuX5hsyGbG40/8rqA3R/gW0T7EcR65DAmC9oWa
    KPSpagWnzmjjvmaChFVJYJcpWlcPHymm4wFABY8HXmff8WVMxpK+4nJxrKvshHocB5pGn8
    Mg67WB8o0IzxALvNzgzvt1+2fxoU2WH9nvb+am3gdBNACByHNFOh3C1qdMwi7YehtkGBWw
    E9mrdjuP7u1XfPHRSeBjG8t6xFmO+K/udnF+RzNLI5nCvP5HCma1jS0OD47eZX0hFlif2i
    fB9DTs8MPgDOU0fwF9uJpHwj2xj30k3D2YaC1qdU6DRjQ2p9Nn/MA47qDzc07jUBAZgJaR
    h2jX+CDS1azh0sGVdn7dqWSKTGJKrjrPPwBzj+pzQOx634sk6Su1zFJPHXKA18DNsw/VdF
    D3Mj2bjoJNowsD4b8CQaEI2uD1OA8nqimwkDWF74Kn0Rivke8G2PD4VzrXltWvnv/1sdOZ
    n08xK0H+N15YDMPlJC0g2bmHxuBcLJceZ8rEkjuFuMF/a7DQv+9SZsqMnFy5woE8hcpcu8
    Mu2TPASU0mtmJQIiMYAfAOGSoKKNS/YM1gVxS9GfQKvOCtBI/c+SRWJUH8AA3/ByBXQprg
    4rfcWwTjalvg5KGHt3+4keCpcwOvLseOGJcxtRF8FZq/JTgGPT5chlpwVouA
X-ME-Proxy: <xmx:alu8an50dH5bG6ZtW-8JzOhc0EKsnjZ1AeqZEDdsPzsJoRJPvjNVYQ>
    <xmx:alu8akgpQZSwP25l-ack0_2XwqgtQ1rwp0t4PsTgoJ08Jf0oeyH6rg>
    <xmx:alu8asE-nrdmUokH-mOj_ZuThZ_CMMG3X7MMFbV9ZTwe3g6LhWL3zQ>
    <xmx:alu8aiTcOia5WzLGbky7lR6lkGfgLv2tJxZ86nkQlUMODT3vIOO2mw>
    <xmx:alu8ajxYxAg1KGXO6rewkXcNKZJX7pSMHv5FqKBoFlgfcCbklZaWleQm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 20:44:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>,  Thomas
 Bachem via GitGitGadget <gitgitgadget@gmail.com>,  Patrick Steinhardt
 <ps@pks.im>,  Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH] t5520: don't expire reflogs where it matters
In-Reply-To: <xmqqzex0hzhf.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	29 Sep 2026 08:02:52 -0700")
References: <pull.2243.git.1790606282769.gitgitgadget@gmail.com>
	<89E3CD2E-8366-4C5A-B3A4-8F44AC5F89DF@gmail.com>
	<xmqqzex0hzhf.fsf@gitster.g>
Date: Tue, 29 Sep 2026 17:44:22 -0700
Message-ID: <xmqq4if7effd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Either would work for me, but I created a synthetic base that
> includes this patch and queued your last iteration on top of it,
> before merging the result to 'seen' .
>
> When you reroll, I'd reuse this synthetic base 4d7270214a (Merge
> branch 'tb/t5520-reflog-expire' into dk/stash-apply-index-incore,
> 2026-09-28)

As Thomas updated the patch, I also had to update the synthetic
base.  It is now 59d1ce1b6e (Merge branch 'tb/t5520-reflog-expire'
into dk/stash-apply-index-incore, 2026-09-29).

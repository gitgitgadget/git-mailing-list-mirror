Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3C018AE3
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 20:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782418927; cv=none; b=fmWkpnGca+JKhPKPcSiyauceM7FO3FkkRxqaUJsJcaxFWsdaqksNLVqTn78phx+fPiDNTp++wxKPE02J5WTpZRYoiPK0jTtUs2PiMAFlcOxO5Xt9+ZHxmSZpwQMtauykvZZa+l3kvPrXmJebLZuL9wA3mn+lhiJ3gwRKDP60IYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782418927; c=relaxed/simple;
	bh=nYs7JMUn7JGYNL6GiJllKib1KFk0JDdoppKaN4jaoLA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B20gM12IYVkyq/uRCLdpoYNY23unljq8PuntwIT4hdHTMwxgVilDWe5J9DlRdpueoXUzNLmFYvu5OreXc9dGBgi8VjoMWmNTBdAloFLNa4PgJKNY8iorFdyKJS9+kIP3WBk8YNTgkk5SnhiUl2wqM+X5eBGQr1aEH/TYpQttHe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V2s/+/yx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OBhp86HY; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V2s/+/yx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OBhp86HY"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 09041EC02D8;
	Thu, 25 Jun 2026 16:22:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 25 Jun 2026 16:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782418925; x=1782505325; bh=eFwJjKbqzy
	uqAv/Q3K3XJ4CikeBvT0+9jKF1she9HEQ=; b=V2s/+/yx7yNTlqpxoYN5KAuIwF
	dE5Xaq4NuE8i/uOJpRUMROFx7Z6qdy0MszZXm4LE5a7YMBfH4psJGSmPu+g0o3gO
	64JvMf5JZEdlKKERVoU6Lm+c+6QvBJdC8O5gMHrkE+d185F0r/6Hkfpge1iDEfXP
	JPBKjbgdpd6jCB6WFbYoG77Jqbh6DnSf4dQdQUy/ek5cXLCvyOt7zLkQImQr9DNG
	yJHUE3S9sf0zBx5dNOjBk5JFJ82bSmdHCrZA8YL2EJNw8i768XrOA1LW1HS7RGhM
	lzLlwj4pNQC5inainQjLWGmaU2g/U8WciCY6yo73L5KHuFxjpzxcYSccaHTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782418925; x=1782505325; bh=eFwJjKbqzyuqAv/Q3K3XJ4CikeBvT0+9jKF
	1she9HEQ=; b=OBhp86HYvElRZbtgqIFgFgGZNmKh7drSmmZ+wQoE7SZyFwPbhON
	dIvkteDTw/grtSnLRmRovli38+IeGyzv0wD6ZfKmy3TdLLiazZ5kmBgbxLIIdW3o
	5zDIRuPYeM8+dIbL21m9MdJ/qOYtkEfVUeXTOSdAeH2d6zJ226YaT66D+6fb4NOE
	BDFldr1WBu7fD4a+HzCkVXS2wLb1RD+fhWQd4iuGywWgd1V+1fbdMR0oRwhGxM8r
	FWSwfiLcfNE1uULTLHlLE9QVppu0V0AoxsmbD5BMPCJA+7NIdOBSRq0VAzMI9rgt
	83+YDNjh6gdEP3mzcoms3ZIo8k76wTNICVA==
X-ME-Sender: <xms:7I09atkZ4aSpc-xg0oOfbpZ8mgifwvtNGILod8ttfrpqmKAZjorGuQ>
    <xme:7I09av23S9Y823LuYntrOYRQWb4tHUYuSS7Vdy3ghMS5fLY8kK0J-tATQERi37uwz
    atFlr4S9ufPL56OMWcWTriwxrTDx38dACNNpdrZDUK4ZKE_bC89qkA>
X-ME-Received: <xmr:7I09aoqysLYZP28fg9m7mgA40IVnQXgkd1XDKg9-ARGOdunTl993ZSwd6at83mUZfZI0DqtsMWwu6M1XhNEhJQsECzhuv6IZ-gzw-48>
X-ME-Proxy-Cause: dmFkZTFXEzcAgMAFKa98ZmnJbY8r6JeDpIG0VoldjI50O8hBJN+Xe2OqeTojjqIL1LbX+D
    6IzqdtmOnZRXPHZpJ+hmdKCbmdI846LepyP/3u/AP2yFbrJzIgla7eG9nLCUTJ79xsS4Du
    1Z2RcFWT3UM+teI0vR4NjEd7c0ceeNnJ7iQoiQejqxIpp4z3yG0d0efzUrR/v4GTEEQFnq
    hFPe2YmgUoZirD5uSovumV+adhKMM+ioPli/Nz28gprWykQdqctjfoLg9zH/J4oQXPF03F
    MT7tZMZyb7EntfvfmumJHvia4dHDQyvpGuejImFGdtE10Ke7lLRe4uUoGOrPVcj2pmHSrH
    f+10lU55upoOwvJn2Lga1n6+fcNCewcRhfeygsEpN2g8oAV7vpHrkENs6nxG8CeB33j9HT
    obFnoGcmS7w5dp2jL1GjNPRpOijMdW7pMz9zTF1DFqHuN13SFDaFc7ih+sj1Q2GbkmvTBt
    bKI5ZeN8uSrAHAgTCFVMZhSAfmL43Ap76BCZCyAABX+Z7IstkbDyeb8+pNgoWkbeqiro6+
    zx+R4Um7fr0fQfGfQ+uBEnDLm44oQfCo0OoiLjEOBOHESInUscbQZcEuvt/wyWEqVyeFBp
    Ak9UyqjCaKTP9pctraOpl+jwomRde9l8AcbcNYT3BQgx0oNClj4jFH/eyZRA
X-ME-Proxy: <xmx:7I09ascO_KVhIBONdJjMvOShq2wi44an0io5p68M54PNCNJD5Sg8mQ>
    <xmx:7I09anpKTgAh0j04iuoy0nFkNSRlhQqulpRMJpIKY3twDHo2Ck9kgg>
    <xmx:7I09atGfTTvBkMgxwGxQBJqwBBrqZimo_IGNoLYQA7d4cKRnG_NoQQ>
    <xmx:7I09anvlORg0ZFh4JehTD8hL1QevFiRqQFVxgLEn8FMgtKXVbK_oDg>
    <xmx:7Y09aqvO5sjJQ48Hcl7eaJQ3JU7rgYzIp5kLRYvmob5uES9g0SoYeqC8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 16:22:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 4/4] connected: search promisor objects generically
In-Reply-To: <20260625-pks-connected-generic-promisor-checks-v3-4-7308f3b9dc44@pks.im>
	(Patrick Steinhardt's message of "Thu, 25 Jun 2026 11:57:42 +0200")
References: <20260625-pks-connected-generic-promisor-checks-v3-0-7308f3b9dc44@pks.im>
	<20260625-pks-connected-generic-promisor-checks-v3-4-7308f3b9dc44@pks.im>
Date: Thu, 25 Jun 2026 13:22:02 -0700
Message-ID: <xmqq4iiqfk0l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> When performing connectivity checks we have to figure out whether any of
> the new objects are promisor objects, as we cannot assume full
> connectivity if so.
>
> This check is performed by iterating through all packfiles in the
> repository and searching each of them for the given object. Of course,
> this mechanism is quite specific to implementation details of the object
> database, as we assume that it uses packfiles in the first place.
>
> Refactor the logic so that we instead use `odb_for_each_object_ext()`
> with an object prefix filter and the `ODB_FOR_EACH_OBJECT_PROMISOR_ONLY`
> flag. This will yield all objects that have the exact object name and
> that are part of a promisor pack in a generic way.
>
> Add a test to verify that we indeed use the optimization.

OK.  The new test is a good way to catch the issue we noticed in the
previous round, I guess.  Looking good.

Thanks.

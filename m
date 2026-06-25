Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D045B3254AF
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 20:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782420647; cv=none; b=YZHZSn0BOoIDCCr4D4ccX87CFkeiRXDLeW0cu+T0CqIrRFVoAWiyPf9Oq+igHSN8wUkrDvB9b3FjZ8d0knRztq7iyklMnLSmiUu59QVvN7eO1RlgTLFFpkJbMJZkL0Qrkr/PqhZh7Jk4ln4FKQFTEd7zE6iXt2mGJg1dq880Gsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782420647; c=relaxed/simple;
	bh=jiDDZKsGvMxIBZust9yNdrrbeCBDbFkzh/yJs+CK4/E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o/QM0jKt1+LC6Uag+muFR2k+zlyz7z0rxEWfeO/H2mowSA16Ltvdfxryct5cks08J2IU/T2D2MJwaurNKhuNSky7rDvoAl8gHEUHKyYtKnMKXe0rX/O8SEajC6Veb3jg/h49Wo8pmMmC09lCMIlB1h/s2EZ6FAiBua35ZVQPIdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=j6phFKKG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EQKI9VPc; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="j6phFKKG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EQKI9VPc"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EDE911400093;
	Thu, 25 Jun 2026 16:50:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 25 Jun 2026 16:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1782420644;
	 x=1782507044; bh=5owX5fXSqkljE5FA1eRFlKIE4hd7ju7D59RmGhyNZjc=; b=
	j6phFKKG5QULLxDwi27TTlvLI83i5cqB744RiizuRNPKJ7KVDpeGRkDfmvoERJx/
	OAjjYbn+6Cqk8/rZed8dWEzrb1udMy/5ehQkAfc4wNwUGtyfNz8lHOEy03vizEB1
	dSNII4xf6jk3So6OtEGHlhDjuf7ZWvM1BHwdz2jYC8SSXhHkyyMCyC/D+78Z2Ai1
	WpwGMLF2vLfwKqhOSqW2i1dp4ai16zLXArAoQ8hu6QDib60Eu3Qibf1A+sQndgJe
	00oc8zpo8rdMwq4HoO/2zaUxnPjE+zL0VOfwziE650LM2oM48xFQKASK6t05jNrE
	lnDAOSRaZY5IGCuPZYQ8Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782420644; x=
	1782507044; bh=5owX5fXSqkljE5FA1eRFlKIE4hd7ju7D59RmGhyNZjc=; b=E
	QKI9VPcFHcfHSAjJ/GrBioRof2hTtRLIiUcbk0CMjUHcy2g4aITGrmvEdFBKJWKp
	Zhb7wQJfEaP3vKYALIQyip5uMR7NTtHVYDb+547Yeq4zrw9x7faLPc/RzNX+w8EN
	KQsf0OooyqqIdeex2eYcrrQzfJtrdIGwjzopVkWeL4HV8BWY7vrrC9Y+EKJqx6k5
	U+9q3OW7tn6yV2ZPi2AIMNF6voZQpOTYeKRri+76fMw3qGO7kMV+qss5Vvm4Adqw
	mgl8kBalSrvJ+fnuB90G3TWyiaxR8cw7wjLNw11mHUTNyWy/TEspOCgFumI3KE8M
	mTQ9X3kmi6dlj1YtP4jPQ==
X-ME-Sender: <xms:pJQ9ao3Js6FCuSyVmf2dnRRYmuzmRAL6G0PbEwRsjBdLnlioWKPvPw>
    <xme:pJQ9ajztTANhMYbDdEOCwHmgqCMCjrohSmcIJXd6KRCtZliMk5QhsOt1Q6CTbfzfE
    6XD0RlmJlLZwwdBA468UhElT5kezzvC8ME5EkCl0mTlDgDLPBPQ82Y>
X-ME-Received: <xmr:pJQ9avG-6Yd4QCx90iYYUEKoYVWeD-ZQkOf-XI9mFnVHE05JsD4K3LoGWfdAAR_2_HAtPMtfGEsezrHP3nhlU3WwmNhO3xLsBW89ihk>
X-ME-Proxy-Cause: dmFkZTG1qVPTt6919VZzsrDy4RwwepWmQWW/unk15CSX2yLqYO8eW21wCUjxGbX8SpCT9k
    zJKdtxgP3tdI1rSAh2bjiE8UUvTPDchA0v3wwCs/a+BNsskilzy/EuRNADxwMNKXd23O1w
    QM7PsOBdR4OBRcNXy4sc/O9/W6pjfvhTShL6o81NVDMcToQvCr9MJFA+jn8TZM1zgIvOq1
    +FZb+Jl2N/S5hnhvClqP0BspNv3CcPptPVUoDdPMjKYwKaz+onx97cnHM+8+xfDYBnLVxi
    cTCpfL0O8EX6J0muLMHxMRM/WlM0VedelAam36/GwFaUnEC2g0RGaWd9MV1uUPyxe/YpME
    ++IdLU1yZJTuli2l9CqdqAZ5kYuF46AvtapzE3yIos1BJp4BD+X3AnEwg6hRx9K07Fz6ni
    GyT7AejcqFEgEQFILz3MUPr/kt3/8efgRBATwvcBLIhm9BeqE/4M88KfbyPUIJoapcybp/
    F5CNNYAA/mNkhjViw+db2TRNXNSn3CkiO8njuZJL8Ucs8+Y3PBO0/sJptfiLvOTu022eY/
    7O75j6jgkmHPvSTKgsUSzsSCzGAC2Bp2xxUyimn+reoaX2b2oF6GFXuWRaJBUoAjU+S2Ku
    Pg+7tNyw6M/NfxTWruFRt7b3A/WOkyvMoEiSo3WHJ9s/WVtkW4wQL9SNIUDw
X-ME-Proxy: <xmx:pJQ9amYyjDZkM_26gVcDn4qBCZ-bU9YQPvLOd00R95ocIbVeT7fwFg>
    <xmx:pJQ9ahB124zgW9FRD4--GjN6mC7zfrQoBOzRKhG310bFTU0B8RhAOw>
    <xmx:pJQ9aukyxn2quSbvQWBL3R3I7_QZ9vbvXEi_nl-pVA5MQ-87Aw7sHA>
    <xmx:pJQ9aizBeS-3z1IiVs1X51Al49oY3c71X_2MLpp0NfNxsXcHvR61MQ>
    <xmx:pJQ9amD507UwXaGIj1h-4pmBuIkVJyAj9SVDpHLSrJ6zbPKvzRH38sfu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 16:50:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Pablo Sabater
 <pabloosabaterr@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v6 10/10] builtin/history: implement "drop" subcommand
In-Reply-To: <CAP8UFD3jsepRaiHDen_CzWcse-atvBfCdzAQovk+1csaQeDxmQ@mail.gmail.com>
	(Christian Couder's message of "Thu, 25 Jun 2026 15:51:56 +0200")
References: <20260615-b4-pks-history-drop-v6-0-2e329e536d78@pks.im>
	<20260615-b4-pks-history-drop-v6-10-2e329e536d78@pks.im>
	<CAP8UFD3jsepRaiHDen_CzWcse-atvBfCdzAQovk+1csaQeDxmQ@mail.gmail.com>
Date: Thu, 25 Jun 2026 13:50:42 -0700
Message-ID: <xmqqo6gye44d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Couder <christian.couder@gmail.com> writes:

> On Mon, Jun 15, 2026 at 3:55 PM Patrick Steinhardt <ps@pks.im> wrote:
>
>> +       /*
>> +        * If HEAD will move as a result of the rewrite then we'll have to
>> +        * merge in the changes into the worktree and index. This merge can of
>> +        * course conflict, which will cause the whole operation to abort.
>> +        *
>> +        * If we had already updated the refs at that point then we'd have an
>> +        * inconsistent repository state. So we first perform a dry-run merge
>> +        * here before updating refs.
>> +        */
>> +       if (!is_bare_repository()) {
>
> When your ps/setup-drop-global-state series is merged, this will look like:
>
>       if (!is_bare_repository(repo)) {
>
> which is nicer.
>
> So except for perhaps the replay_result_queue_update() duplication,
> the series looks great to me.

Thanks.  Let me mark it as "Waiting for response(s) to review
comment(s)." then.

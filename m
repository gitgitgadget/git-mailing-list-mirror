Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552B138A733
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 10:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776681163; cv=none; b=Y3aCzrMaSNw4wc+QOwMugGQsc1XtJOAGpMEHpwSoSmbhgrDiWwsMDxHZ/OaByVqaHo12vfp4sSsHJPiowUtRCxGGX8P752rHaoWX/TbcKPyMOhgsmXDtupubbrJxcX9eHH/r+k0OrM0+TXLR+5xcA4pnG3+htPsV683VEheEn78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776681163; c=relaxed/simple;
	bh=fcKlDX3qnBG2GOEkbfba7D3enMLCYUnVKb7Cre36nyA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AbAZMKfS/e/6pkrhj7rXIBoxfXsaUwb/kjAJ+/bGpUD9tqcguCbxco5+LKN/hiImnQVWVDN3DWjTIKvHnTu6vSJZAywENdhxPTuiqih6Miaj9cMu1pKzv+1mYdafL4/0fc2fdxlfLsgVfIWDHXkKnO4k/bNeTCeRl+b+nSVB6xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mL2AG2KO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B8rsrjw2; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mL2AG2KO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B8rsrjw2"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8EB84140004E;
	Mon, 20 Apr 2026 06:32:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 20 Apr 2026 06:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776681160; x=1776767560; bh=05t6er7ZyA
	aS3BkpZpgwiEZluO25N+6hvmx2oNYspMI=; b=mL2AG2KOa3kS4c4P1c3HO58sUZ
	HQEQ7FLbjCOLChg4T14TwBMegbbiaESCU11Dup7JF6gPZAyK51EolR9PWHByWqvE
	//IixwD9Upqw78kI+uYyW2qJjzUeAlBoMazc+j8TTkq5jVODySepiVtpEQkx2VAb
	fwreGxa1qxq4qH+DOUOibxds2tQHe2xJ0XuBcW7fmmaM4sFxFkZKaXXJd8AnLRm+
	9itgtSMQiGJ5TdSSxnwUNP1+b6OGIj1z+dIN93fHxtaR/LsYVMMblEuNkDw0fjMs
	95t8nFtVDJORVaVLa2xLqamb2A2e1NmeCTqPhUWkc/vWsxCo94Tp3bUZpgeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776681160; x=1776767560; bh=05t6er7ZyAaS3BkpZpgwiEZluO25N+6hvmx
	2oNYspMI=; b=B8rsrjw2AEZMoi68BQX9qF0aW0zzIAPoD2fTrVfTeRpNpW7r6t9
	d4a0nk/09n8yEgH63ZL1mJri2vwyvQjpigGNB44q29y1DuzBuvjXm2JuswiZt6GV
	j8IA4aanGGa9aG9k0W5fk5s0K7O5s/uZIq3nypLvM5HApZ6bm3cTOTYQcNIatKWW
	mnnkt/97qdtpQ6d/kuwqHQdKTDqGEZS5Q36Z+e/mQOMIsPV1vFId3MWlFlMVNgJp
	kOkluNByCGVGSjhQtPhI81EdG1LJ6vgGCw0lDD2GAZyqNSzuY6A6uYsCxths0Jni
	EXHEIMbOsYJZK82o9bSvF7kX9FNDUsuX8zg==
X-ME-Sender: <xms:yADmaV-9Jbjfu70LTD0GCwqmKvDgVCN5BNpChZPKV0Lp1ytl0SMvqQ>
    <xme:yADmaQni9WD_C5XEJgCrGeT4hvVzt8bClBMZnr3nHimd5nK93xDrmWHHo_XVWKUcQ
    ZJIYrTfMzbmE_rP_PzBiDUqJzWI74de9u1kQM1AfS0UYWXxiZ-BEg>
X-ME-Received: <xmr:yADmabXmIwM4FcahL6XNSUwptYrPKEyrgf85oHhX9EjLriua4CDJAspr-zRjGYVzbnglr9-dy9Yj5PPYh54c99yFVgK6-Ot7iw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehkedvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:yADmaVEDDcInqB-sXv-ebYNcrU0uQ340AVsvbfe7qvCc3T0wwu_NKQ>
    <xmx:yADmaXfsRtLh7sUmEeCc07WTsufQThjOM_C7amq0VK9arE-imHLqXw>
    <xmx:yADmaWLyVXQkH2WHkSSaZqqg4NpbSYYRKWlPLWkWbXpL_TVj1pqAdQ>
    <xmx:yADmacGH7YQF2hVOs3DlykDcyhUlzFB0VEIydkDBHTsog3bKhQUz1Q>
    <xmx:yADmacVUYZbBN_PC0Ko7wtaRTWCeAgqSiXQurLJ0LgfpE-oL-YVBOUdf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 06:32:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2 2/7] fetch: add --negotiation-restrict option
In-Reply-To: <5370b884-30e8-44a9-a52e-4c518556fa24@gmail.com> (Derrick
	Stolee's message of "Sun, 19 Apr 2026 19:00:11 -0400")
References: <pull.2085.git.1775658970.gitgitgadget@gmail.com>
	<pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
	<9a25b0fadebb5f0219ceeca9496fc6f84abd020c.1776266066.git.gitgitgadget@gmail.com>
	<xmqq1pgf6g5g.fsf@gitster.g>
	<5370b884-30e8-44a9-a52e-4c518556fa24@gmail.com>
Date: Mon, 20 Apr 2026 03:32:38 -0700
Message-ID: <xmqqjyu1udkp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

>>>   		OPT_STRING_LIST(0, "negotiation-tip", &negotiation_tip, N_("revision"),
>>>   				N_("report that we have only objects reachable from this object")),
>>> +		OPT_STRING_LIST(0, "negotiation-restrict", &negotiation_tip, N_("revision"),
>>> +				N_("report that we have only objects reachable from this object")),
>> 
>> Is OPT_ALIAS() suitable for this?
>
> I was not aware of this. Thanks for the pointer!
>
> I do plan to make "negotiation-tip" an alias for "negotiation-restrict"
> based on the new preference for *-restrict as the "real" option now. Is
> that the right way to do this?

Let's see.

$ git grep OPT_ALIAS builtin/clone.c
builtin/clone.c:		OPT_ALIAS(0, "recursive", "recurse-submodules"),
$ git clone -h
usage: git clone [<options>] [--] <repo> [<dir>]

    -v, --[no-]verbose    be more verbose
    -q, --[no-]quiet      be more quiet
    ...
    --[no-]recurse-submodules[=<pathspec>]
                          initialize submodules in the clone
    --[no-]recursive[=<pathspec>]
                          alias of --recurse-submodules
    ...

I think we gave the operation the name "recursive", with a common
short sightedness that anything we are adding "recursive" for is the
only kind of recursiveness, and then prepared for a future where
things other than submodules can also be sources of recursiveness by
making "recurse-submodules" the official name, while still allowing
historical name as the synonym.

In this case, if "-restrict" will become the official name, it
should be listed first, and then the historical name should be made
its alias.

So

	OPT_STRING_LIST(0, "negotiation-restrict", &negotiation_tip, ...),
	OPT_ALIAS(0, "negotiation-tip", "negotiation-restrict"),

would be the right combination in the correct order, I think.
Mention the official thing first, and then tell that another thing
is an alias to what the readers have already seen after that (e.g.,
c28b036f (clone: reorder --recursive/--recurse-submodules,
2020-03-16)).



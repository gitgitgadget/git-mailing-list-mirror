Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C63245008
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 17:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782927689; cv=none; b=UWYxQ7CTprnDPDv0O5NbGy8nRX/zOFuIi11BjESFntCadkd80w4XBOtPZA3o7JEBB2bTTN4O14HnQJrMFpNNZ6PAV9YC1F++h3tnG/86plg7OsC17XI1D8GLE7MsjGJuRb1bfHEqZHysAPJ1b37ZnTd5CFghlL+GrYsOFP05Blg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782927689; c=relaxed/simple;
	bh=TKXRfaqOCaa8kYlmMNdryryNafcXTYckgNBpzrX+q0U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZHFAKMoxZMlgbrW/nyEmTtuXUnC0nU0RZKBqHgpmyRwSHKvNWUiz4zsxPFSWHwSqz587S4rzVL/QuSxQXauU+njtLSgtqcZ3Rbjtoem+aDLg/6kDvtcClDN1LVq2J9m8GMECbunBBlQpslN5e5aM1uinGXFOTAApZIlI6Kk8YWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Phw/CtUY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FtobHyDw; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Phw/CtUY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FtobHyDw"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id E6700EC0195;
	Wed,  1 Jul 2026 13:41:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 01 Jul 2026 13:41:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782927687; x=1783014087; bh=A8v05UHsjU
	mN1prMYKnoAT+nyREIBUBKuymp2ZhZE4U=; b=Phw/CtUYuytJOOO+DtdL2U3zev
	1QrZ+7G6vIObkgtuQo3yG0yJId9si5Ay/Zfy6G6snO+b6oVjHlZnFSb1jAL+buq4
	HKLPbYpG4BScQMF7W26NjwVHYXvU29tpEdoT7Xj5O0ZsnrMK7wr0xyTgD2am/8GO
	60/CkXg3xi4Kz5kt5Zdo6orCoKG9UTTlZYh61oM0vuCJR9r5L2X9yEftkTMw0TQC
	3o8WZ+5wdCLPNTAvBDQwWeJGUZYumrnM/qG4ysyja1Vm/YuMTYiTNgZpcqGcMBWv
	0GMzB4CG7AZCuAcgMOOSwDkJOgE4tJwDajaVumYzu1qkGU+JXha05/tvUTkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782927687; x=1783014087; bh=A8v05UHsjUmN1prMYKnoAT+nyREIBUBKuym
	p2ZhZE4U=; b=FtobHyDwLv81+BAdkiBsutviraXo3P9nQw/vHVn5JDent+sR4ql
	I78nhrBNdXEHiWolcDnenXAg8WEtDsgyAVUgnW0M3xrhGj4OBzHidlfqBIiScIlc
	mPL8k6E6SgpzZIq2/U/9x6m+WiOHc+N+B9VOEYA50VXeRTKSyn7VUILb+jptraHe
	F2M1tK0TLz+toQcNN87RdEDJqfyvdGnflFmrTmcazuWuH6IjDQlFUofol6Bn6LqR
	HnyCvy5yA2oHZuQKTZjWj/Ci2bsCJ+LuH0wrcOTK3qskB013wqDBttUD5Q7G50kk
	K7QnLNfZesZpM6XhF7Vf7lIw3gjx4Ko8Fhw==
X-ME-Sender: <xms:R1FFaiURzIb9z811bYgpURrx795Al4bkkgXHvzmX7bHIwrD91fpOJg>
    <xme:R1FFavT4FS-1wOmCJGmzplMgWXKPstnCQbrgjxsrYeANs3DpGbbCz-y-E92-mxnhG
    oK4hPdskL56pdBuRGwm3YUtPIM8wd2BHd_Fr9ouGJNIn47WMNU11w>
X-ME-Received: <xmr:R1FFakkMqyoUYXVj2tJDRjwrGHDPADeRcAETTxD9jZpPQzvyqAxygXHc_qEhgNkvYNhYeRrB5e5bHVHzoSFGyaC3VkIS0VVTaeZ05s0>
X-ME-Proxy-Cause: dmFkZTE68N0jLyvC0yNBnme/8uTvROjAey/k5P0ZD79dFzNMarfMgdvDABPX80zrND3SI1
    iJD7lsQmNZxLUxiBdIRB+JI22qKnJrxw3AAVaKHUqR9/ikEGu29+qMcszD+iNr+IOvDKXL
    2e/9a3mOyW6v8RGf5GVirUHtmcer7LoyzUpivHlwwe3NikY87RLBmnvDQZ48POROMEdKrJ
    7aMQg/fm1U9Sreot0MFz9U2m2DLo2obR8LpIqgukOi6gpY10zRTOYfqBKmfj+lmOvL5pJL
    EsgkbBlM/fJ3An0dqxvBoX83yTl3iwxcaxCI8qJZ6vQPoZmviF73ItxXizTeqU7EdulIX7
    pukNh0vXp1k+LdCqQOTQQCNeV+OL1FB0fq93QzqbljHUsRRca6gswN0rr57hJuRfPAYtNi
    r6qkUf/cwuYg/WGJQr/LjC5912gaX2TqbYyO+NstT+BPQ3pNYaBjRBf1kWcboEOYMJYMqX
    QHOQvpMguJGXhrnBzFsvAI85GG4/tlRRWY/Hv0ECFhBggeJ7YhUXiRFDZ8ZArL1UpqOwdp
    i4OkLqxEObqRaukRU6HkIL1ucVVcXUesjg6W/eluwgrTGC7dCx4pTsoQdRcs1Eeo/uAZWK
    AT1lkPH3ZoN3NkC/a9r98Ftis2hAmBjeD0CoeoPn+5z0YNGWRBHyQWuYexiw
X-ME-Proxy: <xmx:R1FFat4wd8tsdLVVM1ZEdFPQ7oFLzOasW8KKFoGBEx4JEFh-t4e1ag>
    <xmx:R1FFaiieKbwp-lNbyzFwuhlJspQVGYA8rGrfrr9XHMJ2812KS5YeEQ>
    <xmx:R1FFaiFCGY0qC_FtaDVE7_N5PY5i_pCfByRm8Ayo9UCasOqThwxOUA>
    <xmx:R1FFagSMI-3EqV-8OAsXs_PBg_DUIznreFzYgw_O9cKpgFNjDRaTxA>
    <xmx:R1FFahj4ggIgDt3C8NOhpaawYDeHTu1gvaQCBubSzEkBNWK8g1v3gKJ7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 13:41:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,  phillip.wood@dunelm.org.uk,
  Patrick Steinhardt <ps@pks.im>,  Harald Nordgren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v5 0/4] history: add squash subcommand to fold a range
In-Reply-To: <c517bce2-9f39-46ec-8509-bb0893e26ae2@gmail.com> (Phillip Wood's
	message of "Wed, 1 Jul 2026 16:14:52 +0100")
References: <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
	<pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
	<d37e8f4f-d1f9-45aa-8c95-ebe676d54671@gmail.com>
	<akIQLM6xZTHBudWT@pks.im>
	<3b3af3ef-a043-4af9-964e-429237789c97@gmail.com>
	<CAHwyqnWQmObWr3N81_EU6F13iyKp3FfY8KSNFfoAjS4r_0qJrQ@mail.gmail.com>
	<dff9378a-267f-4b49-bee4-615b4bf75abb@gmail.com>
	<CAHwyqnVN=McZjtQGcPnoVOHAd0+VDNPXy_N949VMsqZty3RDjQ@mail.gmail.com>
	<4b505228-4846-4a48-9255-e249f4e70a1f@gmail.com>
	<CAHwyqnXoqZYHodWXHtwnk0_PiZcCYSVL+WgL3h5nWiYx_cSZLw@mail.gmail.com>
	<f15456d2-d8b2-4edc-80b4-3a9d8fc77da9@gmail.com>
	<xmqq8q7urfe1.fsf@gitster.g>
	<c517bce2-9f39-46ec-8509-bb0893e26ae2@gmail.com>
Date: Wed, 01 Jul 2026 10:41:25 -0700
Message-ID: <xmqqfr22obei.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Yes - if you apply the way "rebase -i" works to multiple commits you can 
> end up with a message template that has a screen full of commented lines 
> between uncommitted parts of the message. See the example below from 
> earlier in the thread. It is not so much of a problem in "rebase -i" 
> because it only fixes up a single commit at a time so all the commented 
> messages end up at the top of the buffer and at worst you have a few "# 
> fixup! ..." or "# squash! ..." lines mixed in with the uncommitted text.
>
>      # This is the combination of 4 commits
>      # This is the first commit message
>      Base subject
>
>      Base body
>
>      # This is the second commit message
>      # Another subject
>
>      # Another body
>
>      # This is the third commit message
>      # fixup! Base subject
>
>      # This is the fourth commit message
>      # amend! Another subject
>      A better subject
>
>      A better body

In the example, the second one becomes completely empty?

Is the proposal not to show any messages that will be discarded
anyway and not even show them in commented form?  I think that makes
sense, and leaving only commit titles for these commits that would
not contribute to the text in the editor given to the user to edit
would indeed be an improvement.  For the same reason, as "# amend!"
will replace the message wholesale, it would also be a good idea for
the first commit to be hidden like all the other commits that would
not contribute to the text, so an improved version of the above may
be:

    # This is the combination fo 4 commits
    # 1. Base subject
    # 2. Another subject
    # 3. fixup! Base subject
    # 4. amend! Another subject
    A better subject

    A better body.

or something?  Is that the direction you want us to take?

Thanks.

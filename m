Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39416414433
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 21:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200535; cv=none; b=GfCYQDzFDQz3ezT/hjImlgdpDWQN/44gaio+aUq9a8eHdoVXowy0vJe1ZptH1FV2R1xQ1oaG/GR4fFAn0B2i+0NQEASllH9JM7zkbmAZgqUdSutIViszBP0hkv2Kj34z8sASgbDImQk4hNyb1s5lZlpxBclDLWrmyTHiAJlHeg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200535; c=relaxed/simple;
	bh=Dyr2NXYG8IIA0JWCsVZHfbKiwYoljxzhmpV4J8IQMO8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f3qJ8wm9ZqBtp91+O/N78XgOFIevL6HE0IU1PpNk0Mci9HPW9aPblEEgOICI8rI+IoeGzxgHVbKwOTiYEIS3cHrioF2AjyDPPP0hBYtS1B7XISdA/BC5So4rNbyK6L4FjSPqLpBgx8HkePqcsUitsXF5+RmGo38slbSlfn9iLXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=S0hxvarn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ePKB8fas; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="S0hxvarn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ePKB8fas"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id DB871EC0119;
	Wed, 23 Sep 2026 17:55:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 23 Sep 2026 17:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790200532; x=1790286932; bh=3sAmZzb9Um
	dFUe2Dedbw14Hf2m/d4c4iVUshR2EqG/o=; b=S0hxvarn1Ksanrkr0hU9aRP0Z6
	XGaE8MhVD3m1PYhH3gLIvPOa3miNwMcwqMBMYmctkIUCViBsoLd2yn5QNY57xrZ8
	tOat+77bSQv74aFeBnzRkolrepjhzmTiKh1PtV8ar5dQZw7l4rZkAjQbFE8nc0LZ
	033IhcnKkPpzyCK8+U+7bkEhGnuFlii2Y8pFaP6rZIZ6K8zp6NNgilGcrjBBrk0T
	FCqp6pg4HqrpNUoA6VbRosAY6l6kHe5oW51het1HQgay23aB6Q4OpN4C9I4Eoc5M
	gxo+O9GQ/dBjUixLXZJUby5OgQ1YcRJQ+btlpVnkdyLtXVlUaDLfOK0h7HNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790200532; x=1790286932; bh=3sAmZzb9UmdFUe2Dedbw14Hf2m/d4c4iVUs
	hR2EqG/o=; b=ePKB8faswW8DdYhYxAp/8LE3c1VxShiGP/QIAZnJ3peORweMuFa
	ajGE+E09l3KVK8X3YkQ+A58o+7q+up+1s2K+6yLF36Z3GuvF31cMRmvnE9EjAZ7G
	ZJYkTUU4KFlWt2Vff3Ajyuksb+V8jGRRcCvzwNnJ1rv9clJuPXdlorpt4dubkr/w
	nFW7icMwiE/QlAuyV0Aw6f6jwdiCws+QegJ+bryq2PknFMzG92ZOAo3J8cz8xeWC
	6y32l/1yppl7XP2OTMoz03RCmHVpSx02PtcEzqCcKNbfMjbQxf1nswVgGTArcnH1
	uWcnxQSrW4GrqmwzKYKYUK9rl2np6Xb20qg==
X-ME-Sender: <xms:1Eq0ahdT5V4golhyhMki9F4Wmq-TxktSDzV4fw1uf9MiuOGWWukz7Q>
    <xme:1Eq0ahzrMi70bOnM2If3X9Rpb9MdjqZefefPRABZSBcz4_pDVscN4C0FyD1E1mH1t
    DM0ZSXKzvzUJRO4gum9LNfS_Xn7HhkG4iVSX7qOnS11kvTHZniVWW0>
X-ME-Received: <xmr:1Eq0auIX1_eya_RdByYM8OB7WBdlpRRyLt2nNNHVtJl4flGeYV3TLiuGyF89LgoOfYyrgZL6i7TClPYpPgAgM25jfIu6b9k860V0>
X-ME-Proxy-Cause: dmFkZTFRbRjX748mfB0KGjJi2zo3rlso9ql4oChyap4DwySmasUMCIuAVJJHnEEaW9oano
    zsP1Ua7e+tcLJVy0nVaraXQ8YfPbx6AjJKDIZIFGXaTe5lkrUPZD95u1GGbYNMcoPEX27g
    QxVFTbTSBC1QVbO5h5lCNCVz8aBD2Q4UHnf4lrGsI5HlQQYo3Wo+yBYfu5rTiv+Kssg9Bl
    h26CMr34FolqZGq5t3p7cdi40sJpAzRthar/S48JmAcm+9s6Bvwc7MPYKV2shKVyH7fs2N
    05QyUOFjJR1sPNJMr3l+cbhHEGNMU2jCkQ5oLVdFq4T4NkXzJ4FJmOmMDdyLLsRq44e4oN
    1XW37qH0QlED40vtSI55pRzB1vh8PeKdHNCBjAxtCJ/etWPTMiIUvnj6qUwW5bVNzxqLie
    WgkWIksU4pTHWfGeWTFbuQXcg/YeFmT4rONoV1WNCgjM7bgvETMQPNA4bqlSEU0GvZb1sr
    /ycnVpiDdTx2boe180l7iLzLpQWEzaMiRDjRDkDUE4L/pAMU+5vasSPHVAjbUE0S0ZkIzD
    JlHK0WAt/dcno/Yz6p3avDW8wE2KsnKWEdhxfyPDmW0q1OVeklyN8lo38R12l1BgHr4hQc
    MY9cFw7hkEs7WHVoeaaTi+0ozFyjf3KPF9IcFRjhxPQIv7TSqgrqcBLct04g
X-ME-Proxy: <xmx:1Eq0arHs7tNA19AHiibhn4UeaNoL87ghKi9T1dmf42Wy-mQMq_i1pA>
    <xmx:1Eq0ai_9DRgj0lKafpnRUeva3Xb0tkwjlBTyU6g_EVY0qYQQ6zg6yQ>
    <xmx:1Eq0ajK9YgppvZK4SSpKmuLjzHRsBZE7cpeHinPGwoCiGwT3YeJAdw>
    <xmx:1Eq0aot2JLFNw01NsSrfcAQIf6ZUkalDxEC_NmvOEsz7udMQMdkvEg>
    <xmx:1Eq0as7Itbqf38GKLQRl97-wQhnE8e3SygbA71QoOstmvng0CVKiP9Ar>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 17:55:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Phil Hord <phil.hord@gmail.com>,  Elijah Newren
 <newren@gmail.com>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,  "D . Ben
 Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v5 0/3] refs: report old OIDs for batched deletions
In-Reply-To: <cover.1790196627.git.maciej.ciemborowicz@gmail.com> (Maciej
	Ciemborowicz's message of "Wed, 23 Sep 2026 23:04:39 +0200")
References: <cover.1790113781.git.maciej.ciemborowicz@gmail.com>
	<cover.1790196627.git.maciej.ciemborowicz@gmail.com>
Date: Wed, 23 Sep 2026 14:55:31 -0700
Message-ID: <xmqqse2z63ak.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com> writes:

> Changes since v4:
>
>  * Update all refs_delete_refs() call sites in 1/3 for the new signature.
>  * Verify that 1/3, 1/3--2/3, and the complete series each build with
>    DEVELOPER=1.

Thanks.

In the past few weeks, I've been trying a new element in my workflow
to try compiling each and every step of a new round of patches (I
cannot afford cycles to run full test suite on them, which would
slow me down too much), after getting scolded by a long-time
contributor for queuing a topic whose end state built OK but
intermediate states did not compile.  This time three patches all
built OK.


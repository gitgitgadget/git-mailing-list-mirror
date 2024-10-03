Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04E51C5792
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 23:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727997552; cv=none; b=CSF2Hx91ZNMORIzvFlggcLRdZ5KU1kS9Xn6pRkQbUc/3VDEcRNeny0+8nfO2ypWPXk5/md2/oLj7iMs3XDHbPXLndHhPc3iUN+Uq78yCMkiSt/+ITN29pgx2mTRnN7ZHErp3sJMcOb3kNRcGOpRnsOwikeb5zqhynXIm7yP6j8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727997552; c=relaxed/simple;
	bh=XYxGNat3HmlGxq665ZTZRCxz+4GuPMGbGJyh9eNDg/0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BqWqo7r6YoW4jhzXpV+DTw7TY1orQ/SIW8trELhuoK8FYOlTfrxrf+Z93DQEkQ8vSMyEHtQDKRp094QDM3rn012zSaL2huNJ4GdInLQlX/RQRtLVVeNUyeGUVQnu/I91cebWEqaD058uTpvZNVVuSJvHiFVomDhpkViTdEEWfk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cIdPLPy4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cTlyczJb; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cIdPLPy4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cTlyczJb"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A69C21140146;
	Thu,  3 Oct 2024 19:19:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 03 Oct 2024 19:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727997549; x=1728083949; bh=0EiSCYmX3f
	IQ1GWo9HrVQcF6lZRKdDBpinqNcDUkv2Q=; b=cIdPLPy4E2OsaUeVIcc3bx8Zx9
	xPEjx11AI0Ga8nVsDJSx++D/f5Na4gPffANBxT//XXzBdywVMOXlV9ZWYkpdjvRr
	D4NE4EACUdAqkXxwpjcMkavRioxHBqZBlW2rLW9Fl/F5YSZE7vFTShdjhcahzNHQ
	Jf5Do/h6lFR/GZ16X5yX6q1jNExUNqjX4VQXF6Crb6WJmt/KGavqaruaB45KMKc2
	jkcggOl+f8p0XqCgCHsOQ6ikwb/jWTDbD4EnFcKW+DH4aiha0qlmp2wsgQHtdmbD
	roq98NyZAHLTf7ZGpoaEDP+9R8eXuoXqNx6MXA+gRsh/Vil3NStn3QFm0+Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727997549; x=1728083949; bh=0EiSCYmX3fIQ1GWo9HrVQcF6lZRK
	dDBpinqNcDUkv2Q=; b=cTlyczJbXAiOoj/W7tu/h1e1UuKkvQnl1QGo+iop3bxx
	9AAGwyyy3HQvKIl670aT+oYqoQvLsK9jtBzc0F07BXeAlyz+Y3Eh09ykWJ4sIIaW
	rw66DZcgunfe/tX/1IuwlRkdv3agcgm794QGjt9Y7COH7LY79vyrSQjTuekzPNm3
	h1BlBwOfuTBJhJDYihMShRL8LWVi//NnS1BRxmYJLLYMaXVY1lWc/3jcV6sht2SA
	qP4f0W/amZkm+x6cuFWYTZEMcSCvGu30XQOHXi8TptdALCrVjvzJEMdCz2NgpO/E
	cVinuefsfNO4RjbTz/HkzH0OkUuYnJmvW9IWELgPtQ==
X-ME-Sender: <xms:bCb_ZkyRiCQJAGJrdrZ2N8RuLC5zdZgnnoT2jaN_QAZgY5SW-bttlA>
    <xme:bCb_ZoRBtmJG9BuzgUQFE1U7SlfgQFJbWWN_nBxwv6nLW7DYr8hNoeTK_ZBbPuXi6
    m7yuOzIP0Pbr9JLqQ>
X-ME-Received: <xmr:bCb_ZmXVhpsrPUPsSIK2y-Lvs_HxvgWABtp_KDm_sF6qbcOABqebyl4sj00tBVz2Uj_NwNBihP-HIIUr5ronanSQ1ROeo18dlruMNyo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvvddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvse
    hsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhouges
    ughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvshgthhif
    rghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:bCb_ZigGIfD2muvhhzsaRtURpVFDWZg1wmiSK8YxfDFNHrR5f7gwbQ>
    <xmx:bCb_ZmBTu4KuVeLdaQVzslA_J0OCAX5XRVei6Bs3y2ZrhLS6r8tt4Q>
    <xmx:bCb_ZjJcEZRXKGK2V8qiubz1cNBIAM5Bo9ccqkWDw86tIATDH15zgw>
    <xmx:bCb_ZtC-7nAl8bWSn4plP-oWDP2VqYCfETYaXa24wmD3srv5mtYa-w>
    <xmx:bSb_Zo3hrFm7Jv4B3Gp8e89YXk5DLaHi2_XxZQTtfX4O5905m-VhiXXg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Oct 2024 19:19:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: phillip.wood@dunelm.org.uk,  Patrick Steinhardt <ps@pks.im>,
  git@vger.kernel.org,  Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [RFC PATCH 05/21] t3404: work around platform-specific
 behaviour on macOS 10.15
In-Reply-To: <CAPig+cSuXojVPeVE_0HFwrQQqYn-SwCvHQ9yG+c8H1dgaH00pA@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 3 Oct 2024 18:22:00 -0400")
References: <cover.1727881164.git.ps@pks.im>
	<00fd829833cae1d192d6c42237aa13427156e3ea.1727881164.git.ps@pks.im>
	<CAPig+cSqeKJX99jbxouJZHdGZuyAgNz-wOgt+0C5OPvW3MHgLw@mail.gmail.com>
	<cf2ad192-928d-4bc6-974f-da5b217fba30@gmail.com>
	<CAPig+cSuXojVPeVE_0HFwrQQqYn-SwCvHQ9yG+c8H1dgaH00pA@mail.gmail.com>
Date: Thu, 03 Oct 2024 16:19:07 -0700
Message-ID: <xmqqcykghj10.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

>> I suspect that the problem is that we use "\t" which is non-standard
>> rather than a literal tab character in the sed expression.
>
> Ah yes. The `sed` on macOS 10.15 would have been of an older
> BSD-lineage than the more modern macOS versions, so that makes sense.
> It wouldn't be a bad idea for the commit message to mention something
> along those lines.
>
> (I always use literal TAB with `sed` for this precise reason, which
> may explain why my eyes skipped right over the non-standard use of
> "\t" or I just wasn't paying close enough attention, which is equally
> likely.)

I also learned sed with old BSD behaviour to be portable (I somehow
thought it is not just "old BSD" but outside POSIX if you used "\t"
and friends).  Checking with

$ git grep 'sed.*\\t' t/\*.sh

shows that t3305 also has this problem.  The ones in t3404 are from
4611884e (sequencer: notify user of --update-refs activity,
2022-07-19), while the other one is from e1c52539 (t3305: check
notes fanout more carefully and robustly, 2020-02-03), both are
relatively old.  If people are not reporting issues, it may be an
indication that sed implementations of BSD origin may have died off.

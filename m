Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA2121884A
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 22:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740695955; cv=none; b=TO8LUH8ejzjYL6tYAXzO51xfplU1IsrRztkXQmRfSewwLtF1TZi5cDln2eF2QOPvCjDjJkeMpHfu6yTs2+jnDhKBDDwWQBP3QV0MvNDNiIbOdykMJqVuF69KO1YZn++QSgjQgdzxMMj+8/YKZa1TLhSNwyIU9Nx3e+nWfaJJxVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740695955; c=relaxed/simple;
	bh=E2PKmIXNS+xoLXs7ePcwBLRVKHZSDDIqdMvik7PgrHg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gtphgJ3/15epv64FfjNuwyWpLUbr+XT6aKLaN1mouy5KcuFTXDNxEUSUrH1nNJQuOXQYkZsw89xzkYy8R6IwQFxfMipTqNAp4ZSNEdu7K/BcmzyoL3ZGa1QyqBQePpviJDzSMMRd0hS51yfdMZsm3Y33U18TcH0wlzY7MoVUWv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=I/XjsfJS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VCfL+K0n; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="I/XjsfJS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VCfL+K0n"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A96222540131;
	Thu, 27 Feb 2025 17:39:11 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 27 Feb 2025 17:39:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740695951; x=1740782351; bh=ZlZROxnhIt
	y9vZHAnLFLnWNHKZ1NkI69FOMydm1YpkU=; b=I/XjsfJSprm9uUM9At9+Iphtal
	fIAqLusrFKb67sirxeDrFT79mMgWJPkyLpBAUPdBXa00yF7hCQEN7VtnBeyyNxaT
	oBTkTRDkEbvcA3jvWgUbPt30fSPrOC0I29OaKpVNcp9QAVRE7maf3lTUnBEt0W5x
	aaC5K88e2hnAO/1ZaFlJfrWy4kgbFIxSl1YrixjlMTTSUdZ7LGgUd/xfqpmIzKho
	kIeTlHBKM7IfFyf74IZBC3R6a5XlhG11frwCmgZzYzF1f+Wvl+5UmcZ8L2vyFl2R
	tb3PMuuc7kJL6QXZ03oceWAhgJoAhstF4HNOVUFEKg9Ebk24i5TtnHGQpRJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740695951; x=1740782351; bh=ZlZROxnhIty9vZHAnLFLnWNHKZ1NkI69FOM
	ydm1YpkU=; b=VCfL+K0ntMOal8Ms+RNxPiqFZiBG1ZpFLFvbo6Znl8evXdTuO1s
	fe7sWzUPLRVOF85nL/PdddIm2pogImnKl0WU270fcmkqjwkQ+jiZbg4xHz1P0BQW
	A6CtJA/JzkCWIRmXA3BValJAMBRKqBRY6KT7IP+Er+1igTR1mOmMOfwLumGbt2Je
	3zfIMlI4setHj7QkOZgL2X0ydDtf7xjaIONpDsBlpLc/HTlXyugwbzM5REP9mvfh
	EU/gb527seYOIaHcDYXeTDdRBKC5JU7X2DWK4cKI7JBzVDYM3BWqfA7/JmK7CXkm
	TYmx/AfjaX2LLdTrVDRWqiI4Erp5MhX7mXQ==
X-ME-Sender: <xms:j-nAZ80eg9FUEdg-GEq_asVEscwU-sUBYEZ5Cpy9-dVHaedzQt93ng>
    <xme:j-nAZ3FncnWQs0wEc43I3OiyoE8t9Iqfc9W7R1ORFuTj12HliVkDX2UwrK5iMKB27
    FXd8_bUeIo-Fwb2ng>
X-ME-Received: <xmr:j-nAZ07pMRzW9qFqtTIBkwLn4phUuZBKU-lzdB6iNcL3Nk-R3nRg16J9Erjmo4BtjIm9Tx77fpvX2EN-zxER8Muao6rWxVB4WhY1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekkeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehushhmrghnrghkih
    hnhigvmhhivddtvdesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghn
    rdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgt
    phhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtoh
    epjhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:j-nAZ13Wp9UpJxP_n7U0fuNaXSLIQoI2dpDOzWBgBudpPUwKtFsTbg>
    <xmx:j-nAZ_GXDUP4uhpI9PapjKX2uB1rfnJX-j0ODrVs5QQ8yuNDXTaOuQ>
    <xmx:j-nAZ-_TXlSoCD2txrWij0eG7f-rLvaEVWQuCeHmH_75WYIBg77JXw>
    <xmx:j-nAZ0mIujOqeT6xYsGpmxsE4Ngy3yDcRiFMz9aY4sW-vctb2PmEJg>
    <xmx:j-nAZ2BIg65cY0HsTfykNJ-6DEMuAR61A_J4H11lylsMoG5hZfH9t8y1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 17:39:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,  me@ttaylorr.com,
  chriscool@tuxfamily.org,  johncai86@gmail.com,  ps@pks.im,
  shejialuo@gmail.com
Subject: Re: [PATCH v2 02/12] builtin/verify-tag: stop using `the_repository`
In-Reply-To: <CAPSxiM-bOcqEbVNAYxh0oPXKceN7YSrCU_37e7mXAbxwpq3QNQ@mail.gmail.com>
	(Usman Akinyemi's message of "Thu, 27 Feb 2025 23:26:02 +0530")
References: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
	<20250219203349.787173-1-usmanakinyemi202@gmail.com>
	<20250219203349.787173-3-usmanakinyemi202@gmail.com>
	<xmqq34g8ei5x.fsf@gitster.g>
	<CAPSxiM-bOcqEbVNAYxh0oPXKceN7YSrCU_37e7mXAbxwpq3QNQ@mail.gmail.com>
Date: Thu, 27 Feb 2025 14:39:09 -0800
Message-ID: <xmqqsenz57xu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> While going through the config.c I saw the
> read_very_early_config() which read the config from the system and
> global settings and does not require any repo variable. I think,
> to teach the repo_config() to allow NULL value, we could call the
> read_very_early_config() whenever the repo is NULL as we know,
> this happens outside the repository.

Yeah, when I wrote the message you were responding to, I noticed
that do_git_config_sequence() is prepared to take NULL as repo (even
though it is a bit clunky interface; you need to futz with members
of the opts structure like opts->ignore_repo to have the code ignore
repo that is NULL).  So a caller that calls config_with_options() with
no config_source and no repo should be a good candidate to reuse.

As we positively know that we are not in a repository in our case,
using read_very_early_config() when repo is NULL sounds like a
sensible thing to do, I would think.

Thanks.



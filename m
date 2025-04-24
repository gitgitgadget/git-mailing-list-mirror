Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA1921FF2C
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 23:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745535951; cv=none; b=RRVktt/dp1iCMgiO7RPGf0DfaD7560FfEAC5RhzTx1yCmEyfR1YfX/k+TfwSC8jk5lW5+HaMS0Kj2vWNQXDOR8YKUegfaNUXgCsurwIOsIDyn8FeYBSalgejYxSr7Syxtgq/4o3HY1Ln1pvFxQOXqDIIHAnhLpdA/DGSJ5wCoAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745535951; c=relaxed/simple;
	bh=pMsM+GFQrtC4kF+sGoPIUylbF9Qv+S7eZG4sXG0zNwA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DvIrqXXBQyD1395xi9Qnqvl6AmSHfj+uyCCGwLM4R8EgTCe+SBTXB3FL2akKe4jwlvLwMRR9HXqOFQmLB05YE1vHtvTaylaXv12Ip1Dn4iIbz0xvLfQd4YSgb04f4glor7wcikRSZe6E84QnMeQTB+NraL5W5U8aeVaV3UdUXQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=U9ts+JV7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vsqKN2Fy; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="U9ts+JV7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vsqKN2Fy"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id F075E13801F1;
	Thu, 24 Apr 2025 19:05:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 24 Apr 2025 19:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745535947; x=1745622347; bh=lOl8OxxPpD
	TkZc3bg4DEy5mivwDbn+ChShoMoO0CjfM=; b=U9ts+JV7garLE3OCRd6+p/47cw
	dT6IFjZuG1XnNvch479GzY/Nr0RuSCQvPi7bza4uudDBCmB0B574s5zHScS+/vn2
	kvMoKUYI1RHUIbs6BCCw0hP7E9YKyeCkkCmtObwiekKb4jBhIWf+8IWXbQrszUdp
	aRqVYGw7XCXNUCCTqZtnhu6lDiK5b0aBloqFp/e1nJVC9z6Ol0uoM67KXgT2gR6G
	RStN9HplKIvGutrhJWC8bPF8eFwv4FG2xiW5AFxiUd7ZaAIXJ5aBI+jIrs1FhqLb
	QaZtdOaFf6gLEL+y5vhJ7rfS5uBdlBQMU2iNNspL2oEM2OvQqjPz6c8N7Mww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745535947; x=1745622347; bh=lOl8OxxPpDTkZc3bg4DEy5mivwDbn+ChSho
	MoO0CjfM=; b=vsqKN2Fyx/8bUFpKLBuORGu18Z4XPxWLgzEOPwWJhxyuuXDjXXa
	cinEEf+BAkeDthI0r+dfQvVeVsOFiweARuySNPFfo9RGuw7QFLlh//HQCPsa9wRM
	oeMyi6eCRm4vp9KEIU+0HEUhPj2tKM1tdffaCF0AduJ2MabMPpjUgWoc2YwnpD6X
	1O9MnraOsisomrN4DC9ExsTr0XUwsR3Bk3sCZaW5SdOEaqaHqe1yrYbvDiMZt5rQ
	YI6+IybUHKJ+iOdwJalhhQLp26wW5x/UO4xp85oLNjMwNYCfLPMWPUfry/N42gNw
	7Pfno/0qdSdeEnfFz474aXaUA8bZ0DwwEew==
X-ME-Sender: <xms:y8MKaBQ7Mh7n3VBo1yW0VoZLqNG5GiNnB-N07jXc4hkSmAow8u2e8Q>
    <xme:y8MKaKw73RIKrNVIxjBwCFyzH27dCdg8paK03AknOoMuZ6ymho_t9Ecmfa0j7WWSi
    e-gzlzRvsk9Kd_-Yg>
X-ME-Received: <xmr:y8MKaG1Iv-3CUc3KZ6BPMZLFnPtmisTngxdxlAZgD2yHkgKd8yvLbXkylrePhPeKCiCSufLcW5IvHh-g0GeCUXgb_vu7Jy6yRXGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedtjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnh
    gvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:y8MKaJAw46TFGfYwW0ntaPJXRPBExzIwqzHjzQyKRuH94V-B6KhFLg>
    <xmx:y8MKaKjRYDM9dyHejBQmAXN7Mrl99XSeXA1pxlPVsIIsqzUR7-ebIw>
    <xmx:y8MKaNrQXFRq-wlP6_5DN39PsngCzlSi13zVjxvQkrEjLAbU1gsjIA>
    <xmx:y8MKaFhavlaylpF5_lThFfMGgVCFuXtuldYLZeGp3bJK6Rx6k11Xnw>
    <xmx:y8MKaHZnYpvUPhkrcPKvnxgKaP17WdOGRjoAS5Z6QMe00IZFDEHHO33a>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Apr 2025 19:05:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Subject: Re: Acceptability of replacing .git internals with symlinks
In-Reply-To: <aAq7_7pFTToMPX48@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 24 Apr 2025 22:32:31 +0000")
References: <aAq7_7pFTToMPX48@tapette.crustytoothpaste.net>
Date: Thu, 24 Apr 2025 16:05:46 -0700
Message-ID: <xmqqwmb9rwhh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I know symlinking the `hooks` directory is common and semi-suppported,
> but I don't know how we feel about other directories, such as `objects`.

I do not know how widely it is used, but the git-new-workdir script
we ship in contrib/workdir/ does make symlinks from a new directory
whose name is ".git" into subdirectories of an existing $GIT_DIR/ to
pretend as if the "new-workdir" is a separate Git repository, that
happens to share many files and directories like config, refs,
objects, etc.

I do not think we ever intended to support ".git" itself being a
symbolic link to ".git" directory owned by another repository.  We
do have ".git" that is a regular file for multiple worktree support,
but that is totally different from "just making a symlink for the
whole hierarchy".

> If we _do_ want to support this, then we should probably add some tests
> for it, and if we don't, then we may want to add advice or diagnostics
> to discourage this behaviour.

100% agreed.

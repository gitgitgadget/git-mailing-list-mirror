Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278362F44
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 00:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737073792; cv=none; b=s5svU8UI3ND/4HLsNeTYTt4XxpJj6zzWPD4bCTHt4Ql0VwtiLEzykM2cVmwAiYX3T8KWbdBPWJV/dw2rvhZPobQQfxOuxZmeRWX7g4wBZkdFrXPm1j6Z+u0hoLpftXkyMgZPo8OWi9VCJM7xtDPAvNPd+pIyKuc4pZLb1MjDAak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737073792; c=relaxed/simple;
	bh=WNfLdRVlzu+qKKKyhmUYv9bJtV0CSrEJkEpnGSpJBFo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PExfqMESe6aYpzQ+JHSc2aWFMx4LLcGnRWHLe+ehtgZuHqmh/NsucAB7+yrz9xXVxPT5rEDu1X6VNJGFHaOjiHcBS/Rlv4R8ZTM99CZlIsgGcjHLEoImmqSm1kEdLst173V24rCnxSGup7AZrsMsDi/zxBc6meFj0mwFyA/utIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=idLbm6dy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qPOFRx/w; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="idLbm6dy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qPOFRx/w"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2406411401CA;
	Thu, 16 Jan 2025 19:29:49 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 16 Jan 2025 19:29:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737073789; x=1737160189; bh=lPOI/lRb0e
	OmFmsZRSaYP/w4ErwtkrnLZRt66eqYLRo=; b=idLbm6dyoy7FXA3i8HhpX6KfSq
	Ah1BCym3SeVxHpGY2TZPCFmNlFb6aB6O1KnlPRGNlZKH/vOlMbtlHY3yYnNw8ZbT
	fbP73Y1gDS/+xVOfnT2MPUooYpqJQbnem72PV1y997RauxFAcrTYIshLeRIGNcYg
	ZmY//O0wM5wUsnBturD6fRBgpewmF0H10HsEjCAOy0fyjnkqK4XNenTj4xVYhyHy
	bBRgL9ctR9V/JqwOuskujT6mTcbmblNMiU+gCmg7CXjD8TsC9FWswTk7NSoVbMZL
	tq3PpTQs+EdFnkDSLbw8tieT1yvX+O511sOIiIvyrUlQP1Dn38EP2do7OGjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737073789; x=1737160189; bh=lPOI/lRb0eOmFmsZRSaYP/w4ErwtkrnLZRt
	66eqYLRo=; b=qPOFRx/wHKn3Nau2RSIllHlTjCT9iieJupCOLZRC/gCWMHmvwqf
	DC+/RmAIaUklrlSwS03qu2+f/yDWxglWNwwI5gmh+s4+dk/Biv/+ECJ2KN/eKEL1
	mclj6bh7BO3OQD0QokIGGNS9UalGsL6qRyNH8iiITuCGUxg7Wh+ixxfGzMhmmaJn
	i65K1MhdDl5b5P1gXYUJ1kh3xk0zRYn5G/5oSOtFyKQ1h9QBx3VD95S5m9K84NZ7
	lUW+O2fvG/eDA+MW81pmlg22FwULpqhmD3hjPp5qBDIj9oUvbbhet8nTdbZ5i0xE
	Y2IMicP+zSt3TYmqw3WBLtRN+btYiBgGa4Q==
X-ME-Sender: <xms:fKSJZ_996Nq_bbwLntQP6MiiqgqLjbn4t2fw_2Zd0VQXDab2bOpEqQ>
    <xme:fKSJZ7vbOqeJgTG7QMmxk96w1s3Gmg2HU6TcWlWzwfeqoNd_O5Ej4naHm6WC9G5C5
    AzEiyvUWiYXSh4yQA>
X-ME-Received: <xmr:fKSJZ9DoPcdaMS32D0hbTvpyrhr1FkvcB6NMQ_fw8AAzZOSOWAWrYoBnU9VS1WlNTuVDJ3npXMNqz6UUvcuChavb90fi_N7-KAvX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeivddgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeei
    vddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgdoghhithhhuhgssehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:fKSJZ7dsKrm4GS5oghBlis_jI5n5tY2vqmzHw0APA6WsgLEC5YnH4g>
    <xmx:fKSJZ0N4tBujXlV5KP48yuL536_GL4LHmmh3XciKRJ04aox3oQS5sw>
    <xmx:fKSJZ9kCjmgkZR3ORcD-0yBAceVs4pkBepNe4SmBmjsBI46OBXp1ZA>
    <xmx:fKSJZ-u9r1sUsn733WG9Akh6gi_iqukLw6CJ7u4UUAy7yxdLFPyEVg>
    <xmx:faSJZxr_hLWpjHSIh_KFTZeEYFv5hShrrNHDWgBF7r-D-4foCX30Y_Cz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 19:29:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble via GitGitGadget" <gitgitgadget@gmail.com>, "D. Ben
 Knoble" <ben.knoble+github@gmail.com>
Subject: Re: [PATCH] grep: document negated line-number, column long options
In-Reply-To: <xmqqy0zanzdw.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	16 Jan 2025 14:54:19 -0800")
References: <pull.1878.git.git.1737066042014.gitgitgadget@gmail.com>
	<xmqqy0zanzdw.fsf@gitster.g>
Date: Thu, 16 Jan 2025 16:29:47 -0800
Message-ID: <xmqqfrlinuys.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> As nobody complains that "I cannot understand what --no-progress,
> which is described in the above, means", there must be a central
> place where we describe this convention ("git help cli" talks about
> negating options).

I looked for it for a while and noticed that we do not seem to
officially state that command line options trump configuration
variables.  Which is a bit hard to believe for an old timer like me
who taught our developers for 20-years that it is one of the
conventions they must make sure their new commands, options and
configuration variables follow.

In any case, perhaps something along the lines of the following would
help?  This is in the vicinity of where we describe that `--no-track`
is a way to override `--track`.

It is entirely possible that this patch is not needed and I didn't
look hard enough to find an existing documentation that says it
already, though.

---- >8 ----
Subject: [PATCH] gitcli: document that command line trumps configuration

We centrally explain that "--no-whatever" is the way to countermand
the "--whatever" option.  Explain that a configured default can be
overridden by the corresponding command line option, too.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/gitcli.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git c/Documentation/gitcli.txt w/Documentation/gitcli.txt
index fcd86d2eee..5b6f0e4a4b 100644
--- c/Documentation/gitcli.txt
+++ w/Documentation/gitcli.txt
@@ -161,6 +161,20 @@ can use `--no-track` to override that behaviour. The same goes for `--color`
 and `--no-color`.
 
 
+Options trump configuration
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+When there is a configuration variable and a command line option
+that tweaks the behaviour of the same aspect of a Git command,
+the command line option overrides the configuration variable.
+
+For example, the `user.signingKey` configuration variable is used to
+specify the default key used by the `git tag -s` command to create a
+signed tag.  By giving the `-u <key-id>` option to `git tag`, which
+specif es the key used to sign a tag, the key specified by the `-u`
+option on the command line is used, instead of the configured
+`user.signingKey`.
+
+
 Aggregating short options
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 Commands that support the enhanced option parser allow you to aggregate short

Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5914BFE8B
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 22:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788993084; cv=none; b=PM40MJBQrW6ZoCxQe8djDgHOuNtdpWCTyUkQxHRvpdKXjyocWpoP21KUtUuvgRJQI+xT74IgHLFWTqvtmwlFoQWB3tZ1iZC43fmtkKxnHPco5raQBAKiI/2TCvUwvMr0L1sN2Kcm0cMyJeWGO1s64zM8/CA+osJkGQunUujaDYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788993084; c=relaxed/simple;
	bh=6nSE1gbsswNzCw84aeiSXMURHMV26/fLnqyfwAurHjk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DQ5fn/d6SZ3DdUO0e8aQusGJ/1pajW055QkTZFo+NI0JrZsAKACnSruyGLKn0V1tpky30o2jMMejQhghBoZIsD8s8bxeFXy74mBBr0eXKz4qnUlCfcfcvKBcPL+biYxmuXN0mbIowZ4Esof/pMhvlP7RI+xNDqJpT1G4d45UTv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OUC7iyKN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aUqulq0C; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OUC7iyKN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aUqulq0C"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 15DD4140010C;
	Wed,  9 Sep 2026 18:31:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 09 Sep 2026 18:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788993078; x=1789079478; bh=SQQMs02qxW
	ITJa6DmJgOUQK+hzHWoU4w2tpqg9i+2bM=; b=OUC7iyKNpChdDAwqRJ6TUd97VL
	cJXCQukSaPJ5iio/7CWg6GLw7FpROvK2tlx2ElUCTzPGey4S5oIUkoPMvdiF6+LA
	9B5rJTdGKteCl0Z1nIguEPv4NsOjuTTV5ovRq73zMtUcR7DCKJeSk3reDFKGQMPt
	1y416ZG1iXEwJRt0b9AmTA9KS5Mpql0nObTggPUZ/R0qKJkXczUh8do5YX8Lx0a1
	lp7KCfRTrFMlwgsj3sEWYORnxe467jVN9Jk8fqzvgugpFSbGymWtUpJvqcXdMtk+
	oJ6jbo7tyidGC97BI46KeAiQS7I+FzPnk3gl9UAlzjHeWtJ9xz+jvS+0Qxgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788993078; x=1789079478; bh=SQQMs02qxWITJa6DmJgOUQK+hzHWoU4w2tp
	qg9i+2bM=; b=aUqulq0CjVwwbjJ9Yr/jRHqWpvRjTOAKBOXcdD7SlKlBHmKVrxK
	7CBLZq3jKCkHs9ELXkHaYHYIVIatXXvgSsN+GAM1t+RZmcAx9qGSv3vAksi8DCDL
	kuErWYfjPBJUaPJeQQcOhZWDTvRXDNLdIsu2bwJ6t17E/zKd4ZhIqazOOItcp+zq
	1ED5Qh6A+0xMgqYpanqV2T5y1RXmJ8Th5anxPQHgVz+jLJ1CJjcBCVg+e5NLZaaS
	RRJ6j1yJpUdez/C4Pbmm59R9vRiG2JB/yNHBgrykcLsQWLhnvszDHEv+WdD9I8/5
	1M7N5ZrhmAjovoIzuBxQ+FgOjDjMcBY9iXw==
X-ME-Sender: <xms:Nd6hassahACejKuS8xlSnJZiTYTLnmYSHpNtHFGsaKEJhWzVtq8nBw>
    <xme:Nd6hatIL55zxTJgGsMCTdRwdjGZdke6k-JYzSfRJyYHnBJFX2P3-iizw1K5XS1yHH
    VAURPOQgLxd6Nrd60I3oIyRAHvuuzJV01BahY7mMztYQQGT-dDA2rA>
X-ME-Received: <xmr:Nd6hahkPWq3kdJPdh0SGADMAilc2mqsHWMCJ1X8wrizXvMZH3GO5X_1Sw5ydGqwnqylc4BlftR8qpKrMA1NJHPbIGULoozvBP5W_>
X-ME-Proxy-Cause: dmFkZTGL4BzCTn9lzR0xIW+xsVZGUnZD0QLQjSNxWGqsIGcjJxEeBPdt8fd1fGlCRiqw4L
    z9wtVlyg9Zla1/UHe+qUqUjg2KrnqDJ+fudsr1XHJHHfHZg9K6A/gkoIIqIq2RGIBOBptc
    saaP4BbYZzKkJq6g3GiXsOgV5SabOoA6EKu7OFMapfSC/88QM2iasIh1TU/TdnnPJqnvDy
    RzSrnpddl9J8RyuRgECbGQCsJzEW59L1GyS3RUjfbBZ+jB6g1D1VT6zjjemc7Og0XKLDTa
    29/YS3LI2EeoDrp9F3HRTNJ9WKxYbmAQOMQYSeZE9PLeAbcKx0czWpFk/7emWBRdu26RUe
    9ieKBZpdDslAwYZYW6bnE7A8CzyynvekErpgpPPRsHPnRhyErplkGr+rxlXygzXVeNpbU6
    zcqTcc7XfroNYfbx8nHjRVldQ8MzDYsW3oUPr3G7cBtOL8QdTsOQZIwn+h9uliDAqhdRkB
    jAhVI+nUccgcpJgfuzgrUAFYItsryUykjWbTxzg7hLthTwATcKEcrwXri6S0l1ZBexwlWB
    lNsW4cgAmfZII7uQdM0513HsJLWyCxbwIpJVS/0O5N2ZA0RNND2SS8N+J3fW5GE0CeWgcX
    kROIQrKkysxwmCEWi4jRO7OrgWGdQL7b4Xcn/WUy+tWtckcF6yObleGTYxsw
X-ME-Proxy: <xmx:Nd6hamJT4jU7_R-rNaClktRUbfFUYF6HfzGVQUkBStR-EfEhLeo2pg>
    <xmx:Nd6hau5bFYl0NHNNIpA6ELN8NLwMIeVjIETT2EIzydFIDmW6wnUdNw>
    <xmx:Nd6hai0XSEErl2yZrFg8D0dEgqSbc0gtcjy1DWJpGVEbfq6rhOmTLA>
    <xmx:Nd6hasfCCAL15oJnFXV-2lQJlaYscFKS4riudEeH0QdKopW8q5oDfA>
    <xmx:Nt6hak0tLvGbT3VZg2lWw9yOGEpjqqXlWNVfXxcWovCipus0nD1_wiWH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 18:31:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Vsevolod Myalitsin <ub4nal@mail.ru>
Cc: ben.knoble@gmail.org,  git@vger.kernel.org,  gitster@pobox.me,
  peff@peff.net
Subject: Re: [PATCH v3] advice: use global config for default branch name
In-Reply-To: <20260909213034.94554-1-ub4nal@mail.ru> (Vsevolod Myalitsin's
	message of "Thu, 10 Sep 2026 00:30:34 +0300")
References: <xmqqse3ip2s5.fsf@gitster.g>
	<20260909213034.94554-1-ub4nal@mail.ru>
Date: Wed, 09 Sep 2026 15:31:16 -0700
Message-ID: <xmqqzexqnjkb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vsevolod Myalitsin <ub4nal@mail.ru> writes:

> I have one question about how the series should be organized. Since the
> three patches will have different purposes, should each patch have its
> own subject and commit message describing the changes introduced by that
> patch? Or should they share a common subject/theme, with the individual
> changes described in the respective commit messages?

Sorry, but I do not quite understand what is being asked.

For example, if you had a 4-patch series like

  https://lore.kernel.org/git/20260909-758-introduce-hook-v9-0-3043d417e0ee@gmail.com/

how would you characterize each patch in it?  These 4 patches share
the same goal in bigger picture (after all that is why they are in a
single series) yet each step has its own agenda (each of them can be
explained separately as a logical unit, and that is why you are
making them separate patches to ease reading and understanding).
Each patch comes with its own title and explian the background (the
observation of the status quo) and what it wants to solve and how.

Your three-patch series would be quite similar.  If you want to
describe the motivation and overall structure of the solution, a
cover letter would make a good place to do so, and then each patch
does so in a smaller scale in its proposed log message.
The contents of each message may begin like so:

 [0/3] defaultBranchName advice is useless

 It does not make much sense to set the advice.defaultBranchName
 configuration variable in a per-repository configuration file, as
 once a repository is initialized, the advice will never fire.  We
 need to mechanism to mark such advice messages so that the message
 to tell what advice.* variable to tweak can suggest doing so in a
 per-user or even per-system configuration files.

 This series consists of three steps, ...

 [1/3] advice: pass the entire advice_setting to vadvise()

 The internal function vadvice() takes values taken from members of
 an advice_settings struct individually, which is cumbersome to
 extend.  Instead, pass the advice_settings instance so that the
 function can be extended by adding new members ot advnce_settings
 struct, without changing the signature of vadvise() function.

 [2/3] advice: introduce advice scoping mechanism

 The hint on how to squelch advice message told users to set
 advice.X configuration variable to false to squelch it, but for
 some variables, setting it globally in per-user configuration file
 is more appropriate.  Add a new member to advice_settings struct to
 indicate which config scope the variable should be set, and adjust
 the message.

...

By the way, when you prepare a v4, make sure that the cover letter
of the 3-patch series is a reply to your v3 patch, and each patch in
the series is a reply to the cover letter of v4.  That would give us
a nice threading on the mailing list archive and help automation.

Thanks.

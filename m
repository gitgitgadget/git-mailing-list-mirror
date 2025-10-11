Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAEF217F56
	for <git@vger.kernel.org>; Sat, 11 Oct 2025 19:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760212248; cv=none; b=o9QSsxM/cY0YeJLv2Fhcz2JwY0f6INjZGf60JOiESUglQ+EQqczwzm365x9IjNyW35bKe31WYYqTpVRwCKzOTwgDxNBvphO4nnnHr7UvyZdZAtU3Eq31SJtDFgpVFkxQ3Kh05z2WM3i0olDoeLOMFi5osQcPxAqiZInviF3Ni/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760212248; c=relaxed/simple;
	bh=ibIazN9AprOzmlB8Zj6UumR+0rLHAKwqj+ezk7bmvh4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=euQx9nLHH/S7LCQJe08A5oaxBF1/AVNJYjXe+CCezyik5XA0xxd+RcK9Nwcsv4gr6EwJWS7deBQtdq0y28MwLjjF39qFNFHyLcrOkBER4CcJlrHKROtFivew4tnq9xOKioTLUeIw/q514bgHa8PCL61++SL4dGT/V+L8n3c3XJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HeFCc2PL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tKJ7mLyE; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HeFCc2PL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tKJ7mLyE"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 67CCC7A00A3;
	Sat, 11 Oct 2025 15:50:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sat, 11 Oct 2025 15:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760212245; x=1760298645; bh=hnB1ZA/mUf
	B+tW/5XldHcwig49plv2ktgMe9lIFly+A=; b=HeFCc2PLlJJLdXRtt6AD9knUA/
	Cls/zvnD4NzNuHVM6aJZ249yUedkY/26JUMir+T8kWb6lWAxFqGl8704DiDDggkc
	hmeOqJSDo3lUz97ItcUb8KrV23/n83S47s694/Vtqqm8SiZGJ32umFRGxu1S+sCU
	hH99fqEjHwTq2OS20XDNPwRUcnSrMaCUdAdJPr4DtIz2hF0UU3tVrfrqSYCtBWkj
	+Olhk6KDXpnCyL2U6XfOPnuzjuW/HL9a45TuPvWUWlG7s4EvoJ09CF/GDyXrTJrP
	d/rZxQpFM/cT/IQRJLXq/y+SYqHcQAwCL9iUpshliZlTgRbjILMDXM8/qiHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760212245; x=1760298645; bh=hnB1ZA/mUfB+tW/5XldHcwig49plv2ktgMe
	9lIFly+A=; b=tKJ7mLyEPeKCsP7RHYiiRxXBO0EpAZWLbYN6I8tCpEkvpP78+kD
	u3sj5ppfKl1RiajCvd6v6JqKINQvTmVfuba6250IasZsHSJavBNvrbaQL1G0BBTI
	YEip7Ra0HUGusMZ0gJQMFrYx8DdJR/owZ2+GLAJN3gd6tz+9rH93+SraZzYeGZWm
	z5lTFf9LXm51N/aSS9vbbCLDpl/49cw4Pn9NHYZvKH/HJSWR9HW4TwvpYJF4VNfR
	5N629l2iGG9CGotcNDMiFprja7IB8p+zcSAinkNBnhIbzUyABTvRi5A2BgDznFxr
	0ocYdzUpuloLDJixxa1Xe+ogADDkj8sIobQ==
X-ME-Sender: <xms:FbXqaGqJzrYaQwJAZUZyg2Ed4pR17Kwtd1ar5kw540bdBQOxU4AzGQ>
    <xme:FbXqaLikShqAklJ0sad71PTObIugHB-uGh6LBnY_dTKdkR2mDEEiKxebAWz5xm9-x
    MW_4XtHipFTVDgspqRwzqsqjlqU5ZkWAu8ZylMG3aLCi_gZkegkQg>
X-ME-Received: <xmr:FbXqaDgFeE6elq_pd0oACKVS-VHQRwrpTKjWEI-FJpsdfGe9vsuLyn5pp9-rmYw_UiGnAhmXhpj2VwHq9usfNCrB8BoZdDFc0N9I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduuddvjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffefvdelvddufeejgeduleetge
    efgedugeehvedutdevieetvdejueduffejkeenucffohhmrghinhepphhusghlihgtqdhi
    nhgsohigrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvlhhkihguleeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtth
    hopehushhmrghnrghkihhnhigvmhhivddtvdesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:FbXqaBizCyMzIg93h9BpApa-5eV0NJaQ2XS6vbqnNK5nmjbU4MSvkg>
    <xmx:FbXqaDKOGI51v7E57CRHZw8syeASxd5B7y3OQa9FBVhdqWXqBP2rTw>
    <xmx:FbXqaAHRSQbBWyBUSXOsVVQzTcNEIRlGLP08GHSXmbuOk4B4ahUEug>
    <xmx:FbXqaHQrWuD6bNWgV-45K8OZMHm-5pwGC5PDdNpSKEgNqifJ1ODMbA>
    <xmx:FbXqaEzjh-x_Rw753GNcXj3ECu-FV69zSvUX5DQsOjJr1xZAMtj5wF-3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Oct 2025 15:50:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Bello Caleb Olamide <belkid98@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  usmanakinyemi202@gmail.com
Subject: Re: [RFC Outreachy] Teach ci/check-whitespace to flag incomplete
 lines as an error
In-Reply-To: <aOporVVSRRL/v4Lq@ubuntu> (Bello Caleb Olamide's message of "Sat,
	11 Oct 2025 14:24:45 +0000")
References: <aOporVVSRRL/v4Lq@ubuntu>
Date: Sat, 11 Oct 2025 12:50:43 -0700
Message-ID: <xmqqecr95ib0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bello Caleb Olamide <belkid98@gmail.com> writes:

> Hello,
>
> While going through the mailing list for some #leftoverbits, I stumbled on this converation.
> https://public-inbox.org/git/xmqqikla86id.fsf@gitster.g/.

Welcome, and first please learn to keep your lines under readable
width limit.  As an applicant to a mentoring program with this
project, you will be exchanging e-mails about patches, whose
contents are limited to 80 columns (but subtracting 1 columns for
"+/ /-" prefix when a line is shown in a patch, plus several more
for "> " prefix when the message is quoted multiple times during a
discussion thread, a practical line-length limit is more like 68-72
columns), and you will be adding in-line comments in the middle of
quoted patches.

Hence, your comments in e-mails thrown at this list are also limited
to similar line length limit.  Otherwise they would become very hard
to read.

I'll line-wrap the quoted text below.

> After studying the check-whitespace script, I observed that the
> script parses each line of the output of the command `git log
> --check --pretty=format:"---% h% s" "${baseCommit}"..` and formats
> the result.
>
> But the output of the git command itself does not flag '\no
> newline at end of file' as it is shown in git diff, in a case
> where the files does not contain a newline at the end of the file.

Correct observations.

> One approach I propose to take is to check the each file changed
> in each commit and check if it has the \n as the last character.

If a commit changes line 4 of a 100-line file that lacked the final
newline, "git log" would show the commit, "git log -p" would show a
patch to the file, but "\No newline" would not be shown, because the
commit is not responsible for introducing an incomplete line to the
file.  Looking at the last byte of "git cat-file blob $commit:$path"
for commits that appear in "git log" output would not give us what
we want.  We need a mechanism that notices and warns when a commit
makes a file, which used to end with a newline, end in an incomplete
line.

If you can come up with a robust way to do so in check-whitespace
script, with the understanding that the right solution in the longer
term is to teach "git log --check" to notice incomplete lines and
flag it (with core.whitespace configuration and the whitespace
attributes to enable/disable the check), it might work as a stop-gap
measure.  As I said elsewhere a few days ago, doing it right would
be a bit too big for a microproject.

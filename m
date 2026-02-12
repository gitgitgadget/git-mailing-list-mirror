Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA7B19EED3
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770916428; cv=none; b=dP1LkE1LOtNEJp0d5dwl6v6D3LnO7vaXv1M7O5R2MaUlhOeoh1Kj5TSEoERQJ13YZetvm5niAKAPvAQXvSDbC4YLGU8WDkgYl1pZlHJigGL/MkeJ028cwPuYgNo788bDNiyMSyV6A9ZF/MCPixGTkPXPN9yZI/3vBJPgcAZ1CZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770916428; c=relaxed/simple;
	bh=COiPxxoq7wRFogMDs4tTO85uoPLHjHxoPql0HSyQyeE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UvnSVgqj5hIUiPCONxBjwka4JrVCNsqhp11/wnTo9Zl1uIUmKmMltavNVDD2j49OH8YTMydT2bf1bq1tWaWWZq1WdYbtAm5T39Bv60pPNsjxGyc2e0npANaVP83xrfrtVwCNyyZg3OBgQgoqHwKdYo6UrEqcFEoGjRi0dGaPebg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ds63MM3H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qq2wiNMD; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ds63MM3H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qq2wiNMD"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 8D76A1D00070;
	Thu, 12 Feb 2026 12:13:45 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 12 Feb 2026 12:13:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770916425; x=1771002825; bh=b2zG3kYSdg
	2uPRe+qUCZkK7nEfrGrYeGOdOQdVSNXnc=; b=Ds63MM3HVegB3ZXRtYYzS6MC+u
	e7Pezf9xLZemJjYSg/G2/4WQ2j/+lI4E2JY9WmcQJybax61zS22k6JZkr1q1nu9u
	1z4gTp51aFicXOBaT+hNGxaD71ZZFonZ7KhM5/6RDqvZuVLyQqlaw5Y4yTIjUEkH
	jMK/3PX/sqFW3vXpNG26qhP6eMx3SqS6rY0ojUhApqZwlH2Ak931CcPQA1uJHk05
	NpI7OfWvDfmhoyWAMu6OOOFP1Imh93GLRwTchpHT68a+bOwurWrxyJY04WpwEYgz
	3IMDtC7yVakr0tEIao726aSr753A+sePGkusqVFfWBLnV7GS07SSFQ/lFoCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770916425; x=1771002825; bh=b2zG3kYSdg2uPRe+qUCZkK7nEfrGrYeGOdO
	QdVSNXnc=; b=qq2wiNMD19Tim+MWiXzRF00a7Cv1g6S8m9vmwe9lOI2tWwO2/8H
	zaprUk34ylKCPGwDnExO/WGbFkw3fwnLaAszekI8alldin8lHoXRnlpshcyydJ4M
	zbJxCre2s3qLStSsAMeG09bYMT7tvzoTil6iSiWutD2gh4s23kcAqefnmO4VQ6i+
	QJhyCXnikihN/W3Z0oC+c845oLOlVeBb6uUKaIYxifEKoU8EfkTAJ8Sbcs2Rw1Fy
	ooxg/xRJeLCtS2D9/3K10xad4d3Pb6qmNoSJL9l9x0GdgtRgs71hf3t/VMynyp9t
	iQejmPedwVgL7Zj9oSoh6tL8D+hmXi0YPSg==
X-ME-Sender: <xms:SAqOabda3uDGXZrfWC6x_XLZDaqzBh5lRzKZPNrx0b8NG5pO4FBugA>
    <xme:SAqOafePWTl_QmHPDshczBMo7q-kZv_ayN-xAGCh0-fxxF4oNcTswLLLEzx2lqTCI
    FsHFHycPD8es3S-aIue4CL122yjgmeTJ9kxNDwuDtBJDQbsa9YAUYc>
X-ME-Received: <xmr:SAqOad15fMPkjkzfN6E1EE7vhQye35K2lqvFc01llPR53FkwcpApTDFHkNNrOCotlQApFl0KeknNA7X8rm2IMq2xqRhqDWtXzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdehleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepsggvlhhkihguleeksehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonh
    esihhothgtlhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesgh
    hmrghilhdrtghomhdprhgtphhtthhopehkrggrrhhtihgtrdhsihhvrghrrggrmhesghhm
    rghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:SAqOaf9DHQbJH-Jwv5BlATU2SV5m_D3NydAPZSEmfRPfKAYv2c6PqA>
    <xmx:SAqOaa4obIavNHsY3PeDzTug0Yfc4bCuxtJ3cxQSaiCxyChXqQdnlw>
    <xmx:SAqOafsQM4qXuV8VSKMhRBdhPWQPEsi9GWrTG6X0zDfdIt21cRWNKw>
    <xmx:SAqOaU32tNJDTfaaa_Kh7vnvXgzHA0QnRk19RXiD7XbfAzHMDdYPcg>
    <xmx:SQqOafPLu_qB3fUmSBwOSDJecg7AYWskDXXJvoFR_aT95CSTQmuV2Nvw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Feb 2026 12:13:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Bello Caleb Olamide <belkid98@gmail.com>,  git@vger.kernel.org,
  toon@iotcl.com,  christian.couder@gmail.com,  usmanakinyemi202@gmail.com,
  kaartic.sivaraam@gmail.com,  me@ttaylorr.com,  karthik.188@gmail.com,
  phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy PATCH v6 1/3] environment: stop storing
 `core.attributesFile` globally
In-Reply-To: <7d9e0e9b-4565-492c-81b7-2471a916015e@gmail.com> (Phillip Wood's
	message of "Thu, 12 Feb 2026 10:33:33 +0000")
References: <aYsEpvFwCSHb5DYO@ubuntu>
	<37abfe28-ff89-460a-962d-4503ec3f7975@gmail.com>
	<xmqq5x83w7m1.fsf@gitster.g>
	<7d9e0e9b-4565-492c-81b7-2471a916015e@gmail.com>
Date: Thu, 12 Feb 2026 09:13:42 -0800
Message-ID: <xmqqy0kxq3zt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 11/02/2026 16:46, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>> 
>> At the beginning of repo_config_values() in the patch, there is a
>> check to ensure that repo->initialized is true and otherwise you get
>> an error.  But the initialization is already done in the early part
>> of initialize_repository() as quoted above.  So I do not see what
>> difference it would make if we rewrote the last line as
>
> In Bello's patch there is a second assertion in repo_config_values() 
> that checks "repo == the_repository" and that one fails. I suggested 
> adding it because the config values are still global rather than per 
> repository so we should only be reading them from "the_repository".

Ah, OK.  It may indeed be a good safety valve with the current
codebase.  I am not sure what the upgrade path would look like from
there, though.

Thanks.

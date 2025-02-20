Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA38A1DE4CE
	for <git@vger.kernel.org>; Thu, 20 Feb 2025 15:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066191; cv=none; b=Xg83b3PmlORme9LV0blXddZY4AZK7buNhI4p+Ei2nqePNXxGpWNr8XGUkvcMWqC32izhv1OBclRWoLF1R1sQTrQgwjUJ7W/ykSoKegkeYC8Qbq5/nx504KPXATyp/BKNQr7EZuxn+9vgIEBBOmhp/lvP/Jxp/hmHMO3TByaF9l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066191; c=relaxed/simple;
	bh=T3Cr/EC+nEIjtO32TNJW+TjRIh0VEyXIlz1BkcFjlDE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D39qz1YVkipeXs4jIABM6ZJTysLe0cBEErq7oFKl7Fwp47C22XvC/lvDL6GZjVf2fKAn83o4qp/uloigwOaBZRT4DyG58HfsrivPQVNug5mS6Ocr/NWDqSiDOH6q3oMznu5eDWtXZqzQC92TT3FMgQSgo68GF2oICtclJ7ROS2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=j6L5T4bu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vaJK92vM; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="j6L5T4bu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vaJK92vM"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.phl.internal (Postfix) with ESMTP id A26F41380993;
	Thu, 20 Feb 2025 10:43:08 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-13.internal (MEProxy); Thu, 20 Feb 2025 10:43:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1740066188; x=1740152588; bh=SyZnC29Pnd
	FnwvHvYuaaHO3TolrF5OL3UxjtWieCVjU=; b=j6L5T4buwffH7nlNregaMFM7WZ
	kw/rJM9mi7mqUN/u67D8AlKHXeMi4mPBkgvpMHU6vLeFIi3xRsQB1+Ucc+Jdeb7t
	eFpFqRwL8UIQzKWYXAu0ldyMwT2qSWMGS7m9L7Z7g4Aq6gND3oeV3onZfDNLyOhl
	UACgK9i6EvH+R5HJ3LcFU1z2sLtRvOU1lB5RU+nwWILyJTXEJarvaeYo7bMDb+13
	TohxYPEVdAfLzTIqq6GaCDbmn/SQeuOP6203TNwKMhgbuNVxVU9l5h1wXQJwmK6f
	3DN//UYg5MThLYISRjmpCsihQOHVlSJl/cQ3/b6+rxtKJXzwU8tGCAvAVXFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1740066188; x=1740152588; bh=SyZnC29PndFnwvHvYuaaHO3TolrF5OL3Uxj
	tWieCVjU=; b=vaJK92vMvx+/p118LLGS2tWS0dBJknsnZuDpoLqB5s/FQL4G0nL
	7LNhzUCTzHDNQ/V87yZbaLBoGHsZrK97m3qzIq/fKLHImxgkWF/qzEgdruIrq+IQ
	97bnLGoQrWsPvHW3Prf6+rWNO4p4Xx95tMuUNW+FU4cqlTg72LmDwXg61lKPEVyO
	185/ZfNezxOY2Si38qjxFoY6j7NiYL2psSTOEbiBwnGTk/twXZ6PJSTLNmJd+ZZR
	z041b5j4gSA/AFxwse9OeDfS+U3THCoXhCW+Y59sL4WOXCHM/cqqZXoxAFgILww0
	hXwp5VT+OqO4okeSWLewAjKN52gRqyPvt1A==
X-ME-Sender: <xms:jE23Z1ZL0SoRLwNv8iZ3CbBKQVjODz19r33dXJkFEHs2XRRG2M3lyQ>
    <xme:jE23Z8ZzCpTNDjuWuqnW-NCQlSDXsoIjZQQhFoSqEoO47G-rH0pzqkCjWPMRptwZO
    nm1wJzFMI4sY6X7qw>
X-ME-Received: <xmr:jE23Z3-HX9J2o3l23OBTMZSm7zgxIWoIZ9IWGxufEmw6dJUG-II7Mtvfo5prW3QO83foWjYNSB3l8BjqqskZ0i-65_80xsCd7vIKuBo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeijeehtdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:jE23Zzo3YLauksqM9n3x_6wRhgHFUlueEgNavPjsFvlTwYIIvDk0rQ>
    <xmx:jE23ZwpkUYpSwsSjmWvnAw3jjaUAxHk2w1W6gPHC_DLHBaBx7DOytg>
    <xmx:jE23Z5Qwp2ptSUtTTRMOESMhsEfuyFEwIVRbeeUXKVFg5Edcn7jz1A>
    <xmx:jE23Z4o44jHYhJNzp9q_RfjNpyH7QcF1Yg_ykkLkBMPKXGQ_ctoe2Q>
    <xmx:jE23Z32aOfJyJxOKcNxb6WpMAASrknm48pGCYeQ3PyUQ-ABNzU1VnYWG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Feb 2025 10:43:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,  me@ttaylorr.com,
  chriscool@tuxfamily.org,  johncai86@gmail.com,  ps@pks.im,
  shejialuo@gmail.com
Subject: Re: [PATCH v2 02/12] builtin/verify-tag: stop using `the_repository`
In-Reply-To: <20250219203349.787173-3-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Thu, 20 Feb 2025 02:02:50 +0530")
References: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
	<20250219203349.787173-1-usmanakinyemi202@gmail.com>
	<20250219203349.787173-3-usmanakinyemi202@gmail.com>
Date: Thu, 20 Feb 2025 07:43:06 -0800
Message-ID: <xmqq34g8ei5x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> @@ -23,7 +22,7 @@ static const char * const verify_tag_usage[] = {
>  int cmd_verify_tag(int argc,
>  		   const char **argv,
>  		   const char *prefix,
> -		   struct repository *repo UNUSED)
> +		   struct repository *repo)
>  {
>  	int i = 1, verbose = 0, had_error = 0;
>  	unsigned flags = 0;
> @@ -50,13 +49,13 @@ int cmd_verify_tag(int argc,
>  		flags |= GPG_VERIFY_OMIT_STATUS;
>  	}
>  
> -	git_config(git_default_config, NULL);
> +	repo_config(repo, git_default_config, NULL);

I seriously think that it is a horrible idea (but the previous step
of this series is hardly the first one that commits the same sin) to
move git_config() down only to deal with "repo might be NULL if run
outside a repository".  We should stop making such changes, and we
should revert the changes we already made along that line, to solve
it differently.

Wouldn't it work much better if we teach repo_config() to allow repo
to be NULL to signal that we are outside any repository, and behave
the same way the current git_config() works when called outside a
repository?  Even though the function is called repo_config(), it is
*NOT* limited to read from $GIT_DIR/config but does read from the
usual "repository configuration trumps per-user configuration which
trumps system-side configuration" cascade, so it is natural to skip
the repository configuration when called outside any repository but
read the other configuration sources, which should be what happens
when git_config() is called from outside the repository, no?


Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A396E146003
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045199; cv=none; b=k2JH7wyqIjFBA4sltStpPkcGCSIh8bMVRSbcgE3bFkge6sIvp4E7QAlOVQs1Aal3AfyBALsRuIXx8ysnitSu1tkxseYFbZRAv9BSduk9O+5O3olIfMWMezerlTXdrPnZKyimvc7ZXxG1xjAy6bfotmkKRnTEOY/xtQXqTXXUapA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045199; c=relaxed/simple;
	bh=Pe4PL82itwNJ6dVyPGf3P+d9QXZ9XEk4lISH7du9miM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FVc9d7now7/lqd0EdtZm2SeNXl0+MdULhmFJXUSk9KvVOPbgn2Fc75lNXdXKMizmCNbH9gnWAkq50UwYzdxX+ycNqy0FCTU0rUxPexHqgsnotjKq7J6IfZwwPUbij8kTx98I8bgUNQ3EcCt00OuZQnr1FRrK4FUR9F/Fr1JCd0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=anExplkk; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="anExplkk"
Received: from localhost ([193.175.198.193])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 41REkKKj003433
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 27 Feb 2024 15:46:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1709045181; bh=Pe4PL82itwNJ6dVyPGf3P+d9QXZ9XEk4lISH7du9miM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=anExplkkg+RW9ooSbWV8UtgxFFL33Q5mmPgkoVYaoN2j882YeUbn4LGgu/DOu31DW
	 cehu9KcDO9qqT80Z2ic7lgPNfxDL/yj/3ssKirlnATId0lOmSqGQr7mO6w3e/w4Z0h
	 S6yvyYmEhoNo3V7icLTZxgHW8zHlIMapJA9pl3jA=
From: Dirk Gouders <dirk@gouders.net>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 04/11] Prepare `paint_down_to_common()` for handling
 shallow commits
In-Reply-To: <84e7fbc07e08956e6c493baf499fee455887b16c.1709040499.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Tue, 27 Feb 2024
	13:28:10 +0000")
References: <pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
	<pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
	<84e7fbc07e08956e6c493baf499fee455887b16c.1709040499.git.gitgitgadget@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Tue, 27 Feb 2024 15:46:15 +0100
Message-ID: <gha5nmnex4.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Currently, that logic pretends that a missing parent commit is
                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> equivalent to a missing parent commit, and for the purpose of
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                  
> `--update-shallow` that is exactly what we need it to do.

Chances are that I am wrong, but to me the above sounds very irritating.

> Therefore, let's introduce a flag to indicate when that is precisely the
> logic we want.
>
> We need a flag, and cannot rely on `is_repository_shallow()` to indicate
> that situation, because that function would return 0: There may not
> actually be a `shallow` file, as demonstrated e.g. by t5537.10 ("add new

Again, I'm not a native speaker but I understand the above as
"There may not even be an existing `shallow` file...".

I'm not sure -- the sentence just "feels" uncomfortable to me.

Dirk

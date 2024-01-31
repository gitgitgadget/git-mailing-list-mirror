Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119C882863
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 14:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706710147; cv=none; b=tQo9V+Bdt5zcqYceH2LPEv0EXUVzR+a3l/WmJ9y2jc0SFKJBdJXsg5FkTEwgBs8CsvGXmMS7z9Hvoi07Zqeru1s/NyQxQbjVu6lvKvSbyTiRzUvkVQWqwi+5uOJ1JkhaICx1Nvbd+r0gXqUHmY4pMZPvgsSn4O4lw14OdYuGKiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706710147; c=relaxed/simple;
	bh=tFN6y9u6lsPhb2erPavXN54dSf2MTpqjJjynPf5c3V0=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=pbtiJktFOzFiz16XMJcQCDiYNsK33ZZMK/e8spCh3KZ64v+KQwTVltM3piqXx2oemcYPArMyBmfMbry640Sga3HIv5F82zOLBzWRsdBGGVW5BOYvf6BNSTdu21oYQm/j3HS1bY1jeIsKCJucfjvbczFX59JR3ImXSdRIdYGJnn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=E9qZrU93; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="E9qZrU93"
References: <cover.1706263918.git.ps@pks.im>
 <b0982baacf74a4501ce5c543b294bc15d6937875.1706263918.git.ps@pks.im>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1706710140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e+YVABRB+jLd0q21N3GHJCH3OQpi1wAHm8Ypg+7t7+k=;
	b=E9qZrU933NO3YdI/5uys4d8CvqhZxgKDKMmh8bbd/ToBkzu2vEmXBJ89GCHlnBYwDNC9LY
	ujWwB2nxeUDE2dC0MEj1WwUMHuw5Hl3XrCP6vNLN/U9E44AjkLpSCMV21zgXbJwKrscvgO
	u/VuXpOgc0+Zi7hIta7GpKppC1CHCiA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/5] reftable/writer: simplify writing index records
Date: Wed, 31 Jan 2024 14:44:38 +0100
In-reply-to: <b0982baacf74a4501ce5c543b294bc15d6937875.1706263918.git.ps@pks.im>
Message-ID: <87sf2dppjt.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT


Patrick Steinhardt <ps@pks.im> writes:

> When finishing the current section we may end up writing index records
> for the section to the table. The logic to do so essentially copies what
> we already have in `writer_add_record()`, making this more complicated
> than it really has to be.

I didn't feel like this commit message made it easier for me to
understand, because I interpreted words differently than you intended.
Using "may end up" makes it sound like it's unexpected behavior. Also
the use of "copies" implies to me it's doing a copy operation. I would
rephrase it to something like:

  When finishing the current section some index records might be written
  for the section to the table. The logic to do so is essentially
  duplicated from what we already have in `writer_add_record()`, making
  this more complicated than it really has to be.

Other than that, I don't have any comments about this patch series.

--
Toon

Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B66F263C8E
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 07:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753774692; cv=none; b=KwEiYWSCZLIFHOczkRNHNa211pklhhn6aIQFt9Rq74eZJUkEjWGwQmFFzFI5BD1yW5nzJcMOBTJjGd8D3LwiECaHaid8XfBm3QwVPqHF7Dz5/V5mCVwRTwPH2JXv++/+FtHgcO4jxTLxwJc/0tJkh2GKSFCI5SS3onSP7WMolms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753774692; c=relaxed/simple;
	bh=/nK4B6vMHessgg4ydZy1h8xW0ULlsg2kvGwLq/1WBlg=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A+MGdBsEKPFLizhqdBsvbrSR6aSwk0vNInEF2sUg/aZPpXflw90RNhCeSP7XF5+UyNVHyUQ40KxzNngtzrmzm6+VEn5dJcc3I5jZMdgHtc9KzMtzkwLS9nneaHdqYr3bOdjAAxN+fjnwBlR9NCZqLxTV2gQcbtWo/qemttxRplA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=0PYkdZ1p; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="0PYkdZ1p"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1753774680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/joHn7QdYQxWDhpMonxa0NL1INF82rI/TwMW1hQQW5E=;
	b=0PYkdZ1p5ciygDgWPKHYnSme5Xnd8b8nnSbIRFr36yg0bPRcURZ9i43ZNJcAJ86y8LtRZl
	zO2NeNbRuF1afpkEUuGwD4IVbj9V705h09v6XBbJsA2WdwHsShbF87FoIab/5KRlQOExRR
	QoXRkV4nO7DUPi/L8Jw/16nlrHpRU3E=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2025, #08; Mon, 28)
In-Reply-To: <xmqqo6t3sqrc.fsf@gitster.g>
References: <xmqqo6t3sqrc.fsf@gitster.g>
Date: Tue, 29 Jul 2025 09:37:47 +0200
Message-ID: <87ms8na1mc.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> * ps/object-file-wo-the-repository (2025-07-16) 17 commits
>  - object-file: get rid of `the_repository` in index-related functions
>  - object-file: get rid of `the_repository` in `force_object_loose()`
>  - object-file: get rid of `the_repository` in `read_loose_object()`
>  - object-file: get rid of `the_repository` in loose object iterators
>  - object-file: remove declaration for `for_each_file_in_obj_subdir()`
>  - object-file: inline `for_each_loose_file_in_objdir_buf()`
>  - object-file: get rid of `the_repository` when writing objects
>  - odb: introduce `odb_write_object()`
>  - loose: write loose objects map via their source
>  - object-file: get rid of `the_repository` in `finalize_object_file()`
>  - object-file: get rid of `the_repository` in `loose_object_info()`
>  - object-file: get rid of `the_repository` when freshening objects
>  - object-file: inline `check_and_freshen()` functions
>  - object-file: get rid of `the_repository` in `has_loose_object()`
>  - object-file: stop using `the_hash_algo`
>  - object-file: fix -Wsign-compare warnings
>  - Merge branch 'ps/object-store' into ps/object-file-wo-the-repository
>
>  Reduce implicit assumption and dependence on the_repository in the
>  object-file subsystem.
>
>  Comments?
>  source: <20250717-pks-object-file-wo-the-repository-v2-0-36d2cd6c700e@pks.im>

I did do a thorough review on v1 in the past and did a little less
thorough review on v2, but the range-diff is tiny anyway.

Version two removes the controversial commits around global config. With
this, this patch series is not able to drop USE_THE_REPOSITORY_VARIABLE
from the object-file.c yet. Nevertheless, the whole series is still
worthwhile to me.


-- 
Cheers,
Toon

Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4E3338910
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 05:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784092168; cv=none; b=FKMnDAEm/yzGxZuN6nA6QPTWXD0xJpN6NXFCDvNSPfvLNh/BQw2nqfJJR/JR8HlB+pJ7J/WOJtuOQ6+FN0zwpstY1rhufhLBiHsQ3XaVpAvx5rAxcm3R8mwagY0smyHutxo4ueYOOM6SqF7zQNMmBCHjLtG28DimI8ageLX7jwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784092168; c=relaxed/simple;
	bh=ApTbsoI4cgsFkrDSBukmoGULOGuLXJqbqECe62THD/w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZwnYKJQcnglP9I5Wv9sWf2RcphwY2oPcXnEbY5mish2DehxLNji6H67dyjWXEVm2seaTb4s9WclZ/a2sPPrJkzD5qGRfJgRa3ZhPW8Eb0T4gXewiZMiW7IZxH37ptHiH31vln4x6FabNeK2nvod4AC8LrpmpHpcyCB9s74PcRVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=c2iV2I8o; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="c2iV2I8o"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1784092162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=canum5eBM5FgH2a3PVXWfiu8CaCDLNjGFLtMdzKso1M=;
	b=c2iV2I8oHyx+OtM2ONRmTuZn5/cXFUr3jWBFKXYI6lN23pv0/GRiZFDmRY8ryHoerbc1y5
	yOokdN0Wo+LyucruofWAipx7KdlNtJIrQGq99c2AuBaut6IwNS9QguL8Y6LLKolsGiIXu9
	SSmFfyR9QX/aSePzAByMJ2+bndg8uSE=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/7] odb: introduce object filters to
 `odb_for_each_object()`
In-Reply-To: <alCakwxxOc4FEEAv@pks.im>
References: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
 <20260709-pks-odb-for-each-object-filter-v1-6-82fe014b12b3@pks.im>
 <alATd_YS2d_l3CHq@denethor> <alCakwxxOc4FEEAv@pks.im>
Date: Wed, 15 Jul 2026 07:09:12 +0200
Message-ID: <87fr1kn8jr.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> An alternative going forward could be to perform filtering of yielded
> objects inside `odb_for_each_object()` itself so that it will filter out
> any objects that the backends themselves couldn't filter efficiently.
> But I'm not sure I want to go there as part of this series -- we only
> have a single caller anyway that iterates with a filter, and that caller
> already knows to manually filter references.

Ah, that's a valid point. I didn't think of that.

If only we were using a language that has lazy iterators ;)

-- 
Cheers,
Toon

Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56198175D3A
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 15:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722614117; cv=none; b=bDgKaNcK6KCcdYC8G5MwMDargzREbgC7DWdG2R/YTWIyt4DBfDT8w5rA+nh/u/e6L3xM9ga2lyvJ5Y4iZlu929oyT9VG3ud6qWv/jOI8/oRnEyvbybe/ofN59B6c0po0aIdmumBFn72jehxK9tjrrUV4k4j6j7EjKqtiO+wvbPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722614117; c=relaxed/simple;
	bh=qMrY/pM0iMjX4RNaMgpc3QMtr6c+OPB1mZgl62b16dQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bDmAs8kBtf6HvVVOb8095jUfwR6r1fq00XWOhoXSz1oL/iX/zBT/ubgO1g+EycAdwRV2PiGsU7vfWh2wz0Dq7u6W1HvdxElnryhWI4P10Nf1xI1q/OHpK6Uz2BmLNDe0aM+f6fdvscnDgUxle2dh2MgTnMPKQR5TsGaTLdse+gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=asqFl2Zm; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="asqFl2Zm"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id F243934708;
	Fri,  2 Aug 2024 11:55:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qMrY/pM0iMjX4RNaMgpc3QMtr6c+OPB1mZgl62
	b16dQ=; b=asqFl2ZmbUl4TznyrhlgyUwZ2nypVr4vpiDQvla7FDWRD+wXdMBB8g
	R6adgGzpqZqVdlXl5NBCyQ/TJHFoZ6oWQNIxJnqRCSJmR6p7U9KxlQnE/gPI6392
	hEYUNUrMG9a3YRVLlu4O+4j6vaXMjkcQ7mEMPD8ogr1mYKObY2q0M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EADE634707;
	Fri,  2 Aug 2024 11:55:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D9F1234706;
	Fri,  2 Aug 2024 11:55:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] refs: drop `ref_store`-less functions
In-Reply-To: <1d9add71065dabb3d7bf81529d04afbcf91e3a69.1722577074.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 2 Aug 2024 07:38:19 +0200")
References: <1d9add71065dabb3d7bf81529d04afbcf91e3a69.1722577074.git.ps@pks.im>
Date: Fri, 02 Aug 2024 08:55:10 -0700
Message-ID: <xmqq34nmgbs1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 99C1F922-50E7-11EF-ADFC-92D9AF168FA5-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> In c8f815c208 (refs: remove functions without ref store, 2024-05-07), we
> have removed functions of the refs subsystem that do not take a ref
> store as input parameter. In order to make it easier for folks to figure
> out how to replace calls to such functions in in-flight patch series, we
> kept their definitions around in an ifdeffed block.

Thanks for not forgetting this.  Will apply.

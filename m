Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6296433EB17
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767798806; cv=none; b=IEds7eLd7qacOAUsa0egD6MUlFuGBKOoGU3K6RZZk+vnKkm2FupXU/wWy74kYz00R4sLHi2R7MQ/MMKjJwDGZGFa/BCV8vp6OoRoE+Dp8s+wFj8S8DF/HPieN6sVR3XxAptIkaffQrRkrMTuPRlTTi3lP/sIdIEtivY2vXR9Jbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767798806; c=relaxed/simple;
	bh=WkCFX9Em9Qj3VxZtp+uXx2vIZuES14jEWR+S/ElLoyo=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l3hqEglNy67xvITvvZWicKkrHJoNCdx2bLA4ULfs3FK2KhiBD9rDMrWAAaMckqZ/LahTgm/tgODuhcviPlmYnPMcOIwzEopMokzNfKhnRAPbeMwVxe5v2lyGMtkRaldiY09rPcx9tMZVD4k3w8v13Ii/vPcAsB8Ca14b9owm7sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=LJkvQVnH; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="LJkvQVnH"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1767798799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1WI9XHFcZIq5nX8+1Icyah6QhCcWa2ODfReE+cbBEHA=;
	b=LJkvQVnHdrJiixj2Su8SMpvTlY+oc/TkGBJZOsc1GiRNnsC4jnJqUJ2r10Z7ZEoVYBnG1b
	4Cb28PAyNxQwy0r0lt3ufQ2F2CcHEY8bDYjfwPLnxSIJ/NfihtKDk/PgfqDO+HD+YPXrd6
	Xx01nWmWt/dOzFyMzg67jnu447+cI6I=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2026, #02)
In-Reply-To: <xmqqbjj8koe8.fsf@gitster.g>
References: <xmqqbjj8koe8.fsf@gitster.g>
Date: Wed, 07 Jan 2026 16:13:03 +0100
Message-ID: <87zf6po3r4.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> * ps/packfile-store-in-odb-source (2025-12-17) 12 commits
>  - packfile: move MIDX into packfile store
>  - packfile: refactor `find_pack_entry()` to work on the packfile store
>  - packfile: inline `find_kept_pack_entry()`
>  - packfile: only prepare owning store in `packfile_store_prepare()`
>  - packfile: only prepare owning store in `packfile_store_get_packs()`
>  - packfile: move packfile store into object source
>  - packfile: refactor misleading code when unusing pack windows
>  - packfile: refactor kept-pack cache to work with packfile stores
>  - packfile: pass source to `prepare_pack()`
>  - packfile: create store via its owning source
>  - Merge branch 'ps/odb-misc-fixes' into ps/packfile-store-in-odb-source
>  - Merge branch 'ps/object-read-stream' into ps/packfile-store-in-odb-source
>  (this branch uses ps/odb-misc-fixes.)
>
>  The packfile_store data structure is moved from object store to odb
>  source.
>
>  Comments?
>  source:
>  <20251218-b4-pks-pack-store-via-source-v2-0-62849007ce21@pks.im>

I did a review, had some questions (some I was able to answer myself in
meantime), but this series looks good to me.

-- 
Cheers,
Toon

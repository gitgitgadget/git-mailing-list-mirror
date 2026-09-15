Received: from mta0.migadu.com (out-81.mta0.migadu.com [91.218.175.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDAB480DD3
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 08:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461749; cv=none; b=oHmFjzWLbNLavyphsZETjP7Uroxj412iF9tkmfvzJEkR7DWu4qmlwXjTNrlDJHLLdI9dQdwNpaVyh0fFPswJ925CM9Mi0Mx/nl/9OboawtQYSPMnCzqbY0e1ssOcU0LdOOOvFLMGqVLQC2HAmhOklz7CTIEYirkml+vBCbiCJwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461749; c=relaxed/simple;
	bh=VaOPD+iys/h+4Mcl0NbcScN6TaANiBzKKqZVYQPMc/c=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VgVHsngiXWz/oNA1qrUjMu+TPIKkJNyyNg3jMAbpye9s+v5tT3AZ9w514z47gMq5CmtezO1aKrDO1vjSxuKPSn/v8PWb7XDkdO9whkfXKDLEW3cLhRKBjQ7NrZYPl+0Y43zjjF/b+BQYMbp7muoOPKV8KhE9f/FX64s1h3uyobU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=wQdVZLfz; arc=none smtp.client-ip=91.218.175.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="wQdVZLfz"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VaOPD+iys/h+4Mcl0NbcScN6TaANiBzKKqZVYQPMc/c=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789461741; v=1; x=1790066541;
 b=wQdVZLfzvLgmpBhsRwteQD7P1itsgpH4iQ2ULjHPVBnYhM9GvbWgCjIywmhgOmc1yvJyca41
 NR2Rgb+zmJdbV3pQHLZPzzViPF/zDfBdk36m4agG6zC15hv2Bd8r1fqzD1aFzNFMXGoQYw2SFAh
 UjbK7Chc9KqcxW62nJ/Of8dg=
X-Envelope-To: git@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 34dd7dcfd9c3feed;
	Tue, 15 Sep 2026 08:42:11 +0000
X-Mizu-Trace-ID: 34dd7dcfd9c3feed
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2026, #06)
In-Reply-To: <xmqqv7874nm7.fsf@gitster.g>
References: <xmqqv7874nm7.fsf@gitster.g>
Date: Tue, 15 Sep 2026 10:42:04 +0200
Message-ID: <87zexiq52b.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> * ps/odb-pluggable-fsck (2026-09-11) 10 commits
>   (merged to 'next' on 2026-09-13 at ea4130138d)
>  + builtin/fsck: move loose object verification into the loose source
>  + builtin/fsck: move multi-pack index verification into the packed source
>  + builtin/fsck: move bitmap verification into the packed source
>  + builtin/fsck: move reverse index verification into the packed source
>  + builtin/fsck: move packfile verification into the packed source
>  + odb: provide infrastructure for pluggable fsck checks
>  + builtin/fsck: don't check alternates with "--no-full"
>  + builtin/fsck: de-globalize option handling
>  + builtin/fsck: merge `fsck_obj_buffer()` and `fsck_obj()`
>  + builtin/fsck: use `fsck_obj_buffer()` when checking loose objects
>  + Merge branch 'ps/odb-eagerly-load-alternates' into ps/odb-pluggable-fsck
>  + Merge branch 'ps/odb-pluggable-pack-generation' into ps/odb-pluggable-fsck
>
>  The consistency checks for the object database (fsck) have been
>  decoupled from the generic builtin implementation and moved into the
>  backend-specific object source layers, making them pluggable for
>  different object storage formats.
>
>  Will merge to 'master'.
>  cf. <CAOLa=ZSi1TiTZ=i=SQp+pmjTOm2_wY-NiCotx66+M6VDKx=ZXg@mail.gmail.com>
>  source: <20260911-pks-odb-source-fsck-v3-0-ef2fdc085e38@pks.im>

For what it's worth, looking at the v3 range-diff, I'm happy with this
version too.

-- 
Laters,
Toon

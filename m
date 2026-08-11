Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424B93B7759
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786463400; cv=none; b=VWIfsiaAjfD4EXZVRXGCk9v0XaR8J3/sx3dGbCN3Z7CXL/Vx3ifNZCPT7PnKUuIM8ATUYgpSxqCzMQriepTGZ87CCZm0yMKoCVeRp3nEHlU2QdEbEF+oM9XioRYBX10U1TZ8J92maP1kxGcPEtWHg5uepBdTYsz7ifLq1oCF3xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786463400; c=relaxed/simple;
	bh=RNTMRsvhUr03tko2tAhIRIZgh8O+HU3dSRXAHJMW3AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSzavRdxARyUqM4GcBwgF7DWS/PgpNvTfm+KIk06uf1aGcPfHh1y6fg8UlueeIPY6t1HUqP3B9eMGpZmzX+04oV9Uqpi8QV7Trh/IDuspNj/R6lL2ggt3XNHYAZCYlWkLuTw/57btcP4hMmCsFV1PikmsJ6yF1ZVs1npmqR9OlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=U3HXbQMS; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="U3HXbQMS"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-81f3b227a4aso47909037b3.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 08:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1786463398; x=1787068198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RNTMRsvhUr03tko2tAhIRIZgh8O+HU3dSRXAHJMW3AE=;
        b=U3HXbQMS++xoGc6PHJjmqzWSzzgAjbNEIvp+0Pa87iL6iDky8e55sSqDAy+iChYHXp
         waM+nN6FqAMzZXQnOZWWZ1u7QHaUsZxNnUWDCneOtH4QgMnevQnsFtQOSi4yQ4lSzHTu
         mN2e1FwtLfeeQ46+3kXf67eF3niRQaP8vfghU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786463398; x=1787068198;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RNTMRsvhUr03tko2tAhIRIZgh8O+HU3dSRXAHJMW3AE=;
        b=C8PBgJCRTyVtqEzv8C1JCK8kPFUa05wTPjOxD96nbvVlF45smNlNnLMWz5TyR7zYYl
         r0GSuORmfMy9axl5BHvOdmJe4jvT5RD+NWYsJH+pMucR9sDBC1iAFQkBtsnHpS/olGJm
         gypLbqHgvpoNYTgdGDDTdbGP0oKxKiZA5aBy5smtaUQiwdecV2INTCj4JR7kDhAZGZeO
         KlZ1QYfml99zf+SYJKJ+4NSIpG3xdvBR/sTI+vbIrPPtn82Ypq0MUL00O+20dqbMrxZR
         Zhym+NypJFUXDQkCKEX8Ja4gkuvLL9W/3+FyPPsIb4+uVcIwgkriq1lg4Se+RR/1B7mW
         Ia+g==
X-Gm-Message-State: AOJu0Yxy+AxhHy9yXv35BLJ/QEYvB3VcP63WkPSCt6qKCOJ9xPGz8bPe
	6KY7BzuodgNis+/+dET8F4aBqfiVe35km7fV7zTvDa4fJ1Xe2/GDzGzqWjftSrq5xdc=
X-Gm-Gg: AR+sD11hGb3NCwR8/9cpR6wsn+W2fx1w8YNGPBIjZtWRnsT4o8QLz4hgkDP1euWfIB3
	BmmKU4WjgzMZAmCV171MkkJKOrgFP24etUuDQ7TAaL3VDcohO4GGLLJgwYq4LjC2MYGtvtpfw4z
	rM21+VR4EnOsBKRgTk5sZeFXsb7SrD/T9rLrTBSsKI/X0CGum1sWDJ/I5QrKjmW6ipm8xxOdnqP
	toA9Q6OtfhNscsbEQhkEIK63eeS3LHvKo/l9gEZqL6hXK/8svKmWiEBK0O/mYr4CKj598MfYaUC
	mSAezYY9LhrXncHYIWT0bYIcjw8aykFDZ0JA6H5c+OWkGyn1zeighD3IvCYvGgzU19xjYsyab1n
	WiF24p2kL4FjZ0z+xClxpGglSFowCUCQ/qs50Fc/vxu+RDiwDc3ucIBUtV6im91bZ5LZzmy9Lq2
	KbzCCaVQz2438eeOX+i4/zZM89HEXRJ36QdDSXip4QTsxiAyjK8y4I0CRcQhyifec96L5ah5OGb
	O8nk5HfCvy8xDRy578K5s7BJRDbUrIu0bA8iLAd14aMdA==
X-Received: by 2002:a05:690c:7308:b0:82d:aaf8:b263 with SMTP id 00721157ae682-82f2a13d902mr31995667b3.10.1786463398060;
        Tue, 11 Aug 2026 08:49:58 -0700 (PDT)
Received: from com-79390 ([20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-82ebe151ec6sm12109257b3.16.2026.08.11.08.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 08:49:57 -0700 (PDT)
Date: Tue, 11 Aug 2026 10:49:49 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Ted Nyman <tnyman@openai.com>
Subject: Re: [PATCH 1/2] maintenance: account for promisor pack geometry
Message-ID: <antEnTVfHFEGQQZ_@com-79390>
References: <cover.1785902237.git.ttaylorr@openai.com>
 <a9de123b43efb58c53c99c71eb7e34f29e075071.1785902237.git.ttaylorr@openai.com>
 <annqJGFJPviEyfEC@pks.im>
 <ann0nnSGfSJ7y7YK@com-79390>
 <anry8wAbkxNfVgfh@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <anry8wAbkxNfVgfh@pks.im>

On Tue, Aug 11, 2026 at 12:01:23PM +0200, Patrick Steinhardt wrote:
> > So I am not sure that I understand your concern here, but please let me
> > know if I am missing some aspect of it.
>
> The concern is that it's quite unlikely that both the geometric and
> non-geometric sequence will merge all packs together at the same point
> in time. Consequently, we'll never hit the case where we perform an
> all-into-one pack to prune unreachable objects, and that may cause us to
> never prune objects at all.
>
> So what I'm wondering is whether we should be a bit more clever about
> that and perform an all-into-one repack under a new condition, like for
> example when the objects we're about to repack exceed a certain
> percentage of the repository size.
>
> Hope that clarifies it a bit :)

Ah, I see what you're saying. We should still be OK here as the goal of
geometric repacking is to converge both the promisor and non-promisor
packs towards a single pack, at which point we would do an all-into-one
repack.

If the two are perfectly out of phase, then this change would prevent us
from running all-into-one maintenance. But that does not seem like a
likely scenario, and the behavior here should be a strict improvement in
the meantime otherwise.

Thanks,
Taylor

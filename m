Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4412D3A93
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 04:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784002072; cv=none; b=ehBYib5ZvyXkoYnoufssuo1a1c7bbxVM8FR/0hb9qLcTaHxCcgqAHlGLLn5WwTrU4K+ojrcVpJKNQTu4vBkRlUBoyurfgwK0KnX/p5kodSt+/MY+6rGTi4UJqkbIq0CXmPtzfjXamX++K8PQbef9ImlhAQhYgTLey5c/sYNwtNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784002072; c=relaxed/simple;
	bh=jGhR7D2BN7mmt66roYelR2z9Ui7Kn1YKMjZ/pgDGaEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrNzKzmW6W1o7allhrO04KsxB/R7t4Ui3EMh3bcNt+1d63u97MxvnFmn2YUub431BDCk3nyr7aNWOqnrJ5QB+Nc5ebv6uD+29+cvZ6IP7Kh17ZgFNU8YCuQafc38PAfnmI70lR07Z98eL+rJOGlILdYJhsDphGrGuN3jKSeaqG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=TXbkVj1B; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="TXbkVj1B"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-902f92b8504so30798496d6.2
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 21:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784002069; x=1784606869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jGhR7D2BN7mmt66roYelR2z9Ui7Kn1YKMjZ/pgDGaEg=;
        b=TXbkVj1B3Fu6jeASwgx0dz3bTBMot6hcz1H/VbWD4sz84CmAyz6SPh5fPu+exsUU0L
         YVA3t76MWccvOkDb8T+Ei/x7WA68JyQ7CDxBHsOnKYnuaoZ9SXP+U+fc+ddVJeELe/oU
         /xarWb5Iz2/+u67NFrBv4ZViGebiD9+4S3tdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784002069; x=1784606869;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jGhR7D2BN7mmt66roYelR2z9Ui7Kn1YKMjZ/pgDGaEg=;
        b=qwaE6WexKcRCDADgI7Y/tyeplFdIedIyFGbJDUNadjsLEU4NtqDG5hbi/kbC8At+ZR
         gKEbNykL4yzzksMAzARdhSfASNecedjv/i1wbrjf4dHPtPDZktMuYDRMtCO+12oGQSrt
         qfDW8Hi/NcOcJJoYY8mLZLZsBdK0kS07e0PzoVJIVYsdyoVz/sqEKNFnsmWdtcsvRk54
         nl+Doggn591mhF8FOpKblKVd7sKnvu7c1VyYtey0Z4APGCxOMv2AnfSPQd0eLbuVzVL7
         8N5Slg563UD4oKlMn6qL0ZapsX5IfUfXxc8JSwDO8WERkgFZMAMfOUjqV0wpL4VR3bZH
         W9vg==
X-Forwarded-Encrypted: i=1; AHgh+Ro8mzZVoMvEOO9xTBzptrXRecZDMNxLRIrh4BBIkaZUP0MwVOJ4BBZO5IuVHtNn5FWGWX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAnuVceTMJEEGTlLEdYa8TRpblClc2w6q9HwU1sii6czQ+cMt5
	Za12xw7Np96mA9CbjdPdB1XbmwAWfdnJ1ZbxzBOiEjnfo+MBR86bMWix/Txfx3xS5bM=
X-Gm-Gg: AfdE7cneUmXBy0xns3GVxYZfnkqTxIUE1fiUNmRbWp8UzoEH5wyQ+XTQihGNVSj3C1Z
	oHiwYsDsfSGmaPZ38Jhx7gdKG77SBY2LJsV2uJR6v4Ujfq4OXJSlYWBq2hFhEmWMgzwHK3z7xLE
	Fy/m62KVwtEwnHtQoDvJufJHTveJY7HBj980n8+GKGsFeCsDMWyPw9fYcUgntqWCZQvLQ85Lhrn
	8VOVZSXIg8kehBXSdzr/Ca4BoxfXidVn3CrVfWCd0axLbHVw6h6JQKQ0LGHRNasB5tIsrop37JU
	1FB8Yl19AYf08QghSdWxyyL7vokFzHUjXisB8nlYFriLuxgcMl6qKZsZX5JOiYwc2sG+p9TBJuS
	sjP/NvFWWJvFC46/Ld1n3cLivWE0xA/1GOeJv1xIvEqB99yi+NxFp9I00P7m6zV9DN51qV4B7O6
	0ZgRpMoYKLNM6VYLi/X6sU9IZr
X-Received: by 2002:a05:6214:e6b:b0:8fd:6de3:bba8 with SMTP id 6a1803df08f44-904053d916amr129372416d6.62.1784002069527;
        Mon, 13 Jul 2026 21:07:49 -0700 (PDT)
Received: from com-79390 ([209.249.37.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd86d43e2sm155985326d6.43.2026.07.13.21.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 21:07:49 -0700 (PDT)
Date: Mon, 13 Jul 2026 21:07:46 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: Ted Nyman <tnyman@openai.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/2] http: use unique tempfiles for packfile URI downloads
Message-ID: <alW2EnNR21VmkESW@com-79390>
References: <cover.1783982021.git.tnyman@openai.com>
 <alVn-QmK3K91_tkH@com-76773>
 <xmqqse5mv10a.fsf@gitster.g>
 <alWXwAGWgXSXoRJv@com-76773>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alWXwAGWgXSXoRJv@com-76773>

On Mon, Jul 13, 2026 at 06:58:24PM -0700, Ted Nyman wrote:
> > While that does sound like a safe and correct approach, stepping
> > back briefly, would it not be wasteful for the second process to
> > download the same packfile that the first has already started
> > downloading?
>
> Yes. If two fetches overlap, the second download is redundant.
>
> > Are there better ways for these processes to coordinate with each
> > other? Instead of appending to the file, what if the second process
> > uses a predictable temporary name (which we already use) to open a
> > new file with O_CREAT | O_EXCL to avoid this redundant work?
>
> Using the existing pack-<hash>.pack.temp name with O_CREAT | O_EXCL
> would prevent concurrent writes, but EEXIST alone would not
> distinguish an in-progress download from one left by an earlier
> failed or interrupted invocation. The existing .pack.temp name is not
> covered by the tmp_* pruning path, so simply waiting for it to
> disappear could leave a fetch stuck after a crash.

Exactly. If two processes are downloading the same pack at the same time
to different locations, the effort is of course redundant. But I don't
think we can reliably distinguish between that case and one where an
earlier process died in the middle of downloading a pack but was unable
to clean up after itself.

Thanks,
Taylor

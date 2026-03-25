Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C50230EF84
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 23:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774479793; cv=none; b=CYSsSaG2OoWXxPBDdNGizoXn7+J7Tx4di3MQXzOPf3Kr0NPPcgc6xqWM185t5AuzmLdnE65oATrscMB6FCVAxGNjWrRwNH2/8xul4EeUI6OsL+E1fD4v3hzapoF/yokazSKFkDAiIZPRuqcC1zjPB6S6uDq40sjV3TUMloRd/Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774479793; c=relaxed/simple;
	bh=lNqEskWxZWZy1zTu2q6mp2lMJu8MB0SylBDcMpTV1Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NC2NzdOQ6ToXws3M/AVQ2ACqQ6tJsAaa569Zr+IWmiqBMQXaUZG7ZOqezktTNLDZqtKFC7QN8iFhMBwof84eaEPaZ/YVKcm+cMnGt96Lhyl5xwr84wvUB+luKztQDkxp/+grpiHiXUOUcorL6lGgdXw3LWC/1m8WyMYutY61TBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=WHIeqQyE; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="WHIeqQyE"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79a74765703so3665007b3.3
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 16:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774479791; x=1775084591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lNqEskWxZWZy1zTu2q6mp2lMJu8MB0SylBDcMpTV1Zk=;
        b=WHIeqQyERnG8AjlNziCZVJH7pfgCSbHJnnmOL2ouK37Lp+eyXFMBC0BPHxSC4Yq/6M
         0bcjlOAfZr52cS1mCGV3Ct1tTomU5yV44zP4piVtBG3yQE4jgC99vwKa7lymsribVGaA
         qKoggpeEB5UGexKwZgJ+C5OVb77Sf5Ed0Qcj3hcvVHPLIOmanFzOS4mMd4Ar4axWHeW+
         h5gytqHPbxPRxYrgEbpc9Zj6fMpe0qTxHVhbV2wsUTuGh/Xa+B+G4MiN/HdKo1dGwzAY
         GQkmi1+NohI2GIUbK8/3E2dkpNpNOxhP7XHtg+71lxsd2xyq1LYhccvLvFq8wv6xtJ+N
         CHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774479791; x=1775084591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNqEskWxZWZy1zTu2q6mp2lMJu8MB0SylBDcMpTV1Zk=;
        b=Vp/Pgx0LxdSVpKKvhfJ72YSS1+m0xrC1Yyrm9MMnHraJ4HNFrvUHGQr9HYcQAyQPG3
         TjJmnnp7zGlnvnAffcqqfculm6MQ0+xpBNegq6E1Bestr7f/nP7IzLjHOG1iNhz71xFY
         lwdyDYzA1DasOwQleKMcpXRRN1iuuzE0mW/KV+YCybCRwlRhMh5J9+C2+/4V0/iWUBkg
         Zp9XaskeMQQ8YATpebczOU4eJAs+S8VZ4N3u/4tDEucCBCUZaCNTBQ4pahXzNtL7gTGG
         e+XDivrEqi+o5zqG2e1ZxdAgaXfgoRH3kkJmHdymK0YWb84tIcqmzpzo1QaRoJzeL50i
         22jQ==
X-Gm-Message-State: AOJu0YwHFUn7EC7IloFkWKBVujGDJ/aZT4YqzP2IPsr7fSkXPCMt2PMg
	FC5slj0US8Mkb+nwp5BIGrHHa6zGJIS8KTZ0f046O+kEv52iHcTEOFOZlltdImBadp4=
X-Gm-Gg: ATEYQzzO+UUrkj760gqO2gtuofaJecMSsRmdEY/3jv5bnEo2FybAPVvaZ61vnt/MxRq
	tbdfbe21rh9M3midSQJjMQaKPBmWZOXipf146ANtIgXdGxo/2jYLnPUGETKX/AECDHqAHPLlr/N
	0GaM+T1zu4mMF1Tw0Er7IwIow8Et7X/eyvY6WUqunM1o/DbxSonspKdqPGWPW/fHKj0lzArErTH
	40MnWMho/ft70e8ZbNHu8xEPeNAH4k1FJDvQ4RpSnjVG2ZeDKfDFu9QxAGdIIZgi/0QeQ8FLqmN
	X4USs8vEXIC/mqQR1e2KTQv8Z+VgH+MqrioNqHLH1Uk/K1Xd4qVEQ35JPBHczl9RFLU1ZwZUfhz
	RXwQPKkdUG9GK3NKNxoejd89x27tVODSZ/RACVTSEV4Lq47ypAJ6R3ERYYrZQCqVWHZE97C6YwG
	3zQh7ev0wu5UmniVwcJjQyk+N10ewKiCl62p7dktrTxuunyVo/xHfZKOUKfkyQ8P2FodMhqidyk
	RUmN6fbMU4Ebkx/9C7Js/8C+Km639zNJQDsCPN/
X-Received: by 2002:a05:690c:c509:b0:797:d5f2:c64 with SMTP id 00721157ae682-79acf2ecc19mr58366907b3.10.1774479791403;
        Wed, 25 Mar 2026 16:03:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79b1e3bec5dsm5219237b3.25.2026.03.25.16.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 16:03:10 -0700 (PDT)
Date: Wed, 25 Mar 2026 19:03:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/5] pack-objects: plug leak in `read_stdin_packs()`
Message-ID: <acRpruzeYfivaCs7@nand.local>
References: <cover.1773959041.git.me@ttaylorr.com>
 <1dac74f1e4a370097117754a6b1fbb6fa2b382a6.1773959041.git.me@ttaylorr.com>
 <acI_pTWTcJN6QaK1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <acI_pTWTcJN6QaK1@pks.im>

On Tue, Mar 24, 2026 at 08:39:17AM +0100, Patrick Steinhardt wrote:
> On Thu, Mar 19, 2026 at 06:24:15PM -0400, Taylor Blau wrote:
> > The `read_stdin_packs()` function added originally via 339bce27f4f
> > (builtin/pack-objects.c: add '--stdin-packs' option, 2021-02-22)
> > declares a `rev_info` struct but neglects to call `release_revisions()`
> > on it before returning, creating a leak.
> >
> > The related change in 97ec43247c0 (pack-objects: declare 'rev_info' for
> > '--stdin-packs' earlier, 2025-06-23) carried forward this oversight and
> > did not address it.
> >
> > Ensure that we call `release_revisions()` appropriately to prevent a
> > leak from this function.
>
> Would be curious to learn why none of our tests fail with this. The fix
> looks obviously correct though, and there are no other early exits that
> might need fixing here.

I believe it's because the only memory we allocate here is in
revs->pending, but we copy it to old_pending in prepare_revision_walk()
and all object_array_clear() on it.

Since our traversal doesn't use any other fields of rev_info that would
cause it to allocate memory, we don't see any leaks in our tests.

I'll rewords the commit message to clarify that this is preventing the
*potential* of a leak, not an actual leak.

Thanks,
Taylor

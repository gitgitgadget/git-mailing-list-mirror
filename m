Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337513921E7
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 14:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781879620; cv=none; b=bTZRaXrZxR3ncfuCeyoq9c9hT4BBYQKv0wQ0ebXLdhgc+WC4NmE55dehoySX1Jyr/vOSOQclRvR7fPL6KUg62f/DzociYEyIVxlm31hj5csb9DheNgeINTS7Rks+1aCa0+NfY1Y7W/7lRO+pv0pIlHAcDL7H9kxRBynpFXyEf+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781879620; c=relaxed/simple;
	bh=HaC6R26GhRo8YZRKMxXJbRi8uyo9bsBUrHcQgJ1AFXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ML7oBBbTwfBq0ijgLtzwkvHZ4/Hno3QKT5SxmzkN369b+5ARDrFh4v2qPNIUas7f9rSykW2CNM0d0ADstsJbiUgne0WsxGUi1Dnzt1/MH934c+S7UiApIsCjP8NPgJwDwJ7nvkF7p9IzscnB3x9QL97bvem8rXP+iAc0XfJb0FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Rpfqr0Du; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Rpfqr0Du"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7dfe7712572so23541747b3.1
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 07:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1781879618; x=1782484418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=30TaR0Z18gsgZOIQXZ+HcYoLFLrEIReO2yttDxg1ncg=;
        b=Rpfqr0DuklXHp/qhJpIw0riNJ16PvN/R3hMJeF7czMknAC+ES81m0RoGtMY22ieM8D
         s6ugkcedAGoBT880v7p3L2PedzYzjcqb3Jyirm3PcQUtZaZr7bGiSilAhNP68NFjzdmd
         DaGu4mr4vxowDhe/4+cvpB5kzBgRiBYBIk9OHx1mT+Rup0J6lfkm00JB4B1ZOMfFbtH8
         qyRe0+vTAt9PHQdx2yN4SGNRexx+Uh04UwF8x345Zo3PblmHoaWqupl4KhfNouEwshIV
         eBrfIYEVYozu9CvyNNVaBubzvGox7cypm/5mHfll6iHodOw2bFnwd1s4nmk0XuWWvZyr
         QyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781879618; x=1782484418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30TaR0Z18gsgZOIQXZ+HcYoLFLrEIReO2yttDxg1ncg=;
        b=sNFDW4Il5lxB2Cyy8mAkDyy9eqNoGBusGxQOGGP53kCu7ASNPtHKOblgdzhf3WtTb3
         0gBBG6U2fciPraOs57v2nihTjo7gKBWg+JwMYy2np8h1ds9emWSGtpMTeERNRJOBS7mP
         zXJerahNh/fRpuu4fk60GgVHIAsVXkGLobiR3gmrnf04+v0B8b8Ap/qRrVnxQMCzYb4L
         BT5t7T8kp3zit2i7etYdBCYLMiVLtKYBaeRhsOmCGeLDgWoAmlNPr4R0bR9dX7J+YyEu
         1UBPnlMEg8mFwFDOm2H77lIMjU+O8BHLvZ1/UbtB5Rufhz7R922OJkAuugzUUDPm1LhH
         SQEA==
X-Forwarded-Encrypted: i=1; AFNElJ94rHpS4lVnBCmogCecnA3Nal62L6TuuhOdQGOuj8758DQrzumIxOSYCXoMBiiUxNiQhnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFyOcYG/1xd9cy5u1pn5p2TKg3rsJMG+4nkTGrp/7JJ1EUYfuP
	NCJmn0/XkJo3yXwJL72hftbtGB9qWgut4qd7ZT6J8sSsxkWVxeDLHBjkmXC98tX4KTI=
X-Gm-Gg: AfdE7cnbASKZNBnldAczcc0k+6r+BlC4Yta39WkzhKNXbvAjTeA/tKdYdISCTe2DTZP
	hCS2aM0movy1Z2PtB2VMJDbF9PTtq+INN2/xw+/1/raLno+9gpNjw4Hu2AElH60k5GL+A67BvZo
	BNB3jPs5XU5wl43WXVotvb8QjYIO/pkuEC2gzZHwvSNnJbXldMDO5Gt79AG18hZvo7KB+HnBC6y
	AKlltuqi0vvY2Q8bUBGbnuiwBi0WzjHxyIC+oT9j70p+UePCQN61eABIw2xqg9ixr3HnNacbDvj
	6gwfU4r3xAfXVgu0jutyYdgbgjuWRO6oyQAkAOhPNygQyI9eIDdQ/dSELaQR1qWjp7d2cPPCbw0
	sCKY8ldaAfianprXP9wPDwNqvChAfuFjxbjGRi/LJGuLYCkAcU+menNCQdOX+hFPu5oI1VWoUQM
	MqldKlX5j58d7rBTPyfw4WfZ8e+cqZ9utpRhat0jLJO/L/addeRtMASjKjhgyhtTnNbpoxw0rAt
	zqziO9ARoCvvCiZDCQrTmSc1Nnf2EGX+My3B5fA12+AVGDzeQsVDsTy2x9qUwPq5l+2lIb2sz6W
	eZQd5g==
X-Received: by 2002:a05:690c:c50f:b0:7cf:d242:d94a with SMTP id 00721157ae682-80133503503mr39590377b3.25.1781879618114;
        Fri, 19 Jun 2026 07:33:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8011981083fsm12291807b3.10.2026.06.19.07.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 07:33:37 -0700 (PDT)
Date: Fri, 19 Jun 2026 10:33:36 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2026, #06)
Message-ID: <ajVTQPcNwaR7VM75@nand.local>
References: <xmqqtsr1w0z4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtsr1w0z4.fsf@gitster.g>

On Wed, Jun 17, 2026 at 10:06:23AM -0700, Junio C Hamano wrote:
> * tb/midx-incremental-custom-base (2026-06-12) 3 commits
>  - midx-write: include packs above custom incremental base
>  - midx: pass custom '--base' through incremental writes
>  - t5334: expose shared `nth_line()` helper
>
>  The `git multi-pack-index write --incremental` command has been
>  corrected to properly honor the `--base` option. Previously, the
>  custom base was ignored by the normal write path, and the pack
>  exclusion logic incorrectly skipped packs from layers above the
>  selected base, breaking reachability closure for bitmaps.
>
>  Needs review.
>  source: <cover.1781294771.git.me@ttaylorr.com>

It would be nice to get this in before v2.55.0 is tagged, but I don't
think it's critical. In my analysis, the worst thing that could happen
is that generating MIDXs with a custom --base would result in a failure
to generate bitmaps, but not much else.

That's unlikely to be invoked manually, but does have the unfortunate
effect of rendering the new incremental MIDX-based repacking strategy as
useless in this release.

I'll add Peff to CC in case he has a moment to look it over.

Thanks,
Taylor

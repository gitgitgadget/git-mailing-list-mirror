Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF42E28D8F1
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 20:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759955144; cv=none; b=NwCtEEOxjdhrWIrrVB7pyiPaKjdgo4knmFSed8PdFW1SSF5mZ3+iOfejaICWevBd1C/Ga13rJOGaIk0yY//XTDKnBff0DV2/Uc4keXPRs42ll54/P5WScS5zugkI7ZUgBp91xoLycvvNG5fZym7/UBWG2gmI/tTywvWnlojGTJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759955144; c=relaxed/simple;
	bh=ofko6U6hlE6VHeyPfk31iTbQDSRpFp0X1ayLrJNcvDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGIVAI77kCzk3Uv2YcwCaq8Y/u38nXeJ6bR1MnMpGAQCmXbLyaWgJetpo3Yse0sVxUDAGKP7kOgERlK6d921bo/r27g8o9vNHI52PXC1NNiBKXT1sHx2C3V6R/37mCPAOPu7J+RfiJBcAQxUnAsX/vRuR4UbUEXCflo9i4HM4I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=CKCpEh7W; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="CKCpEh7W"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-92790f12293so8749039f.2
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 13:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759955142; x=1760559942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ofko6U6hlE6VHeyPfk31iTbQDSRpFp0X1ayLrJNcvDA=;
        b=CKCpEh7WidwBaK0GGpndpDZ07kRt7hgYO31V/HzLvB4eo4IyKYLQlCrJKsjfwntY+x
         qOqhOLeemPauvqwV3f0O1WfLePKm9r63HpCTqevk/MV1W3gJiba5NipShyD7ZJdfoun2
         K8E/yQJ9pX8BHY2z1V+x7c3SDKYQmPAUbcTDYExOMXoj8k+a1DdCHmW9sH9TP62WFgDG
         9K1XFOdPYChCT5KsrUO8KRiyk2r7soT4bQigz42ROoAB2ZMvLAzBnXks65pxl9DLJHCK
         zG01mDAV1qqPRR03fYjREM0rMo/yoUYTOVccPbIzJ31f1sLZNU7rdhKEEYt8mw50xAMW
         xocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759955142; x=1760559942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofko6U6hlE6VHeyPfk31iTbQDSRpFp0X1ayLrJNcvDA=;
        b=ff19UsyOu2dOmtwETaDRniK6DxSxmrzDOPhETXRhblnt2qNbrJDmoAIlp4rNIIChjd
         0vOCduQxiEMZhxA32Z2JRSTPDHW+qgI+yG+KgRk48FRbcNo62Ydvoox9bO8pD34JtWbw
         c3ftNZfnbb9tqi6xjQE+l3FxL11m4ykeephPJ5ozqqjl5TwdaS+qTuvrPEpo4SUGknjR
         pm1t8kGStGeKCmxt/0DurnsKgj740vlxxbeoXV0rWMI8EpNwfIxELrSm7/1LeLq+UEWR
         k/jc2BGCJ414juHdbrDRG2yhdl3pr8hL6Sp8vhBv6e1ZHdWWzAFxFsg09IvIEWf2LXCs
         MQjg==
X-Gm-Message-State: AOJu0Yyql2G+Nzv2Sri8bYLzL8h+rujpn9VV+v+LW3tPYZ0eGsxDCFWp
	UE6DYqW8dMdvV8/3mjwLe+yoLF+9KuD8Ebg+ciLqFKVrBBqvOYWOL+0VbOvElAJEwq2a6ygBZhv
	aOkGiOZZ1Yg==
X-Gm-Gg: ASbGnctqRgrH8ksqUKABhf96eqEvPGK1bOc5a/FLFJ4JWN8UGvwHufqzpCxm/RR7xvI
	VdXLuJ5JnGTlcGYW2buLYQStM8iz8mRe7h4D03lzn07tVbp/+ka7MxnWHX/KBW6POI+aZsqLSk+
	QSEncOvKkhRyqNrwZvFPzWfdRdQBgaREHBO+6OLNfKr3PbjP3JTZ4mYSpLCudDHupBIdYL5AHBC
	g336DKMlnIoGBXfahHI4V502lSM5ZRL7P+32zj5px4SKJCPAFIU5XUJnl9/sTDC85PuHljV/CA9
	whASXaGoCFBqnJXPDQYVK2bp1+CNMvRt6qS/Fpc9L8xN/fv6/acA+pFkXAnW/AJrxyCxu7dhmmU
	eOUVHScXxFybzf9AMRTgLTnFptavcx58Nma1RcDQVGDZRK0bQwhRS9UERFs7c8DKml/lZ449uj3
	KK0eWHy4w7WMqvzk+9oh5PyQBVTn10MI7k7MhNgurDkMsdDMUm2w==
X-Google-Smtp-Source: AGHT+IFlagAs9ZjIKViMDztJKW4ADPvKPMu18EXR+2vc5vUbE0v8+DRIw6/eJBQcCCEdjK9qD1mNMg==
X-Received: by 2002:a05:6602:641d:b0:901:98a7:59b7 with SMTP id ca18e2360f4ac-93bd18a25b8mr577121439f.8.1759955141701;
        Wed, 08 Oct 2025 13:25:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id ca18e2360f4ac-93bdb31a6e0sm23986639f.21.2025.10.08.13.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 13:25:41 -0700 (PDT)
Date: Wed, 8 Oct 2025 16:25:39 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/6] builtin/gc: convert to use
 `packfile_store_get_all_packs()`
Message-ID: <aObIw/et7DxB/NrZ@nand.local>
References: <20251007-pks-packfiles-convert-get-all-v1-0-428227657a89@pks.im>
 <20251007-pks-packfiles-convert-get-all-v1-2-428227657a89@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251007-pks-packfiles-convert-get-all-v1-2-428227657a89@pks.im>

On Tue, Oct 07, 2025 at 02:41:08PM +0200, Patrick Steinhardt wrote:
> When running maintenance tasks via git-maintenance(1) we have a couple
> of auto-conditions that check whether or not a specific task should be
> running. One such check is for incremental repacks, which essentially
> use `git multi-pack-index repack` to repack a set of smaller packfiles
> into one larger packfile.
>
> The auto-condition for this task checks how many packfiles there are
> that aren't indexed by any multi-pack index. If there is a sufficient
> number then we execute the above command to combine those into a single
> pack and add them to the MIDX.

s/them/that pack/

> As we don't care about MIDX'd packs we use `packfile_store_get_packs()`,
> which knows to not load any packs that are indexed by a MIDX. But as
> explained in the preceding commit, we want to get rid of that function.
>
> We already handle packfiles that have an MIDX alright by the very nature

s/an/a/, s/alright//

> of this function, as we explicitly count non-MIDX'd packs. As such, we
> can trivially switch over to use `packfile_store_get_all_packs()`
> instead.
>
> Do so.

;-)

Thanks,
Taylor

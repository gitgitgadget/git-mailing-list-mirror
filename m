Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D3A1F4CBE
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 22:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754345236; cv=none; b=ol20ycysVDe9zCMCgCV9GagmRvjZBLD/if6LzcivGCfVBquUdc5FV1N465PQee3ro3gLu36GxVfYMtt9rlAno5bzgWXH6o4iumrrWj4my+LMm1ixiSXNsbYbH+rGJMUAEbPGAhUrO0SPQm+hT9b8KIyA8Imy1OR3zT52lUd1LTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754345236; c=relaxed/simple;
	bh=Hhj4HesbOGeEYwxsjgtB/HzZiF8Zsn1YpXFoRvU+AZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3Ojk1KMFzKgCHqwTRBEeny1evbAIk5qnyVZcAa7RWm7lr+OYuCH4JYlDMA3PWbEdvVP0LX/7RVykSei9lnplRuZdi0GprM0ahCJotggZtDX/NRCJRkvzWyFCCKTPVy2vpGKnG6TQ0mQ/AyRYVtMjO9hMPPzI2mZG7XftLAuumM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=h27icebm; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="h27icebm"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3e3f1e69090so14832785ab.0
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 15:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1754345234; x=1754950034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DhCJI3Pinb6Wrq03QX4qna5JtgmpMArjVfku65LSHG8=;
        b=h27icebmNU8XdOc6QEhzDg8t6Q+TMq39RAEVEMndGyhBhIF/U4QNduQNqyJlq6r8Gs
         yIdcy12Zds63QGgez45wBOM7kxRUogicVayYFRCaqbhS38O/BreYaXm2q9dH2kN1/Kdc
         Q4m9afUe/2g8o4gBnzaAhGKV1aYdMHqm/RBdq4wDop3/PWr642Hd7ndoUN2it30ajBeO
         aKjnMrB+uwLV2npVd9LKEQM8/bRclcANYoqWB7oxLfo5ojDELY4YM85veOAmHdK4FrNR
         kTVja46so5swiCQFcregvXuN7j8t2lAV8BeaOC3cJKH0G17ppyNW/a6YoPA7Fn2f3nTp
         FiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754345234; x=1754950034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhCJI3Pinb6Wrq03QX4qna5JtgmpMArjVfku65LSHG8=;
        b=OZah7qAqFOjlYPfSfMBu3V4UX06xooBTevCqK4A/+gE8NGhiMankNZUxByFba/JV2Z
         1wKc3NF/P59M2+4rvli2h5Qi6f4pLND5rK4ROWaMSXBm1kHBfzAEztOzFi5f0+mvFUva
         RELYHgDt54Df4bo2/b6bUxp0BF3Zm07mH3jGKE/TJGZNQiZths8n9eoN39Oq112R3LKh
         u/qCzqXN6QAGi7ihYf/PsQ2EnAvCL5oM+H/N7H18LcUdbHmltt9tBLdCm+wkyqEbQLl5
         LAAmsKh9nH3PSBjQELpk6ALIInA0f9ZdsUtoqSPgJDBVGOU3vksYYh7T1P4Xofk/aQ89
         DqGw==
X-Gm-Message-State: AOJu0Yw95oafE7EgdNX+KTPXhqZZCT9q4wYzWJ2IHPGAelmtyg966nVs
	LYTFep4v5otwAayGlMUxHZdumRzmvug1MFocMRFA30ZMAspfbROU6/AcI/Yxq74MAx7/pnsKjSR
	9syrt
X-Gm-Gg: ASbGncucm2okCCSDQUa2/wOqPlHVq/uUJi8mORhpt5S+nbFPhS+buHPp0LY8BLvizbk
	DWfX4Tzf0lzHisTKrwZPDmdIVryQynDWb/1lSD3ZPGHmSc0VVFDPyiz5FYGS+WJg1itYrw2SUE+
	mQJ0amYLUgMzvW1rAL/o1nMhOgg4lC+EPUofgs4+Es3mfl39MV+6OgxreHG8gogBn1MSSoR25zR
	6t6M+Q74QXFEH/t/70RQwqfs9QcsRIa0McHUqpb0bnKGOuFNLOxMUBQeFPuJ8baGDtTiqYiN+kT
	crPWfCa8NMbbnjAb+xCTEwwk2lpRQz96OkiqE1DYjiECoht+YIl/vmErPzg8CBP3f4HZRXRuXHU
	aezZ88rZebIVmK6P62+cGrx/8/umJH4gD8Z1vqfraQTBdhERwCIL/s3QqWBV7q1TH1fio8AirxJ
	VmqBZy
X-Google-Smtp-Source: AGHT+IEQ1ZsYVNBE93DZUEPG/rQ7d2yqvLX9HlWfcZW+WqvKNYnQCFAAVLHo0lDqcwHcKmcLq8ik3w==
X-Received: by 2002:a05:6e02:b:b0:3e2:aafc:a7f with SMTP id e9e14a558f8ab-3e416122d83mr233626785ab.7.1754345233834;
        Mon, 04 Aug 2025 15:07:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-50a90a3c82fsm1484234173.82.2025.08.04.15.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 15:07:13 -0700 (PDT)
Date: Mon, 4 Aug 2025 18:07:12 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/9] commit-graph: store the hash algorithm instead of
 its length
Message-ID: <aJEvEB0DXcnmwme8@nand.local>
References: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
 <20250804-b4-pks-commit-graph-wo-the-repository-v1-6-850d626eb2e8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250804-b4-pks-commit-graph-wo-the-repository-v1-6-850d626eb2e8@pks.im>

On Mon, Aug 04, 2025 at 10:17:22AM +0200, Patrick Steinhardt wrote:
> The commit-graph stores the length of the hash algorithm it uses. In
> subsequent commits we'll need to pass the whole hash algorithm around
> though, which we currently don't have access to.
>
> Refactor the code so that we store the hash algorithm instead of only
> its size.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  commit-graph.c | 36 ++++++++++++++++++------------------
>  commit-graph.h |  2 +-
>  2 files changed, 19 insertions(+), 19 deletions(-)

Also makes sense. I briefly wondered about hash version mismatches, but
parse_commit_graph() already covers us here by comparing the
hash_version field written in the commit-graph's header against
oid_version(the_hash_algo).

Thanks,
Taylor

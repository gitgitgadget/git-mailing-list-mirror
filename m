Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D7E380
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 00:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742342618; cv=none; b=Jh4aSI4K4WdQUzo9PmcNEhjR1Id44LudEfX2k34POacvYtdsb0kOX+S6FbDe9lMwijuhzMdnu/GPZl1Q0mLNi7ArTLd1/LcttbdHRtY1uii9m+BwDGzp+6cDR4xL8LZ5wt9Q1s8jPtA7LlNgEbKSpyMWkI6iRQv0M15VBsP8BoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742342618; c=relaxed/simple;
	bh=t+qp1+xrTyy9Ak18lpDBDN3SAMo2Kij8ciACsUaIqyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXZidMJEtfAQ0OH3G0PKndsvIGJZ+DGMl/E5orpg5TPneqyR8rJRabnuBFJzmRE0LOhbzZcYVm9OVekxq527mM639MlLnYFSBRmYkxf6oVwV99pFid87Tmc9Tn+oQcm/2hi30c58sHK+ZsamcWiMq3SVa+UYQ3fVQtWrIHC2SXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=rEC6h8rO; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="rEC6h8rO"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c24ae82de4so703171985a.1
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 17:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742342616; x=1742947416; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FpRSUzYG/Wqw/83I7gX4WzlH+aQuAoflrMNDsTAbWYg=;
        b=rEC6h8rOiWFhMfeN4jnqQzD6FYkyLXd27uOhs6m5MZTbHHzXNTqu5w/Zy1PhVKPLqb
         PdWDoCdekPulzdad+JGtDknVc40aFsaSJlqbU1N5L53CqT/hYsQ95rXpy7sSoy3aWJM2
         HB7PTKWLySSHR+P1tMUD189TEldeX+S8dJ0RR8YKldeAiQYMMehKdGvgZGGulNXpyluE
         LiM9k7D/ava+8W0ToIuZXDgBcNvefO1x3Pll3vui/vgASIGqF6o2pVJJxw/6RsQItNvJ
         Bk4Yaq6e+ZsPie1LkbCmB/DySbhebz5UnnhriRm8lVSe2Mw7HE/gdU6M5Tb2F5YnvyrF
         2Wcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742342616; x=1742947416;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FpRSUzYG/Wqw/83I7gX4WzlH+aQuAoflrMNDsTAbWYg=;
        b=Dbc2+RZb5PXpEEB8kHOx5ayeVj/F1WfGQTu7RBpxNFfcaI8Y50B7InOblKj5Wx338f
         qO9vPdmv5tgYsQ1qogSLDT3R7bM4jTUOiQom0jEVXb13yKjv7CeGeEi1ooLbZR1rkVNe
         7EC178klHIARqBix0JJAXEE/T/uRx9gUjnWaSGw8AvCCHr8rQmPgJxNBXDA2gL0EQnqr
         zHyIh24vPz9cd0qILPLPVVu14J9FEHQQZMQEtUHV3q0A0AJn5I36lr0Q6chH6BR1Hf16
         bEuz9madxYb3Okhu5Q1TXeZ0IHfv0OOEgUUv/mQ3hkF94yw6uoN6wdRyYOtAHcHWs3Aq
         o3Mw==
X-Gm-Message-State: AOJu0Yy2aCAui/n9dK8lMl6l3RztLcEeXVc7bXv8Nb80bbLz9gNzboA7
	nuckqJAoey1mhoEduVLRizMEHe55mCPYYjyOUIHOZZ2cQ9+rqqoRcrV1091X9ufalhUY3e/suNP
	Zw5I=
X-Gm-Gg: ASbGnctl6hdJ/S0+WZrGD1iJZo/QQ6D2rc/hzbpHKLBq3nc549jvi7yvCuoIXmDT4jS
	Suvi5eiau4PXuTIdssG/GcTjgfLshDeqqeHdjeDukUtJQ6oe85Eu4MJcMcjPOXnlZ6eVbvO0WKP
	5rH142+XCh/idnqjA8YtS+Qytc3dSSS+uriAqS4Hd+Z5DZjO44ciTyvThoPyGYswwPsWkN8+29x
	k/CNnrGpyaMH62FMKXJ0nX3CGfOfU3P7PfQSnIj5PgSGjL+VsnK2mJZUoitNbb1CGg/eQZiNHfY
	eitH1M76Bitsbmjh9d9BMvSmS5p1lD8QGHI2G5DuIgSXeIJJ4V5APX4S5/zyMsd3xbjE5qKi56o
	o9ahozgbrYpyuBkrH
X-Google-Smtp-Source: AGHT+IE/hkqriarr4l9X4J8qYgTIB4EKRrqc6M8P7YAob3xyINpuVK8Wa67iYJM4WyLI1YZnTMlJdg==
X-Received: by 2002:a05:620a:1a9e:b0:7c5:5596:8457 with SMTP id af79cd13be357-7c5a84a5050mr87120485a.57.1742342616055;
        Tue, 18 Mar 2025 17:03:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573c9a818sm781328185a.50.2025.03.18.17.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:03:35 -0700 (PDT)
Date: Tue, 18 Mar 2025 20:03:34 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 02/13] pack-revindex: prepare for incremental MIDX
 bitmaps
Message-ID: <Z9oJ1veRTy1+UxfB@nand.local>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1741983492.git.me@ttaylorr.com>
 <f2a232e556a066c1a5083f02584ddc3637ecfc48.1741983492.git.me@ttaylorr.com>
 <CABPp-BGbw+MOq9=cQzO5sc3XkakZQhXXg3r0iKeY5-p-4QR-3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BGbw+MOq9=cQzO5sc3XkakZQhXXg3r0iKeY5-p-4QR-3g@mail.gmail.com>

On Mon, Mar 17, 2025 at 07:43:07PM -0700, Elijah Newren wrote:
> On Fri, Mar 14, 2025 at 1:18 PM Taylor Blau <me@ttaylorr.com> wrote:
> >
> > Prepare the reverse index machinery to handle object lookups in an
> > incremental MIDX bitmap. These changes are broken out across a few
> > functions:
> >
> >   - load_midx_revindex() learns to use the appropriate MIDX filename
> >     depending on whether the given 'struct multi_pack_index *' is
> >     incremental or not.
> >
> >   - pack_pos_to_midx() and midx_to_pack_pos() now both take in a global
> >     object position in the MIDX pseudo-pack order, and finds the
> >     earliest containing MIDX (similar to midx.c::midx_for_object().
>
> s/finds/find/ ?

Good eyes, fixed.

Thanks,
Taylor

Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="yiUfzJXu"
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E67D40
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 11:32:26 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-77d895c298eso66678385a.3
        for <git@vger.kernel.org>; Thu, 30 Nov 2023 11:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701372746; x=1701977546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zEpOL8M3Oss2b6PVQCut4niZIixFtKQHJWn7QpgKwPc=;
        b=yiUfzJXu4h+CiWQvV9J3z67TkRRUYklg5V1GXf7weQa8NY8oUgRzK6V9AlxIBZPQJL
         zVFaYqjjZu8eBqz1YBty02jyi8vldi13F/42+8Vm87MIK8SOKLw6DRs9x5qUO6U6sWDo
         qxge1i9k583j0jJxyfgN4iSWEVeIlVP/vRMhAKqnV7kLGEzPeIU/8ac3n3NFvKt9mzWK
         AuXMpkkDqtoMdaoxXyXHTuVHW3TrUtZZFdkwNj5/XiNZeqVH97recnTJx+lB3KEu1x85
         9V1nNkhBEGXIs/RA63Txa2WtncP+jACZGZd5zeCmUje3steABz3QMUUAoGyXsWuBYi5n
         W8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701372746; x=1701977546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEpOL8M3Oss2b6PVQCut4niZIixFtKQHJWn7QpgKwPc=;
        b=lgZsV+iBedCLbZ8g6Nll5NE3USEtuH9p6bIpZ7O1YjAPIZlRZO7S2KfBggJQG6CQPI
         5OpvMr5/xcXMDfcmhbBtshNrPyMaK0sHQqDQViicfr99svPmWnrYMe8hFPhqGtPuG93H
         DL9eg77hqs7TymZtGIPJRoxhrWz8eGJkRd4RHAQlz65+aCLXz5IuUMMiQgUVjzn8J900
         vkHVQtI7B0UjZlQX9udbE+DqdWvM3mWm/62aM2D7L7IWh/hpy58CI20ti63Yq7RREnuY
         J52acnPTuYYrv47HY4WYeqtGcyX5vDCQHpwvEpB11DMNKGI1z/x4Hd7cOubxv1Qsx7yn
         5GeA==
X-Gm-Message-State: AOJu0YyvfF0o2VbwHZEXi+38LJTeayg7khDCXr2MBhgDYAK1C7Sx028+
	YHJ+HzP4EfA1NDc1X8KuHFRBIt2z8h8PXLgQ5hI=
X-Google-Smtp-Source: AGHT+IEgseQLJ3ndKTfVgHMpkvtf9cI152qicjaOHPFlHPJfzi5hQd85NMdzidqcBFZQUurbynV5CQ==
X-Received: by 2002:a05:620a:6507:b0:76d:aa3b:ac9c with SMTP id qb7-20020a05620a650700b0076daa3bac9cmr27168837qkn.46.1701372746014;
        Thu, 30 Nov 2023 11:32:26 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id tq20-20020a05620a3d1400b0077a02b8b504sm761267qkn.52.2023.11.30.11.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 11:32:25 -0800 (PST)
Date: Thu, 30 Nov 2023 14:32:24 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/24] pack-objects: implement `--ignore-disjoint` mode
Message-ID: <ZWjjSOJHw6Q1qQ+y@nand.local>
References: <cover.1701198172.git.me@ttaylorr.com>
 <0368f7ab37669163b50b82185725935bde5bc946.1701198172.git.me@ttaylorr.com>
 <ZWhhkdnVZ9w7tDBv@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZWhhkdnVZ9w7tDBv@tanuki>

On Thu, Nov 30, 2023 at 11:18:57AM +0100, Patrick Steinhardt wrote:
> > Instead, teach `pack-objects` a special `--ignore-disjoint` which is the
> > moral equivalent of marking the set of disjoint packs as kept, and
> > ignoring their contents, even if it would have otherwise been packed. In
> > fact, this similarity extends down to the implementation, where each
> > disjoint pack is first loaded, then has its `pack_keep_in_core` bit set.
> >
> > With this in place, we can use the kept-pack cache from 20b031fede
> > (packfile: add kept-pack cache for find_kept_pack_entry(), 2021-02-22),
> > which looks up objects first in a cache containing just the set of kept
> > (in this case, disjoint) packs. Assuming that the set of disjoint packs
> > is a relatively small portion of the entire repository (which should be
> > a safe assumption to make), each object lookup will be very inexpensive.
>
> This cought me by surprise a bit. I'd have expected that in the end,
> most of the packfiles in a repository would be disjoint. Using for
> example geometric repacks, my expectation was that all of the packs that
> get written via geometric repacking would eventually become disjoint
> whereas new packs added to the repository would initially not be.

Which part are you referring to here? If you're referring to the part
where I say that the set of disjoint packs is relatively small in
proposition to the rest of the packs, I think I know where the confusion
is.

I'm not saying that the set of disjoint packs is small in comparison to
the rest of the repository by object count, but rather by count of packs
overall. You're right that packs from pushes will not be guaranteed to
be disjoint upon entering the repository, but will become disjoint when
geometrically repacked (assuming that the caller uses --ignore-disjoint
when repacking).

Thanks,
Taylor

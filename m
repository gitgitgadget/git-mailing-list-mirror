Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF031C729B
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 15:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730474303; cv=none; b=HHssFYRvlsf6ZWpvm7q4S8jKTEFmpe6P5dgJolVN/5bxiph/8ySfo+uIXmYf+1OFHzrZBAI03BZarTDpbynZ4EvdvHLneTHO6mmQGxRGy55Oy3JhhRDrJllaovHYtmzwNHrpazb8yKgSkUGh6aWpS4bipetrnHhSGvvoot1W4Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730474303; c=relaxed/simple;
	bh=udZHwex3blDcOjqLbTZTzYAJvl6haW2kqymKsy5Esic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DO9STookasmheDJIoZwpMccjx0ZNttbeZTlNsg/n2gmnHyKichcz0EuuCgAhTTM/YWdquJUNQaPKfc3LCV5VYw0vlPNvH3cWTAtGROvRx4/PFTD6QBZOYzmDjjp4tfqtTvfSwoe1ff/IgJtMrfVn9wloiEV7FHqF+mC/keSwGYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=BeMGsDcZ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="BeMGsDcZ"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e38fa1f82fso17225397b3.1
        for <git@vger.kernel.org>; Fri, 01 Nov 2024 08:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730474298; x=1731079098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mTq3zEl0x96KFtuIT4zfBr6B/hCXbSSxmzyztG4PcSM=;
        b=BeMGsDcZ6SAniTSivuppgclMPqMLzmx5iQy21/kPCAfFnoj6GEb0F7yKMoG8bLzXQk
         ydNSriPOUFBnI/3RSaZCiXi6Y6vy5e/fif7L6K1lZToYn8ikYPm3GlBzL6wfr1a5KeLO
         VT/clW/G13jDjDRjjheAPdAJPeoEvxR6EOxpp15/0IslVMMa4fpW+KI2sdn2FeiCyTsg
         uRuyD2Um8no9sCxuqUUJ7WjqBRFe2f3vO1dKZmP/9Yb/fMwua0i6ly2AXtWWXl80Yssp
         aW4x8D4zjg+GERglf8+WD63OYR1XmrzQyCCdOYhVgsqedM8osUxFF8jFjCPGStBB4UR7
         XqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730474298; x=1731079098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTq3zEl0x96KFtuIT4zfBr6B/hCXbSSxmzyztG4PcSM=;
        b=Jwu4xcqpWN7jN5ki7tXngnXnUFX/l2z9dhVaI/wm00EGRAooDApt1wp2TotiqlQMD+
         N7U2aftQlDWgi3fxHkZg7Gi9crVxnlGiZwTQBEYbIC1DcJYz+lRjwtzxevWqobh8qhnx
         7SZG/2Vzgphl3CBEl2ClIwq479/lHIk1xOlvnqOsQzxmiLaO0EUpOoS/q7ySxaxNrzH5
         ry5yk/sgp0cZatN6YSKwxwzrGiesbm5Vopy9s80PdRYDR/g8AXv2AUtQ28PK++0COeXe
         got0oGIFPXfZJXPW8KZwiH+6e4S6PTFuJ61Gm0TqsjY7t4Qmr8wT5+3WKwc7oHy1RVUt
         mwcA==
X-Gm-Message-State: AOJu0YznSLsm+flWyTdi9XMUks6ZawpdHDsDLEdxmtKISAG86xoX7T/d
	J/b167VyeKwghz0+Ie9M5o476qlNRLS70cJQaybYEkqM8KuXHHViIUHjSZ7ojbc=
X-Google-Smtp-Source: AGHT+IEak1VpPvZ4uEcT2XHKPiSpLcuJ2MwXGX1IfuTzGQJihwC0HBQLo9wX158Tg4vdYExV98lEwA==
X-Received: by 2002:a05:690c:23c2:b0:6e3:156e:a917 with SMTP id 00721157ae682-6e9d89b12b9mr251080347b3.14.1730474297716;
        Fri, 01 Nov 2024 08:18:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea55ce7324sm7060567b3.146.2024.11.01.08.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 08:18:17 -0700 (PDT)
Date: Fri, 1 Nov 2024 11:18:15 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org, steadmon@google.com, hanxin.hx@bytedance.com
Subject: Re: [PATCH v2 2/2] fetch-pack: warn if in commit graph but not obj db
Message-ID: <ZyTxNwZgeOy/+05b@nand.local>
References: <cover.1730235646.git.jonathantanmy@google.com>
 <cover.1730409376.git.jonathantanmy@google.com>
 <631b9a86778f15b7086e5f17fe850ffa151dd341.1730409376.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <631b9a86778f15b7086e5f17fe850ffa151dd341.1730409376.git.jonathantanmy@google.com>

On Thu, Oct 31, 2024 at 02:19:01PM -0700, Jonathan Tan wrote:
> diff --git a/t/t5330-no-lazy-fetch-with-commit-graph.sh b/t/t5330-no-lazy-fetch-with-commit-graph.sh
> index 5eb28f0512..feccd58324 100755
> --- a/t/t5330-no-lazy-fetch-with-commit-graph.sh
> +++ b/t/t5330-no-lazy-fetch-with-commit-graph.sh
> @@ -39,7 +39,7 @@ test_expect_success 'fetch any commit from promisor with the usage of the commit
>  	test_commit -C with-commit any-commit &&
>  	anycommit=$(git -C with-commit rev-parse HEAD) &&
>  	GIT_TRACE="$(pwd)/trace.txt" \
> -		git -C with-commit-graph fetch origin $anycommit 2>err &&
> +		test_must_fail git -C with-commit-graph fetch origin $anycommit 2>err &&

It appears that this line breaks CI:

    https://github.com/ttaylorr/git/actions/runs/11631453312/job/32392591229

because you're using a one-shot environment variable assignment before
calling a shell function.

This should instead be:

    test_must_fail env GIT_TRACE="$(pwd)/trace.txt" \
      git -C with-commit-graph fetch origin $anycommit 2>err &&

Thanks,
Taylor

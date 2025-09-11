Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC5F3112D9
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 15:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757604885; cv=none; b=R9dGvuM4dYl5j3S9U23LBFPgMCsM8ABTgKIoyzbxd8hnC/HWgEj7xz6AFHn2YMy6qVxVKIJ+OlrC4lqAru/XbWMVWz9agHxqT+GOBogAgWexW1DjeN7Kds7ojMHQMq6dr2V0ne0P3gG11YWPna9mHtdHr9e/X2t3sqXXL3Kp3s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757604885; c=relaxed/simple;
	bh=IOaGA5gTv+yb+AzvI3vvFjpOvv2g9t4ZxpV4KSjG/Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icpkgcbWTzbavWs32yTg8BJ6/qDZn3vfh0NPwrZQMHQd2Qj4Goqnqqa3yAK4vzZWgJyxE15YWEzS1tuKM/pbRhy6evGL+zRJerIH5CPZOWq0t17NcdAeJ2M3UwAM0l/DKNnVQZcZpH+TB/lgJByIK8+jKo4j/LOQoFPcPG+Rbn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUXpDn4u; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUXpDn4u"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-74595f3852cso633105a34.0
        for <git@vger.kernel.org>; Thu, 11 Sep 2025 08:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757604883; x=1758209683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h4h6cX6+GACjJNdiD/slW78FvGGNLw51ruXom41cjtE=;
        b=HUXpDn4us08Hhii50wP6sqH9eKirQQFR9GpKXtrLJjacG/hBcI9uSxiN4BVRtDcqki
         MGh0W6Hx7JI5ChzC8WffatZWMFe1fT5NjP5MZs01PAav9GPxjN44A1x7yQXWBccfBaHL
         2oA+fWSZE6orkki5HFXZQj+WrTcfINIPd/gTWizFppx1cMbsv8LmeMJv8osucAVX4M8J
         J74uX0ilfoOARpkaY68aIxbKL9tXdOLBOBzr8f6I2yAYVqy+B66zy53YC5Ho7m9a53/M
         coVSmIvYaVCNqJlUXDOC0+4W0v2rhMZgHI2/zaOIvpAfuXwVSbQ46+tIe+9PUGmmAFjF
         SmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757604883; x=1758209683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4h6cX6+GACjJNdiD/slW78FvGGNLw51ruXom41cjtE=;
        b=w/TCAJowbsRlfMovv16nuBHd3fZbwJ8/FMA+CeMnuM8SS1y2T6U7AtA88hB7QmrFY2
         bJj7gsgHg44Cz7qwuJSaiL1VF9GoBhhrym03cLQI9DnKjWf2My0J7uUU9CQOASDuZS7p
         v0OWUOt0wYWQndoVHAsGxy1IVA5GDaa5+nPxamProKw8qq/ttEv8rAzuau9k6hHy8LNU
         PkB06zoDW4v3zUUQXXA3JM+td1lm++JzZ9Hnyvnhs+xMj+QT6pBheXQDm9nOdsyMZ+0y
         hk24mJJCHaxUXswwgFhihRBo3AW29hU0fZMdlC9lGuWkgeYS8wdMlv9wQ7KeWbwHQipI
         xf7g==
X-Gm-Message-State: AOJu0YzRH8KdyWqJk5hWq3NvCh8zq/noNCi3FZp+lNK0obv63RvmeceC
	X/J8lvvRzFDvke3QodCOp6KtJK/N0ak9oku42OWpWAhVrpE7q3CPSoraod6wcg==
X-Gm-Gg: ASbGncuBnDkpRbWJEHLyAPswOaDngReMOPT3dO7T805jgWoiYxuTCLgTurhKaWZGxAv
	b+edpk5IIGPiOSxZNDr7PTNi5SrfsvW2iyNOh7Jr9i5xAntDtpfnfGh3huVLZSIaNFRAC2jrdWT
	dnCt0jvE2qMEq1/SeZZnt8iBtepHxwtstIV5zYfUAhYJIpqEnksoyebhy31xrv/K0aGNqSMdjCR
	q1hVIPlQSQjekdgf06y94sJkAEyQ6HSEbByVkD8+qmx+cGMwmUWT+OD+72hLzvel+OrU7P/OkqK
	w9C01PK4E83DlP4UNZuySxy9a3c47ZxTQ1d4EMOH2HJSfSnklrlf6Ewdann0yF5LrmFaTID5Akx
	b5csORaeooqNEVm7mhgC8J5TvV40=
X-Google-Smtp-Source: AGHT+IHqmcvR3zFCNSWHLK+Br1b5Bj7Ijz4DtntzrFsuV9kDnYGIxyVYiGt6BMZGU0Xcd3YGTsPkJw==
X-Received: by 2002:a05:6808:10cc:b0:439:af0a:dc8d with SMTP id 5614622812f47-43b29ca0eb9mr8004678b6e.38.1757604883267;
        Thu, 11 Sep 2025 08:34:43 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-43b82661c0dsm288958b6e.0.2025.09.11.08.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 08:34:42 -0700 (PDT)
Date: Thu, 11 Sep 2025 10:34:42 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/6] builtin/update-index: end ODB transaction when
 --verbose is specified
Message-ID: <3cmqsfz5j2h36mw7yzwbrgfgchaettcnidvkiboqqktkm3dd5k@h6rmgjnqdmq2>
References: <20250909191134.555689-1-jltobler@gmail.com>
 <20250909191134.555689-3-jltobler@gmail.com>
 <aMJu7vPKfnxt9UiC@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMJu7vPKfnxt9UiC@pks.im>

On 25/09/11 08:40AM, Patrick Steinhardt wrote:
> On Tue, Sep 09, 2025 at 02:11:30PM -0500, Justin Tobler wrote:
> > With 23a3a303 (update-index: use the bulk-checkin infrastructure,
> > 2022-04-04), object database transactions were added to
> > git-update-index(1) to facilitate writing objects in bulk. With
> > transactions, newly added objects are instead written to a temporary
> > object directory and migrated to the primary object database upon
> > transaction commit.
> > 
> > When the --verbose option is specified, each individual object is
> > explicitly flushed via flush_odb_transaction() prior to reporting the
> > update. Flushing the object database transaction migrates pending
> > objects to the primary object database without marking the transaction
> > as complete. This is done so objects are immediately visible to
> > git-update-index(1) callers using the --verbose option and that rely on
> > parsing verbose output to know when objects are written.
> > 
> > As soon as verbose output is requested in git-update-index(1), all
> > subsequent object writes are flushed prior to being reported and thus no
> > longer benefit from being transactional. Furthermore, the mechanism to
> > flush a transaction without committing is rather awkward. Drop the call
> > to flush_odb_transaction() in favor of ending the transaction early when
> > the --verbose flag is encountered.
> 
> Okay, this interface feels somewhat weird indeed. If we now end the
> transaction early, does the transaction still serve any purpose at all?
> Like, do we use it to batch steps _before_ we start reporting stuff?

We only start reporting updates when the --verbose option is first
encountered. Options are not all processed upfront. This means in the
follow example:

  $ git update-index --add foo --add bar --verbose --stdin

both "foo" and "bar" are silently added via a transaction. After the
--verbose option, subsequent updates are reported. At this point there
is no reason for the transaction to continue as all subsequent object
writes must be fully written before being reported. Thus the transaction
is ended early.

> If the answer is "no", we might be able to just not create a transaction
> altogether. 

We still use a transaction in the normal case when objects are written
without --verbose enabled. This matches the existing behavior.

> If the answer is "yes" we should probably point out in the
> commit message that the transaction still has a purpose.

Yes, transactions still have a purpose, but only for object written
before the --verbose option is first encountered. I'll try to clarify
this in the commit message.

-Justin

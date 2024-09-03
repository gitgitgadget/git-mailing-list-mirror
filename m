Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BC213DB92
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 14:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725374585; cv=none; b=VYUwUbi0Ke76vd410/vaObTuHvjHUgPAQbCf/EIdgE/VcQ+lbaKiMPocYkifGnsncIy46hUHjnHDczEAjqaxeHAtKVuWYZjJFKP/gZ/u/VzAJfos1LJA2+gDhmC1HxIWSED/jOI/mESkpQjvFs9uW1I1/ffBu0ldZorEtjKzX7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725374585; c=relaxed/simple;
	bh=xm+MUduMcGK6/7f+yZ1YPL/CQVn02GDwmOJB23CEeW8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YTpgpsa9oK78Lw+fVj6V7j37svvfmiz7oQnQwhFuQDFc+uUPrsRuXmU6W6RwI3EC7ByVpDDxBGmtBuU7Zl+dM7QVJM5zH5sMMKCg4U2DpaLuOG48rHDECasMNtAaLcqPDR78tDkL3ObGf86+EVp0FjXjXWYjkUnDM/PCKzZsn4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=JOAeiuzX; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="JOAeiuzX"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e1ce8a675f7so1745360276.3
        for <git@vger.kernel.org>; Tue, 03 Sep 2024 07:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1725374582; x=1725979382; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xm+MUduMcGK6/7f+yZ1YPL/CQVn02GDwmOJB23CEeW8=;
        b=JOAeiuzXOXnw07KAT1BjzxCr1HcWhhJeOwzg46KVQlptWuqB5VuXnAGInJ96sKp43l
         aQwqQtPZs0pcrrp2OecVE+T8siSuy+ZriUZriL3nOj2hDMdpdW+Gquy4lXtbB7vUoM+7
         axd0+jXtiE45odIqO9UitQCOIdQKINrGUqnWkJ/I+Jz7ehXiRU6vlQ65tlNN62opmJu0
         7HxsPv7ff+6H8fKraNeBiIERHFqBJx0gXwFH/+9evwoHtHSl4oUszkCX8Xn+kXgLRqok
         znp+zyncMJIGmL6WA1fsuVH6e2r5uZrxEGcqJh1DldBEH0HSP1hhCHotDqGSJ0DsV5v4
         ABoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725374582; x=1725979382;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xm+MUduMcGK6/7f+yZ1YPL/CQVn02GDwmOJB23CEeW8=;
        b=pWJVbYtXCQzBDea8QuYNGQZFaCnU3Jw730aHUxfnli7Qwi4P5/w5GDzmQE/XCNjMZk
         dwEFPfTso5lFzGLUX8jy+kyUTgsRLykYQKb3564oJcOBDvYfAFWac1PEnAOgR4ux20zj
         q3ep5Xd2xfb/Doeesce/rD5B7m4f0q4gTqLJI6g0nsqcICbfHm+MQzXLNhqTY90iyFhn
         Oh+SaW0Qkgu/AXWmWJOCtMs4FHZ5jthavon78Kkn1QNUiYzjyUMF0AZDR3OFtvhDQ1gr
         2Sl+5obniU8OMe4FD0Kc++KUUjMM68EC7UJiBzwyLbK3gLQyChDT0G6q9gddVNlgys+h
         XX9w==
X-Gm-Message-State: AOJu0YzoNl//z8Nd8CeNb1L+QOD0y7T2wl4XirB6NFhHNX8i5iHj6ZtS
	85Hlu3H8ebspk4bpzxDVn/axFkOlbhOsKyyjJWPkVXIe45VIlmjVM7nElCRRGaBq3LlZdccfgU2
	0980=
X-Google-Smtp-Source: AGHT+IFdxVOXnYRfDRmSxankwdVabIm4CExUD+yXwNLjjg9OJTeHneFZ9ge57tfxnoR8ujtDA8E72w==
X-Received: by 2002:a05:6902:c03:b0:e0b:c297:8a1c with SMTP id 3f1490d57ef6-e1a79fdc00emr17462132276.15.1725374582259;
        Tue, 03 Sep 2024 07:43:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1a94966e24sm1412260276.46.2024.09.03.07.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 07:43:01 -0700 (PDT)
Date: Tue, 3 Sep 2024 10:43:00 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Pedro Rijo <pedrorijo91@gmail.com>
Subject: [ANNOUNCE] git-scm.com running on heroku-24
Message-ID: <ZtcgdJmVunVwwCmk@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

I upgraded the git-scm.com Heroku app to use the heroku-24 stack, which
moves us off of the deprecated heroku-20 stack.

The heroku-20 stack was deprecated [1] a few months ago back in June of
this year, and builds will begin failing periodically starting in
February, 2025. I've been getting periodic emails from Heroku about
this, and finally found some time to perform the upgrade.

This should be a no-op for anyone using or visiting the site. I deployed
a review app to test the changes beforehand, and everything seems to be
working after creating and seeding the database, etc.

But if you notice any issues, please do not hesitate to open an issue on
the git/git-scm.com repository [2], or reply to this thread.

There is some work ongoing to move the site away from Heroku [3], but
this change should keep the site running smoothly in the meantime until
that work is complete.

Thanks,
Taylor

[1]: https://help.heroku.com/NPN275RK/heroku-20-end-of-life-faq
[2]: https://github.com/git/git-scm.com
[3]: https://github.com/git/git-scm.com/pull/1804

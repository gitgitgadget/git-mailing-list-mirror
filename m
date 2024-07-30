Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D4618800D
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356045; cv=none; b=QWlRKBZUsulWiKPgc/8Z2x4ED573WqtcoI+I5NCzcYzwGic8F2QiQ6K0DZoLZSoJZj+L1HUNE4X5fSW2CzcCWUl4qXlQaluJNr/eWNITSK7HZ+OwFTb/Ry/SVgu+Xf3mprEDsft9gU2QDv08D1ZF/AMr69cdZOpK4/oJea8Z0FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356045; c=relaxed/simple;
	bh=D/1yMzRLDhZpkql2WGNOY9v+T2brQRi5wN8eJzCZL00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQX9yu2lv7F72i0JZPEEKOS/oXty/7w6QA9x+hytHH8hif8Isz5Hp+gOZ5esnSN/4mdTxZomcEggcOH9o/5qexDVPu9mjPu+zoo8w1/MDuRRtRQJYwbI3bHiNlPt7NMxI2zEs2qzQnzc72uHEj5yCdy4nUEkTcuINgtUE3I9OIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1MaOX/+; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1MaOX/+"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70d25b5b6b0so3341446b3a.2
        for <git@vger.kernel.org>; Tue, 30 Jul 2024 09:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722356043; x=1722960843; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9GdHhtfvdvlfgf29QwasTBou2uTJ4LyIivXLI0lePkg=;
        b=i1MaOX/+rOSoO5Eq8x80LFHYcvtRM13DLsWirBcHXmcVoSpiivQsuRSBo/WtPOaYnQ
         aLZn77+OePBnb9RN5lf50elRLVUqDLnkxvyCzo04uk4kdon9/WHbf/TQeTOGTeY0j4/m
         03mHg2E2EDQ7oCC0wDp27vA3g4BPmGxrXFfE/XPjJaZWTEHowtEf+NZXofmtyYvnnbFz
         zAlzjrSgh4wT44RllSRPj/hlUi08OmTO2ielzHWrIW9jchhsgssHXesDlGv9CkqFINCI
         xtmBUSht8QFxx5bnAYpx9mZaRJvTo9E01VpGlIQBaJs6l6OotvLBS2u+8b7J38oqIck9
         hwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722356043; x=1722960843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9GdHhtfvdvlfgf29QwasTBou2uTJ4LyIivXLI0lePkg=;
        b=wpis1nO8BUMvmmi4Y8veEbkbPl0bGPpZpy+X220mtDDO7L8FrE2mYaVHrwX9uJP+9r
         8AOemRDfbkOJmFwRQ+cXid7u2tVfzz/wqAiiY78zvUpkSsphS1MC9cjIDVOTcdUKIyGO
         J/CvfzaD9k8ME+r+JbUuFPxJYHOCHtFqOirufcJxHYzLAk9U9qBUd7lRzIv1nYy2D/e9
         7pqM4w3nkzk5U0oiNJ6eswT3QBeUrrquSh2JC81IgKmdMV0Zh6XP7fYpcb577LM5oBt9
         1h9MFDnt+jpMBh8Vt2i/WA9G6gkB/nwojaj5AObc5xiWGN06zSU8qBPeqIJLoiFQNkHP
         CtAQ==
X-Gm-Message-State: AOJu0YweZ23yh7F3tezpdH9ntl/rUYwm4hoo5ZxBWhEoBXA+a0m1B527
	FJatjr8NnyhxTBvIGpwGxVtVP8M0aNvWtL1/TTm+eeT69fzyHNnG
X-Google-Smtp-Source: AGHT+IHwuzczgBodfP94/kOZQbr+ABIcwDDJOBLdlxvySmjsmVUW6ylbxjjGfsrinRQINwhIsSFPPg==
X-Received: by 2002:a05:6a21:7891:b0:1c4:6a86:e40d with SMTP id adf61e73a8af0-1c4a13a33edmr11482313637.38.1722356043297;
        Tue, 30 Jul 2024 09:14:03 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead6e122esm8894087b3a.14.2024.07.30.09.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 09:14:02 -0700 (PDT)
Date: Wed, 31 Jul 2024 00:14:24 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v13 09/10] fsck: add ref name check for files
 backend
Message-ID: <ZqkRYLlqtE9tgyDF@ArchLinux>
References: <ZqeXrPROpEg_pRS2@ArchLinux>
 <ZqeY0eHNZjKhNvIH@ArchLinux>
 <Zqik9EOKd43WxGXp@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zqik9EOKd43WxGXp@tanuki>

> > diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
> > new file mode 100755
> > index 0000000000..b2db58d2c6
> > --- /dev/null
> > +++ b/t/t0602-reffiles-fsck.sh
> > @@ -0,0 +1,101 @@
> > +#!/bin/sh
> > +
> > +test_description='Test reffiles backend consistency check'
> > +
> > +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> > +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> > +GIT_TEST_DEFAULT_REF_FORMAT=files
> > +export GIT_TEST_DEFAULT_REF_FORMAT
> > +
> > +. ./test-lib.sh
> 
> Is this test suite intentionally not marked with
> `TEST_PASSES_SANITIZE_LEAK=true`?
> 

No, I don't know this. I will add `TEST_PASSES_SANITIZE_LEAK=true` and
export this environment variable.

> > +
> > +test_expect_success 'ref name should be checked' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	branch_dir_prefix=.git/refs/heads &&
> > +	tag_dir_prefix=.git/refs/tags &&
> > +	(
> > +		cd repo &&
> > +		git commit --allow-empty -m initial &&
> > +		git checkout -b branch-1 &&
> > +		git tag tag-1 &&
> > +		git commit --allow-empty -m second &&
> > +		git checkout -b branch-2 &&
> > +		git tag tag-2 &&
> > +		git tag multi_hierarchy/tag-2
> > +	) &&
> 
> I don't quite get why you create several subshells only to cd into
> `repo` in each of them. Isn't a single subshell sufficient for all of
> those tests? If you want to delimit blocks, then you can simply add an
> empty newline between them.
> 

I just want to delimit, I will use newline in the next version.

> > +	(
> > +		cd repo &&
> > +		cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
> > +		test_must_fail git fsck 2>err &&
> > +		cat >expect <<-EOF &&
> > +		error: refs/heads/.branch-1: badRefName: invalid refname format
> > +		EOF
> > +		rm $branch_dir_prefix/.branch-1 &&
> > +		test_cmp expect err
> > +	) &&
> > +	(
> > +		cd repo &&
> > +		cp $tag_dir_prefix/tag-1 $tag_dir_prefix/tag-1.lock &&
> > +		test_must_fail git fsck 2>err &&
> > +		cat >expect <<-EOF &&
> > +		error: refs/tags/tag-1.lock: badRefName: invalid refname format
> > +		EOF
> > +		rm $tag_dir_prefix/tag-1.lock &&
> > +		test_cmp expect err
> > +	) &&
> 
> The other cases all make sense, but I don't think that a file ending
> with ".lock" should be marked as having a "badRefName". It is expected
> that concurrent writers may have such lock files.
> 
> What could make sense is to eventually mark stale lock files older than
> X amount of time as errors or warnings. But I'd think that this is
> outside of the scope of this patch series.
> 

If so, let us just ignore ".lock" situation at the moment.

> Patrick

Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EC21946BB
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687192; cv=none; b=u+CKWGjtKlqzgDxf3353EhIXamGZAY4+2izYWCPH50f2a6PYx6LCI7UTmX4CqLiPxFDLfg0/kXPbouIn559bLYy/C3mjC/xk485TFt8i+lTknu3WWtsOX6DluNybzG7ioeGo7GeocSazbAcv/xRVTnfxfTszThK7NQxGWu8sPWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687192; c=relaxed/simple;
	bh=rVyuvv4yxchpuskh6BDO2drmQ6C5sPE6l2nSUhBik+Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aLKk0UjQGTyik0Wbzff29KQ1ZUKok3ZVeHFPYnWmeyJUgjTFqnvmGNOn6U8YHaZc8e9qc3NcCFT9OH9x5FslyTwmfYX3mMPRvZU4+nOdj64GM5t8IY/PEjCgkOltnlkQrglUVSEus4bqEh2tgp8bPwHZdha/akBWSfY/xE/Wcjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WoDKpI0P; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WoDKpI0P"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 81329270DD;
	Mon, 26 Aug 2024 11:46:30 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=rVyuvv4yxchpuskh6BDO2drmQ6C5sPE6l2nSUh
	Bik+Q=; b=WoDKpI0PtNQNlANF80L5bhSwjZvAV4dR4Wab8dmLsK37wG91QDeikw
	nnXutlV/UCJ5ZTahU3t7bb72Yji+/AsElTX4/OcyIEYJkv8BnHBGEWbgHFDj/NRV
	/g9Ht9NnG5c2opJ6m8OfPmaqAlgI+AOH4CW6Za82JLtfYP8Q4MQ3U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7958B270DC;
	Mon, 26 Aug 2024 11:46:30 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 057BD270DB;
	Mon, 26 Aug 2024 11:46:26 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,  git@vger.kernel.org,
  Christian Couder <chriscool@tuxfamily.org>,  Kaartic Sivaraam
 <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH] unit-tests: add tests for oidset.h
In-Reply-To: <CAP8UFD2yTMNmx0n1jhOu7dz_4XeOyTy1iLmRWYmuf9QJf75hsQ@mail.gmail.com>
	(Christian Couder's message of "Mon, 26 Aug 2024 11:31:22 +0200")
References: <20240824172028.39419-1-shyamthakkar001@gmail.com>
	<CAP8UFD2yTMNmx0n1jhOu7dz_4XeOyTy1iLmRWYmuf9QJf75hsQ@mail.gmail.com>
Date: Mon, 26 Aug 2024 08:46:25 -0700
Message-ID: <xmqqttf7mgmm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5AD31D3E-63C2-11EF-B44B-BF444491E1BC-77302942!pb-smtp20.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

>> Add tests for oidset.h library, which were not previously present using
>> the unit testing framework.
>
> It might be interesting to also say if there are tests for oidset in
> the end-to-end tests, not just in the unit test framework. Also I
> think oidset.h is more an API than a library.

Thanks for pointing these out; 100% agreed.

>> This imposes a new restriction of running the test from the 't/' and
>> 't/unit-tests/bin'

I thought we just got rid of such an restriction during the review
of another unit-test topic?  If this is a recurring theme, perhaps
we should teach t/unit-test/test-lib.c a few ways to specify where
the auxiliary files for unit-tests are (e.g. "-d <datadir>" command
line option, or $GIT_UNIT_TEST_DATA_DIR environment variable).

Even though the end-to-end tests do not allow you to start them from
an arbitrary directory (it shouldn't be a rocket science to teach
them to do so, though), they can run in an arbitrary place with the
"--root" option without hindering its ability to read its auxiliary
data files, because they can learn where the t/ directory is by
looking at $TEST_DIRECTORY and a few other variables.  A similar
idea should be applicable to the unit-tests framework.

Thanks.


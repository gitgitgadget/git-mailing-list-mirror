Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B1713BACC
	for <git@vger.kernel.org>; Thu, 20 Feb 2025 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065533; cv=none; b=ufCkEkKbrcW0UAYOVKkxGJjvn9XLwdUvqBS/a3zLq7yi/MNKMae5i6hoWRWmQqi7TP8ig0ISRNcrQ3GSzyC2nZHtVvkfwtGxDPlHhjk5S7ZoW5uXdZ2OChhs/0szlvF0+VUq3qlOd6pchd5GohbtdABrP7usGCdGFkLn8FONigk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065533; c=relaxed/simple;
	bh=039dvFNz+KS+uY/vc172KbwmLIr2GIqj4eQCAlHld4w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FccrrM75zjxn86n9QndCKq6eM4z+7yVkLV3mRtFgC683m6vJ+WcKl1JlUbF2bdQT7/A7BwuKG3fcMm2tthSWhWIsGr32SrUR02RFX+VENAiUYiGEiTSOESA5ZwAXw3bi2/yRbzb4YdseEChRZQ+3Ha67FHkuUq/iCmZPo/JgPes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e006q50w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zhtIQBpl; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e006q50w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zhtIQBpl"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C8E89114022B;
	Thu, 20 Feb 2025 10:32:10 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 20 Feb 2025 10:32:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1740065530; x=1740151930; bh=ac3YyLRhRF
	yBRpeqPAgxzlz3lDBrPGnm3wZ6pWYyaHs=; b=e006q50wlGUykrZIO9Z7ZiK3AE
	bwJ8YROkq9qh3lmMlVbwcue89TJcfY5IZvqbM5tyk9rGP0YLFsDL2fGf1aVAUsSb
	14RQs6Dcqq1iBUYDtCTmn83SDUqxtRzyZvC7mhP6yXx6tisrAQl8xhPzZ8ZdR+Qz
	BHFTb6J9LEwSY9AIqqkZRvft1ffu4CW/6cpfgtBgLLOODP0bcJOAG8jC5FIvAFtw
	ohJWZhOY6g/e7Rk9p+WxTGIieeRPPlh/uMVHyzc52ejS3LcEMa2rqVk4CmEM8fAM
	SmVdXvkb+8i4xgTM5RXwsx7+YgQvNcKxvXa7dBT944EtrHllJ4y/ggU1fSnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1740065530; x=1740151930; bh=ac3YyLRhRFyBRpeqPAgxzlz3lDBrPGnm3wZ
	6pWYyaHs=; b=zhtIQBplL8ETa5/Kdvo8eMiWZDiArpnFlAxY79GGOOrnojHhogk
	clPJlxE8KImNzGSiAK0XpGsPPDRmJSk7QwjeoOpMYtb1eJDeLVenFGtY8jMNnVHL
	9O1Tj1o6UaCfpyB/7LGkmbsM8+vnOORycFA8tyO5SG8+EWVD5DpAjwvY0ngjbew1
	yT4OF+LYNCIy6D+oA7rtubyTCASxm7kYmk3A7KuwUODgnRsRtXyrJss3Sqe8yxL0
	17LCG3J7vNWCHwLjoboRnBCRIFGNq08gQzByXt+yvXI9PHn/beWzKkHtZyFR/H8l
	iTvtkoqb8WShMiTaX4LApIXT2nn5hFhKmqg==
X-ME-Sender: <xms:-kq3Zw-fMtumgbZcyN_DonRSeGJttWMejyxeoNOs8BBcaGxkuLnXGA>
    <xme:-kq3Z4tPP7tKvRf4YK0HxJw42EncIcORYhF-Ine__sOx4e5ZriRRxKeLaWGo65dQM
    jpxpFkdZ-QCI91DIg>
X-ME-Received: <xmr:-kq3Z2AY8HBJMeUxy-9t5qp49qfpIHFbR0P6G5ifEkYYQVjYZVzkeUncDC0ejQ_S1nyZiJaMiRKl2gnc8w9EQY09Ml-ha58JpFHnhwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeijeegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehushhmrghnrghkih
    hnhigvmhhivddtvdesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghn
    rdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgt
    phhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtoh
    epjhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:-kq3ZwcNhMn0LXPtl4vp8uzql31Ard5rQnAD8hCbAS8Pwr8utD-Gdw>
    <xmx:-kq3Z1OapcE01uLP7Ilbo2qXB4CxL-ZBnR8r6QN06ndXegO2JCubIQ>
    <xmx:-kq3Z6njk_vPHfLBXH4qxFYdfanLHQTvhznH-3nBYf4vD7nsUUaPbA>
    <xmx:-kq3Z3tW69yvj41QV15e3rR4AP9koXhJAfk0mk1BZQuBr2RjfrgDyQ>
    <xmx:-kq3Z4p94tYXgI8lC2DiuheBso9ev5TfNIvHS-41tdi1h3E3u0AjP8XL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Feb 2025 10:32:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,  me@ttaylorr.com,
  chriscool@tuxfamily.org,  johncai86@gmail.com,  ps@pks.im,
  shejialuo@gmail.com
Subject: Re: [PATCH v2 01/12] builtin/verify-tag: refactor `cmd_verify_tag()`
In-Reply-To: <20250219203349.787173-2-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Thu, 20 Feb 2025 02:02:49 +0530")
References: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
	<20250219203349.787173-1-usmanakinyemi202@gmail.com>
	<20250219203349.787173-2-usmanakinyemi202@gmail.com>
Date: Thu, 20 Feb 2025 07:32:08 -0800
Message-ID: <xmqqa5ageio7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> Move `git_config()` call after `usage_with_options()` to avoid NULL `repo`
> check.

Two things and a half.

 - This move of a single call is not something I see usually called
   "refactor".

 - The new call to git_config() should be chosen a bit more
   carefully to be future-proof.  It is harder to see with the
   reduced context, but verbose and format.format has already been
   referenced before the new place where you read the configuration
   file, which would mean that you are making it impossible for
   future developers to add configuration variables to give default
   values to these two settings.

The same comment applies to potential new configuration variables
that may control how parse_options() would work.  With this line of
conversion, we are closing the door for such configuration variables
(e.g., OPTION_FILENAME may want to understand "~/path" and if we had
user.homedirectory configuration variable, the value of the variable
should affect what file the string "~/path" given to the option
refers to).

> When "-h" is passed to builtins using the RUN_SETUP macro, `repo`
> passed by `run_builtin()` will be NULL. If we use the `repo`
> instead of the global `the_repository` variable.  We will have to
> switch from `git_config()` to `repo_config()` which takes in
> `repo`.

I do not quite agree with this line of reasoning behind "will have
to switch".  You need to realize that this is cmd_verify_tag() that
is designed to be ONLY called as the top-level command
implementation and not called from random places as a library
function.  It is perfectly fine for it to work with the_repository
with git_config().

The helper functions that this functions call may be different
matter, though.

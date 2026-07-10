Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DF61F91E3
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 06:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783664095; cv=none; b=iH1eMW+eWF4xgtd5+xBnP1M8OKnmzm++5dmOGO7DcGqLHM4kxg57ts235RXrTEAjmYrfYAXA5gAnenb+7T4Vn+E6TCamcT/Yhp0nC87q+PpvZHrPn33WkUy0r77vbObMpE6H44p8nDA/5+vTXBTOpC5nHVfd+JAjjcPwRmCL0i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783664095; c=relaxed/simple;
	bh=5FME86CcQQL2VCFV4b8vWHnPR7tYayhaPOyyGziwTJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7sO2h2GlBrol2Srknb7eMU9aUSXhcYfypf2WWD/FO3zoTKtHgYhtVUOnXihziHQmgWJvmTdeVh4QhANySZGmpUV8RmWrXbsZi/+G/HZHcacM0Psvqrsx2Siii5lOqa4loPstXi8ivwdS0OA3zS8XB4ctXfUMSbtDLnJ+UYtXzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m7B2nA7J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qjENvxfM; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m7B2nA7J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qjENvxfM"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id EDF02EC01D1;
	Fri, 10 Jul 2026 02:14:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 10 Jul 2026 02:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783664092; x=1783750492; bh=lJj7m3Nw+T
	Vzmde1uy22YR0Mi852eSgF4FbVWHhDsno=; b=m7B2nA7JiwaNo4arlpM33S5rn9
	DvAaANyI/ad4OfTd6AXsfhRiwdFqHuXDFqjckkw7Temt9ELRLIXXqWWtDJ0gYQm5
	zn6HKDiJpem6Rzn+a3klMYXHJfEvf4C4voeXN+caEnIDlnkrleBBm3YFvPnyJl2S
	soiwSnyNhzPAUYgg30LseWv7qv4di6ghti8krDYLr/buUfcx4P6d8nhguy4eP85B
	w8YkN8ihWXJyu6wvYc6QTzWyip9ydexy4R3BHvsGp6edaZTMkkOdebR6+8zPVkSg
	0iFPik9vSnIb/MjmCCM4cLF7hwnJRfmYZt2m3LErqnpUfDp/p6u4CrsclMSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783664092; x=1783750492; bh=lJj7m3Nw+TVzmde1uy22YR0Mi852eSgF4Fb
	VWHhDsno=; b=qjENvxfMq3uXK47sVzZboVbOFmuxFwcwcOK7y0qQq/PE9htXdAn
	7p95tweEg4YArJq+ogbPHx4GMKc1ceEtwTEodkc/6EPGxE2sKXTamWl90a1WgK4F
	PdROQzmU381oEYM8yQR+7AKQeo+lzkvKXqEgli1hE+rviQzlCHxVsJiMZsaSjXjJ
	3QImmoucDZNOJbb9ZpZz08RtnmdJ2atzJ2LN3ZOCNSTVkf5df2YaBQWjHs/xOKMc
	ai4ocvMSjCz2U1aXmYjBTOlETceIyiJqRlucKtAZVqnT0t6Mp1UKhas31VhDK6pw
	lJcMzxefno+K9G309Zex1ylEcTZR52GNimA==
X-ME-Sender: <xms:3I1Qal0XJdbI8sVO6X8SKmnR8Hx6NsMi2jJUY8F0JZRAtK3x-4VhtQ>
    <xme:3I1QaiEgGInh5kFBRPwZ9Qz-Ng3Kfi5ds3v2pvaR9nC2gsbqu5DyjDu1xx2Kg6ci5
    Z0ZGIQnBrCXtXYR47BkV4XBVah074n_YLiROZVEj1jJ0z1FzMX0gQ>
X-ME-Received: <xmr:3I1QajhK2HxWjCIIEzhrc4YKQhw24xG7DRDA0Gd-PUvRikGa8XZfI_a1ceNaNloHpyJKL4SG4qDhHD-Zd6Zpawaco6uDsVQtdeh5nmL5G1FItw>
X-ME-Proxy-Cause: dmFkZTFosPH+PHKuFGZDx9uucJHmJzzKwF1Q6oyadSm4O6CY2pBSsO+9gjB22fobDbFNuS
    xeplyMwn9JL3BzLVjNZ8j2DrZ17XefzWTpN0BOlE0vE2/YCcp/tr7ymB18qpqfxUU5cYrx
    KQ/DRw+KBkMHG1Q0yA5A0+tN2inWRahkQQC8KkgqN7VGrDmCQF0tPFm3bFfUBuJijHU+Im
    iIjONmZEGQRVxjTSQdxo+XySzsJ+SinoXAcM+k6xNxCjZowDhfWD1y/NULwzpEOVh5gJ//
    Av8n++G5WMMY2xIX/wwmRZf4hoKAKfL3hFNxIXs5vLyzRPmuzfEF2yNI4b26kaacXxcEpu
    wkuvbyt1bxZayL9i3sJX/96asrM9Fxpwdteci0nsAPXf+pDJvw3VK3oqzfUqFEdzDf76AG
    ork2IhVwzDfW4aO3mAQyKRp7LHs/qUxeOfS2FE64ylEL2xo5xF6eAH9X5wosMI7ycuRDPj
    yUL97bCcA70M7CX4XB3+4eHx4815uMcHtGsz2ebz27+CIV1sfryoLqHEAlUls7dyhQg8/f
    887/cpsfATYmgtVcHmIg3XGLusMy8/OU7GftfLK9PJ/DuffVp2Q9aKMi23W4o/aTzFSEqJ
    fsV4v+D6EquKgL2f34vfv0HKJ/R1kcUgVr7IgwDcYcTen1eLEMFXIO5MMl9w
X-ME-Proxy: <xmx:3I1Qat8yQJ5QAVwTMxkT9vUvpTTPF46wJa8s1m8FerhWKFMLuTPI8A>
    <xmx:3I1QaqqAZECGb4_p5rUmxjW5BTOrOnf5FoT2o3kDgSCxLtDNmrLMbA>
    <xmx:3I1Qas9vs1yDsbCCmTZTv43Jr3K293ZOrIiY2hNIW38h5gKnwglIqQ>
    <xmx:3I1QauVHQx-DZ76nUIlDjPuzNTcG9H8YF2sfvXDKTpR0Tycl5hLUPw>
    <xmx:3I1QahMY8ndiI8TwJlHrzZkegL7mxyBaa1NNBMwkilpEE5WqJkjnNEN1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 02:14:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 77533892 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Jul 2026 06:14:50 +0000 (UTC)
Date: Fri, 10 Jul 2026 08:14:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/7] refs: remove use of `the_repository`
Message-ID: <alCN2Afi4gTSSajg@pks.im>
References: <20260709-pks-refs-wo-the-repository-v1-0-1ad6f27529c9@pks.im>
 <xmqq5x2nlwyg.fsf@gitster.g>
 <alCJgLcjXKEgNwFF@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alCJgLcjXKEgNwFF@pks.im>

On Fri, Jul 10, 2026 at 07:56:19AM +0200, Patrick Steinhardt wrote:
> On Thu, Jul 09, 2026 at 01:39:03PM -0700, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> > 
> > > The series is built on top of f85a7e6620 (Start Git 2.56 cycle,
> > > 2026-07-06) with ps/refs-writing-subcommands at 002fe677ca
> > > (builtin/refs: add "rename" subcommand, 2026-07-06) merged into it.
> > > Despite that, there's a small set of conflicts with "seen" that can be
> > > merged like this:
> > 
> > Thanks for a heads-up.
> > 
> > This seems to break so many tests when merged to either 'jch' or
> > 'seen', even though all of them pass standalone.  I did not have
> > time to figure out what interactions with which other topic are
> > causing the breakages.
> 
> Oh, interesting. I'll investigate what other topic this has interactions
> with. Thanks!

Hm, curious, I cannot reproduce any of these failures at all, everything
is passing locally when merging "seen" into my branch. Did you maybe
mismerge the changes in "setup.c" by accident? That seems like the most
likely reason as you mention that it breaks lots of tests, and "setup.c"
is of course involved with all of them.

For reference, this is what the final result of the conflicting part
looks like on my side:

	if (real_git_dir) {
		struct stat st;

		if (!exist_ok && !stat(git_dir, &st))
			die(_("%s already exists"), git_dir);

		if (!exist_ok && !stat(real_git_dir, &st))
			die(_("%s already exists"), real_git_dir);

		apply_and_export_relative_gitdir(repo, real_git_dir, 1);
		git_dir = repo_get_git_dir(repo);
		separate_git_dir(repo, git_dir, original_git_dir);
	} else {
		apply_and_export_relative_gitdir(repo, git_dir, 1);
		git_dir = repo_get_git_dir(repo);
	}

Thanks!

Patrick

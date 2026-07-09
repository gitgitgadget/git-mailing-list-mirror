Received: from chiark.greenend.org.uk (permutation-city.chiark.greenend.org.uk [93.93.131.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5D13EFFA2
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783589826; cv=none; b=j1ue4cGiV+2WxplxHExRuv7ZIV/ZqBgabk/NNQXQ1ztc6ob0nF0y5tMvKmKNH4HBcI+u6p4j5e+/6SJprzbPTScYXIkedxyplvWBNNGJA0I7pC5SsRslHvqyrU5YVpf0sTzG1S3JdKvT66wbgC4ouF8iFtYIp2wtnIau0mNBUG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783589826; c=relaxed/simple;
	bh=2bSRSaYtetTMNp5HdC5vrv/oSr4CFLrtJTz/mefvp2o=;
	h=From:MIME-Version:Content-Type:Message-ID:Date:To:Cc:Subject:
	 In-Reply-To:References; b=OiBNGJPP1905HWQQKyd21UbiQoz6dp+F5F6aO+zTS+0Lntv+Wt2o3oVz2LKUTXgBWAHug4Jv/lmMjlHL8PTT8ZKDNitgIDlvtpM29NvfqBPVWjKtgyNyZwshHbv+B3JInYAzFs2BxMud8TuRQKEixDVOUYODG4/R4ahO7mD2GUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chiark.greenend.org.uk; spf=none smtp.mailfrom=chiark.greenend.org.uk; dkim=pass (2048-bit key) header.d=chiark.greenend.org.uk header.i=@chiark.greenend.org.uk header.b=W14A7lT3; arc=none smtp.client-ip=93.93.131.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chiark.greenend.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=chiark.greenend.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chiark.greenend.org.uk header.i=@chiark.greenend.org.uk header.b="W14A7lT3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=chiark.greenend.org.uk; s=f.chiark; h=DKIM-Signature-Warning:References:
	In-Reply-To:Subject:Cc:To:Date:Message-ID:Content-Transfer-Encoding:
	Content-Type:MIME-Version:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=1ecPNAnNEQLPB92m9EGTyEN+p76jVf4/MRpB9M2XbDU=; b=W14A7lT33+QQ
	ezux2kTp5ov8pOwj0Yby9LpdKh+Ef7Yw2Emdr/tAucoJxM5hxgfDS3TU15o+FtIJ5o4xQbnoGlVO1
	3CWi+buBzhRO32mXMoCgVyEHiEH/5Bg/rCURaWaXxzLzXbSUF3PSW1tE4aRZZNLrWCM1sAVKXdgUj
	d971or+fmmjrXnKmEJ7Y+gPwCiCUQGD7scmuh7nLU75xRi9ZD4wDo1HU8BXxkBrhnPBo+qkCKiRhp
	oIBLBnR6kmQ96LJw9JN2y+1V4GYnMasZv2Dkeh1OaHUz7vr3ot0XiBu7wkyVeX1nn5ZUKy9ZFf2tp
	QFFuYKbck9rHiH+AUoQ/XQ==;
Received: by chiark.greenend.org.uk (Debian Exim 4.94.2 #2) with local
	(return-path ijackson@chiark.greenend.org.uk)
	id 1whlBg-0006d7-09; Thu, 09 Jul 2026 10:36:56 +0100
From: Ian Jackson <ijackson@chiark.greenend.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <27215.27575.968985.583226@chiark.greenend.org.uk>
Date: Thu, 9 Jul 2026 10:36:55 +0100
To: Colin Stagner <ask+git@howdoi.land>
Cc: git@vger.kernel.org,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] git-subtree: Bail out if we find output from Rust
 rewrite [and 1 more messages]
In-Reply-To: <f557bfcf-ffd2-4903-8015-97fff97dbe09@howdoi.land>,
	<9ef8cfcc-ab47-479b-9f23-71ba99e1e56b@howdoi.land>
References: <20260706115816.20267-1-ijackson@chiark.greenend.org.uk>
	<20260706115816.20267-3-ijackson@chiark.greenend.org.uk>
	<9ef8cfcc-ab47-479b-9f23-71ba99e1e56b@howdoi.land>
	<20260706115816.20267-2-ijackson@chiark.greenend.org.uk>
	<f557bfcf-ffd2-4903-8015-97fff97dbe09@howdoi.land>
X-Mailer: VM 8.2.0b under 27.1 (x86_64-pc-linux-gnu)
DKIM-Signature-Warning: NOTE REGARDING DKIM KEY COMPROMISE https://www.chiark.greenend.org.uk/dkim-rotate/README.txt https://www.chiark.greenend.org.uk/dkim-rotate/83/837009f527229b25a19cfaf2070e5217.pem

Hi.  Thanks for the review.  I'll go through it point by point:

Colin Stagner writes ("Re: [PATCH 2/2] git-subtree: Bail out if we find output from Rust rewrite (test)"):
> It may be slightly faster to create only one repo and just make orphan 
> branches, like `test_create_subtree_add()` does.
...
> `test_commit()` from test-lib-functions.sh may be superior to manually 
> writing and committing this file.

Thanks for the suggestions.  I'll take a look.

TBH I found this test framework quite awkward to work with.  Maybe
folks here have some tips:

One thing I was missing was a primitive for "check this fails *and
produces an error message matching this regexp*".  test_must_fail
makes it easy for a slips in the command (or some kinds of regression)
to go undetected: the test then passes because the command *does* fail
with a usage error or whatever.  And AFAICT there isn't a way to
manually inspect the output when the tests pass?  I resorted to
sabotaging the test by adding `&& false` to the end of the shell
snippet string, and eyeballing t/test-results/t7900-subtree.out.

Colin Stagner writes ("Re: [PATCH 1/2] git-subtree: Bail out if we find output from Rust rewrite"):
> > +reject_if_v2_config () {
> > +	local config=.git-subtree/config
> 
> This is a nit, but `local` is not specified by POSIX. I know it is used 
> elsewhere within git-subtree, but it is specifically discouraged.

There are 7 existing uses of `local`.  I think I prefer to use it here
too.  In practice I think there are no shells we might want to use
that don't have local.  The alternative is to change all the variable
names to be obviously globally unique, which is clumsy and also seems
to me to put us at greater risk of bugs.

> > +	if git rev-parse --verify -q "$rev:$config"; then
> 
> For subtree split, should we also test for this file in tree you are 
> splitting: i.e., "$dir/$config"? The answer might be no.

You're right that we should consider this question.  The answer is:
no, we should not.  Briefly, whether to use the new or old algorithms
depends on whether the downstream has adopted the new git-subtree, not
on whether the upstream has added some optional config.

https://codeberg.org/diziet/git-subtree/src/branch/main/DATA-MODEL.md#control-of-unmarked-subtree-merges-guessing-config

> I think that subtree merge should only test the top-level project, as 
> this patch does now.

By "top-level" I think you mean what I've taken to calling the
"downstream": the project where the subtree is in a subdir, and whose
top-level has other stuff.  In which case I agree.

> On 7/6/26 06:58, Ian Jackson wrote:
> > Another, bigger, reason is that current git-subtree generates unmarked
> > subtree merges (ie, without any git-subtree trailers)
> 
> Subtree merges can be performed without git-subtree, via the `-X 
> subtree` merge strategy option. While the design of RIIR git-subtree is 
> outside the scope of this patch series, this may be worth thinking about 
> in your rewrite.

This is what I'm calling an "unmarked subtree merge".  My rewrite is
not going to support this user behaviour.  The problem is that it is
not possible to reliably determine whetheer something is an unmarked
subtree merge.

It is possible to guess based on tree similarity, but that's a
heuristic.  It's also possible to guess based on root commits.
Both of these approaches can go wrong in some cases.  I prefer to
write reliable software, which doesn't guess.

I'll advise against this practice in the documentation, but I'm
reasonably confident that if a user does this anyway the results won't
be terrible.  The upstream input to an unmarked subtree merge in a
downstream that has already used my rewrite, will be treated as if it
were a downstream branch that predates the subtree addition.  The
effect on split (in most cases) is a missing parent relationship,
which is undesirable but not catastrophic.I've made a note to add a
test case for this scenario.

Combining manual -X subtree merges with git-subtree --squash merges
could easily produce quite weird and wrong results in the tree (even
before anyone tries split, or something).  I don't think I can even
reliably detect this situation after the user has done it, and of
course since that user is using plain git, I certainly can't prevent
it.  This is another reason why manual use of -X subtree should be
discouraged.

Regards,
Ian.

-- 
Ian Jackson <ijackson@chiark.greenend.org.uk>   These opinions are my own.  

Pronouns: they/he.  If I emailed you from @fyvzl.net or @evade.org.uk,
that is a private address which bypasses my fierce spamfilter.

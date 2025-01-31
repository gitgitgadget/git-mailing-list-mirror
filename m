Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD281547E4
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 23:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738366225; cv=none; b=qGQEgjQl8hcIxvIe2IwyNtMQawwcjmp20jpIWqY25LvxW8yswyXgsUscJfOK39MJ1d/Ii3XeAp57Lnw1HW4FVuDW+DG3IKkQvux3LMZtB2VX2dYxZ1HISzsJzykIPOQOYLseUYGUWJuCYcelB4fc0/c+exkbgJDdCpJV8phhuzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738366225; c=relaxed/simple;
	bh=PX+PLjkTEjKsdO5H4PKdMCdfl/3TSV1eZJ6Dg2Necs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDmVH0n4N74CsAeM1KTPc8R+CnDOJSmUOrToVuIlN88paZZPg4K6Rpe88PnPfLF5IXCl6nnqTAfD/kHMexsoNaeae4Rd+SmnOJS3xcYQw8laAX/N9Nuw6h/NoSkhYgqpJu2t9ssQcfChkWzibCFOpMNGMHitUo7th6+ZUrjkXCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=M/wYQRFC; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="M/wYQRFC"
Received: (qmail 7589 invoked by uid 109); 31 Jan 2025 23:30:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=PX+PLjkTEjKsdO5H4PKdMCdfl/3TSV1eZJ6Dg2Necs4=; b=M/wYQRFCg7NbPoWU8I7uVin0uz2n9D8l/JK8pr2sj5KHLmKgMu8ppePwlEP4f62VxCbsOK08jp4wbJyQU3JYjScpRN3yQOAl4YxV5EKNWeHPJhVzH4B/tl7EwKsvlIFz/kJysYV0umuhu3JTQxbuyy+sKzirujZ3Vcbsj718vYSpljUFT8KAVcOa7pYBe6NzyztPWGvOUGGwJSQAM3WURbIIZagY30dc6I0LQppSeOLPMI7dBmq1VmlltholdoMWMBOFsBOwsJzlN6ZZZ+E4VLMhNZp9H6UBDLlJXgtwgxnsomv7ImYEQUv1ktBSuBpMjZaSqNpRgtKaXqSCRmYOtw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 Jan 2025 23:30:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5717 invoked by uid 111); 31 Jan 2025 23:30:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 Jan 2025 18:30:18 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 31 Jan 2025 18:30:15 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #08; Tue, 28)
Message-ID: <20250131233015.GA3544301@coredump.intra.peff.net>
References: <xmqqlduulbgn.fsf@gitster.g>
 <Z5nfcAUZPNdDSI0l@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z5nfcAUZPNdDSI0l@pks.im>

On Wed, Jan 29, 2025 at 08:57:36AM +0100, Patrick Steinhardt wrote:

> On Tue, Jan 28, 2025 at 04:18:00PM -0800, Junio C Hamano wrote:
> > * ps/ci-misc-updates (2025-01-10) 10 commits
> >  - ci: remove stale code for Azure Pipelines
> >  - ci: use latest Ubuntu release
> >  - ci: stop special-casing for Ubuntu 16.04
> >  - gitlab-ci: add linux32 job testing against i386
> >  - gitlab-ci: remove the "linux-old" job
> >  - github: simplify computation of the job's distro
> >  - github: convert all Linux jobs to be containerized
> >  - github: adapt containerized jobs to be rootless
> >  - t7422: fix flaky test caused by buffered stdout
> >  - t0060: fix EBUSY in MinGW when setting up runtime prefix
> > 
> >  CI updates (containerization, dropping stale ones, etc.).
> > 
> >  Will merge to 'master'.
> >  source: <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im>
> 
> I'm a bit confused about the state of this topic. You say it will be
> merged to 'master', but as far as I can see it's not even part of 'next'
> yet.

Looks like it did hit 'next' now. I think we need this on top:

-- >8 --
Subject: [PATCH] ci: set CI_JOB_IMAGE for coverity job

The main GitHub Actions workflow switched away from the "$distro"
variable in b133d3071a (github: simplify computation of the job's
distro, 2025-01-10). Since the Coverity job also depends on our
ci/install-dependencies.sh script, it needs to likewise set CI_JOB_IMAGE
to find the correct dependencies (without this patch, we don't install
curl and the build fails).

Signed-off-by: Jeff King <peff@peff.net>
---
Grepping for "distro:" doesn't find any other instances.

 .github/workflows/coverity.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/coverity.yml b/.github/workflows/coverity.yml
index 48341e81f4..124301dbbe 100644
--- a/.github/workflows/coverity.yml
+++ b/.github/workflows/coverity.yml
@@ -45,7 +45,7 @@ jobs:
       - run: ci/install-dependencies.sh
         if: contains(matrix.os, 'ubuntu') || contains(matrix.os, 'macos')
         env:
-          distro: ${{ matrix.os }}
+          CI_JOB_IMAGE: ${{ matrix.os }}
 
       # The Coverity site says the tool is usually updated twice yearly, so the
       # MD5 of download can be used to determine whether there's been an update.
-- 
2.48.1.675.g52e87fcee5


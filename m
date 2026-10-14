Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FF4376490
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791968876; cv=none; b=pNeBlCHQ+E6xF0hwVAVS2jCM7nzxUD6WUU6bYP+SeNhXMp82caIVQtdT5hkY19c3QEM+JdsLc1h2OyYWMPModePJavcT1x+4eXVUc9cRzYA/xvmZ+2PQZMuLU53OubnxxfFuFN7w4AnAcmKdNvuDGrzPFK/SEhgjeiRH1Mzv90M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791968876; c=relaxed/simple;
	bh=Xm3f4jkzZojDIRmhO+14o+ths5HqgrVziziz7ZDXmmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhjIvWTChU5kkQMwJLfojpj5NOI0fOY/D2q0vN/qyIJdk1dxGYuCZFPwr2kh7Egz2WkgtZoCIgommzS6DN3NQ2Dh+ahdqhe6iHRBKjMefUjo05SrGkrauh29zHB7YF89KpHY6VaelbZarCSgbjJ0vZBz8U+DtSb9hc4TUTzOGPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=eZiaJQRS; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="eZiaJQRS"
Received: (qmail 68801 invoked by uid 106); 14 Oct 2026 09:07:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Xm3f4jkzZojDIRmhO+14o+ths5HqgrVziziz7ZDXmmU=; b=eZiaJQRSF/XSWP9qwQH3q2WiUS+Y+C6EgbZiYWYx3bfYDZlKgGaGfiaTjZ3UmCUWxB7sXBG4PhcKgXY4J1Zb+6PFm+2U/Piyg9OJqdR/kSCuYmYsOYrMSBuEWEVsVkBNWj9DJBwXzb1QEpIiqmA1NKPf+NotI5uw0iWDwy6bSX5jixTIpHjToZ8wk3+K/vQpLI37pTsI6MvfMmPbQ7oppaimYy55Jo2Xu/gV+dVgjot3gQWEd0kR/g9/xOYTeGR50LJb8pNujyzGeIHHy29Oq5EaCCo1DTZprK3ZZ9Gu86acdyydx/zHdlvqj8BdUzzBTqk8BjK1s3S1RHDvvLqOLg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Oct 2026 09:07:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 35564 invoked by uid 111); 14 Oct 2026 09:07:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Oct 2026 05:07:51 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Oct 2026 05:07:46 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Todd Zullinger <tmz@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 1/8] t5004: skip SHA-1-only test in SHA-256 repository
Message-ID: <20261014090746.GA1341124@coredump.intra.peff.net>
References: <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
 <20261014-pks-ci-housekeeping-v3-1-04c24e1f480d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261014-pks-ci-housekeeping-v3-1-04c24e1f480d@pks.im>

On Wed, Oct 14, 2026 at 10:30:27AM +0200, Patrick Steinhardt wrote:

> We're about to fix that typo in the next commit, but this will also
> uncover that the above test case is broken when running in SHA-256
> repositories. The extracted objects are SHA-1 objects, so extracting
> them into a SHA-256 repository is not going to yield anything good. So
> once we fix the Fedora-based job to enable breaking changes, which will
> make tests use SHA-256 by default, the test will break.
> 
> Fix this issue by adding the SHA1 prerequisite.

Does that mean we'll basically never run the test once Git 3.0 shifts to
sha256 by default? I guess we'll have a sha1 ci job (like we have sha256
today), but would that job actually hit all the other prereqs?

If we instead teach it to use its own repo, independent of the defaults,
then we could run it everywhere (that allows all of the other prereqs).

Something like:

diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
index 768b0ff85d..3a5c01c475 100755
--- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -187,6 +187,9 @@ test_expect_success EXPENSIVE,UNZIP,UNZIP_ZIP64_SUPPORT \
 
 test_expect_success EXPENSIVE,LONG_IS_64BIT,UNZIP,UNZIP_ZIP64_SUPPORT,ZIPINFO \
 	'zip archive with files bigger than 4GB' '
+	git init --object-format=sha1 big-file &&
+	(
+	cd big-file &&
 	# Pack created with:
 	#   dd if=/dev/zero of=file bs=1M count=4100 && git hash-object -w file
 	mkdir -p .git/objects/pack &&
@@ -206,6 +209,7 @@ test_expect_success EXPENSIVE,LONG_IS_64BIT,UNZIP,UNZIP_ZIP64_SUPPORT,ZIPINFO \
 	"$GIT_UNZIP" -t big.zip &&
 	"$ZIPINFO" big.zip >big.lst &&
 	test_grep $size big.lst
+	)
 '
 
 build_tree() {


A real patch obviously would also indent the test body one level; I
skipped that here to keep the diff readable.

-Peff

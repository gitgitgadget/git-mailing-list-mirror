Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3694D3A8C1
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 10:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741082808; cv=none; b=FPUuFHX9R2ZAMVFttmkMXulcR0Xqm4H+wARKPT6PQnmfoay0RgPwTxKgUdZZHS2Nb20QuwBGXwuWH9cQFvRSP+n7lCc4AFmn+EGJzjEXA2OGbckUHMXrloA1JY1HhYOagf8LgAcJMaV2FG+fO2ARD5U5JxZ9DktQFHvdSG0DSGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741082808; c=relaxed/simple;
	bh=SLU5re4QhoSzd26Q2IakSj9LKh1hER1OeN1NxKY37FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8nBUB2HtAdVsAUR0O5xo27ISGGEWYPAIwrde5nDCgit23INg+bnlYosdZS46gzgsF/tdNiGjckEJcwl66t/lZ052NBnp4xfa7IRNg/65rAIUejoghA7HTSQCHqF2Hoov7vMyb+YNvo/TS5j1XOwm0U4F++ZgNFkM7lWA6mlXKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FakSJGX6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0WN3JA+5; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FakSJGX6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0WN3JA+5"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 165831140122;
	Tue,  4 Mar 2025 05:06:45 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 04 Mar 2025 05:06:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741082805; x=1741169205; bh=jWHCUNcG/s
	lOjv0vG9+ClYzK4McBysavxzYppNOisU4=; b=FakSJGX6fg6F8YbSc8/Lvsr8yr
	60kPzjOZ/UZih0TPhvdvGHn7eK9cnKT4Fzr7I8h/Wup49YiZbyNt53e9XxVR75Kp
	j7kyJKrz4cvRMSZ0j6k8ECSRjvEzPptIQf7qStZolK9EeYU4QAc64vRwca/v54LN
	bJWfVFLeGQl+dOU8FybCvPgmRAJeFa0qNRwpioTiaJAwCI6gh1JslBbLiUerHsOH
	83IxU/1ge+4Ipa8HNlcX1ejhHBW5zTfGy4m/GEtm0bTa+3Jkx70xoVUpeGg/S6nc
	yLsTR1gUJT3Pim5E2dQjh0CgLn6zmNq8XpRev3N7H7Yr/5kJqBvdGrD5Q9ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741082805; x=1741169205; bh=jWHCUNcG/slOjv0vG9+ClYzK4McBysavxzY
	ppNOisU4=; b=0WN3JA+5dSeEFjXmy6vupsoNVzS8JmpHBsFZq1GXhGqsogqRj7O
	aODtOeA9BNuhM+sTaTnR9pdTIrx3EGQeQbjD6o8AKYMT1glRd10h4C7536Hg6bgE
	1qhbK0j7RYPfYDladjoNG30gxGX4Byhj0cUZkNSWicPQLz/jYrHNIyrc8tjNrFzF
	pEFaNfyp9flhngLXvIQenRgKjRWWbNuiaeWAwCZdc9bz/eukSWjxRmaHNVZl0djW
	h0peoPGuSE1C6O2Le4YVuDbzR6aJbisbSNNg361EXzbt9TvRpVdxaFMUwXU+59NS
	omZGxAenR2xdw82AH4fi20DqlMx31/Qht7g==
X-ME-Sender: <xms:tNDGZx63F2DJGWWaLGd5DMrI4ntvAn9njLhmnJp2mCbvtxg8J7Tmeg>
    <xme:tNDGZ-4HPFST9CwuF8ZsKoi6sR5XnzfA7fA07C4G-h7VmOm2U0acrglED_Iyi54B3
    pG3R7g_DQyenQqKmA>
X-ME-Received: <xmr:tNDGZ4eMd3fMWJjN1FQCwaSAVoAYMLL-bG0NLZvim3IptvvKVmZtnRMdDsdNBTWNo96OLIDJRala6oyPk9WvGk4_IleXbZC5P_HUwz4OrvkvJiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddujeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdu
    gfehtefgveelhfeuueevuedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlih
    hnsehgmhigrdguvg
X-ME-Proxy: <xmx:tNDGZ6KLfymIxvLleqP7q1oZkKLXKIz-5ZqVGpCVM0vkBQ0KQ8CHVA>
    <xmx:tNDGZ1LEXbQRLVmzCozCS7XofKDdlSHKpdKYGsNqkY0WsOmd_4455A>
    <xmx:tNDGZzzfzKKn7uFr4Rx3CYfjmAsFt_1Wd1bjWodfKKpofDeHx9QjvQ>
    <xmx:tNDGZxKGuKcgM_NHyFYkrf-aqSCE7ixqb9QPlQHMQwBQErueDeLzXw>
    <xmx:tdDGZ11wY6i1W50z7tNnHsDPAEzGrNtCm30g5Rdw6rvwLwLWEU8Qg1IJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 05:06:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4bbbc37c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Mar 2025 10:06:42 +0000 (UTC)
Date: Tue, 4 Mar 2025 11:06:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: ps/reftable-sans-compat-util, was Re: What's cooking in git.git
 (Feb 2025, #09; Fri, 28)
Message-ID: <Z8bQsflIqzZd3AMs@pks.im>
References: <xmqq7c591sus.fsf@gitster.g>
 <Z8aeLc-xelujEjTE@pks.im>
 <0c808b85-d97c-ecd3-0b1d-fba546a1124b@gmx.de>
 <9cc294f6-03de-d88f-9734-510a23fc8991@gmx.de>
 <Z8bL0HUuQqj7LlTp@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8bL0HUuQqj7LlTp@pks.im>

On Tue, Mar 04, 2025 at 10:46:17AM +0100, Patrick Steinhardt wrote:
> On Tue, Mar 04, 2025 at 08:40:13AM +0100, Johannes Schindelin wrote:
> > On Tue, 4 Mar 2025, Johannes Schindelin wrote:
> > > On Tue, 4 Mar 2025, Patrick Steinhardt wrote:
> > > > Johannes, did the new version of this patch series make your life any
> > > > easier? As far as I can see the conflicts in your "shears/seen" branch
> > > > seem to have been fixed, and the failing pipeline seems to be due to
> > > > other issues. If so, we would be able to move ahead with this patch
> > > > series and the dependent fix for Windows below.
> > >
> > > Honestly, I cannot say whether it made my life any easier. As you can see
> > > from
> > > https://github.com/git-for-windows/git/actions/workflows/main.yml?query=branch%3Ashears%2Fseen,
> > > the `shears/seen` branch failed to update automatically since I updated it
> > > manually last Thursday. According to
> > > https://github.com/git/git/activity?ref=seen, there have been 5 updates
> > > that were hence missed.
> > >
> > > I'll try to update the `shears/seen` branch now, but I'll time-box it to
> > > half an hour because I really planned on taking care of other issues.
> > 
> > It seems that there are the usual CMake-related breakages (not related to
> > ps/reftable-sans-compat-util, but to the introduction of the
> > `CLAR_TEST_OBJS` or at least the `lib-oid` addition to that). I hope that
> > the tip commit of `shears/seen` that I just pushed addresses that, but I
> > ran out of time to monitor this.
> > 
> > And there are some pretty bad `exit code 127` problems in the unit tests
> > on Windows, see e.g.
> > https://github.com/git-for-windows/git/actions/runs/13648196783/job/38151312208#step:5:213
> > (but again, I ran out of the allotted time).
> 
> Interesting. All of the errors relate to reftable stuff. Curiously,
> those errors only seem to happen in the MinGW build, but not with the
> Meson-based MSVC build. I can reproduce the issue in MinGW indeed, so
> I'll investigate. Thanks for the hint!

Okay, I found the issue: it's mismatching allocators. Git for Windows
has support for the custom mimalloc allocator, and it's getting roped in
by default in MinGW builds. And because the allocator is declared in
"git-compat-util.h", the reftable library uses allocators from mscrt.dll,
whereas the rest of the Git code base uses allocators from mimalloc.
This causes us to sometimes free memory with a different allocator than
we have allocated it with, and that causes a SIGTRAP.

Below patch addresses the issue.

Patrick

diff --git a/compat/posix.h b/compat/posix.h
index b484029f751..5ad3539d55b 100644
--- a/compat/posix.h
+++ b/compat/posix.h
@@ -176,6 +176,16 @@ typedef unsigned long uintptr_t;
 #define _ALL_SOURCE 1
 #endif
 
+#ifdef USE_MIMALLOC
+#include "mimalloc.h"
+#define malloc mi_malloc
+#define calloc mi_calloc
+#define realloc mi_realloc
+#define free mi_free
+#define strdup mi_strdup
+#define strndup mi_strndup
+#endif
+
 #ifdef MKDIR_WO_TRAILING_SLASH
 #define mkdir(a,b) compat_mkdir_wo_trailing_slash((a),(b))
 int compat_mkdir_wo_trailing_slash(const char*, mode_t);
diff --git a/git-compat-util.h b/git-compat-util.h
index 8d2acf86670..a102a365592 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -226,16 +226,6 @@ static inline const char *precompose_string_if_needed(const char *in)
 # include <sys/sysinfo.h>
 #endif
 
-#ifdef USE_MIMALLOC
-#include "mimalloc.h"
-#define malloc mi_malloc
-#define calloc mi_calloc
-#define realloc mi_realloc
-#define free mi_free
-#define strdup mi_strdup
-#define strndup mi_strndup
-#endif
-
 #ifndef PATH_SEP
 #define PATH_SEP ':'
 #endif

Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F20213E67
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 09:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743154162; cv=none; b=I1Kl37KQfrMe9SxUP3EBcioA7s/SyvcnwK+EEL62AIQ1sdVmxZWHlGQtrWeGVJKn84DHNexcX2/dXcsxvU3KhfokTMLI6vdLthKB/CXDf1ptxE3a33X7xq2Z5S4U8uk4yidn5FkPdxs84B/CgZT4kZr2YMvWea1Tci3i+Dno9Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743154162; c=relaxed/simple;
	bh=SwrDqgmCIP5uJYAXK+WXp5B/tTS4xMgTbyUyWOpbOow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=peys8NFFKBGGz/a34Z9UqGjAwVym97ARyXGa5ChJRYlIW1E8FE5Y2FzgdqcqI3e/gg2A3KqTWZyWy0BIO/vftCVY6ejs5ogAh1mWYmTdKdPuBMWjqFIUpKkprAl+DmC5AAq+kXWOllUimGnW7fijUlusqBF7x+wCTZzBaq0oKLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EONKlvBS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u4VH1pS3; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EONKlvBS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u4VH1pS3"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3F62325401C4;
	Fri, 28 Mar 2025 05:29:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 28 Mar 2025 05:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743154160; x=1743240560; bh=lSJek3FVPY
	FR5poXdTGDOkGctfaUg5pgbzx72vVE2I8=; b=EONKlvBS+S+BQRvVCv1TgMpxTr
	lxJVgHDj/Wp0yW/uybz+J/axg6KTjX/dBdBGg52zjmG8+EoRX0C2nCGcBu1Jc8kN
	E0M7Pl+OZIYbuZmwdd/Bhcpa4K678wEPyRC0Y2GzSLtqzmMJywg+zinXciXAqrr9
	NKUV//uNWfjb0lSWMRSzT0FSIkHiq4TdXFqx8FPacBWJXNi0SeK0uL8cPXnNsjdZ
	BqPmfL00Sj7SV3BQLKqYxvPbAQzO8aRCdaE/aANXubuuV8fl9+pdU1rANod2SVzi
	xRB388v1bc3wEgy6uK1HRYABZV6z0uKx5ZfmrdYNjOcXzo/D6qLOHXnhvnhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743154160; x=1743240560; bh=lSJek3FVPYFR5poXdTGDOkGctfaUg5pgbzx
	72vVE2I8=; b=u4VH1pS3IJSYyKnBDIZnjwmyMvXPiB6CF8+nAub1brE6YsiFhba
	suPLsSQXaYYRB9OU1a5eNfBGKerdGHeE0ZWOI84DSBURCSrLgGXf90fBbi1+7BYs
	Zq5a7x38jdUU2228GErDavHZY4SRgpsGuRn+uFoAVokd6T+bXsK2rV8MBLrKQ0xO
	sPwBgcYRkxnHKMox6cpt36kQ6zyLHGsmxtDQajiGDdUpizYf6yQJKSAciwolStev
	bvemNM4zxLfthWGK8NM64BofXnMAaxQNR4f0rqrSoQEEDdlRiBcZJN0C3W2pyrZv
	90xvecuBOO8UeSCVGqRtQ9cbgt5HIXe29ow==
X-ME-Sender: <xms:72vmZ59K9K4GKCEat8A2QtlZBCM9Sgo8j9o2dGIH2MZ10vhSB6-O9w>
    <xme:72vmZ9u7mO2i_kcmRzUmIYMIsn0mCgs-b4UByF5vKivfUUd9_OIv2-g_o78Ft6wEs
    HskqnxxnEHbzHFyfQ>
X-ME-Received: <xmr:72vmZ3AWE3JFh-MdycShUX-dG4vMpXj5ZP-6DIqc0IK0qUzq-2_hKuHKkA3xKL6hqsOklTpVRsNQoerAmeuDWQAF-BcZJe-HTOoZXPMyW1beuOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedtleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepjeevudeggfffffeigeethffgieekveeffeehvedv
    geeiteegueejleeihfeitdeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhmiiesphhosgho
    gidrtghomhdprhgtphhtthhopeguvghrrhhitghkshhtohhlvggvsehgihhthhhusgdrtg
    homhdprhgtphhtthhopehglhgruhgsihhtiiesphhhhihsihhkrdhfuhdqsggvrhhlihhn
    rdguvg
X-ME-Proxy: <xmx:72vmZ9eZbMxYDFWxzWAQueRuzIaddRlZ6guwlNFZHR8jO74MF76arw>
    <xmx:72vmZ-Nu7BxlEUpFLZGR52o81uyWfMDfT32bXEvaOtpateh7o6x_Hw>
    <xmx:72vmZ_nEdVCxUGVdVqVVHtRW5KsUthavOaa7GjkShXtHRWolTu0tMw>
    <xmx:72vmZ4slRgdnkvw_7JJoJJVDHcRJkD1iA7PHQ2z-Q1krbjpm08T3mw>
    <xmx:8GvmZ7q6ZJgYsRwi8dVh_bw2nH_4FdlV1WQcyr321HaubUJVYR4tPEuq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Mar 2025 05:29:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0d3db5b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Mar 2025 09:29:17 +0000 (UTC)
Date: Fri, 28 Mar 2025 10:29:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Todd Zullinger <tmz@pobox.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	git <git@vger.kernel.org>,
	Derrick Stolee <derrickstolee@github.com>
Subject: Re: Testsuite failure on s390x and sparc64 after 6840fe9ee2
Message-ID: <Z-Zr7BZL1UGqVxKu@pks.im>
References: <89257ab82cd60d135cce02d51eacee7ec35c1c37.camel@physik.fu-berlin.de>
 <Z-R_Zmr6kxCPLm-O@teonanacatl.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-R_Zmr6kxCPLm-O@teonanacatl.net>

On Wed, Mar 26, 2025 at 06:27:50PM -0400, Todd Zullinger wrote:
> John Paul Adrian Glaubitz wrote:
> > the following commit:
> > 
> > commit 6840fe9ee29ab51ffd7d924c624dc62da22c50bf
> > Author: Derrick Stolee <derrickstolee@github.com>
> > Date:   Mon Feb 3 17:11:05 2025 +0000
> > 
> >     backfill: add --min-batch-size=<n> option
> >     
> >     Users may want to specify a minimum batch size for their needs. This is only
> >     a minimum: the path-walk API provides a list of OIDs that correspond to the
> >     same path, and thus it is optimal to allow delta compression across those
> >     objects in a single server request.
> >     
> >     We could consider limiting the request to have a maximum batch size in the
> >     future. For now, we let the path-walk API batches determine the
> >     boundaries.
> > (...)
> > 
> > broke the testsuite on s390x [1] and sparc64 [2]. The following test fails:
> > 
> > not ok 4 - do partial clone 2, backfill min batch size
> > 
> > CC'ing the author which is Derrick Stolee.
> 
> I reported this during the rc period.  I didn't hear back on
> it, but hopefully your message will arrive at a more
> convenient time. :)
> 
> https://lore.kernel.org/git/Z8HW6petWuMRWSXf@teonanacatl.net/

Copy-pasting the test logs from that mail:

    expecting success of 5620.4 'do partial clone 2, backfill min batch size':
            git clone --no-checkout --filter=blob:none      \
                    --single-branch --branch=main           \
                    "file://$(pwd)/srv.bare" backfill2 &&
            GIT_TRACE2_EVENT="$(pwd)/batch-trace" git \
                    -C backfill2 backfill --min-batch-size=20 &&
            # Batches were used
            test_trace2_data promisor fetch_count 20 <batch-trace >matches &&
            test_line_count = 2 matches &&
            test_trace2_data promisor fetch_count 8 <batch-trace &&
            # No more missing objects!
            git -C backfill2 rev-list --quiet --objects --missing=print HEAD >revs2 &&
            test_line_count = 0 revs2
    +++ pwd
    ++ git clone --no-checkout --filter=blob:none --single-branch --branch=main 'file:///tmp/git-t.sYdo/trash directory.t5620-backfill/srv.bare' backfill2
    Cloning into 'backfill2'...
    +++ pwd
    ++ GIT_TRACE2_EVENT='/tmp/git-t.sYdo/trash directory.t5620-backfill/batch-trace'
    ++ git -C backfill2 backfill --min-batch-size=20
    ++ test_trace2_data promisor fetch_count 20
    ++ grep -e '"category":"promisor","key":"fetch_count","value":"20"'
    error: last command exited with $?=1
    not ok 4 - do partial clone 2, backfill min batch size

It would be nice to learn what the file contains instead of the expected
string, which might give us a bit more of a hint what's wrong. You can
for example apply the following patch:

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 79377bc0fc2..197494cd28c 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1975,7 +1975,7 @@ test_region () {
 #	GIT_TRACE2_EVENT="$(pwd)/trace.txt" git pack-objects ... &&
 #	test_trace2_data pack-objects reused N <trace2.txt
 test_trace2_data () {
-	grep -e '"category":"'"$1"'","key":"'"$2"'","value":"'"$3"'"'
+	test_grep -e '"category":"'"$1"'","key":"'"$2"'","value":"'"$3"'"'
 }
 
 # Given a GIT_TRACE2_EVENT log over stdin, writes to stdout a list of URLs

If you then re-run the test with `-ix` we should end up printing the
contents of that non-matching file.

Thanks!

Patrick

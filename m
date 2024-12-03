Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F597192583
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 10:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733221081; cv=none; b=lgD493o9uyJrZjJzl9mhTKQN3IUGdY5yz3bLHA8D14pmq9bZcTNUYGGkvQJmcJvXa58HEU5HiRoISTRhkJg6ejEByV+ffBNmEUUrPT94IIrPS1upgyJFXi6aVZbVrpM6GcVxPx/UEQNtq1Ox/YltJIYcH0j11aFMJlM4X50RHJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733221081; c=relaxed/simple;
	bh=XiKUDiSer5HISoMiMjeUHv7si6YNd2AMTsjgchpdjSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKG/LvAgQ3AjJ+8dOenjgfLil57lUv/wjC7shvYEtBkrWYYgfA4BDiYDE8F40G3PxdvF+4DqtOYdA+M/qdd/77kr9X6+Dr+YaY9irJZvPxf8lJ0sLjV9A/uZifmw1RurzLRibV7xn2wrmj5suuzs3Px3js26K4VDbsMb5bwHLMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bsrfz2G+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yQm1ZiVR; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bsrfz2G+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yQm1ZiVR"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 57146254018F;
	Tue,  3 Dec 2024 05:17:58 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 03 Dec 2024 05:17:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733221078; x=1733307478; bh=GPTOBu7MaD
	0o7fMHcmvx8sSlRFFfr9zqHrJ1Gu0/lGA=; b=bsrfz2G+8gdTKhkGJUGXXk7KJZ
	ar7zKnAwZhW4K0W3gzl+mem59NmFBvJK1bKeyObMas/hP22+phRPVA2F2whcU49x
	ZJK2E86hmfoUpyr/d6neKH+zA9jiVlH4M3iDqFzUSoPNjoW+cib5Va7a2/wxMon0
	ptc+o990F9e3bH6c/il2/WhFoqZP3Uj6uu65bhAIRWUPwna+8ApuKH0KY/B9cz0E
	JjOVbB5LbWDrC4LI5gU72HQJMJa5ylChzSp+izduvfcjvtWFPzsv9ZziqGQ+v2fJ
	qWBiJsMx7ZDOOpJWKTioEdmYXAkCdFLwujG4dQgGo2btiA7LsBUFnX4eOhgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733221078; x=1733307478; bh=GPTOBu7MaD0o7fMHcmvx8sSlRFFfr9zqHrJ
	1Gu0/lGA=; b=yQm1ZiVRD95+jAf44G9eIQOM+ht6T9GMNKrFqJOK1TqXZ95XOXL
	kCOz11ejaWP7Wujn24sCPmD0OgJWKtEJ9IE2EbMGG5N6LueX0gX8+9igD1oaiRzU
	jBGr0hbN3XJ/e9+PRfPdt5xRCBkVP3L9p/462H0lZrOz5aVHrZF7m157qi0azgZ7
	SeU53mnCyCyNzqBQgxDteX2RxlvRwpbbCOBudyqVFq+YYLNpY0Q8eWpwhKkzX1CJ
	smKIXWdQE0CNcf0fQ1t/D3gNkeC0ZAj1l6E5o6sCHuCsOh1uFYC0qCb9h9Y5r3lF
	LcNAxTjkFqGAept3ctSFsjjkcHWLML+zBOQ==
X-ME-Sender: <xms:1dpOZ3gGnojGBLgAexp6VyXqBQKMkCnaC5DE3JtlhMHpdf7oG-vyjA>
    <xme:1dpOZ0CtrnNUrBNSPooPz6yhMjwsQkvcLt-WPqPhJJILX8gALe69Xw1nkvnNmXnqC
    N8LGBAtDpUPoHT-wg>
X-ME-Received: <xmr:1dpOZ3GcZ19TeXnHX__EJsZH6GqzvbJVqvAULhepHsVfTNmzylR3GnZjMqKX9ZtH9WD-mAoRFC8VRI9yZHf1QaYoRepJ6qgBg2ySTp2OJN4SLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedvgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpedtveefgfdtteffvedvffelteevuddutdefhfeijefgteeu
    jeehheeijefgieffvdenucffohhmrghinheprgguughrvghsshgvugdrphhspdifvghltg
    homhgvrdhpshenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    khgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:1tpOZ0SOujAREWVUAgkSc3ACBsM_xZeXAAXKVBeDux2guc_BbF9-dQ>
    <xmx:1tpOZ0xvM7aPuyAHKJMgaZpd-Gsx-9l9_5mTuEAyEy5L3IepuqLQ8w>
    <xmx:1tpOZ65H28wxddjK3hGk1O-SmxnHPfIVvU33cIGRF1IriWsy6nWLBQ>
    <xmx:1tpOZ5xqyaaCB2lz5jGaZEvmZiT5uI54o4kh3kI0JzhV-WKSIhTFow>
    <xmx:1tpOZ-swqzrFpD01kPmzYiSpANq_qDGY0fEPuUq0dWSqX9-nSdWNJTyC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 05:17:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fff900d9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Dec 2024 10:16:37 +0000 (UTC)
Date: Tue, 3 Dec 2024 11:17:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2024, #01; Tue, 3)
Message-ID: <Z07auxNCcysPovdo@pks.im>
References: <xmqqed2pcled.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqed2pcled.fsf@gitster.g>

On Tue, Dec 03, 2024 at 03:48:10PM +0900, Junio C Hamano wrote:
> * kn/midx-wo-the-repository (2024-11-28) 10 commits
>  - midx: inline the `MIDX_MIN_SIZE` definition
>  - midx: pass down `hash_algo` to functions using global variables
>  - midx: pass `repository` to `load_multi_pack_index`
>  - midx: cleanup internal usage of `the_repository` and `the_hash_algo`
>  - midx-write: pass down repository to `write_midx_file[_only]`
>  - write-midx: add repository field to `write_midx_context`
>  - midx-write: use `revs->repo` inside `read_refs_snapshot`
>  - midx-write: pass down repository to static functions
>  - Merge branch 'kn/pass-repo-to-builtin-sub-sub-commands' into kn/midx-wo-the-repository
>  - Merge branch 'kn/the-repository' into kn/midx-wo-the-repository
>  (this branch uses kn/pass-repo-to-builtin-sub-sub-commands and kn/the-repository.)
> 
>  Yet another "pass the repository through the callchain" topic.
> 
>  Will merge to 'next'?
>  source: <20241127-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v3-0-c5a99f85009b@gmail.com>

This series looks good to me.

> * jt/bundle-fsck (2024-11-28) 4 commits
>  - transport: propagate fsck configuration during bundle fetch
>  - fetch-pack: split out fsck config parsing
>  - bundle: support fsck message configuration
>  - bundle: add bundle verification options type
> 
>  "git bundle --unbundle" and "git clone" running on a bundle file
>  both learned to trigger fsck over the new objects with configurable
>  fck check levels.
> 
>  Will merge to 'next'?
>  source: <20241127233312.27710-1-jltobler@gmail.com>

I've posted one more question on this series about how the config
callback function is set up and why we ignore errors when parsing the
"fetch.fsck.skipList" config. So you may want to hold off merging until
that question was addressed.

> * ps/send-pack-unhide-error-in-atomic-push (2024-11-15) 6 commits
>  - push: not send push-options to server with --dry-run
>  - push: only ignore finish_connect() for dry-run mode
>  - t5543: atomic push reports exit code failure
>  - t5504: modernize test by moving heredocs into test bodies
>  - push: fix the behavior of the Done message for porcelain
>  - t5548: new test cases for push --porcelain and --dry-run
> 
>  "git push --atomic --porcelain" used to ignore failures from the
>  other side, losing the error status from the child process, which
>  has been corrected.
> 
>  Probably needs a redesign.
>  cf. <Z0Q0wfSTk_cUXH0F@pks.im>
>  source: <cover.1731603991.git.zhiyou.jx@alibaba-inc.com>

I wonder whether we want to roll with the first version that I have sent
instead of using v2 from Jiang. It seems like a more minimal fix and
does not have the issue that we have different behaviour across dry-runs
and non-dry-runs.

In any case, additional input on this series would be welcome.

> * ps/build (2024-12-02) 24 commits
>  - meson: fix conflicts with in-flight topics
>  - Introduce support for the Meson build system
>  - Documentation: add comparison of build systems
>  - t: allow overriding build dir
>  - t: better support for out-of-tree builds
>  - Documentation: extract script to generate a list of mergetools
>  - Documentation: teach "cmd-list.perl" about out-of-tree builds
>  - Documentation: allow sourcing generated includes from separate dir
>  - Makefile: simplify building of templates
>  - Makefile: allow "bin-wrappers/" directory to exist
>  - Makefile: refactor generators to be PWD-independent
>  - Makefile: extract script to generate gitweb.js
>  - Makefile: extract script to generate gitweb.cgi
>  - Makefile: extract script to massage Shell scripts
>  - Makefile: use "generate-perl.sh" to massage Perl library
>  - Makefile: extract script to massage Perl scripts
>  - Makefile: consistently use PERL_PATH
>  - Makefile: generate doc versions via GIT-VERSION-GEN
>  - Makefile: generate "git.rc" via GIT-VERSION-GEN
>  - Makefile: propagate Git version via generated header
>  - Makefile: refactor GIT-VERSION-GEN to be reusable
>  - Makefile: consistently use @PLACEHOLDER@ to substitute
>  - Makefile: use common template for GIT-BUILD-OPTIONS
>  - Merge branch 'ps/clar-build-improvement' into ps/build
> 
>  Build procedure update plus introduction of Mason based builds
> 
>  Will merge to 'next'?
>  source: <20241128-pks-meson-v10-0-79a3fb0cb3a6@pks.im>

Fine with me.

> * kn/the-repository (2024-11-27) 10 commits
>  - packfile.c: remove unnecessary prepare_packed_git() call
>  - midx: add repository to `multi_pack_index` struct
>  - config: make `packed_git_(limit|window_size)` non-global variables
>  - config: make `delta_base_cache_limit` a non-global variable
>  - packfile: pass down repository to `for_each_packed_object`
>  - packfile: pass down repository to `has_object[_kept]_pack`
>  - packfile: pass down repository to `odb_pack_name`
>  - packfile: pass `repository` to static function in the file
>  - packfile: use `repository` from `packed_git` directly
>  - packfile: add repository to struct `packed_git`
>  (this branch is used by kn/midx-wo-the-repository.)
> 
>  Various implicit uses of 'the_repoository' in the packfile code
>  have been eliminated.
> 
>  Will merge to 'next'?
>  source: <cover.1732618495.git.karthik.188@gmail.com>

I think there were two nits that Karthik has addressed but not yet sent
out. May make sense to wait for that final reroll before merging it
down.

Patrick

Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9030E74040
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732098988; cv=none; b=uGnXlEWUaj4sefjLV3t4EqOI1NUUXkFHhM7eLQRYc5dpaquaJJX1hn95kfeJiSyM/MmzPW9XpAJa8NH5612AlsgiDp527pc2WB61B1q7NKsXGpro5asa4ecpetau3sEP6MJv1PQ/WBVPBu3y0LYbJrKakoUgv1nFx5AXGN3nSSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732098988; c=relaxed/simple;
	bh=uu3Z0pGi1G+qbhPGYMGGbuO9xu2tIGXUEKfBbEacTGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5wk9zyqnwPglImTfL5fkPirdLfv4BUaM6dd7u26dw2Xjct2UbhlsKyLq+42i+j9kJrES7xZXGBJvkucFqSBSopInoqocdg6H3ciWRO2skFw7CJv7f1nveghVy7dWJANL4AnOIEfWOVAfNrHIsmDAR9lydCwjJfgHPgWXWVFNfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GCOyA4SM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cGVym4ck; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GCOyA4SM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cGVym4ck"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 77D4511401B9;
	Wed, 20 Nov 2024 05:36:24 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 20 Nov 2024 05:36:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732098984; x=1732185384; bh=R9X2PDmafF
	9e1O+/0hFwoAxGymyEim56ct3tmkcWGAM=; b=GCOyA4SMSnnEYl3NMcZoCE0qMB
	mD8NUse1vey75h+PlhUqNHOO0+doCI5pRCNTlb4hu0ehnjKpfZwPl5lEKt2OUq2o
	5Raszs+Bxsm0m5dCdTLgJErG9qjHrEJEjg9QdexcvPZKpwGfELqWqJ91glUyBiGR
	jwlXQ9ox0VP9g+FgvlvO4cz0CNYdtus3qLeW8MYCFgbDcj6sVya3OJ70d9SOLYSP
	qsnlH1PsxA7mZzMT4gUKHljYOhXPnYB/botoiMz3beIDW3elsSrQlhuwVTgLGYMQ
	Um9Pw+BETokkv8AwumIE1XQ/X/Jqf+XNp7E/Vq+y782oV17YI0oSheP+Pj8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732098984; x=1732185384; bh=R9X2PDmafF9e1O+/0hFwoAxGymyEim56ct3
	tmkcWGAM=; b=cGVym4ckkFJQey4dhZ1jhcGoj0IaORDgjhclYdNq0bMHuMdxQGl
	AuZF+iFaxjNbGO7gvdfyLbilk6yZ0+K5D0UzSwsDirGEiKCm61kWW/YXubrMqkrt
	9TsiZY1D+NLSUk4te8UljjHZfrHnkuxSluU3SOufYzbgUa/5BEQmFg5CI2MKzJok
	zKttYRTk3B6o04j0qJRwGMoyhILZ6AzaRdBKN37WNE53Fw05XWq8fVdSCha9sqVA
	br8Xoq8ZLbiC0aqEsLxxjRd/vMF9lQdLaDBzo1uSs/FJguhHuR2tmn7k/gYjhVVQ
	NARDI3yh9ye7xUs2A7QkYjNnldnYYPsFw9Q==
X-ME-Sender: <xms:qLs9Z2D2gBKXS3HQyOZ-922lgplqc7lYFigzp8L8Ubp4YoyM8VivaA>
    <xme:qLs9ZwhDuWbk8lOtANZMTMFC4yn4ucZhqoNrAn30jxcXg0Y4b8agUgbVk05LqdXro
    n8p9xpzdHwDwADFUQ>
X-ME-Received: <xmr:qLs9Z5kS2-Gz7fMYilezrgj2yMX1uUSRO3yYWNZtU44CQmh3s_shtmB0ziyNqhAh5ltD05hCm7Qmmf-HCjAyp4zOl5h67bOh9qj6WMlhkZLXjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpedtueetgfeljeevteffueelkedttdeggeehveejtdffhfeh
    heejvdetheeggffhkeenucffohhmrghinhepihhnshhtvggrugdrphhspdifvggvkhdrph
    hsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhs
    sehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:qLs9Z0zN6xS-2iuebKqpLStspCKqNEglDgNdJc8PP0MW73uBoopnag>
    <xmx:qLs9Z7R1LClkJalsnWHALU096SVOZ2E19vSmm4LKbGYoDFVAgp0Svg>
    <xmx:qLs9Z_ZxhJQWqNRSO5jWLyviOwFhhc5l38pR-bhndr7McBvEE44AxQ>
    <xmx:qLs9Z0QbLRCqVG4RTA0HU5pX80YRYOskAt0N26NflCCqbIql5fRaqg>
    <xmx:qLs9Z8J8JxrQMGRnXqSk2ppBN28cjGwHOeUQs54vCvWV3dmjggNVEEq_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 05:36:23 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 02524d89 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 10:35:28 +0000 (UTC)
Date: Wed, 20 Nov 2024 11:36:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	shejialuo <shejialuo@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2024, #07; Wed, 20)
Message-ID: <Zz27kX159PKAmBOb@pks.im>
References: <xmqqo72ai929.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo72ai929.fsf@gitster.g>

On Wed, Nov 20, 2024 at 05:49:34PM +0900, Junio C Hamano wrote:
> * ps/gc-stale-lock-warning (2024-11-20) 1 commit
>  - builtin/gc: provide hint when maintenance hits a stale schedule lock
> 
>  Give a bit of advice/hint message when "git gc" stops finding a
>  lock file left by another instance of "git gc" that still is
>  potentially running.
> 
>  Will merge to 'next'.
>  source: <20241119-pks-maintenance-hint-with-stale-lock-v1-1-f9f9a98e12a0@pks.im>

Note that this message should speak of "git maintenance", not "git gc".
The confusion probably comes from the commit message's subject, which
speak of "builtin/gc", which is because the implementation on these
commands are both hosted in "builtin/gc.c".

I'm never quite sure whether I should speak of the command or the code
unit in this edge case, but this message here seems to indicate that it
would be preferable to mention the actual command instead.

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
>  Needs review.
>  source: <cover.1731603991.git.zhiyou.jx@alibaba-inc.com>

I'll review this patch series later this week.

> * ps/leakfixes-part-10 (2024-11-13) 28 commits
>  - t: remove TEST_PASSES_SANITIZE_LEAK annotations
>  - test-lib: unconditionally enable leak checking
>  - t: remove unneeded !SANITIZE_LEAK prerequisites
>  - t: mark some tests as leak free
>  - t5601: work around leak sanitizer issue
>  - git-compat-util: drop now-unused `UNLEAK()` macro
>  - global: drop `UNLEAK()` annotation
>  - t/helper: fix leaking commit graph in "read-graph" subcommand
>  - builtin/branch: fix leaking sorting options
>  - builtin/init-db: fix leaking directory paths
>  - builtin/help: fix leaks in `check_git_cmd()`
>  - help: fix leaking return value from `help_unknown_cmd()`
>  - help: fix leaking `struct cmdnames`
>  - help: refactor to not use globals for reading config
>  - builtin/sparse-checkout: fix leaking sanitized patterns
>  - split-index: fix memory leak in `move_cache_to_base_index()`
>  - git: refactor builtin handling to use a `struct strvec`
>  - git: refactor alias handling to use a `struct strvec`
>  - strvec: introduce new `strvec_splice()` function
>  - line-log: fix leak when rewriting commit parents
>  - bisect: fix various cases where we leak commit list items
>  - bisect: fix leaking commit list items in `check_merge_base()`
>  - bisect: fix multiple leaks in `bisect_next_all()`
>  - bisect: fix leaking `current_bad_oid`
>  - bisect: fix leaking string in `handle_bad_merge_base()`
>  - bisect: fix leaking good/bad terms when reading multipe times
>  - builtin/blame: fix leaking blame entries with `--incremental`
>  - Merge branch 'ps/leakfixes-part-9' into ps/leakfixes-part-10
> 
>  Leakfixes.
> 
>  Will merge to 'next'?
>  source: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>

Toon left another comment that I'll want to have a look at before
merging this to "next".

> * ds/path-walk-1 (2024-11-11) 6 commits
>  - path-walk: mark trees and blobs as UNINTERESTING
>  - path-walk: visit tags and cached objects
>  - path-walk: allow consumer to specify object types
>  - t6601: add helper for testing path-walk API
>  - test-lib-functions: add test_cmp_sorted
>  - path-walk: introduce an object walk by path
> 
>  Introduce a new API to visit objects in batches based on a common
>  path, or by type.
> 
>  Comments?
>  source: <pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>

I think what's interesting in this case is the incompatibility between
the path-walk API and bitmaps. It seems like there is some push back
based on this, but from my point of view the path-walk API still has
uses where bitmaps don't matter that much, like in the proposed new
git-backfill and git-survey tools. Both of which are of interest to me.

> * cc/promisor-remote-capability (2024-09-10) 4 commits
>  - promisor-remote: check advertised name or URL
>  - Add 'promisor-remote' capability to protocol v2
>  - strbuf: refactor strbuf_trim_trailing_ch()
>  - version: refactor strbuf_sanitize()
> 
>  The v2 protocol learned to allow the server to advertise possible
>  promisor remotes, and the client to respond with what promissor
>  remotes it uses, so that the server side can omit objects that the
>  client can lazily obtain from these other promissor remotes.
> 
>  Comments?  I got an impression that this is premature without
>  finishing the discussion on a larger picture.
>  cf. <ZvpZv_fed_su4w2-@pks.im>
>  source: <20240910163000.1985723-1-christian.couder@gmail.com>

Chris is currently writing such a doc that tries to clarify the bigger
picture. So I guess we can evict this topic for now, start to discuss
the vision and then once we're all on the same page start to think
re-submit the topic.

I've Cc'd him in case he disagrees with me.

> * sj/ref-contents-check (2024-11-15) 9 commits
>  - ref: add symlink ref content check for files backend
>  - ref: check whether the target of the symref is a ref
>  - ref: add basic symref content check for files backend
>  - ref: add more strict checks for regular refs
>  - ref: port git-fsck(1) regular refs check for files backend
>  - ref: support multiple worktrees check for refs
>  - ref: initialize ref name outside of check functions
>  - ref: check the full refname instead of basename
>  - ref: initialize "fsck_ref_report" with zero
> 
>  "git fsck" learned to issue warnings on "curiously formatted" ref
>  contents that have always been taken valid but something Git
>  wouldn't have written itself (e.g., missing terminating end-of-line
>  after the full object name).
> 
>  Comments?
>  source: <ZzYqoai8X_Wdtbmt@ArchLinux>

I've already reviewed this version and expect a (probably final) reroll.

Patrick

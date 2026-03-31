Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA1928CF4A
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 03:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774928094; cv=none; b=TN7L17P972pwlYo2GvbIy+mck6rLQG6bVV1l+iEr/lDDMQkAvXtGm/WjCXNI+rx31VXOITz4469AQBC0TwZaEiBryIcJ9DDMEw/Xq7o2ZRxJ66r5Y9385ODloK0imemgqsM68YPlct6BvM2dF2QqJgoUYUM4QC6NM+RhEPbgo+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774928094; c=relaxed/simple;
	bh=t8JZdI9zRga1mtNrl8AT+wXHonLUkMsF/6E+TSgUfrs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PUOhgBo9SR8Jql9GZcwT0uomyiyNqy6Jf9lwqH7hgTDaXd2VKfEz6b04nkKJ1+LsKGxUgCg+IU3yMPwCSie3qXhOHqCHVx/NqB81PXle4ebgHN0bqOW8Q+4CrQR2WrkC5vYX9b6MJ3WR8df4u3P3UnWL75n9LAksERme2DUSrdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LTeJX5/D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pW549/40; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LTeJX5/D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pW549/40"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BAA1F7A0269;
	Mon, 30 Mar 2026 23:34:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 30 Mar 2026 23:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774928091; x=1775014491; bh=E5j8Hwtuwy
	5RyAJzpH9a+ZKdhwMBbeM+FrhCBZFfofA=; b=LTeJX5/DGbm3+gBtR4y7w50l42
	sWD++TM7EMKFBHpCZ0Nv9IYKkpNYUUWHNcDFRC2DSvVMGxbFQcAjbXOEe5VsTWE5
	LtHQDFgB2grw0+TZ9LuI/GzydOwu5jlBt/xbXHx82h2VCb78h10Spz5XCITChdjz
	UPBH19BoXgTeStV+v32rrwO+h4LJ4ro0JtfniRmjnfURuzqqrMlffNKlvZg5yOvK
	q2CaPGHnpEDWX9EKiPc/6qgRdBduIptHhpF/2a4UcvCZIKx9zcqAMp9G0fRlEwyk
	sXcGr/pdazMyeXM6F2yLFZfXmNnhMKcxiCMZ16pDb4BbPakDV2TxMuTge2wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774928091; x=1775014491; bh=E5j8Hwtuwy5RyAJzpH9a+ZKdhwMBbeM+Frh
	CBZFfofA=; b=pW549/40YOHdRl7A7ptF8V9Vu7IMpW3NFWONSLOuHWXpfrkZrox
	VsXdDeeJmrQg/7BEAF361/581GHP4Vwl2y/5dVoe8KUg5DRgbPvfbDW/d0M2fpj6
	/yeail7GzOKAuINOE8iZ/h1gYWzahch+VEYNmFFVcXhtKjYJKATFVxc+fAzAbkJd
	t7jDaJVwKU5ngVtswluQM7SCKt1O9F606ydNGHpNTdOtQgqc2ifM2TT/TX7SDNPJ
	x3Pvg+AVyiJsqlDXbYrQppn9YY8YauZNm8ay8PBp0d6w5Zj+eDU8iPDm+/h2m6wm
	apNizlF4eS7JaqDqtCW0JINU4W78/ng2//w==
X-ME-Sender: <xms:20DLaShNk3QxcxMiiQ16qoHrrm3AzmonWlsiC-RiufSaWVB0-h_adg>
    <xme:20DLaWsLW8K9xv-yrRL5ZduiJA-84TPMMCz9sE6HJ3-211J14_91UpkX5IgH0VFrp
    31myiAFRQi7yA7YA97Qtes_pKGLTqVghTHirya13zfmrrMmqRPnCQ>
X-ME-Received: <xmr:20DLaT5ZbSb2OALhIDMQZyFBp5E2KSW_o136ncPVpR9iLhpuTkZY1gZ__1cOMZ5eaydzvwHY0sQRbA5sPnkP6ASggm37nDNsfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgedtkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepghhithhhuhgssehprghulhhishgrghgvvghkrdgt
    ohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghu
    lhesphgruhhlthgrrhhjrghnrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:20DLaSMj0ofkKjmjBz9mVKECz8SlEd5NphXoF1CFvrQeXAxjKSmT7g>
    <xmx:20DLaRs3xMQzAFMAKoN8ddS-l4vhVpUFfT1K3r8gzTmpYeSwKif3iw>
    <xmx:20DLaVbXIdeLKjOQrqyfknDdIfZexXZBAr_mt3bQjqyG9mIet0NpVQ>
    <xmx:20DLaTxqMCattDUeop1l50-lVrwQp2u-7-dcv7Q2bqpl9_UKRhdo9Q>
    <xmx:20DLaSoaHiqrj2I3zbBwyOFdo8pW365ykyfxHgYfZuyMyCwuWzTwXGIa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 23:34:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>,  Paul Tarjan <github@paulisageek.com>
Cc: Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Paul Tarjan <paul@paultarjan.com>
Subject: Re: [PATCH v11 00/12] fsmonitor: implement filesystem change
 listener for Linux
In-Reply-To: <acphGnG9uX9C6dvx@pks.im> (Patrick Steinhardt's message of "Mon,
	30 Mar 2026 13:40:10 +0200")
References: <pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
	<pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
	<aakyzGksiC2fhhiD@pks.im> <xmqqwlyzsmq7.fsf@gitster.g>
	<acphGnG9uX9C6dvx@pks.im>
Date: Mon, 30 Mar 2026 20:34:49 -0700
Message-ID: <xmqqjyus4qp2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> > So please take a bit more time to work feedback into your patch series
>> > before sending out the next version. It's totally fine to wait a couple
>> > days between iterations.
>> >
>> > Also, could you please clarify whether the patch series has been written
>> > by AI and if so, which parts of it are?
>> >
>> > Thanks!
>> >
>> > Patrick
>> 
>> The topic went totally silent after this message; is this topic
>> still viable?
>
> I didn't have the capacity recently to focus on this patch series.
>
> Also, I think we need to be extra careful with merging this patch series
> as it's written mostly by AI as far as I understood. So I don't quite
> feel comfortable to ACK this series by myself, as I'm not sure to what
> degree the code is understood and reasoned about by anyone.
>
> I'm not against merging it in general, but if we want to merge it I
> would like to have at least one more thorough review by somebody who
> understands this area before I feel comfortable committing to it and
> maintaining the code going forward.

I share that exact feeling.  After all, the section recently added
to SubmittingPatches about AI-generated code was to address this
kind of patches.

In any case, when this topic is merged to 'seen', it seem to break
linux-TEST-vars CI job, which essentially runs the build and test
with these settings:

        export OPENSSL_SHA1_UNSAFE=YesPlease
        export GIT_TEST_SPLIT_INDEX=yes
        export GIT_TEST_FULL_IN_PACK_ARRAY=true
        export GIT_TEST_OE_SIZE=10
        export GIT_TEST_OE_DELTA_SIZE=5
        export GIT_TEST_COMMIT_GRAPH=1
        export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
        export GIT_TEST_MULTI_PACK_INDEX=1
        export GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=1
        export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
        export GIT_TEST_NO_WRITE_REV_INDEX=1
        export GIT_TEST_CHECKOUT_WORKERS=2
        export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1

and t9210 fails with this topic merged (abfd972), and succeeds
without (4b8355c6f8).

  https://github.com/git/git/actions/runs/23775508256/job/69276399578#step:10:562
  https://github.com/git/git/actions/runs/23777158230/job/69281498657    

I also reproduced the breakage locally on a debian-testing derivative.

Help to diagnose and pinpoint the bad interactions with topics in
flight is greatly appreciated.


! [abfd972] Merge branch 'pt/fsmonitor-linux' into seen
 ! [4b8355c6f8] Merge branch 'ps/receive-pack-updateinstead-in-worktree' into seen
--
-  [abfd972] Merge branch 'pt/fsmonitor-linux' into seen
+  [abfd972^2] fsmonitor: convert shown khash to strset in do_handle_client
+  [abfd972^2^] fsmonitor: add tests for Linux
+  [abfd972^2~2] fsmonitor: add timeout to daemon stop command
+  [abfd972^2~3] fsmonitor: close inherited file descriptors and detach in daemon
+  [abfd972^2~4] run-command: add close_fd_above_stderr option
+  [abfd972^2~5] fsmonitor: implement filesystem change listener for Linux
+  [abfd972^2~6] fsmonitor: rename fsm-settings-darwin.c to fsm-settings-unix.c
+  [abfd972^2~7] fsmonitor: rename fsm-ipc-darwin.c to fsm-ipc-unix.c
+  [abfd972^2~8] fsmonitor: use pthread_cond_timedwait for cookie wait
+  [abfd972^2~9] compat/win32: add pthread_cond_timedwait
+  [abfd972^2~10] fsmonitor: fix hashmap memory leak in fsmonitor_run_daemon
+  [abfd972^2~11] fsmonitor: fix khash memory leak in do_handle_client
-- [4b8355c6f8] Merge branch 'ps/receive-pack-updateinstead-in-worktree' into seen




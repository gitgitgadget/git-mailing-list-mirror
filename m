Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F55B1836D9
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737734545; cv=none; b=eea0HHI1I4zA9AXxIKaMw1JaUINZ243LnKEDlmpS8dXZUi7QWhGyJbkWwvLBLKI3hSJ6eZZwnds35AuL+zy++J0SP1cACSxmpNbQPRPJT7XFpdYlZJKq3D9CYq49nIpiK4SFwunhJ4PQrzwid9f10xXlZSvsty383thmW6AhxKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737734545; c=relaxed/simple;
	bh=fwxLD3gWgq5XkYk4sdnp6zyISgwkWsWAq4VteodJ1/M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ci2/9T9BTpWNenGLsPUzUpRFEcGsQYiX6TScS0NC+vD2JmDanE3Br1g18ivbi7XERy3kHYaz/ctdjg4VMosjtzrYA1SDtKCiMydwfQD2gy26CsXYEp3XvyIdozgc4tdcn5eVgYnKAuGaQt3tfDA0X/fPdck5DGFE3F4tWrBNNfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MAdh5sU/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nOtPwHLP; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MAdh5sU/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nOtPwHLP"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 5DDAF11400BD;
	Fri, 24 Jan 2025 11:02:22 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 24 Jan 2025 11:02:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737734542; x=1737820942; bh=wT+mOVmsYv
	8FahjpUju2MjIVhV8JvVrBx28406MzaBo=; b=MAdh5sU/vXrcED+fzPVHE5N/vG
	x4gbnk1hhSn5jrApFqYEn3oP4PMBjmaF3c/EIVQOMupBjBsoMuV10caJWPgGUHPj
	0+YnneavQuZDz5ojlp76+jyMigmf/pcGJqkylTRl7H0r7SzDbJZKCR6cJHaCv1/9
	PxNArUA92LeOTN/tCjtVxQG6Iio/uPYPbc0mW9k2tDABqJImVWhL5EnslRAmohbv
	lsoGuqCAbS5DgYd8/PWo1Ah9w0qMlDL4vXDr7F2wOuKrZ9BTOTFMhSJu0ToPk8rE
	Z+yS1RDCX91jjV1L35/gIoQuwl9PKQp4W2vj+JAXRFTT+IWcoDmY7hBkMnAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737734542; x=1737820942; bh=wT+mOVmsYv8FahjpUju2MjIVhV8JvVrBx28
	406MzaBo=; b=nOtPwHLPrkH4AEhMNsnBXwQFYZUes7iTCpodvfdTLVU707tRWmb
	lua3RqVvCjspscuvnDms4+hWXaYq5gYqgZwbplSzYFsWGz05bevtisju1NH7fKM0
	WNyqxG/0Vzv5fW4RfP+CXs7bxcjMTGAczOfG4/8bQHwGSl4UnwUHDQc7IVzXZ+1O
	9wBxVMscj/KiKUWwIxiriOlRNcBK8lDI6lu07o5Nc3tIHU/D0csirM8/yzsZlVNY
	d3Z/L4Ry5ykGL415Mo2gzLPWWCZFNKtp2eYhN1LzxaT460Cda75cnCVWvKO9BrZv
	ng8aP9R91y4ZUfYQvNmbTGc6t231XvVtq7g==
X-ME-Sender: <xms:jbmTZ-gDnKDCidg1i_AbWo5dpt2qiAplecU5G8V6Wgpq3ByngNeNzQ>
    <xme:jbmTZ_A1xp_8Ee0M8Oa1BvwOvdMDMMBjapPPgpcQmlrbsCUw63uEOGc9kanhlRPVR
    7kplXct5H__5owbVA>
X-ME-Received: <xmr:jbmTZ2HveuzBGfkjd6q_o4vfWePb_Ys7OrPt6C4qGs_tgiIqZQw-5Y7MkpfaxRjoL-v2sWAliQCPtnNan0LDKsOBQBVpLwxSWSic>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedggeelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedvudegieeilefhuedtudehkeejhefhieeg
    gedtieehgfevveffteduieekkeelfeenucffohhmrghinhepthhhvghnrdhpshdpmhgvrh
    hgvgdrphhsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:jbmTZ3R-uDPgFUNprEmRtgw0qjiYXg0FgZlxJeOvQmvMeIi43C-jHQ>
    <xmx:jbmTZ7zTXS47DGbM78yeFNut3RidSZw3yi9kHlSCAfmToIBGPMpMGQ>
    <xmx:jbmTZ16rZMTM48RQ2lLZQUrjlInI5R2eXQfF3Amr-rwJvayXW-xRqQ>
    <xmx:jbmTZ4z8GAJRCTzyKJZ_ul-qDEqVmqd0IGWvHnWLAsks8bz8kTF_EQ>
    <xmx:jrmTZ7_ep-PiNJY0wk_lycFHgTY79azyOpaFL7jluJ5IvS4lyytwe6Sf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jan 2025 11:02:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #06; Wed, 22)
In-Reply-To: <Z5MuCd_GbbLK_puS@pks.im> (Patrick Steinhardt's message of "Fri,
	24 Jan 2025 07:07:05 +0100")
References: <xmqqbjvyv510.fsf@gitster.g> <Z5MuCd_GbbLK_puS@pks.im>
Date: Fri, 24 Jan 2025 08:02:20 -0800
Message-ID: <xmqqr04sp5df.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> * ps/ci-misc-updates (2025-01-10) 10 commits
>>  - ci: remove stale code for Azure Pipelines
>>  - ci: use latest Ubuntu release
>>  - ci: stop special-casing for Ubuntu 16.04
>>  - gitlab-ci: add linux32 job testing against i386
>>  - gitlab-ci: remove the "linux-old" job
>>  - github: simplify computation of the job's distro
>>  - github: convert all Linux jobs to be containerized
>>  - github: adapt containerized jobs to be rootless
>>  - t7422: fix flaky test caused by buffered stdout
>>  - t0060: fix EBUSY in MinGW when setting up runtime prefix
>> 
>>  CI updates (containerization, dropping stale ones, etc.).
>>  source: <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im>
>
> This series was approved by Peff, but other than that it didn't get much
> feedback indeed. I'll rope in some additional reviewers.

This one I took another look while reordering topics for the next
integration and noticing that it had a bit of interaction with
another topic.  It looked good, so let me mark it for 'next'.
Unless these others find anything objectionable, that is.

>> * sk/strlen-returns-size_t (2024-12-26) 1 commit
>>  - date.c: Fix type missmatch warings from msvc
>> 
>>  Code clean-up.
>> 
>>  The remainder needs to be reviewed.
>>  source: <20241223110407.3308-3-soekkle@freenet.de>
>
> This one seems stale to me, as there's been a v2 with [1].

IIRC the patches were pretty much independent, and this one was
clearly ready from the initial batch.  I'll let it merged to 'next'
independently instead of waiting for the remainder, which was not.

>> * jc/show-index-h-update (2024-12-20) 1 commit
>>  - show-index: the short help should say the command reads from its input
>> 
>>  Doc and short-help text for "show-index" has been clarified to
>>  stress that the command reads its data from the standard input.
>> 
>>  Comments?
>>  source: <xmqqfrmidyhk.fsf@gitster.g>
>
> This series looks good to me.

Will mark for 'next', then.


>> * ps/3.0-remote-deprecation (2025-01-22) 7 commits
>>  - SQUASH???
>>  - remote: announce removal of "branches/" and "remotes/"
>>  - builtin/pack-redundant: remove subcommand with breaking changes
>>  - ci: repurpose "linux-gcc" job for deprecations
>>  - ci: merge linux-gcc-default into linux-gcc
>>  - Makefile: wire up build option for deprecated features
>>  - Merge branch 'ps/build' into ps/3.0-remote-deprecation
>> 
>>  Following the procedure we established to introduce breaking
>>  changes for Git 3.0, allow an early opt-in for removing support of
>>  $GIT_DIR/branches/ and $GIT_DIR/remotes/ directories to configure
>>  remotes.
>> 
>>  Will merge to 'next'?
>>  source: <20250122-pks-remote-branches-deprecation-v4-0-5cbf5b28afd5@pks.im>
>
> The squash-commit on top of the series looks good to me, so I think this
> should be ready.

OK, will squash and merge.

>> * ps/send-pack-unhide-error-in-atomic-push (2024-11-14) 2 commits
>>  - transport: don't ignore git-receive-pack(1) exit code on atomic push
>>  - t5504: modernize test by moving heredocs into test bodies
>> 
>>  "git push --atomic --porcelain" used to ignore failures from the
>>  other side, losing the error status from the child process, which
>>  has been corrected.
>> 
>>  Needs to see if competing parallel topic needs to replace this one.
>>  source: <20241113-pks-push-atomic-respect-exit-code-v1-0-7965f01e7f4e@pks.im>
>
> I think v3 sent by Jiang Xin looks like a reasonable alternative to my
> fix, but it needs some fixups. I'll maybe wait one more week for them to
> reroll the series, and if that doesn't happen I might adopt their
> patches and do the fixups by myself.

OK, so just keep this one so that I can point to your above remark
in the message I am responding to ;-)

Thanks.

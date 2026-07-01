Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B654BC00B
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 17:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782927299; cv=none; b=pmphKuIDyXtWyF45x8u4YuW/VYvyyjnsj1KCdMzGCh1WLyoTXAQ9UKNWV5MtbGWYOvKiXNB30DAFrvopkGs4yzfP8eAljrRx3BElqz2KDLq2wE/kTfp99cqlNU4jQXjfL17AYWOE30FmEDZpAqLi0hnb0gzeluudpFQjDEM3M1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782927299; c=relaxed/simple;
	bh=MqDTO1vLMFPhIsxgJWCHfRVGrltkgwKsaqzNMXkmCkM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UI/SawYeUsNvqL1J1FLlYd3NNRpjCNC2TjJmfCLbZ7YR0NszTC37k4OD6TkWBjCGc5yYBRjd7U2zG1XDAJVhC3jzj8jSi8LEeR+YO1PE/RvT5ZsTXAPp1wI8ZqYVuWK78CKUbssFv50RQ3AT96V+306904WDLX9cfAp/WVnrWJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YvwHr47K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P7GMlLYw; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YvwHr47K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P7GMlLYw"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C8CCF14000DE;
	Wed,  1 Jul 2026 13:34:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 01 Jul 2026 13:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782927295; x=1783013695; bh=yYI8/DCJ8Q
	ZEbp8hMp+KrKSo7vCCj/sFvjYrZtkRW/g=; b=YvwHr47KQ4iT+O7x4bOpN8kpTR
	1Hs57PZyT4V2+K3Yrs33vTnnpqKi878qeiBv80NLX7vEhuyxtcNGjGV8Y4o5Geuw
	SyWRIwc+Fy0NbE9+OmscFWaKWiBSqTqj7zGCDwLkP8SQUZInZ249aFQTJ+r72dig
	Y8uy3AchNYmICltUM847qch4H18qYP6Ju2Ny4/EJ3/AaHMSTweSSOXQMuofVjpFC
	f0TUzs3O/zaQrQqkP5bcacCqIS/N0HKX5zvgBIDHpnBTAOelcvRzgKi7a7car7gW
	5fuXM7Tcbx99nAfIDAXiMQPQ5+Z+8npOPThcgjn7183p2kT4/XLWiYTaG27w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782927295; x=1783013695; bh=yYI8/DCJ8QZEbp8hMp+KrKSo7vCCj/sFvjY
	rZtkRW/g=; b=P7GMlLYw9DHXFgbOUAJFPxLaOPqqKe98iUwNRwwlNYcyUpB+WgE
	5FxeScxm0kIQNx8lP6vEawBXAr5Co40YoE/pZ4lUIxmIUhUAZ+mGbkmIDkl0KkWk
	mwjeCCtvRpE+78v/t8jzBjnfk2luj/z9otrINjYsgT/RzVFUe9dyqdy9L4jW/n4R
	NzqWxiejzHLGL5czsxVd5c+eQTvDoJ9lxix1oEtb9ffylX1/yQ6So04zfiXMbRLq
	d8Vgy6RZBuCxq0XRjxz9r0AuO39o6zS4bjgJdzpi4juPXBHczybVytqDyqohP7xu
	/PA1AKsoRkvQUNI1tQB2TnAC4xE/LsCcJ0g==
X-ME-Sender: <xms:v09FagQtzdo5xnZjs-1hDPgAc43Md5AkQMYVjCADzfwFP1RszcVryw>
    <xme:v09FakyDrNrN8qv7z1wl2t84xsjs0fIOB8UPENhO7mg-ms4h77PwW2LF0uExSn2QW
    WUzYnOtwt7ejt7B8mq40MZUBx0-Gppef3VNPhAEzhFhFXQZP3eYZK4>
X-ME-Received: <xmr:v09Fai09ZHkWTwA3bUx1fXdNnS5N6jY2rxsshJ-prsroF7l1PfUkiKcAi1S7pRxMykJAPh5JDmBRuw7YycTfDIlCRswQ7HSHfRTmVgU>
X-ME-Proxy-Cause: dmFkZTEgX1YAStOcoagI1V+7b9DuJzdjiOt+5JBCgXSm0zRQ2bMwCdDDOeo6eBDMYZ+UEp
    mG7o5jiAX51Ax4m66MFXkKZV+OyV7ooIX2/XGKAJkmcpQlS54FPJO0QsPhsg05NvKsYkbk
    YAVi8OKaaOJA6DfhA6uqPttzf40Ov9YpYWnhD57X/2nDJkrZxM18S9IxdqUm7S/xpz55fs
    rn7vwMKQLRBCe4wKBqA8AnnEP7rcKod5YdRsi0kwXFfmeKryNBFFFqDizZHT6cXk+LUjIW
    LsOlvE+/DQDHBQvip6+JGpNSjlthSVhHhwu5MchEzGs1yEik+7DHKz0MCzB1I9H1q69HMr
    APffRDMfx/Tj7ohMN/vbKu/b+XZSgfoFqZx6IZS00x5Ytk3JzCxG04iVISF6pelMydMy+u
    Z+PH14RxDoJaoYm/a2jhCQyT3fATewpAl+NwfOrvXbymKXoayrZMbSm1LFW7EhYVJQQ8l/
    xK2+tLfTLUQU0J/Psyl1JyPEGYpMMZHX7FzSyZgSq5U/K6cRib+QXZdmwHDwmKp83NRZ/I
    Ioa7At/BjldIuAzIHRSsb18kjZSWO++yWVhh7BHRtSnO3rK5AWLVccNHLiP/9TR1wxwI93
    90EtmcYLDt539I47p6LZRH5EvHs/Mq9k90hUZHU0HkDyZf11cHVZThQ6n7Rg
X-ME-Proxy: <xmx:v09Fai6IQAOKQ1hJiy1Wot2yHVB5XeB_5OcBhwcPN_tzymLBQdWGrw>
    <xmx:v09FalWFfHhe9Hs8Fjq-b1oHWA9CjqR1jBTlGb4t3ddk3VqjtgWSTA>
    <xmx:v09FahBxwRul2bgdXOkL9TFzqmGNpEQpzxU1O0SFEMkjWxrkzPMd5Q>
    <xmx:v09Fak6XnD89vwyugl9K17RPQsAJiYpTKM0b5GiYyyBeqz6CKXktMA>
    <xmx:v09FaoML8V2PEjM8UwG1i9Kk1XKYV_0JpKubHyz3J5qRqG1GIs9NGTrK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 13:34:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 00/13] coverity: fix leaks and error paths
In-Reply-To: <pull.2163.git.1782889472.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Wed, 01 Jul 2026 07:04:18
	+0000")
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
Date: Wed, 01 Jul 2026 10:34:54 -0700
Message-ID: <xmqqjyreobpd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> I wanted to whittle down the many issues reported by Coverity in the Git for
> Windows project. Turns out: The vast majority of the issues are false
> positives. Most of the remaining issues are in core Git proper.

I read through the series and did not see anything jumping at me as
wrong.  Looking good.  Will queue.

Thanks.

>
> This effort was forced on pause while Coverity was down from May 16
> [https://web.archive.org/web/20260516152422/https://scan.coverity.com/] to
> June 22
> [https://web.archive.org/web/20260622182153/https://scan.coverity.com/]).
>
> Here is a first batch of fixes for those issues.
>
> Johannes Schindelin (13):
>   load_one_loose_object_map(): fix resource leak
>   loose: avoid closing invalid fd on error path
>   download_https_uri_to_file(): do not leak fd upon failure
>   run-command: avoid close(-1) in start_command() error paths
>   run_diff_files: avoid memory leak
>   line-log: avoid redundant copy that leaks in process_ranges
>   dir: free allocations on parse-error paths in read_one_dir()
>   submodule: fix cwd leak in get_superproject_working_tree()
>   worktree: fix resource leaks when branch creation fails
>   imap-send: avoid leaking the IMAP upload buffer
>   reftable/table: release filter on error path
>   fsmonitor: plug token-data leak on early daemon-startup failures
>   mingw: make exit_process() own the process handle on all paths
>
>  builtin/fsmonitor--daemon.c |  2 ++
>  builtin/worktree.c          |  7 +++++--
>  bundle-uri.c                |  2 +-
>  compat/mingw.c              |  4 +---
>  compat/win32/exit-process.h |  1 +
>  diff-lib.c                  |  3 ++-
>  dir.c                       |  9 +++++++--
>  imap-send.c                 |  1 +
>  line-log.c                  |  3 +--
>  loose.c                     | 11 ++++++-----
>  reftable/table.c            |  4 ++++
>  run-command.c               |  6 +++---
>  submodule.c                 |  8 ++++++--
>  13 files changed, 40 insertions(+), 21 deletions(-)
>
>
> base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2163%2Fdscho%2Fcoverity-fixes-leaks-and-error-paths-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2163/dscho/coverity-fixes-leaks-and-error-paths-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2163

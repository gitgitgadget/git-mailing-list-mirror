Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCED82868A7
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749228445; cv=none; b=enxsl595NmvcFVwOjZJT/ZOHB1TDfvzNOB1zfu0HHb6h7a227BUhmTooqpAuZvcGSgl5E1Gwq+o6UfginHKJ45umGkkUlv65lOShulWUbU+QDWxvQ0iRmjKfXaJQZ6jRgzVs/r15xW5cvPhX9nm6gXEhuMgO2Y8kGC45b0ceJwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749228445; c=relaxed/simple;
	bh=9eZKLJMSxYKhtuc5Mswd3XBnsCold+ck/7U0leJr7eM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V2AGnGZdvIQ9gpAKxN59gxJj8dkIbiJB0o/om9f7/wXoIo/50dw0O5yuT+/jB1ZDIep99vyPsr7T0JliKqgVAve46xmGs/YxWt1lNppuJzLVytNwXvHRHZ+eTFoDgOlvpzoQEhHY8hpAA1qVtJqyIuDyKnOk4NunldmNqxSTbzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gWMB28Vs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HxMNiZl+; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gWMB28Vs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HxMNiZl+"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DEAB92540125;
	Fri,  6 Jun 2025 12:47:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 06 Jun 2025 12:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749228442;
	 x=1749314842; bh=SOaHORsYIdlrne5un5fWugPRObT5+K5aWbc2YrddNLM=; b=
	gWMB28VsJU8Co9PlH2yAwbuT2NOcRMzocXm/fbK/k/H72Q0ZtEWExORemavkHVR8
	6qr9yJemYnNVdHXyEfLg27sf66WBzFWehVNOy0EtbS1bI9gUX1/kscyiT+g1ajyK
	HRQ5JpQkUNkoChbKFoS6Bkg9lGSCdKnVokGv4L+EtVd4u5fWGRLNBYzZEAvlg3MM
	g1SCWipXoeazJh8H/wa4Ku6T0sNluh6QtQajmXPA0gPigce8jGDPJvjxhcsBGBkF
	kGYs2B0OtY84Kwh3g7N4QyVxs9SJQlRcf+6nHiZ050N+7KpEyVZ2HQmXLP1i94dM
	NqMmx4luA8Cus3b6kHPkpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749228442; x=
	1749314842; bh=SOaHORsYIdlrne5un5fWugPRObT5+K5aWbc2YrddNLM=; b=H
	xMNiZl+CtNlwq3mEYNhO65r3kMNIPJCWCELYx7HCCCkjbWyMHBwfhKfN/y2Exl48
	/8MfFrex6Agmzs9PgAq8ewbiTBm8dYF/FYswaRioFkqPrA6vIQaDI3/4zwhiWNwJ
	KDOxShdryQ8cBSzaDxarCJG4PQ7RmCBK/7kYuJLPpLrbDjfE+7IWxzBW+Unmi7CP
	ivthyMkyS7uypcQVsoroW/bCUICPU9BdZB/4jE2ex+35XIJxP9TotBei+sDOGqXG
	35y5vxQIu75O1bV790VdbgE/SAplqxjpTut+VwAp+ACSRcwV0ZAYj8TifKFwF1Iy
	SZHy0trNfHtTozPYvsQqg==
X-ME-Sender: <xms:mBtDaMfrKTiVDizbeP_dePkzr4zV_F2Y3ntHOTwLQB0TWmQILxt3KQ>
    <xme:mBtDaONJGMlx7i0Jw0tiDVfPO8OeylzOAPT1BJJzbwhgxfx0YOquG-fOMZdCkgjwd
    HxCb4vbUxNVT5cyzQ>
X-ME-Received: <xmr:mBtDaNi_XWAtGa_c2eHoUef8dqul2F9AVK9AD3Y4dn5St5zd9kreh1GSNWuXFIIarPBwWXU-0NpgIfiUIZeqXDGtTbHEwZLSnV4p>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdehfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeehtddvtddvgeeffe
    dttdehieesshhmrghilhdrnhhjuhdrvgguuhdrtghnpdhrtghpthhtohepphhssehpkhhs
    rdhimhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:mBtDaB8rSrKrvuAxczG73u8S3CEzhqiGpj_YydsW8rVEqgGlam7kUg>
    <xmx:mBtDaIv6KWsL7LZi9_zUIY-5wWTZk0u16dugi3433fDlf_TkEV3Odg>
    <xmx:mBtDaIErA1tMLYp6juySQ5bKk4oCAR3k_QKy82BqhkgKPNB-T3__iw>
    <xmx:mBtDaHP9-AQTL9XdxA4Nw9ZzcMu6PUmU2y1DKGEM4-XVFd02AR4f3g>
    <xmx:mhtDaDnSF_4LYmRTkS73jPgUkZQmhUjkY0FB1C8eMUfGPSDB21EWQ-zx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Jun 2025 12:47:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: lidongyan <502024330056@smail.nju.edu.cn>
Cc: Patrick Steinhardt <ps@pks.im>,  Lidong Yan via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] revision: fix memory leak in prepare_show_merge()
In-Reply-To: <90FE268F-2309-49F0-9C3B-DFB207CE6F47@smail.nju.edu.cn>
	(lidongyan's message of "Fri, 6 Jun 2025 15:31:52 +0800")
References: <pull.1989.git.git.1749006537271.gitgitgadget@gmail.com>
	<aD_6T0lUOsqrb5sH@pks.im> <xmqqmsal7vqx.fsf@gitster.g>
	<90FE268F-2309-49F0-9C3B-DFB207CE6F47@smail.nju.edu.cn>
Date: Fri, 06 Jun 2025 09:47:18 -0700
Message-ID: <xmqqikl83jhl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

lidongyan <502024330056@smail.nju.edu.cn> writes:

> I could add this test case into my patch. Though I don’t understand
>> + git rev-parse HEAD >.git/MERGE_HEAD &&

That was not about telling "show --merge" to work on any meaningful
data and to produce any useful output.  I knew the step to prepare
for "show --merge" was leaky, so I gave a very minimum that can tickle
that codepath.  I wasn't of course proud of the direct manipulation
of the filesystem (as recent "git update-ref MERGE_HEAD HEAD" would
not even allow us to do this, sheesh, not very convenient).

If you came up with a sequence that produces a situation to use the
"git show --merge" command in a more realistic way, like below, that
is wonderful.

> If HEAD is equal to MERGE_HEAD. Would git show —merge still
> works as usual? How about something like this
>
> diff --git a/t/t7007-show.sh b/t/t7007-show.sh
> index d6cc69e0f2..f693b6e24b 100755
> --- a/t/t7007-show.sh
> +++ b/t/t7007-show.sh
> @@ -167,4 +167,28 @@ test_expect_success 'show --graph is forbidden' '
>    test_must_fail git show --graph HEAD
>  '
>  
> +test_expect_success 'unmerged index' '
> +       git reset --hard &&
> +
> +       git switch -C base &&
> +       echo "base" > conflicting &&
> +       git add conflicting &&
> +       git commit -m "base" &&
> +
> +       git branch hello &&
> +       git branch goodbye &&
> +
> +       git switch hello &&
> +       echo "hello" > conflicting &&
> +       git commit -am "hello" &&
> +
> +       git switch goodbye &&
> +       echo "goodbye" > conflicting &&
> +       git commit -am "goodbye" &&
> +
> +       git switch hello &&
> +       test_must_fail git merge goodbye &&
> +       git show --merge HEAD
> +'
> +
>  test_done

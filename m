Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72321EABBE
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 12:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513253; cv=none; b=TAtZ1HaEX6dLrrgUzMy91KcHbLECalJHq5IzHajn6glx0ih2Xo99zRp668J08BSVSctsS77NGxGjUzp8yks+zF0kIwN6o6zDF602KaixYIaZevZKpiTUqpSP2gcbts4kRyxqHc9+HYIn37jXBv6xrx66+giJCiJWaE8kFonpFs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513253; c=relaxed/simple;
	bh=oqKFUND1ER1AUBUgpw8YwBeyc/4f1PNboPZ9t23j+8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtigP5yh2xxHIEeHtfu0u5b2RwXdV5vDoOA0dnRCjUFFZ6P4nJqGIfeckYmvOETmoKhAcOsJ3MRIYaZTSs6JJi9XLm25DKwFD6vJxkYzCsTsKmizTOkkUJxVawTbHcsm2Es9A+U4CIZNwzij0sCjTqiMCjQNcC+bOHs5KePjUNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UJFaW4lU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ChiKRCZq; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UJFaW4lU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ChiKRCZq"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id CFA1F13806A9;
	Mon, 21 Oct 2024 08:20:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 21 Oct 2024 08:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729513250; x=1729599650; bh=e/EPc7wSPg
	PGjigJ6itpxHZGD8pQ0x0W6wTmAiFEcqI=; b=UJFaW4lUNQ59/qbyj/SaLKUZzz
	2QOySkniXCza6dwHxt6+z9PKaq40ylB4Conp1N6mKm875SpElvdZrxHj2DZv0wlo
	4HELqGCsDjRM/19Brux25C6GBObeiPXfcOXX0s7izXx/6v8TWf7rTr6b/fuxIFC+
	H70N12QwNm+25alQCAs1rK8Ui9dwc7s3WPthE+udVMKWglt6zinVBC02lgP9zDxL
	efzLPkEMihp3fC9mXLs2GFsN8i83gZnWnXirY67DFBxEglwX9cO+JwiU0ERF0Hfn
	icLGK94DpgIn0XtRtHjagePDmIb7RwRLZB7DQyWy5NaSSoOcqnIOamqk6h8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729513250; x=1729599650; bh=e/EPc7wSPgPGjigJ6itpxHZGD8pQ
	0x0W6wTmAiFEcqI=; b=ChiKRCZqfK7kznjpoY0RQsRCuUYXtyzm1gTb7fax9YSb
	q3pLCwBsibjNw1voeDqCRGxrDb00oiWmxSH9H3GbXiPVaj+XSS41VlMAT5OSxePC
	JbYjCugf3XiTXBv5qayryQDsHFS8Jr8FSpeJxcJVXCXsh9+YerTDdX0jI/D/eOz3
	q2BRgqUsofCpnOLYDvsAndzT8ASdnlNFIkZH2mo8gQ7OIGNB6lMQxLLZWBR7YU/A
	tM1DrQ62gJNrix5Lbs6Ug/0ljyuGGFWtJsr6KMnTM8MDFChdEr6seH2nzuv1Jj1B
	1M3uwNGqkT5j0DlLsgChaNS+sbdS+sa9pLmkdtbBnA==
X-ME-Sender: <xms:IkcWZ9QaJaoqMkTP8gySJLIjqop-X7S9C9RK6qZ54TpXV5WZ_pjybQ>
    <xme:IkcWZ2wATaOsLxB5Uv7pXC_jfg5Q31VSdF5TDsYvXd0UR4qRrBx3ltgw39ODEFJV7
    ibiG657-UnYYpXAWw>
X-ME-Received: <xmr:IkcWZy2OGrmnUoxcl0_GYBkY_0hR2X4ZMg0YB1KNx-hmOeyfdjQammn0U7ia8VRWrzXcjY2JrashMlj-4sLJxyDN9ne50lWjogVqGq8mBwi3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:IkcWZ1BjagghLqJSHbOhJywLCvcyC1gPIWAPJzaY7Fq3XoyfimIs8w>
    <xmx:IkcWZ2jtiVTo9U0Dp1sUHGDwaZn6aw2eF_qJB7ssDBqfN_r_wagsTA>
    <xmx:IkcWZ5ohzHYiWq_WN9ojU0O3aesQltvYLs7gKly3DcmUjidoKnOMPg>
    <xmx:IkcWZxg8sPPSOt4pigNhslLyLM9AcB7yBTWkc23JUZOnXgzQ_Bg6ug>
    <xmx:IkcWZ3tgGYAYTNXLFwmThQIEDYuiTSzXzilU0J2wzPCiINxAFaY_v_jg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 08:20:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 875f3217 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 12:19:18 +0000 (UTC)
Date: Mon, 21 Oct 2024 14:20:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>
Subject: Re: [PATCH v2 1/3] daemon: replace atoi() with strtoul_ui() and
 strtol_i()
Message-ID: <ZxZHFY4cXQ1lA4QU@pks.im>
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com>
 <a333d8a40134f4a06812fdbf85c2b011e9d3e472.1729259580.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a333d8a40134f4a06812fdbf85c2b011e9d3e472.1729259580.git.gitgitgadget@gmail.com>

On Fri, Oct 18, 2024 at 01:52:58PM +0000, Usman Akinyemi via GitGitGadget wrote:
> diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
> index c5f08b67996..c73c2196981 100755
> --- a/t/t5570-git-daemon.sh
> +++ b/t/t5570-git-daemon.sh
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>  
> -test_description='test fetching over git protocol'
> +test_description='test fetching over git protocol and daemon rejects invalid options'
>  GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  

Hum. I think the test description can stay as-is, as we don't typically
mention all the exact details of what we test in a test suite. But I
also don't mind this too much.

> @@ -8,6 +8,31 @@ TEST_PASSES_SANITIZE_LEAK=true
>  . ./test-lib.sh
>  
>  . "$TEST_DIRECTORY"/lib-git-daemon.sh
> +
> +test_expect_success 'daemon rejects invalid --init-timeout values' '
> +	for arg in "3a" "-3"
> +	do
> +		test_must_fail git daemon --init-timeout="$arg" 2>actual_error &&
> +		test_write_lines "fatal: invalid init-timeout '\''$arg'\'', expecting a non-negative integer" >expected &&

You can use ${SQ} instead of '\'', also for the other two tests.

Patrick

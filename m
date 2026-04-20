Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A183148C9
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 08:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776672709; cv=none; b=lW9qmt4jAs9EwD7KyZGO8XUdrx+yyATrs/F+rR62IS7NEZCRvfBt3LG9ZEZHawD5VIpn3IEJuWGHtg1FmmaX3tTYdc0uWSm+Pr50lmEG+hVcYpAN5pfOzEHdjHmevmCJy5RH6n5FSKRy6QctFc02QXp4zcqHZsQq/SKGyVgxMnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776672709; c=relaxed/simple;
	bh=yvavsz4dJVfOl+YCnCTx08ZHl1AsWQHrjTz5UpHl8GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LERo+zxqZ+7NVcPb7GRokmhEHGoyQA6Up6e2iV+IKsyKnE2JwzLK8bFpufRu51WeHQ7mznE2lMLqnx0zgA7a+hH3oRiuy8xfB2PNhRC7r77rRnSTLm8N82bmwVe/ZWfW+7aXinpMtST0qYZ0fxBrMP0yum2MeALOxbTkWgNEePs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SM0KVlKk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jjaEi7Zj; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SM0KVlKk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jjaEi7Zj"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 0C8EFEC011D;
	Mon, 20 Apr 2026 04:11:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 20 Apr 2026 04:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776672707; x=1776759107; bh=yvavsz4dJV
	fOl+YCnCTx08ZHl1AsWQHrjTz5UpHl8GA=; b=SM0KVlKkbZ9XAeneK+zzpgrW4K
	TNt9f5eNNz1WkXKyD6h2P6HDvf/5ZVvdEt85No1UP8QmsLZgEKeSxkCrf6CFfqRL
	WfN8aU7+2FWreeKIM8zLlXsZw0vahAi5W8C8OJ7SIWWJI15LdaJOnmYjQa+P8tZ/
	NxqCft/x6yN+xvRI15ibbPNq2zlnB7j2beVyerbFV3xjJUMv89egJ7E/h/HFUcj6
	UbHc9N30ZchZAVO7RfmqOvnZtZzgirrto/rKldwMel+1iPsmN/dU9W0CnY81Rm/I
	d8IO6o26AnvlsXxegvMySgJKAxQzTMbgbFZCGBR4tWU/+bUhywvUvPP1GHwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776672707; x=1776759107; bh=yvavsz4dJVfOl+YCnCTx08ZHl1AsWQHrjTz
	5UpHl8GA=; b=jjaEi7Zjre5SwABKLWl6slgz1Vwo5hpuzwJ+eq+XY/gGDLgwv1O
	r2D1u0oOk18oAtsvQQb/EEwOfvhGHfvJM8TrkR9sNajBJX3qG8Zto8ugGx87pSjB
	6gyn9hJxG4eBlMKDNz3WfIsvExg4rFBkxskaByS1qOB5duAyhy6vwi8uYQ/u25cr
	HKduLQ7gkGy4HkuxK6lfUgrYbHrlKJj9SgeFpuozFODbtOwZSE/hkuwyFUFu4i1p
	vB2/PwfICTDcYWi9kgsQ+Bsxm8gz0zcIZX7Du09ei7ru1VZRLd+j8OY2/dsQVQLT
	UjA2srLp6lBiHkCIeuo6oVk9A12rFnzEmZQ==
X-ME-Sender: <xms:wt_laVi17iodYiGhwEX-LAYwebHvQaQ2-uUl7wCD59yZhxDDxS-i1A>
    <xme:wt_laRAH357F6yZ2JCfXjbtkIRpIbAdC63ashWyU7Vdg3CDlkVgC0ysmKH3lWlmc0
    XKfYNMD07ldkzIZ7jv3ks8lls9PuNvmGtYqHS7buzX0Pm_PHpkG6L8>
X-ME-Received: <xmr:wt_laaFv-NVCwr4gTo7psrcbjaHdMfb3uHLpsZNN0S_oY-N5DQrvQACt_chVvCsHXxy7u9CEU2dqWZP7CywyMq3UDJTqqRqpdjWE2hFOdaS->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehkedtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:wt_laZI7nq6AWPb4ricaXT0uOKImEs3QS8EeYmwQUrzEXjbpcdrepg>
    <xmx:wt_laem-vbZIBdd2-omzW9z1QiMaCfwfLkpKf0vhCg0F3NLrbPF28g>
    <xmx:wt_laRTtsaMXqMwuyDua68Jzo7J0yH8zvSP5G-qmHswPM9T3A7T7uA>
    <xmx:wt_laQL9HPyLiD-YjCdyAVCFsQiIOE0CGQzylimOdROAa1KybnK_tQ>
    <xmx:w9_laRkJZlvfwRF3Ad7GaXqvIy-1JxDjln9cd67iTh4RCRGR-ZFEpNgj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 04:11:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 09ae263e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 08:11:44 +0000 (UTC)
Date: Mon, 20 Apr 2026 10:11:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 3/7] transport: rename negotiation_tips
Message-ID: <aeXfvO_aD5b-7f1z@pks.im>
References: <pull.2085.git.1775658970.gitgitgadget@gmail.com>
 <pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
 <0f89665aee679636d1c6ea801e54b2b53161d4df.1776266066.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f89665aee679636d1c6ea801e54b2b53161d4df.1776266066.git.gitgitgadget@gmail.com>

On Wed, Apr 15, 2026 at 03:14:22PM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 3bcb0c9686..4c3c5f2faa 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c

Don't we want to also rename the local `negotiation_tip` variable in
`cmd_fetch()`?

Patrick

Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC8020E708
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 12:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748865609; cv=none; b=SMknwVu24g9xl9Zr5BM1ieWgU1iYXHptdGuSYfbdhNQpEHCyBqm/gY//MxhZmGcP9z73JY4EgeRvoJge15pRzdxaP8W1wg6ffsQYWfg0DjvCVkO+zjKIJJS8D6kugL3N5/dVEZwsZUvrA57n6zixry7CQyjnsmvO7LL0+trEaLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748865609; c=relaxed/simple;
	bh=/kDWI7blL+CSzxCILm9qyfVBAlUfZHjRvGC+s7nyxT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kc6ulubU02Ee4PyNmQl29C8Es4H8fDos/EIv8lKt+l2BF0DNesIzlA/EhC9R3jDKRY38QwbrJ15LZ3fnXjIaWAF7QYFbQhH4HewYHG7pIwYDyYSqxs6+QUt9axP3Rm7m1vleKxehn9U8WFtDMPZmOC1dIs1iKzECOa6OzC7F+TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YbZMJPR6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SMr2ow5C; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YbZMJPR6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SMr2ow5C"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 748FA114019A;
	Mon,  2 Jun 2025 08:00:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 02 Jun 2025 08:00:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748865606; x=1748952006; bh=EQjgANqDm/
	zxNUIoJZe52cLrNCSz6Hj0y9OMevWNE7w=; b=YbZMJPR6OWyuWm1okWAMboA1b2
	ShKu5hLWYuO+0iS1E49L9g26Po5fVGAj0+5D2Ksup+cPJHbtVZQeEG8EVIFuFbYi
	GASmh5R9tLawR2wuHerKCXTPFykAMtNhb1R3xsu8VSGQQwWICASTRPPQLIGhjZ9W
	k41eqAc+Ype8mZfJyl7ie1jGqIYbsS1Hj8cOy5CtRwyJKQA6dDJSI6qI7BVWR/VG
	SeTThIzN5deq0ZhBxaskN6BGEE3kpTl/XtrEo7cXw3iuQZnTergDVYDg5wqz7YwC
	hnF2SKqcNK22RG7KeRt2rEijNCATczEM5rDk+LjWIGunj6Wy/Gh65R7eS/Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748865606; x=1748952006; bh=EQjgANqDm/zxNUIoJZe52cLrNCSz6Hj0y9O
	MevWNE7w=; b=SMr2ow5CSpL9j1DNrsW5q0n8OeKPzwWuOZ6cdfvfN/mtfzUI913
	oawzQkv5a3OyP1Oz/FnbL0E3Z0TgYWiWUfWThlzHel7C4DKzaLO2rl9zvO4YwVGE
	iaq3TfwGPpJeEC5i0xkQA+PIqqaM0OZcTXkeAD8RcIH3GSUbI76UywQWNyYSJ05f
	Yea4PbogqKaUFdi4NdlfSONb31wvKDjxiZ4DAlrpsn6VwLekFMcsHuO+O2Q85lbh
	h1jetrZQaFOCId+mVj1F/nXq7+MxqkLu8FaBN1FOI7HHZ4YLaOKhy+hd5TwiIoKK
	CvkfuKZLlZAKj5t8qClx/dtmqNKCzeBHdHw==
X-ME-Sender: <xms:RZI9aM7fFmVQs1zymlxOmDtoiiZ7Pl7biPCRc9oG9GrT0Io_6c86pA>
    <xme:RZI9aN56rtXJm0H39DxbgynTUjDg2KL4nIDcxkjYX3GvfmfpV5HRLGFL0lVHs0v-M
    fpDwAWUg1SjOvTm2Q>
X-ME-Received: <xmr:RZI9aLcctn2NZjYsvfx_rlydOZxwKHLpIlp_Ku0nOu4SSqH6OxEUeAhAuZN-q8yCbYdtbelHTcpdLh5sGCYR72dweMcZURTESjRZ0fxefPfsMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefjeeivdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrh
    guthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtledu
    iefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhstghooh
    hlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:RZI9aBIQ7pOtB9DqQ1iuNYoC59fT1KPpP5QCQdpVC9BLRoMELdb3jA>
    <xmx:RZI9aALIqIfnyjZDyqxtRnx4M5FlvkViPgzjVFwKQyAcvDlOrBbjog>
    <xmx:RZI9aCyRTQWJ70cSbIH5qBMN9iOFWr9O31F6Wx8fCS-YlBMXl7Z3cg>
    <xmx:RZI9aELpoWH_gWBrsNCgOsj2VNEGJ6XCXRR3kAZGPrVx95W7DnkG-A>
    <xmx:RpI9aDXoeO8tkVCgVxMykYzfKZ07qJcF0FB5h6tmscwR5zOKGP3wkW5c>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 08:00:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 75738cb1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 2 Jun 2025 12:00:02 +0000 (UTC)
Date: Mon, 2 Jun 2025 13:59:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/3] receive-pack: handle reference deletions separately
Message-ID: <aD2SPsro694yr60Z@pks.im>
References: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-0-903d1db3f10e@gmail.com>
 <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-3-903d1db3f10e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-3-903d1db3f10e@gmail.com>

On Mon, Jun 02, 2025 at 11:57:26AM +0200, Karthik Nayak wrote:
> In 9d2962a7c4 (receive-pack: use batched reference updates, 2025-05-19)
> we updated the 'git-receive-pack(1)' command to use batched reference
> updates. One edge case which was missed during this implementation was
> when a user pushes multiple branches such as:
> 
>   delete refs/heads/branch/conflict
>   create refs/heads/branch
> 
> Before using batched updates, the references would be applied
> sequentially and hence no conflicts would arise. With batched updates,
> while the first update applies, the second fails due to F/D conflict. A
> similar issue was present in 'git-fetch(1)' and was fixed by using
> separating out reference pruning into a separate transaction. Apply a
> similar mechanism for 'git-receive-pack(1)' and separate out reference
> deletions into its own batch.
> 
> Add a test to validate this behavior.

Okay. All of this is unfortunate as ideally the reference transaction
itself would know to resolve such conflicts. But we're no worse off than
before because we at most perform exactly two transactions now, whereas
before we would have performed _at least_ two transactions in this
conflicting case.

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  builtin/receive-pack.c           | 23 +++++++++++++++++++----
>  t/t1416-ref-transaction-hooks.sh |  2 ++
>  t/t5516-fetch-push.sh            | 17 +++++++++++++----
>  3 files changed, 34 insertions(+), 8 deletions(-)
> 
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 9e3cfb85cf..7157ced2a6 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1879,6 +1880,8 @@ static void execute_commands_non_atomic(struct command *commands,
>  	for (cmd = commands; cmd; cmd = cmd->next) {
>  		if (!should_process_cmd(cmd) || cmd->run_proc_receive)
>  			continue;
> +		if (only_deletions ^ is_null_oid(&cmd->new_oid))
> +			continue;
>  
>  		cmd->error_string = update(cmd, si);
>  	}

Fancy.

> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 029ef92d58..34eb3a5a07 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -744,8 +744,8 @@ test_expect_success 'pushing valid refs triggers post-receive and post-update ho
>  		EOF
>  
>  		cat >update.expect <<-EOF &&
> -		refs/heads/main $orgmain $newmain
>  		refs/heads/next $orgnext $newnext
> +		refs/heads/main $orgmain $newmain
>  		EOF
>  
>  		cat >post-receive.expect <<-EOF &&

Hm, so the ordering does change now as all deletes will now be listed
before the updates. We don't make any guarantees about how these are
sorted, but it makes me a bit uneasy to see this change. Can we avoid
this change in behaviour somehow?

Patrick

Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BFEB674
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 12:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742820412; cv=none; b=Z95QkeX4SYaj+IdneGXl9yzBbgmJ3DXg30OlHPUl8CyhvAefR+XJZjV37r5LfCvRjIyhqTFHJQC8zcoTGdUxCNwssTyEapdQnXVO+cMhYD2DZIfDSefnuFT/HfvWumV/mBrsXR8PHhmlC8rWB1sX0LhaGqa6xTp2UgEQYTRJgsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742820412; c=relaxed/simple;
	bh=d4tsXNJfhhUPGesclj8d3Vy/h4zRUMH+X/PjTzFd6gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzazFGx3WDd5NyrXl98wgWBtePAh9AuTA3zuiKU/b5nth7uuaQMZt8yxArDpgmg6kGaG1HNQqRW7OOU/zzecb9j2b5MdShffdRn2YSMQNkX/G9lLTzjlN7qm8A1SAKe6k0wlyVV+ZS3COTsvAE8B3L6gCNrRCgbJWVnBAeAkjbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EIqh+86E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q/7bb3lZ; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EIqh+86E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q/7bb3lZ"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BA45D2540189;
	Mon, 24 Mar 2025 08:46:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 24 Mar 2025 08:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1742820409;
	 x=1742906809; bh=cqOo8Vqw+zixyGyrGFJg98hDhwdd1AEQOfReoIPHj7s=; b=
	EIqh+86EdqeBRCTEKkg82P2rOp7fP5Fzx/nuX2TBzSwQT0jwqC2MegPZ4JZeEaR3
	vvFm7pEKxc269edHPnmqFbdx1l4KlbTLt1avyGQzbeXMeJm/a7lKLKcjICjycwDs
	K8ZuFyaZW8a5kLvOmhR8ocusuhew82GFVweAmCFsFfLPDWIDSRZgusn8wQY8jE5W
	xF6Ezjw8AHy8gkAykOsI7ZdVSSXmv6hvPbe/cJOc0BJVQoCKpBjUVcQ6wb3L68DO
	/o/yEuhFJxVkQlSsgQ+Gzxpyp6zNI0fHjrpFMqTu1z4EbzuRePtRaCE9T+z0kQGx
	Gn9iN2h1FpdNinyob5xdbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742820409; x=
	1742906809; bh=cqOo8Vqw+zixyGyrGFJg98hDhwdd1AEQOfReoIPHj7s=; b=Q
	/7bb3lZCg+AQWxD107EB0SeGpBvITD7JgEYSvzhv36EoDBtyWAiTa8j4A3i+mK4E
	B+EnNu/XztmmAGjDhi82cDcDhvcdhAJ7aRgVJF6OJLF3hnredkG4iF497c9WvGc8
	FTn8idjYQSl/RVijPIdbfSNYHRTqFxq5fh0VxxxGHy1kGgIBT9VWeRVNk4K3RJtk
	kUUiF7ydnoP5BJSPPevAy097Ttq6yoZAk4t64kA5ERW0p2LOJ76In185dSqc1Bws
	Kyd9x78FpRvRK0bDbrPX/bN7LRg5XsQ+G47zc4/NSuJPO6xLycbCHVPN876GFd7b
	Q16RFGucZe7TEX3e3hqxw==
X-ME-Sender: <xms:OVThZwaYwsWjFW_HO8SQTCrZX6gSmG7F86MDtenCxqG55MMZYwFIww>
    <xme:OVThZ7Y67qntAG4YxyoI6TJzl7-Ze6JJSZowjCmuUMnZR9i5CSidHXBtIaqjxZx-k
    A3JQmrCbfouTVtA6A>
X-ME-Received: <xmr:OVThZ6_bVk6ZRqMUIFgetgLCOqk3Cwd7JymymdH9zihFpGdXqGQREgMrMEnIRbFmz1b3MpNmZWgKvUgq7y2ktXB7ooWs0lFBoTDywvL0A0laRFM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheelkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtg
    hordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:OVThZ6ovkvCoT4ODJ6DxMDL3xQcmj-WEG_LxJUxZhgYulFwmryNkQg>
    <xmx:OVThZ7rLDF4eXFTm9hYO8PRMasGb_twh82JIkqmRTnX_BVKcsSkEew>
    <xmx:OVThZ4R22iYZzdDhqAcdOFDsq-2BCYZmbPtHskP14aL47GDq8eWFIg>
    <xmx:OVThZ7qfzP2BrbiqBka1-7MDtQW_Sc_tpQ_0gZsL035c6iqVRxdgiw>
    <xmx:OVThZ6WogbRw09CHw2B3bgLjVougm1w6ZZQueYbfJt1v8PG85YhGc1t9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 08:46:48 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c550d963 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 24 Mar 2025 12:46:47 +0000 (UTC)
Date: Mon, 24 Mar 2025 13:46:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 12/20] t: refactor tests depending on Perl to print data
Message-ID: <Z-FUNgmY9hTsnzds@pks.im>
References: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
 <20250320-b4-pks-t-perlless-v1-12-b1eefe27ac55@pks.im>
 <CAPig+cSC3zdur1fCsa7RMNZDcgUK4pUGKb22tpgdANxR6OxNMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cSC3zdur1fCsa7RMNZDcgUK4pUGKb22tpgdANxR6OxNMA@mail.gmail.com>

On Thu, Mar 20, 2025 at 03:33:44PM -0400, Eric Sunshine wrote:
> On Thu, Mar 20, 2025 at 5:36 AM Patrick Steinhardt <ps@pks.im> wrote:
> > A bunch of tests rely on Perl to print data in various different ways.
> > These usages fall into the following categories:
> >
> >   - Print data conditionally by matching patterns. These usecases can be
> >     converted to use awk(1) rather easily.
> >
> >   - Print data repeatedly. These usecases can typically be converted to
> >     use a combination of `test-tool genzeros` and sed(1).
> >
> >   - Print data in reverse. These usecases can be converted to use
> >     awk(1).
> >
> > Refactor the tests accordingly so that we can drop a couple of
> > PERL_TEST_HELPERS prerequisites.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> > diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
> > @@ -643,12 +643,11 @@ test_expect_success 'basic: commit and list refs' '
> > -test_expect_success PERL_TEST_HELPERS 'basic: can write large commit message' '
> > +test_expect_success 'basic: can write large commit message' '
> >         test_when_finished "rm -rf repo" &&
> >         git init repo &&
> > -       perl -e "
> > -               print \"this is a long commit message\" x 50000
> > -       " >commit-msg &&
> > +
> > +       awk "BEGIN { for (i = 0; i < 50000; i++) print \"this is a long commit message\" }" >commit-msg &&
> >         git -C repo commit --allow-empty --file=../commit-msg
> >  '
> 
> The original Perl version emitted the entire message as a single-line,
> whereas the awk replacement emits 50,000 lines. Was the intent of the
> original specifically to check whether it handled an extremely long
> line correctly, or was it merely checking whether an overall very
> lengthy content was handled correctly? If the former, then this
> semantic change is inconsistent with what this test wants to be
> checking; if the latter, then this semantic change is harmless.

It really only wants to check for a big message, the exact format does
not matter at all. So in theory, we could even adapt this to use
`test-tool genzeros | tr "\000" "a"` or something like that, but I
didn't want to argue why that change is okay. The fact that we now have
a newline was unintentional.

> Also, it is possible to do this entirely in shell without running an
> external program (assuming `test` and `printf` are builtins):
> 
>   i=0 &&
>   while test $i -lt 50000
>   do
>     echo "this is a long commit message" &&
>     i=$(($i+1)) ||
>     return 1
>   done &&

True, but it's significantly slower. We already use awk in many places,
so we can just as well use it here. I'll adapt the refactoring to drop
the newlines.

Patrick

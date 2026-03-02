Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE98E37E670
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 21:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772487152; cv=none; b=AHbNh/aUSSX9bVU6hFDTvox2LtiJneDMHE7H6xmuDUzM2p0Qu6g6+MCIjtzwCqxPO64rEBaa8W2QiAfXLGCUPEMni3OMAon/fqT/dQ3qk+HxvgKLxKLjzwnhTllD1R3XjQbV4bYvrOJqDxwslMzESEWzc7iS+AhUHrPzLVtQXjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772487152; c=relaxed/simple;
	bh=RXwThcoQTEkcFVbpMT2qtDrOecyeXahUZ4aqC+TV8Nw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tyxzaGdVoKTmO9vuliGeb2uhtCiYFXFvJqCzDxIYaggvy21JNuDg08qoRi0sxFV02kJ7HTUqiR865BwxVKQdankjIouNpn7Fr+kXRO4fL/f+PbUTPK1WaksXCTS8YjPz2abZ3QCOmIEOrxddKOPhks1UQp0F0/CbZlRChqsJHlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J8/UYnNv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LQ84nIEm; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J8/UYnNv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LQ84nIEm"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id EEE45EC0308;
	Mon,  2 Mar 2026 16:32:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 02 Mar 2026 16:32:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772487150; x=1772573550; bh=UinyRgVhru
	NFvYG7PnMNeOutsfJcfp2w4xlkAdqUO6o=; b=J8/UYnNv8Cv1/Dhb5IWFD4qBTO
	L/tFLO/uSfLNl3m1JRSvtcexQSHVFSra3rhGQUYLFuDcyaQA7Ql8pTey7iPwc6vA
	dsAXdtj3225QRQHJCpoW/JnB2CW5pK1L1C8zNSN1f8ekY3ca9SftEcQLn+CNXLdG
	pwU7UQQm4xhJPWq4ZcsGNdavgAYMy70PEDjB/6DAO7ff99bVXt1kQBu3IF6vM/SM
	BS/BFeDB5dPTXcTMS4PAaKQbjGFnzrXiJc00giq5Cb+xpPX+WuppbxTXQVxBP+oW
	Sgzsu6JrSnJqfQxgZuV4fTSbADWzZr5qHSK6qy6/oDLslNUAfGG4Db8NmZvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772487150; x=1772573550; bh=UinyRgVhruNFvYG7PnMNeOutsfJcfp2w4xl
	kAdqUO6o=; b=LQ84nIEmqPdf5Fsf5/gJZQwZfAY9ZjAiHpjJi+V7Cy31fnR6OO+
	nM0Kg5zzZ9PJAg4ZV8VYuYJJwvLqidRFv7ujjaow/RUKwjHQ/Q7HAXS0EzyERqg/
	c0NGUe1X0Vt+szAbkQR0oVLFJ22xR9M3TPh/9Vqu5kUXZar0pDXaXlTuRIg5u5OX
	L+aVXcI0uZChJkkVOmfvkn4Ef06z+QGq41J0v3XOG9WRvjlPBFMGDhP4O9F8Mh+R
	dr83f9b4kR+Zbdc96Y0rbicf8Oo+fd2i0th24LESvlqqOF0dM5fcG5lqV8brKYjm
	tuHdTLQ+3TUe1pe4K9QtSJi2vjLGQA5mAGw==
X-ME-Sender: <xms:7gGmabLYZ9DEK9ly3mHLbXcftjkHudx7S5UxI-KuT_jeXVqO4E1u1w>
    <xme:7gGmaRsQs1tffv2JlEFkFgJEO8ZoWHibU8R_Y83J7q57c6meyHYmRgRr8rCJTvp4x
    CxhYMHIYKIL0PDb6KBkIRstiPHUKOBVLh4lTSmRUO_TFG0gVQbdEQ>
X-ME-Received: <xmr:7gGmaXXyt7W4viv2dE_ZGgQ0tn3c33E2Q2wVQgXD898FeOvB88Kwwcp7oJUmecxpOXAHd7xTI2eGmThxBG4BAHTuGA82Dk1L6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtghhithhgrggughgv
    thesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepfhgrshhttggrthesghhmrghilhdrtghomhdprhgtphhtthho
    pehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepphhsse
    hpkhhsrdhimhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:7gGmaUgPkKpe8nY9BH9ekB1x3yIfG-y-S-nG3VRG4eQAUybIgvcfww>
    <xmx:7gGmaXph8RQGkWGWZdzqfKkXloQVfWM6RUuTVDBfnY4701px1ykc7Q>
    <xmx:7gGmaSHTc4J5yP4JSifDwpquEKJAFNVE8KpRqlsnveVhvYB9e3u-8g>
    <xmx:7gGmaU6Hc6RpUq3rhAuTd9p2SqvlhAOhMGow0mhO2N__NwCFYEeTPw>
    <xmx:7gGmaTfrT6w8ZI2H6Z2qKitGbWbwJQyJ1NxVLJxCA6UACwACqKhy9XCj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 16:32:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Jeff King <peff@peff.net>,  Derrick Stolee via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  fastcat@gmail.com,  Eric
 Sunshine <sunshine@sunshineco.com>,  Patrick Steinhardt <ps@pks.im>,
  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 3/4] for-each-repo: work correctly in a worktree
In-Reply-To: <15eb8691-a55d-4edc-94fe-ac8a4b37b90c@gmail.com> (Derrick
	Stolee's message of "Mon, 2 Mar 2026 13:39:16 -0500")
References: <pull.2056.v2.git.1771968924.gitgitgadget@gmail.com>
	<pull.2056.v3.git.1772465805.gitgitgadget@gmail.com>
	<2a6091095f120426fed554a08871f2b4dcd15282.1772465805.git.gitgitgadget@gmail.com>
	<20260302180601.GD28275@coredump.intra.peff.net>
	<15eb8691-a55d-4edc-94fe-ac8a4b37b90c@gmail.com>
Date: Mon, 02 Mar 2026 13:32:28 -0800
Message-ID: <xmqqcy1lzzmb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 3/2/2026 1:06 PM, Jeff King wrote:
>> On Mon, Mar 02, 2026 at 03:36:44PM +0000, Derrick Stolee via GitGitGadget wrote:
>> 
>>> @@ -15,10 +16,11 @@ static const char * const for_each_repo_usage[] = {
>>>  
>>>  static int run_command_on_repo(const char *path, int argc, const char ** argv)
>>>  {
>>> -	int i;
>>>  	struct child_process child = CHILD_PROCESS_INIT;
>>>  	char *abspath = interpolate_path(path, 0);
>>>  
>>> +	clear_local_repo_env(&child.env);
>>> +
>>>  	child.git_cmd = 1;
>>>  	strvec_pushl(&child.args, "-C", abspath, NULL);
>> 
>> The second part of the hunk here is as expected, but the first one looks
>> wrong. We didn't remove any references to "i", so either it was
>> redundant to start with (and the compiler should have complained), or
>> now we've broken compilation.
>
> You are correct. I did a --fixup here and it messed up the diff. I should
> have double-checked the commit-by-commit compilation and testing post-
> rebase.
>
>> Looks like the latter, but we recover when we switch to using pushv in
>> patch 4. So I think the declaration of "i" should move to that patch.
>
> Can do. Looks like a small v4 update _is_ required.

I could do this too ;-) but I probably won't get to queuing this
topic before you update on your own, I suspect, so ...

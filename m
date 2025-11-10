Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C6A2DC331
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 17:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762796296; cv=none; b=K2xzuOgmueZTir+mxVAyiOM/KgHrRJLxzIoma6pBTa+UjGNlfO04ZVIoQ/ySjrbBQuUHbc/xQ7UXFrNRgahWhJZcHCEZIj7akEMKf5KLGCW1jBJJJG7+7ZHpsZXu3+Q9Ay+4L/gAD7qqQxm7YrdP2DM8Lw0IWtidLMFLFWrnSQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762796296; c=relaxed/simple;
	bh=t4e7LxtzrlA7PR5rGc7aHjyYgYg/iklyl4Nx1nmPH3c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BDmknqp3CXCUr9B3HtuoSmOsaPI+CFFwQO7rhVIUjonYBPnFJJalNQrvdUauZ2Qjb5YXrBIyz6aOtUWbLt/fhwngUi1c9yLZa7WIa7TMiEqtQG43ZfyO1WsccIGjE+XP4fJDjw/LAXwhiCOf1xTa3gg21djAs+6VHpe218YGyZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PLLSjvGm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F9Ye6TXc; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PLLSjvGm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F9Ye6TXc"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D82AA14001F5;
	Mon, 10 Nov 2025 12:38:11 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 10 Nov 2025 12:38:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762796291; x=1762882691; bh=2V9bcGhLXt
	AOyncuESnQmw6L4w9wRa8A10VfJhjLc/M=; b=PLLSjvGmNJOiomeI4m00X5aqi0
	IudHJsVvsDR1xUe/LzZwM/kxrCugNXPib/ThlYP00K3FaS68t/LXmYh4e2MtOdti
	uvZZBiIsAAY/qWJnLHpD9nTEbGj9gpQhsD1i75aG3l/lP+XaA9plP26nROcqKmup
	QtazTFoySkNExj7W0sXYqpXECtgj3kctcM3qgP1ms46xBc3WQnNJhR/ED1HMXac1
	0CaSIc4+/V+yP6jHBo040PCIGvRXvno7Bjr0pTtaooBXfIU2gimOlyE7Jx+50bUI
	bZGEyxS3rC8s5Df0QG6DeKoiyabd2rE89j57UkKSpGjxU5xwMAG8BGyHAS6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762796291; x=1762882691; bh=2V9bcGhLXtAOyncuESnQmw6L4w9wRa8A10V
	fJhjLc/M=; b=F9Ye6TXcu1gy61SDU5iz5iaZdHhWTVFsYZN+4oTgu7Rk6OgfP4N
	c1Ms/UX6W+uaxw9t3JcIawW/wBcbVr5HweP878yTWMpc/tXKMbFMeaB1l192hV1F
	XnztrISt8I46KCKZv2YI59sLtkOP12rpWVbp4OdwqMFG/Q0Otns4SG2mR+/j/NPQ
	VtrSnNkX42sdIqsMI0UldC6xWJe2+oNLzXbSc58xJQmj5KXJgbp9+ULnNR4OLMvu
	A1fAZ30+hPXcyjGCat1s5JgxfCOiMY4zSBsht7WJXTNryP6Ia2sbv7PA7sA6yJQv
	igFp1tZtNJwziem+XPA0u33Q3PRk5rMkD2w==
X-ME-Sender: <xms:AyMSaXWYXqQvgPVzuJWuAcf-OBkhiJXfI2svYdg5JLq6b2LghJNzvQ>
    <xme:AyMSaTRJjfKbOG-SyYL9voVVT4gUXWS4hzsKSAoJnKC3SXkD6JnlcwVwgkocaRjcQ
    D3C9SbQgWveBs8TVp0Id1K-d2qpsD6NZ1L_u0L15tYOT1oWRzUt>
X-ME-Received: <xmr:AyMSadM9oBIN_UsZaGee2N1aWrGj0mxeKlGhpZYVzWf5mrNi8swAdqC8pRN31kGPNYLV9PNHMUCBObTV4z7s3YWfuKvYpt18yGy5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleekleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtgh
    hithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtph
    htthhopegrughlthgvrhhnrghtihhvvgesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:AyMSaZRUN8Ja-_TFX84c_wQMMWcguM9J0HrQxozISJqrzS_IYf5rnQ>
    <xmx:AyMSaTjKcR5EK830zLgnHmlbqmg_Ru2hAfjfEzaKywHgTCJW2vkL8g>
    <xmx:AyMSaa-I8byFml9kiYsKIHCxE2uYFUGx3VXI3CHcfVNYKfo8qhkJDA>
    <xmx:AyMSaSHjAEWCci-rGel1jGpFqv6Koy3PA0mnLhuy-Fe5gYdIQcuopQ>
    <xmx:AyMSaaGjYXZdkIQAtBSQIAosEeNzH53rOy2WqAieiEBeWJ4TscPbBu_Z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 12:38:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Jeff King <peff@peff.net>,  ZheNing Hu
 <adlternative@gmail.com>
Subject: Re: [PATCH] commit: add --committer option
In-Reply-To: <aRGvVwRcsJA9CD9c@pks.im> (Patrick Steinhardt's message of "Mon,
	10 Nov 2025 10:24:39 +0100")
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
	<aRGvVwRcsJA9CD9c@pks.im>
Date: Mon, 10 Nov 2025 09:38:09 -0800
Message-ID: <xmqq7bvx3i0u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Sun, Nov 09, 2025 at 10:22:54AM +0000, ZheNing Hu via GitGitGadget wrote:
>> From: ZheNing Hu <adlternative@gmail.com>
>> 
>> Add --committer option to git-commit, allowing users to override the
>> committer identity similar to how --author works. This provides a more
>> convenient alternative to setting GIT_COMMITTER_* environment variables.
>
> Yeah, I can see how that's useful.

Well, I don't.  Naming somebody other than yourself as the author
may be something that is needed from time to time by human users,
but lying about the committer who made commits?  Our tradition is to
give long rope to let users hang themselves, but we already have the
environment variable override specifically designed for scripted uses,
where there may be very legit uses of recording arbitrary committer
identity that has nothing to do with the identity the current user
who is running the Git processes usually uses.  I do not think it is
a "useful" change to make it more it ergonomic to perform certain
operations that we may not want to encourage.

So I dunno.



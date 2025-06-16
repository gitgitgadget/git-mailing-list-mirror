Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D0B7262B
	for <git@vger.kernel.org>; Mon, 16 Jun 2025 04:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750047325; cv=none; b=aVjZaulpNj+uHZPpJKh+WacyKNOqUzoGPbtSZHJrgtrF0tBvk3gC9erZn0CFJfOcMHuCCtaeblcCOxByqmPLkGou4j6HdfwuosP/SWKS5d/7yrVIegMwRWFsa98dkTxq/Y21YmZQo4ig7zgjonoyhHQ9sL4/6+3Ry0lcP+VAaPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750047325; c=relaxed/simple;
	bh=Fh80Bcsj8ijT7ospZesxUlh+V9EFjlr0F1bwdfXp5Tk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kBNEBR18qwKYENwH47qTjHHYArakfds7M1AXLQ0ysfpvs6pzat75VGOx2m7G8ZxnhLnbaBZPxgp50YAnMzFnmyecsUikz4zhIHzPkc9MYFHZz53gamH/UTUNKV8+q123u0a+RmHbIDi9mCdyH8gr2JuRkY+fMzBcabssFZLzbBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=a7PkWEpf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y4J2jWXs; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="a7PkWEpf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y4J2jWXs"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D6FAF11401C5;
	Mon, 16 Jun 2025 00:15:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 16 Jun 2025 00:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1750047321;
	 x=1750133721; bh=cT7KmOrRCfrDc5AyYhcTf+z4HvgzcworcZqKdMMLfU4=; b=
	a7PkWEpf4CijsVh2n8ogush2SOTW1VGEooJvEnfrIdk5jr9/J4LjgvxgeKjowvUg
	stmK5zBE3ryVv7p98uLPsTFeoj0qmczh3eeLi939wy3VuShtUe7Xvt4xNTi2a/4J
	wyRb7Av3PcBrP7IBke8N9/L3nymgbqpHfe/u6S/9XBs3JGx23CJrD+E0oucgB6iZ
	OzQORWQGriplnjFNLVp/hk5LmOgo7Bxl0PoMgoWKklKMurt5fRcDMirSn22EqxKB
	jKJ/gMDofWq5b7Qr/YxOwd2idC0l6uJXSEh24wVK5GztZMOU+KBxW6DMGpfnmxiM
	Ur45/pW/CrU0gRl4OKP9bQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750047321; x=
	1750133721; bh=cT7KmOrRCfrDc5AyYhcTf+z4HvgzcworcZqKdMMLfU4=; b=Y
	4J2jWXsYSrOpjy42urNdJrRRC81JEt1wC3MzLq5+hfnog61ZK9lPY5bNNVgdfwaU
	OwwsSBg2FBScn+sRvIZXaINShc/SVx/lxc2L6C6AQskeNpqgTv3I0akh8o/J6Bwh
	azd8HBPMbMWpmjB9B4A1mYrbimUIyaaeWePfrjMapnkZOC8lW/tJENeozNOt+lpZ
	zBypRXNcqqrvA4KNfEwb6oZuYZXA7OOLxuLUUEfew34Zt3ThQJzB914sKIJPpWz5
	N7GzRjcGPiQBGeKSCN3rtWQS1jV8iBWRHg1Lzp9ygk1EkfPTrgM2chexnJbmRIHq
	GGHiNVuxdju7QOGPqwZfw==
X-ME-Sender: <xms:WZpPaL5GeR9mdfVFS1L3TEqCTbnFToY6cuipc45dHZEgI8HJ9h0Q4g>
    <xme:WZpPaA7vT5_RCGfc0DkHU5HbfSfZV-7I6PQSVy2JWs6gJdxZpRCAjLIv6xpaT8DmP
    2r18CPYWBu_1BnHNA>
X-ME-Received: <xmr:WZpPaCe1FyLLwgzkWX3gs5Bn4gtQXlEAKkT2DuCGstLAN-bRvdcyrBwqBh93MT_rQ6ahTInKFK9jMbVVrAAkDUs7IqVLY9FA-KF2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvheehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinh
    gvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehrohgumhhitghhvghlrghs
    shhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehitggrshgvlhhlihesuhhsphdrsghrpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:WZpPaMKXsOd7hfWcf5RynzqIsrpurJ3iGs3Wxr24IIb_ladambl7mw>
    <xmx:WZpPaPKtpK0K6FsDjS7GE5O1PJ8hWZUpXvf5fHZePqj_nQPoBPWxDA>
    <xmx:WZpPaFwYZJuOOv0zwYMRYOKXrnI4w8SjFjJ6HVJD31G2Nzx9Z0x1JA>
    <xmx:WZpPaLKY7sYWO1piz6Q_j0KsmXzX5-oK2nOFGYtlVF1KEvw4a5AkGw>
    <xmx:WZpPaPrjK-4-KpJy0FZEo5CcAYK3LwEJygaYP4j0EgCyLDCyw7ncmvGw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Jun 2025 00:15:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Rodrigo Michelassi <rodmichelassi@gmail.com>,  git@vger.kernel.org,
  icaselli@usp.br
Subject: Re: [PATCH] replace 'test -[efd]' with
 'test_path_is_[file,dir,executable]'
In-Reply-To: <CAPig+cT1VfY8QiUvrrV3-obTBP1439b6iwaebJtGwML5MScnQA@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 15 Jun 2025 23:39:56 -0400")
References: <20250616020827.10820-1-rodmichelassi@gmail.com>
	<CAPig+cT1VfY8QiUvrrV3-obTBP1439b6iwaebJtGwML5MScnQA@mail.gmail.com>
Date: Sun, 15 Jun 2025 21:15:19 -0700
Message-ID: <xmqq1prk490o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Eric Sunshine <sunshine@sunshineco.com> writes:

> Thanks for the patch. See below for some comments...
>
> On Sun, Jun 15, 2025 at 10:08 PM Rodrigo Michelassi
> <rodmichelassi@gmail.com> wrote:
>> From: rodrigocmichelassi <rodmichelassi@gmail.com>
>
> The From: header name/address should match your Signed-off-by:
> trailer, so you'll probably need to adjust your mailer settings.

This is an in-body header most likely added by git-send-email, so
the name string is what the commit object recorded as its author.
What needs to be adjusted is not the mailer settings, but user.name,
if that is indeed the case.

>> replace 'test -[efd]' with 'test_path_is_[file,dir,executable]'
>
> Let's prefix the subject with the area you're touching. In this case,
> the test number would be appropriate, so:
>
>     t2400: replace 'test -[efd]' with test_path_* calls

Excellent.

>> 'test_path_is_file', 'test_path_is_dir' and 'test_file_is_executable' are modern path checking methods in Git's development. Replace the basic shell commands 'test -f', 'test -d' and 'test -e', respectively, with this approach
>
> A better way to convince reviewers that this is a good idea is to
> explain why these functions are superior. In this case, it's because
> they emit useful diagnostic information when they detect a failing
> condition, whereas `test` itself does not.
>
> Please wrap the commit message at about the 72-column mark.

Good.

>> Signed-off-by: Rodrigo Michelassi <rodmichelassi@gmail.com>
>>
>> Co-authored-by: Isabella Caselli <icaselli@usp.br>
>> Signed-off-by: Isabella Caselli <icaselli@usp.br>
>
> You'll probably want to order these trailers like this:
>
>     Co-authored-by: Isabella Caselli <icaselli@usp.br>
>     Signed-off-by: Isabella Caselli <icaselli@usp.br>
>     Signed-off-by: Rodrigo Michelassi <rodmichelassi@gmail.com>

Very true.  And without a blank line in between.

I too spotted the misuse of negation in the test script you spotted.
Thanks for explaining why they are bad and what should be used
instead.


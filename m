Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED5B3C2D
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 22:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785710771; cv=none; b=qesAZ+aDuYgFBnpsAZE9KL6L3U8xci+DsADVMLIzURuA+u1axARRdpKpe5683SzFjO+VnFC45k2+XqT2sDH81Nv2cYjbUdIcOwOoCg5Gox2rOa6zkIK1iASU44fKM7sn50MmlZkipIfpenOhuXHos1MeKMppIrEay2JKEE0Zo4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785710771; c=relaxed/simple;
	bh=VBgHq14MjmZWbrn4ZcHC0Rr4evI4OWd+KBpGs1vrOVg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wrmuh3Z4PODwhLEcjiVDvSHKedm2QBTNhUj/j4/Od9JaE05jKQ+VxrRotOVttgPOr4KIFtHYzro/vp9dGg+h/q4Fa2s5tOUqa34TiVZ8WW5JiecMHrEFewha02mTbJl1JUBP0ChqjLdA3/iQQN2cELAuHiNqG52EGeRYwZ3nyLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VRtI1B7c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lv7lEq09; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VRtI1B7c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lv7lEq09"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 4D64F1D0006E;
	Sun,  2 Aug 2026 18:46:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sun, 02 Aug 2026 18:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785710769;
	 x=1785797169; bh=Vmo0K8WXZwRChch71VZv0ytvZfztEVChx9owme7S7xk=; b=
	VRtI1B7cjUcSDlFK+yW1F4fyrMpfk71tenQM5cl5+ltbjmiQkAeXPXLDCs/9jFHL
	a3eOejtO1Ouw718+5BJ3XIAJBtTcBuOQkKUIyXU45jfgYvw3zRkzFJ0oBDnihu2X
	ZWpGvvkfDiaSTPpAE/kwW7V73iVjH7rhqBgP4f/EsDT8Bf6M2yQXXmoQFnqvcp4e
	4JVFsD8hxXYMiP1L/Jupt/XGDjr8d/M2VM8+0NQWHBJVeDBDeumnAHChZKkgX5oi
	F1yswYG6mUa+eiqa+CxxuZq6w3FEFHRg26ncpd9B/Zl3yO0BVGLLqvnE4VDnH0x2
	d+a960XWhZZtYiyFdBeWPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785710769; x=
	1785797169; bh=Vmo0K8WXZwRChch71VZv0ytvZfztEVChx9owme7S7xk=; b=l
	v7lEq09TeuIZN5p0Ak92xTyCXOmY+sxN10wXTRdJyXVjg9A6YP2NGgXIUU/Y4N2w
	fYpT39JSwAN7UNET/0K+qtLRodCv5Y4JfHVHgYN9asbvsdOzpWlYjesA4ggysfIo
	DIlj11jqEMl3FcjJWmh+bCM1KBKnxSeMUi0wQMfB0GX+ktARq6Ut3ZVaMTkSDjwO
	Zbx6r6GjWqcGDV2iOUTCacWfoYoAtjkHofTNXsDHJGSJHmhgiwGRN/A/2IxW1U1f
	gsefup6RuKi5ZeSzvMCwnkE8nQ1nU/94KQBf4AAjSDdOgLsVZc0fkxdiD3PA/RTE
	Ij/KH9iEnVU+h3RcK3A0Q==
X-ME-Sender: <xms:sMhvavNzJVi-MG3oYDc7-7NIDkZTwP87jkg99jOU_YO_23X0xRC0lw>
    <xme:sMhvapCri1rgokPtUF_cVEcfpjH8Wrcj4jRm5b4gAo_GzDfc9qGMYicA9K98c-i92
    gQHPDfvBuBOXIS5c3zEY6UUHZR67Aon-VgYoh7_WneAfNmNCcA>
X-ME-Received: <xmr:sMhvakcq6KUbz6rhgO0NGzK24tHqx1b3LieLMla5lOehxH9t8QpgNeURIBwcB-68BtzfrdtdRgQwJbAH3Ltp7NXjH5TQsxQ7kw>
X-ME-Proxy-Cause: dmFkZTE0/8N/RQApliEAOVqhVEPu8VKqI+/CfmtXV9pJkT1LyexMjJpTp+cGM7bIs3N5B5
    eeQ8q0hatZ3LrnGFwl1YL3nv0zMJ06QtcTauWe6wOns0sz1oAi2JIW0DBgwRcD7JHCSGxs
    tqCUMa1qDnOcK3TQLcTSOdtLBdsFPVG+QO4v1NRYQ0ufVBJ6LLxC8pMVvRgzBuucqag4vA
    YMMb2R2VAvIO0PHJ1CN6WpQ3pWud5EHCbshCd1EKnD9w4Ki9pL/OQ8gNxuu2jMxkZTvHoF
    UiARL6qD1+ciSCDn8irtkCZQgY67bzKMAJm43bygzFlWz326/JivmzMpEDoiXowk/e94mB
    IFG4zFrPXU/Z0GDFhtD85KJuU/zjuMqxyOBvi3Zzg6UyC131VP0vLhs3Px4boFkKnCNuDR
    ZXquYHzdTgRwYilqcXMl0ZEskAyZ4ugQB0G8klnVl/WlzimdP0h+0Pth2k9bybpQC0NbTE
    GQS9SRLtye6sTUWtcE/k7sE5CkRnYRvpVlfvGz/qiG82UOvo5LKbaLDTwYAFR7mm+EIMEk
    C6MKkxV4ddg8xHzLaK04oF5VPrghBOTIxhdOYOMSJVip95u9kGk8qcUo0odlNGuTpMVtIm
    TvHIh4Xh9Yv9MMuBSj2LS9kPgy01XsePtepiiQRNd5XMGeb3YlMVj2Vjg9cQ
X-ME-Proxy: <xmx:sMhvagPoMjov1hx_Cuu3YoOax2K5J8DTqsNf7Q_KmNV4J6ohn6CTSw>
    <xmx:sMhvasIJIikvF3Kd4WwPxkkRQ73EeSUgNXTBmicaqn21YC2YHUVEbg>
    <xmx:sMhvaoJx0jOEdfnJquMJUUR7PlgGY9Z7uwhC4RW7kkcBsTN31zWNrQ>
    <xmx:sMhvau5wMAUTyUfJk6eykkaA1dbCVQ5WGCMJqz47srMoLHoohtJvRg>
    <xmx:schvagLFvZeqx-4Bk0OiQdHv-lLhlSZf5_uxZYO13bqD9rtTOBwBuB2E>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Aug 2026 18:46:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Arijit Banerjee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Jonathan Tan <jonathantanmy@fastmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Arijit Banerjee <arijit91@gmail.com>,  Arijit
 Banerjee <arijit@effectiveailabs.com>
Subject: Re: [PATCH] index-pack: speed up promisor link recording
In-Reply-To: <am-7_wSb-GNefKlB@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Sun, 2 Aug 2026 21:51:59 +0000")
References: <pull.2191.git.1785706396130.gitgitgadget@gmail.com>
	<am-7_wSb-GNefKlB@fruit.crustytoothpaste.net>
Date: Sun, 02 Aug 2026 15:46:07 -0700
Message-ID: <xmqqcxw02lao.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>>     index-pack: speed up promisor link recording
>> 
>>     AI assistance: OpenAI Codex was used to identify the bottleneck and
>>     assist with the implementation, testing, and benchmark analysis. I
>>     reviewed the resulting change and take responsibility for this
>>     submission.
>
> I don't think SubmittingPatches really allows more than trivial changes
> written by AI:
>
>     The Developer's Certificate of Origin requires contributors to certify
>     that they know the origin of their contributions to the project and
>     that they have the right to submit it under the project's license.
>     It's not yet clear that this can be legally satisfied when submitting
>     significant amount of content that has been generated by AI tools.
>
>     [...]
>
>     To avoid these issues, we will reject anything that looks AI
>     generated, that sounds overly formal or bloated, that looks like AI
>     slop, that looks good on the surface but makes no sense, or that
>     senders don’t understand or cannot explain.
>
> This doesn't look like it's a trivial change, so I don't believe this
> patch can be accepted.

The project we borrowed DCO from has this to say on this topic:

 https://docs.kernel.org/process/coding-assistants.html

 * All contributions must comply with licensing reuqirements.
 * Only humans can attest DCO by Siging off their patches.

   The human submitter is responsible for reviewing all AI generated
   code, ensuring compliance with licensing requirements, certify
   DCO with their sign-off, and taking full responsibility for the
   contribution.

Now we are *not* kernel, but I think there is a general concensus in
the community that, while we do not want to outright ban machine
assisted contributions, we generally want to tread very carefully,
especially in the DCO area.

It is very easy for anybody and their dog to say "I reviewed X" and
it is very hard for others to assess how trustworthy such a
statement is, so I am unsure how the kernel project is enforcing the
"human submitter is responsible for these", and more importantly,
even assuming that we would take a similar policy for ourselves, I
am not sure what mechanism we can put in place to detect cases where
these expectations are violated.

So...

Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7657F484235
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 17:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787072981; cv=none; b=c4Eds3CpcbYnTofIMb1fHjCcOIxnJ657Am6jyWOqXtX6KaNaPB1tX7a9L+zwvkw1/5bOOtiVZ7iSzrj2ryVD6EKDYBMnqDyzZUVTIVqIKJMCtUoXzA6+wa7Ep6TkD8q1ua6KChgog71jsNPfcecgTT7+XHgY0fzaQ21hydCmhqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787072981; c=relaxed/simple;
	bh=zmv374BeQMQYruDOJGEN6PMToH/i5YhQ6t5bFPxSA2Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LtZUmYETTN23d+FQOu/10eg+wQ9BUQGzpy164nLGOMckt7736HrVYeTghSfOlJQ1CnqyUd78KqNK/fVNJPSiPLcPlF/4Pz+7YPyO6TCkYd3ukttBUv62qJFKa6RZEx3QPRy6N1JETgSAlaAtpaCkFbwnpeorrsus4ItfZ0AOOkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Mf5mHKDz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b00OUN9z; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mf5mHKDz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b00OUN9z"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 974DF1D00142;
	Tue, 18 Aug 2026 13:09:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 18 Aug 2026 13:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787072978;
	 x=1787159378; bh=MSAukxnmFFyASn5m/KiFZNOYnUkNMVH0unDFCk5hLU4=; b=
	Mf5mHKDzlExA1agXG6plH7GSTvpzkyQdjfDI2cV/x16HQtr5sDbyBW51w6KRnge9
	XGRfNxglAXL0PzAS2jv6+24CjfeNYgL/BsPQIxblVU8TfpUb2gPyewhQk81H+XNK
	BRKYuo0mSkLMEQMcSVeV4L6+4pI4bT++mYnwHOy1UXimWUQJxG20rYa9/KBMguBA
	5kMBDH69fBhKmrUHKt0bR1+MYWH1wgUpyC57dIlXI+o5l4zCtdcjVFx7XplLFnZ7
	JXc6g1b7OyAX8FZP4bJRpXliTUO/aZ17/Px0hvN0W5vy0mcNS43k5sr+wIGlgw0+
	onv0d1WROys9fjjiuHdjpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787072978; x=
	1787159378; bh=MSAukxnmFFyASn5m/KiFZNOYnUkNMVH0unDFCk5hLU4=; b=b
	00OUN9zcYW+QCB6OAqCkplZydX/sMLFsCRMSvNpP4378WhmyERDonAgVrSdpJwTG
	TSU8ct3x405/uXlroKb4QT12M1eXxBG7+gqed/XPkNNW9Zmi2ITiiBS++vQnCsss
	MkI90CTgJAtUOmSI1DiuFXIOpwbsiMa1by4Zc5VHxyNBPnIubu3XNg8AV1v2kFBd
	tkMKA2B42Hd/kL9/UCpSdINt/GPobP40piVQ6Yipn5lG3cJATFyk5LOkWN0loXkg
	EfD5LwLz/EocYMNCDGZ9gWSfvLxp8kNMCKZt8xWWORaO/Q/Qiuwdmmgyf8jcdXfV
	SeI/MpMuOpAYfyRZES7QQ==
X-ME-Sender: <xms:0pGEauSkm5FZWosuwCPIk-pPj0l-_AfVCw2Kk4_XxMAnQ1iiBLFBTQ>
    <xme:0pGEaqrzxqqEIW5To5YWDcxdn7lg84ZVelgWhHcFca8x6CgDYcLqCeMpvQAgy2MKY
    oK7JIVK9Y3_AHeYNry0GbceZ7bxlaejhp_YaGPuN_lqNydzLD9DDRI>
X-ME-Received: <xmr:0pGEakIOayX2gXx4wUfZJYOn7iBERGE8FhdWqeaYVv2NQ3JXmTfHtYT-eIsFj5ha4M1OnHWUaJIhlRce0_dNNAbLLmo1CToPsw>
X-ME-Proxy-Cause: dmFkZTGuYANRo7Wc0hCHomihNdTRYUG2biZvM2RYM6YHH0coVl//g1uGYycnSFugBwkKpV
    CXk2B/sflac1hDYSxdqwOVgEPok+oF5FLM3pGel1iDQ3s1gtSNMZ/Zffdlhr7YlGd8oddl
    qs99gK4+Y2/ulzvCqrxNrDyXviWAmtoTEn7Q5Jwiin7eMIUwgB6ZVmpJJcqIKWx/z5vZQk
    N7744v4AMoW7DUNosD9GJtHm132CNH3gCpIF+8BB8BNFiasspUhCUbaQeIU4swK0IugPYR
    6YjCoxOAGsfTx4wb2I5+V6wIVxcyncy0bi87oihxwQ749eJbkGoBJhp2fiAKBF2AvH//qM
    w8oG9pgM6IfUHAp3YX6SkLTouWlxZmw4ZA3rgdUfpm3ba0VnAuaJb7pj2mSsiNUUmO+N1C
    DAbspn9XlOZxt/EaBjVCkMllguhZSNSJfXHFVXkpOfUQvr+8/qZ6IyYNXDa0nFNVirfL+s
    Ny6K5KmyQ1kNXIEe8bKg9n3JAj0Wwi2HUb02P9tafUhQX2DyVVqZh25UKKo03V5auVm7Tf
    4aa4wnHxr2fJ4K5qGh+vUJI43Aft9xl3sKtsjM3GFbzcFhLTZMupWUgdvg7TJKEObZxUXB
    d5y3Awx8vWLko4koi+1wCJJvkY9ioGyukkV4+eS2UKcU02Eig09DUliWMulg
X-ME-Proxy: <xmx:0pGEalqI3QPsb9QDsEql5nnGq1onFXXcK3WFzm4f83LdclHE5NzTTQ>
    <xmx:0pGEakyn4aHE3iDZBVvs9zEKiPcw1DtY0D7_GZHa-nT7ZsTZpDq88g>
    <xmx:0pGEahPdbs8nwIxKGbxbL8HInvr1CcVVKWt1NIzdOgyp1YMkwW32Yg>
    <xmx:0pGEah57kIq6AFs4QAEuCuQhExQxuEbNRe3Aefl1KMaFzKgEwhtNPw>
    <xmx:0pGEag4ffvMmufgZxP58gD3SmaYeSZK6pN7EecbBne569dY1vEdQJfgX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Aug 2026 13:09:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,  git@vger.kernel.org,
  jltobler@gmail.com
Subject: Re: [GSoC PATCH v4 6/7] repo: add path.git-prefix
In-Reply-To: <CA+rGoLfPJb_Pxjm_Bkqd2Ni0BA1vT2LEObwj4EjUaSRRNyRv-Q@mail.gmail.com>
	(K. Jayatheerth's message of "Tue, 18 Aug 2026 22:03:05 +0530")
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
	<20260806101556.162940-1-jayatheerthkulkarni2005@gmail.com>
	<20260806101556.162940-7-jayatheerthkulkarni2005@gmail.com>
	<6E2B0ADE-2101-47AC-B11B-315897AC2AF9@gmail.com>
	<CA+rGoLfPJb_Pxjm_Bkqd2Ni0BA1vT2LEObwj4EjUaSRRNyRv-Q@mail.gmail.com>
Date: Tue, 18 Aug 2026 10:09:36 -0700
Message-ID: <xmqqlda3z773.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> On Sun, Aug 16, 2026 at 6:24 AM Lucas Seiki Oshiro
> <lucasseikioshiro@gmail.com> wrote:
>>
>>
>> > Scripts sometimes need the path from the repository's working tree root
>> > to the current working directory. While this information can be derived
>> > through existing Git commands, `git repo info` does not currently expose
>> > it as a scriptable key.
>>
>> Even though I understand that this is a relevant info, it seems
>> to me that it's a little bit out of place here... This is
>> a "current directory information", not a "repository information".
>
> I agree that path.git-prefix is technically current-directory information
> rather than repository information.

The same thing can be said about "git rev-parse --show-cdup"; you
can complain that it is about the current working directory, but in
reality it is about how to get to the root of the working tree you
are currently working in, which means that it is very much about
repository information, only given as a relative path.  Nobody would
complain that you have 'path.commondir.relative' when you already
offer its '.absolute' counterpart, saying that '.relative' is about
your current working directory and not about the repository, right?

The same story holds for 'path.git-prefix', I would think.  View it,
and "git rev-parse --show-prefix", as the inverse version of a
'path.root-of-the-working-tree.relative' (aka 'path.cdup') rather
than as being about the "current directory".

Oh, and if you are offering git-prefix, you should offer cdup as
well.

Thanks.

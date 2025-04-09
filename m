Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276E61DA3D
	for <git@vger.kernel.org>; Wed,  9 Apr 2025 16:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744215564; cv=none; b=KBwIAKKYu9Ws/7vflesWrg71YSrR0zDnoCAxDmKVfkGSV+saI7QSG0Fq5FX5zYbUc25DVTn+SRPJMZlvQBwRMdrKDjzZDlgK+ZZsXFKY7U03l7MVsQ+z3o1mfZKIQj1u7YTY2BDV99gJcAW3yd86zJRZ2jYockd6YTJ/qSPssp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744215564; c=relaxed/simple;
	bh=vwHm6/t7slu5hGNdTLlaDD8xKqAn+Dn+s95RU+i+pfQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lJrx859a0ctBvix99s5lplgVasETssIRA5wn3CcKvEkxF47hOQiy4AHvpoaET5MC23w4Z/K0w+Bshx4xTjAb2ANmcq/x9ZoeT1fRQDzDv05aSiG0WV/wwpyEorCtQb075P3tnTKisCp+AJSMcXY0UvhSXNQGfpEaIx343Ufz/Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=W5+wt/L8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OLsnL5H/; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="W5+wt/L8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OLsnL5H/"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1BDEE25401DF;
	Wed,  9 Apr 2025 12:19:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Wed, 09 Apr 2025 12:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1744215561;
	 x=1744301961; bh=9DHrR1UExsOBVnYuOACRaroh/hwaCwxhkW5awt6gEaQ=; b=
	W5+wt/L8sqDoQeK+pOuwLyVC9DGkk7Q3caGv+pZ3xm4vd3v0eVWznAZxQXePeSc8
	7FDnj/3IUwRgMEdd2qagFrb+TPZCP5Nz4z4UVxletEjRwsscPo/5zbCsqwv/UIkz
	pSf4smux75MQWxQtnZeZjYyBdrmiJoqhGA/5ZbA6H8EC8OoVxnrWMKyIOc0LDECu
	gHmFPNz6bMD8YU1WJR19crJLRuZD8FqjJ2sN6qn9VhqULWtB9Ae4LXr3gYJ8dWOE
	+FSQ9dBYmSkA8Mkd5Du+ogUsoE3LYU2wdOgrXfw7NNslsdmT/Gic/bOLVBzyEHpP
	xM/FyHXnx4X93FXjjVSeNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744215561; x=
	1744301961; bh=9DHrR1UExsOBVnYuOACRaroh/hwaCwxhkW5awt6gEaQ=; b=O
	LsnL5H/9eNHJ+MDkDUwDGVxmhJ9CMLjnERXddMuPzjsf611j7j/f745PuGHuF73X
	4dN0QE9zsS7uEqGj2TSULa9oOcwNNiE20qs7dmdfpAsZBeAidFzUrDSmLZeRzhMc
	BihNzQ5IjEEZS4BEjjSx8EXpPM2ewNMESs2Yak1QV4UDPUom+YeZ6w58eu8loNUw
	PiDdmsWKIP6MugGxANtRdIHRZ5OToFitNMnquuvNgO105QWHAAx1TAPZU6w1yEtZ
	ovsFxrqGsk4+Nbhobs06i6ALiwu9esIeKmU0dZAHCY0ZDxbLvzCWRTxgsr3t5aoQ
	Ss8L3+HOnMS6yx6dvfLuA==
X-ME-Sender: <xms:CZ72Z053qM4kDq0myIbn_JBp76od7p9zBFoJp3D_5quy9xjsj-wyxA>
    <xme:CZ72Z178yEC2B_psbgV6tKOES6WF1ZvoHmLgIYUjACupXqO7vTwrptDot3jAXz5qf
    xhgCiQAveS63MaxQw>
X-ME-Received: <xmr:CZ72ZzdAWEpOAK8WfIjM3ZaKAhgJGWdoJp_nd27C9IauIMRezXjTFE6ugsw5eCExgIZIhUo1hns6MqnJwQM6ALDzvyqItuf3Wodn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeigeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhih
    hnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepshhntdefrdhgvghnvghr
    rghlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:CZ72Z5It3BqqjYopuMK_arPgkuZaDj5dvW8e2wBEJ6adwZy68FmXqw>
    <xmx:CZ72Z4JXjBv296Piyb4DEIOqNgr3jrX1SJtyW-JbeKNHBqilC8bNsg>
    <xmx:CZ72Z6yqHrpOG17EWutDDNbgQHJl2wA-LkRnvRqZzgCX7Zju-SU7Og>
    <xmx:CZ72Z8LEkr0Exsbm2Grx-IX8sjtfNSoyEBsiUHcB5t1zBjcxRsXwjQ>
    <xmx:CZ72Z_y7PRuWp52ZLPOYcP_gmMiVLiiPDWDMaHcdesrx-vnXfFWR66r7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Apr 2025 12:19:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Subhaditya Nath <sn03.general@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH] t7422: remove extraneous argument to printf
In-Reply-To: <CAPig+cT1dQL+MfUctyw=9O5Wd2yUqA40pXSgsRHKfNf=6vxQ7w@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 3 Apr 2025 13:05:16 -0400")
References: <20250403144852.19153-1-sn03.general@gmail.com>
	<CAPig+cT1dQL+MfUctyw=9O5Wd2yUqA40pXSgsRHKfNf=6vxQ7w@mail.gmail.com>
Date: Wed, 09 Apr 2025 09:19:19 -0700
Message-ID: <xmqqfrihs3y0.fsf@gitster.g>
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

> On Thu, Apr 3, 2025 at 10:52 AM Subhaditya Nath <sn03.general@gmail.com> wrote:
>> The POSIX man page of printf(1) mentions -
>> > If the format operand contains no conversion specifications and
>> > argument operands are present, the results are unspecified.
>>
>> In practice, this means some printf implementations throw an error
>> when provided with extra operands, thereby causing the test to fail
>> erroneously. This commit fixes that issue.
>
> Thanks, this makes sense.
>
>> Signed-off-by: Subhaditya Nath <sn03.general@gmail.com>
>> ---
>> diff --git a/t/t7422-submodule-output.sh b/t/t7422-submodule-output.sh
>> @@ -180,7 +180,7 @@ test_expect_success !MINGW 'git submodule status --recursive propagates SIGPIPE'
>>                 COMMIT=$(git rev-parse HEAD) &&
>>                 for i in $(test_seq 2000)
>>                 do
>> -                       printf "[submodule \"sm-$i\"]\npath = recursive-submodule-path-$i\n" "$i" ||
>> +                       printf "[submodule \"sm-$i\"]\npath = recursive-submodule-path-$i\n" ||
>>                         return 1
>>                 done >gitmodules &&
>>                 BLOB=$(git hash-object -w --stdin <gitmodules) &&
>
> This change is obviously correct.
>
> This was added by 65f586132b (t7422: fix flaky test caused by buffered
> stdout, 2025-01-10) which also added a similar loop just below this
> one:
>
>     for i in $(test_seq 2000)
>     do
>         printf "160000 commit $COMMIT\trecursive-submodule-path-%d\n" "$i" ||
>         return 1
>     done >>tree &&
>
> in which the loop variable is interpolated indirectly via `%d` rather
> than directly via `$i`. I suspect that the author's intention was to
> use `%d` for both loops. Thus, for the sake of consistency and to
> match the author's original intent, it may make more sense to retain
> the argument to printf and instead employ `%d`.

Yup, I think, even though both would be correct, such a change would
be more sensible than the one that was posted here.

Thanks.


Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C44D21D3C0
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 01:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765848095; cv=none; b=o5t5r/F0BXY722QfSmBl4bGckkGbTVEvfRZdn42J5MrACjNnym4acw80qKzjuXLct+rcKcXuzcoQTzXpIRuorp9x9N1p016bNGu0dDkgPQrVPr7M03VnC5+tjyM84+2LWgUBJAixEclbiw4pATPQ47PnDxFoSP5YK6a8/UFVGG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765848095; c=relaxed/simple;
	bh=6p/v60MRJ3VGRueOw+0hDcID+MaOiMwp19p2bd54CrE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DXyLIHzt+ssyNqI5jQ+rAXcEacQ9TTwAey/B493M1I+RuAswY0TY3ZOvC1b+aHpnq70u8E4ESmQTBNKt9tphUYo4IjaVG0f8jyPBG3/SsJYWKG5Xfw/eJAc8DY7sfbUKHt7qlLJN5aGGwBYixEOM0Ym872Nc/KQzjiFR4/XM7pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fPEa0BB1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R+DwdzNf; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fPEa0BB1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R+DwdzNf"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4348E7A01D9;
	Mon, 15 Dec 2025 20:21:33 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 15 Dec 2025 20:21:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1765848093;
	 x=1765934493; bh=Tk3a2Zd3Geg/N8EIIDE+Um/Ruj5HMxVZ7KUVOzUDVro=; b=
	fPEa0BB1e4ozFkiB5WjaomHYLcga1qip/xC7zeJfJ+VTUrc4uysbC791fP7atLLk
	l5JEg6CLt42VYoYTAkk6Yx7CbvF/b5RMqAGMZW/wxqjPWsaYcoG09WIx8aKYO5jz
	EmQkic8dfh9bOp+r0+FxiieKRtBhb6+Wbdh8fEd8gPxJ5krdpZaL2/c7ihMqSkyl
	Z7SFcEr07n9kGZFzOUIETqWSZ5GfuWfe9ZSaVAtgabL5iA9875TZu8aB3iDLSHKI
	P6coP/qurnhkqVz9mkAERnltztxrATkCSl9DAN1BMXiclrhw6jxZyZGNKDsBBIiH
	+CrFab8zjzh6M2brtdKV2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765848093; x=
	1765934493; bh=Tk3a2Zd3Geg/N8EIIDE+Um/Ruj5HMxVZ7KUVOzUDVro=; b=R
	+DwdzNfzDZWBxe8BBf7AMWdUAUH6wcDk7XQkr0OLGRZhxkMOpyVdR0taKDwwWgT+
	C3RTWoUHTPv/z97n/4PB2eqZvI8mwdZqMKv3N31z2RA5y0mQ+RrjR0kAO6o3lF6Y
	HPOk4D6Rhr63xTdeI88Zgjx3eYLHvlBcnGjH0QCE4KidJJ+jVCRV531ugJlUsJVb
	crYOHZgxLuEdBo/38q595TgdP4bRqAiE0Cv90deCXqXv071Vt/EEXLT13uqUYWky
	wZGuBe/JHv3iCwu9cqUh/WFwJWC4xhdFbo+5OH4kEV7bo+Qkl90C8NqNSmXcB66C
	HCjyB1jnaR+KOaKnKP5FA==
X-ME-Sender: <xms:HbRAaQILqBqqYehDzjhmxmX5nUNhOn3vHlROHMJZ187JRpSNvKjVsw>
    <xme:HbRAaXI8d5idDBzg_xAPpIhHZ_tXpjspdeBj7lXPj5c0RO5jff8BVSk7PSILU4oyy
    2N-EK5EJfZKWu7-ezdJKsqc3iDvxpgaEn9MTOugd5l8W5ntcJg>
X-ME-Received: <xmr:HbRAaVs2FQ6jYWo-nsnKIhbYiKRUtJSfSvfJAFuUSG7E2P9cH9iDuhRvzosmhue3WbtfeKyjrox-0dnzPOocR17m8Yny98hyqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefkeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgfgsehtkeertd
    dtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevle
    fgkeefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsiigvuggv
    rhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvg
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:HbRAacT04eycHPs29YI1n0IySIDlzRLMXijuth-h1J6kJMAjIz6XlQ>
    <xmx:HbRAaTOFDihtJk7AsNCiwu0C80Cpl0MVfwHqVCM-1gpirMMErYrlKg>
    <xmx:HbRAaZbWdG0NKoAitA_H-LbNc7LRulFTbwoYhGKnz3QlKdfm80pCdA>
    <xmx:HbRAaVw1vQFU1KC5zqRkIX5cC6HiQEHibH9Sl37tGUV18Bd_A9ej_Q>
    <xmx:HbRAaba5D3LXAOIaQX_Zty4D1yEVHi9MFBN8-TtYZgfeSwe0LwAf_G7z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Dec 2025 20:21:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH RESEND] diff-files: fix copy detection
In-Reply-To: <aUCTdUMKslSo3XR9@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?=22's?= message of "Tue,
	16 Dec 2025 00:02:13 +0100")
References: <4b06a448-0935-4f2a-9061-238c7cc800c3@web.de>
	<aUCTdUMKslSo3XR9@szeder.dev>
Date: Tue, 16 Dec 2025 10:21:31 +0900
Message-ID: <xmqqecov5ihw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Sun, Dec 14, 2025 at 04:57:06PM +0100, René Scharfe wrote:
>> Fix copy detection by queuing up-to-date and skip-worktree entries using
>> diff_same().
>
>> diff --git a/diff-lib.c b/diff-lib.c
>> index 8e624f38c6..5307390ff3 100644
>> --- a/diff-lib.c
>> +++ b/diff-lib.c
>
>> @@ -272,8 +276,10 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
>>  		if (!changed && !dirty_submodule) {
>>  			ce_mark_uptodate(ce);
>>  			mark_fsmonitor_valid(istate, ce);
>> -			if (!revs->diffopt.flags.find_copies_harder)
>> -				continue;
>> +			if (revs->diffopt.flags.find_copies_harder)
>> +				diff_same(&revs->diffopt, newmode,
>> +					  &ce->oid, ce->name);
>
> Junio, this patch should be queued on top of 38f88051da
> (diff-index: don't queue unchanged filepairs with diff_change(),
> 2025-11-30), because diff_same() was introduced in that commit.

Very true.  Thanks.

>
>   ~/src/git ((7077c385f9...) %)$ git log --oneline -1
>   7077c385f9 (HEAD) diff-files: fix copy detection
>   ~/src/git ((7077c385f9...) %)$ make diff-lib.o
>       CC diff-lib.o
>   diff-lib.c: In function ‘run_diff_files’:
>   diff-lib.c:231:33: error: implicit declaration of function ‘diff_same’; did you mean ‘diff_free’? [-Werror=implicit-function-declaration]
>     231 |                                 diff_same(&revs->diffopt, ce->ce_mode,
>         |                                 ^~~~~~~~~
>         |                                 diff_free
>   cc1: all warnings being treated as errors
>   make: *** [Makefile:2862: diff-lib.o] Error 1

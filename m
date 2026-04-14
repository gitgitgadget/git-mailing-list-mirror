Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A338C3B2BA
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 17:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186051; cv=none; b=U8yr5W6wum1kWOGXcDeWc5PI897Tv77kaZ/gWNfOq+g20Ip/orwxkjHxpps+wsMaxHiLd8JfeyXzdWrHXLdtm5w6BoU9MpukR3c6opp8huk18OMMR5FBykfMdpnNDviGE9B9/6Az1/Hm6zRNlUuQgolw2qxuyqEF7UbZTknyH50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186051; c=relaxed/simple;
	bh=O25gc/E7ZQ042+yVyty26fagBF9hCWJe5JpI3dHkdEw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vq61WX4bb+9c6dib0LPlBR1Muuw77CuRSexCs7+qI3aGvJzx9PzEWF6qp+PhQ4HqC+PO+e79mK1C5oA689Fa38fbockW6vLqiCgIKtAR9T064hzUnhjH843jSPwTQ4oJikfx+P8MrlEmogyx8Bzptg8DRsxyUGDAZVraT++9mjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GuKtVLY+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LU4Zm+EU; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GuKtVLY+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LU4Zm+EU"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A13201D001B9;
	Tue, 14 Apr 2026 13:00:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 14 Apr 2026 13:00:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776186049; x=1776272449; bh=UvoLhMvo2V
	w6RVWVp2OqGz+7S9pq/hkdBO85d3rRJMY=; b=GuKtVLY+RGZZIkcO+u4hEjU6EC
	gKuyq8aCK7XbI4lDybLPMWQFCl1phXGzQ6JjPosv4KQ9WuaQ/oAU2SC9vgdeMaPh
	L9xEAXQpv0BSwcv7dYNElC/R1H/f4x1oY1aewOH0+Z23VSMsWEuoBsvOa7ZDivyy
	21Q4lz3hv9zwwZIjnv907Chr5ZX85jUXrAuvfP2CupWb63d6Bj0K6QWzj+GSVOGE
	3jDuTdyUd8O655kw2PZtmtmvxYB1ZkNmFDMR6SHTM4UMnx+hKCzfABQ6nkhkSqbK
	Sv9JRPI7ygEwwBML9V0rcYQoij19AHWyWSpbzMyiZaaFCK/39gTuuv3R+kNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776186049; x=1776272449; bh=UvoLhMvo2Vw6RVWVp2OqGz+7S9pq/hkdBO8
	5d3rRJMY=; b=LU4Zm+EUDetRLsc+U7J+UF+IIXB90yyq/6gittquxI6u//jjsHD
	sAeYn20BspWFxo8k9zXZMGxfg60TVnzBbDEGA+tx2bq7x2pb4djH+TKCi+4DZcVg
	wNw8YDiesauvOyc+FZ4PCtYhGxFa8y9zZoMumNrJl6P13bCqIYE46UiVlXCrfmlO
	dxq1VK9HesSNFzMW64Y7yzJDQ2lh2smsyR3Sd56Qqb2sPIHczBvWxi2YIVEtJTFg
	smaJVlZl8jBF0D+L2bgRExPnDA0qxuCTtN9o7f39RoueYiPHgp8cqryMhqw4aa9p
	5vL2ZQzQtosmgOMIX7pOCNWWp2p2AtLg6Hg==
X-ME-Sender: <xms:wXLeaTYA40J1qRT7FMgpZdvVXExtjJXSlPcH5WuWk6GFegjCCUnytQ>
    <xme:wXLeaUqfbXFy2KmJu0KR_gU55fLxS8Zrjh6r-hocfnUuDZy8Mf86UjKQoEryHY4QU
    A_18rf86w2gUkYfA7qjAkoE_b0eiloy1xA7VSjHATWFynaU8txmug>
X-ME-Received: <xmr:wXLeaYMqRbg_M8Q3BWwVn0oCMezWORgchQjy7NOA__Cowz3MYAKDtPTB8TZiwU8Ca4YTBKiw7CwFZj5oRRG478MclE-dagidEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegudejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehrrdhsihguughhrghrthhhrdhshhhrihhmrghlihesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprggsughosghnghgrugesghhmrghilhdrtghomhdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepsggvnhgtvgesfhgvrhguihhnrghnugihrdgt
    ohhmpdhrtghpthhtohepjhhohhhnrdgrrdhprghsshgrrhhosehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:wXLeafo5GPNwrTPyn2wFN41EEr59pTs05-JvTO9CFckTfU1_gWXTkA>
    <xmx:wXLeadcflMsiJnAxoYtmsyr0KvNCChdcihft6bXD6A4rpPTwvecKlA>
    <xmx:wXLeaVQYLuG9oemFfLhOQBk9dzXI3o-phY0xtLdg91E_urwvF6aHew>
    <xmx:wXLeaWYvxgOCncTYkE-KorDt6lzf2-VDAHolohNa1rnxE0whIRSh1g>
    <xmx:wXLeaXWDgwuK_idi31Tl16C3Rn6cAspChIaGrMwZcYY4iRUqevQKgzJe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 13:00:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org,  abdobngad@gmail.com,  ps@pks.im,
  bence@ferdinandy.com,  john.a.passaro@gmail.com
Subject: Re: [PATCH 2/3] t7004: dynamically grab expected state in tests
In-Reply-To: <20260414141828.27576-3-r.siddharth.shrimali@gmail.com>
	(Siddharth Shrimali's message of "Tue, 14 Apr 2026 19:48:27 +0530")
References: <20260414141828.27576-1-r.siddharth.shrimali@gmail.com>
	<20260414141828.27576-3-r.siddharth.shrimali@gmail.com>
Date: Tue, 14 Apr 2026 10:00:47 -0700
Message-ID: <xmqqik9tbhog.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Shrimali <r.siddharth.shrimali@gmail.com> writes:

> The tests for 'Multiple -l or --list options' and 'trying to delete
> tags without params', hardcodes that exactly one or two specific tags
> ('myhead', 'mytag') exist in the repository.
>
> If other tests are added, modified, or removed earlier in the script,
> this expected global state will change, resulting in these tests to fail
> for completely unrelated reasons.
>
> Instead of hardcoding the expected tags, dynamically grab the state
> of the repository before running the commands under test ('git tag -l'
> and 'git tag -d'), and verify that the output matches or remains
> unchanged afterward. This keeps the tests independent from the script's
> overall state.
>
> Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
> ---
>  t/t7004-tag.sh | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)

Excellent.  I agree with both reasoning above and execution below.

>
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 6ca5c75b57..4fdd47cd21 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -145,9 +145,7 @@ test_expect_success 'listing all tags if one exists should succeed' '
>  '
>  
>  test_expect_success 'Multiple -l or --list options are equivalent to one -l option' '
> -	cat >expect <<-\EOF &&
> -	mytag
> -	EOF
> +	git tag -l >expect &&
>  	git tag -l -l >actual &&
>  	test_cmp expect actual &&
>  	git tag --list --list >actual &&
> @@ -223,12 +221,7 @@ test_expect_success 'trying to delete an unknown tag should fail' '
>  '
>  
>  test_expect_success 'trying to delete tags without params should succeed and do nothing' '
> -	cat >expect <<-\EOF &&
> -	myhead
> -	mytag
> -	EOF
> -	git tag -l >actual &&
> -	test_cmp expect actual &&
> +	git tag -l >expect &&
>  	git tag -d &&
>  	git tag -l >actual &&
>  	test_cmp expect actual

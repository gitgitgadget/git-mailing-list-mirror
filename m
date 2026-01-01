Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F433481DD
	for <git@vger.kernel.org>; Thu,  1 Jan 2026 00:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767227272; cv=none; b=gDfy+la9ZSlMisN42hisiuEGOMk6opJh/wqiYW2uG2PQz79NQSdwXcvGtoeKlOfas4qvdMuNIBSo6KJOL+is81MmAknFm1eGB1gkkHxMuUelQ3tei59uMBHOee3iRtKaIGkAAGGJXO+VEnCp9/HQd2vG4efw+5oUVDuixZjfojk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767227272; c=relaxed/simple;
	bh=dhBa0N6kjWMnFaj/nIYv+9P04Mv5JTg9/m9UamZzKYY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oExHBjfSaymQEG1DrohaeU/hRreJ1y4/Fs0R70X2DUKMsEaVaYefW+Yegsnl8V4YeLfgEDQouMUA9lEi98XYJJODWpuWO//6qeTOMSHEvqaO/64tZrNDUDohpjbQX6JCqUtRUbAComW2fpFNx+nh4cSuUEAo3P0qvqJJoqXhZFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GE0J95EU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pTesTJ1l; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GE0J95EU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pTesTJ1l"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9C14C140004E;
	Wed, 31 Dec 2025 19:27:47 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 31 Dec 2025 19:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767227267; x=1767313667; bh=3SuFvxGIwD
	V3/Q7MRqMs0ZjtAMekkGYHSzcWvM3T684=; b=GE0J95EUcXlDLG3PniyUpBRbZH
	fvWitBiV88RXPVLSGnaekKId+tsS3y7XDxZ9BTea6mW5XAFORhQkcxMde20BM9jl
	a4EWYVrkBJXK0tLTxkPvGaNSs9zVS208Ucq79wk/y7jt5VWTQUkLtMGZ9I3EyBK6
	IlVkPuC553Sde49L2LM9f/F67gJ4UtLlHjG1NFSWexPtBQKlqrJC9zCaGjT19xfX
	suqzLzjd/Li9K/dnZgUBrkYIqdXa56FFa1FJ4VcIxNMg5OQ0gpYcvzcAyUBlrNoY
	4D/dvfKfo+stJWhuyK/rd2gCgAYwh1ZLt63ZNRarBJIRhTYc69F5nPp84l/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767227267; x=1767313667; bh=3SuFvxGIwDV3/Q7MRqMs0ZjtAMekkGYHSzc
	WvM3T684=; b=pTesTJ1lfrXI2tmf+A5QQtOyb9tTIAXN8UBimGv58AT1Nhhb7jY
	qffw0T3+/1YOXwia/9ZjfGqeIJw26ejX/tHiVmVXnX/33sw5OvgfOiaI1E7uMi1i
	2S667qxBrC/bdpbjXWu4S6wWpnsOovNafZQAq9DecaClaM+iqJYEE0z9FE2zppo1
	21CYgVStg/gGdK3Y1vLuIPKSWH5mISutQj458LPvUupBuZ88SZvewXCWKArnPPeP
	m8o/NGsuYUmf+TRwXbJ+b2q2706IQ+QWO0i/eoAvXBwZ4pnH8bEv/T9Pr44BXMEv
	raZ5oyyq9ViN2MFPPIP7BevIis5rWCSOVrQ==
X-ME-Sender: <xms:g79VaRvYGIPxBjK4o_dI3hEW2yyInRi6Sgdf_MOEJu-QZoMecHY1jg>
    <xme:g79VaR49cngHeW1QBopLeeTxkqIbt2ZRVHvBkD88HxyN51DAtj6UCke8BKOJPZedW
    C7q4lRA9tbKpENnTKodMHeq8zuwqEGEkaNPkxK1R7m7GAyflJo59w>
X-ME-Received: <xmr:g79VaSICs3vwu2t3AZ51ZQFidmmQ5tSTrx3F32vP4lqoyRCzQGNXAKI0Vce5q4_Dh1pkWS7x-DfIktQa8rDWeXlf9d8jY9hwsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekgeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhgvshhh
    ihhguhhrghgrohhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:g79VaR74RNvKJcx25EgeQFjOLR_SobcTE0DDuIYHa26FAZaMyj60Xg>
    <xmx:g79VaVwUUn0I5fkxPrJlA67nbH7mZHnlq8x7hErgl5RRH2bPJ_5hVQ>
    <xmx:g79VaVbUnrFPXz8__lEhB9HkDl-6hmwfCu56A2w7aJc9_6C1dezJxQ>
    <xmx:g79VaXS2gBTM7bgOMgktjI7LyYPBYhY97D78b82GmhC2svczsvUypg>
    <xmx:g79Vad44Bo38Lcf7hfGX92XaULuyKMb2uDSd0PZ9ZS7irDXPiKB549GY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Dec 2025 19:27:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] [GSoC] t5403: use test_path_is_file instead of test -f
In-Reply-To: <20251229185737.2328-1-deveshigurgaon@gmail.com> (Deveshi
	Dwivedi's message of "Mon, 29 Dec 2025 18:57:37 +0000")
References: <20251229185737.2328-1-deveshigurgaon@gmail.com>
Date: Thu, 01 Jan 2026 09:27:45 +0900
Message-ID: <xmqqjyy2dvni.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Deveshi Dwivedi <deveshigurgaon@gmail.com> writes:

> Replace 'test -f' with the test_path_is_file in
> t5403-post-checkout-hook.sh. This helper provides better error
> messages when tests fail, making it easier to debug issues.

All true, so I'll queue the patch.  Thanks.

A #leftoverbit is to think about what this test checks, if it
makes sense, and if we can do better.  The expected outcome of this
clone is stable, so the input fed to the hook should also be stable.
With the same brain-cycle to write a test that checks the existence
of the output file (i.e., proving that the hook was run), we should
be able to concoct a test that validates the contents of the output.

> Signed-off-by: Deveshi Dwivedi <deveshigurgaon@gmail.com>
> ---
>  t/t5403-post-checkout-hook.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
> index 978f240cda..1462e3365b 100755
> --- a/t/t5403-post-checkout-hook.sh
> +++ b/t/t5403-post-checkout-hook.sh
> @@ -109,7 +109,7 @@ test_expect_success 'post-checkout hook is triggered by clone' '
>  	echo "$@" >"$GIT_DIR/post-checkout.args"
>  	EOF
>  	git clone --template=templates . clone3 &&
> -	test -f clone3/.git/post-checkout.args
> +	test_path_is_file clone3/.git/post-checkout.args
>  '
>  
>  test_done

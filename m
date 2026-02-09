Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C95388855
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 18:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770660676; cv=none; b=nOHydLcPGqn/pWC0KDXxBSUuF9Hz+Q9TPQv62nAF2T1o8ekaxor0W0UIGDW36O8FW0CyCpm0+fYwZ5AP8N1xHpFyGZdPpNrFqA6rp1lu5zWUZUaVMtIxa+8NgurHShoTq4hBj1Mo3c9xcdHmagdkCGY91+2UPnOPNvOyuAitiec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770660676; c=relaxed/simple;
	bh=ukS8rsZEWxlKiyKCExUCMp1W4f+ptW+R9RbUkbuIAto=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eETz1IRTLcWDSBHkXfgx8K9M6qJN8LOrEJwBnkDBVQ40KAUN0py1d1MuUQoaNCKpHBMGS91VhjXh3n0+tVME5EhBz1MRrMRnmQiOYIZR//SEwt0sG34PCkWSibPpXHMEB2ckq23iF71Gf5Uwip0CB4q+ukgPehafeX/sFEffhBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h5twb03F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kPG2HRHq; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h5twb03F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kPG2HRHq"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 9AE7FEC05FB;
	Mon,  9 Feb 2026 13:11:15 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 09 Feb 2026 13:11:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770660675; x=1770747075; bh=/9mwnyu67K
	UGTh3LTjZpyqVM5qQmt7kg8036d3MplJY=; b=h5twb03FXhBK23T6aSoIno1Jrq
	NoiKd9xF4VYpxNgfajpgXjWok9vEtaDLPfwqqRQD4vPOwcTN9FhMv/D159XtKo0V
	YMOFa2GFLlWvf7nkWrPrrM0+Xi15mkndjtv0kShWHfUdLh89or9hwXN45zD3LLnk
	BKpafm8NDXk0/a3tdMnpqMspu54K6d5LDPXfV+Ab0/q1mCXIfh3JwIlXAo13K9aO
	kYY5WK8X/5uLQ6PGUOYoFpErOQFeP6s8x3W9/fBqTXw1DkmRW/q6Bxoq6vgr9Meu
	ecorIkdpjFmJ9KKMSnX/x+G18zEJjdvAhiwl6aJHMOueGeUzUIBRuT6YPjeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770660675; x=1770747075; bh=/9mwnyu67KUGTh3LTjZpyqVM5qQmt7kg803
	6d3MplJY=; b=kPG2HRHqlLfl85JTfXdCCfHJ0zP/GPWvJOKfNCAPxje6HlWZsOG
	rRzMGZfqK4mHcFZBq07se2A8Q7rlkEdUhfJ1QwYu1lfPN9im9ROiXnzvkCnBIC6N
	UJqvhAL90sa3U6klXlV0jDsEXt6KHnq/5f92UAyk1cD/6a1KZEBRCeRqxLtZI1fZ
	j15/q09GyHBdZ+vYCcJMPY/MsR+PmtHYLU8xm4TL4vFLMIYRaJAWhoh9dWvMUSo4
	UnV74b3Dbvmo3NLdBb5wYalGuTi/r7IM37ZDWqrMAwY8/9JZ577rC4wD4+6KPw3x
	CE4Rs1ZwvaoUUCuPGmIerIgohy090cnLmyw==
X-ME-Sender: <xms:QyOKadyQtDoXHoWxT3jzmPzWNAdZp_sFHO4b-cskedimpTowu5mw0Q>
    <xme:QyOKaUtNqT2VbQb0lihU79DuB2RPj7C2b1U5fcINTDt-BMNOntXRtvWeUQ1cRmgHT
    8pFIj4BjBj_zwDJKVKyDgyHet8CSHrkbuHLCB_60csAULc0ed2WZw>
X-ME-Received: <xmr:QyOKaUtTKdwrmRgguscRjX9dBViuvmip0Jsb2q0wUXOrwjeTt3Zw0zvCRet4J9LDGCR8Z5HqR72th3f-0mtmMMF_g7_zPnFXrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehvrghluhhs
    ohhuthhrihhksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:QyOKaZNcXJqiBPsVJCwAEXDxypONubdd18EkNxWTKdGi08Rsv2oJAw>
    <xmx:QyOKaS34ZPASvsq2stRnwvoMDuxsjAq_5w1j0fAAIkgz_cbfWCUi0g>
    <xmx:QyOKaVOaA-yuhPRImBSgZmpx6LgjxjmhvOFg89YARn43Gb89Ksecqg>
    <xmx:QyOKaS1RhmbnIMqsLbp7_G8r8OrhXRQQFhpMpF1prGBQRxaIdhXlmQ>
    <xmx:QyOKaUtjVfEFdDXRkQU6OHEbzwQokeFVz3RtrYMyiTjVXHlsfiWxRmEH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 13:11:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: SoutrikDas <valusoutrik@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSOC PATCH] t7003: modernize path existence checks using test
 helpers
In-Reply-To: <20260209172445.39536-1-valusoutrik@gmail.com> (SoutrikDas's
	message of "Mon, 9 Feb 2026 22:54:45 +0530")
References: <20260209172445.39536-1-valusoutrik@gmail.com>
Date: Mon, 09 Feb 2026 10:11:14 -0800
Message-ID: <xmqqpl6d4wjh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

SoutrikDas <valusoutrik@gmail.com> writes:

> Replace direct uses of 'test -f' and 'test -d' with
> git's helper functions 'test_path_is_file' ,
> 'test_path_is_missing' and 'test_path_is_dir'
>
> Signed-off-by: SoutrikDas <valusoutrik@gmail.com>
> ---
>  t/t7003-filter-branch.sh | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
> index 5ab4d41ee7..c475769858 100755
> --- a/t/t7003-filter-branch.sh
> +++ b/t/t7003-filter-branch.sh
> @@ -92,8 +92,8 @@ test_expect_success 'rewrite, renaming a specific file' '
>  
>  test_expect_success 'test that the file was renamed' '
>  	test D = "$(git show HEAD:doh --)" &&
> -	! test -f D.t &&
> -	test -f doh &&
> +	test_path_is_missing D.t &&
> +	test_path_is_file doh &&
>  	test D = "$(cat doh)"
>  '
> @@ -103,10 +103,10 @@ test_expect_success 'rewrite, renaming a specific directory' '
>  
>  test_expect_success 'test that the directory was renamed' '
>  	test dir/D = "$(git show HEAD:diroh/D.t --)" &&
> -	! test -d dir &&
> -	test -d diroh &&
> -	! test -d diroh/dir &&
> -	test -f diroh/D.t &&
> +	test_path_is_missing dir &&
> +	test_path_is_dir diroh &&
> +	test_path_is_missing diroh/dir &&
> +	test_path_is_file diroh/D.t &&
>  	test dir/D = "$(cat diroh/D.t)"
>  '

All the checks involving "is-missing" are now stricter than the
original, in that they used to allow "dir" to exist as long as it is
not a directory, etc., but if we audited the code that leads to
these tests can never create a "dir" that is a regular file or
something that is not a directory (which *I* did *NOT*, but
presumably you have already done so?---if so that is worth noting in
the proposed log message), then "test ! -d dir" that is rewritten to
"test_path_is_missing dir" is actually a _better_ test.

Thanks.



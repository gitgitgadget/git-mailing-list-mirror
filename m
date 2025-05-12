Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7812957B8
	for <git@vger.kernel.org>; Mon, 12 May 2025 17:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747069756; cv=none; b=tFm9sKJvOgkqqzVjDDwMh/jnMBavGPxnhvxPysNozwrnoWmFvaHX9GIf+NflLK/MX9i3wDebwR/ApROxIC6PpBLeeodgZU2Z3NCu1z8xsg4eU2qy/1eZ/+PdZKkKq5V+wDS+Q0kVFzJKNS9dr+P9PrTVhebTXIlyB84sQA/9tvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747069756; c=relaxed/simple;
	bh=PNuca2kVOqKp9y+KGoH0HNrGWeJEBTzl7fQb3sGCAs0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=se6+gUUiWuNIZf2/uo70aj0mEcmVj3aZd/Uup//WDqVPoQnaF6qPCcGxZSSxPfGnoiWf3UqWmtAgncernpheBQX7tODJtXtTSnMagGsiQkZFlAz/Mr/yMzllIkiDddencGCdqE/DXB0kYa4qMHc5ceYEe4qjH+ETLNv6kZIgea4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dxVmlYOE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ffYt6Mk/; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dxVmlYOE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ffYt6Mk/"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 789EA254014B;
	Mon, 12 May 2025 13:09:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 12 May 2025 13:09:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747069753; x=1747156153; bh=k5/wbYgTCe
	Q3iU4UPud4FMRsgf/YiAPPO3S2AoQ32bg=; b=dxVmlYOExQIYZ5L5XsjAl05ovW
	ihNHe7IuDiOjhvl6Ca+DsoQV4ZCheHOdHRN+dgqSn2I4bXTTbl/b2VQURrj8nyU1
	G886Am/iEXZ4Z/wHGvp5prWgi6xyKxCkZV2FEMSOvLWV6AybaZuoNyuBxQ6wES+6
	fCaD22TSJ10VX2XdT/pj5U8PUM0n+sJ9mRgJapEGyeyEHnxw4ED4exGvWCfYKWiM
	ZcQVShZ53aEMvw5WuDvMRQz9+gy7ZOvXV/veWz4P5uLDaTli19YylyO198eFua0g
	Oa36EnFcZmeUTcL6I9zXps/LlKCdadj9xF00yH4J46d0LIylhmZIbC76LVtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747069753; x=1747156153; bh=k5/wbYgTCeQ3iU4UPud4FMRsgf/YiAPPO3S
	2AoQ32bg=; b=ffYt6Mk/qzPN4CaWN0lB7gnmPbg8JzGKGSowtxOrkp+79Cizcg1
	d2AFNhby3WRfwB9XPPSwtGrNoLdrvcMuySKgHTq71fIE+fzjNDBoZdm+OcVAcmkp
	vQVbla7o8nvixsHAeD9junHJzPzAjwPWjbBYcrDwhC98f2NlMCdTFOvFCU9eSyCg
	1uayaQmqfYhhWD1ZRGpnPz69NTmkrmBo/8NHRGndutSMvzMO7g7Oj7Z8KMGP75ea
	pA28z21o9nhBLjejX93tJX1Wke/NslLhcWKF2hD5lwHAEsmdk4ccvjvJ0IO//8rN
	qRjbjY9HU4vIxFBjdw7RA9kqpLITpE383kQ==
X-ME-Sender: <xms:OSsiaFOAuQ0UGzq95BwYpwKql86Gtvxj60JT7cgIgnG1uj4DGBWzJA>
    <xme:OSsiaH9RwA-uq4QIcea99UTxkfvpUpTTj54lsnHlzI_C5eVQtRir5HzZkwNNmZZ2R
    Org1KwDPF_PeSqEjQ>
X-ME-Received: <xmr:OSsiaEQlj7hcpCoEWtVWXl0dYoL0abLV53uL21qyM0JUUwpMjIprAac9xTFoT8MMS_OPgEGauBE0JJ_GOZVqtameYcovC2y_TvRfIa4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddukeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehrohgurhhighhorhhsuggtsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:OSsiaBtiAchse2ZHUku5FQk8MRgLbTLrZhVLcCGZ8qYaFkq7eXR2iA>
    <xmx:OSsiaNfL4n2Xtal2ZMKO4f92Q6QQD6J6IZiPJvGTeZSYzRpuxNa3yw>
    <xmx:OSsiaN2QzjmzLiqM6M3BFcn4RGzfw-dtBeYXjZApF2ODVIMIt3sF4Q>
    <xmx:OSsiaJ_Nc9ehGtXcRs0OpR7zfkFNX_fpXBg_7dFWdvwQ7f_wXWdH1w>
    <xmx:OSsiaPrxscPCRsfEUMI_L2x_WWv6g9f7YiRkrEDlRyZefw-dKODTcYFW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 13:09:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Rodrigo Carvalho <rodrigorsdc@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t1001: replace 'test -f' with 'test_path_is_file'
In-Reply-To: <20250510230909.65519-1-rodrigorsdc@gmail.com> (Rodrigo
	Carvalho's message of "Sat, 10 May 2025 20:09:09 -0300")
References: <20250510230909.65519-1-rodrigorsdc@gmail.com>
Date: Mon, 12 May 2025 10:09:11 -0700
Message-ID: <xmqqldr1u56w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Rodrigo Carvalho <rodrigorsdc@gmail.com> writes:

> 'test_path_is_file' is a modern path checking method in Git's development.
>  Replace the basic shell command 'test -f' with this approach.
>
> Signed-off-by: Rodrigo Carvalho <rodrigorsdc@gmail.com>
> ---
>  t/t1001-read-tree-m-2way.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
> index 4a88bb9ef0..2e8d9384e1 100755
> --- a/t/t1001-read-tree-m-2way.sh
> +++ b/t/t1001-read-tree-m-2way.sh
> @@ -362,7 +362,7 @@ test_expect_success 'a/b (untracked) vs a case setup.' '
>  test_expect_success 'a/b (untracked) vs a, plus c/d case test.' '
>  	read_tree_u_must_fail -u -m "$treeH" "$treeM" &&
>  	git ls-files --stage &&
> -	test -f a/b
> +	test_path_is_file a/b
>  '

Obviously correct conversion.

This is an ancient part of the system, started before we even had a
"git checkout" rewritten as a single command, so it is not
surprising if it had quite a lot of antiquities and debugging
statement without much effect, which may be subject to further
clean-up.

Thanks, will queue.


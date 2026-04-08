Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB9C2D8382
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 00:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775608926; cv=none; b=Op+j+cMyJL1beJ1YJz7TQFl72gvKvhhYGI8dWaHdZRBm67C0EN+xK2ECEZsgFoNDRPNeByvVA52InEFUsIilad0hP/GN9mLxAoP6f5hFXnOXjuIrXUWfMkbcIDFAlyvUMFK2nkbYp6vViBXb+NadIvEG1qKFWV677uqE7F9oOfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775608926; c=relaxed/simple;
	bh=ZhLANxvpGRb2mYYUgHMisf1qlbtPpVimHu3e1cn8knE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P1rTzPGcQiViQaC0/Gz9KfJIZIvAroLsBa6lyM+HYefsiHLRMK4eXLjWGXvZDCKnMQLBjXLveiPkQeN6RGTCT7WNZirysCVkL0JH++V6pQSEl2BdfWAfoUWldbiPDccFvF+40R0NOsn7WGs7lLvMWbRLkz2RfDonxV3y57Diq6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pMO79tX8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P6an9Iw+; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pMO79tX8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P6an9Iw+"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 6E416EC0175;
	Tue,  7 Apr 2026 20:42:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 07 Apr 2026 20:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775608924; x=1775695324; bh=+rDvPzXwaf
	4bVvJ5zSr+yjMiNR4rMVGN6NSYkXbrFX0=; b=pMO79tX8DHmz7TuaN1EU14e5L4
	K/HaF94d0OAIxnH3/t3l+AJ6y6GbTMYFEpc7w4PcGPpWCk0/q+f1bsMgBf+g0Coz
	oHD477QJuecM08rbIC3/Ezh0sfIMlMZs0JyXYRJhyuNRX8SU6ple4pq8piuF6Lgl
	Pz5F63Litr4jlA8UdNoHfBFTe9F5LjtGpr7VQ2BKVJuowprmoQbY2lMyTp4ch7RM
	iUCzgSoj74MZS/QUXLilOJd+R0I6wAYMtLr0WCjIUiT0Ti25phLM4ccltRT5025c
	qy8clgQ4n0m686fl9WL+GAsY09q06ExoH2ijUmxXnbYNtL7BWSeJtYFvynWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775608924; x=1775695324; bh=+rDvPzXwaf4bVvJ5zSr+yjMiNR4rMVGN6NS
	YkXbrFX0=; b=P6an9Iw+DXBxYaAps1mHgibDbrYek0dFfRKaGCIB2DAqbxbKTz7
	jFSVNbx/91udGRunSLWOWQqFRtGS1Cb8IHGJa4itSQJxUOnr7gnWigwVXr7z8dPC
	qa0T7F+lmjC8C3b06cYgVRpUiJkhEX2oV9qP+spg5y2Q0DOYIuIKZdBfeu0uBFmO
	4VYepdLF7pFVuvrT3gUj1ChQzylBx7XCZylSblUI1Sb0vZgiY++fkCzZc5U02pWh
	tzvbf4BCwGjrQKpJ43YzR4QaLcvawQvOHFZ+PhaZtfdjfLoXjHsmLYnqKoiMR3Ii
	AmF2NYbeqEQLUImgNG832u3HHq2gfyI13KQ==
X-ME-Sender: <xms:XKTVaYiC8N81luKaa6VK-pV1q5xWATwRDl3OuwTlq6MmbnEPpILOzQ>
    <xme:XKTVaUsFf6sDHkXZT8PTCOF6LTt96nrEcQHszryizBhn0lTDzzrncD9JbGM2qaN6C
    LQ9b9SpbCC7ee1e_z4MaKjfILPy1eSJicosiFLf2Y1NJh91FMScey8>
X-ME-Received: <xmr:XKTVaZ79vVeGxRd0YFbxPGgMw88Vrzsp1WeWgu48deTYyptluriZrC6g3wLOqNGgaMUJt_9kp0pPKpBNT7YA5Clo5PqX0zp6cQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvvddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheplh
    hutggrrdhsthgvfhgrnhhirdhgvgdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:XKTVaQNgVsPo9EKW20EY67Nz-ZJ2hkgiRPHA_NeFaesdQLra9QNfsA>
    <xmx:XKTVaXtiQ0navsLuVQLfGxXoA0ShPCJgiCj_mhNzWO632_k_ZHc8FA>
    <xmx:XKTVaTaPv75lPD0AJ5VxYY-ZU281jnpzOlgBIejbLqaKoqd9jS3NWQ>
    <xmx:XKTVaZz0CjpZGUJee1YY5Y2949PCPgcqapszG7cbEmSkyyKLMSGMNA>
    <xmx:XKTVacLSJgp1M6Zt5rhUSuNWq28hrfo3idAWLTddGVZ0esdS9A6FtX7o>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 20:42:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  peff@peff.net,
  luca.stefani.ge1@gmail.com
Subject: Re: [PATCH] object-file: avoid ODB transaction when not writing
 objects
In-Reply-To: <adWGjWNTXlR-glgt@denethor> (Justin Tobler's message of "Tue, 7
	Apr 2026 17:41:12 -0500")
References: <20260407201730.2526914-1-jltobler@gmail.com>
	<xmqqo6ju31wx.fsf@gitster.g> <xmqqfr563099.fsf@gitster.g>
	<adV-NI-t6-jgJK7D@denethor> <xmqq7bqi2yux.fsf@gitster.g>
	<adWGjWNTXlR-glgt@denethor>
Date: Tue, 07 Apr 2026 17:42:02 -0700
Message-ID: <xmqq34162sh1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> Thanks, I'll make sure to double check.
>
> I'm not sure if you already included an update for the test per Peff's
> comments, but if not we can do something like below. If you would like I
> can send another version with it included too.
>
> Thanks,
> -Justin
>
> --- >8 ---
> diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
> index c1dbc6359a..e1d35170de 100755
> --- a/t/t1517-outside-repo.sh
> +++ b/t/t1517-outside-repo.sh
> @@ -93,12 +93,12 @@ test_expect_success 'diff outside repository' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_success 'diff files exceeding bigFileThreshold outside repository' '
> -	cd non-repo &&
> -	echo foo >foo &&
> -	echo bar >bar &&
> -	test_must_fail git -c core.bigFileThreshold=1 diff -- foo bar >actual &&
> -	test_grep "diff --git a/foo b/bar" actual
> +test_expect_success 'hash object exceeding bigFileThreshold outside repository' '
> +	(
> +		cd non-repo &&
> +		echo foo >foo &&
> +		git -c core.bigFileThreshold=1 hash-object --stdin <foo
> +	)
>  '

I'll redo the material with the above.

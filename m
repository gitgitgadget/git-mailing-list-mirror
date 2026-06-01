Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CBD340407
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 12:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780317194; cv=none; b=Xm1oSGwMOHdqBXRFjyjGO2UeXpD7OyIisc34yRFjlWjLkIwSasCqtr/1SQR+hE4t8IHNpxoU2F5ZsYLb8DREk8km/b+rz/FtyLWkEywZRV0LSPVLFGn+YRiGIQnBkNxElFh4K4ZJSNERjVPgpCZ3Z/PWROw3/jFme3+gq0mu6G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780317194; c=relaxed/simple;
	bh=XX9nR2NAJFYbrkwGjGgiHqcooAH+DoOoMx44dkmR4uA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ocISaWm8hFIbB7Ci6327Uj7BKWQx8q99LACmMRkUoeP2KoLZ3y+aWC5fXlULo+suAPVgjd+usJDYUPI41ob3G/R8EJ4Tk9yeHGuoP4tGX5mnF64NTX/kuxk0NWfAKj0IZdGOU53IOqLl5cbDMYqfzVFHn2KaIk4nCoVaQXriJWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GOrgyuPx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DK39pzWL; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GOrgyuPx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DK39pzWL"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 0C2F51D003DF;
	Mon,  1 Jun 2026 08:33:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 01 Jun 2026 08:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780317191; x=1780403591; bh=/yJP+ujlW+
	z8p+xVRQrgUmmAbzWra0ZtOjWue49SPkg=; b=GOrgyuPx0BUbNzk+/0D3ZXkNLs
	xeisuFR8rF7LftT1YA+GEJ2/OpUmWKI2Duj3fn3s5vTpEj/mIQsCwcMi4HP/NXQV
	LgopLJ4jvmim2RCPzoqU7nsFxlUMVrOhdi1KDepx245uQNvpo45y22kKG0cjHld9
	nn6/EqZ+MQCXuy2OZlVxsv8MMVyWEVdufvuzhVBhyuKbw2iY/beBgIc3gHCi3X6R
	mAMxUTnZPuPpHa52CsitgBTP9bIJ/IB3AyyPeqT64I0ESU/kRskzwdHNFYnDa440
	MeocvuljhSfHtimjss0Yv2IRu3uyMZhUEPJ0yoNN3FCc7rR1TPIeKg2sazww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780317191; x=1780403591; bh=/yJP+ujlW+z8p+xVRQrgUmmAbzWra0ZtOjW
	ue49SPkg=; b=DK39pzWL6AMWppqfuKmO1cFSd60/4FgiFwW07xB2wbGRNjTFVBu
	EaxDAIk8lh24kg3HuutPBuCMQW6k58ozZMrnllswXMsr3eGMKWkRQN/V+oDHlzqY
	P6F/KgMhNirLGFQ7SFOoMKzvyN5QYOSB+8j28qFCtnS4M48U1zh140gqEV2Jl4oI
	VtvMF1rQ1hjg58VcQc8gHCdzxK95LaPohYwudLFAFGK6h2QR27auSR3O8EZZzSmK
	Ffoar5VpyhK59cYuB/v5TrxSAwaD4iX7JgcueoU9v/RCZUWpuigf0cjj/fNDswwF
	IywjhzAagUJpzTECbXqusQ9YjuYlLyXwt8Q==
X-ME-Sender: <xms:B3wdanrre2KCAbgXyc_JbbgkT9wXeO7SEeKoz9E4RLEX772ML-dxVw>
    <xme:B3wdaoqf-YesxVi_skifdu9fL1d7G2VbkQjYcfQY_fFGdS_NADQw8lghcvWNCIHwu
    uhgjaCg8s74hCDEFVIssDBM7vlIFTlG4h_3t-DhYJ22VVcuOucq>
X-ME-Received: <xmr:B3wdapP3wFc92BRuKp1shNTg5qXkq5D5KpId8RAEYLwtO8spNPA2w4HlevCSPfB-EJ8RvY91V_E9daXUldXJ8TIf18FfrpgtfQCz>
X-ME-Proxy-Cause: dmFkZTF5s1yzJMjEQDQz1ZJYuoNhGEnge7avUBIvzvbHQVtWbluvrBF52YLgLeK5qtk//w
    Sm2eFvIIlF36rMjyzs9DOI7EML6qHLP+K62V7WijD5FcwBysZfWBJ5tlL4I6ifOGWRVRL7
    Z2BINlxSQX8Go1NUI6gkw2xTeLw0AQ43eVfdXHdo1wE/6yu4Dn6r26m0vrcggev4lOKDr1
    KrArV8eRSfWmxVun9vI6nPkP7+AYjFnIQDJUv2GW36vQMD9prBZ3mrEeHeLfwmOZI48zRb
    SHJLUSI8hhyrkL32s/8KtYyFwqxh5Glfn5xRhkos/ptGXDv+IuwGMMIsSK43+1rFH0ZuWa
    QMgrihXe2cfwB5zpxRNtHs2GAjFpGMSgBBtTFT0oqJdqT65gxgh16piaT65R651iBbsATQ
    LeUi7JmHPKdI5hMY/928USkGOeEV0vPuBf03UH4Y/Jz/6GzX6fW3VM94rJkj/4owqmT39t
    NChQtwllzRZe8+QTtaE/U8xf8wDhyolE/hcLaE2MhSBGeGGARwW6DRAN+Pz8v/7AUQF+yO
    ZBVg7yZPpzHaRYedtwn42ky9o43L4hLMVFmq6R3HsY++DHwYiRemfOppXmxxwpt7d8Pjjb
    HcOglBEkJK2/6KwbyOLTe3ef3/UJIymW8/ENIefMcMZm4EbD0E4C0u519vzg
X-ME-Proxy: <xmx:B3wdapyJO0qQ9uj228owYHenKV7rTIngIEL5jtiLYWG-NB0ezpdhXQ>
    <xmx:B3wdaiv1DOrARMQEK7eUubdSdbbv1cOEFFadnlHvAScGgNgIkaZiwQ>
    <xmx:B3wdai5TA-jydxCvoqlhCZ9S_xIqK90Dr9HuFHbUuI79KHR9buF70w>
    <xmx:B3wdahTSeODfgX3BZB3MCY8UUqU2uWlJg6GvLTzVSOebzVVD7kTEqw>
    <xmx:B3wdaosz-5Z0y8e_slGxJuOwDlS4wOcfBpsZVD0fI23uvkyZuce_LIGI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 08:33:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/5] Duplicate entry hardening
In-Reply-To: <pull.2096.git.1776731171.gitgitgadget@gmail.com> (Elijah Newren
	via GitGitGadget's message of "Tue, 21 Apr 2026 00:26:06 +0000")
References: <pull.2096.git.1776731171.gitgitgadget@gmail.com>
Date: Mon, 01 Jun 2026 21:33:10 +0900
Message-ID: <xmqqpl2a4f09.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> We had some corrupt trees with duplicate entries in real world repositories,
> which triggered an assertion failure in merge-ort. Further, the corrupt tree
> creation in the third party tool would have been avoided had verify_cache()
> correctly checked for D/F conflicts. Provide fixes for both issues,
> including 3 preparatory changes for the merge-ort fix.
>
> Elijah Newren (5):
>   merge-ort: propagate callback errors from traverse_trees_wrapper()
>   merge-ort: drop unnecessary show_all_errors from collect_merge_info()
>   merge-ort: free diff pairs queue in clear_or_reinit_internal_opts()
>   merge-ort: abort merge when trees have duplicate entries
>   cache-tree: fix verify_cache() to catch non-adjacent D/F conflicts

This is a fix to an important corner of our system, but somehow left
in "Needs review" state for much longer than I would have liked, so
even though I am officially on vacation ;-), I took some time to
read these through (by the way it was a pleasant read, thank you).

I wonder if we create a rule like

    Those of you who have more than 30 commits in our project are
    expected to review one topic (or more) from other contributors
    for every three patches you send and ask for reviews by others.

it would help balance the patch vs review ratio, perhaps?


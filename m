Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D043415B76
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 17:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270119; cv=none; b=Vh4axWbhNE8BM9/gV/ksQbqp1lWsEpi7UmcMIBoIRUGgjTK1VMy//il4M3Fqu6A55WCRu95FlyzbIBS6gaxJgynMYZ/j4v4c9bsQ1yQqQTqBmYXhloA4oQDFVILxYNrSxDDdx6dhw1u3tBqgjdYizWzoMvv9j2jcMeLqrtIbrw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270119; c=relaxed/simple;
	bh=T5paz5tAaHrJy1ODcPHkuHae0oRDdCub2VLztQRX5/4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UULO451zaeJrNnvr2urRwGs46qeVlbu7EfVE7o9TdyFQTgfk0cKFwN9mgoNEn4I7jQfW5L4GiyfPJhIzixNAyJ3BOmMPOwyZgn6P9MqTEi+3iZy3H8DbGF19Gwz2zIDFPS1/vV/mDtW26QOk1DSirJLfnwRmq6v1cl+Gjp6XNgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=m7cBzKgT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wndJIuvD; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="m7cBzKgT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wndJIuvD"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0B693140012E;
	Thu, 24 Sep 2026 13:15:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 24 Sep 2026 13:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790270116; x=1790356516; bh=nS8HRLMfJ1
	QY2ZAE9xCg206k6p81sD9mKzaoEIfaXkU=; b=m7cBzKgTpqViWWuvDvGu0f9ua/
	CpLcDUlcXOlXsDazHV7bsx+GdW3lLpj4WVt+WvFWzbm3+mvWLauFUIuSy6r7x/Gd
	o6TntsJ+pC2jNdJ9DuRCEH9cLI88DdYV+eJAU3net5lXE6InEOiwqcXC60XqxJh2
	4J1FwawgijrpB23txr/Lne9YpW0FRlWtkmX6PCJ+WPbUzv2e8CQC/Nw/DMEqvNPr
	ZOasmbikGSqqIaagn3s1L1AiNik3+llltRw9WLYYQarrKbMw/lIWbTXezkTZiseE
	kaaKeEgz/DJGC5pdqv9id3+qpyUoVdIwHjrEFQX2K5nqeviaoRmScV0CxNNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790270116; x=1790356516; bh=nS8HRLMfJ1QY2ZAE9xCg206k6p81sD9mKza
	oEIfaXkU=; b=wndJIuvDB61iEVHyLgRO7scsNbALHPf5Hs8v4it4PreO+LvmwJ9
	DqmNC06sUnpwOuAKExY747Noal5KhhDeZSRZdb9lbbs0iqtJQ4c+4wCZxWk51x6D
	CPDT92CqobK/TFfd3UJwzlCbdJLHUD9yzlilCySbvF1HR1l+6FCh6Sa5LE5J8Xc+
	bTHkozC+m6T4WT46bG5wOhdJ5XPQpxEiP6I2Yh1WAhg6QmQfmyy5qShkNPmG4F6C
	sdSTj0htkpGLjUpn6q3q5ITyhOlRTGKnqKAhRQH8hOZ1Q93c2seud8kTMxBXFOQv
	Gn9r+St31UzNNaK/CEn5mkFrA8bmQJkNamQ==
X-ME-Sender: <xms:o1q1aiI8p-Ldmh3kcT9pK_Wj68a2SEm_ADjifVYlI0IDpPaS5bunZA>
    <xme:o1q1ahANwMeNR_M0qJV6o4be_7ZPHyLXSLSts51SC4P9OU7bU_bB7yraZ0e2H-CbS
    Dec1KazxfzlcqyXCWdwiTfBGu3OvR_yZp-zKr1yHhP99UnQl9bjSMw>
X-ME-Received: <xmr:o1q1arCCVCYCMv3_jzv7cIyYMIfnTE_UA3fLS-SRyeNnWrjl4oxZy5deF_4Y6HnsNGWtPJGIwtHSQxkCAqcql0uvCCjaKA92EoaC>
X-ME-Proxy-Cause: dmFkZTFmoEONWBhib2oJSGtIJaXArpaoqrA+5uJaY75psgF6Wmgo00IcfNL5kdW9d14cLA
    OO/iZdVgHcPdvlEi1GHh5QU/1gEzCl0gIKr+nkVgOc8bAsD6iMd4VGwiUdLuyaHSd9dOq6
    ZZlr2bVsMe8aXIiz/cgMjrcfmMpq6NQFJaE6W9y/4jm55oZI1xmu4E3N70HdMBxbHrog3d
    O1J7SITx8Ot68iO0jVduKsmDTksG10aqqputCTRmGHnsuFUBM4kQqNSFhjLfAVgUD5zqmz
    lKYSbT6RT8HV71kjCN7L8H6+avgL+l5z2d4HgtdVUkk1610gJnzH8bPpWhBj7Y24fYmyUM
    8V6LItscEbl+sA645Vaw1vDzWHyj/FRjmMVtaH+hH7Vs7zOLvdchTlP1HkqjhHy+U3Y28p
    aYM+piwoKMQ9DNGmkRUajm62pKL11Tnt+Fh3C9aDBJdyRoqUZHrCxRYbiEzlLjD67l/rqe
    ke0arC1fyoz+GiLjMC+XGbfgTIGz/sEKHNMjgBHnhDFt+Sv762Fyx+4GJn+CD3pA/XBE/k
    CCU/cdpUn7bzQ0jSs2ZdHYvQSwbuUqKsXDIhPwL5NXjSXn2Hn8zGa5IJZ9RL3fR8lAp4zY
    zvqZj9zjV4ZmXnvXpqr5DkozVRX+HrLFZlXEmgFWU3MzjxAHygNuu2cI/fvw
X-ME-Proxy: <xmx:o1q1ajDvRt-zjo_2E3Gp7cgiXgas1eWaqbjc163JeJkDTUcIdiypYw>
    <xmx:o1q1amq0biH2FHYqqKvLOgtqCuhol0AtzH4E_t7SEOxO4l3ovj4fzg>
    <xmx:o1q1atlm7vNM2OMPJ-yUzAcJDl_llw4UWH7zW929VWRzSQ9uZJNkNw>
    <xmx:o1q1amwILmENpGGGFNBtf7HpBrwVaagj2V_1Qgh_VlMNP1XCTtCqtg>
    <xmx:pFq1ajg7zOWbvFJqyj5Q4KDaurEsh5YB-CbvCp8kqQwXIYNzMfHqDV2y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 13:15:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Jeff King" <peff@peff.net>,  "Julia Evans" <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] doc: add more AsciiDoc cross-references
In-Reply-To: <63520573-c8a7-41bd-aaeb-bfc2b5e43856@app.fastmail.com> (Julia
	Evans's message of "Thu, 24 Sep 2026 08:30:31 -0400")
References: <pull.2416.git.git.1790105342890.gitgitgadget@gmail.com>
	<xmqq4ifhdon2.fsf@gitster.g>
	<665e8f8d-7bde-449b-a390-10875135cba2@app.fastmail.com>
	<20260923214038.GA49087@coredump.intra.peff.net>
	<63520573-c8a7-41bd-aaeb-bfc2b5e43856@app.fastmail.com>
Date: Thu, 24 Sep 2026 10:15:13 -0700
Message-ID: <xmqqse2y371a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

> Here's a revised commit message, can submit that as a v2 if it seems correct.
>
>     doc: add more AsciiDoc cross-references
>
>     Instead of saying "see EXAMPLES below", say "see <<EXAMPLES,EXAMPLES>>
>     below" to make the man pages easier to navigate on the web.
>
>     The reason for using the more verbose <<EXAMPLES,EXAMPLES>>
>     (instead of <<EXAMPLES>>) is in some cases, the HTML output is rendered
>     as `"EXAMPLES"` or `[EXAMPLES]` instead of just `EXAMPLES`.
>     So this gives us more control over how the output looks.
>
>     This also changes some of the HTML IDs of the headings from `_examples`
>     to `EXAMPLES`, which has the potential to break some links.

To see if I understand correctly, let me rephrase the second
paragraph a bit (not as an attempt to offer an improvement; by
restating the above differently while expressing what I take to be
the same thing, we will see whether I misunderstood what you wrote
if my version ends up saying what you did not intend), as I found it
somewhat puzzling.

    The short form <<EXAMPLES>> uses EXAMPLES as both the link
    target (which is not shown to the end user except in the
    browser's location bar when the link is visited) and the
    clickable text.  In different parts of the document, however,
    the text in HTML may need to be rendered as "EXAMPLES" or
    [EXAMPLES], which can be achieved by using the
    <<EXAMPLES,"EXAMPLES">> or <<EXAMPLES,[EXAMPLES]>> form.  For
    consistency, always use the longer form, even when there are no
    such typesetting constraints.

I'll mark the topic as Expecting a reroll in my working copy of the
"What's cooking" report of the next issue.

Thanks.


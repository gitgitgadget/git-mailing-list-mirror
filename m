Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2921F427B
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 18:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736275267; cv=none; b=leu5oyZ+GjZQcw3jy3TYyeCWgZ0RT62rdbkovc7MFYg8thsYmnSjLraCjwYnyPwfosMNt9Ft9VK1PEizoyoAMLUhFEUtjqQhbJGChuaQ8RgmDyAYwUN9g8Na3hpWcupS5eDCzJddFzsbgWIPeU4AcrLGTtoAaZieC/Xi0mtfZyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736275267; c=relaxed/simple;
	bh=EtechFwDQ2vc/LfkHd0Lz+uhEdl5A4TR03CvGbm8TN0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uD0sPToNqLxr9Gs8Uf8B//KTje2gFKKbaOzJ0n18jFFAwl+E0gHGieD96HPsf/qFN7MpTAFL+UUkgIZSDvhRYHf46XFViujC5SNrYJIymlP32peXXEspeNZMt6qbi0a6vZAtALX0U3n8nakh32xrQ8CNVUTGksNK57PJwTMKW5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lXLNsIn0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o3RvL0tY; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lXLNsIn0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o3RvL0tY"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A458F1380263;
	Tue,  7 Jan 2025 13:41:03 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 07 Jan 2025 13:41:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736275263; x=1736361663; bh=Y8sEhzGkcZ
	sM34zh53LkW7UU8CzW1IKAi2A1UzVNc/A=; b=lXLNsIn0iMGaHqMgjrFKwYmMV7
	oNqq7ocJWHwyUjrWIj1nWWkOGtm2+IRJFxCsWWo5CJ2Rth3dN0mcun/lVgrOyCQO
	+t5+Thm78B/00siYszdQ7enKdgtL5o5iMvlcetgZlu+NS3gXbpnqlAsTm7vpHyTh
	0do4ifwMiwWe+9t6GxQEIZRBvKRA62WllqdwFKmJsGdeP6ArMH+0tPK6wvzl+rgq
	JqjwYWUq+nVtZVkxfKX8pv1J4zj9ZnWhpC4gaDF7Hf0IKtLKsFks500hjh9EBbn3
	V+8VtWnah0dBpl70MXkcuuKGaeO8B947qvzDsIvrJGbwM22zqSvtGf10PJWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736275263; x=1736361663; bh=Y8sEhzGkcZsM34zh53LkW7UU8CzW1IKAi2A
	1UzVNc/A=; b=o3RvL0tYkYWo9cVhA6co58Z7bRUyOS3/8zhgrw24QgRu4cz1gK/
	kb5Ej+H8jppFg7Rvbtvf6Z2BQcct4Lci8VXQxyAiN4lqI0FxNV/zbnLSerGJEf7a
	sTBmBlApWwr3sp9FzyeXjY1gDIzGCdQf1OwiALMcsYlMbE6ozEDh7aJaf2iBgcjJ
	ekSRmvCa8E/WkTY+A7NmxAEd5zvauqLvA+FzDG2PUqRW5Oh0WPOBQiIWO4THX3MT
	NIOgrCwWtcjwNGhJcfyNbFqwSFSiEIA60rPcp+luYWO7VauQpBMyLlm0vhye55EA
	Q1DoVqEfPJ1L0BdMmdZe1Z4Qb4CXdi7F8ZQ==
X-ME-Sender: <xms:PnV9Z_YDg9VeWmxb5vekDaBXm_n2npIBFYl0LsVzJ5MLQMczO4V8hQ>
    <xme:PnV9Z-bPFeHFSHXTffLJjErdfJBCUsxhjP2rZgRCEyH4_P4edwLmQYMFZtzzoZx2A
    niZrhKV-cZjVolI_g>
X-ME-Received: <xmr:PnV9Zx-BeoLIFBojMnOyr2SGc5TA8pI-ZBy-TJsLEd4x8MWh2T7KL2ZXnQzygRDH2vIA5KmAROiujG84v8c1-Gf20uKPU7_XZnve>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkuhhfohhrihhjih
    elkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehphhhilhhlih
    hprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:PnV9Z1pAos2Cz7kRc7uicOCtTXrnyBv9y6noc45tjoVZxw1qo9GvJw>
    <xmx:PnV9Z6oGIu99C4TGQ2SQ3JaSDvBpiwTK0BJR20JB8aQUgezS-47zHw>
    <xmx:PnV9Z7QuGHUnNSNmEWYzRNYcK_zwF0weVUtPN1XD-T04QefTTul1mg>
    <xmx:PnV9Zyoszy0wi7qoRoJwBtw_3oC4L7CXwkVt1bBOsYHcfNyi2nyY-A>
    <xmx:P3V9Z3Dinu3TzaCH-Yh0DeeUSdEyFMY7Vj5ciz2NBO66hI9ZigE6JpRs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 13:41:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] t/unit-tests: match functions signature with
 trailing code
In-Reply-To: <xmqq7c76trpa.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	07 Jan 2025 10:16:33 -0800")
References: <20250107091932.126673-1-kuforiji98@gmail.com>
	<20250107091932.126673-2-kuforiji98@gmail.com>
	<xmqq7c76trpa.fsf@gitster.g>
Date: Tue, 07 Jan 2025 10:41:00 -0800
Message-ID: <xmqqv7uqsc03.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> A quick peek at [PATCH 2/2] tells me that this is not even something
> that would make it easier to port the existing tests by allowing
> more straight line-by-line copies or something.  The patch splits
> many in-line test pieces in the "main" into separate functions, and
> it does so in a rather unusual format, e.g.,
>
>   void test_hash__multi_character(void) TEST_HASH_STR("abc",
>           "a9993e364706816aba3e25717850c26c9cd0d89d",
>           "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad")
>
> where TEST_HASH_STR() expands to the function body that starts with
> a "{" and ends with a "}".  It can well be written more like
>
>     void test_hash__multi_character(void)
>     {
> 	TEST_HASH_STR("abc",
>         	"a9993e364706816aba3e25717850c26c9cd0d89d",
> 		"ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad");
>     }
>
> and we do not need this step at all if we did so.  Such a construct
> would be a lot friendlier to the editors that auto-indent, too.
>
> So, I do not quite see much value in this particular change.

Having said that, if this were more like that you write a series of

    DEF_HASH_TEST(multi_character, "abc", "a9993e...", "ba7816bf...")

and they expand to

    void test_hash__multi_character(void)
    {
	const char *expected[] = {"a9993e...", "ba7816bf..."};
	check_hash_data("abc", strlen("abc"), expected);
    }

then a preparatory step like this patch _might_ be justifiable.  You
may want to avoid having to write too many boilerplate, and a
special rule to find "DEF_HASH_TEST(name, ...)" and it might make
sense to add support to extract the name of the test function being
defined by the macro automatically.

Not that I think such a sequence of DEF_HASH_TEST(), one per line,
is an improvement at all (it also is unfriendly to editors that
auto-indent the same way as your original version).  I just wanted
to say that a change to the pattern to pick up the function name may
be justifiable if it were so.

Thanks.

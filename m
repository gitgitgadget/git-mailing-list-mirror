Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EF8318ED0
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 23:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770678875; cv=none; b=elEdBiUcCviVvRuZy9d4dXTzsufCx6Bl3SMob7UiDxuNvrnlq5yxMCI/6l4YUi810iWVrmqSWmbFvNGU5fMYpn0HhGhIG0LpgccQKe1tkqNWhnUHcUnPBNe24MM+TLsC7WdxCaxo4hro3HZ7bPyVMJt1h5cidb06uikq3Ch5DSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770678875; c=relaxed/simple;
	bh=OenXSpbmP043oImIfxcerqePVLxqTrYakm9mAS1KOWE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D3q9KzGYQ3OO1RHB1Q/W0eA4TPs6lzmPnIl18WXcRU+azn8eJ3VP9SECRUWMqehbXr2kKLME2dM2W5DiLAHt0LnAO0UGRlMjlG/QMVupCbyMQeCIQPCMc4gLnNuqkrWeG5qH0j/lNGsTEqcVIVXEGTe8C/PPK21fqpNt3hVdmCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ogYHefce; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dXku2Is/; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ogYHefce";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dXku2Is/"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5F7D71400176;
	Mon,  9 Feb 2026 18:14:33 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 09 Feb 2026 18:14:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770678873; x=1770765273; bh=lne8hlNgyx
	qxLh9fnRPvCI+1lxH2yNHcvXwwO++VT3E=; b=ogYHefcessllRxPcM7NECx1QdY
	3WMsS41Z5pYJX1CFZIUVJA9TJi4hna8kxB0HEkn+xlOWUzPuAwgV+h9iEDA6+lN1
	DNWVkJdZFFK/dRP35mN2ZUH/9tGouU9r5cvl6A0KcsuCiMkl7hxbwcapLYRoaxyQ
	zbgAcQgjt+g8gzjMYTi5DS6JIsyJ+gPX1PiiYRjU0vcnFvZwudUkCeVWoF5GYkgL
	pTIJmz4czTNsIwRu6BTRCk/RqDGV/9/w5Wxrz1bTjYWr9OL0If1FfcoB5SnbBkgp
	nKG7EmCO1A65/ddq0pz1ejo4QRHWChgvxriks3CT7Mnmpm1tf0HZF/cZPfKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770678873; x=1770765273; bh=lne8hlNgyxqxLh9fnRPvCI+1lxH2yNHcvXw
	wO++VT3E=; b=dXku2Is/oh/jYuqqVJLhq1J0H4WEeki8BpLY9nFc+CtZQbqnJy0
	ZDf7nC+G9yHVHItd9qOmWCKImwNartq2L20drWu6Z+B77JTyKN9BTMdIyH1ji22Q
	RL3CcSeYCT2/EOioYk9oZC5Hdc/6rgJ+JQGeBSW1AcfE59oam2qrvSGz1Oz8Xt9J
	1apQTWeo1Qbf6oj74pe0OIHnM91OnW4ihlUGog9oviChi+CyBmbWdoOu3wbj9QOr
	kmy2j4aT6056tkwiG5l+UbOorn0Znt0INCuNhaNfGthpRhaJC6kDOF3DKu6hT2FK
	fGZJBcJRUXay5XRjQ0zf56AXUzSB3qC4K+A==
X-ME-Sender: <xms:WWqKaZV_HgYmUq46FiE6Y-fAAWPXEvMKDuquO-QyOFxzCr84LaqstQ>
    <xme:WWqKaQnxJjhpp78qii5rgE2wXENOXSX7oUsmNs4h9HhZo2N4XYQvqD3Zia4PBNDey
    xfrqJ8pVNohb59xx96YnQqvYCkmVpr-k3PknZf4WfOHb3Wo4cw4D6M>
X-ME-Received: <xmr:WWqKaabEWFUgboz5nlDCLadk06xlHe2WkeKBhXfNxu1S4OFoeYKfr1nyYwZ6o34a1W63dFRM6RcyCnXk6VYWQfV1516VkXy_0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleekuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepjhhonhgrthgrnhesjhhonhhtvghsrdhprghgvgdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:WWqKabPsoC1hi6Wpx6SuzM3prWv7O5CJz2i7YQtOmQp8JAwanz8_LA>
    <xmx:WWqKafbPch5uPqod9Cugck54MA77wxevqtr9FK1fqo6l4M2yDL7Q-g>
    <xmx:WWqKaZ3dF3cwqq5LNPbNxRbAZ9B892TtbqbKSKOWhjdFE46eoJonjA>
    <xmx:WWqKaVd96yCwIzlnVPGRA9naRs7oK-iS1-B6Ya-1nLwF1ugQD8YE6g>
    <xmx:WWqKaRUJTDXRa5_xjBgjDd77mBoHbUZXQuf7JUYrNG_-vrVUIxFp6IPn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 18:14:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Jonatan Holmgren <jonatan@jontes.page>,  git@vger.kernel.org
Subject: Re: [RFC] Support UTF-8 characters in Git alias names
In-Reply-To: <aYpiSHSxYS2fUUS1@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Mon, 9 Feb 2026 22:40:08 +0000")
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
	<aYkaepCu4lwT3xNl@fruit.crustytoothpaste.net>
	<xmqqikc66k5k.fsf@gitster.g>
	<aYpiSHSxYS2fUUS1@fruit.crustytoothpaste.net>
Date: Mon, 09 Feb 2026 15:14:31 -0800
Message-ID: <xmqqecmt33xk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2026-02-09 at 14:55:51, Junio C Hamano wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> 
>> > I don't think we have any Unicode normalization code at all in Git,
>> > though, so if you want a quality implementation, that may be a thing we
>> > need.
>> 
>> Isn't NKC/NKD a macOS-only issue in practice?  Anything on the
>> command line "git" potty and "git-blah" built-in commands receive
>> goes through precompose_argv_prefix() to be normalized on that
>> platform.
>
> Normalization is not a macOS-only issue.  Many accented characters can
> be written in multiple ways,...

Yup, but that wasn't what I brought up macOS for.  No sane person
would write the same string in multiple ways on purpose and
everybody would want to stick to one, so that byte-for-byte
comparison can decide paths they created in the filesystem can be
matched with a list of paths they added in .gitignore, for example.
And for that everybody uses normalization form C, no?

But the macOS makes it harder to stick to a single way when it
involves filesystem entities; the pathname you gave to a new file
with your creat/open(2) may be normalized in macOS specific way when
it comes back from readdir(2).  Ahd for that glitch, we massage the
strings we got from the command line and readdir(), which are in the
normalization form D, into normalization form C.

I think the suggestion here is to assume that the users are doing
the right thing and treat alias names (which eventually end up being
pathname components) as bytes, and everything should be happy, even
on macOS.

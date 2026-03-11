Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2760345757
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 17:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773250006; cv=none; b=GWg6WJxUBmJpLAyn6PXy0WKCYycDsVi+iEClKDFOu8D/Mwd1YI2I+mDvYkK8FoGwVO2wyiOvAam8d+XT7/hX1X1uCQOmop+AJh0T4rZuQppTyWBQGfUMdGkxQYEN1rD5hm9QT2wZGvOY8yH6bdLpM/ErQ45U3TaupcJs7GvDAbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773250006; c=relaxed/simple;
	bh=ynyN8zwZetJGa0Lg+PX+WgzQFxgmjy1Pk53X2uxjhFk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=POpPf1LbYG4IY9iIZy17J33Y4/D2MaG3iSig9UY0U4SLbG/a18ZGN8ZRfMcpL9EqEZpXvvOEJ+OrCHqHUVY3uU3vRpwjgsWvbs7yyhFfE8izrro42JXrEziYTMkUJqCywm+5NheN9iPA+Q4RddPvvn7ob/7QWfHQ4974/BSeCo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LiDMO1kv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ip1k3T7k; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LiDMO1kv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ip1k3T7k"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2460D14001AE;
	Wed, 11 Mar 2026 13:26:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 11 Mar 2026 13:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773250004; x=1773336404; bh=ZPC5arugq+
	spDAP2W/D61k75/Dh+Bvd0TW3icZGopQY=; b=LiDMO1kvHOM/NV5QZz53Qy8/47
	Ee2vsky7D2K0RhC4gCV8voDr4QVn16mP5slDK6vP7z3PewNd/ddqSbXdiY6Z70vG
	qXdphBhVWEc9Z5/HTfZGGjwlWv63IP++/0oAjs/gGvqBTYOyzfedqkqhjuxSlJhp
	AAmnlLoehGn5/OQ4FHJL0/rBWjBxUFz4g92ycloe3UAK/JKgZvsKnVuH3Qo0h3cI
	NNAka5hBQV+L0SWOLgi1D0j2Ahst37RlzOmzRBC5+d5j9TY4b6Yiq8wc2gkwUecP
	MLUIrR5veKZU8f0ZjGwHDn74KpZSGiBw5Kbg8cntQyIAxgPQTRgBZgnN4+eQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773250004; x=1773336404; bh=ZPC5arugq+spDAP2W/D61k75/Dh+Bvd0TW3
	icZGopQY=; b=ip1k3T7k1Z6nE68UKk/3hIVRmC+3w4aRK5ZzO/hDbLFL26xSxsX
	8OIVsXk9/sR03nPU7kZv2EPoM2s/22QFxzOtt1SCtIm3WWm3uk2kGyM3R36rN3I1
	BMwjYKxdhiv++AjaIFjzQLWjmSFxW9kMkdKlrklicxM7su995w+5tm29jIBZSD6U
	QAT7QW4f9aYjXHkK82dMLbJGa5L0m52hIiS9hTMw/6O0Mv4HMs2LiZzAoZem7wV5
	6/9Cr8o3U9IYQJerBCqGSeJHbGBdjGOdN9CIbluMyb0NpKQ04KcB31tulIAs9OL0
	N7ownWNRFub7eX7O6uB9i5Vpdz7OPh2XfXA==
X-ME-Sender: <xms:06WxafjNnu35kLe0O0dCjce18-BuuUVS-DVW88nE72yc2JSNgCrKug>
    <xme:06WxaSD6TKOoQb13KuucuCefVPQuyBzeey1qc2lUtLT0WXh3-0sz6do4x9zmMUQG8
    GK4Ij4VYWqr2V7cQusPeSi0uNEe9xDrDfKQfTkbiukL7KYVj_-_8A>
X-ME-Received: <xmr:06WxaZ6ov5kip9qNa4Xafj_N4QrDbbDwqdlMc2Zv4ssHAIdWvw9BQfLRWiuJ9rhrteR4SX_kwKuaLcijBA8-WGonv04ZKbik1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeghedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkh
    hrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghp
    thhtohepmhesghhithdrshhtrhhovhgrrdgukhdprhgtphhtthhopehphhhilhhlihhprd
    ifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehjohhhnhgtrghikeei
    sehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvght
    pdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdr
    tghomh
X-ME-Proxy: <xmx:06WxafHPMuAws9ZKTvrTXBv769It1PdU4Urs89-QL1QP98n1eLd-Lw>
    <xmx:06WxacDRG1bxkwCSEXLYRyW_GN-03LG38enz2Qp5r7qce3zyFyGu8Q>
    <xmx:06WxacxUw-f_3eKNHX6XJ5dxk1t1DQ7dk62tws2cN_72oNzXi00FAA>
    <xmx:06WxaY6muDctZIAo22t2oJUSZIsxorFmtVqIGIW5W1rLd8nFY1f0eQ>
    <xmx:1KWxab9cv9ZvE4qyCdlp0IDm2OtN9YGI9MjjfTx1okCXJRVpcKCHvdR_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 13:26:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Mathias Rav" <m@git.strova.dk>,  "Phillip Wood"
 <phillip.wood@dunelm.org.uk>,  "John Cai" <johncai86@gmail.com>,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,  "brian
 m. carlson"
 <sandals@crustytoothpaste.net>,  "Patrick Steinhardt" <ps@pks.im>,
  git@vger.kernel.org,  "Karthik Nayak" <karthik.188@gmail.com>
Subject: Re: [PATCH v2] merge-file: fix BUG when --object-id is used in a
 worktree
In-Reply-To: <bcbbdcb3-9c4b-4eb8-9e70-3eb0bd19b32c@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 11 Mar 2026 12:14:11 +0100")
References: <86e5c9f7-cd99-4c4f-a852-f3b1ada53722@app.fastmail.com>
	<abATPiRUczb8fe4t@pks.im> <xmqqh5qntpvy.fsf@gitster.g>
	<c076edd0-9057-443b-ba37-33aacde2eede@app.fastmail.com>
	<bcbbdcb3-9c4b-4eb8-9e70-3eb0bd19b32c@app.fastmail.com>
Date: Wed, 11 Mar 2026 10:26:41 -0700
Message-ID: <xmqq5x72qnu6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Wed, Mar 11, 2026, at 07:44, Mathias Rav wrote:
>>[snip]
>> As for the quotes in the commit references, I use gitk's "Copy commit
>> reference" daily and am personally used to the quotes. Since
>> SubmittingPatches seems to give equal preference to --pretty=reference and
>> "Copy commit reference" I didn't think that the quotes were a problem.
>
>> (I wonder how controversial it would be to remove the quotes in gitk.)
>
> Turns out that this has been attempted least once before:
>
> https://lore.kernel.org/git/1472230741-5161-1-git-send-email-dev+git@drbeat.li/

True.

Perhaps something like this patch makes it clear that what the gitk
command gives and what --pretty=reference gives are not identical,
to avoid confusion like this?  I dunno.


 Documentation/SubmittingPatches | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/Documentation/SubmittingPatches w/Documentation/SubmittingPatches
index e270ccbe85..fad0b41af0 100644
--- c/Documentation/SubmittingPatches
+++ w/Documentation/SubmittingPatches
@@ -335,7 +335,7 @@ date)", like this:
 ....
 
 The "Copy commit reference" command of gitk can be used to obtain this
-format (with the subject enclosed in a pair of double-quotes), or this
+format (but with the subject enclosed in an extra pair of double-quotes), or this
 invocation of `git show`:
 
 ....

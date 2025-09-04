Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF76242D79
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 20:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757016563; cv=none; b=szg426NWLCitMRndAN7WWhOoYeLmDXPCo84na6xP4E6CuJ2WwI06RBm4S10P8t3shl+iL/gejn9T3Zxu2uO6yU9k+4kHhGOZ5hE0Ga8zasAOHzagdE1O9OjQ7qDCnAP287GEO/TOjHI7TlFrKRwYygkpDfJ+uTrKZnU5M2YxZ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757016563; c=relaxed/simple;
	bh=wD1IBLQpQww42KT5mgwTy4kSIbTRNWrNEbB3oznED8M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lENgZz1jqTuDw2E9FDqgULUwcaB+6LThUKI9pye+uNGmAiERzBqL/CxIvRfWOKYkLv4vyIP4wVP6ncGi0UpHB4Rw40ceAjzJb11YCeJ+mp1MG9/quooRev1pVlt7YFG9rygCCr6ay4oRhvFJ+IEviYvgdyBvAQdPeVRmFgCn58c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=k37nM83s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gnon9tbj; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="k37nM83s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gnon9tbj"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 475B51D00468;
	Thu,  4 Sep 2025 16:09:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 04 Sep 2025 16:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757016560;
	 x=1757102960; bh=025XobELP02L2pySOOvCGUPWAtBZWWa42TRfGPuoZ7Y=; b=
	k37nM83sCLZXyLJltQQ45DMUj2hE2Uqlt3YAf/rwYJEqeZUxyiy1lwbSMUka66uH
	x4jsmzPFz6onDVaQD9UktzwDBE97o8DPAUanVeq8+fXaUT0AhldxWtvr9mKIVLtr
	O6AWdLH1CTFyUiZ4JgnT5cfX3jJicTUzPhuf/X3jz1lI3YHsLBMXoVYGEKs8pdDL
	LgbYOLNJ4Bdr7b0XvaYHcABT9VZIIMiVWX+P3r19MJfGnYCXFGEzHvIWcvoXFeIg
	Srmx8CRfuqQuS1CZYArY3z6NEqzUnM9ZjjisB9AQLf7Gi6gwKrdHPI1Z6RuAZJfr
	DQCTW2qZhX3znOqG7W1iPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757016560; x=
	1757102960; bh=025XobELP02L2pySOOvCGUPWAtBZWWa42TRfGPuoZ7Y=; b=G
	non9tbjcGMtkNwIgMdjeB7GxcbNUm/3XyxU/ayJvhI3nR+pURs2rzmYz5zFWpEk/
	KM5XaJo+hdW1x2WYd6pSdjeHo0vdoEmsxNZdDBHjXIae/RTGrVVBnBISZeeou8Hm
	Uwwrj5wmaHlUj9M2Iji2akQPhsS6I5dxBbOStyBTVPuc4Sg/xF8gojZPmT2NdnIY
	2w9mXAdmZmRTAR2K1rN6oxfyy+i9bMmxrHk/faCZ8A2f2PieH/YOoTJUZSMvkEGR
	YZAzF1vrv8+XUioOSvcOJubC+QHcUQleXP1kJ0+omJ0PiRZPPqLMT4JdykoEYWmR
	91WTqIRGyRLD6jafUpdZQ==
X-ME-Sender: <xms:7_G5aIkZkMvSt6iRcs7gX_wKjug9hYq8miMLGtsjTsma2ZbDcABOfg>
    <xme:7_G5aLH9FbANV1ym9dxDX3J579CFChQD3dlGxypilqxbP19gyuLNAu5iJ2toSDJVB
    TKr5E0JYHe-S4ARpQ>
X-ME-Received: <xmr:7_G5aAGOQAFFojHHKICYd5__A46f88LZkOxL_VsZ9vkc5JTLLEouNImVGZ8NelRlut6MZeZtsFAbtqG1AXc-FjgKh3dqUYDaDEah5Jo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeileefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttd
    erjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepgfethedujedvueeftddtkeehvdevgf
    ekleevtedvueevveefudeuvdduudeuffevnecuffhomhgrihhnpehosghjvggtthdqnhgr
    mhgvrdgtfienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:7_G5aAPYXrkhAYiquhoe0LP4r0SUh9cJ_FRc9RaBjataXKdb61HaYw>
    <xmx:7_G5aHEsyuqjpzf0z6XjGq7zhFegCrrV1xcxqygUYkziNiexuGw8cg>
    <xmx:7_G5aPN7AQAhuMh6zCSNmq7BOq1Tv9s0JENrf5wUs94mzjSLRpeIqw>
    <xmx:7_G5aA_ZMLeprvMYFuinxuuqgPBIT5epRkKX9UcC8erpWdOujTNIOQ>
    <xmx:8PG5aJUdHGjt7CQkflB_d0DOOIM9FX7kq5Rve-Uo7pXQTwtsJ0SiUURX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 16:09:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] object-name: declare pointer type of
 extend_abbrev_len()'s 2nd parameter
In-Reply-To: <e0bc9a67-faa9-4218-a55a-c7d53c15cfce@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Thu, 4 Sep 2025 19:58:25 +0200")
References: <e0bc9a67-faa9-4218-a55a-c7d53c15cfce@web.de>
Date: Thu, 04 Sep 2025 13:09:18 -0700
Message-ID: <xmqqv7ly6kup.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> Expose the expected type of the second parameter of extend_abbrev_len()
> instead of casting a void pointer internally.  Just a single caller
> passes in a void pointer, the rest pass the correct type.  Let the
> compiler help keeping it that way.
>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  object-name.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

We obviously do *not* have to, but I have to wonder if we want to go
one step further to have that single caller explicitly cast it down
to make the intent more clear, i.e.e.g.,

 object-name.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git c/object-name.c w/object-name.c
index 11aa0e6afc..8335d0239e 100644
--- c/object-name.c
+++ w/object-name.c
@@ -714,7 +714,9 @@ static int repo_extend_abbrev_len(struct repository *r UNUSED,
 				  const struct object_id *oid,
 				  void *cb_data)
 {
-	return extend_abbrev_len(oid, cb_data);
+	struct min_abbrev_data *mad = cb_data;
+
+	return extend_abbrev_len(oid, mad);
 }
 
 static void find_abbrev_len_for_midx(struct multi_pack_index *m,




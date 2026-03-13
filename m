Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380B139A055
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773415155; cv=none; b=pSvT85x/RF71yepM6uOuj80BUI2G29NJ+VkYi17jOgOWdZkQ+3qaaIPOPSJLGR8TUrBEZ1hzLMjlMjKj6fvFNOauZjedMPETuOFMPiamUe2ydjQnL9BDpQi2OohwjBxD3LXow8H12kN2AnSnicJRXG1DQ7zCjIuSaijuVQg1vgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773415155; c=relaxed/simple;
	bh=ZsXG3AhuuOTROYmODEA1np+/ZXLetjHZpTrP1mpEtnU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RgFyyKGmMC5nt+rr7GfDZwzyIX17jsIlkIT6Zgc8viP5/cBgb3wtdD9YGuzRRe04nKiPSod2j09nGh09jgwmr75dOQ8BmDdKMqn/aoWtnmaWZJWBZ58tpFnEVcd74wWWwUz3vYxN78eCq5MRmocIvLZLTy2FuAdKxQIRx2b6hbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gMizHoIh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cHgc0pPo; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gMizHoIh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cHgc0pPo"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5D878EC0AF1;
	Fri, 13 Mar 2026 11:19:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 13 Mar 2026 11:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773415152; x=1773501552; bh=aZ14UxbFF3
	Iu+DRF4xMayWzr3DaemN+qAEym4ZXyhj0=; b=gMizHoIhaJh+ZMjHTQuzrqWU0R
	VacDmJh15Pd2rgScprlnigCcH9FfvB2MIju7pSN+AXVGZXxF6UpxdQyqNc306CS9
	IHIex1Ec3bAKruzjvsz94Ft5LDatk+kEVeLlgPpheVZBbAberygiRIH6ZNejSOp+
	/J5Jx7P/DPQupInp2k7RdJmFQ0EC87TWut+lfPh4GgNqopYbtC3G9iPt1vznr5zs
	WweOAQn6k4CYAL9/bVS+fha/BtYbF4VtnaY0v5uAsMngaIVDjRS+u+tGcRcZiVp1
	fJPyQ76Sne0x3y/dwXPJZNLghWZnHUSeYfivGZlhBMvkdiH43o3j0kc1oGJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773415152; x=1773501552; bh=aZ14UxbFF3Iu+DRF4xMayWzr3DaemN+qAEy
	m4ZXyhj0=; b=cHgc0pPoHmIjAZxY2Q00wAMLFAoT8BkIJZsMZFmrq+nY/VK/FF6
	l9rCrwkhWKhZbwoNImZXqSdTDcouT4fTS76ee/sPdu7klTsPlZTluQr7JeC29ept
	II7X6/mQICgOVQExxCboTI88UibIs1DfVGV3s8iY/B4v9XNMOIu1S87F7oO0I1LO
	3TUwSGUPSGf+STD0O3gfWxb+hIF7gscZ+lQ3+O/Uwct1e2IdBT/+Uir6H5/cTzuY
	267x+wvPp2ABK/aO+mQvWA7eGaPKq5YD1e2zOnclHwqVcxZskuyFkDy4emz4vWlf
	+Uw0oYXYZlOsOzawSaIj/Fenq36qEs3ggLQ==
X-ME-Sender: <xms:8Cq0abIfpfaC65iefEHGZc54Rwq70w_bH_RZoPSHLdVodDk2H5vC0Q>
    <xme:8Cq0aeNlSYGKQcrRhLmONP2-EfJdRoMKb-mt4-ASCE02rQ2fdRXSbBaMYcRx9hX5l
    5WeLJM5rqrzgwl8xuqZPZuSmrLtEmgh9zGYQrouB3o5K6qusB19Gg>
X-ME-Received: <xmr:8Cq0aZ4Rm1hRn83OLbidf4UWG-T-FIx0CwyNWAS6S3DTUZw7y1CGgb7fIKb2TrgjRTY-aVz2tWgLj-ZMGyiRNnuZHO-zhHL-GQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledttddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhdrshhiugguhhgrrhhthhdrshhhrhhimhgrlhhise
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtg
    hpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehpuhhshhhkrghrkhhu
    mhgrrhhsihhnghhhudeljedtsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhish
    htihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhi
    khdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:8Cq0aQ6Sa8I6d5KLhIFPvkeUvSQCHNnq1kvnrCvUX63jl2y_H8RgbA>
    <xmx:8Cq0aXFSLF5KB9c-gp3IJju8UWUTpGJjZM9v9uqJmj3TioFbSmrZAA>
    <xmx:8Cq0aQWe1MnQzSGC9q4N-KNkNaHX3sfhZSGE9gfiiUNmh7WgdXp0nw>
    <xmx:8Cq0abUW33onbasK3U_AatfsOG__HRf9tXfJrEw4XMzH6R9T1wICtA>
    <xmx:8Cq0aRMzsHQeS4EMBM7U18CHA08TFUJowVUaWXmuk0bh7euBui-Ddsrf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 11:19:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org,  sunshine@sunshineco.com,  peff@peff.net,
  pushkarkumarsingh1970@gmail.com,  christian.couder@gmail.com,
  karthik.188@gmail.com
Subject: Re: [PATCH v2] t0410: modernize delete_object helper
In-Reply-To: <20260313025852.30010-1-r.siddharth.shrimali@gmail.com>
	(Siddharth Shrimali's message of "Fri, 13 Mar 2026 08:28:52 +0530")
References: <20260312125030.7799-1-r.siddharth.shrimali@gmail.com>
	<20260313025852.30010-1-r.siddharth.shrimali@gmail.com>
Date: Fri, 13 Mar 2026 08:19:10 -0700
Message-ID: <xmqqecln92q9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Shrimali <r.siddharth.shrimali@gmail.com> writes:

>  t/t0410-partial-clone.sh | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
> index 2a5bdbeeb8..d36d1c3a5f 100755
> --- a/t/t0410-partial-clone.sh
> +++ b/t/t0410-partial-clone.sh
> @@ -11,7 +11,10 @@ test_description='partial clone'
>  GIT_TEST_COMMIT_GRAPH=0
>  
>  delete_object () {
> -	rm $1/.git/objects/$(echo $2 | sed -e 's|^..|&/|')
> +	local repo=$1
> +	local obj=$2
> +	local path="$repo/.git/objects/$(test_oid_to_path "$obj")" &&
> +	rm "$path"
>  }
>  
>  pack_as_from_promisor () {

Please do not forget to run test-lint.

    $ make -C t test-lint

If you did so, you would have been told

t0410-partial-clone.sh:14: error: quote "$val" in 'local var=$val': local repo=$1
t0410-partial-clone.sh:15: error: quote "$val" in 'local var=$val': local obj=$2

Squash this in, perhaps?

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index d36d1c3a5f..52e19728a3 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -11,8 +11,8 @@ test_description='partial clone'
 GIT_TEST_COMMIT_GRAPH=0
 
 delete_object () {
-	local repo=$1
-	local obj=$2
+	local repo="$1"
+	local obj="$2"
 	local path="$repo/.git/objects/$(test_oid_to_path "$obj")" &&
 	rm "$path"
 }
-- 
2.53.0-713-g4f09e58cf8



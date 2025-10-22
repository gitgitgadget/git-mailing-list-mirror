Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D091280329
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 21:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761168811; cv=none; b=hegBgfv15wePd2scPQOEu6lLSCssKOCiVF77ejjk2t2inm5MlSMCDOnb1hlfjH9WZSSMoSVVVqzOfPWwMeO4Yxt9d4AEnyz3ETbut+dso2i5mEjfxK7+7GJWCpnhizA9JUM2VHxQI+bVQt39W2alf3tujVElm6a/c432xqSLIrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761168811; c=relaxed/simple;
	bh=aUrTnnHF2jOe7iJtaX3JEn7OxHmO7DsEmEgEg135mEc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vDUELJ5I7pNvMUYkXP1eyppEs9PvkcVaUnR5XnVWzcFEKK+BmSbaDVV675BmiJc07hlFCe18B9w4OfrHVfO/PKfd/ZNYn4/SSNxrr5+HcKY8ml5UV8vBh/t0bbcrc/jW5r3Re8zFr2f5qg1Q+Y9nKMjxTsbFYD3pMc2jd11so88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AZI6sAoO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wcc0X+zf; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AZI6sAoO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wcc0X+zf"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 51136EC01DC;
	Wed, 22 Oct 2025 17:33:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 22 Oct 2025 17:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761168808; x=1761255208; bh=BnRBgEYDHD
	s3SOYPvkd3qDPrepHxcEPD2wQDOth1648=; b=AZI6sAoO4Zvy5h7Zipc7imD3Zy
	bkX2s8IWVT37DYR9HZgg2Z+AS2FVC240ZvujSjZwgmKEt49V4dYt9ONwDTebUfhh
	hUb2O+DXO9pDaOjiAOUHSPErmxCCFk3o7IVA6K5ONss5+FuKPpuN+ia6EL489gd1
	JOxkgomwxtseJB2LAeyfjrxvSBP5zAW2xJst71IhsJHJPzODRyamqLpWJY8KeXS4
	jyNpGBOyc0TvBicc5YuXul5fTb4jDqVmQtjtIWwsvXguzU9yChQ/N+RWjns/5OyT
	wGO2EE2nw1vOwLNRrregyEACjksBxWlyWZ4WY/8HUhzkSS6dAgBiOLX008Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761168808; x=1761255208; bh=BnRBgEYDHDs3SOYPvkd3qDPrepHxcEPD2wQ
	DOth1648=; b=wcc0X+zf0Eq3dEcsKR2SyXDRzDKnBYJkXr8GbUhpx2F1ZKNwPLB
	ldWGaVCKGWwN/axZ/KlewyeRa2va/957nyO5dZe3xELHmGyDGB5l9M5nXZ3Eou6q
	cHy49oCGQkIO8Pntd6Y+1AUnbShKbjl2D8m4m2rtaeR2vVRVIQmqiNB18yqmzFEl
	4LZtSE1Mb4br9s0R13AjtVb1OXpn+qK93bg30YX7W1URTAjAqWA/Bt3cTW+U08pS
	euhWv9WNn+RK47Mbycqi1WZL+0QopeVhaENW+Uct2ku9hwtknIro2/W6Qq1t2Dwp
	JNV0ANYMcDGqVG8LiYp5RYLg0Oj7hzf0sxQ==
X-ME-Sender: <xms:p035aL-VfDqBGTZ2DP_PUzBN0lzxKpeMvzBVePbQffHc5NowJAocfQ>
    <xme:p035aJ9gd4K5snKYw8dso_YCc_FLhrplP9vhN2js6S5zU3oqEltcIGxzLm2EcktCl
    UZg9bFjmUC270DuA14MfxCGTv3o0dZK486RddM26YwJygMRZSWwrA>
X-ME-Received: <xmr:p035aLTZeq2Y1s2md29EenTjF5DRN0tJwbXnXABzMUzfYFRFhl9BlfGw1hC64QdD0Jsthyku7en5brlisVYdC1fIpRfiyV89aLnx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeegieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeihlhguhhho
    mhgvvdguvdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvth
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidrug
    gvpdhrtghpthhtohepjhgrkhgvseiiihhmmhgvrhhmrghnrdhiohdprhgtphhtthhopehp
    vghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:p035aNfXhZWlHTE57R2nSNGQvk-P9qQxZgVr0k_QRR6ykOcUBi_Kog>
    <xmx:p035aPDk0J0z-7Gtq7QFKvPZ5o1gFIS-P-gpBJruNisCMM1aoCjDPg>
    <xmx:p035aPl5Ll9AgJLmGQE_JFgCaGFVEsylSavai7lff0657IC2S2taDQ>
    <xmx:p035aKcAxhtdibNrB3c7KQGSH1LchLdKEY990YbqerC7rZkOJfFKQA>
    <xmx:qE35aNJrbqrYQ_kqlaZK4glu4nb8i71nhUjVAAVPr-mLPgV6PCnQ20Ew>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 17:33:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: gitgitgadget@gmail.com,  git@vger.kernel.org,
  Johannes.Schindelin@gmx.de,  jake@zimmerman.io,  peff@peff.net
Subject: Re: [PATCH v4] diff: stop output garbled message in dry run mode
In-Reply-To: <xmqqms5iyap5.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	22 Oct 2025 12:53:58 -0700")
References: <20251018094823.31173-1-yldhome2d2@gmail.com>
	<20251019163024.18939-1-yldhome2d2@gmail.com>
	<xmqqms5iyap5.fsf@gitster.g>
Date: Wed, 22 Oct 2025 14:33:26 -0700
Message-ID: <xmqqwm4mwrix.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Lidong Yan <yldhome2d2@gmail.com> writes:
> ...
>> +	test_diff_no_content_changes () {
>> +		git diff $1 --ignore-blank-lines -I".*" >actual &&
>> +		test_line_count = 3 actual &&
>> +		test_grep "file1" actual &&
>> +		test_grep "file2" actual &&
>> +		test_grep "file3" actual &&
>
> I am puzzled by this part of the new test.
>
>> +		test_grep ! "diff --git" actual
>
> The "test_grep !" is to make sure we do not leak the "patch" output
> run in diff_flush_patch_quietly(), which is understandable, but in
> the new world order that even raw, name-only, and name-status honor
> "diff-from-contents" since b55e6d36 (diff: ensure consistent diff
> behavior with ignore options, 2025-08-08), shouldn't we expect empty
> "actual" that does not say file1/file2/file3 in it?
>
>> +	} &&
>> +	test_diff_no_content_changes "--raw" &&
>> +	test_diff_no_content_changes "--name-only" &&
>> +	test_diff_no_content_changes "--name-status" &&

I think this was due to the lack of /dev/null redirect around the
other call site of diff_flush_patch_quietly().  I've rearranged
patches in this order:

 * Peff's /dev/null redirect for --quiet (NO_OUTPUT) codepath around
   diff_flush_patch_quietly();

 * My /dev/null redirect for --raw/--name-only/--name-status
   codepath around diff_flush_patch_quietly() on top of the above;

 * This patch with tests on top of the above.

And that was when I noticed the above test that expects 3 output
lines was fishy.

I have the following patch on top of your patch that started this
thread to queue it in 'seen' and have tests pass for today's
integration result.



 t/t4013-diff-various.sh | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index d35695f5b0..c0a558da55 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -683,11 +683,7 @@ test_expect_success 'diff -I<regex>: ignore all content changes' '
 
 	test_diff_no_content_changes () {
 		git diff $1 --ignore-blank-lines -I".*" >actual &&
-		test_line_count = 3 actual &&
-		test_grep "file1" actual &&
-		test_grep "file2" actual &&
-		test_grep "file3" actual &&
-		test_grep ! "diff --git" actual
+		test_must_be_empty actual
 	} &&
 	test_diff_no_content_changes "--raw" &&
 	test_diff_no_content_changes "--name-only" &&
-- 
2.51.1-638-ge1c807bd82




Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF0520E702
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 03:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782358583; cv=none; b=hulyw8HgqS8l6kojcWWVM92T0T9xcnPHr14u29dANtg/4cR8GfcMV4MpEequkcv1LBGCX4YeAF4rWbNJCU1q5zYxahluvmtOaUtnL33hqPBXMQ7ZRhskxeswKecSpspndfILQRElQUqowyhlALUqD/fmECAOriL8TdrwCnoRIKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782358583; c=relaxed/simple;
	bh=rqF9KvSmsd8YmhRqDdcH2ilDCIPAmbc3e9V2xWIB9kg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mi4Fk71q1ELI8puAl1pYyTQJ9AeA7GWKs40r9+ijNf1BAuFLtmYXiInWk629bI2V7nz1YvYDFoDIZnHqL1WQAsD2MO/uToSa8uGNdjNkRKBHKPzcVtRGT9ViJiNGmspHOtSqYjqquJ++iReqQnHjcyHv0TOq0BdKpPXt6bBZ3ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dnSMUbr4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OgsiZc/x; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dnSMUbr4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OgsiZc/x"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 7120C1D00070;
	Wed, 24 Jun 2026 23:36:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 24 Jun 2026 23:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782358580; x=1782444980; bh=vzbDks4414
	V3MuUuKAf/YtwZVEyRR5BDHueYs2gzNL0=; b=dnSMUbr4eAC3n/GHJ9q4LZPgCZ
	gSRfMh6WV41Tlw/NvZWJjHa2twI7/pyLHHvmHeYeV+yYFad+//LLlpfgNJD+IUE+
	fVFimFwF639WE0Bm71MWS7rG4ZynUnKVoWMKQ8VO+9o8WRqONPRxBw7Sdo7tJAWp
	rcy9iUYleJoRcL2s2e7muqbScFg3FCr2acaYKezU5DE6mz43bbpRVGzQEu59Sxbg
	zO8/eNKHh36ZnNZghNIG0gItSmt7/6Og6dtDAcMhKMjN4GrqsazNGP2FSMukTM4q
	pICGyUnU/sXuT9il71blqGBIZcJzQPfRDMQz//J3dprqFJ9+SY91Yq/4nWpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782358580; x=1782444980; bh=vzbDks4414V3MuUuKAf/YtwZVEyRR5BDHue
	Ys2gzNL0=; b=OgsiZc/x16+YSZaI0mC41rS6UtImEMSVQmofoBqtg4mnbxAKXn6
	e0zgQnXSIAODDeGTJVQVhGtoRBzzWN0K7vdmDkuKRkit8MsdkT7CDi2YT5+iBkGm
	IRhWFpA44kW4orIRtk11jA73bmdIyUcnrkdWBobadneKpF+C7K7aEwRQdIKqM319
	9G/RIirZmIWEXrRXvuzsFWK0v4YKp20tCjKpO8abvH9hkE2v3BwJKsHHVXvv4190
	rKky6mlHWjCZ+LF9V1w1slKLqYDxS1BBIBuSQh2ra1h8uxfp4QP9PHIXIZX2f9xX
	XJj0WvDIzBTIhhzWKqaJL1DTV1pZNbn+feQ==
X-ME-Sender: <xms:NKI8akKicKOJyS46yCy8U7FzReEY147u6EkFIlqX9LiIm6B6tZcDQA>
    <xme:NKI8arIiw_yXH5qgYn83uhmJjRCxFKGGzRrfbSa2F7a4f0ZoEpXSnj2JhVTU3qCRH
    jtnqWJtfbV_CJrgigVcNmBbOazR76l95xJ4q-kiMIe0FFxXTkXaZyA>
X-ME-Received: <xmr:NKI8apu_Q7ax_21_kBN2To_Hecca0CSkrrt-l5Cuo0aFK0N9d7nyvPmRqfs4bXXAmOzQ-vf09oswKUYsKQqlFPKyn3h7etVR8u38Zoc>
X-ME-Proxy-Cause: dmFkZTFPv97flNNp9TzEvl51I4dKGccJXa8i/SwLKdkOBcrgQ8/0qetN51r2BNyvsUMzsh
    OvmCKm9rSpxWsbPl7XWoKtuTtM+GQiHfxzLeB9SFlVSVnzt3HCbfh2PCYk5RpT0Fu/jKeZ
    STRTgnhYkTtas3VDVhKvnIFeQl7cKkyjYOQcNo0nIyUUFosfQVtkq0Yix6NYM+8hpbYvVI
    6qF7TRG+68+FOfakPc/4mwRUYSb7sazUD90bPBGDNBMpE6dwzfZ/ZXnBS5EvgGRPfr0OPL
    J3WpPZlG2un4/WFiFrjJIUysLkP+iuHM/ZNSZxDaAFvqlEYVB4F5VC87IEOyzwyCte4/n4
    tPgX/oGC2emdZZJJZdSEQwHTsr7b9j9KpGwKf8V5fAS9CFZCfJvQNDbWVo8CBiMffeSXlA
    KFhBwLeum7rirC/qvkpPBXogspFpq6btDOpFC/H6L/DZ863jvPV0Da0Nk85KBx7/QVTXCg
    Tk8VFVxzy0qdXfSCgbfJFNvE+JE78HHd10UcnoSNhYY9BdLw6u332Bszr81PZ/KydOhxSJ
    GDX9z+7yE+WEc6x5rQKN0Z05u2Atgso7UON4C8ngBCzgrMVRIZ/hZhrMzdA8s6WeOmOWaT
    Nk/oAe7UNhkdpzE8JsJpOekXIdkTBDNDhrQovfL5IOaWe3RF2hHJv9zDfGTw
X-ME-Proxy: <xmx:NKI8agTlAV9jxU4c7gEjtm3FO4JOTJphqNsOmmc56OIIbZk-OtYMkA>
    <xmx:NKI8anNQgWyAFvnfjPMe1VWm1hxJcy31p0gMZSiGeDs__Sedex7_5g>
    <xmx:NKI8atbg8JOC7TExZxhK1bHPcgY2VqJsounnUfJPxQpr5SLFOBVDQg>
    <xmx:NKI8apwSw8isVIjq2lEECpda2JXZzHumgnT6p2qsum7zMtrhmCd-Ow>
    <xmx:NKI8apNVvUzbrsfaO-AsOGQ8BVUuL0CLEFOyqMnsLDIhAgjv1EXGcvhe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 23:36:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v2 2/2] push: suggest <remote> <branch> for a slash slip
In-Reply-To: <xmqqa4sjh85o.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	24 Jun 2026 15:42:59 -0700")
References: <pull.2331.git.git.1781262619.gitgitgadget@gmail.com>
	<pull.2331.v2.git.git.1782338114.gitgitgadget@gmail.com>
	<49de5a925de506ed9a141eb72927b2548b73af22.1782338114.git.gitgitgadget@gmail.com>
	<xmqqa4sjh85o.fsf@gitster.g>
Date: Wed, 24 Jun 2026 20:36:18 -0700
Message-ID: <xmqq1pdvgukt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> diff --git a/t/t5529-push-errors.sh b/t/t5529-push-errors.sh
>> index 80b06a0cd2..cfb294305d 100755
>> --- a/t/t5529-push-errors.sh
>> +++ b/t/t5529-push-errors.sh
>> @@ -54,6 +54,37 @@ test_expect_success 'detect empty remote with targeted refspec' '
>>  	grep "fatal: bad repository ${SQ}${SQ}" stderr
>>  '
> t5529-push-errors.sh:59: error: bare grep outside pipeline (use test_grep)
> t5529-push-errors.sh:60: error: bare grep outside pipeline (use test_grep)
> t5529-push-errors.sh:62: error: bare grep outside pipeline (use test_grep)
> t5529-push-errors.sh:67: error: bare grep outside pipeline (use test_grep)
> t5529-push-errors.sh:72: error: bare grep outside pipeline (use test_grep)
> t5529-push-errors.sh:77: error: bare grep outside pipeline (use test_grep)
> t5529-push-errors.sh:84: error: bare grep outside pipeline (use test_grep)

I've queued this squashable? fix on top of the branch before merging
the result to 'seen' for tonight's push-out.

Thanks.

--- >8 ---
Subject: [PATCH] SQUASH??? use test_grep

---
 t/t5529-push-errors.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t5529-push-errors.sh b/t/t5529-push-errors.sh
index cfb294305d..2294645902 100755
--- a/t/t5529-push-errors.sh
+++ b/t/t5529-push-errors.sh
@@ -56,32 +56,32 @@ test_expect_success 'detect empty remote with targeted refspec' '
 
 test_expect_success 'suggest <remote> <branch> for a <remote>/<branch> slip' '
 	test_must_fail git push origin/main 2>stderr &&
-	grep "${SQ}origin/main${SQ} is not a valid push target" stderr &&
-	grep "hint: Did you mean to use: git push origin main?" stderr &&
+	test_grep "${SQ}origin/main${SQ} is not a valid push target" stderr &&
+	test_grep "hint: Did you mean to use: git push origin main?" stderr &&
 	test_must_fail git -c advice.pushRepoLooksLikeRef=false push origin/main 2>stderr &&
-	! grep "Did you mean" stderr
+	test_grep ! "Did you mean" stderr
 '
 
 test_expect_success 'suggest <remote> <branch> when the branch has slashes' '
 	test_must_fail git push origin/feature/x 2>stderr &&
-	grep "hint: Did you mean to use: git push origin feature/x?" stderr
+	test_grep "hint: Did you mean to use: git push origin feature/x?" stderr
 '
 
 test_expect_success 'no suggestion when prefix is not a configured remote' '
 	test_must_fail git push not-a-remote/main 2>stderr &&
-	! grep "Did you mean" stderr
+	test_grep ! "Did you mean" stderr
 '
 
 test_expect_success 'no suggestion for a trailing slash with no branch' '
 	test_must_fail git push origin/ 2>stderr &&
-	! grep "Did you mean" stderr
+	test_grep ! "Did you mean" stderr
 '
 
 test_expect_success 'no suggestion when the argument is an existing path' '
 	test_when_finished "rm -rf origin" &&
 	git init --bare origin/main &&
 	git push origin/main HEAD:refs/heads/pushed 2>stderr &&
-	! grep "Did you mean" stderr &&
+	test_grep ! "Did you mean" stderr &&
 	git -C origin/main rev-parse --verify refs/heads/pushed
 '
 
-- 
2.55.0-rc2-165-g3249676ba5


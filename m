Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839F54B1E7D
	for <git@vger.kernel.org>; Tue,  6 May 2025 22:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746571741; cv=none; b=T8JVmtkNcHtGkcR//oHOBfQayanYCKCQAjgquEVG9GDR2dWVkyXzwdHWSy9+vKDT2+gaWnflJkSEdy5yK2LNQMo0+01VAJJdgzMQ5rwfcsJZfvHMl9One0SzLzF1MVGDeH3IJAyu1jA6RSW0oB1aYZn0UlWRa4fdJkcPyGb4kuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746571741; c=relaxed/simple;
	bh=7KxA52ZVrlNm1GKCcxH/yZcj6KROGhoCPEuGSNpmI+U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M4k64KAj9ajiJZ1hdEf/LsaCo2bvNR9Fcc2jJE90tPmhAMBRMyIO/MigNxBRTFGCIGJdrSq6bZNUWUcHWGQRS4gAnjz02QS+T9I+dUpjzbcBbAN5X+TgAsQREI7ZCBPFhkoIOxK/Mup4X19BGvcXaHTQJtthLYsu+v0xjNiOA58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gt7SgBwI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uaUgfq7n; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gt7SgBwI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uaUgfq7n"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 63CD611402B2;
	Tue,  6 May 2025 18:48:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 06 May 2025 18:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1746571737;
	 x=1746658137; bh=4WLNTaU+PfmO5nCjabFHxlDt2aNKhjiZT5CgoES6Bmk=; b=
	gt7SgBwIsneTL/u2h66g5jkZ/afgsZ1yJqkJOcdZ96L2hbiTndu81hTs8Uxm71DI
	5UCBAgbi25dNa9d9vHISV/3Mzi+hCxwQy3teRcvEghSf3k22YiJPkho/1PWfXw3c
	TpQK475AhDwLktiKkjOhqJCYchYDJQRJevSbgpP0EP66UIEf77J8GuXa5R+pp52h
	VjXmczbhEwPTnSRC7bL9WsAixL9Qs66/5rwVEAjcrXCkK1e+rfQroxmEYRk50+hM
	sgetFDniT7N+lFB5rwaSNpUjkIrF29FnJ1hVSG8ypg9nr8bbeAccnfSjlC4/5OCj
	OepKw9H6qAyPtkD7k4EZbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746571737; x=
	1746658137; bh=4WLNTaU+PfmO5nCjabFHxlDt2aNKhjiZT5CgoES6Bmk=; b=u
	aUgfq7n6dlUEQC5pHDD/PCRHQItazK//2AM56YphArtf8tzalwksQRvGkLQWFAjX
	/L4npCuaDjutakvoLYvI/XgdXk91dzKyuNgP2RHlteMFAhdANrxnZ5GEb9Fa1BcW
	taEv5682uDmVHKyrxAzVYEeDsc1obOEN3Rb5GVY+haA/gCAXvjZJ5slnVf3X2Lv9
	nQX3lWyuMXVizcGjdExVi6lgDxZA4EP5eMHjWDlKDCsbdPHdug0cUSMbgokqdCK1
	6kteK2tj/W2BkICRJpXP6hAo4lFwJmgkrYwuDOdc+Wg4N2X+nu72mOgdVMgvsD3F
	YSu4FuklJFkz5XSq6rG0w==
X-ME-Sender: <xms:2ZEaaDxWZAjwK5kUz5jjkzeNuCC_TMmA-vbXJSqFVdbJgsUNmkEIBQ>
    <xme:2ZEaaLS7eIc_zJGUxd80nUxUNlmz2H729YuBKzLBGeH7RJdRZzp3mv--reliU5mlm
    z5y_voJ8891nclneg>
X-ME-Received: <xmr:2ZEaaNX7W0Ano4bWpavnVkpO8AJxScmLzMe9rC1epqzMGIaTGIsd11olidL8nz-PCTGe88cxOtXyJSGv2eN-K17PrBG52BQKVG35>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeehvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcuvecujfgr
    mhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnh
    eptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveeftdehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsth
    gvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepthgsohgvghhiseifvggsrdguvgdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2ZEaaNgDqy7TQgWS1EHCicq59t4S29lUonujEvEfqvjNFHz--Mei9g>
    <xmx:2ZEaaFB3qJuX_wQYm_jEAoA7rMbtieYCspR-3TRqnPPFYaFlCcg7lw>
    <xmx:2ZEaaGJJk4A0NAmYz2imfwBMwEc1M7HPowxSX00DNVO-xtv0dVtReg>
    <xmx:2ZEaaEDcmSfqQBbUMaU1s64f7aw1v58xk_2V2BmTjnUQyDFBoGixbg>
    <xmx:2ZEaaDhivRyYirwDg7AhOqU4z77PsNWrryNs4xy0K5n8uRcJCJibgvbh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 18:48:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: [PATCH] t6011: fix misconversion from perl to sed
In-Reply-To: <71fcb24d-55e3-40bb-9368-5b47aa180993@web.de> ("Torsten
	=?utf-8?Q?B=C3=B6gershausen=22's?= message of "Tue, 6 May 2025 14:32:04
 +0200")
References: <71fcb24d-55e3-40bb-9368-5b47aa180993@web.de>
Date: Tue, 06 May 2025 15:48:55 -0700
Message-ID: <xmqq8qn9fj8o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

No, this is not about a quiz on regexp compatibility between Perl
and sed.

Back when cdbdc6bf (t: refactor tests depending on Perl substitution
operator, 2025-04-03) rewrite many use of perl with sed, the general
pattern of the original scripts were

    chmod +w some_read_only_file &&
    perl -p -e "regexp to munge" some_read_only_file >some_tmp &&
    mv some_tmp some_read_only_file

persumably because the author new replacing some_read_only_file with
"mv" at the last step would not work without "mv -f" in some
environments (GNU does not seem to give any prompt when not running
interactively, which is what happens when running t/ scripts).
Replacing perl with sed would be fine as long as sed with updated
regexp does the equivalent munging.

But one place used to use a different construct in the original:

    perl -i.bak -p -e "regexp to munge" some_read_only_file

With _no_ temporary file or "mv", "perl -i" allows you to replace a
read-only file in place.

When we replaced the use of "perl" with "sed" in the said commit,
however, because "sed -i" is not portable, we rewrote that in-place
replacement to

    sed "regexp to munge" some_read_only_file >some_tmp &&
    mv some_tmp some_read_only_file

Again, unfortunately that does not work in some environment, without
"mv -f".

We could run "mv -f" here, but we would then need to remove "chmod
+w" and have them use "mv -f" instead at all places that were
touched cdbdc6bf (t: refactor tests depending on Perl substitution
operator, 2025-04-03) to be consistent (and more concise).

For now, let's make it consistent in the other direction by mimick
the other places that made the target read-write before moving.

Speaking of portability, the outcome of using "sed" on non-text
files is unspecified, so the entire exercise of cdbdc6bf may have
needed to be reverted if people still used ancient version of
"standard compliant" sed that barfs on non-text files, but these
days we may be able to get away with "BSDs and GNU seem OK with it"
;-)  But one fix at a time.

Reported-by: Torsten Bögershausen <tboegi@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 t/t6011-rev-list-with-bad-commit.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t6011-rev-list-with-bad-commit.sh b/t/t6011-rev-list-with-bad-commit.sh
index b6f3344dbf..1dd1e50d21 100755
--- a/t/t6011-rev-list-with-bad-commit.sh
+++ b/t/t6011-rev-list-with-bad-commit.sh
@@ -38,6 +38,7 @@ test_expect_success 'verify number of revisions' \
 test_expect_success 'corrupt second commit object' '
 	for p in .git/objects/pack/*.pack
 	do
+		chmod +w "$p" &&
 		sed "s/second commit/socond commit/" "$p" >"$p.munged" &&
 		mv "$p.munged" "$p" ||
 		return 1
-- 
2.49.0-615-gd1e3f1cce9



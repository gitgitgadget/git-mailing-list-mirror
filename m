Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328DE3612E2
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 02:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791770902; cv=none; b=X4MmgOA9iCT8yJ5C2yRM9wp8/o83oM3bsDndVZyyuXnP0rKiJt/ydh2jczX/zTDhiv9VQAUpNXbIYKi5A5+3aMsrELLUUeQArjn+ILhEcT3/4qI75LQNdkgU0IrMeWRsyFD1asfLJ6FCdv34UPBGrpxnFBDHhdVBg0Mv2V1mOWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791770902; c=relaxed/simple;
	bh=2306DdHzRcuX+ulCfHPVu0iA+sn/H75JR6WmQhXWkmI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=C+BSzAYiKfeM+Np0zoNaX3wi372DfStyWhmhxHEen1ekEvpIQVX9bLX2E/+bIInLu1tveT+SsmEmeN48IlvgEWZSYGPnpxt/IC3y96NGpJBaBDSU6M73dbPUzzZ/yV/fUqttaoBB95AORNctsXbi1sZliwBpHUDMfp17xtk8dsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q7w7z0zv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VdO2UDm5; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q7w7z0zv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VdO2UDm5"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 932837A0072
	for <git@vger.kernel.org>; Sun, 11 Oct 2026 22:08:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sun, 11 Oct 2026 22:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791770900;
	 x=1791857300; bh=/0YBU3BnSg/KLHxFejLf6glcP0akXY5uDZstgbgIMto=; b=
	Q7w7z0zvbjjIPkLcwj3K6n6vGaSGfVfL+dgLF2WcBM4xII/t+AXnHaOR3Ragdyoq
	8g/2vnOaZgwHXlti/ZNEvNB2oMM92W7owHnZiebupDHH4W+9kW3LkO/YlYJthRgO
	MYtfSWrpSqcIhO98hPvvznaWL+QDD1SAhWskf1aA1moA5VZtBpAQcQHEHvlI5l1u
	J9UMMdh+CodKbbM+he7qD0wWeegaH441el4yr+Csy/hf4guWnZRRpN9+kRuDCWRX
	eGXw7eAT7JyGH6tfjdEAPgUM3puADkiIahTtDNBEuyKHYwUPm80VViwshRtoh5ia
	fpv5q6L1HnksrolSmB2Y2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791770900; x=
	1791857300; bh=/0YBU3BnSg/KLHxFejLf6glcP0akXY5uDZstgbgIMto=; b=V
	dO2UDm5A10NApr1IYg5oAdrjSoG8nOUwQjxdb0nwJOfu6T3rLL3zopic1D+VL7EC
	5r4l0RIZAmL2ztn9e1w+Dib8PwEH1yJCd80rnYhDAXXkjd7cAHVPN7TLNukRwxqV
	HfiYpHt3PdyiDGNDCpA7NIBQFXEPsLhZpmoLWhm3GQmDSAEnyA7tAGfKQTXpKqZR
	9kzlTK1wNpwRcEOEwJwEb2+TTTOrT+CoaE/+U3aTeXuGKUUDUOR0U3jLMOXGTHWs
	A0LJUIz52/wMgjk0iaLF5yMrKwkc+ogRknUyMdx0NwQmrzRgXhLE7Who5rVWQcBd
	lZhipgc/jvz8Kg8EeoCQg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791770900; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:NGmb6ieNryxwUGrF2PUbHHx/kI1SFoIKqOzohUscq39R8xe
	h+ciUU/dnMOBAOZ+tzKMFFRXRd2DQGmDv3P2EKBhlvipNylSFSGxUWK5e1R53fax
	PPGYl263c0tQSV5JOKnCGxqesob4KZ+gKduUrwpmgDyUAVeDvPgSOT5oNdDeeY/F
	nqk0fk/zx9QBupm8e8NI/Tk/MQqcXLIn5/oOKp2qsJ07VGj6QghCTzA8UNBEoyuL
	V90Srz1yEU3lZZ6momBGYmRDTTZAUYuaKCidfLn4R69EyZ4jdhjYAbb/K19AGsdC
	bVMK0FvRNUk+943aFlpk3tDOnzYqA768vma4/lQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:esYAy7s+0DialNooBxnkEZSm8S2GtVRMiHXu2wCf/AQ=:2306DdHzRcuX+ulCfHPVu0iA+sn/H75JR6WmQhXWkmI=;
X-ME-Sender: <xms:FEHManRAeyS3kcEsdsTt2NI8myNLlRa0OlQRnPgQX3g2EJWT52hpCQ>
    <xme:FEHMavxpgaqCErR8MFKoZCnM8DO9Zadjdz5Pk9jyJeJZQYalW_d8DyIwnlqWgj_Eh
    OMgtELCSBUK4y0x4Qr7RBx20nsg9Ds1t6QeAvzUoMxnrDU3fjXwCWQ>
X-ME-Received: <xmr:FEHMah2WjIglkX6155JzjzCcnTKl4pFsJ-cEtoGBoOSWT7QcgFKLy3i1Phc>
X-ME-Proxy-Cause: dmFkZTGxEUMc3fEoZL4zjMEvt7lTgDF1psKavfdPHmwjSBY7hz6aIK5S9zozEawqanvj9g
    FLqxNd0mGKpsida6yq/uoQikzJMBacG/A6sD5d2N4pfWPAsmhykOGy2I2G07ol5neXPGws
    XM+lcPtxVy94EhXwFEMcKVQMA+sgIceX+SpCEOpiHyXiTl3VYHsf49hvZkCjAKLDpxzwtt
    qSmRygeYcx9wu2tQXopsLX9YscNxDaSJbfNSdsH0Z4R/3xAuGtO5oJxvkYEPs7ISdDKrbF
    8ym/5VM1pWY03DvbTApQUe+iu62llS8rlvu//UvdKZRpFgYpTWmPVVvBRmm8xXomPjV7as
    O24VQTOfrQdBv4dihVnXrQ8YPOsFHFvTjpuEr6oIVQIXZ5isqfdpD28VvCDUYilxKz1u7d
    XAW7Ht9q9bImHJWhSLDOzHpmxikCVWV+2NScfFfFLfJCDtR5C/1Amg4U3+NhjkGirbGcUv
    EzcCskTM+TIjiFMZgebKO1OGgpQpogwoztA6enPHQeGikWoCUeqmxhjcIWWz7notebnd0c
    0aQ5Ino8DOaMprYXjUCo+MGknqPrbtfsd3xjbZnox3URZrXwKdmvK5/wfL1Tppw2/fNqvz
    YS0kcV3nM8EXjTBEpCu8Bu18raDcv1vZK8kaNX8QxYVvYnWcgz781n3u5NNw
X-ME-Proxy: <xmx:FEHMal4GltQ3ZAdfd1iWmnp_Z7SEFsdfVjyalwBxnCyQXk1nhg0zAA>
    <xmx:FEHMasVfgl3I-LNGKDgHo--HocFn17x0wy8dhGKsMx9YduJ4PW51yQ>
    <xmx:FEHMasASwGCVO_Wwbnl6_s3PDnSpcjA_ktJTRxP8GVdFpmT5_vLahA>
    <xmx:FEHMaj6PixOJRqreO8AjOolZUyzkAYBNGjCb58yZCISaKRatyK-l9Q>
    <xmx:FEHMannLPj96HKkfD_HZGvuy_JftomDN51rmOZ4WtPw7yt30l7k0MVuX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 11 Oct 2026 22:08:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: "Matthew E. Luallen" <m@sph3r3.com>,  git@vger.kernel.org
Subject: Re: [PATCH] archive-zip: omit UT extra field if mtime is out of range
References: <CA+h9NxRT-9QzLGihdL_Bp-yyt1AdXJ79YYgpK-OaegUz8e+HcA@mail.gmail.com>
	<595dafac-33c7-4c45-9cac-c868cf1f8bb0@web.de>
Date: Sun, 11 Oct 2026 19:08:16 -0700
In-Reply-To: <595dafac-33c7-4c45-9cac-c868cf1f8bb0@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sun, 11 Oct 2026 18:06:04 +0200")
Message-ID: <87jynn8ycv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
> index 768b0ff85d..20bab21048 100755
> --- a/t/t5004-archive-corner-cases.sh
> +++ b/t/t5004-archive-corner-cases.sh
> @@ -227,4 +227,32 @@ test_expect_success 'tar archive with long paths' '
>  	git archive -o long_paths.tar $tree
>  '
>  
> +test_lazy_prereq ZIPINFO_UT_EXTRA '
> +	"$ZIPINFO" -v "$TEST_DIRECTORY"/t5004/big-pack.zip |
> +	grep "UT extra field modtime"
> +'
> +
> +test_expect_success TIME_IS_64BIT 'zip archive with 32-bit mtime' '
> +	blob=$(echo foo | git hash-object -w --stdin) &&
> +	tree=$(printf "100644 blob $blob\tfile" | git mktree) &&
> +	git archive --mtime="@2147483647 +0000" -o with_ut_extra.zip $tree
> +'
> +
> +test_expect_success TIME_IS_64BIT 'zip archive with mtime exceeding 32-bit' '
> +	blob=$(echo foo | git hash-object -w --stdin) &&
> +	tree=$(printf "100644 blob $blob\tfile" | git mktree) &&
> +	git archive --mtime="@2147483648 +0000" -o without_ut_extra.zip $tree
> +'

Both Ubuntu/20.02 i386 (which is going away so you do not have to
deeply care) and Debian/latest i386 (which we plan to use to replace
the Ubuntu/20.02 i386, so it would be superb to get it work) jobs
seem to fail this one.

https://github.com/git/git/actions/runs/38189684665/job/114619579067#step:10:321
https://github.com/git/git/actions/runs/38189685137/job/114619583658#step:10:337

Thanks.

> +
> +test_expect_success TIME_IS_64BIT,ZIPINFO_UT_EXTRA 'UT extra field' '
> +	"$ZIPINFO" -v with_ut_extra.zip >actual &&
> +	test_grep "UT extra field modtime" actual
> +'
> +
> +test_expect_success TIME_IS_64BIT,ZIPINFO_UT_EXTRA \
> +	'UT extra field omitted when mtime exceeds 32-bit' '
> +	"$ZIPINFO" -v without_ut_extra.zip >actual &&
> +	test_grep ! "UT extra field modtime" actual
> +'
> +
>  test_done

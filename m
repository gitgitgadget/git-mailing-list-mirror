Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496DD20ED
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 01:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782611133; cv=none; b=AOI11Dfu5xxw7Wi6Z9aVEJBHyNYs324gcLGKSStX2ZIsxpP3WQZcdWm3NQuMqUyAKY1xvknQqAtYBg8RxAZd5Lu/vllq7wgNG6Z2++ExUUDZJka8t8OdkmC1P/9XXYkaKD/Lk1k94qPDN4TwCohbQOiwjVevaKfSz/v0i+hiWSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782611133; c=relaxed/simple;
	bh=bluxDwYQMWLVw1dsQB/r2ITy6L8l1x/YlV4vg0/iGNo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NcBpF5TD779k5c1fqZXjqbiYMUgcceDlKmzqZhoGqnryu9ap9BXlocHLlK0lHmCmS8iibA1JJg1tcJxBZh1KNBYDjvIhUxpou5CtbcYNlD5CG3bqSbC+p5MkOklpmyxFSG3+aXutKEFnM3WV0G+sF8ruRdFa7Jew7lzKaeagXFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Sw0NYnP2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EGqxW/c8; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Sw0NYnP2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EGqxW/c8"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9408614000AE;
	Sat, 27 Jun 2026 21:45:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sat, 27 Jun 2026 21:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1782611131;
	 x=1782697531; bh=DDUP1PfY6vJbBF6Br15/q0Ytw6HdqAXmk9ZQhP5m/y4=; b=
	Sw0NYnP2aI1qoRYH8dhWr0b8qeIDm597fGGvC+TIhSB7wXdmM7UI71I3+tJ6cn/m
	SfEjSKY7QVyHam9uTVcpSxOeEkfFZ2afY7XhVH7zckg28frZ/HQ+GEynIcCimNla
	EDEyLDLgfNwJ/ltQtBKhgp7Uw60wf9NG5n+UrNo9MG1MCKynasCpdbD9LqHJvKe6
	TvAy1QMY7XpaJFY8S6ifk2/hwKcARH+eThHTHkDaLGefKXjGbXgsGiR3+L9g/aps
	zFuIw/zHu7UqClAa4sbrPKyxrVmf6Qm8W33EkY9y9XuZFH7gi1mORBPHOMyCOoqG
	zgfh/I8qfpfhaeui0LqKsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782611131; x=
	1782697531; bh=DDUP1PfY6vJbBF6Br15/q0Ytw6HdqAXmk9ZQhP5m/y4=; b=E
	GqxW/c8HEUaY13ApQf242sbP9C4AFYZTcLLy1/xuVzOn8JEUkTGBEA4sMLOIw4PH
	x5FVAm0s1cOAye26yOWd423cyBKT7vBkP/Q1m9zCaYQ9tGJVHlevNvk0JDWbV33Z
	CRcKz/1IuOkUAonALgQ/ao2Ns8HNXrjoyDS9Rmnq4ppt9wkcPHTjGqPqpCE4D4Sk
	LeuJbuFdV/MomMlCtG3V2dgReL3FsQ3UqtD6jo1P5SFMV+/Xc8FFKJZ8yQ0vAe+0
	1GkDRGA6Ygah4hVRGbtT3NoJ3D9ItG3EYHOrscMgizJlLtZ9h/b+ANvCmjX+YcSU
	zyiQ+Mun6hAeIFmCqSkVg==
X-ME-Sender: <xms:u3xAamBpmc5OOi29PGqSEr3sJiTm5fhBeSV3kkniqwSyGXCcQnYz4w>
    <xme:u3xAasCwkNMbEi09OJBi_W_owzs7OyIMx70LIc8n_EBakos9JQSxXxuJ3aLvC-39q
    _pJRmp1xj_o2-dgm28IkgJ6QXqPjc_QmUQyx4HFVVgVSodfPRMvGC4>
X-ME-Received: <xmr:u3xAagDsCAqzqnQkZSWXvvqrVILB97fypLepTk1jWXib71HV5-X3ka7qOmfCNbh1WKmmdY1T21xB8dQAUjhwSr71prq0qRmmcQsq5ws>
X-ME-Proxy-Cause: dmFkZTEDw8ciMM8XtDM68QfXX7Cpk7kFj0e/+Ru82s3ew3sc91ORiE4Pe6JaJwgAJus/76
    bnMvMAwopt4s0iXSY5KdSmKin4vrR4pO9Vtzt2nuUjI8K3THZO0G8loBDURjsntqeeWzln
    UuhCvB2+k+U+Xs0PfbbZURuDA/kyIZDCkqXxNDctnhbkECfILlGip3z8qOcurqTMrbxrWE
    4FhwotoWLBWtx8ArSkfFq1cwNnAQAZM1gfuzx7jMvQ3pJ92u6YB5LSEkF7v/rUAzQ6daW8
    LxpBu3PMacBtFeyn4yzMZMUFBgEmWZPGBKx2h1wMjaFj3kSIMKB0LxW/wUEdhg5uXo5HfL
    fhKdSH4DljZP1teAukVlZW7lBjBmFHlBaMkilRxe2vjUPb16FBMfsmgpUxmMEu7QqrF9u5
    7RO547HkdWncRbryq2ZgpCc8AYwxDUzSTDMx8B8CCtfigURWlvoJpE8mREmJhTbH+TRHvI
    C1TaN0/JT/D/zdBNDivZsR5ENoksbAyh20J1MuWkS3rdOTbETXAQOuqZupLjAHdwLZbYrT
    AMLdCM0XA4hFEzmDdDfoDHFt/g5zeOgzvJfELvl4ih9KCO3r20LBUQcQlA3q58of4rAnrl
    EAQBRA3Jds0+F7cXxBUdos4yPipv6rIVRCrloaa47QCudUr3j4z96ynLyznQ
X-ME-Proxy: <xmx:u3xAavo46g6G9wRVJzNrbZu10ELQeZq2In6zYlqVG8EygR5II455Fg>
    <xmx:u3xAaik4Xx8FDiIPtck9tMVZ-afCetlnj_liCUgmKFsEr0nPuC9wYg>
    <xmx:u3xAanwHBZK123GBMInIenQZrNXYZzUWmt8FwohCV0uRQinbivDt_g>
    <xmx:u3xAai_ZnhaJ98cxTc3y9uFbGAaH9DZXrh5Orpuuc8so63ZaH6sWXw>
    <xmx:u3xAavC2oWrE337GJxLR0asdDAXS7CYH89SZcGHXR84MXEfyYBH5q8Ut>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Jun 2026 21:45:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org,  Michael Montalbo <mmontalbo@gmail.com>,  Denton
 Liu <liu.denton@gmail.com>
Subject: Re: [PATCH] t3420-rebase-autostash: don't try to grep non-existing
 files
In-Reply-To: <aj90x3DsER5HASUS@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?=22's?= message of "Sat,
	27 Jun 2026 08:59:19 +0200")
References: <20211010172809.1472914-1-szeder.dev@gmail.com>
	<aj90x3DsER5HASUS@szeder.dev>
Date: Sat, 27 Jun 2026 18:45:29 -0700
Message-ID: <xmqqcxxb4eva.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Sun, Oct 10, 2021 at 07:28:09PM +0200, SZEDER Gábor wrote:
>> Several tests in 't3420-rebase-autostash.sh' start various rebase
>> processes that are expected to fail because of merge conflicts.  The
>> tests [1] checking that 'git rebase --quit' and autostash work
>> together as expected after such a failure then run '! grep ...' to
>> ensure that the dirty contents of the file is gone.  However, due to
>> the test repo's history and the choice of upstream branch that file
>> shouldn't exist in the conflicted state at all, and thus it shouldn't
>> exist after the subsequent 'git rebase --quit' either.  Consequently,
>> this 'grep' doesn't fail as expected, i.e. because it can't find the
>> dirty content, but instead it fails, because it can't open the file.
>> 
>> Thighten this check by using 'test_path_is_missing' instead, thereby
>> avoiding unexpected errors from 'grep' as well.
>> 
>> Previously 2745817028 (t3420-rebase-autostash: don't try to grep
>> non-existing files, 2018-08-22) fixed a couple of similar issues; this
>> one was added later in 9b2df3e8d0 (rebase: save autostash entry into
>> stash reflog on --quit, 2020-04-28).
>> 
>> [1] This patch modifies only a single test, but that test is run
>>     several times with different strategies ('--apply', '--merge', and
>>     '--interactive'), hence the plural "tests".
>> 
>> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
>> ---
>>  t/t3420-rebase-autostash.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
>> index 43fcb68f27..bbe82d2c0c 100755
>> --- a/t/t3420-rebase-autostash.sh
>> +++ b/t/t3420-rebase-autostash.sh
>> @@ -200,7 +200,7 @@ testrebase () {
>>  		git rebase --quit &&
>>  		test_when_finished git stash drop &&
>>  		test_path_is_missing $dotest/autostash &&
>> -		! grep dirty file3 &&
>> +		test_path_is_missing file3 &&
>>  		git stash show -p >actual &&
>>  		test_cmp expect actual &&
>>  		git reset --hard &&
>> -- 
>> 2.33.0.1279.g1a260bf8c2
>
> It appears that this patch might have fallen quite deep through the
> cracks... ;)

Yeah, that indeed seems to be the case.  It is surprising that
nobody even had any comment on it back then.

> But the issue this patch is addressing is still there, and the patch
> still applies cleanly after almost 5 years.

Will take a look and queue.  Thanks.

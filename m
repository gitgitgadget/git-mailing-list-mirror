Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A4632B995
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 15:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762528441; cv=none; b=jLWD3W2d0ZYEnO/N/iSAivu2KDqiqkLyfmnDyLBzKl8EyvWMuMT3VS11/LvJxlf0bzhRqcAvuqgWJCvGHytw+CuPmtAvr73uh2CPu67IgQQutCyBx0Ad0Cne3yldf5XdYi5YzGIpY5N4wTO1VSZGz/eBq8fRvb8x3FJ41ZdmUus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762528441; c=relaxed/simple;
	bh=wuBYTCaXqOtTA2ST369IMF8NyNXyW0MwrqBMoBNX3Gw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+mcVY6hCJ1qTOt3GyD/kwSXvsn30ld763v66WvjZILKoJ83h+xn1MeKviEF+aNrPRRIvMdPhTGbiAgopvbIUrR2EFkgR4yFI+IDY7B1vzniTvx9q2EtGVBNpwtlE/g0X4P8BzFtw6ckIImYMWVMJ37bSANkbCThBSjoPc7ijPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLalaokB; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLalaokB"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-559748bcf99so775530e0c.3
        for <git@vger.kernel.org>; Fri, 07 Nov 2025 07:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762528438; x=1763133238; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9rRL7XpiJAk8bJKNva1LCEvaMbqZcUmsms6/8EkimX0=;
        b=FLalaokBxBsk/JFp67cL+G6J/Lwm1pYAPSsaXuznzaV9mshyM4wGR1GrYWy27D3ipc
         tU/ow/F8NDUEiGbPN6qLK8Z+TJUdO/TiDwDQqLVTHWyWzpBabRHRyew9GFSHsEgmV7x6
         gJjccz8xxROK7PQabykKITjTRxUxKEOxCf1ZeMh4KYZFh5jt1gPEiesuoygoTb3QWf66
         1YRF+TYN4euT83vgkc++LhCSH87FIT04wqVRmwLvElJTmDL2gQbHeSOYl+02cL4WpWLp
         cStvfr6HklMKHO45J1aUYhOja4xod94KmGvicPWZIMDfTSJfvbXtbfbUjlbE0aNGv6rw
         ISUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762528438; x=1763133238;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9rRL7XpiJAk8bJKNva1LCEvaMbqZcUmsms6/8EkimX0=;
        b=ZswWhLOzsyX/4pCw522exBf9ULfviQ/amAa3vZ8CN1hanTeGuDzMVC4dA/7tV13ju5
         5VjbA9QYx5h9Vh7feEVUe2yNxYxIBAyvGEb59CcPZ6yk2AwVelYcuuXDZ6UOkfYC5d9J
         Y2nOxPVyPS8Sr3GAhtgNtOMh3sovdiN1X9TNge54p3fpMePR9lhVgfRNJE6XbSq8YXIe
         jKMf7tZSKFVh/dGH8S0DjZVDQQjH9jUiutFZzMfyQBuiUwBz7yk89IqwRHV4NQGhWr8I
         SmzYdrz44zqAO0UncfNo8G0Aa8mt6kUy1h3io2YMuCJaUrOxJNARo0zyMLe1IxYhRnOo
         vroQ==
X-Gm-Message-State: AOJu0Yzx5Dkp1cuR5YemyBt7k6h0sWS8m/AKJTjpUL4MDpE578P8se8L
	wDdto2q3n8hfGYdTMox5XczVnauyHZyrr7hm52gDc6ysJXU6aaD8XY1t/1kSHYuYhT3wULJVZKS
	i9Nim1darajEP5FhCpvMgOPfPGMFfjpQ=
X-Gm-Gg: ASbGncup75MdGHYJ8N2uL4tkB5VZHPk9dwX0a9TGgfjmcNBDR+TjjjAWXzA4bo4sHco
	Y22+fnMir+EpMxSLsKZfO0xZJkukV8KDVSMHHj4oamyJETTsgk7C8hlL30UT37ze2W0z0UTJHq1
	Qutwiel1dDmQ2NYTLSu9bPdCtL0eFfmRw6wWXnbtuxJaC5r6HlcIJ/yMvBydg66ct8B4OnTvQS5
	Q0ZFIm002AfP06ONdKOitA3l/jF+A4vP4BmD3MO/RWGS9Qyz4xqL1cwQMzqodwGgT2n75LY0PAk
	jUYhxUVo1q5+pw8lkXqDnYlIvp1NOIQjCrNXLA==
X-Google-Smtp-Source: AGHT+IH1wZPa6H4iDMoBSb+ZWeex8VctZWXQECJ5lEXoh7u6WAqgKRC2kUlSTxfS6Zfe/ROAcT4DAsbEOGK8HPC2PSo=
X-Received: by 2002:a05:6122:4584:b0:557:b52a:d553 with SMTP id
 71dfb90a1353d-559a3b0df84mr1235892e0c.7.1762528438382; Fri, 07 Nov 2025
 07:13:58 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 7 Nov 2025 07:13:54 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 7 Nov 2025 07:13:54 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aQ39P0mAFqDGPYxS@pks.im>
References: <20251103-fix-tags-not-fetching-v1-1-e63caeb6c113@gmail.com>
 <20251106-fix-tags-not-fetching-v2-1-610cb4b0e7c8@gmail.com>
 <aQyLfD_zx0ndCLvU@pks.im> <CAOLa=ZQpTqnCQs4=wcUwJOWy5mXiG4y_eTiFtPkS2uOk4U66Tw@mail.gmail.com>
 <aQ39P0mAFqDGPYxS@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 7 Nov 2025 07:13:54 -0800
X-Gm-Features: AWmQ_bl_8XnwcgfBdAhyVPz9XZCO7fzlVu7nREumoLXwJHopsCTIxSNdVso2XVA
Message-ID: <CAOLa=ZS3oFiopf0ys2ZS5z0MdE8s6jqapPyaR86gj5CcJ9jaYQ@mail.gmail.com>
Subject: Re: [PATCH v2] fetch: fix non-conflicting tags not being committed
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, jltobler@gmail.com, sunshine@sunshineco.com, 
	David Bohman <debohman@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000007a0c7e064302a10f"

--0000000000007a0c7e064302a10f
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Nov 07, 2025 at 05:15:32AM -0800, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> > On Thu, Nov 06, 2025 at 09:39:25AM +0100, Karthik Nayak wrote:
>> > The following test demonstrates this behaviour:
>> >
>> > 	test_expect_success "fetch single branch without explicit tag option" '
>> > 		git init source &&
>> > 		git -C source commit --allow-empty --message common &&
>> > 		git clone file://"$(pwd)"/source target &&
>> > 		(
>> > 			cd source &&
>> > 			git commit --allow-empty --message discard-me &&
>> > 			git tag discard-me &&
>> > 			git commit --amend --allow-empty --message fetch-me &&
>> > 			git tag fetch-me
>> > 		) &&
>> >
>> > 		# The "discard-me" tag does not point into the history that we are
>> > 		# about to fetch, so it should not have been created.
>> > 		git -C target fetch origin &&
>> > 		git -C target tag -l >actual &&
>> > 		echo "fetch-me" >expect &&
>> >
>> > 		# But with "--tags" we instruct git-fetch(1) to fetch all tags, so we
>> > 		# should now see it.
>> > 		git -C target fetch origin --tags &&
>>
>> Here, we don't really backfill, but rather we request all tags from the
>> remote, hence we end up with the 'discard-me' tag. Not because of the
>> diverged history. I also confirmed this by adding a breakpoint into the
>> `backfill_tags()` function, while running this test.
>
> Oh, exactly. But there's two fetches here: the first one only fetches
> "fetch-me" because we don't pass "--tags". The second one was simply as
> a demonstration that we would also fetch the other tag that doesn't
> point into our fetched history with "--tags".
>

Yup, even the first 'fetch' doesn't hit the backfill flow. Since it
points to the reference being fetched.

> I notice though that the first fetch forgot to `test_cmp`.
>
>> > 		git -C target tag -l >actual &&
>> > 		cat >expect <<-\EOF &&
>> > 		discard-me
>> > 		fetch-me
>> > 		EOF
>> > 		test_cmp expect actual
>> > 	'
>>
>> But I was able to slightly modify the test to get the required affect:
>>
>>   test_expect_success "backfill tags when providing a refspec" '
>>   	git init source &&
>>   	git -C source commit --allow-empty --message common &&
>>   	git clone file://"$(pwd)"/source target &&
>>   	(
>>   	    cd source &&
>>   	    git commit --allow-empty --message history &&
>>   	    git tag history &&
>>   	    git commit --allow-empty --message fetch-me &&
>>   	    git tag fetch-me
>>   	) &&
>>
>>   	# The "history" tag is backfilled eventhough we requested
>>   	# to only fetch the master
>>   	git -C target fetch origin master:branch &&
>>   	git -C target tag -l >actual &&
>>   	cat >expect <<-\EOF &&
>>   	fetch-me
>>   	history
>>   	EOF
>>   	test_cmp expect actual
>>   '
>>
>> I will add this in. Thanks for the explanation, it really helped
>> consolidate my understanding here.
>
> Yup, that should work, as well.
>
>> >> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> >> index c7ff3480fb..d5aee5af10 100644
>> >> --- a/builtin/fetch.c
>> >> +++ b/builtin/fetch.c
>> >> @@ -1686,6 +1686,42 @@ static void ref_transaction_rejection_handler(const char *refname,
> [snip]
>> >> +	if (*transaction && !is_atomic) {
>> >> +		struct ref_rejection_data data = {
>> >> +			.conflict_msg_shown = 0,
>> >> +			.remote_name = remote_name,
>> >> +			.retcode = &retcode,
>> >> +		};
>> >> +
>> >> +		ref_transaction_for_each_rejected_update(*transaction,
>> >> +							 ref_transaction_rejection_handler,
>> >> +							 &data);
>> >> +
>> >> +		ref_transaction_free(*transaction);
>> >> +		*transaction = NULL;
>> >> +	}
>> >
>> > Okay. Do we need to discern cases where this is called and we haven't
>> > managed to even queue a single reference update?
>> >
>>
>> I don't see a reason. This is anyways a post-commit action, if there are
>> no updates, there will be no rejections. So this will be a no-op.
>
> I guess the question was rather whether we fear a negative consequence
> by trying to commit an empty transaction. The commit doesn't know to
> short-circuit empty transactions, so we'd still end up locking data even
> though we eventually end up doing nothing.
>
> Thanks!
>
> Patrick

That's correct, but that's also an internal detail of the reference
backend.

  - In the files backend, since we lock individual files, no updates
    means no locks.

  - The packed backend and reftable backend would lock the entire
    backend.

So I guess this is something we should fix on the backends themselves.

--0000000000007a0c7e064302a10f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: bc77e2432000d75f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rT0RMRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN0VMQy85eERRRjRtYjBxd0JLU0VIOVlrN3A3YUV5YQp6T1BsSWRPUXlv
dUd3Q1BVVXFXMU5DT0hFamxJRHAzYUE3VTBSTTJyN2E2RVlMMFBXdHZVVHZPaDFtSkVRRDg0ClhI
NXhVUDBoa3gwaE5adFFjUXcybERGdExhYkFtRmdXMVdnN1M2RjdyZ1pRSW8rVCtIVnhaSzFJS0Mr
ME5XSnYKMDdjUnFQeE1ERHluNUh4d2RFa0xXSVBBTXZXZ2Y2SmF5KzBncUtFTmp6enBOd2hJSk9N
VGErZGtvUnpxNXR1NgpQRWU3K2NuVCtqTDg4RWpoQThUbUFuM21McitYRmFGOEs1SkxOODAraTdi
bFU2MmhUSlQ2bndBTVZzT3dkYWNWCkRVam44cEtQWlBxOCt3bGFxUUxKWTZyZWhLQVRCMHZaL3Nv
dGZQbE03MmRmckdRRjlROHovaFlBcFo0YWFib1kKcVZhVENLTng1RDlrTTlPRld6SmZNdCtaQVFl
WkFmeUtsRWJKTDBFa3pEY1FmVDRxR241ZmJzT1R2VktjZTZ4MQp0Mm16dTQvR0hBZkVsUUlFZm5D
S3lxUGYvTFpYd2xXMW1DMXFLM245dkkwd0xQcGh2MmRPeUo5a1NSNHc4RStQCmFlODdQVnZOS3JQ
N3VtUjFkWEgzN0JFbjAwd1JBWC80cXJZUGk1dz0KPTNidTEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007a0c7e064302a10f--

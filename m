Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AE021C9EA
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 23:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768001536; cv=none; b=E5h20uHbwTRh1Nki+LhgolZpbyDpydRLFa+McpPUHezkGpRpCa3EtBryIWbSZNU8COnlgJVBFXTQvngYbDpbfY5TAZcvk7V0D6eSOE0jrowKk1BMd6GSrvuRbi9t2lR8gjv1frNmVeIYgsdUCnwxIiNST/dlhPwb2F6spa34+Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768001536; c=relaxed/simple;
	bh=TPvJWLTmNMK8HMp0BOzsF95OXSejebIg5ZRoi9dTna8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwAAq5awKIgyIP8FceZzB8jfXWnX/U0ylfC+fZE9pc3xziPTLbONtjYMex/Gq7cpXAYiBDP12X2kZ0bhGfFwxBol0cseOhIC0ZaT9Pp32ICt4KLek4vwteMl5qGsxHacUgR6owNklFm7LL78maVWwpd06QJiSoyA+FWdM+gczac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=AUEslyl6; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="AUEslyl6"
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-7927541abfaso325197b3.3
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 15:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1768001534; x=1768606334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yxBzAjyzywuyQFXIIjZ0VLRlj5SM2KyBGf8ksUA++3w=;
        b=AUEslyl6SnHF0HSyxKFtRs9lOcmwj4KyPYgyA5Pf9p74xQAdDzxDR45CDCYcHEwPv/
         dL64Phw+ARtgk1H2EVLTEuhuxvFAE/ihziNFbYsvWtMSurhfC2L5fBwutLwFyYaZfkS/
         8bqTkkVwqBsjG6DRKOUm30RK6E0fxppGfdXIFWlbPt8h2KEss/i+EyjWzn4Bx3XV1MF2
         Ymtc2zftuqOZQNWhRNv1bWhpmDYDOraMqngOIr/URXiGj+xHXrweHWYUqGw6K8UJY2ZD
         D0Zrc5eRX0O0eej/pWqIwxbFxRVnxHa+DB52FMUp6huQ+OCpXGEKzOTpnZWSRfNJI2/c
         5RJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768001534; x=1768606334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxBzAjyzywuyQFXIIjZ0VLRlj5SM2KyBGf8ksUA++3w=;
        b=i4g59dxU9GXUfKtUmFQtySgdB7e9u8Afpd0mYVgqJe95G7J677QYUAAsAmv2Ov3Xhn
         m512h9/tzaaMl4KoT2TSYNfGVkA5p78Tflnf1w4edN4DBDLl3uqK5CpwamucwVsOrOg8
         c9MxlpxzN1ecJmulZwjG3N77wK1L7AGQ71alz30x+P4qQVNclEjTZVGJcj6rJb+zMmhH
         awbn2qorrbMS1p6K+17oBbaAluOufxJHSzEuXBikI3E70olSTds6DfD0R1URIup7ivZf
         MNuWfoXFq1miOK0xGkjfCrQ6EahkW/xBf3/oaWCr0rUFtBoNSBPGoqbuFrX02JNXmIQO
         KOkw==
X-Gm-Message-State: AOJu0YwyVb5mogA6iTbfLoSVfzLlSIfnUtBb9JxQITQ2JSjhizEm6rG6
	0BrvU+cwDuX0yje6mQBHUfq+H3kTtmIxZWxWpEkuve7FMtqd1rqe3OfIhr2u49YlCjeVVOkVuCL
	+HuzMJdsRp/GP
X-Gm-Gg: AY/fxX4TnkpHLtsKHN7038YPxPR2saQ2WZPrDHRt7uuNb/vlYVLHG0Qf02KKaTEi6HW
	I39i4Ex7qJgPVtsHripq+CbpKna5XsrJU7yLQaQUX7io9PeqPdZ5Ws0RDvo7MznwAY8tkAUVBQE
	90UmmMRoa0T+03WICH8pB8jZfcxRsUFqi/EG0kqI0FqaIoCUwZBG1IBSxW1ihbyRCo4ZjvQIfOU
	rBluFP7Drgo+0WTdvIDXFOtc6StMsWs2zwcoMCPTTBnYK9/sFR2qQHRA0g0g5L0BP8z5VtpTz+K
	kEQtDgREK7kKuDhXf2Cd8SOtVUxXKdbT2J6dNsGkGSzBKIbqk2G5BBrbZCMHTfnRYaz6EWKL5el
	IDr/Ih0k0izMkdsq4rL4NKCrrVV+DHlaL/Qhs+cqZqwmwzBVmbKUEu2zbOTP9S1kegFQcZ8W7xs
	fdpSP+sz7lrbgalqfDeoJ6edXudO2s4RHm7eeRugoBY2wyE7mFGiAPEzj0+HWQ5ig8cIouBXviF
	ad+OEnzQzS5QCQbSg==
X-Google-Smtp-Source: AGHT+IFoEaVvsYoYPGnHTYsaVVAxzW2CajmaT8YB9GbTBAqw0/gLIdRtd+zzfp5ARj99R0+CYrGg9Q==
X-Received: by 2002:a05:690e:168b:b0:644:7a23:c7db with SMTP id 956f58d0204a3-64716c67b9dmr9544929d50.50.1768001533922;
        Fri, 09 Jan 2026 15:32:13 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d89d4c9sm5094089d50.14.2026.01.09.15.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 15:32:13 -0800 (PST)
Date: Fri, 9 Jan 2026 18:32:12 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/5] builtin/pack-objects: exclude promisor objects with
 "--stdin-packs"
Message-ID: <aWGP/Lp2Eo03F7vN@nand.local>
References: <20260105-pks-geometric-repack-with-promisors-v1-0-c4660573437e@pks.im>
 <20260105-pks-geometric-repack-with-promisors-v1-1-c4660573437e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260105-pks-geometric-repack-with-promisors-v1-1-c4660573437e@pks.im>

On Mon, Jan 05, 2026 at 02:16:41PM +0100, Patrick Steinhardt wrote:
> It is currently not possible to combine "--exclude-promisor-objects"
> with "--stdin-packs" because both flags want to set up a revision walk
> to enumerate the objects to pack. In a subsequent commit though we want
> to extend geometric repacks to support promisor objects, and for that we
> need to handle the combination of both flags.
>
> There are two cases we have to think about here:
>
>   - "--stdin-packs" asks us to pack exactly the objects part of the
>     specified packfiles. It is somewhat questionable what to do in the
>     case where the user asks us to exclude promisor objects, but at the
>     same time explicitly passes a promisor pack to us. For now, we
>     simply abort the request as it is self-contradicting. As we have
>     also been dying before this commit there is no regression here.

I was wondering whether or not this is the case, because we don't have
an explicit `die()` here or a incompatible pair of options declared. But
it does die(), although the message is somewhat confusing:

    $ git.compile pack-objects --stdin-packs --exclude-promisor-objects --stdout >/dev/null
    fatal: cannot use internal rev list with --stdin-packs

;-).

>   - "--stdin-packs=follow" does the same as the first flag, but it also
>     asks us to include all objects transitively reachable from any
>     object in the packs we are about to repack. This is done by doing
>     the revision walk mentioned further up. Luckily, fixing this case is
>     trivial: we only need to modify the revision walk to also set the
>     `exclude_promisor_objects` field.

Hmm. I'm not totally sure if I'm following why we handle this case
separately. Could you elaborate?

> Note that we do not support the "--exclude-promisor-objects-best-effort"
> flag for now as we don't need it to support geometric repacking with
> promisor objects.

I didn't know we had such an option in the first place, but it looks
like it behaves similarly wrt. its incompatibility with `--stdin-packs`.

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c

I'll hold off on commenting on the code to give us a chance to discuss
the above.

> diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
> index 4a8df5a389..cd949025b9 100755
> --- a/t/t5331-pack-objects-stdin.sh
> +++ b/t/t5331-pack-objects-stdin.sh
> @@ -319,6 +319,45 @@ test_expect_success '--stdin-packs=follow walks into unknown packs' '
>  	)
>  '
>
> +test_expect_success '--stdin-packs with promisors' '
> +	test_when_finished "rm -fr repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		git config set maintenance.auto false &&
> +		git remote add promisor garbage &&
> +		git config set remote.promisor.promisor true &&
> +
> +		for c in A B C D
> +		do
> +			echo "$c" >file &&
> +			git add file &&
> +			git commit --message "$c" &&
> +			git tag "$c" || return 1

Unless these changes all have to live in the same file, could this
instead be written as:

    for c in A B C D
    do
        test_commit "$c" || return 1
    done &&
    # ...

?

Thanks,
Taylor

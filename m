Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F771EFFA1
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 20:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785617363; cv=none; b=ojzqq7WBlG/Avn3tVSejbc6+9fG/pS9wYqRjBBzPLgBkh3LKcomA+Rp9DvkEHNxCl8d3ZM1z1QtoivyPC1xx6KB+FSjhDTROoRlHjhQeoLo4g2aHBjosZAl3cFj3zbvLEFRxqq3v0VJ3hcJBM80uYFAMQcJCXcDa+AcbIe6vKoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785617363; c=relaxed/simple;
	bh=CNVdApOzv8iC7L1DKiUNfErC6xedlWXQmhzoca33YFw=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=PShfLzPc+bD2+YS0kSPjeJ9N7eqeLd7HTC1JV/x3Nk7QVMAW9B3iQgwbVcGC9FHrWqOnsMO5XAnG2W8rDsIJxjPE7ykVWKZy/+d5MA/KvmYK3heuL6v/NJ4No5NzKbYugOQZGC8qZh8VRLzGHqmqIm9gdqOhoJM4+ivBo//4v6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQ/vcGcQ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQ/vcGcQ"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49557167508so7916655e9.1
        for <git@vger.kernel.org>; Sat, 01 Aug 2026 13:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785617360; x=1786222160; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KI0uRifdt03RqhcSTNMIWSOZzBjvOjB1hZVFQmex/YU=;
        b=eQ/vcGcQv9s9HwSKDT8TbXUERTjB2iqPIGbboXdYDU1EI38hd8ahlL7tX6EsMXtoAx
         ACh057BntxMwj1tfYwq9y8qp5xcZrcaHfsUMvpmSYVb+vSVhW3iP/DR3HeTiwS8osHRP
         hqvUwJFAQB1JsAyZsUqZ99Z1amTuiKOg+mhO++0adMofHg/f9JlEiOX5DVFzHOIW9PeT
         nUGDg2Tv5k6D/o+5TgYOtE/ZlJBtzyMKKf/7YzJizGezq3gGF5g+BaMFO+W3IpkJqJnD
         kTVKrB5qgGYnSesZlEpGOEctcfIobxE8gXfxX7p7XMYfMZr7KVa3maKotTq/zXkQzjki
         ydyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785617360; x=1786222160;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KI0uRifdt03RqhcSTNMIWSOZzBjvOjB1hZVFQmex/YU=;
        b=QUnbDTBYUQIpIq3DWZqlJd8Zs2vCuIDQRUxbocVv/bVsw98nWSfyiAYB6PhqM1Ho4H
         dWJddjhuO3Nuyk2Lpp5JBHfnI5+l36xHJZ3BYb/QFiwhxm1v8Nj2YzaKFFLuCJFMq2el
         GhWAuY4P4OyS++XlorkYkUSJK25KxmbNr0+CG8tMPjKQUSFYyJDJP0rWGvxyyQ0TAjJI
         shudIbvhfF3SASPgOI95qzjqRKf2rataiNaT7f25PanJyA4H+kBfyZ3/xwYir5iP1cSy
         TM1SqGP9k00Hukd4he9Md4Uz2tVHh3/2gWQq8pI52Fy5rG1RVQhtTrxyRJJGA4sEiVvE
         1+1A==
X-Gm-Message-State: AOJu0Yx0qKPvCdcXme91WOrmvRwb+XMfSq7IpGNzpnzaUo0GzJrXKLJB
	z5gsh+sz+GWhhEjm9o3lNDS1+ZtjgyzfZkue9Sjz7IKHwkbT6URKNKnlsZSAqyjO
X-Gm-Gg: AR+sD11CvRXXiBmbiD5kmdaNOhCUcqnOsKTqxTQi/aDyfbNBSs/UB666EhdYvG3NPX4
	7kmtx0Q70gQTpM3j+6eecMVI3kyXX3MLieKTqrbk4haOCiOSxKNxxPSgcmeCtRAlZkDMlLax5We
	eEHAm7oxnsTPp/2+GZBSptIGl+qhbo8FFkL8ANlrQVVquHD6xkv0laNNW8a5oZNLaC3t64xhaTq
	7BPtGcF02Yw9rvEBlITCNTDWrUs3ZkR8fMuTInoNRxzbRRNqEfwsma5MyCxTSszVsbVqewXdhp3
	3K7FbtG+NaurNTktHgbzx7b5yI3eiUd7THejQPOkKykTOJ7Lb9in/t1Cv9dBczEVbUv38FNoSR+
	XTO825ZwRHRSUpex9Xi+8v+QHTv1Yc6YV8XKhSkiUhnokm2CeTCx3JhLpN+oF074cSFCXfsVOSv
	+hyEtXpSOqirkLhU5lg9hqDAb3uulP9d8BtK1LAV5xg5qd3ZocrH5lWfn4iSxFOKlK34tpcniF1
	mRaNZSH/StGsGS6YEq5Y7+n3qqnaO6ufmmSuHaoOf3gAhl8ik0ZiiwX2a1xKo+gTrx8iVMGoYBw
	JBOUrw+xeFDkC0OY4xtwAieCqdPvo0vPWY1q18gExhzcDzAYBVLxzzOBlpxZY1Q8LaUFZqOzyvM
	=
X-Received: by 2002:a05:600c:1393:b0:495:4fd4:619b with SMTP id 5b1f17b1804b1-4980c649c54mr86155555e9.1.1785617359981;
        Sat, 01 Aug 2026 13:49:19 -0700 (PDT)
Received: from localhost ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498081a1910sm37076355e9.4.2026.08.01.13.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2026 13:49:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 01 Aug 2026 22:49:17 +0200
Message-Id: <DKDWIXJQF4E8.1L2ZF7HSLKNAW@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
Cc: <git@vger.kernel.org>, <chandrapratap3519@gmail.com>,
 <karthik.188@gmail.com>
Subject: Re: [PATCH GSoC v2 2/6] t5701: use the test_file_size() helper
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260731-objecttype-support-v2-0-af577461ed57@gmail.com>
 <20260731-objecttype-support-v2-2-af577461ed57@gmail.com>
 <xmqqqzkia2is.fsf@gitster.g>
In-Reply-To: <xmqqqzkia2is.fsf@gitster.g>

On Sat Aug 1, 2026 at 6:27 AM CEST, Junio C Hamano wrote:
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
>> An object-info test uses 'wc -c <two.t | xargs' to get the file size.
>> Update it to use the test_file_size() helper instead.
>
> What is missing from this description is what is wrong with the use
> of that "wc -c | xargs" construct.  What benefit is this change
> supposed to gain?

True, the patch was small and I did not write the commit message
properly.

The xargs is there to strip the leading blanks that wc adds on some
OS (I tested this on macOS).
test_file_size() reports the size without any padding, so nothing needs
to be stripped.

I'll write the log correctly next reroll.

>
>> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
>> Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
>> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
>> ---
>>  t/t5701-git-serve.sh | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
>> index 9a575aa098..b4d6beef11 100755
>> --- a/t/t5701-git-serve.sh
>> +++ b/t/t5701-git-serve.sh
>> @@ -356,8 +356,8 @@ test_expect_success 'basics of object-info' '
>>
>>  	cat >expect <<-EOF &&
>>  	size
>> -	$(git rev-parse two:two.t) $(wc -c <two.t | xargs)
>> -	$(git rev-parse two:two.t) $(wc -c <two.t | xargs)
>> +	$(git rev-parse two:two.t) $(test_file_size two.t)
>> +	$(git rev-parse two:two.t) $(test_file_size two.t)
>>  	0000
>>  	EOF
>
> It is not like we want to avoid piping wc -c into xargs and hide the
> exit status from "wc -c".  We are already losing the exit status of
> "git rev-parse" anyway.
>
> If the test after the change were like this
>
> 	two_object=3D$(git rev-parse two:two.t) &&
> 	two_size=3D$(test_file_size two.t) &&
> 	cat >expect <<-EOF &&
> 	size
> 	$two_object $two_size
> 	$two_object $two_size
> 	0000
> 	EOF
>
> you can sell it as "we do not want to lose exit status of 'git
> rev-parse'", "we do not need to run the same command twice", etc.
> But it is unclear what we gain by rewriting the wc-piped-to-xargs
> to test_file_size.

I will do that, I'll move the object name and size to variables so they
are not recomputed.

Thanks for the review,
Pablo



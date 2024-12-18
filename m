Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DB71BEF89
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734531690; cv=none; b=aNGw7sc2wo0EXCxziTh47RQwRaEkKunoTGddsLaRWDSwBMBl2FMtJtSsXqHx6vIdevSV9inwPlDUEeODN7jOIr2JKMbEJ4St9/PKlP7VgIMOfZHvNwYC5Dfc6qjwL53Mwew7Oj5WddIkjRxoM+f2/xiYyrvq2nzIpGgl474woRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734531690; c=relaxed/simple;
	bh=6RNQAY2wpNIuURTlbN38TpAAY5pSkJkLXuQ0iZR78kQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AyCl4ZOCFclE9Lv6NDM3ZSztiBXUswEM7XootYBbYZstr9s3wU3PYWVK5TAqF9lud+zGGNDAuoYTyjXrSg2767QOGk/7vb6Mkpi2Um3WV468b1ORkdSbp7AS2DkIjCmusDkejCF8vB8UagIE+qk+vNEOaik/HaBM94R/9mTMxds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTH2oOpw; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTH2oOpw"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e455bf1f4d3so3916272276.2
        for <git@vger.kernel.org>; Wed, 18 Dec 2024 06:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734531687; x=1735136487; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ul+dZbYdBjHbi3mOr9GooyXpACBYl83uK6yMTanbPOk=;
        b=DTH2oOpwV4VXwVTKDs5fsQJSUIexX+SN1onOsBLWVfsapE/W/YdaKvqdNBFqQiuabk
         VMteO9G/hzuc4g0D8A3ETSfFl+K619vUWY1yDOVTRu3S/0xANiwJoEpBUmLmzakbsvTm
         4LsL7yQ7y++C1Pbb/sl828TCt+qqla3hkIAQ0gXdHEABndUoInBe5wCkuBr+O+65ut+b
         qmVQgGsUmcp7hMffH2SMbGIJWasiuBk25pIbiigxmdkFWxhIG89n43qbCtiLdPd3gHTP
         5bvBa2oMvQn45KvEu2XFL8O8Eu3/PxYk8yUMmMGPWyaCj46VOvJsO22aCUm5DeaoVOxa
         3RuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734531687; x=1735136487;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ul+dZbYdBjHbi3mOr9GooyXpACBYl83uK6yMTanbPOk=;
        b=lvfoAUQ2mPlhX3N00R0fI1Kk7TqbCLLmGRUxWvuk+a0IEQEfAGKeFAVWrtod20yRMZ
         fEE7H/G1PmTOs1Cm0Nz8h85l+DYOLxYJSRsmcRSTi13VY6VaN4MKEEMZwau3I7O9xAeZ
         yUmyop1we0611fYVHOKmSK0+JoEqRJpZh0rQkFZLD6l+QDlSsNrCVmGHBA+hDleRIJ0y
         R1ZbJB4tAxZC3IWSw9aE4YvovYOBwR5glgZL62Fp0gZxr98ah4VJDd+PFZnQSHNbjPyD
         /8prKZqUHJrUxY8/+0VtGwpu3kbRpJHGlJgvZ/bU0YDbBZ6lG/MiMIEhjF7/inrNywWv
         5bNA==
X-Gm-Message-State: AOJu0YxOd8qrMJQ5IJzMdehkQ7j+WsEMNvFbrYli0f2xpHYkwGfzYZg8
	PtShFFJ3TAEun811PhZHp2bkw4D+tdD80u1umAe6uwwa2d9TXqWC
X-Gm-Gg: ASbGncsp3pDWmbzM5Ha8197M+r3TkYzR8qdBMiy/C5OX8oR5q+DnwIrer3mB3qlxnuL
	Jjesw7OOZJmE3Dkd+DVuX6wQ29zXB6iaMoTCl3l943XNgDk30i0ULo/fMF3H+oY3BgPzBK79x3K
	Ap+pNu+uhzBPIqc5V79/z2I970AednrPYFcSnOekMvSh6k8Qi0JR2o9hAAsCUMLTcQuIVLT7zGK
	z0PRWOX0QbAMkGwri47xI4zjmsrIfc/418eR2yvZpWX6EDUOG4FmiVUS3PRd/3Lu+RlUcWSYmqR
	iv5MgqXvI/i2mbUH7gTWKFtsF4KKLpMb2O6oX1vKg9tl
X-Google-Smtp-Source: AGHT+IG1b3kBe0n3HfkxZcbFChX5lCoXDnJNn2B11JWQJukHeF1YPgIW5LV2KU/Uym/aN5bYceM8PA==
X-Received: by 2002:a05:6902:2413:b0:e49:c11a:757d with SMTP id 3f1490d57ef6-e5362101769mr2590579276.20.1734531687529;
        Wed, 18 Dec 2024 06:21:27 -0800 (PST)
Received: from ?IPV6:2600:1700:60ba:9810:79bd:fdfb:4e92:f26c? ([2600:1700:60ba:9810:79bd:fdfb:4e92:f26c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e4703160a6bsm2345929276.15.2024.12.18.06.21.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 06:21:26 -0800 (PST)
Message-ID: <eda7d3b7-8c3b-4486-b292-2507ca7f3bf9@gmail.com>
Date: Wed, 18 Dec 2024 09:21:25 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] path-walk: introduce an object walk by path
To: Patrick Steinhardt <ps@pks.im>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
 peff@peff.net, me@ttaylorr.com, johncai86@gmail.com, newren@gmail.com,
 christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com,
 jonathantanmy@google.com, karthik nayak <karthik.188@gmail.com>
References: <pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>
 <pull.1818.v3.git.1733514358.gitgitgadget@gmail.com>
 <b7e9b81e8b32313f00d38257ba731e73d17224cb.1733514358.git.gitgitgadget@gmail.com>
 <Z1whcUJE-MHAhULO@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <Z1whcUJE-MHAhULO@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/13/24 6:58 AM, Patrick Steinhardt wrote:
> On Fri, Dec 06, 2024 at 07:45:52PM +0000, Derrick Stolee via GitGitGadget wrote:

>> +	} else if (parse_tree_gently(tree, 1)) {
>> +		die("bad tree object %s", oid_to_hex(oid));
> 
> I wonder whether we maybe shouldn't die but instead return an error in
> the spirit of libification.

This is in fact something that is being tested when 'git pack-objects' has
the --path-walk feature. See "get an error for missing tree object" in
t5317 as an example.

It's not enough to fail, but we need to fail with this error message.

Has there been enough progress in the libification effort to establish a
pattern for returning an error message like "bad tree object %s" from an
API like this to the caller?

I will try using a "error(); return -1;" and consider that as the best
option for right now.

>> +		} else {
>> +			/* Wrong type? */
>> +			continue;
> 
> This code is unreachable, so we could make this a `BUG()`. Might also
> use a switch instead, but that's more of a stylistic question.

I think a BUG() would be good here.

>> +		}
>> +
>> +		if (!o) /* report error?*/
>> +			continue;
> 
> So this can only happen in case `lookup_tree()` or `lookup_blob()`
> run into an error. I think this error should definitely be bubbled up so
> that we don't silently skip tree entries in case of repo corruption.

Looks like I agreed with you but didn't follow through.

>> +		/* Skip this object if already seen. */
>> +		if (o->flags & SEEN)
>> +			continue;
>> +		o->flags |= SEEN;
> 
> This made me wonder: why do we only skip the object this late? Couldn't
> we already have done so immediately after we have looked up the object
> to avoid some work? If not, it might be useful to add a comment why it
> has to come this late.

I went to look to see if there was a reason, and at this point there is
not a good reason. This should be moved up to avoid some checks and path
manipulation.

I think that in a later patch, the use of the UNINTERESTING flag is
important to pass the flag even when the object is already SEEN. This is
probably cruft from an earlier version that passed the UNINTERESTING bits
in this part of the code.

>> +		if (!t) {
>> +			warning("could not find tree %s", oid_to_hex(oid));
>> +			continue;
>> +		}
> 
> Is this error something we should bubble up to the caller? As mentioned
> above, I'm being cautious about silently accepting potentially-corrupt
> data. Silent in the spirit of the caller not noticing it, not in the
> sense of the user not noticing it.
Can do.

Thanks for the careful review!
-Stolee


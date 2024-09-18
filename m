Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59E219DF51
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 23:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726702246; cv=none; b=HusVUl535uXixRlr5lNJzPsujGmT7HnpFI5fUN/NjKHk+0owOXxAj4+bvDClsxXZNaKR5OcF96q2BBKA3dSASZwc96ul5ifvWgdrvrJJaqabKB94xnXy78tkwdKUNBCn0GIgh3xP8kJvidnbNIKFZjnlpHROmP13MqtqNzjcM34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726702246; c=relaxed/simple;
	bh=DP5JccrrKUEWaNuwa819z7YfRm1ZduyfVxGrFI8hZWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ErW/o7e8gRY5/8B0Enq92AMEXMcaxTwSvAefs7GVvUjrxT2vjna2aC5OA/7wVMYX8F9GRdfQ/opJHKFnbgUyyLDfKtaNQQRuBZr3/SqhEJQ/8KuFRAKDRwB5ld1S4OoNCelxBzAsWussSqJaGx5IEFZslFOlXl5ptijMNYmndB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTlyRAze; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTlyRAze"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2068a7c9286so3139585ad.1
        for <git@vger.kernel.org>; Wed, 18 Sep 2024 16:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726702244; x=1727307044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6+hrKzufaVHPPuYWkdhHtjyI/H3aYF0P3M0/Izl4cO4=;
        b=nTlyRAzeoEXxOck7PULXSG5kGqIDr4rX8d5ZCevtPDwQcVCjoDmXuu6QMwEkvo7iEd
         oEhYokz2F28R7whLCb17iCnEDBmu3FVin/ke7QG4ioyxoXAzWW3uiFiK09p+7knDEQgg
         nAsq6oWEk3s0teUAmBVKMwDqhmDwLhxu0G1KpGLaq8K/d1woJIJRLjyM9/tKN89kMLox
         aRyYeHiSktoaNbV+Ck2qgBHXCXCQGvjSEsTksuDp64SNg2xNzD97AFeLmFepON+36n4P
         WIpFNusxEIjs57OhufE0IgMjxrxOXIblDPVzOd1EhcnQJCybVUoUvNmAz3tkhqdDMDhA
         SqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726702244; x=1727307044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+hrKzufaVHPPuYWkdhHtjyI/H3aYF0P3M0/Izl4cO4=;
        b=GEy7pfa4smMbbMmUwprmg8ov3AmRReLO2f5Ch+TaYkdX1lXGmI/cgAeBcPbUlMdLQy
         WMaZSjY8qQOiWbhxzFRx6uG7qii48+HvmCrurhjuaxRk03XlcaAdrIWotzZy9JREq9AK
         Vo1hLsa7qrnEjPA8JM6Z7kG9vcnU5E4oMf6jrTezj+yb9M20ReOpQ0mMetE56dElCmDC
         k3gUk5VAtCHU8qFoFOLTkJuC+k4O7WkrOtmJDUq6cNM01xJyRouLoi6CIiiSF4tQMrLD
         BUBuI4rY04RDpTKXCId4+6qP0hNORjhVJIDp42tXGxYCygEP0T4bGrnwkLElnQWlkl9U
         qRFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/zZWIal5zWiGti83J1b2MNJ5eD837bLAdYcWLjYygA9SRsB/MD6LIuRYVuJ2U+BJ0D8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwMUnif0dv7VpKtNBWixZ3gweq0VV8KeCwqJEBRDEjTaDVAVvL
	UoZ6WWKkXd+T+vXHOmrO1mqZOmhigTHGtIiryIKhJMefBqhNs8Ry
X-Google-Smtp-Source: AGHT+IFfLLSOYZjWakFNXJJoDMh3h5iHO+ErYnKAsoGNJ9h/oyRHALkYBWbbDxvqil7mwxHU03bjVQ==
X-Received: by 2002:a17:902:cf01:b0:202:13b0:f8d2 with SMTP id d9443c01a7336-20782a69ef3mr295116085ad.46.1726702243962;
        Wed, 18 Sep 2024 16:30:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:8559:eaef:b03f:6f5f? ([2600:1700:60ba:9810:8559:eaef:b03f:6f5f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794601379sm69821705ad.95.2024.09.18.16.30.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 16:30:43 -0700 (PDT)
Message-ID: <b2ad8d6f-ad66-4ca4-8b27-8e5450306c99@gmail.com>
Date: Wed, 18 Sep 2024 19:30:42 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] pack-objects: create new name-hash algorithm
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net, ps@pks.im,
 me@ttaylorr.com, johncai86@gmail.com, newren@gmail.com
References: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
 <pull.1785.v2.git.1726692381.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.1785.v2.git.1726692381.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/24 4:46 PM, Derrick Stolee via GitGitGadget wrote:
...
 > Other things that have happened include investigations into ways to adapt
 > the full-name hash to improve upon the name-hash. I did some experimenting
 > with increasing the size of 'struct object_entry' by using a 64-bit hash
 > value (name-hash, then full-name-hash) for a single-pass compression or two
 > 32-bit hash values for a two-pass compression process. I include my WIP
 > branch at [3] to show what I tried, though the single-pass option did not
 > present any improvements and the two-pass option seems to be broken to the
 > point that the compression is substantially worse. (I'll try to elaborate on
 > this in a reply to this cover letter.)
 >
 > [3] 
https://github.com/derrickstolee/git/compare/full-name...derrickstolee:git:full-name-wip

To break down what I attempted in [3], let me break down a few things.

First, I tried using a 64-bit hash value [1]. This used the standard name-hash
as the most-significant digits and the full-name-hash as the least-significant
digits. The goal here was to still have locality from the name-hash but get a
good partition based on full-name-hash within those collisions.

However, when sorting this way, the boundaries of the full-name-hash partitions
are ineffective at getting good delta bases because the largest object from one
full-name-hash set is next to the smallest object from the next full-name-hash
set. Even when a full-name-hash set has size one, it is sorted roughly randomly
among the other colliding path names instead of grouped nicely with objects of
a similar size. This makes the results nearly identical to the 32-bit
full-name-hash implementation.

[1] 
https://github.com/derrickstolee/git/commit/aaa6befa3016667ea5eb10fdd6aa2b7fcec3a52e

Second, I tried storing two 32-bit hashes and doing a two-pass delta search [2].
In theory, this should be very similar to the --path-walk feature from the RFC.
However, I failed to make it work. Something about this version of a two-pass
walk was hitting some strange behavior. For example, I had to put in this extra
condition [4] if a best delta base was not found, or else we could get a
segfault.

[2] 
https://github.com/derrickstolee/git/commit/bf71271040ab93a624a8cdf5bc8aaff68e9b1b17

[4] 
https://github.com/derrickstolee/git/commit/fedc4fc543e50563f4748a5ffc45b51b530023e0

In fact, the results were not just _bad_ but they were _significantly worse_.

It took me a long time to report these details because they just didn't make
sense and I couldn't figure out what was going wrong. I'd be very grateful to
anyone who could explore these WIP commits and point out what I'm doing wrong
so I can learn and maybe we can get a boost to the feature.

Even if we had strong data from these examples, I'm not sure that we'd want
to add four bytes per object to the packing data, especially in a way that
impacts users that aren't even using the new feature. We would want to
explore options that use some kind of hashtable to map objects to their
64-bit hash values, perhaps. It also affects the .bitmap file format, which
would need modification even for a new 32-bit hash function (though one of
the same size could be used by adding an extension saying "I'm using hash
function v2" and leave the rest of the structure the same).

I would also like to test the performance against the threaded version of the
--path-walk feature, which I recently got working in my prototype branch [5].

[5] 
https://github.com/derrickstolee/git/pull/28/commits/a9fc233390ae00e3d4b156be64d6b3974e30d8a1

Thanks,
-Stolee

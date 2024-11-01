Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F0316A959
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 13:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730468539; cv=none; b=tbhhzPylr5thWqQ6OgxyyH23Q4X4U4UbIMssAASpujC+ATXcFPtjdeIwIzvOJHK9Q3IDZM6KYtAV3j1wUPrllySBBN/oCXKse5roD/fZ7+yJqQxz0UaPV1FkKraRWz6F0WMyx9AFHvWj9gysKAq9sqQzu3km2+ojU6mUCfvCAKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730468539; c=relaxed/simple;
	bh=lyOVZAgvj24Tmnn2zS8msf86kMbdktWp1cToaPa6t9Q=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q1XOwouFTDxchUhvOHLUuElKYbk4NWoYz75hS70Qsdz4z5unf2TCGeWYxdKnRG//YRH73BNYW2gKvz43fQ2VUjSczu7qXBzJye4mzTQ0hGYalehfLXIBFm3sUrdBX78ct98ikKr4D/uBfaMDMTcjrm/PHi+A4qddI1OjMzxY4vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGRwNeWJ; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGRwNeWJ"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-84fccf51df1so557479241.2
        for <git@vger.kernel.org>; Fri, 01 Nov 2024 06:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730468536; x=1731073336; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hULcAeeBYehtRTiPFrGWjLZctF7xPAmW5u5sMLEr6uU=;
        b=OGRwNeWJWUU56btmRj81s+MAwCduuZW+kP9UoVq45dZzuo78lg0DGLXwY7BQVXk9R4
         gNayFvAtRjPbdTExPXIyzDjdrRfebmq2NfVmU3sSKRgoSwU5QhU/uxaxtUlH3OzhNvHN
         w7fXqWcrUMVZ1HXH/mA1tBSWjR/LsEzrBxVbkbWDnGyrzkwvcnnVG3SwHxYNlu7Al4QU
         AVcUUQ3ai4yHFc1IyWjb2nkjHOAsoaohZr7D//6w05JMRz6YAnzR28OBokFTy2J8uqBA
         hcxIuNXRyIGskiX7ycWSUrPR45aYaFfqyuSI9/TQnPExHUuVlGs1pW/Mk9JnM5Fee79n
         90bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730468536; x=1731073336;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hULcAeeBYehtRTiPFrGWjLZctF7xPAmW5u5sMLEr6uU=;
        b=hhfYgzOrbgCLi7xZ1e20D+W99eEZj0kQGT+Q/qvg4Lzql3cMi6vvgUI6D6WFHoGI9z
         Vk/qypcapubx+3xjbd6yE0/gvmlIpmqrBjAr7H1/QSbT+ks2Tuuv8TzH5vi0yOC8MONb
         2Dpug5HXRA+/lkzQpvrStA1BmwcLF0qGBj/eWSoQwghWp0QOR4+Tshpw0g1/Vf0cbAvZ
         hJLHX7/OJQQe4q3/fGtHEaIg5+F4dHtmd62g3Qpnsv4vg/+jiPNhfkx4jFz86JnQOPPw
         ofShnAtrMMn+S0DGkhLm5E4aGAYj2Ji9fc7FrseTnzhuM3CcL2/54oonIoC1FDAvJa4m
         Hhgw==
X-Forwarded-Encrypted: i=1; AJvYcCXO1a520eDyziHOg1i4eyJluS/S7IO+fBrygDcrbCA0yV0lFMyJRBhTLoZujYGcTo1C0KI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/yJtbbkK5vDsWk/Bkz7KHFD3qbmyA5cTNiYJc4dR1sSUiqd3J
	Lqyh8oEeeuRl6ri1fRgKFZAebIRTzyJTtOqXaMvga3ZF+bw+xGnhGVicOgBIF251ap9IZ1aXvHO
	pidtRRwyj695hSBYXRDCTBnsEXNA=
X-Google-Smtp-Source: AGHT+IGbWEOvZaMg6K7SAyx/cMZaf4smqYIEa2JS5RFoYak/X5thr34Iy3pbZVYVxmnEuW4JTpde9l4vn420vYST2D8=
X-Received: by 2002:a05:6122:134c:b0:50d:44fd:5b68 with SMTP id
 71dfb90a1353d-5101510d909mr23788985e0c.10.1730468534538; Fri, 01 Nov 2024
 06:42:14 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 Nov 2024 06:42:11 -0700
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <draft-87r07v14kl.fsf@archlinux.mail-host-address-is-not-set>
References: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
 <c71f0a0e3613555de83668473ce97db86aad659f.1730356023.git.gitgitgadget@gmail.com>
 <draft-87r07v14kl.fsf@archlinux.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 1 Nov 2024 06:42:11 -0700
Message-ID: <CAOLa=ZRJd7CXNFi1V=4UN_CuNFHqSsOGE5S0AnVeBMvPJJy72w@mail.gmail.com>
Subject: Re: [PATCH 1/6] path-walk: introduce an object walk by path
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net, ps@pks.im, 
	me@ttaylorr.com, johncai86@gmail.com, newren@gmail.com, 
	christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com, 
	jonathantanmy@google.com, Derrick Stolee <stolee@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000004bf7850625da1abb"

--0000000000004bf7850625da1abb
Content-Type: text/plain; charset="UTF-8"

karthik nayak <karthik.188@gmail.com> writes:

> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> In anticipation of a few planned applications, introduce the most basic form
>> of a path-walk API. It currently assumes that there are no UNINTERESTING
>> objects, and does not include any complicated filters. It calls a function
>> pointer on groups of tree and blob objects as grouped by path. This only
>> includes objects the first time they are discovered, so an object that
>> appears at multiple paths will not be included in two batches.
>>
>> These batches are collected in 'struct type_and_oid_list' objects, which
>> store an object type and an oid_array of objects.
>>
>> The data structures are documented in 'struct path_walk_context', but in
>> summary the most important are:
>>
>>   * 'paths_to_lists' is a strmap that connects a path to a
>>     type_and_oid_list for that path. To avoid conflicts in path names,
>>     we make sure that tree paths end in "/" (except the root path with
>>     is an empty string) and blob paths do not end in "/".
>>
>>   * 'path_stack' is a string list that is added to in an append-only
>>     way. This stores the stack of our depth-first search on the heap
>>     instead of using recursion.
>>
>>   * 'path_stack_pushed' is a strmap that stores path names that were
>>     already added to 'path_stack', to avoid repeating paths in the
>>     stack. Mostly, this saves us from quadratic lookups from doing
>>     unsorted checks into the string_list.
>>
>> The coupling of 'path_stack' and 'path_stack_pushed' is protected by the
>> push_to_stack() method. Call this instead of inserting into these
>> structures directly.
>>
>> The walk_objects_by_path() method initializes these structures and
>> starts walking commits from the given rev_info struct. The commits are
>> used to find the list of root trees which populate the start of our
>> depth-first search.
>
> Isn't this more of breadth-first search? Reading through the code, the
> algorithm seems something like:
>
> - For each commit in list of commits (from rev_info)
>   - Tackle each root tree, add root path to the stack.
> - For each path in stack left
>   - Call the callback provided by client.
>   - Find all its first level children, add each to the stack.
>
> So wouldn't this go through the tree in level by level basis? Making it
> a BFS?

My bad here, thinking more about it, it is DFS indeed. Although we add
all the children of a level to the stack, we pop each of them from the
stack and end up traversing down that level.

>
> Apart from this, the patch itself looks solid. I ended up writing a
> small client to play with this API, and was very pleased how quickly I
> could get it running.
>
> [snip]

--0000000000004bf7850625da1abb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3c43888399e32fac_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jazJyQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOVRuQy85bk1ySGh4eHdRM2tuU1paWlJQeWxVVk1qdAphZ2o0Vk5SNm1Z
WlkxYjc2dVBKTDg5U1A4blJtNytSZU5Pa3RleTlqVG1iQlpIWWFROStHb2xDL09DTUYvVUlJCkhp
dVVUclV3SU11MGVkRmN6bUd5a2kzSXM4OGp6Y0h1QzQxK3J2K1pUMHdlci9zbFNqVTA1NWd0cS9V
TWJsTXMKSlhiRyt2Sk5GWXF0Z3Rjb0FWaGttam1Hd3ZLUE1TRk5PamkwemdxN3JtWThKM2JtclhO
NjJUblFrVmQ0QTlKbQpLczF2OWNtMDREVXpvRGkxMTIwSGZjU3c3Y2lzN3M0SVYxaHRuSFR1QkpM
K0R4cEdtbnU2MmJUdmd0MTZoQzJLClQxeXg5cTk4a3pCLzUvaitnTWRnZEZDRGlUOHF1bEVYMnR5
MW9VRmgwNGxGTDdpa0toN3RZQ1EyQWhmTzZUY2QKV01kSGI5a3NOTno1dDE5NDVJTGNlRS9uci9K
V3lMRFk4WWg5cE9UM1FwVzd2TDE0eml6R2thUDhYNm00YUlnMQo0SHdyUGJFckkrK1dnc0ZEclZj
RFo1NE1SK1NBN1lWREpTdmxBdGJhSXRsN1V1bmZRQXBMempzNlRJdm13Nlh3CkZ3QjVYcWhTQ0l0
RWNnRXNiUDh6TDM2S3dydHBiL1hoZVA2OHpjTT0KPXMrTDEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004bf7850625da1abb--

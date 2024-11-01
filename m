Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FF6156C5E
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 13:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730466740; cv=none; b=pKKAVMkyMtAavbVXA/GP2jLtjOYUUITtljcLtrozDOKhIqGNeT4UUbXgyNezgZuD5zNNZdmVZB4i12UZBXWg9RydPwFc1p9LKuJvQNh1B80lgLSmEXsHtqlKA82P3TEK0PLFM1zcmCFoR5QdUjDmC/VL3Lq7CqI/OjzdHJSJPCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730466740; c=relaxed/simple;
	bh=v3mmAMyj6bxNc9kaHGlpGW3r3k7VW671LM8alaPI9mI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UcvgG1yWigqERYcrBvkXZSUuvRNx+WHATZQaB3R8jgUJdSJB2e0RTQWzZt2TOJWy5P3N9f87iei4ZEfCvgxH6E/T2+TEqweeg8TVXATGQktWy8n5KczvL86T0bDR7bVblFgfYccEkVN+GqqNWidV0GWGOXpXJK5fFmIgbrEpVFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjzvDzlF; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjzvDzlF"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b18da94ba9so161837985a.0
        for <git@vger.kernel.org>; Fri, 01 Nov 2024 06:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730466737; x=1731071537; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pdf9NaZOYDyGm/xMgXk3wYdu11axu66rsvjbzDPiZdU=;
        b=OjzvDzlFuwngG6QFXJlrc4cmRr+4gg/2biZCyhBP2SmNLNO11F1jicowlsxrc1R0NO
         7fD7YZ/A9FSRxkl9oybma2zRdS6eRUvHR0aE+6+r0G2vwOuXAQeU5phRpmiCpHE9UoJz
         kmLZbNCfc4UFMza+/ylPxXT4WjVeDAtXbLTB1rvp0WsZ2sQIVkl7sjR9uFZAtZWIMJ+W
         YtFi5lNkCw0tdAkpLJEJPp/AzYVwMZkNmQaNozyJbmX+chYVp33+TeafdopM/8JcSSHu
         4dlk4IxFZ5FJxwRcJDIwoRPtQY7wtUKbOPeT33udkdB2pp5Rsnklz/lONKP8CZVk5ZTp
         qBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730466737; x=1731071537;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pdf9NaZOYDyGm/xMgXk3wYdu11axu66rsvjbzDPiZdU=;
        b=DDqCWO2iAfNB3h+e1j8QpZuL4/eMKLvAArxeWSo5SuuQyEYG0YxWqBw4qn3Mp9MCth
         1Td5z0VKLph4YD/sH/sBVDQRpgqhlFCybnNwHHOXftLu3nsbC7LLofS5U+kkoXmU5GNb
         lxLDw2FcFRgEm+Y+0mTHQ4EAgJxl6Lew4Wj+u6YGBCQFaO2YMR6XTVHLbivdWJF9D0Dv
         YK8ix2rbJKEqe9oOxVMfxvJ2qY9fJcTrxvKE5u5bW6/QDzRZxiNZgGS2UAmmlmLCFRHb
         fREJDpSBsP1aThFmqF7CvD63eWcrDqcs9hbxcbiR7KH9JurRALYrnoV8rd97dZuibuzp
         hX3w==
X-Forwarded-Encrypted: i=1; AJvYcCVB9A5tMVHZNAXHGGtTYnZswbw/jtkUK9xw4LyUhor/kKdkI9wJpAv8d+rKbr1nFzFtYKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR2zhjith+RjB6LVrqTiWwsmXLRD2LnbMjaD34QRirNEhDRL9K
	89AVOqb5Y3f83q9w7g9ZkLWad6kQZAkYR1j4cOiDej9kyPauhIkg1OA8s38Saq2QQOssp8iILNr
	sGlHI1Cg+2dGmXpZjklHXltwa9bc=
X-Google-Smtp-Source: AGHT+IHtIRjDdAjL574PMwpw8OVxUQ1bJFKh3FNQqTN/DSZ5eNcOxcMecJ7/T3WMDanG5wBNzv2sxmqTMinlqy1BXlg=
X-Received: by 2002:a05:620a:3183:b0:7b1:5545:7104 with SMTP id
 af79cd13be357-7b2fa60b822mr591520585a.2.1730466737057; Fri, 01 Nov 2024
 06:12:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 Nov 2024 06:12:16 -0700
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <c71f0a0e3613555de83668473ce97db86aad659f.1730356023.git.gitgitgadget@gmail.com>
References: <pull.1818.git.1730356023.gitgitgadget@gmail.com> <c71f0a0e3613555de83668473ce97db86aad659f.1730356023.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 1 Nov 2024 06:12:16 -0700
Message-ID: <CAOLa=ZQnEL7i=QbqjHYjpjWv_uhG=u+1w1FUKTMgkfNYd3fefg@mail.gmail.com>
Subject: Re: [PATCH 1/6] path-walk: introduce an object walk by path
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net, ps@pks.im, 
	me@ttaylorr.com, johncai86@gmail.com, newren@gmail.com, 
	christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com, 
	jonathantanmy@google.com, Derrick Stolee <stolee@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000028cae70625d9af8f"

--00000000000028cae70625d9af8f
Content-Type: text/plain; charset="UTF-8"

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <stolee@gmail.com>
>
> In anticipation of a few planned applications, introduce the most basic form
> of a path-walk API. It currently assumes that there are no UNINTERESTING
> objects, and does not include any complicated filters. It calls a function
> pointer on groups of tree and blob objects as grouped by path. This only
> includes objects the first time they are discovered, so an object that
> appears at multiple paths will not be included in two batches.
>
> These batches are collected in 'struct type_and_oid_list' objects, which
> store an object type and an oid_array of objects.
>
> The data structures are documented in 'struct path_walk_context', but in
> summary the most important are:
>
>   * 'paths_to_lists' is a strmap that connects a path to a
>     type_and_oid_list for that path. To avoid conflicts in path names,
>     we make sure that tree paths end in "/" (except the root path with
>     is an empty string) and blob paths do not end in "/".
>
>   * 'path_stack' is a string list that is added to in an append-only
>     way. This stores the stack of our depth-first search on the heap
>     instead of using recursion.
>
>   * 'path_stack_pushed' is a strmap that stores path names that were
>     already added to 'path_stack', to avoid repeating paths in the
>     stack. Mostly, this saves us from quadratic lookups from doing
>     unsorted checks into the string_list.
>
> The coupling of 'path_stack' and 'path_stack_pushed' is protected by the
> push_to_stack() method. Call this instead of inserting into these
> structures directly.
>
> The walk_objects_by_path() method initializes these structures and
> starts walking commits from the given rev_info struct. The commits are
> used to find the list of root trees which populate the start of our
> depth-first search.

Isn't this more of breadth-first search? Reading through the code, the
algorithm seems something like:

- For each commit in list of commits (from rev_info)
  - Tackle each root tree, add root path to the stack.
- For each path in stack left
  - Call the callback provided by client.
  - Find all its first level children, add each to the stack.

So wouldn't this go through the tree in level by level basis? Making it
a BFS?

Apart from this, the patch itself looks solid. I ended up writing a
small client to play with this API, and was very pleased how quickly I
could get it running.

[snip]

--00000000000028cae70625d9af8f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c7ab30e4824ac101_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jazA2b1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md0hwQy85YzhaMVRjYlZBbERhUGwzR0VkcUdocG15VQppYUdZbm5BcVh5
Y24yWEpuM05nRzduUTZhWlk4Y2cwZDF5aXZnb29qamplaStteEJqVTVIa2d0U09JMmJwRThJCnl4
eUtSaFhleUh5UTdlRmRXb2I1eENlRjdBbzhIWElUZllXU0JrcWZRZ3pURXg0Vm92amY3dHhCMGN6
RFpGR1kKUURPdGRKa1IxQ2gvYWpqaFM5Tjh2dWgxeGJ6aFhIOHF1dVZzbnI1bHJIdUZWcVJnc2cr
WU9zWTRJMjVlOWxTTQpzOUZ0eTI0QVl0bFhMOXp0Z2YvcUtHZWoyaTB3ZFMrcVRLNjEzSi9mQmR2
ZkdsajZ6Y1E5NDZtNTFha2JXazNyCjdxZjdDOVQ5QkJuMnhENnlwQXdKejlnMThQZDhtRVpaeGdr
d0J1SUVUUlc4WG5NSjNuYWRabmpvaUxBVUZ4UXUKa2pUNXZyLzF1NnI0WVI4YXR5MVVNd0FwNzBH
Z0NQQnU3a0srdFREWEZKUnlDdVh6MWZ2cEJ1NXBQUTFCeHN3ZwpDQW5yU21TWVU5T3lOWEQyOHRw
b0dUYkRGbzhnM2I2RUZybWNTcDRveld1dkhXMmlRSHpaUUczUklWMkN0T0E4CnJVQXRtTW1GVzJX
NzNwMG55NVQ4U3BldVB6UkVRTTB5Qm5GcDZkRT0KPTRXMmMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000028cae70625d9af8f--

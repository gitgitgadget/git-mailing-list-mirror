Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E893B1632DF
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753990815; cv=none; b=XZvwn6Er+8xFJD8r74QFg0Sni7JQX5jQ5lyHxQJO8VQ4Aj30wh30LahdMeYtxcxeEOh4wjsiVdrE+0JtNHqVKT1G6YfKTUbOHjQJIv3bEc9H7dA4A6Z3S4aoOrB23KxbUu7ga5Ft2HjpqEX0G4lS9L2PtFqAimLs9eqPLQP0EKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753990815; c=relaxed/simple;
	bh=eQgpWDmEpLZxH2X9bkXZCTF0Y5z8+F2p7tN1/2xY7bY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ID/0cjY6st3qUhnjHpe1s4jZBQJINyHOnjviPsHFaRodpYNOJdfEVmhxB4vjT8etKdZElWUKctuRssqywnJmfoS/sDFqcX8TFymjI5rA8999DkavZKoJWA2MWI2F3Qpe5qP7liPpuj4jsxzNimomcEWkZT/tircGCnKpAcpxfzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8nuw8tt; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8nuw8tt"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-748e63d4b05so98595b3a.2
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 12:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753990813; x=1754595613; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXk4E7v8CzcyVZERASgrHo6HU7ugX/DrYmvXRKMRP2I=;
        b=a8nuw8ttgfCeVbu1Bx7Pk3fYWaMBYZLy1tGv3fAyRUEYZjDqsGS1MX3pqXQ7Af9NHU
         SrR6G6FfFPSHOW6NN7adXqrMlTkx7xfR4fO58m7mnRT3Cb+DgXLKovWFoS4iMD040Avg
         DF8/hCg1+kzZqK5o3f8CjgE4yZAhIy7AFfGscYo8l1X2R5vga6kBwIXe79dLYIEvotzP
         YN/WBI+wxCi0FVYym5D54zNpTw6R4q+It98FrWVWeo0ZjBoaywcELE5BCuQgocdo2CGT
         zDaHQf0NNfhEKaKdViZ/xsVYLfTNW6MrWLBxxKlbdYdGf2GACvb0dU361MmCpbZwE1Kg
         020w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753990813; x=1754595613;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXk4E7v8CzcyVZERASgrHo6HU7ugX/DrYmvXRKMRP2I=;
        b=c+t2SD6n8WwVN/jODN0A2ZYSJJ1cV2mctq2aPhzbsQI5b2pyMk+1InT32leUSquwug
         HqKwxhmNNyoPclPZTuwvRjrhHP+jVv7m9hL0pDTA3Erbr7s0wq52v83lam72SGwNrZFi
         NitVGYXoLDuOI3eDthuyd+rkl3PPZEPbRNwENXlvxDfras3TF9zvdIQSpvyDQJ5a8Z8E
         fTmee08pw+tE1/K4FHWZLyzpjNdK9SU0KCViliGFQ7tI8GJrudbvlzRCmeRn3b7tWYAM
         clD5PwN1gFa03ZKzJQ9j57wjG8+z/jO8ZegcQr20Kx6zQwWCG94HgRhxP345ekZ+CjAz
         H6PQ==
X-Gm-Message-State: AOJu0YzCrJf8RsQOiu6V4aeG/z8geuQ6GpwrkKVkMTXBmxpydFkyRyyg
	KWsqc37OG47lkAq2XkwGEigngIJCthZH+LxLwOYb+AxZgzyDGAbv0P1BjXGM1w==
X-Gm-Gg: ASbGncuTFDTvIT9VSyESCeYv6NW9VbtO4mWJxovZi/8E1Gkk/WndMJQWluUCzhvTbmb
	PXTuAD4vv8i75/KcoE0JzxaXZqrK+37ELN29b3VxGNhNW+pDdo7VsZWs1zBn6aLrendqoSHejGT
	8+meWbkagKBCXdxCL0sREAhyWrYINhqyHFG0+Qg34zjgI2SCZmzXvyhi/tH1mpF+En/yF+Do6+p
	V9DjgC32V+iU9Yc3HeDyt5DeTQ9d2hQLd48vycLOo4JIijMIfKC5cNJQcrJxa/eKXzw89H5hJUI
	Ix+0Fu7uPQa4pSHYhEm2RQEa5/xfwng5mpN4p0WRT6iT8/MJo+AHDVd1mTJCxDJGMifLlQ7oAhr
	waixVfWJyQp90lDIaLuxfGXvfsCRd8nJ0UIjvQhAgtZZ1LTcadSnNJH0=
X-Google-Smtp-Source: AGHT+IGlq0B3aFaCXakYhISksFjXvlWCGUhsh+vtCiFwIVi/7w439RqniWYF3cTC8szNLBAbxBMPbg==
X-Received: by 2002:a05:6a20:939f:b0:232:6809:d41a with SMTP id adf61e73a8af0-23dc0d457ecmr13586687637.14.1753990813031;
        Thu, 31 Jul 2025 12:40:13 -0700 (PDT)
Received: from smtpclient.apple ([2804:14c:32:8c1d:9856:3844:bdd1:13d4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbce4bsm2247387b3a.77.2025.07.31.12.40.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jul 2025 12:40:12 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [GSoC PATCH v5 2/5] repo: add the field references.format
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CAPig+cTuiUy=+2Jf1Lrp1gaM03_zPf8EFMVSKmShqU05t-3aWQ@mail.gmail.com>
Date: Thu, 31 Jul 2025 16:39:57 -0300
Cc: git@vger.kernel.org,
 oswald.buddenhagen@gmx.de,
 ps@pks.im,
 karthik.188@gmail.com,
 ben.knoble@gmail.com,
 gitster@pobox.com,
 phillip.wood@dunelm.org.uk,
 jltobler@gmail.com,
 jn.avila@free.fr
Content-Transfer-Encoding: 7bit
Message-Id: <ACFA8EB5-2392-45AE-9C18-8AA3D0D4BC02@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250727175110.84770-1-lucasseikioshiro@gmail.com>
 <20250727175110.84770-3-lucasseikioshiro@gmail.com>
 <CAPig+cTuiUy=+2Jf1Lrp1gaM03_zPf8EFMVSKmShqU05t-3aWQ@mail.gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)


> Based upon the implementation, I can see that the user must type the
> key in "dotted" form:
> 
>    git repo info references.format

Agreed, that's an important information that was missing in this
documentation.

> I don't think I would figure it out easily. Perhaps hand-holding the
> user by giving an example would help.

Looks like a good idea. I'll add it in the 4th path of this patchset,
so we'll have an example with more than one field.

> How can we ensure that the lexicographical-order requirement won't
> break?

Good point. We don't ensure it through tests. I plan to add an --all
flag to retrieve all the fields. With that --all flag I can iterate
and check whether the keys are in the correct order.

> Also, this requirement does feel like a premature optimization. Do
> you expect this list to become so huge and the corresponding lookup
> function to be called so frequently that a simple brute-force linear
> search would be too slow?

It won't bebig. My plans for this GSoC is to add the object format
and 9 path-related values, but of course, someone may add more stuff
to this command in the future.

About algorithm complexity, it isn't something that I'm really worried
about, but I also don't want to leave some nested loops with strcmps.
If I'm not mistaken, this is the complexity of the operations here:

- Sorting the requested keys: O(n*s*log(n))
- Searching the keys: O(s*log(m))
- Searching all the requested keys: O(n*s*log(m))
- The current solution: O(n*s*(log(m) + log(n))
- The complexity of brute-forcing would be O(n*m*s)

where:

- n is the number of the requested fields
- m is the number of available fields
- s is the length of the largest requested key

which I don't expect to be too big.

Other thing that I should point here is that I also have plans to
add a feature for requesting the name of a group of keys and then
return all its internal values. For example:

  $ git repo info layout
  layout.bare=true
  layout.shallow=false

Having everything sorted will make this easier.

> I can see from the implementation that you are sorting the incoming
> arguments in order to detect and fold out duplicates.

Yes, that's the main idea. In the previous versions (where we also
had a JSON version), this was done in a more hacky way. Actually,
sorting the values was a suggestion to make it simpler.

> However, that raises a couple questions. First, is it really a good
> idea to do something other than what the user asked for?

In this case, the user isn't asking too much, so we're free here. For
example, in git-rev-parse the data is returned in the correct order.

> Second, if this is a good idea, then should the behavior be documented?

Of course, I'll do that!

>    struct strbuf value = STRBUF_INIT;
>    for (...) {
>        strbuf_reset(&value);
>        ...
>        if (error_condition) {
>            strbuf_release(...);
>            return error(...);
>        }
>       ...
>    }
>    strbuf_release(...);

Much better, thanks!

> Would the user-experience be
> improved by instead continuing the loop even after reporting an error,
> and then adjusting the final `return 0` to conditionally return
> success or error depending upon whether any keys were unrecognized?

It seems ok to me, since we're printing some values even if there is an
invalid key.

> This is talking about null-terminated format, but the implementation
> doesn't seem to emit NUL-terminated output at all.

Oops. I forgot to change it when rebasing...

> In this case, if you call this function with a distinct repository
> name each time, then you don't have to remove the repository at all.
> Moreover, giving each repository a distinct and _meaningful_ name,
> rather than reusing the same name, could also be helpful when
> diagnosing failures.

Nice solution! I'll do that.

> With only two callers, it's not clear at this point whether the
> `test_repo_info` function is providing any added value, especially
> since the additional abstraction increases cognitive load, but perhaps
> later patches in this series add more callers?

Yes. In the next patches of this patchset I'm adding other values (and
there are others that will be added in future patchesets). The tests will
look very similar, only changing the repository creation, the key and
the expected value. Then this will decrease the repetition (and
copy-paste typos).

In the last patch of this series I also add the null-terminated format.
Having two formats doubles the number of tests, and this function will
avoid even more code repetition.


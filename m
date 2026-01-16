Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E4F3939A4
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768583024; cv=none; b=uarhnQT/SwX6NDLGlahFa5OEgxkZvdZKG4G18OxRBGh2PsDzK1ouzB25votAnQYvGLrtuFvvSyhEw0bZpG7fClxyo8i5NmgM25oF8Sv7NIVM7XG007SxtZbM3EAiM8PtK0UFBT/VCwWG01veXNO8CEZ2RXIhiiUGI/QOt6aVCQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768583024; c=relaxed/simple;
	bh=SwxP1nMFjMRFnFnoWNaHOI9hbAng4NUhX3bWhYJrKhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BEyfcvEDUtyuuSzAuVxjOzC1klJChU0Q2y8qs+SmRXqkJWE0dR36n/sZQoX5CcGS8tZPt5HQf0EI7rPSEhhiZzgju0VYCEr3FossU4uwhaqI1TznNJR5l4DChFfeHqTF/eYjo/IMgh7AA58uODXbuiX2i1MIlu3018ebWYBLUlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S15RSIaD; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S15RSIaD"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6481bd173c0so2088717d50.2
        for <git@vger.kernel.org>; Fri, 16 Jan 2026 09:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768583011; x=1769187811; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aT9UnRefdDBfPPUKwthgrNgfCksbGnAuS4XCv1riTyU=;
        b=S15RSIaDCAI0QZLrlv6PdOoWVReu1sdw1/kBukqS4KiFUUcCv7Ye0y6B80BPs7lmNu
         V/NRCq4HzTdZzCy8ARWnBPYdDxX3wu2iHGro189zLd8cZUY75p4mEpVAv0Pl98VdcmTP
         +nv9EU2m3aCJfcsubBUfP88b2Hil22Q/bCYwjV1g0n9mf3DzgtUhzFkeLf7nVVzegHb/
         bP2aOuDh3cpw8oyCTpcdBelurN0KYteZ0BujDWu79n+OyW4tVDS90y+4h6Z7X2ikBW9F
         fz6b1t/bMERe1fjrJeWXAM8lFIbC1oMhmMUc1YeKwfIjfDVYJKbvgWU7EE8p3rbcF0fH
         nHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768583011; x=1769187811;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aT9UnRefdDBfPPUKwthgrNgfCksbGnAuS4XCv1riTyU=;
        b=vazFQgeJeOAzzzNQ2P3Fh++OnJ/VwVoHhnBbMwfUxcR5dv5pF09fJfjmPF/3owVyqo
         36bN0/epWsCUO8FnYJ6EyB+j5JOuEp6A0NcapWgffuXnnYiiv6AHnbl/Jr3yXVRv8kaR
         a23kPbk+NVxScLjozIeMVVCA+85k1pPGdBF1KyrVS58xDImKqddGWjr6u8+yZhNnCwES
         OUMtxxc5KymP1ldiFD1B8Mmmhj/vEsV6Te4P+uJ/+Y7ZPEsP7qjE8pNmpxRASLzOwWUv
         6gBqCM/74pnpjKfnUn70rPiWNcS9o1JbwHnavH4sTgnNX8DofFotUDtX1bZE9Bs52mjW
         YwwQ==
X-Gm-Message-State: AOJu0Ywf9+Iaw56iAofx4FSiiaY4yaxEHZyRVQCS7Ojd2R5+nqhhS35K
	eAt0EDt5J5l5pba7J2lUhpmbNftCAv07FpZcfs9MjSf+pCiSKlW6/PAmY8JF2LJdeKAqBUG2V4X
	Yz065tpiM9JapCvP7QtsZ/0s9FgmSDfI=
X-Gm-Gg: AY/fxX5Zqk8Bu+899AqZZa0miaxG1unCComInOwiTZm/EnkZDGrCPBqIUIf/Y4eRu0Z
	9DfG3/XfrsDtOS2YY78Lfzm0Hg6bJVORdAv0HosGyfCPgEudevQw6XJOn1UXXLkgACoetkylPe7
	6vcFe4j8SBEEnI5sbYVYpJ2QQbbzUszBNHNQ2NhginJ3X4KTamwGj35u2ujLoO/2xfhy6rer6Gs
	y4Wal5i4KJ4wROhPxaipVbyPaZnHKd2D6ju+DHLZfjs+8CuJmPGg72AalcM3e/49sLSqMQbUECS
	6SlQagwr2bDdSN4CJfi9e/Le+6fWaDTPoEr4h0A=
X-Received: by 2002:a05:690e:11ce:b0:649:3e9:ceeb with SMTP id
 956f58d0204a3-64917704b38mr2363956d50.23.1768583010692; Fri, 16 Jan 2026
 09:03:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114192803.4852-1-amishhhaaaa@gmail.com> <20260115130935.93526-1-amishhhaaaa@gmail.com>
 <CAPvEtreX9sGHUn7+Y0kLo_VnK7Y=OYLq-kz-+np3bu1QtoEpnA@mail.gmail.com> <20260115200903.GB1053259@coredump.intra.peff.net>
In-Reply-To: <20260115200903.GB1053259@coredump.intra.peff.net>
From: Amisha Chhajed <amishhhaaaa@gmail.com>
Date: Fri, 16 Jan 2026 22:33:18 +0530
X-Gm-Features: AZwV_Qij0Nl-xZzHRxUA31m2s_K38_GxDJmzVsiiWh3yZh7mOasPxp6oRFQs22M
Message-ID: <CAPvEtrc4KuQhNhc966=bbMQUZw1Ne1eoG68mVoZiG6A3h4t=GQ@mail.gmail.com>
Subject: Re: [PATCH v3] sparse-checkout: optimize string_list construction
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com, newren@gmail.com
Content-Type: text/plain; charset="UTF-8"

I was able to reproduce this, are we open to a patch adding a test
that checks if duplicate entries are present in stdin the result
should not have it? because the tests were passing even after removing
all duplicates checks, and non duplicates enforcement is a part of the
method's behaviour, if I am understanding correctly.

On Fri, 16 Jan 2026 at 01:39, Jeff King <peff@peff.net> wrote:
>
> On Thu, Jan 15, 2026 at 06:45:35PM +0530, Amisha Chhajed wrote:
>
> > I was also very curious about the presence of
> > string_list_remove_duplicates in the original code, from my
> > understanding string_list_insert already removed duplicates and
> > string_list_remove_duplicates was still present with it.
>
> Yes, I don't think you could have duplicates when inserting with
> string_list_insert(). Of course your patch removes that, which means
> we're falling back on the notion that the hashmap cannot have
> duplicates, either.
>
> I think our hashmap _does_ allow duplicate entries, though. The
> insertion code in insert_recursive_pattern() avoids duplicates in
> parent_hashmap, but adds its arguments directly to recursive_hashmap.
>
> So I think you could get duplicates with something like:
>
>   git init
>   git sparse-checkout set --cone
>   git sparse-checkout add --stdin <<\EOF
>   foo
>   bar
>   foo
>   EOF
>
> Before your patch, that produces this .git/info/sparse-checkout file:
>
>   /*
>   !/*/
>   /bar/
>   /foo/
>
> and after we get:
>
>   /*
>   !/*/
>   /bar/
>   /foo/
>   /foo/
>
> So I think we do want to retain the duplicate suppression. Switching
> from insert() to append() is still good, as long as we keep the
> remove_duplicates() lines.
>
> -Peff

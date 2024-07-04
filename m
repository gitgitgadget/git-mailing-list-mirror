Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4134C83
	for <git@vger.kernel.org>; Thu,  4 Jul 2024 01:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720056348; cv=none; b=PWwJ+hW9jhqs2RdP9q71xpW7F6e7/+KGLgtsDn37AbJe9p6hgfTtCV5NDiGH0pfKBD6yBtGrBmR23jA7PGujOe19sgEzLehU4gmcSVLvdSm905ag3R2Q1d1ve9wfzR0H+v+GrUHN/petGj1rEzdD7AYl4eABWW5VQyI1WSQ6aLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720056348; c=relaxed/simple;
	bh=Kjk0UGO5eWp01ygRcpjN71RxV8ylBN1ytNy6I2FMM90=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kCed2vxToSMfdYAVgCjRe7qT8QGRSg1rK1cNcDtTw8tBrEdUljF8ku2csgVmsYTXDkXh5eOwGTxw3GrnmHO9N3vnF0h1Tfb1k7NOqA0OcNOpoAJBQRU2DQn4pUUSPmXwdFOu8YvimaNuwrcWX0zVeFY2r0l4UMUrZR7vLbXWHUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1c6G/zu; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1c6G/zu"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2c96f037145so131080a91.3
        for <git@vger.kernel.org>; Wed, 03 Jul 2024 18:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720056345; x=1720661145; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QzBm9jdKwX49ts115rci9cPpaH0aNl4s1+N9COsvuSw=;
        b=i1c6G/zut70zadI6aME8yWzdyC9FXR9O/sKqLZx2u05Xn+8o9muhFLJnu6qCFYqM8a
         EzHq38fIUeQHIeONLsSD4Ph4JeY/GTupsInMBVQ7vZeUqxgALc+Q8AGk7yKevoiCSQEm
         a3uT6yagIRMXvJUe7R2rrD/n82/X1TWJzgsXY+zhK2FWlY7Ebef+BJCiHAkX3IGSYj3B
         H+aB3lzUsIrnPE88mAYsQtZ8eme1ibKSg+sDGjOIIas2cxbn65zB5LmIJO06Pq9QXiYR
         FVyV72fYyMQjSq1/XGqwRkiztaGL3HF6Jp5f0r8j/g1RLt3Ia7+psjmVxyZhVXmpLbwy
         D7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720056345; x=1720661145;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QzBm9jdKwX49ts115rci9cPpaH0aNl4s1+N9COsvuSw=;
        b=Dgy8pRQ+uw0FCrnEaQhjKNJOiFx5wKmOqeiGwvVdxpsKd/zY3NV6KS18WDq9jFYNxk
         zzWRcxDXCbisrik0tt83G3zDvUAwAaNl6nuF1QqG7+DSze5V5F2/hzdJw0m1rnB/7XIm
         dioKclpY5HmokkzFvQN+J12GLRNjM9/3tENXZZ+Dhzm38DgT/Wel/ArVnkK3R8V02rsH
         93GOdB0/5vlDuT1e5GtHg5ZCRnkBSBKG0YYGVMwhGETlxOUOP+PE7Q7j+Ns0W+MaA86M
         Gx91fBE7VTmUNMnoJ1PTN5OBMVqkTADLT/2o0dM4Y7fu3SKElGolLf4yaiJFWMLwJuPd
         YKWg==
X-Gm-Message-State: AOJu0Yw9dm+2PjMEfObCnGXxHtPgdCQAmPz19WoIxk0SQCTh06ZpToex
	z2W0WH5QQvfgySIhcOa2IGRdWK6EFzcylS3GoMJoaTcgp0z222nl
X-Google-Smtp-Source: AGHT+IF4ggG2gYVmsEiUzGM+LQZURpfHVrjE+qyqwals5AJGl8B2kupFJ+XCNabZ2wdt1H1o+1upkQ==
X-Received: by 2002:a17:90b:344b:b0:2c9:964a:95cb with SMTP id 98e67ed59e1d1-2c99c6c6a85mr147021a91.40.1720056345050;
        Wed, 03 Jul 2024 18:25:45 -0700 (PDT)
Received: from localhost (236.219.125.34.bc.googleusercontent.com. [34.125.219.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99aab8e04sm182498a91.56.2024.07.03.18.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 18:25:44 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Eric Sunshine <sunshine@sunshineco.com>,
  Derrick Stolee <stolee@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/4] Additional FAQ entries
In-Reply-To: <20240704003818.750223-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 4 Jul 2024 00:38:14 +0000")
References: <20240704003818.750223-1-sandals@crustytoothpaste.net>
Date: Wed, 03 Jul 2024 18:25:43 -0700
Message-ID: <xmqqh6d69cdk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> This series introduces some additional Git FAQ entries on various
> topics.  They are all things I've seen in my professional life or on
> Stack Overflow, so I've written documentation.

Just to help other readers:

 v1
 https://lore.kernel.org/git/20211020010624.675562-1-sandals@crustytoothpaste.net/

 v2
 https://lore.kernel.org/git/20211107225525.431138-1-sandals@crustytoothpaste.net/

are where the previous discussions are found.

> There were some suggestions in the past that the text "modify, tamper
> with, or buffer" might be somewhat redundant, but I've chosen to keep
> the text as it is to avoid arguments like, "Well, buffering the entire
> request or response isn't really modifying it, so Git should just work
> in that situation," when we already know that doesn't work.
>
> Changes from v2 (partial):
> * Add documentation on proxies to the configuration documentation as
>   well.
> * Mention some security problems that are known to occur with TLS MITM
>   proxies.  This mirrors the similar Git LFS documentation.
> * Provide a documentation example about how to use proxies with SSH.
> * Recommend running a `git fsck` after syncing with rsync.
>
> Changes from v1:
> * Drop the monorepo patch for now; I want to revise it further.
> * Reorder the working tree patch to place more warnings up front.
> * Mention core.gitproxy and socat.
> * Rephrase text in the EOL entry to read correctly and be easier to
>   understand.
> * Improve the commit message for the working tree FAQ entry to make it
>   clearer that users wish to transfer uncommitted changes.
>
> brian m. carlson (4):
>   gitfaq: add documentation on proxies
>   gitfaq: give advice on using eol attribute in gitattributes
>   gitfaq: add entry about syncing working trees
>   doc: mention that proxies must be completely transparent
>
>  Documentation/config/http.txt |   5 ++
>  Documentation/gitfaq.txt      | 105 ++++++++++++++++++++++++++++++++--
>  2 files changed, 104 insertions(+), 6 deletions(-)

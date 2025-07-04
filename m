Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA40723A58E
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 12:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751630981; cv=none; b=qYQ521rFl890ASlY+sDPwrT4GUvGDYh5bebkJOGi9hERu8z/Tz9SzV9LeXc0GLG69GtA4uHrJlLZfNcs7bnHmH2Djzobht2CLqAeJZ0Pj3LC26WzFXl/wKJ9/uFdqAt4v7DDoGRh3zGNnBe05obbh4TWB47HxhiCNBjyWIIxDd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751630981; c=relaxed/simple;
	bh=tF8TEXVxJo9fHViccnk+ArgDRpIXjZoGgnSZsO/xUY4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TFZC5gQfcvGI9f/H0R28tWykoGDpT+KGQ9ShMqA9r1w8oxSMUnlgvxhjPZj0SyozyiwTw1ja1QfDAEBkQIZb9kzCYKubxyAgGXqJ5YF8TyZ8ZxZoBSj4DlkcFVNUPhdBmyhIsD9KDuQDTyv6zWAF5kEpAnp95/yxP+Zqy7RWrrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COLD7G1j; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COLD7G1j"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-235ef62066eso14079275ad.3
        for <git@vger.kernel.org>; Fri, 04 Jul 2025 05:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751630977; x=1752235777; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhJKb7hAG68v+Ce3CFT7bOVJ83dpmj1X3j/NwSdTYvw=;
        b=COLD7G1jH/2YwFHZtAGH3kMp5tG7CoLt44xrbKtI7gc+15f4bAO/2PnDgmEeGZkWEM
         FwAsw/XLIxzj3ihtEdYMGti9Bf0LYI/NbKCUpW0aQRwpOFtg6QAA8RgCBoJMVSNKr4wx
         7nHjeGbobFAPD4+fk+f6O2e2uLd9BWxEWTnVQDqt61xGC23xkX0k3KB5Gmw2c0ja/Kfg
         RIPuDZ/lh0Zk1hScvBddqUPnypTeopaNg3dA1e9qcI9EL5InrXScmyh/U+QwT5d+Ek7+
         VMdfOPRWyPedOH8piGP1CWR1aKN1HlgrFe9wJ1X9vY7FisE53njOn8MU25UFNIC+7rrT
         RLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751630977; x=1752235777;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhJKb7hAG68v+Ce3CFT7bOVJ83dpmj1X3j/NwSdTYvw=;
        b=qICvVT8LtD9k3wM4h9ALxue+bNYGkjMd2bz44PCYE2iC/zdAEdl0oXJqGePrZWwXEr
         4jo30uG+VKSet/LB4ttirWobVu/4JDyMaJRNQJAuwXzS5ksmmQUn9E9W4MYK2GyMobAK
         nZyzsvIZfy0Toqu9QKDl/rjoeSZtZXD5+q0ab/vQ1+l0LOCDy19xJRDdNCJ3Z0QXETCq
         S44NmRa2UqlmAmJnxtlJdj8HlR+07NrVUnCF+/gkN5RVRYk1EqgyhVBiuXO+Ha3k4yxY
         yiU49yT8UxWm4B37k4lncRm9bJhgUe7f6YXrZgGYdVx2bW6oOCr3cc0buuv4hWfOdgqt
         snXw==
X-Gm-Message-State: AOJu0YyUJj+O0rObqGl88qPbOyNat4Hmc2cfTCwteIOqjkN8Yb2mUZPE
	uraJsImCa7+2cNwxHcIClUgj++i8cljPyPQuM9QbR6StxvYGc1N7Dan/TfYDjYCKDpQ=
X-Gm-Gg: ASbGncscX7hgrYhpOJz848UgIbiHh2lIwWqQ+beuk5FV+lCKWAoADxLjp3tVRIf+Tzo
	hsFJxcTdMo0QpK+KDWkT3C65t1aNKU5tOOw5iEbixC/QPFoAFQVYMlfHPWOm19z02jxWznbUnW3
	dGYF9x/GtDAtAZkpZTRANdRKSdCyYhJJSfB1tiTqBAwqJ8d0MY7QfMmxQM7nDApnsBjIIuUniTp
	sAolNlRSFaZNmTJGx0+vIk9h2QXZ6lirla70onWIiqcI/TdbWkYfXNznBLS3qlmwKldK0hf820O
	dbxQM02q2o4omwR1J3m4A5W0ENV3o2xMdvOUo74Z4zE+6G2R+p4JCnwY974IxRZ2IXZaVjqO6/2
	H2L6fRTlxOKi74kBQdZrgc78fgKW16KYrcCmYuA7+fC4MXiWCwyidlcuwxy3aHg==
X-Google-Smtp-Source: AGHT+IETl7+dCBEevbJHAzDo7m2Hq/EgxNYD5EgzANzK0SmSVHXlP/mzVhpxpfjaDFyk/blVHCifUA==
X-Received: by 2002:a17:902:d2cd:b0:235:f459:69c7 with SMTP id d9443c01a7336-23c862375e1mr40617485ad.52.1751630976748;
        Fri, 04 Jul 2025 05:09:36 -0700 (PDT)
Received: from smtpclient.apple (awork062012.netvigator.com. [203.198.28.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c845be91esm18408525ad.250.2025.07.04.05.09.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jul 2025 05:09:36 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH 2/2] bloom: enable multiple pathspec bloom keys
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <xmqq1pqyfvb2.fsf@gitster.g>
Date: Fri, 4 Jul 2025 20:09:23 +0800
Cc: git@vger.kernel.org,
 =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1BD174FD-887A-4002-955C-A67E7DBFEFCA@gmail.com>
References: <20250625125541.3048632-1-502024330056@smail.nju.edu.cn>
 <20250625125541.3048632-3-502024330056@smail.nju.edu.cn>
 <xmqqy0td8fa9.fsf@gitster.g> <C8E0D62E-11B1-4921-AD4C-2905F10E07B6@gmail.com>
 <xmqqo6u4kkg0.fsf@gitster.g> <D5CB9B7A-C7B2-4F5A-B358-8F46A4E18CDB@gmail.com>
 <xmqq1pqyfvb2.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Junio C Hamano <gitster@pobox.com> writes:
>=20
> Before concluding so, we may want to double check how Bloom filters
> are built on case insensitive systems, though.  If we normalize the
> string by downcasing before murmuring the string, the resulting
> Bloom filter may have more false positives for those who want to
> (ab)use it to optimize case sensitive queries (without affecting
> correctness), but case insensitive queries would be helped.  I do
> not think we support (or want to support) a repository that spans
> across two filesystems with different case sensitivity, so those who
> worked on our changed-path Bloom filter subsystem may have already
> placed such an optimization, based on the case sensitivity recorded
> in the repository (core.ignorecase).

In bloom.c:get_or_compute_bloom_filter(), the computation of a bloom =
filter
looks like:
    diff_tree_oid(c=E2=80=99s parent or NULL, &c->object.oid, "", =
&diffopt);
    diffcore_std(&diffopt);
    struct hashmap path_hashmap;

    for (path : diff_queue_diff) {
        Add all parts of path to path_hashmap;
    }

    for_each(path_hashmap) {
        Add path to filter
    }

All these steps do not check config.ignoreCase, so I believe the Bloom =
filter we
build in the commit graph is case-sensitive.

To demonstrate this assumption=E2=80=94and since I happen to be a Mac =
user (where
config.ignoreCase is true by default)=E2=80=94I ran the following =
commands under the
llvm-project repository:

$ git commit-graph write --split --reachable --changed-paths
$ time git log -5 -t -- README.md > /dev/null
real	0m0.089s
user	0m0.067s
sys	0m0.021s
$ time git log -5 -t -- ':(icase)README.md' > /dev/null
real	0m0.281s
user	0m0.239s
sys	0m0.041s
$ time git log -5 -t -- =E2=80=98rEADME.md=E2=80=99 > /dev/null
real	0m0.458s
user	0m0.394s
sys	0m0.061s

And I think it proves that changed-path Bloom filter doesn=E2=80=99t =
optimize icase
pathspec item in case insensitive file system.=

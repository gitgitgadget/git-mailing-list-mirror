Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6415E6136
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 03:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750734986; cv=none; b=gHyOhPcDbOcVd8D1Y6G4HWeLFReWWYK9TXS33HP6DHVtJAKuRtRi4txZvQgM7D147zi7hCVDLktZvfcpesyuviXDkA3cYH6nOp9SbHksgBq06zOcfMmpZWn3VsSLOAuj94PYgkbVMi9HEu1tp6D3r7omIrv0x3IhJcrHCICyvGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750734986; c=relaxed/simple;
	bh=cfLvSBum0Jat514l6cR0ZonpL6Gc6TivTOCtlySESu0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kviPM/Kc/bTJjGtj6x1qnIWhcJvcB1Li5FNl2RF8XzCa+xVmpBn+yvmv89POPoDb0RB7nVh7hrYIPt4RgWFCZ/kwqbNzD/HEWEAmLVfMY1fpHif//1Yi54uI2kLpnTkUtft0iygMHuMq7W6FB5VbfgfwnuKSYbPHk1Bm1E9aQxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BabJmkik; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BabJmkik"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2350fc2591dso41897425ad.1
        for <git@vger.kernel.org>; Mon, 23 Jun 2025 20:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750734985; x=1751339785; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLoyp+7FgQhVsYtUUJY9jrU0JXGOybp6QHv5oQ5Myb4=;
        b=BabJmkikmNX9TXsPwjXkEKeqzMpqR4TOWkPobAm4Yvll+vfgyqE06869dJ0pOq5Ecn
         iehOfB3sleqg6tYmxUfAQHQuc8OHwKuxIT1m4JLbLB9aji7PllwyrwXPjHfygiozQMaa
         RIrO9Y6dGoHyGBLyzvccPNhGOJmIr58B9YbPUHxYPG0TBWQlmM5ZxEF/3pfzbXrU3ze2
         YnLZcbayHdyEt8BOIftMxKFzLikSkKOHLGohrVxOILp3okgz4BvPX8rzZzS0uU+Eptmv
         8SoraP1ySgsRcHXmvzecdKT3EThznpP2lNxCstDAry2qJczM9wZIhMeBkJAur8mn+F5H
         fLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750734985; x=1751339785;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLoyp+7FgQhVsYtUUJY9jrU0JXGOybp6QHv5oQ5Myb4=;
        b=wPowq3lSdNPTtKKjY6GajvRTzhoLGCQqWXHyeUKoEOzEYxVfoNeAZXVfG9P/QeDKVi
         YZcevwYXUj/Pc+ZKJmKqdxOnDpDSnkr8WgbUoY+jZKtqkXGyE/ON8YtGHGiyqP/aTiEi
         gx1/B3xYtamyZTykNopB0mPi9/iC0msRCk+zXHDAkr99PIkkxaGVlhT+y7E5obtBEQVB
         8jk9NRMyi2ACFSfPcgByw2nccOAaAGuJBUQXM/+Mo0tkG8BRyWMar2KAiSpP3lixV8xv
         GSOCyc3xGvO1y8fTLgz0s8skmw3E28Yj5sZ1FbFY/9fyQ1Ic2YseX/q1MGVgR9o6KzIr
         BCKw==
X-Forwarded-Encrypted: i=1; AJvYcCWOzAstgMbI8Zu5JcmC/aSJtmhJkpk8G+pHI14fVNe5jCDg9gzxT5vOpCb5ZfhpUpvnoXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYHbBs92sYFwPO8gCEyIxusPDsx6AsA+pawaMuM68JHYAVOvv/
	xyuvAnx+g+sHSZ0Fex0bvXPgS/W6Aid4wkVIJqEQ07Kniu2Fd3LUHhvt
X-Gm-Gg: ASbGncu1tFT6CUJFjERFoWtqqR3SakYn20i1KMSoJrnvg4KpigNxpKv2zPLGR70kwM9
	usUAzZgejeEgMRQAhC80CoAEju4JMqOIeoPK4XIdyVlP9iciq0xVKk/rmHJmO1C/Zz6M0oXZcLu
	Z1hax3loOM/z+8axEwl/E3R2okMLy/1jq6Ey7hLhH5Vk1vQ6ihjX7VEfyEqvJbWGI41GNEIcbC5
	xTRLGhB+r+sp1Lv7sUU+4AlWmsPFbHxAY8yw8mK62jGrj10lm8FA57edHNU0RK9OwMdcTtSojTt
	lJzjr2ECjct95OJRWflthlT+rIAqkM37rumHPgQCHHRKUMmGb9Z2NuL3kqTtG/n8diMgJixwJ4L
	yjcK317eF1aVxuhZMsUvDrxbHLAbqcByHhFfuCbEbGWeEzh6RdyACamLlRjc1Cyc=
X-Google-Smtp-Source: AGHT+IHZKnrUScaa8mNzalwfBwUBSld2WVNIGpCGi3aInBjYUtypuzvyYMDsmjOWV3zTNtoI3My6Bg==
X-Received: by 2002:a17:902:d50d:b0:215:58be:3349 with SMTP id d9443c01a7336-23802481315mr27878975ad.14.1750734984468;
        Mon, 23 Jun 2025 20:16:24 -0700 (PDT)
Received: from smtpclient.apple (awork062145.netvigator.com. [203.198.28.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d86895afsm94748385ad.183.2025.06.23.20.16.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jun 2025 20:16:24 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: Perf bug: rev-list w/ 2+ paths relatively slow with commit-graph
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <xmqq34bq5g29.fsf@gitster.g>
Date: Tue, 24 Jun 2025 11:16:09 +0800
Cc: Kai Koponen <kaikoponen@google.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E6A4C972-9675-47AE-B5CE-75103DB1D153@gmail.com>
References: <CADYQcGqaMC=4jgbmnF9Q11oC11jfrqyvH8EuiRRHytpMXd4wYA@mail.gmail.com>
 <xmqq8qli5jyi.fsf@gitster.g>
 <CADYQcGrR0mKLEWSYZCrL6b7NYLGfdsZsuKCCFQ_ptpMJ8mofmQ@mail.gmail.com>
 <xmqq34bq5g29.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Junio C Hamano <gitster@pobox.com> writes=EF=BC=9A
>=20
> Kai Koponen <kaikoponen@google.com> writes:
>=20
>> I see, more of a perf FR than a bug then.
>> I don't have much expertise here, but on the surface of it, it =
doesn't
>> seem to me like there would be any reason the algorithm couldn't =
check
>> each path's bloom filter in turn while searching, other than that =
this
>> would be a large and annoying change.
>=20
> It looks like that the necessary changes are probably fairly well
> isolated to two functions, i.e., prepare_to_use_bloom_filter() and
> forbid_bloom_filters().  Right now, for a pathspec that has one
> element "dir/file", the code uses two bloom keys for "dir" and
> "dir/file", but if we have "dir1/file1" as well, then it does look
> like a matter of using two more (and the bloom_keys[] array is
> designed to be variable length).

I believe the issue here is that revs->bloom_keys[] represents an
AND condition, whereas what we actually want is an OR. In Kai=E2=80=99s =
example,
we=E2=80=99re trying to identify commits that modified either =
src/Make.dist or
src/clean.bash. However, by adding src, Make.dist, and clean.bash to the
bloom_keys, we end up filtering for commits that modified all of these, =
rather
than any of them.

> But those who have more intimate knowledge in the area than I do may
> point out what is missing in my "it looks like" gut feeling.
>=20


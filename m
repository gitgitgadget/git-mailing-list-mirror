Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C4816D9AD
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 09:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723453954; cv=none; b=dz41KAkPGZJTR9jiBDGHQy5TbIL3aqTyzXAbt7PQYTHDqHG5dhKFFOnC4I+7r6MOLu3UpwEcx8ebrdxVqP2flXNg/gnpBNIBghbQSwo6qbIEvOd21UzGySBgWbv+5RnO+Cgv2LP6rLjf79GOUurJd54cQ/GVZ6BeMgsNa8KIFLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723453954; c=relaxed/simple;
	bh=pbazfU38MWhB6KIBcYasKuX9GUTwvKtPXxTX8Noa+NE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dKo7xTDrVRj811YN+Uc/fgWS9AfUB9/jSYLswIi+Ya1xUvqwzMFe3L9FE4YGdE+XNomoAq0GDDhXY0PBz6hHpI3ZNtOa42McRy2l1af2gPIM7FmMfMURybFJokOsYzP7EDdVB2BIFAz4EnCl4MdbyGGT4l/CCdwWHpUgoEqXNXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVqIeH8V; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVqIeH8V"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5d5b1e33fa8so2394727eaf.3
        for <git@vger.kernel.org>; Mon, 12 Aug 2024 02:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723453951; x=1724058751; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pbazfU38MWhB6KIBcYasKuX9GUTwvKtPXxTX8Noa+NE=;
        b=HVqIeH8VJxOBh3Gh+kTmVyTVHZ/5r4Ft705juIOcS79+01RJQbJZbBSHEwOiEyejZ7
         Yc9oQobuMarVde8WEDe6uWpJFvdnIomP73xoWNvmQ/rkvmfH1xKIsVONwjO7MtqSmC5f
         IJZfhIT8C9fFJOIDSfl5BLtXat6P7+wDnl+wR5887MSgk/CNPqnwmTfJiNRvBtdJncPQ
         ceOppLU4hhxIkhJIEh51CWuTWbhlfPWekRWYhkrlZq0tdaO40eSjBckEn6RvoAbgzW85
         MCs9MqNXW4kPlw0BylAhoVgMMYP1szMzhXYJmKDX5xSgPkfaWJjGPYwgeyL6fg5w9lsU
         BnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723453951; x=1724058751;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pbazfU38MWhB6KIBcYasKuX9GUTwvKtPXxTX8Noa+NE=;
        b=NJ6IxBeWaOVcN5f9tp1T4lqB4phvAWXBdWUqGChw5/zYq/fN9Oct/IeWFxelo/PeOB
         HLOBfRkj8oQWpFNrXYp4cNSng0JPRvYgKcc2P0lNE5c9nWwlOj3Wnzw2Yqj0qkpj+8j9
         tR2LN0wJB1fgjtKDViKasAUHt8jKlCHFrDtXiAaTS2EgXBC3Po9Wg6mAMchDRLTWLghp
         azM+3vBlJA/pZ0Aldzqu95yAi6cx/v1/YHZUMl2ipojXKQjVZvn8ZBUiEjhR+mXP4isy
         l9t05Jme2ZHmnbS8rS3fcBCGKEemrtk5qRh8ODH+8Xn5P9OGKgtZt56lPHcaw3H3gzic
         6Atw==
X-Forwarded-Encrypted: i=1; AJvYcCVeH/cEV+VYmgZG5KJU0AF6u4hFSNLd+C3rRbDejMd5kPjicbJFTY5y422fA47wtKOFKn11bKy4VcwjWNSeTUAT8rJK
X-Gm-Message-State: AOJu0YzEGqEC/wWvOeQqkDeCoGWBojh1vIy780fAl62VjIoOaII9nMA5
	vkSdIYLFIYpvsptRUJxKx3zLi8c/diNF53t/2oEC0fKjqwXjPHtEatP56YkDViipjGj4f7R+zvH
	Dusiiys9JLzbUO2lEgsW+nKJVQ8yytQ==
X-Google-Smtp-Source: AGHT+IGu43NtAW+QpvIu4j4jqvrKfduHKs8mG30GDu1x7MoMylbrAgKJAUzdfKMBtQMOHgPMh+buL4S1bW6gkh+TR/0=
X-Received: by 2002:a05:6820:16aa:b0:5d6:1082:4f4d with SMTP id
 006d021491bc7-5d86d97d613mr10571325eaf.4.1723453951067; Mon, 12 Aug 2024
 02:12:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Aug 2024 04:12:30 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <343ddcd17b3e13dc7b8ab89f9c9c427bb2ed101c.1723121979.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im> <cover.1723121979.git.ps@pks.im> <343ddcd17b3e13dc7b8ab89f9c9c427bb2ed101c.1723121979.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 12 Aug 2024 04:12:30 -0500
Message-ID: <CAOLa=ZSjBxVxmr7xiOFk0+2N4sTuxq9pFZt4ytK=L9kyw=Zvig@mail.gmail.com>
Subject: Re: [PATCH v2 22/22] builtin/diff: free symmetric diff members
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000008a7b2b061f78e423"

--0000000000008a7b2b061f78e423
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> We populate a `struct symdiff` in case the user has requested a
> symmetric diff. Part of this is to populate a `skip` bitmap that
> indicates whihc commits shall be ignored in the diff. But while this

s/whihc/which

> bitmap is dynamically allocated, we never free it.
>
> Fix this by introducing and calling a new `symdiff_release()` function
> that does this for us.
>

[snip]

--0000000000008a7b2b061f78e423
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7f5aba701957829c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hNTBmd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mODIxQy93SWFWK0REZU8zemFnSXdyVDRsVVBpS3NYTworc05taHQ3YVpr
RTFrSFJFU0RPZFhhUWxnRVVBamQ0UFpNR25EZXB1Wi9CSmhGMklOZDRlOXhJd3lqYi9Fbk9HCnJ2
WFl3VEk2TzFZL3laRkwxdWprUkxiazZ6NDVUd0U4dGgreDc5OVFsSjdZWFp3VVFWbUFNT3NOWE1m
RkFzZnYKd1VkeWxCNFFDZ3EzaGV3SXQzZVprU0hsUDBadFMvTWVLZkRPUU9XV015dlJ0RjRaU3Va
S0NJaHV4cytybmdPYwpVdUxUcG42QzBjRjFOMHhVYkJZTTBTd0p1cVdPcUVsaEJ6RjZ4WC9CTXRx
SUE0ZFR4LzFraXFsaGtET2phZjhqCmEvdDAzNEw5c2w5bmlKTXdJMEExZEc3TUZrdDRGVDBvSk90
NW5laWMxanl3V29vSUZFU1YySWs2UjlQUThyOEcKb0hQOGgrMTQ0MmR2SlBILzNocGxmYldBMi9z
N0EzU0lKbHlKaDBId1cwK2JldC8xS1lSbEttWUhBZDUvRzh0WQp1NXpjOEVJTkFwQjFPaWk0SUZE
VzBTa3BDWGxDUmZOaE5qQUQ1aDlVRnZVZWVtT1M0MXZpZllVTWYzbFVKeFJRCnI4bE5hUEdHMkEz
alUyYUtQajFhdFBHWW5US1pscElxR3hnai83UT0KPVhCaVQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008a7b2b061f78e423--

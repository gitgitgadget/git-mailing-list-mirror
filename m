Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28352FE591
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 10:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764586426; cv=none; b=l/Pekc+0ZKKx7ECjqMJ+uzRc6MfugC35+lrsyE4Hnunz9dQ2flQsyV0FgcMcaUegjbdLAWXcv5jZm9arBSbKemBwCjf5MRR1JtIGuVU5MZSr1UqPLm4Lv9oDh1MsjQodmpevnOmxYM3XNWwJvaNWExkTPJ0MczIi4H3v/o1XRVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764586426; c=relaxed/simple;
	bh=//ke/IT6pro+m4coH8QJFFDAajYUNLoW8bQXX1otcr0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=X2XAxsRuOPJX9hFX+Ed1saIGclDCyWdbNxvjKTkrnFQ4T6og2zH98ZwvMMr/bUFs4yzEftguQRVNcL8KDEt+vcJltV3Mvw/8aa5iQD0I9s/RHqvCM5Td34wgXdW8WSRsvzvCfglcwvxbH0v5vsQHqa0S+Fdz7U/5dNrnkAIw+Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgZBGTcv; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgZBGTcv"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5dbd8bb36fcso3495223137.1
        for <git@vger.kernel.org>; Mon, 01 Dec 2025 02:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764586424; x=1765191224; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0KLxBC5RvuaJQ8/Qe2duZQYDJFhgfwDZ2eSzwZNmvTM=;
        b=CgZBGTcvfbRcCEVyc/fSv9BaZdGVrlmUyoHW2ettCvdxrpUeeOIPOqVE4Y3QKddNgl
         6hQjggU+AEqUpEReFqbB54ec1YOwvFOT+L2hVBfprke6EgLg4gCgeOv8XYbx2A64UL4d
         KQA+M+R788jQM9YhKmAKSZouOH0dQXwrEVN8FT2eJ93+ziFU+OjAlJ0xDZ/2b64vZR6k
         TVOTG7E5tUPed84WP8xiOC/snHP7Wvxp9GARebszvBvMKPErFgKE6+lLDOcWZuY2F2iQ
         ldLaHvB0R0It9q3g5ioszUCLKwLJcvXjavWfBgcnvcG0ihmTgA8aSkJjCTzdfeTf5R2l
         Xmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764586424; x=1765191224;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0KLxBC5RvuaJQ8/Qe2duZQYDJFhgfwDZ2eSzwZNmvTM=;
        b=xQWrGQpyW9K2UYxg0H5do4Ty5PCx+JZiKYr3ppXupp8DXAb1AIXNNoy2DArWw7ZBi5
         Xh+nUBzbmpum03gFVmtcnq6W1QQ9pNhagQd2IxdVksCVrPbjeb3lu4aGbJo6qKDlt6d5
         AYSxEO0JtGyrxDmuqal9khypTWP0xOOK8qXjgVTnSCUfs5Xjxjdi+tDiPu2TsEAbLxAt
         4Ym4gEKyrFeFXylFAOqB6u9rZfFgxG76KcFCJql9445qP2lzRmgHF7lW27ff6Llu567V
         wtC7Jx3lrSU5RZI1InoL6/t4gRFrMTlIjBLcW8/cKog71qvZlwF9A6ExyRDCiMocIDAp
         eQbw==
X-Forwarded-Encrypted: i=1; AJvYcCUjZxANfPvN5KhLwlP7vLxrLCG8Yw/gWgScDRXseftAqubL3OmQgxtnXbF8f0F6PScAZu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZvNa6IWMCJHe14TcFAAuFfJ9+L6osR0wK5rRhD03psO6pp545
	EsURuQ828IK5GPA3sTLdMoreqjQz7DrXNTDAjjeo5b0xVRHk6tClG31CMjWgFeVH3MaPfo4QFCT
	NIWIDUxipbk8gsSnzvzXwIf/28hg9A6Q=
X-Gm-Gg: ASbGncvTqVYj5vAKlv68b06SBXBfDE2EdF7hBM7WtaJrNrf8FI86B067aCM/3wECAkU
	yxtb/F26rFPdsMR2cCwv+NxP9MLgXll2wDorx9/0Tbv8Axx1Up51dhd1XLCOvc11LNhMzR4AAGy
	k3/h4BbR7ZXb4iqtZEUfdh00+C4DDglC1Y8JlYiobR4D47OAJ6b5ZZ4NfUlWJT27uuBXOmMtWnS
	0ZQnGNAbS3QsX0BLXK8QwRXgHgkq55x85L1vPLGTkPj55dGLfpxh39QfzX59fRK6ZtsbQ==
X-Google-Smtp-Source: AGHT+IFadjzekGLL2Fl+5wJ9wLuqUI1feSIFvwGaBZK55MU+Kl9sobF9EqIAch4TUMkVkzUh0PJ6k9OSlYf6qMtCx68=
X-Received: by 2002:a05:6102:5812:b0:5d5:f6ae:3914 with SMTP id
 ada2fe7eead31-5e1dd01627dmr16263292137.22.1764586423872; Mon, 01 Dec 2025
 02:53:43 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Dec 2025 04:53:42 -0600
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Dec 2025 04:53:42 -0600
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq5xaqbxmk.fsf@gitster.g>
References: <xmqq5xaqbxmk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 1 Dec 2025 04:53:42 -0600
X-Gm-Features: AWmQ_bm13KrS0ZkABZ7FyEhbFHZ2RVftuLggMRAArp1xihoawTrhepId6I1ORWY
Message-ID: <CAOLa=ZTC3gWcFVENTCa2WQsxaq4X2a_D+0qQUBdg31uf0zjoTg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2025, #10; Sun, 30)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000f88dd80644e1ca89"

--000000000000f88dd80644e1ca89
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> * kn/ref-location (2025-11-26) 2 commits
>  - refs: add GIT_REF_URI to specify reference backend and directory
>  - refs: support obtaining ref_store for given dir
>
>  A mechanism to specify what reference backend to use and store
>  references in which directory is introduced, which would likely to
>  be useful during ref migration.
>
>  Comments?
>  source: <20251126-kn-alternate-ref-dir-v2-0-8b9f6f18f635@gmail.com>
>

I'll send in a new version for this today.

> * kn/fix-fetch-backfill-tag-with-batched-ref-updates (2025-11-21) 3 commits
>  - fetch: fix failed batched updates skipping operations
>  - fetch: fix non-conflicting tags not being committed
>  - fetch: extract out reference committing logic
>
>  "git fetch" that involves fetching tags, when a tag being fetched
>  needs to overwrite existing one, failed to fetch other tags, which
>  has been corrected.
>
>  Will merge to 'next'?
>  source: <20251121-fix-tags-not-fetching-v8-0-23b53a8a8334@gmail.com>
>
>

This should be ready for merge, it has been reviewed over multiple
versions.

Thanks!

--000000000000f88dd80644e1ca89
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4fc6e53438dd1a7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rdGM3UVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK3d6Qy85a1l3SjJKNElrTGFjYTNibWtaNGhhY2JKOApwZjA5aUtmWkQ4
Kzc5VVloa2Y2SjJ4K1preWdwbHhYWE96MDI1bnlzSVJ5ZEU1aklXVjB4K20zVzBzaWtObnNRCmRQ
LzcvcWpHYU1VU05DYU1uaWlkSk9lUkNLTlRQTCtVbEpZUFVHd2NMWXlFYzA4UE1lMHBnQkIrdTFy
M3NQNEMKZFhZK0xXMW8raFdJUlQveEpJY0RRNm51S3pCRTNoQmFrSSt3cDhKK3A5VitiODRKdlpa
SEhoSXd1Tzd4alY3SgpDNFI2anFqZkxkRWJINlVrQzBpTXo5TTJiVDkvQTY3aXNxQlI3ZmR3QWQx
Zk12N1QrQlZVZ3BxVWk5NFlrdXpGCjdFWlFzRzQxbWJuV3hmczhacGZBRzAzVVdWdFV3M29WZzhI
WHVjc3F0MGhkWTgxZXBmMmlJSmV3L01NUjhKSm0KamdsNk5qNWtwUlBRRXYwZ3V4dzUzMXVkeW5j
YlJ5b0VvYjhJUWh4VnhSdm1mQmRMODE0K3lrbzBEVUltRkFWVQoxOHIzNkp1YWx3UzdzUnN4TEZW
bXdaeitKTkxrSEJ0a1pjNWtYckhsTGJqSEJhWUppWGVJQ281ckxYN2dJRkVpCjVXVGhMbzBTSUZY
NmJqY0N5T2hWZWVLd3VqWkFzeHg2bkhJOVJKcz0KPWt5VDkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f88dd80644e1ca89--

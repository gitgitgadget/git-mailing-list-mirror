Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F5C21481F
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737564260; cv=none; b=PMZiiZ0y/fUbueqmH22QvCNpOzBcvzXHst3WJmp84RDnNwXjcEnc1I4oulq6gjFxj4uM8FM08rihueigPxqJiAt/PWaGgauOnHmtmNRTNgnP1xjKzF7PW7E2W8pBy35YeaudxRpHIremAK18K1A2+WKD6QbWZH+h6VkFwnrzd5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737564260; c=relaxed/simple;
	bh=VHAivLMYiQn8RGUDM7/xJfyX2icJzirvFhuXhDTRafE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ocLQt1SIeetcdSm0xjmjolqk2C6JdKEM4FK+hu5FmVrrVHNtA6/HZ5ZCvd11/GkCtyju/Ht140etIeSn7Y6ZSuZOm+cbM604LbP5phWcJtNXBOMQvffNtUYJUERhQnNaNHFZbmWJcDN3vn5Ahr/i21VRG7ReLdPN/SQr/4N0GnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqPRLlAD; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqPRLlAD"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-85c5a91374cso3105001241.3
        for <git@vger.kernel.org>; Wed, 22 Jan 2025 08:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737564254; x=1738169054; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TyiPe8MWB7RvBfSXVFXJMYw3rFXoEmEIzccr2SGhdkc=;
        b=gqPRLlADbWXNlpjqlhpWRLyUYf1xomQTEpegNFJNYsVn/Eh//CWvmDc5P7iZgmoSoE
         GoKkpyFkt2QM5stkhpdOJOID06ED8hB99ckAi9PHP9EH7DSSYueGDya6HzYz67UfFOcD
         ZYo5WcKGLyEcip1IRN4AkJ+6UbW4SqOD1gyVe3NvfUvTWDeyPgXMxG83LRWuruptmpOA
         75SiRSLiNfjzYh0wurPhdIk/PorlrIxW1jfvuJf+rwmggSmdB+izeIA9HyvfqXzB8KLm
         0z6GKsXdyYaykMHP7TzDr2G9BmkZVWD8+vgJRLmROHn2wE3xT6Z4rt96Hs8MHdxOES66
         LAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737564254; x=1738169054;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TyiPe8MWB7RvBfSXVFXJMYw3rFXoEmEIzccr2SGhdkc=;
        b=tSEvfOT9JBylkpyHscIdyRALH8vOKH5ofWSJsHhohhXRuYAVcdoHrBH96DCh+a6DbJ
         iJghJ4ptjrblBAAjwJuIP89zpXfoycZdRMyOIecMjwG4BWxSTn3kYdlk464R5vwSUQVQ
         alF3daR6lwB6aKCeN5dgXIeRCKkd3IBqIAIg4nTW4s7YHuv0g6DNKx/eloNUdxFrJ22l
         3zV50LRpFPLka2chgFub2PKHlBrjkdtmI6D6aZzKuq8fPCHCCRPUv8oHwh/ddQtubIRW
         4qvvig+epwY2fMgEQ5xsn7ahztu+r8ctnUpJyl53TaeQY59VAosgVMMRa+Bz7pkWEKKp
         J9ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWygFw3eLBpYHzpn8QzBLSM/4KTybeKFoKNZOOXPss3skxYgG9GWvzgQEW/ZbOVvoW6N4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1FPNOSu/qJlVc1FNHyngkE+VhCnTA+lQPxZjqgNFwBjeyamfD
	PMVvH5P4CO+aoC+Xu+T8UWn1gahHyGZ2ER0CQtwAmObbnTjIyTFJnt+c+h0Rmur2r+Dl3NkFWwT
	Q0bPNkxVzbVlDxyCh19gqpr/lgMU=
X-Gm-Gg: ASbGncvUt/G296+0bhDGmfpYd5G4IDis4mEDyECBrgJMiPmmcT2LhGVLGlOGL1o75N7
	jkaiRBeSI+cbaTgOfEJWEVVJQ/vnuIuuD5+wqP55DwIg30yBvRKP5
X-Google-Smtp-Source: AGHT+IG1oAgAc8LY7JLQKQVcUaGT5pRTbo/xTMLnDTp6/ZkB/LyVoBpsRrGbpUwiuVcxsF7YxzosbkEBVVYbrh0w05c=
X-Received: by 2002:a05:6122:8b87:b0:518:a287:56e3 with SMTP id
 71dfb90a1353d-51d5b2fd483mr19388049e0c.7.1737564254147; Wed, 22 Jan 2025
 08:44:14 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Jan 2025 08:44:13 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqwmetgdgm.fsf@gitster.g>
References: <xmqqwmetgdgm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 22 Jan 2025 08:44:13 -0800
X-Gm-Features: AWEUYZlP2NnEqnUfoAmfjmzFBdAUf7-YSzmWt2oUpdsp0rhxdKx6q8uHTioTBaM
Message-ID: <CAOLa=ZSyEg8G9g1B78VRymgfk9eo=d3KkhD=+S14_BSqaAO2Mg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2025, #05; Fri, 17)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: multipart/mixed; boundary="00000000000024c2a3062c4e3425"

--00000000000024c2a3062c4e3425
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> * kn/reflog-migration-fix (2025-01-15) 1 commit
>   (merged to 'next' on 2025-01-16 at ae8f9ce9a0)
>  + reftable: write correct max_update_index to header
>  (this branch is used by kn/reflog-migration-fix-followup.)
>
>  "git refs migrate" for migrating reflog data was broken.
>
>  Will merge to 'master'.
>  cf. <Z4mUizLNUdq_1BgY@tapette.crustytoothpaste.net>
>  source: <CAOLa=ZTL9n_DPhNr49XAd6bT838kc09oVx_AH7Pb4o8VK_xQ9w@mail.gmail.com>

This seems to be breaking on 'next'. I tested it locally with

  GIT_TEST_DEFAULT_REF_FORMAT=reftable meson test -v --test-args='-i'
t1400-update-ref

my local tests were made on files backend, and it didn't trigger on the
CI either for some reason (I shall investigate that soon). But dscho
(CC'd) reported that macos builds for reftable were failing [1] for his
branch and I could bisect it to this.

I'm yet to understand why this fails and also why the CI didn't notify
of the issue. But that is something I shall do next. For now we need to
remove it from next.

[1]: https://github.com/dscho/git/actions/runs/12906424058/job/35987723223

--00000000000024c2a3062c4e3425
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 53a61bc0ff2466fb_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lUklGb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMGRNQy85aU5jbU9GRWorM3YrbjVPRUg4YXd1WmpvSQpXVkFRK1puQUNK
czMxcmtjUk9oZ0p2UmpTQmtDL1dGNFFvVGJ2L0R4WFBwTEJHY2pyd01jZEZvMWlxSFhKMG1vCjdL
U3JvNVJTcFRmRmpzZGFtZnAwUmxOeXBzV282SklFc1dDOHM4TjZKWnF0YzgwUWg5dkhJWGtuWHlE
M1RZck8KVTl4dmRpVXgyREhubS9SZmxkQlVuT3IxSWo0R0Q3YUp0VkgrcDBpTDE2MzJVN1dtWVZZ
eDFUci9zb1FmN0tyQwoxN0J6dTBsazdCaGwzL3RTakNTWHJCaGNleHQ1MG0vZStQY1VtMXM1Snph
RExLSEFyRTdyem1FOTZHYWRGR1lICmhTUk9WbWNVVFFjQmxkZ0ZoTjlFMXBwTzhrZHNZaHRENWYx
SmM5bXFUaHNRMlpncitEd21CdGJmNFEyVUczSncKMFFWNG9scHZRSEZsTjd1NktqVjJGb3lhcGZE
RjRpRC80RTVkeWtkQWhWMFkxQjhkdEFMNFZobm9iTFhEYTZ0TworNzhqdGN2SENBN3FvZGlRcVFJ
TFVTWWxVSllnSC9iR2FnazN3b3lCM1grc1l3K2ZlZ2hwRUpYTER0aHNGdzJNCkh2b1ptYmZXZG96
enppdG5jR3RGUHh5UGFDczFSWFJDTnhaYXQ2RT0KPTVnTkoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000024c2a3062c4e3425--

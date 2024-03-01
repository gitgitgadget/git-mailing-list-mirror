Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C94B5811C
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 10:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709290481; cv=none; b=sr5NdEEksvfdaqKzLSGPCrtVLE1b9GNWtk1Xzxi7ES7T3rlX5tznDomMbhqJlFtjCBJOa6GJXBd7kilLgDCl33gNao0Mn4+e4H36c5Y8PCFT78ZPsqzDwzBW8HFwhp7oRjdOiKwfWQbz0JCl1RMDfwk9TU+oBj/YuxMcbSZGspI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709290481; c=relaxed/simple;
	bh=c4A+OmXAxiX4w6l//Hi+JxycdOOXb8oV/DO5wa7cUeU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=JXMDAvjm4ck5HKwImX33+COe9M0o4audjr2355w2AKj7JPo+pDK7hVMYGZhfs820N2MwDfP8wZso8/bTAaONAIMAWI9wHuOnlxGyjDmL5yW9DoYBqzbZfDlo+q940XA0KC2zHA+kb/BIiKNO8nbfyg3/wqGc4ylrG6dM5470KmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcT2mwpn; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcT2mwpn"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-220461b7597so1072594fac.3
        for <git@vger.kernel.org>; Fri, 01 Mar 2024 02:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709290478; x=1709895278; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oO+Uu/USUY+vMd11CgWiZ8wTVXRILKwPvqkXMfJ+Br8=;
        b=GcT2mwpnq4Pwiyi27WzXVWuojMkUT2P0P9JP7GSYOWtn3QptSEMJRiXhP6IsiFung3
         hInMnvHsWuJ4kYR25F+pM7eH9IJwiV4kSk5gkJS0WAvocd/RG+NZ9442v0bIXY8v0yEr
         JVMVih8XNdMxShccjffvxL0yRzmhBO2YowSVKhPNxutpy0yNadz350FRNreQ3K/B69O2
         wSStDwJFrE/AHZejJbt3O+QeVuPhMhMlrsbcYIJAkIIF1/l5HQR+fMZtxPRRpIXfpS1M
         UGVi8y1lCf8kazCfGySBaLR1GDlniHz5Ao5So6llLp/rPsH17UmJZKxg9kggFeV8WVOK
         KuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709290478; x=1709895278;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oO+Uu/USUY+vMd11CgWiZ8wTVXRILKwPvqkXMfJ+Br8=;
        b=RoVDOYmjPI/MejtWOH28rGlfuaeOiQr6aeyG5r8gViXKWURdND5UYPOtPSRn/4br5R
         /aBE5zkeMf2Ia0Ycxj+J/DCw6R0hyXB2VlJnkDpn1XGxy2OuPIMqwAiXomLbsKrEH9nO
         DSUqhQen/oQkxdHBEB43WTkKrUpkXov8Sv9CJmi4JUfwo7wa3hAMidOLSb9rfN+dxV7y
         FKomEQo2L23Ohi4HOvbXtoaW0lyG+XksKB6iP+RKjzqhK6LwxbvucAE08b8CKgh+xTcN
         oz44TR/n99IdyRMuxEZ5t6Wk8sJUPe3vvFLmwrFYpUsJIpiHpE/EJN+rp/g9CbsBv8zc
         MZvA==
X-Forwarded-Encrypted: i=1; AJvYcCX07/ANjXGGOzlV1WUoYoHFJavVQ1xbyxffDtx6fBtnljHgV32ncvKpAQgX/x630tGIRVbzNA1I2ed6yL0EFgig0dxJ
X-Gm-Message-State: AOJu0YzaBlRfsA6k0wuNH5ggtn1kvWm/Y9oet8xU8O8w2Myr+Zz9ZdKc
	HEAcg4ZN896VhpCrEv0ZLX0V4nRKDDJYLAjv7K3I8/jYUQKDYvL39ypXhRFNcMoP8DwoXFlnkZs
	tsI+vpd8yq+y27GYutTddgVoWgFn6G+JaBYI=
X-Google-Smtp-Source: AGHT+IHBnEEHasqjUBtG63YPC6jjLtNIWD160BlRGp8yrCw/Ttj2ZeRX3szgr/VKbms7lgoEdFsy7XWiMgy7ldySmR8=
X-Received: by 2002:a05:6871:5311:b0:220:6da1:8a38 with SMTP id
 hx17-20020a056871531100b002206da18a38mr1551818oac.7.1709290478368; Fri, 01
 Mar 2024 02:54:38 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 Mar 2024 02:54:37 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqjzmpm9b8.fsf@gitster.g>
References: <xmqqjzmpm9b8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 1 Mar 2024 02:54:37 -0800
Message-ID: <CAOLa=ZQAxGFDrBmq0+Q77YcfT4hBivRu9oOGZF-r81F49P+00Q@mail.gmail.com>
Subject: Re: What's cooking in git.git (Feb 2024, #09; Tue, 27)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000c80e0d061297333e"

--000000000000c80e0d061297333e
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:
> * kn/for-all-refs (2024-02-23) 6 commits
>   (merged to 'next' on 2024-02-27 at aef2406cca)
>  + for-each-ref: add new option to include root refs
>  + ref-filter: rename 'FILTER_REFS_ALL' to 'FILTER_REFS_REGULAR'
>  + refs: introduce `refs_for_each_include_root_refs()`
>  + refs: extract out `loose_fill_ref_dir_regular_file()`
>  + refs: introduce `is_pseudoref()` and `is_headref()`
>  + Merge branch 'ps/reftable-backend' into kn/for-all-refs
>
>  "git for-each-ref" filters its output with prefixes given from the
>  command line, but it did not honor an empty string to mean "pass
>  everything", which has been corrected.
>
>  Will merge to 'master'.
>  source: <20240223100112.44127-1-karthik.188@gmail.com>

Thanks, the description here needs to be modified since we moved from
the `an empty string to mean "pass everything"` to providing the
`--include-root-refs` option.

--000000000000c80e0d061297333e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 586a566d99f995de_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1YaHMrZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMUZYQy80NlRNRG5oWkZERVRTRGtFNmNrcnVjYnIxWgoxTVRiN2oyWFk3
Y0xGNWJFZG9ZcVlhQ2JhMk1lVGQ1ZFFHNFRPbjNjT0lSMWQybnphd081RmZlbnIrWE5nYTlLCm1S
THlDaTNjRkIrRHptUWE3NXY5RzlZTyt4WGYwOFpaVEpvRi8vWERCcHJsWlM5Tm1ST3dNZ3Ewc2dK
ZlFwUUcKUVRKdlNPR2FmdmgyMktLVFdOUHpEdWNvcHhtNVFkdzhKa3kvZnpBVXVoOUVrKzRjNGoy
VGFIaGU5VkhoY1BxSwprelZpQ1o2WmFOVHQ3WmZTZkEzSkRFS1NsSTlSa1ZGYzhjd0dqVmMxNHM4
YjFzWHJSSXU0akp0YnQyeUZPSGtICkxVbWN2OFM4alh4K3owN0ZjQW1ORzh2bWxsOTEzdFI3SHpL
cjZEanJaSWRlVHM1Q2VCbnY3Um9Wbkx5NGZDRGgKZE5COGFtaDdwclZieXVVbUtUUXFpa1JyWS93
ZTNrZjBrWkhsTmtJazJ2ZFhGNWQ0Z3NYRjJpU0tDTFQ2Z2lwRQorSEdzRXhrdzVIaThXeHdCTWp6
UVIyWlFLZHYvOTdkTVlnTTk3ZjJSc1BYeTZkVEVzT1dWSkNyZWJobnUzNjAxCnhUL1BPTUg1TS9O
M1o3ZjJCb2ZuOUN4OUlQOGZ1TXpCazRSQ3lBdz0KPU5ycnkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c80e0d061297333e--

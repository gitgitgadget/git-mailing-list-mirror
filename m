Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27C91FBE87
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 12:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732709985; cv=none; b=Y0jUNCpAbkWao101rW9WEXU5FlKKQ3zuIss91E76NJmf8FVBJwW80499I7TM+SE7c/R3e3EuVU6KFmkIEAywMfKCpQ2mul8m5A//WzFkrobBlYvpJSB1QbpPFA+YzWKbSWgutNjbv924/zH1WFTNBj0GFBzzdzTit+PceE3yLNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732709985; c=relaxed/simple;
	bh=GlDOOcvqQMz6S7EeJkBikCED3DzCx9CJbdWCCUVeueo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=u+NC01A4jJvnECW/8lbODXbr1L1SHOdLPqXka304bSwiucjFTNs6ocnTG5dssxCyB3tA67NUoN7LCDlutatC0VB/SRfJeaovTnPEC5ojCoG1DWklcBqSemIBfDXONQhiXHJ2VK9xID5XPvgh/ioWg9nKM3CgUX3a1M2Y13DGuBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mppycp4Y; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mppycp4Y"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71d40003870so1048878a34.0
        for <git@vger.kernel.org>; Wed, 27 Nov 2024 04:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732709983; x=1733314783; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6BYRAAEHvRUcmCbUGjXmbBScZMl5yVWpFJwdyCshUHI=;
        b=Mppycp4YXbParSn8r5q9G22chD4JgjJa0nB9PEWXFtswipuSylU0fBo1KqGk50ItL0
         LKSkAZPsjUna32i7+T55DssKYzzgNMKvMU+Fg0tdsTaDUba3Rm91OL/0XwXrPJLCLegz
         01wPQY3TrOOU/+wf5a6dtmlwcpGss+yRCjgKp22MGdTVX6TYAWkEr7b7la5MsfdVVUug
         9oUw06fq3xG2M7NKXn/6x3GQHJpMHVif80gEvsyIt0YDciJSPYr8FbplwdCkH8G51aCN
         XvVWlq4IhAeRC26xW+PofUVTVS1W1Gg5SKc37ZuisPI47IuaBsStFStn2ynSvTKS697C
         3CQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732709983; x=1733314783;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6BYRAAEHvRUcmCbUGjXmbBScZMl5yVWpFJwdyCshUHI=;
        b=VnPmIHZiqWF2IV5xrTsu5GCAKRUvY9NqjutR/n6b3vb6fz9NEYQbRsM77FKLklMD8O
         rNsn9Pu6SKsIQGAenW/mVo7unaN7OAalzHHNE1sfkIVoqmpicYmeU+0aFzSsYZ3pzsHc
         is1Rbq2DCjSFhAPrq6mOSRHn2tODhe1Kwi1NMeatt6j62JA2Obwc+pNh+MVAEhZ9X0k1
         /g5CTv0XnpRG2uWxTKycQyMDpBpaYFrjMRNdws6oVk586ifmom+Tcmij3xi5sUlOCznw
         TM0XUiYKsDIkH83a0g8/HLYCVoON/kHWJ5xJAlQQ8vz3ozp347kOm+vfc3BMBvPENoX9
         UdzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFFOK3+ncQvsWw8MyaMSoyw+9K5/dt26PoJkKgLz72IfF9DHuIsiiqfUKAJqGx83zjlEA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzib3U61QDe6uZdJ/B+bB+jSx35QJ8yx0B6zb7/zZ+jismHzjoh
	yWcHQQ8VdMzev/sv/r0QYAmfg+eaa8fQpuRbeYupLA6yKgol7UzrDvrw5aq665ehk/APfC3bBsS
	KvJZA/Z1ySaVf+PEhobk0karl+/M=
X-Gm-Gg: ASbGnctumFYI9L9kr6ciGS4LNKxvvuLgz9FSEf32MnfkXenIFJhxwGtEl4CHMW/Bxid
	XjVYG2XJZylsilkXkJFdIsy6ECuJKWOnCPj+dfFuzlt5zzeBQcIYTSbFxoKSERwzyMQ==
X-Google-Smtp-Source: AGHT+IHzAPe4UEsSqd1PLhCHp1v58p2N7upRg7PxugzH0jNaIbrYfolk7ZJjZVQCqnSrdksPCrm8h38NLb2bqGGfJsA=
X-Received: by 2002:a05:6359:4c8d:b0:1c3:39ac:889b with SMTP id
 e5c5f4694b2df-1cab16aa9d1mr161665055d.25.1732709982928; Wed, 27 Nov 2024
 04:19:42 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 Nov 2024 12:19:42 +0000
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqttbv4ty8.fsf@gitster.g>
References: <xmqqttbv4ty8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 27 Nov 2024 12:19:42 +0000
Message-ID: <CAOLa=ZTHVdJxq+vcAGMRMS3A53m_a38npEJgiF7xLd-3J6MiLg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2024, #09; Mon, 25)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000008aff80627e3fbe0"

--00000000000008aff80627e3fbe0
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

[snip]

> [Cooking]
>
> * kn/midx-wo-the-repository (2024-11-25) 11 commits
>  - midx: inline the `MIDX_MIN_SIZE` definition
>  - midx: pass down `hash_algo` to `get_split_midx_filename_ext`
>  - midx: pass down `hash_algo` to `get_midx_filename[_ext]`
>  - midx: pass `repository` to `load_multi_pack_index`
>  - midx: cleanup internal usage of `the_repository` and `the_hash_algo`
>  - midx-write: pass down repository to `write_midx_file[_only]`
>  - write-midx: add repository field to `write_midx_context`
>  - midx-write: use `revs->repo` inside `read_refs_snapshot`
>  - midx-write: pass down repository to static functions
>  - builtin: pass repository to sub commands
>  - Merge branch 'kn/the-repository' into kn/midx-wo-the-repository
>  (this branch uses kn/the-repository.)
>
>  Yet another "pass the repository through the callchain" topic.
>
>  Expecting a reroll.
>  source: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
>

I'm waiting for
https://lore.kernel.org/git/xmqq34jdyey3.fsf@gitster.g/T/#t settle down,
and I'll then rebase and send this.

[snip]

> * kn/the-repository (2024-11-25) 10 commits
>  - packfile.c: remove unnecessary prepare_packed_git() call
>  - midx: add repository to `multi_pack_index` struct
>  - config: make `packed_git_(limit|window_size)` non-global variables
>  - config: make `delta_base_cache_limit` a non-global variable
>  - packfile: pass down repository to `for_each_packed_object`
>  - packfile: pass down repository to `has_object[_kept]_pack`
>  - packfile: pass down repository to `odb_pack_name`
>  - packfile: pass `repository` to static function in the file
>  - packfile: use `repository` from `packed_git` directly
>  - packfile: add repository to struct `packed_git`
>  (this branch is used by kn/midx-wo-the-repository.)
>
>  Various implicit uses of 'the_repoository' in the packfile code
>  have been eliminated.
>
>  Will merge to 'next'?
>  source: <cover.1732269840.git.karthik.188@gmail.com>

There were two commit message changes suggested by Kristoffer, I'm not
sure they require a re-roll. But otherwise, I think it should be ready
to be merged to next.

--00000000000008aff80627e3fbe0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6eb6074d74946cbd_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kSERsd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNkZIQy93T2VFQXhVNVFSc3NrWm1xeTBQdjhCOGxDdAphdUt3R2k1L3Ft
emNqcTJIT2FRNnV3Y1V6aC9aZHZPM25IaDFObGg0aURXbkxzTUxZeDZyVWVORUR5QklJT0hBClVu
N1ExL3d4UklGVGxReGpRSE1jb2JhSm5SNkpWaEN3L0J3RUZSeHJjUTNwTjZLemJCSEg0bzJuSU1i
YUNTTHkKVWc3VHFFaG5jWkx2VENrbGd4clRBUXZ2UVNVVHVrM21VSDZjNlI0RHdJWEJ0eWtvSzQ3
Y05VVWc4d3VXRUlySwp2QmptUFlocElMM2dhUi9SVGFMbnlDaDAxMkxiNkltT2ZWYmNjb2lNMVJo
ckQwQmdIS3hySUIweDZpRldNQmJCCjZNWkR1YUVWYlNIQTZWcGxudlBkTk1KQ2NJbVhhcEpPaTQ0
aEhTdGpydEJhT05tcDE5VXc0b0pyaTFPdWtmVWwKTklyZm5RRktIckVhaFpJb1poMDdWQ1JMa2xE
b3JOWjZ4cDVOcXhZdHR3Q1NnVS94YkMvVWVUdnVZNUYxWURwSgpHcVIydTQ0OHpoSHRHeDA3MS9B
TGd4aFNwb1FlcUFMYXBpSFlWekltYk1BTjZaVzZoS0N3ejhXK1FXbGtoTmdUCk5XMzhaR3RTUDho
Y0M5YTZlNW15M2RCTlhmc3dEblBoTkdLZVR3TT0KPWszeHEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000008aff80627e3fbe0--

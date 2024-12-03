Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8F21DAC9F
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237169; cv=none; b=NWYhrrGulE+oDwzQFjLb9p4j1ntFcVLZZnQhW2tTijE6/ThnWIwuU6rdw9NvYWcrY+gfFOsTX/uZOhqvWwR7shlxpRu2r2fh2JNM6QV3drF4+/WVFABoy2IJo0qpRwmb7mLDjjy8i1hxoF5LWroAJYTV16zt9iKuF2WjL2eqiUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237169; c=relaxed/simple;
	bh=3MSo81ga3OfU7b+HJPIrHb0s3jO5HlYsf6inIfp5hK8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dEbwx33g82MJQRCOc+urQwyKpTMVnRTd6Rf1eyirKRtHVyvjn6dwX0thksLeuC6S7kBmKAJXHNPIlU/BHwQFRpaMfOSlfbYLPEXRWkj4urAf9WdVzRX/vQG0QtNl+10bNuebBBAzfNMFuBAjFTLtv9s5LGfqn/+JGwwRhdJ37Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZQ3LaoR; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZQ3LaoR"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5f205c4625dso1860594eaf.3
        for <git@vger.kernel.org>; Tue, 03 Dec 2024 06:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733237167; x=1733841967; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gay8AMo4ZJMiIoWDhP+5LaJGog2Zqz5sSlaWHuhTa2Q=;
        b=gZQ3LaoR5/+5QEgKr7bwEVlcHYBed2Bf3n/gypsUX9CyCC+eVsZVG35ZW0iIab/eVn
         Ha+eQgwGY0YEj8PNzf8h6WVpPQSD5zC2Sup5My5TAy9V72LWAE+k71+DM9BsaxWSJSP9
         8qE4fdgTfZMhscVgu45CowWHKObhbidPv+zG1IbN/xYlRA0KOm90rTZqIO0D0f9V6xxu
         wraODmKDhTyVG+ZKMQe+x8MdsrLXWg3xX5m+Klkv+5Lx+BG2anzwJyQYeuSybRJSMAjU
         vHYSlRE28cLVxCor9TFb+ASBVPDRPUgVkJFPO+yMVURTGpoTNYFeYrInTX8ko88RI3OD
         j61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733237167; x=1733841967;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gay8AMo4ZJMiIoWDhP+5LaJGog2Zqz5sSlaWHuhTa2Q=;
        b=ifcVoGTbMCx5Yr4/GW+A1jegwxFUjB571wDFxFYZhuDVVbXirfeOthTcbqxNpO3fxH
         uBYJDwxiGaqtiKtvK1sdOwF/ZZK3Seq/Fs49ezJYCx+Arm3nVyve3Doz2mWk5jS6v4AF
         i1m/Sk0NrWOPDBrDPfIcvP+cV+8Dv8bF4c49RHK70WM9tpewk7Rba6uzif+zCjERaH5T
         5HAXhZI74R5lv0Qrs3rwtNVNyYZHzhducBJQsNIFaWqU+r/cRfA1kFsDc/5aBaFzwJrI
         7JzaCqrSzI9oySKF/vdvx3Gx7d2a+w6EKuzJcAFmSOSZNmhUaEIyWL4Wg4kJe5EZ3ydO
         iT2g==
X-Gm-Message-State: AOJu0YzNW8+PsLJX+1YxV+Bz5CurJZp+Kh/0a2lPp30i86vKm07I32z+
	ctpSyFqmb9/URQAK5reT2+8EFw2N2QdSywlzwQ33CsQG6XTP9ERK3XZqrNlhwh4X0EFULJwYP7E
	WJwHRoLKsqHVQaDTo21B0mrCNqyk=
X-Gm-Gg: ASbGncsCGj5LEd+h6DIyKQC0uou+duX1EPdDtYDI4YgmlUXhirI7jKYYVYYwWNon2KR
	VD4bHCwZat7QJ7wDLtlQ+ucx7g5v8LnqkWoMKRGGLV+yV7O7BoweUAUbIxiSeC6tsVQ==
X-Google-Smtp-Source: AGHT+IHe2szAZZ0I/voELcrA4mWKeY3J/VnjfxiLA8N0gQK+gHiPapAnnPxIAFrrsPWbXFZzAS6t9K6vTnD6Qn2+bfc=
X-Received: by 2002:a05:6358:d38d:b0:1ca:90da:3c21 with SMTP id
 e5c5f4694b2df-1caeabd7be7mr229389455d.25.1733237167059; Tue, 03 Dec 2024
 06:46:07 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Dec 2024 14:46:06 +0000
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <Z07auxNCcysPovdo@pks.im>
References: <xmqqed2pcled.fsf@gitster.g> <Z07auxNCcysPovdo@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 3 Dec 2024 14:46:05 +0000
Message-ID: <CAOLa=ZT1queYRwTK2a-yB+XXiY0kdBnuuuo5ptbWhfsY69tmcA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2024, #01; Tue, 3)
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000a8954806285eb9dc"

--000000000000a8954806285eb9dc
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Dec 03, 2024 at 03:48:10PM +0900, Junio C Hamano wrote:
>> * kn/midx-wo-the-repository (2024-11-28) 10 commits
>>  - midx: inline the `MIDX_MIN_SIZE` definition
>>  - midx: pass down `hash_algo` to functions using global variables
>>  - midx: pass `repository` to `load_multi_pack_index`
>>  - midx: cleanup internal usage of `the_repository` and `the_hash_algo`
>>  - midx-write: pass down repository to `write_midx_file[_only]`
>>  - write-midx: add repository field to `write_midx_context`
>>  - midx-write: use `revs->repo` inside `read_refs_snapshot`
>>  - midx-write: pass down repository to static functions
>>  - Merge branch 'kn/pass-repo-to-builtin-sub-sub-commands' into kn/midx-wo-the-repository
>>  - Merge branch 'kn/the-repository' into kn/midx-wo-the-repository
>>  (this branch uses kn/pass-repo-to-builtin-sub-sub-commands and kn/the-repository.)
>>
>>  Yet another "pass the repository through the callchain" topic.
>>
>>  Will merge to 'next'?
>>  source: <20241127-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v3-0-c5a99f85009b@gmail.com>
>
> This series looks good to me.
>

Thanks Patrick.

[snip]

>> * kn/the-repository (2024-11-27) 10 commits
>>  - packfile.c: remove unnecessary prepare_packed_git() call
>>  - midx: add repository to `multi_pack_index` struct
>>  - config: make `packed_git_(limit|window_size)` non-global variables
>>  - config: make `delta_base_cache_limit` a non-global variable
>>  - packfile: pass down repository to `for_each_packed_object`
>>  - packfile: pass down repository to `has_object[_kept]_pack`
>>  - packfile: pass down repository to `odb_pack_name`
>>  - packfile: pass `repository` to static function in the file
>>  - packfile: use `repository` from `packed_git` directly
>>  - packfile: add repository to struct `packed_git`
>>  (this branch is used by kn/midx-wo-the-repository.)
>>
>>  Various implicit uses of 'the_repoository' in the packfile code
>>  have been eliminated.
>>
>>  Will merge to 'next'?
>>  source: <cover.1732618495.git.karthik.188@gmail.com>
>
> I think there were two nits that Karthik has addressed but not yet sent
> out. May make sense to wait for that final reroll before merging it
> down.
>

I was holding out on re-rolling since they were minor, but I think it is
best addressed, I've pushed a new version with the fixes now, we should
be good to merge it to 'next'. Thanks both.

--000000000000a8954806285eb9dc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 28c0895ca6bf193c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kUEdha1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meGNnQy85ckNRbVY3QU1BMU1aNUQveVJrQnhvbUJ2dgpGdVNCZDV1VDU2
cHppQi9nNjBzZ2Mzb3lBZHVhZGgwZHFSYkpCT1diRzJxcnlXbnErai9qVHk2TG1rM2c1aTFqClcr
SVBvRmVJd2JIMHEvYUowOTJ2amRjZWxYS0V0MHdUdW0vSTdiMUh2TU15Z2hvZWZuOVV0eXM0eU5r
RFRLQncKbTRyeWY1QU4ySXo4OG1BaU1BaGRxcHQzS2dtSzdxcGlzNTM4MmxIbGgrcDlVdlBVRnE5
TE1UeWJEcEt6dVFGVQpnK0trSGZjR0JNY1JhTDRCYTl6OEZjLzZQMGFocktPMVluNyt2TTRhOGc4
UFBuMWI1WHRXbzJTandYWDJFKzJqCmxzZDgxTS8xWEFMV2xaVzYrVDRCY2xVTWtibllWUDd0MGhn
K2FmWFAvQ0NPRXcyOU9aVFBkalZhZHpGeURNWGwKS1U5NGlpWDU5eTEyK1lKZUpxQzZmZWRmRndH
N0xTVS9JZGtLeUdEQnBQNFc0eFZpNW5uNitEZEQveVhhaVVxdgpkTGhxbGRzN0NIR0xibXR0RWpO
ekI3UWdOQmh4Z21QaHpSb1d6NDhMUHROYWJUKzIxVGRRVWkraC9CT1J2NkJZCkpNVWZqdDROSFBE
b3VUNm9raFMxdjBOM1lYRGNvNUQ5VHB1KzMyUT0KPVN6NjkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a8954806285eb9dc--

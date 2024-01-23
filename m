Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9062B5EE64
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 12:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014171; cv=none; b=p6v2zl/SSlXyQ4bRxI71nlDun9uLSU7fwz7S3TqPodcYWb8AQ/uYb+vPbEvxrSH+FgnkmdQiPZD30uOVbJg1bsk1YDUciJmqT6apHoM35etXURBecqSCjt7c3vYVPEzMz4zb3AMp1t+sMk7efNnJjdFfP1F3/wN4m0YrZJw0zI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014171; c=relaxed/simple;
	bh=4dYPhY1KilNiwWSAx5prMnON+rw8wJ9ZYeaGuMDmWXc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qGPCovMrONWhLHCHu+PybtuCv042T9ZMbrCWhm5Uhv+BGuggsrk11wksyFfGkXR/LqAFRv7ynNvIhjHkKfJ5QFm7opV9iYo4zA3JBOMlsEm8y6jS8lqyFsa9Et0HcNewFAAAnIK4o6v6Zf+9oL7fQdgBYS2+sAebMcAhuddk7y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gp/jW6VR; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gp/jW6VR"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bbbc6bcc78so3549997b6e.1
        for <git@vger.kernel.org>; Tue, 23 Jan 2024 04:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706014168; x=1706618968; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4dYPhY1KilNiwWSAx5prMnON+rw8wJ9ZYeaGuMDmWXc=;
        b=Gp/jW6VRQMAS0dmtUSf3Ufmdy4SSJoelSOih6hS1hFs3IdRMHP9eECtH/irXMjB86o
         maSgkMSU3xe15XXBhjt9SONUAPVweN+P74/ydey9c1lC16Uh/e4Woivxmv6EnB45G31M
         NAdqtPpWjWrAzFQVPefBQCBH83PBZCMGfGJIrUPhU698ea1UhqLsyKJBmarieGiFkAt8
         qrmgpy+4yGhcF979VOEUCIbgHnIdqPluWbEJrHo73tFfXv7LU/T2xo7JaGDmvry73OcF
         AXzJooZlxHrUwPctdbpvh7Pj2zDZe6dZUUeMGzyI7oTVTEfoUwHniHUyiq36lchI204P
         ledA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706014168; x=1706618968;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4dYPhY1KilNiwWSAx5prMnON+rw8wJ9ZYeaGuMDmWXc=;
        b=gFq3NVOBHy0QjEf9taletJAPYM9BXXOa3nHBubuAHx8yGVWlA2s61rluqtEIFqmTKy
         rgeH1+Awsh4HPFS33RhkUPyFOPynjxwxRkKNnlBwDFxD8cl0v6wlCizPdQEaBNsaca+k
         kbk0pp1YO3R+Pq4N1AXxMWxGyz+1+q/6UZ5py65oNoOyT3wovbXcq3bqOBjKY7BRakxX
         owzpX40xbC1802mi5Ccy5I5OmoL30TZPndm3wHZzBAhmOmkvT5ZSZd932xsfAen8zHGK
         0LKsXUuD1D29dowXr+q/dGEiJUCNL41FTIVvw3Nh+DDMx/2deVspBnDMcxi0/JoyU5bT
         FNww==
X-Gm-Message-State: AOJu0Yz23YxBUpjC77SZSFYUVxZ0fCj3bngmNs5QW5iDxDPAy93KPwcE
	hrkLn3qg0T9MrvIfaA3dhqBScapYIma4O5DW0Cj4Q3uyjS/srfoIY5a+xtlXXBjYYeD7Mdg+olJ
	byoH5r5RRpJ1E4KzAUg+ZlooTaIs=
X-Google-Smtp-Source: AGHT+IERzLDLD2DZFLYa5Msu7MiFJ1SMBdW+vSTWEqkZxNK/Tn1uH7iJlgWZURqABfjRD68B616/KAdfyFknN68JZhU=
X-Received: by 2002:a05:6870:3914:b0:214:90b2:4ef9 with SMTP id
 b20-20020a056870391400b0021490b24ef9mr428727oap.75.1706014168529; Tue, 23 Jan
 2024 04:49:28 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jan 2024 04:49:27 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ba721840-7b67-4822-8046-c0da4d3b9bde@gmail.com>
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240119142705.139374-3-karthik.188@gmail.com> <ee977173-bc6d-48f6-9bc8-e1d84fe3d95d@gmail.com>
 <xmqqplxtrucm.fsf@gitster.g> <ba721840-7b67-4822-8046-c0da4d3b9bde@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Jan 2024 04:49:27 -0800
Message-ID: <CAOLa=ZQOcqGBJOSehok4BYGUE8RKtnE9eiJYogeT8E6NWZ25xw@mail.gmail.com>
Subject: Re: [PATCH 2/5] refs: make `is_pseudoref_syntax()` stricter
To: phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000007f518e060f9c6078"

--0000000000007f518e060f9c6078
Content-Type: text/plain; charset="UTF-8"

Hello Phillip,

Phillip Wood <phillip.wood123@gmail.com> writes:
>
> Hopefully such a rule would stop us adding pseudorefs that are really
> private state like MERGE_AUTOSTASH. I think that is good in the long
> term but isn't it is happening now with this patch without any warning
> to users? This patch changes the behavior of parse_worktree_ref() which
> the files backend uses to figure out the path it should use when reading
> and writing a ref.
>

I do agree with the problem you're outlining here. Changing
`is_pseudoref_syntax()` does indeed break things since its also used by
`parse_worktree_ref()`.

I first thought I could get around this by adding the required missing
refs, but even that wouldn't work. Because BISECT_START has dual nature,
it act as a ref and also as file storing a branch name as Patrick
mentions in detail in his email [1]. Meaning if `is_pseudoref_syntax()`
identifies it as a pseudoref, it could be wrong and printing it as such
might not work. But we can't not match it because that is the current
expectation.

So there is no way to make `is_pseudoref_syntax()` stricter without
breaking backward compatibility. While we do want to reach that goal, we
have to go about in the other way around, that i.e.
1. Fix all pseudorefs to have the '_HEAD' suffix.
2. Move bisect files to '$GIT_DIR/bisect-state' (see [1] for more
details).
After this, we can safely make `is_pseudoref_syntax()` stricter.

Given this, I think for the next version, I'll do the following changes:
1. keep `is_pseudoref_syntax()` as is.
2. introduce `is_pseudoref()` which calls `is_pseudoref_syntax()` and
also checks the content of the file.
3. replace use of `is_pseudoref_syntax()` with `is_pseudoref()` in this
patch series.

[1]: https://public-inbox.org/git/20240119142705.139374-1-karthik.188@gmail.com/T/#m6e3790e30613fd68349708faaf5f4d9c704ba677

--0000000000007f518e060f9c6078
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b31d0cc4c6d0d537_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1XdnRkUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK2w5REFDV3RYUXBoQWNyYUVPVlVJMFJoZXViTDJXTAorcjlVbHFoZkVP
c0dacnRIWE1yaGpvbXlNSm81SlcwTEdEcFlYcUs1K2RlSVFrMXlhd2E1dTNScUJjQXJQQnMxClAw
L3QxZVlWMHpzNmFISVdHamJ2R0Y4cEI5Y3JjdjRmU2I3OTByZWwwK28rakg1SDRzVEIwOVFYOXNQ
cU41WjIKNHBUWmpDd3ZVWG0xbUZHR3Bsd3BMeXRxUTRTVkJWSjV3eVNjbzFPWG5NZHVISWNaZWZt
VFo3NzVUWk5UYkJPeQpyb05PVkp3Mjd5S0xoNDFILzA1ZTEvNW1YWldpcmI4Z3FmcDlrREFrNzdw
NnJzbS9QL1J6Z0tZTHdpSkFrTkc2CnUxeisxLzdzc0hsZ0ZlMVNCQjJFZzZqSUgwNU5mVVc0cmhi
VnRzMUdNZ2tFaTZkQlN5bHBaSGk1T0pBTnlvWjAKdnhTcnJnSE1yeklxZE5Ja3laSUY5OHZFZ0Rp
NWpCWnNxNlVsOW9RcTBkUks5ZWVCMVRrbGlNV2lsS0VvbEc0UQo3MURLc2VHOHNhTE1ya2V5Yi9V
cVdkdDJZZG1lay9vVS9aM2lYMS9zanZya2pESWtKMlhqVEFkL3dybWk5TzF1CkQ4YStaaDEvQnhH
MjdoV3FqYnV1eVZGdjhWTThnRXhaOHQ1bFRYRT0KPW16VjQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007f518e060f9c6078--

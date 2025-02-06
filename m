Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D816322D4C7
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 11:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738840636; cv=none; b=e1MXR1DdhXqY5lukFCd0gqpKBf3ctcHZ1iXBWIBQH4vFbUOFNr+7dndzMJnILkQCp/gmuPT5HqDobYLtfzfMBaOVnST70P7huxJFq2HfOmUrlDg3KWGiVHOiQg0eYcXq4l1aIJ2wPEdEXeN59OSqYnwvun4zgTzIZpPFIYbmT2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738840636; c=relaxed/simple;
	bh=Vo39VL0fDe8Z4BnzspDSlX+pj+OVybkyazZwLMAInvY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=iCnJNDbzuDw/yOo6u5dcLSDPi0qC0QgBObGsK92hf68yQvgopc+3c5AjYk7k2V86RcZc/5dnX2IrKMcaepAMxNTF9qatWsStddI81wSGCYlOlT6WQuJup7x0GXZ23lIqz1eeCnqy4PriwReuq6DVJSyaU2nDVFdv0CmmcyF/dfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5TelAQp; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5TelAQp"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-864e4f5b253so218658241.1
        for <git@vger.kernel.org>; Thu, 06 Feb 2025 03:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738840633; x=1739445433; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MCx8c6FIZouTYR+dx2wrsyEL4qXw9rW8KBnEZC4m70Y=;
        b=K5TelAQpNrZT0o1uGYg3lFEfd/QTw5hEnigNhnej4hoI3DQGZWXwBk8MWAJ56Kpm2k
         P9CrNYr1I/hfy7jUV/K7iHAOKfEkX0VYbkDVWseB6sXb5DJhO4AZaSTvw0/4n8E8jq2r
         HAUx5J4142xheWqTyiyOOwIK3E2OLomZ3FbYcThZlNHG6D5ZVnxueWf6ue2A1e+iyCtP
         ahtvRMAzcWQuSvQi/reAiRFjcSHeA348//tvwpPmL6ox77RWK8hdgCJa5ENGCQq0qccg
         aULVIulvS6EuP8Wr4SU1bAbihxqbx7ry7cwLUSeGAjGikwpu/sJtDY+cgcaU/ebiw8yH
         2W+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738840633; x=1739445433;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MCx8c6FIZouTYR+dx2wrsyEL4qXw9rW8KBnEZC4m70Y=;
        b=Er6blNDyw/zCojCSH65WmA4uQSgAuCLZXxulki0bwRcHnacWRPs7Ckec2a5lyqNygf
         m/hp3sEJdQECOVBPzMDXWqHX0wWLjIF9v0Jd3sFtUctwUFkq4rUeBHVDO9SVU4AFFoSn
         5wAA3GLqhB+dKoyUatBQsNEFkNmeNDNvFttsFb53LAIy8BRtZBgJ/VYaJvQFIG1AaX19
         w0g4Dls3UfhXnSD4NEPR1VXaLV//b02A8mkvZpl5YPfvQ/QWr1CxLQvCxjPdZU+zZZfU
         fEyvuRJP0hyeVGB9ftmLnA6qGjycYm4TUvcGYQMUIjyK0gw6Nyj+TPjWwzc0APnRZ1/e
         wtYg==
X-Forwarded-Encrypted: i=1; AJvYcCWRYvHvMiw82Gh8imkjBseL7SYLR2LLrILl5L3fOsiRDcp/jchmsqv9GNMH6MMCohHRdSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4dGD9YC1Nt+Rp329U3c3Ov78/QVYhD7QwQRJoHxvn/zrbQ8Mh
	EYywdaNd+coQzeYtT+YfAbMfpOzoCEgMkWSqbERFgo+KmgP0ppXm6SpD9wp5Bk0dQvuMnamCKLe
	o60jL/kq4b9lT18x1shZwBG2+0cm4F749
X-Gm-Gg: ASbGnctZGVTuuoiJY3o1U9ZnhStOoaQwNvUxrXbPFnzbwgCPNDhjwTvTs23GaYmml7i
	gNV9jv52Kn6v05s/G+u4wRQLNPFV0ZgX5RnVweIMEbjzxbl+9PnLto2qvU0F8GOdEHzYtL55sUd
	tWUyS7bvsxECt4I63XZ6pqYw4ElnY9CA4=
X-Google-Smtp-Source: AGHT+IEJDwY1ezDLWduK7mhGUcd+zXbuZqbV4bpm+j54Uqp9VlQ6VILfRLYUwIIj58kKaY+M4ws5OhvkRSfenX3Xxf4=
X-Received: by 2002:a05:6102:d93:b0:4b9:c326:f992 with SMTP id
 ada2fe7eead31-4ba47a694fcmr3656347137.20.1738840633582; Thu, 06 Feb 2025
 03:17:13 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Feb 2025 03:17:12 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250206-b4-pks-path-drop-the-repository-v1-1-4e77f0313206@pks.im>
References: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
 <20250206-b4-pks-path-drop-the-repository-v1-1-4e77f0313206@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 6 Feb 2025 03:17:12 -0800
X-Gm-Features: AWEUYZmmsv2XGHlJ35HmEJGDs3Ro9o9mKZMvycLj-d498XxbEAlOaAG9mSXfrfM
Message-ID: <CAOLa=ZRSSnqRO_=N-sVrYSRpCZkyW0KFh5=rwX0NY_VqyzKz3A@mail.gmail.com>
Subject: Re: [PATCH 01/16] path: refactor `repo_common_path()` family of functions
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000494c80062d776241"

--000000000000494c80062d776241
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> diff --git a/path.c b/path.c
> index 07964f5d32..273b649e00 100644
> --- a/path.c
> +++ b/path.c
> @@ -414,7 +414,7 @@ static void strbuf_worktree_gitdir(struct strbuf *buf,
>  	else if (!wt->id)
>  		strbuf_addstr(buf, repo->commondir);
>  	else
> -		strbuf_git_common_path(buf, repo, "worktrees/%s", wt->id);
> +		repo_common_path_append(repo, buf, "worktrees/%s", wt->id);

This is the only place we replace `strbuf_git_common_path` with
`repo_common_path_append`, whereas other places it is
`repo_common_path_replace`. I assume that is because in those places the
buf is newly initialized.

[snip]

Rest of the patch looks good!

--000000000000494c80062d776241
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 816a976185064152_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1la21qWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meGZtQy80eTk4U1Q0L3l4RlJYVmZVTGdycmJPQWNBUwpFbnNsV3hJWlZF
SDNiTGJHeDNoRytUN1NqQlp5QU9uYlliaFlPUHJJQmtXc1kvMHNlVDlMcEp3Rlk2U2ZTclM5CkpB
NzM1UjVYZkVrWnBoVTFGWjVNRkNLN3RHc1ZGQTRIQVc4Vmt5Yy96TGkwcWxtL1hlS040NnFqMVQz
VkRScnoKeGllWGxxZzB1WVMrbUcxc1pKZkl1dkwvR3FmRGQ4ZTc3QkhtS0tOekc1alFibDM1K3BJ
YWFKU1N4ajZiQ1dHTwpkVkZKTURES0dnam1MU2VFdmhUaEhYM1hrZlZIWWpIUHgzODlsYkxmQWZj
WEFlejRlQzRyeWJjcFFCbW5CTmtYCmRIUldUelJGeFQrek9jeHY0MFM0SFpvS3lObTBPUTFodFR2
U2h5OE93bVBlVU9uVTBLMms5WFNHNktCUXpiVXMKU2gvU1BQaDdOOTkrM0xoaGcyQlpOVWJlYnUv
V1RHNStHU2p2NFRaMDJrekZ4Z0dTLzB1VmFNVmFKRms1d0NpZgpzVjltTHVneE1nREJ3YmZNU0xW
a2t5clpGRjNHaXluV0lsdVZyWnpEWGpBQVEzMmJjQ3MvS2g3OC8xSFlrQ0tOClJvdEdQMElCOFhw
ZkJNdkw0N3AvMFlOR2prNjV1ZXQ2dVZTVU5LMD0KPTNiakwKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000494c80062d776241--

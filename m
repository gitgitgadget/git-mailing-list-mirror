Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842751D86F2
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 09:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739351223; cv=none; b=QiindgOmKWHOPmrTfDPEUv2q9v5vZUsnnmWIQxciieK5DSU0uQmWJr0ThkrblDXk/edlVNQFt0XqcrIoxVYlBYbnfIAhidWVU+2/DOen8seJC3IXIobMA6aq2I5zuc+DzLGn/ufRTAFbofwQP+jYZNwIRyeHRb/KVMKaIwd5E9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739351223; c=relaxed/simple;
	bh=P2Yz3BVkAEy+OKo23SmaHSP29BxjNmATPsZ+j2G+teQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rw5jHBMSyNTc8a4Kp32i0JO/nBK5bu/jkWva72FInyMOXLYqonbHxr7lUT960co/yQ+hZNeabVD+BbSS9tiurM6xivTObxLyyJnXb2gNSeA43ubVB+mEy3Zhx6mo8QVVkW82BxnupQO9+e1r9ppXGup7RwruCo+GzteMwNmiOYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGayAJFi; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGayAJFi"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4b68cb2abacso1679537137.3
        for <git@vger.kernel.org>; Wed, 12 Feb 2025 01:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739351220; x=1739956020; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MdWqanWDhwSyHwcJ+Rq64BS+aZXo/6ra3BODaxqw3Uo=;
        b=JGayAJFiGqVsjgUN/ujs8FTASXDI8BTzoJoX+F0OZphPDBaZZp9v4dJKkmWmYAbvbV
         BBFv8DKWbeg1MxEmKfBaAdCW289AfbhOno1Zn/CuCRQutXxWkEKWcHXw6P9jOHWwDl+H
         bhSQelgzKQ3ITud/nH63R0SxgxsS7aA+KuBqC1dAZn1AOwdoIk5uto/8KUIAaGS3Fyfi
         LZbWPjFQE0RbAI1lyqoo+GNVdiQg8wKQV8RclNkSVwt7RF531FygayA1CAymET2B0tf3
         QmEo/laBoIGiVa6mkmcJLAoBVlHbSzQQyHJNw2jFTBKsb40Z333Yf3ePPGQJci21c5/R
         Tk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739351220; x=1739956020;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MdWqanWDhwSyHwcJ+Rq64BS+aZXo/6ra3BODaxqw3Uo=;
        b=k6OHk8OZkzhpUiSh/D99GyuIfUYlsPNzHezvL1fpu0GoT2Q0Vot7wD1XE39FehDUc4
         +LL5xTtt6+jWo7YOxrq76RKaJnRoNzAiAd5bDZGzrX8zHgmuNPjZ1i0iTaswsuTRSbJT
         EHTM2oKOmKETT+xLS+cl6TRNOqcjBs+JRq40cmIj/TYvfwwufHxQaTm7G5WTbwgLSkX6
         T1LVOcjglRtNf09Lfcx01GR2V+0sAFbNnhu2ZC3xo7WYa4j8xJv5ctYp3RXG1nITAMC1
         pW88Bxg1Yy4W8XPuNx4Bs7AwVZTLSB/oQ600Ztj1+Vuemfxck07Q8F1um6HVzW23WFOA
         JWSA==
X-Forwarded-Encrypted: i=1; AJvYcCVcwh7srvNOeMUKSx3E2UBbcrgkB8JtiqmwW/v2j0wSvFGozPlsW926nUDxzfuKMgOT2b8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWAmK9Wuj/OblMOZQqL2kvrQiRDAdExMfbQU/C+y+VuPypBdvD
	F1c4Lzv8Mp1B5oulHHdKq1CgVv1pXSvD6YtpgPr0vKyRytzGtnm0HNcEcsJKXnMg/lGb14DKuKv
	eF21eNKR//F1JjchsrRS1C2YAnOc=
X-Gm-Gg: ASbGncshTJn4+TgutSsOWtLqr7xOgGbDm7o091OtZ8CO4zFmpqwD9ouZzAtqKART9Pe
	s6Z4dJ3Z9WWYtc+3O0YRrmw4ZPMXAhHJaQX/0fmLNy1seeITC2iJ3/6EYbWQxpRH+vOmFzfy4Uj
	ZmWS4wQW/pVRI6/A0kLFVad0fLRQqDjbs=
X-Google-Smtp-Source: AGHT+IFHr1i3IKtD48/XCWeNXAMsIS2NN5/y2VpRRVWR/B6gakj7pa6+nVwhpTqcIqUZ8Jmh0UA/dM+i45twgw+jdyc=
X-Received: by 2002:a05:6102:2ad1:b0:4bb:ecb9:b34f with SMTP id
 ada2fe7eead31-4bbf22267e8mr1794375137.14.1739351220271; Wed, 12 Feb 2025
 01:07:00 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Feb 2025 01:06:59 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250212041825.2455031-2-jltobler@gmail.com>
References: <20241213042312.2890841-1-jltobler@gmail.com> <20250212041825.2455031-1-jltobler@gmail.com>
 <20250212041825.2455031-2-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 12 Feb 2025 01:06:59 -0800
X-Gm-Features: AWEUYZk8fGerY_fckNvvSEdyObQWJ0ia5OsYRHsf-wlglUkT9H0fb5ppTDKTCKk
Message-ID: <CAOLa=ZRssYP8U+kyTYdUY_-WGCLLk4mVxQRbgu87g7AdxPJbZw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] diff: return diff_filepair from diff queue helpers
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Cc: peff@peff.net
Content-Type: multipart/mixed; boundary="0000000000009fe813062dee4329"

--0000000000009fe813062dee4329
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> The `diff_addremove()` and `diff_change()` functions setup and queue
> diffs, but do not return the `diff_filepair` added to the queue. In a
> subsequent commit, modifications to `diff_filepair` need to take place
> in certain cases after being queued.
>
> Split out the queuing operations into `diff_filepair_addremove()` and
> `diff_filepair_change()` which also return a handle to the queued
> `diff_filepair`.
>

This patch keeps `diff_addremove()` and `diff_change()` while
introducing two new functions which return the `diff_filepair`. Just a
thought, why not replace them? The users `diff_addremove()` and
`diff_change()` could simply call the new functions and ignore the
return value?

This would be messy if there were a lot of users of `diff_addremove()`
and `diff_change()`, but I only see a few callers. Wouldn't it be
cleaner to just replace?

The patch looks good to me otherwise.

[snip]

> diff --git a/diff.h b/diff.h
> index 0a566f5531..6ea63f01e7 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -508,6 +508,21 @@ void diff_set_default_prefix(struct diff_options *options);
>
>  int diff_can_quit_early(struct diff_options *);
>
> +struct diff_filepair *diff_filepair_addremove(struct diff_options *,
> +					      int addremove, unsigned mode,
> +					      const struct object_id *oid,
> +					      int oid_valid, const char *fullpath,
> +					      unsigned dirty_submodule);
> +
> +struct diff_filepair *diff_filepair_change(struct diff_options *,
> +					   unsigned mode1, unsigned mode2,
> +					   const struct object_id *old_oid,
> +					   const struct object_id *new_oid,
> +					   int old_oid_valid, int new_oid_valid,
> +					   const char *fullpath,
> +					   unsigned dirty_submodule1,
> +					   unsigned dirty_submodule2);
> +

Nit: would be nice to have some comments to describe what these
functions do.

>  void diff_addremove(struct diff_options *,
>  		    int addremove,
>  		    unsigned mode,
> --
> 2.48.1

--0000000000009fe813062dee4329
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 51b814b8a62ac8fc_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lc1pMSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMTFrQy85MWpvaWZkbTZXN1dlcklzQWFCWEh0QWx4TQo3OEhkR3hWTm9q
TmR1MFpDTXJaOE5ZZE1CNWJqY09wWVhoRXEyaWNQYWF2d21SSzZGWkRqZFpsZG50d2Y0ZnZnCmVk
eWovajFsZ2cva3pvRGNubWxRN1Qza2Fpc1YxZC82S25FcEJKcDRuZVJCcTFVWExYS2VyZC9OaTVL
ODBqVUEKTTRhTzVmUkd0eHRXZVhWRzFuN0o2NFRwY0oyclFBSkFnbDIwNy9HY2E5OEJ1eDlhTXM1
YU5hYTE2SGlvSlZkTAprdDc4Nmc2eTRDZFNOUVNzbVBCeUU3dGxPOVBTMHpmQmptMVM0ZHNpbnVv
MzdjNkRHL2lYd1c1L2RvTnVYU3FxCkl4Y1B2dGJPZnRPNStucG9nNWxDN2xMUTVjQ0JESjNJamhu
N29QeC9xQUt1MGFQU3grVFpIV2h1ZlJoZUxWMk4KVE5HcWQvMCtsRGhlaStGd1FaL0cwdXNXNkNn
b0htR2diQkl3UEVTUjdQMEVMdE9iY1hUeS9QazhQM2RWWDhkZQpyblFwblM2ZSt2S1hwaTN2bk1s
d081WG0xcEcrU0VzaEVHbTFWblJqSXdQVngvVC9sMzRGSmsxcGRlQmx0dEdTClZISjNQajROeGlE
aEdDSHhSZE5tUTZUayt5aDdGTUdNcG9tcmk3Yz0KPWhiSmwKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009fe813062dee4329--

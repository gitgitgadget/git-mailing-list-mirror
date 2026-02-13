Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4F036215F
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770993923; cv=pass; b=Yy14JklICZ1VOs6RptHAbzt1vG4XWgVV3YoHoJttnHC3oYNL8S7v5IoSeMCUZuI3vpILrrZPg7LlRsig71XGMUYH80CvHGJ6b2JGTKeGVmemp49oPz1e/fxup4wNRvlN2UsDqi+ScoIvxaM4XAI1bZF64hrdzA9i1EJSpOhRkuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770993923; c=relaxed/simple;
	bh=EA6EriHpQWtuyMgglXGeKaclfdo/jk+Xr97NYO6Xp54=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZlaeEn5Aqa9yvkGc5euZ/Gn4W1wDAECfhHGKIiROBodgMfLVKJeZCR5/4pAOSABVNBTIlKPs3u1/5PNilXO2/Tfp/sQJ7FuDzKATkcWDyzCjo0sfnmegkrsONGFLlVlXdkmnYV9UatgQ5ZcwuD/UhErc39m7M/TMb4Xf5qkg2gA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkMZy9Zt; arc=pass smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkMZy9Zt"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-948ab1c79ebso304371241.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 06:45:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770993921; cv=none;
        d=google.com; s=arc-20240605;
        b=Ujo9aMKVhpEWJwz9FNd/qnsbi6URvj4M3PDXl8h0HVdcikkJQrkj04SeP22V9MCGya
         RTK48P/l/ZfAMemegTZxVauIe6SLzqZsrpKzFYvLrOPhWZc1H98dow/+kLoMg2ZZQg9D
         FqMGZZhlFiD03Z4Ulnptxi2b/ZaJhJq3XYo2SOkf6AiyBmVAHE89PrC/emSYMvVvT5+P
         4cAHWIQrwI7Mi8iYt/VEc4c1V108m/dy2cT/76ENbHisAThlOdM/ptLNFzdk0eaO/Djs
         g/wgR3jM4aBzD0uYl9cycM0WlVMTYRg/av7pSgZaxW6Xtc78LaKew1aQHIWQl1O4X32c
         cH9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=AcooKocih7d2BlU/ONT10qajam/m42AR3S4AaSKI1YE=;
        fh=MPMvdI4OKdwoNdUqlzx/FPwWfkTJ3ZzCcYeiizfGmP8=;
        b=YwtDtA2+hKTW2sEMURfpGRInm7p5LftvKMjad97WXH0XCwmXfR+A7HwgzkwTR8KEjk
         ENRcxLc5k9tWzHu7A2NHSBe7OPufRxFnwf1fzyxCeyjXme6sfDsMp0n22LK1ayJWRI/0
         7YTr3rXx7hOW8bU3W9Rq8Q8zDmcrqRVQNgHibs6YtY4xXnHIWU7E5aLbCPKRw4K4w1iq
         rse3ekA6ITRreVug6tDBZ1bF/z7TdSMqh+7tWCvP46QbP5xCW9VeFpWp+5oEBtnIQhbN
         8SqyfCFs3s2bAQlUGB/VeBY0MCJwqw+LJIYIgzbdpHmyRtO+xUdsSh8LvPfex6KRRqbD
         OYfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770993921; x=1771598721; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AcooKocih7d2BlU/ONT10qajam/m42AR3S4AaSKI1YE=;
        b=SkMZy9ZtBLhhFVz+nMwy3RGaKzq67XmQcKOsx0YSnnSI1f01TmGoh1O2tkbV8B7Her
         dQtHY4cZdDm71pWIa04tfR9lNfa3sIQ6bWh++6bcmHC2mUxDHYEhX9LG7lGou0H2V5iK
         R2cm8bhhqauAduwUZHGgSPYEj73Rjf6PaYJCudqQuQLdQefeLwjw57iTLjhkxupbYJTg
         CUa7ag6uK69Z6ucufJt22Y5qMkNHZyAoV2sxMlJhY1vApT+1WjrOG8ZaKucuyyA6GXuB
         2s2lL0hWJoewo74etR5IBJ0yJ5UqtjG7dfgWm7zXxRt+JiCsiqvkgp8fIUkap82+YQ/6
         M++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770993921; x=1771598721;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AcooKocih7d2BlU/ONT10qajam/m42AR3S4AaSKI1YE=;
        b=ZagkIsaEGK6IxzLguuAq3CbP+8Yf+IYa8KZLsdwTianqC9c/9/TR/ujVoMdIOQZSF7
         oo80w30Rq75p73bgwG+sU391cy85Oh4QpaSaKtwOpLSQemUxf+wuDJ8Es0meoCYjpMrk
         XjWv3a3X4UtaoZgNmqa2Ujp3OEjJX6UveraqBinf6WNJ8EEHAytnW7u/L7/xnPN7iJTu
         xSuHBkd17CGIx6yxf2QTRs+SlxO2brmY7oaDWLP8lYVFbs5E6gs8YVWvgSN4y2d0+mLC
         FBaRQIGptNiBJ43EDQ1DmTgMl5zfZ+AK+tHTi1S2WuC0HNjzpIpat/8Pm4eQrtt3SOgW
         QLPw==
X-Gm-Message-State: AOJu0YwUeENCZr29sCcPga1dZbxIybV6tswPZEjB1NDEgY+HrtrC05MD
	0wHxCpXaCIgKIuxJzOAO0tvHmT5QV9mIDdkb7G78H3VRXCj7GMaSQRSjNdDHZS26TvZnVmZpRt5
	2fhU2B+BaeG2iK7u50wu8B5HgQ07GIwKDRZPZ
X-Gm-Gg: AZuq6aJOIfcWAgDRKckg+WspRBPY99QH0JrSeIov+ATKYuVidoC6yZpvWs7F/tILWvY
	bEe+Mx8l2FQxgULPxcgzW39UhraoaYQ+joKFCntSkAaIv16r40uSpQ2wT9EhvldFFe1/e9bWu+b
	EFt0fgATfA6DS6b5tFykzWHmNrZLoiNXbbKcBqYCV6Fpip7RIs9J0S7dVk2tWoaEbjE8uvNM7b+
	eJg6vXcFnHiaMzkaMRdKiCJrybfyfBXQeZ65dWkCQj6uTxg7x1kDUcxHO/GADaAysCbrsVjNG+e
	TnuiE0HgBBFLzAesx1iZd5QcQlQEfcuXq4uDuMYZNzYsl1wKZ61o
X-Received: by 2002:a05:6102:ccb:b0:5f1:b9bd:ab9f with SMTP id
 ada2fe7eead31-5fe16ee23aamr905918137.21.1770993921122; Fri, 13 Feb 2026
 06:45:21 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Feb 2026 06:45:20 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Feb 2026 06:45:20 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260210224654.GA1837132@coredump.intra.peff.net>
References: <20260209-kn-alternate-ref-dir-v5-0-740899834ceb@gmail.com>
 <20260209-kn-alternate-ref-dir-v5-2-740899834ceb@gmail.com> <20260210224654.GA1837132@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 13 Feb 2026 06:45:20 -0800
X-Gm-Features: AZwV_QgaJgoGda4Ok42Cb696LoX2LfiXz1kJXb3SUtHOHi6fd4Dpf24R8_mYLAU
Message-ID: <CAOLa=ZQdYVO8wJxs_e-6FR7x_zOJnTNTwAVm1sHv23pnDYKnug@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] refs: forward and use the reference storage payload
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, 
	gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000918c1f064ab5a716"

--000000000000918c1f064ab5a716
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Mon, Feb 09, 2026 at 04:58:19PM +0100, Karthik Nayak wrote:
>
>> +	if (*is_worktree) {
>> +		char *wt_id = strrchr(gitdir, '/') + 1;
>> +		strbuf_addf(refdir, "/worktrees/%s", wt_id);
>> +	}
>
> This is another instance where the new version of glibc will complain
> about const-ness. The wt_id variable can just be marked as const.
>

Thanks, will amend.

> (This and the other one I pointed out are the only two cases in your
> series).
>
> BTW, is it possible to have a gitdir string without a slash in it? I
> guess not if it is absolute, but I didn't look at the caller to see if
> that is always true. Anyway, I wonder if we should be checking the
> result of strrchr() here.
>
> -Peff

Since this is called during the ref store initialization and that value
is generally set via:

1. `repo->gitdir`: Which is resolved to an absolute path
2. `repo->commondir`: Which is user input, can be without slash
3. `worktree dir`: Should contain a slash
4. `submodule dir`: Should contain a slash
5. `refs migration dir`: Should contain a slash

But even with this, Gits understanding of linked worktrees are that they
are in a `$gitdir/worktrees/$wt_id`. So it should be safe to do this.
Nevertheless, I'll add in a check.

--000000000000918c1f064ab5a716
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 45d7e6f3240ee71b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tUE9QNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMy9tREFDUmJJcGhJekRFL3NjeEFoYnhmajNjNUhjRgp6VU9xSjR1dHp1
eWQrMkUwSFZPUU1BaXNxYTh3VGlENGZwVEVVa0dPVithTlM3cUp2eFVDVmF3dW1iZGlCY3dxCkJ1
RGZpY2xXR25LcUkxRVVSYnNwQ0tHRDVFclIvNHhrYno2c3c3bGR6a3EvVTQwaE1CUkYzMVF5cVUv
TGV3SHoKYWRxZFVkcVFQaFlBbm8vczJENzhsczhHUEp6KzZmL0REanlWK3I3TFNJRlkyZ0JVUmVS
c3ZmcklsY1NGRVlNRgpuS1h4YkxaUDJzaG8vVjBrcmo2dEVtZjVkek9nNmF1UVYzS1FGUEhtQjM3
OFBPeWpsamh4b0JFOGphczdPN2M2CnNqU1hRMlhXMm85MlNuSlpKSVZGYkdnc3NsSWN0QVVUcEZh
VWl0NGJVK2g1a1ZIYytQbitFSVgxV2JrbVc4TkEKcTFEa0VuTDlEOXl3b29kMFVWNVB1ZmNxQ2tK
YU9ZWFFnRERHczNlUHlaeVAxd3hleWV5MWc3MWdsby9UUEFXYQpzMDhJUkc4M0Q1SVRHVmRGRHdS
T2VxZ2ZDNk9QVGFoc1I5ekZlRzhFQ3YvSEZVb2ZpUTY2Mmp3cDRKRU1SY3EwCkQ5Mng2R2puV0sy
OW1wSmlkdmExbXduR3pGWTc2US9JRWVhTldBZz0KPWFpaTIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000918c1f064ab5a716--

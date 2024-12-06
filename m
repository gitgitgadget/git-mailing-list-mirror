Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB0E1BDA97
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 11:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733485648; cv=none; b=u40e1TXlDKsoj+Uk4Keft7NEWArVNCcL8vgjmM03fl24slyK/fnfs5tdVwTi6i2/9Jl/PokX/8ESOLNK5lkgb5mFU/hdajrsO/P4ZTmU68w/Iv5ucxPQgtESbivj/3t5B9ySijspHN0N/bSNsEh8phwvQuIS7qV/ZekB+t4NX7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733485648; c=relaxed/simple;
	bh=NH+qENIpwN4fmydIdUfi7TDhrW/W5rz+xggdIIJO4fs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=D8WHanmLz2OOkp8QyycDUMuVdHX8HWib7KT7uDDVY7QAUkXh8RS1lo3nlTvp1FYzt3I8olHifvnqhmcCXfqW4YNvQQU5Dmw3iaCKZ0ENkLkURYRexvq3Or4IyWyyP4x983KDycXLXS5Bao9Qh23D2NnrSTlrphSjx8QmTJilQFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbC9KN1D; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbC9KN1D"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4afccfd925fso345988137.1
        for <git@vger.kernel.org>; Fri, 06 Dec 2024 03:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733485646; x=1734090446; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7GoV9i72uVQepKRbrPu4BfaQVJ3GL5pcDY6sv2dkEOg=;
        b=XbC9KN1Dl54b+wqQ2Lx+Jx66l0lqHWEhyud59YAs6opjJ87Yb66m9llsL/eLztGsEG
         u9QFLAUm6wuBxvP4tari5Zd3ZrBniAIZAkiShckAptw7RjgAOcyNLPsISAFf8uz2ThFf
         PAUiTbGA43JNux/vfrVPNeeYIi3KW7oMx6xlu6MX8d4SUIwgCyqVszGaEoFm8ghB9pKc
         o/3Z77AXpnHdexBw6KrACrmjk+t7rwhUE1e22rN0nETVNECziFXm1ruQjIUyWL5sEu19
         u0BoxMcPbCtaRnqvdN+J9n2+LIusYFgvvK8wxaXvNe9e8sR+OEIt3+mRdS49vaHknfjM
         QNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733485646; x=1734090446;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7GoV9i72uVQepKRbrPu4BfaQVJ3GL5pcDY6sv2dkEOg=;
        b=fgfuyjX6QDzcA/b1k1vRvra2tJCWM1+suO0sNp2YXmH+vXwTF1KdEvq1uxXITsmNOU
         1mpAJaopPbQzzAHTdAvEm5sSunYKTReDonE8nL14fypeBb3NJXZXxXzhfpkBJfTZqosq
         cixL7IdjdUWt/9gzBg992/0rg2qZ3P6JneSjrxy0AmzO4O4eJ3T9P/Di5W2CmTNxPW8u
         K7C8vLFNFo96IsI9DlhASi334PosnVL5h9XpPw9IhzuTfypZb7A3aCtU9wUsyIesNULr
         Fwlka+4wR4XQU9/yPzgal4xGmawc/m6otDJJSdBoDHEmboY2YTdnQJSs52iFibU3XPtB
         K4cA==
X-Forwarded-Encrypted: i=1; AJvYcCUROlVMDPbvhUCfMO7CR+M++mQXYbsskdgX7bHw3je7toVlhrL3K3YMnr93GdCr/D4b84c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKYGIWuH9APnEb6GjmjoOGWHgG/AZwRPAukVSmSOTN8KURYVou
	/hetEB1bWkX8xWfHZC3e3Mlw2YrR9TqCTxiaviedNQ9LOVU/ZyjVO+6Bz1ryRAYEZXs867LGJEY
	kRKv0hG525rfighm8UYJI4WFBpHs5q3LI
X-Gm-Gg: ASbGncthlKFWubGPl4l1olRtIy0I8LCe3QdjFM2gPEw0BrKAwrv3Q6/oa8QwwW4W7ZB
	UVDwG6lQZa9wkyqNCn0c8UKLw2gQHag==
X-Google-Smtp-Source: AGHT+IEdMbIF+48AEyCUJ0KQOoZDHlKXZBbpdEE8+coFERmTYdZZ4tkkmQ6qeUvOu6mAYs+G6oOmkk0fL76vjK7Yl4c=
X-Received: by 2002:a67:f511:0:b0:4af:d263:de23 with SMTP id
 ada2fe7eead31-4afd263e057mr325147137.9.1733485645759; Fri, 06 Dec 2024
 03:47:25 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 Dec 2024 03:47:25 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <20241206-pks-ci-section-fixes-v1-0-7ab1b69e3648@pks.im>
References: <20241206-pks-ci-section-fixes-v1-0-7ab1b69e3648@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 6 Dec 2024 03:47:25 -0800
Message-ID: <CAOLa=ZQeRWHog4Fjkb4MgK_34kV5JVEp4yAQ7Obgx6cnDJgyAA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Random improvements to GitLab CI
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000023aae8062898942e"

--00000000000023aae8062898942e
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this small patch series includes a couple of more-or-less random
> improvements to GitLab CI.
>

Apart from one suggestion(?) in the first commit, I think the series
looks great! Thanks

> Thanks!
>
> Patrick
>
> ---
> Patrick Steinhardt (4):
>       gitlab-ci: update macOS images to Sonoma
>       ci/lib: remove duplicate trap to end "CI setup" group
>       ci/lib: use echo instead of printf to set up sections
>       ci/lib: fix "CI setup" sections with GitLab CI
>
>  .gitlab-ci.yml | 4 ++--
>  ci/lib.sh      | 9 ++++-----
>  2 files changed, 6 insertions(+), 7 deletions(-)
>
>
> ---
> base-commit: e66fd72e972df760a53c3d6da023c17adfc426d6
> change-id: 20241206-pks-ci-section-fixes-1bb91ceb50b8

--00000000000023aae8062898942e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: bf88ecd8d6b8115e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kUzVFd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMFd6Qy85NGl0dUNvakZEckhkUWwrc2xtM3haZ1cvegpOcmtaeXBtNFJi
MlRTUkE3dFM2KzBUa05lUkg5WjgwVkd6Y3JpY2xwMGw2ZHpPcVRIUHZBVFB1K0VJRGhRWjVOCjdM
dUlsMDlEU051Rm93NlpMRnlJcHNMbmZDM0REMUNLQldxVlF2Qk9jdE1JbGYxZFg4bUUwcDcwNGNH
MmQ5UUoKYkNOM3lTZGpRbmc3ZGxGenQ3WlMvWm9ZMWl0T3VHUzNZQnRqYVkyM2dFbEJDR1FZU2th
a0dPUzBoMFNMdTN5VQpWVHdOZEJJNU1pNk9FZ2dQNW8xQm1xL3ZmZFFwMEN5cHdoRTVhU214YXBa
RjBxdUY4RFNaeTV0aWNDd2F5TTBSCk0rUmxENHJlcFNXRDlLL0liZnIvaHBZVWJldDhsK1ZkdHRI
UTR0ZE15cStlRnNTMlZDVTd6MnNCWVU5T1NXd0QKQmlEelIramx1dWU1Z3FhUWhjUnVlbm5uT3ph
MW12U0ZFc0lCWEk2QmxjTjF2ckdYTlQ1TGlYZXo0QXlzMjFXbApXMmo1eENKZE9aQkZMek1XclhY
bkFSK3ArMzlsTCtvYm55S1BicVVSdnJQSDdRWlI2OGpUTU9vYnJDeStSTmNDCkxDY3g0Ykc1VU1O
aUlMYy8xVm54d1Z4ZC83emx0YllhMXhaVUVObz0KPUhzMHAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000023aae8062898942e--

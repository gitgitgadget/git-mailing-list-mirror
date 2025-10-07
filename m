Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EE72135C5
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 12:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759841644; cv=none; b=JBM3kxD29/ngWD7RGWRlswxZGK/QEvvQQZPpgdhAs6EAjKrwvRfgkBWpeFmpf2tLfZvknHgXl8ZnAf0av0OzFACHHWxzP4hwSp1g+BBeZ3Nwx1xdp+oPgf6DezV6Ak1WneEEmfcIcXlwL88YAAblujI0c9jHhkYET9oodd4kMzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759841644; c=relaxed/simple;
	bh=jUO4S+B0p+1hONIuGi+OxmOxQ0m96No/QmAi0A9JVAE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6H2m+NDPc6o49MHWieCWoNWsRoGIbqnL8KCYQs8ZdnSN3VcqTcfJ5Loe+QcBUfmAKdoqrx3kZE/eBw02NTzipPq/4/wL7fpV/m9oEZnpx2KBhsQv9IXtn/dgZ/GeARNBxsOO0rFqR2ouzMmxuxgxlFnXpvhT8cJyjrRN+yIh48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MiXciMxY; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiXciMxY"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5d128733742so2695069137.3
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 05:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759841641; x=1760446441; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jUO4S+B0p+1hONIuGi+OxmOxQ0m96No/QmAi0A9JVAE=;
        b=MiXciMxYOAapihFVGjEFhT3IvmssvGSVpHk8WHpbIVaFag8SsANNSyy+OJHrBH97lL
         1CEI5koHtT7zF+6oNXLE6/qTsGs8UtVzl7GEF7xUY2dJ1vDe+6+NPoz1t9eita+kv62K
         xiMqKtUiDUq/KWxq8i0rw3c3lzDbl6rp7emf4AqV+bhJ6mxairrJk5NsqHG6lc+ebpPE
         WvQBS5t0C/Y/CEcEo4J3pnWO8YYw6/GodgYmia0kteEZ5fBs8M6GLJCvQBAS+Beph6nk
         b8Pjmp4qpwZDEBBPeBy5FGHxpbzJ1tAXIi7rEUNT65U9QEm0SJSCT2Iq7uA167gwS9TU
         CTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759841641; x=1760446441;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jUO4S+B0p+1hONIuGi+OxmOxQ0m96No/QmAi0A9JVAE=;
        b=FEOG4HP+IcCcf66gA/ZaF0XzN+lhqWEwWNs/c1h8WNO6spX36lbsUOFG5GJl3VmrL1
         d1JUDWD6gAe9Nn8qB7eNwFjJmKmSH37hmeqcaVg0TEVSCMaLmuzEkvwXWJfmH7+JZS+b
         77/xOOEkliZvwdjeNH510zlbPVjpZ2D7Aw7RUJYUZ+LYdQPX8QZN+iyye1k+KamGGICe
         AYyiSfohOViKKdoieqFckobAqUOpg8B40bLNBGQDfqxaUB8eVHQ8xfBNphOcHd1px7Wx
         QmFUIPoigNcf9NE6hAZsjReMUXCjb3OcRHOjj4CafUfTwD2/Fsj/RVCNT0vWn2DEk3yv
         Y13w==
X-Forwarded-Encrypted: i=1; AJvYcCV/E/JyZfVzEjcP6M8BBGdHIBLbVeQshrHN245LVXh9xCI6VX/33iPqtu6ey45ugELR34M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8OddKH8afstyJKsHYmef5W3Z6iHQn+c5YbBashVWrMxnyewgm
	JM7QKuEQtRnYe8ute8jBTPavE8zgRoq0YoVilh5Rp7zo9MN7mBXxVKRDsEwE/8SzmnwYqI6xEQW
	hGXx/Gg08zOL83NKPR0Yu1cvJOA8ZCI8=
X-Gm-Gg: ASbGncv9YxbYsxVsgn4Hslh42LPgnVNNVzsc+ZkkdjKNeKzA5FNnlMjeJE5K/7eQXfK
	rtiE4NMzrEdQjm9auRikrwzUYJg3bOFusKP5Wy94wX4MDoAqWdQyLDoJH2HjC7f9Wama8pMKS8B
	SLEdBgI4NkPs1kROJK2Cd6PCo+WbsqLYActxtMYDZmyvVfbh1Mq2ocY/xcc37pEssPztp7Jf8L1
	/a/ZSCr36FRoJsbgICWw5IlyIQWAVa3SfbFyiZ/h18ci5IzVwyWtpKK/He9aA==
X-Google-Smtp-Source: AGHT+IHN9OnAaHRqcxGoAofyjTW9kr+QKUh1EAfLKx8LEBx60woVfoUrLH94bLf61GTXAa8SI/b7d21xAYblLR+7llY=
X-Received: by 2002:a05:6102:80a9:b0:5d3:ff03:8f6a with SMTP id
 ada2fe7eead31-5d41d12dc77mr5467868137.30.1759841641415; Tue, 07 Oct 2025
 05:54:01 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 7 Oct 2025 05:54:00 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 7 Oct 2025 05:54:00 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20251007-b4-pks-ci-rust-v1-1-394502abe7ea@pks.im>
References: <20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im> <20251007-b4-pks-ci-rust-v1-1-394502abe7ea@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 7 Oct 2025 05:54:00 -0700
X-Gm-Features: AS18NWBHFuWcWlfhXjwp09YQcUStwe91NJ-RHRXH79hjr3m08WoimF_V2VfUIRg
Message-ID: <CAOLa=ZSatdP84CmW0TLzP00CrV02P3ahmXBCp_HhxRYQXzry6A@mail.gmail.com>
Subject: Re: [PATCH 1/6] ci: deduplicate calls to `apt-get update`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: multipart/mixed; boundary="000000000000e690150640910fd5"

--000000000000e690150640910fd5
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When installing dependencies we first check for the distribution that is
> in use and then we check for the specific job. In the first step we
> already install all dependencies required to build and test Git, whereas
> the second step installs a couple of additional dependencies that are
> only required to perform job-specific tasks.
>
> In both steps we use `apt-get update` to update our repository sources.
> This is unecessary though: all platforms that use Aptitude would have
> already executed this command in the distro-specific step anyway.
>

Nit: s/unecessary/unnecessary

The patch looks good.

--000000000000e690150640910fd5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 852eb73386acd736_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qbERXWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mLzhNQy9vQ2dBVVUwUklrZkp4NnJyY0hlTisrSUM4UgpOVUxTRzVaYWpY
RmNuU2M1LzRGWGpqTE1QcXRQT2hhSGNqQ0c5UUhmKzd6MVVuSU9IRlp4cUZzVzRscXNPamFkCnZS
NWMxazJOaU5CT2lrbnpRaUhsQW1JK3NIaXE5L3lTbXFRWEI2Zm91eHFxSng1MDB1WDM1VXJWSzNT
WGMxRDEKT2xRRnRYTUVoQ0xCUWhTcjUvaEFFc0NqUUJWM3lkSDhLelpLd2lDOFJyNUhBMm41Mll6
alBJMWR6ZVBJUXd0aAo4YUNwVDRuc2ZOUS9HRjE4UmM2ZmVJZW5rOFNta0dHR3FtVjRESU5JWkV3
dE1yZEVrWTR3OVd6b2NmWGdseGNSCnBLVmFtOTkrREh2dTlmUWkxdFIrM0d4UlFQMHNKa2k1NUxx
M2QzZHVQZTF2bHF0Qk9iL3JqVktadk4zYzlYdXoKUDRzS25DbU05UEtGQlFPVk5LbzdvNkkzeXM2
MXhYWmlDNWMxSFhDMVdWNXoxMk1aQ2VqZTlxVzlYQndBYUxkcwpUN1RsRmlwSlZzZVE1UHZXZnZl
ZU5rSW1zZFdEc1lZY1JlOGthVjJ1eVhoTDc0Ly9tT3dlRExBYzBXd0MyNUhsCkt2dm1HM0trRVBi
eHdIcTkxY2dXQTFrcWVyTWxucE1uUTVEN3Ztcz0KPWpQZ0YKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e690150640910fd5--

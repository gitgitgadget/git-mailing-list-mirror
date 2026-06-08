Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43282609DC
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931351; cv=pass; b=mdaxGIhRfbQ1CV6z5GiCYZ1Kc8oTewFxaqDAJ9Elxt/qgpn2HHiTQbRA+JpJObNzGFwyCseLixag7cWRozR+wgi7Lzpdk9pn8baJvpFO4rN+fyeHx1J5z9ELJeTaUoYLDXRKynhT/FLX7TXA4ITXp7yCr8WM1vXukYTeLKCExig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931351; c=relaxed/simple;
	bh=yoa4TCPoSOkKydwD2+rDvtAuQ/mSPycndbDdnsFyg9s=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=cZPeDhc0FDmrUOKQYGXy0N5U/aI9cS41Vq/69E7nU0DBQGzvity4vudRrkt4U6tmxCQzlBSvP7TEpjTKp497jfwPCXtrYKQ1vFcv4109IBGkeh61b1ZMvEwWKImjmmkH31PSF6K14DBJeZPd6i6NhirHhPADncVTBlDBtatUu1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmQL4a5B; arc=pass smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmQL4a5B"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-6c25b040554so2460879137.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 08:09:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780931349; cv=none;
        d=google.com; s=arc-20240605;
        b=VA7TuQHC1e+yZDlMpsM6Bd5guZzVaMpwXAPm2ptj+9PKWMLupJTx8ISy9haSVIETLy
         km3PRkIR0OZlo3o1qVJ24r5v2wcaF3Ij0BpBvOzmv9gPAHkwSDhY5kfI2RO3O34C/Tlt
         ysUUB0V1JViLT7VGv83ZLb2w4BQY+Pd6yKuncIUo42L5KSRxGR3KAQdPilxQhyFglFlH
         AVqbWPPTT+eDImnwchmV3ZsbePDxg8C+FiRK0Wy2AA+VUP09ZtSiwnP5EQiV+ZVA0crD
         WXOdwCPALrWOLiV3yphHfwFg+Edsr0TVA8zI3Pqjfe1/NBTG3nJ+i7dkDvh7D94wtWqU
         KiBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=d5HRuJC2FQN+OaF1Q8i99mSo+aRkHB4r0ZZzKcSdpdw=;
        fh=5lJFebYbVoPTPqtpHTGAscSIHy0y+1Pzj9xFNDN/G78=;
        b=Ubtu7UkXiwJgQd4V0J0XAyfS29fuB3O3GicT4nao6L4JUZoRA/oJ8opCcgp1xHhqw8
         1ryKD6Q30f++P9d/T+aIpUe1zYZwcd313DYAgAy4AqLBPtBlfucj7FXYm/MWVvo4w7tS
         qN37G2/1JVw2UPkjh9zSJXW9jsOJnpq1edA+J846Q+MwLcamI065d+FvP60IzBMJWrnE
         KvpLlowKSPMmZMrl28ntbdFfCTa0U3gZ/Y5+UUyP7k8QqYdsKvDTsP1i7uMYHtCQMgTW
         oXFnWgC3SiLVHJS1aWpeEUBMfKztMS/pV66sRFGQFbBwr6oBU+sQeXTGBm3cTk/HWGJu
         b6ZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780931349; x=1781536149; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d5HRuJC2FQN+OaF1Q8i99mSo+aRkHB4r0ZZzKcSdpdw=;
        b=OmQL4a5BAuDEO5uzyWexPtyWlzJkwlX8o0+aEYgCTE87Wnqv/YG6sgjRT8bn2fEhYT
         XiznPfOOYj50nQN3dVhRK2lI9RX5wxaFYrJyD+kmt0pfRrLowwzcZ5GzHqhLrG3KK8RD
         ubPt3td/v0H+tjgi+ESf53RMOp3/DSASCooxcd+Z6rlWfRsOMmWmgys+ekQS30aKoxih
         HkvZIKGBN2pwrEa9waa08iLwuPqZaPKIyiLOAbyPkTbq6eXlejQupY7R+ZiDOK1EXGnq
         6L+KFBgmtJol/AOdfVzcRZBv+TT99C2Z+USjbd1uQrfR0+uA2SuVeKSMtiai9g4IpmRG
         9CdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780931349; x=1781536149;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d5HRuJC2FQN+OaF1Q8i99mSo+aRkHB4r0ZZzKcSdpdw=;
        b=XoA4UdqlKQmDPvJWeAznLQSQprClT/aaCf0NLNu9rezE8V31nkHz+YJhRiGqglSxdL
         kq/jGszD0OaMva2O2/sBalZi/YhhO3LkhRvgjMgqq8SuaskY4feMd2D9sXxP5NvRJh2Z
         maiSppYLyVKO5cI3gD9hrzI9Fw9clOjWptUkf4H7LG4vQ3j256tX4JibxzraHqgRJ2AK
         iqvJKhZj8/GK6vD4802sqE552DpTnEjWdmIAU8cE0Vot3oGKMIUgwVhX3lLXZiISSgfS
         cWzLB6at3Se+CYDQyCVV2+NE2O0/5x6fu5ysj8RpRSmaXrQRokojqTYjWQPQIdr9hvhf
         OnKQ==
X-Forwarded-Encrypted: i=1; AFNElJ91HIX45UchuWgSjdQlLmlLTy/oZs8O+CNxQf73FYsfaFAY+bKeNmYJAEZugkmThuY0obc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7R15dSS2MHx+zqxASbTG38ChEv4QoNy5PWNfzORbrSki574X/
	XJU6lKsY8LiNm1+e8ZFg6qLc0LWeE7RDKaF9KKREvp7G89AtWghQSYBYz2bP3XV2v2zX/H0dsYD
	EPxHwvyYaK62Cyx9SOryHPf9bk8UYpSQnRA==
X-Gm-Gg: Acq92OEMceryoDADjQY4DPSxeK5VfRZ5/UpLwkdE5C1iBjsQ45YSQqfD3ZIjf2yo7pb
	khcRQBO4UrvWkg26nmqWwCVtD/PgmVE3cIlgwNHPblq6IKiQObhrtFnI1hK5YGNVcMuGXy8UJsN
	fRnY+evayfc3z9umjJ7kuppJlE2l3U4wmYyEqbCi2jpaJXfJIEH2eKDDeIE0ywRYHNzrHPLTehI
	n8kBEvOHbWDJTMtPNW4OHLC/pDYI9GSf6hWeIMOnGz+8qhI750UhpMayo+DVEopHBGoYx136xBr
	WuTEWgt9gbU8lisOBkJSPnsW2AIGOF5O8TDA5nZUAK/yQDQ4VkC3j4SSYWO/tkteY56wOPzbz5a
	F9ACkKQG9
X-Received: by 2002:a05:6102:149c:b0:631:d586:893e with SMTP id
 ada2fe7eead31-6fefa60b89cmr7867842137.5.1780931348732; Mon, 08 Jun 2026
 08:09:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jun 2026 08:09:06 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jun 2026 08:09:06 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260604-pks-odb-source-packed-v1-2-2e7ab31b4b5c@pks.im>
References: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im> <20260604-pks-odb-source-packed-v1-2-2e7ab31b4b5c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 8 Jun 2026 08:09:06 -0700
X-Gm-Features: AVVi8CfEWPyvvaQC76FqTAYTVkwjlNabfGkIo5zyGFOcECrByIyuBMNlytRVPU8
Message-ID: <CAOLa=ZQ8K53yyopSOp4_Gc-Gpq6ULA0xW6gH5OCWdWNHEyRysw@mail.gmail.com>
Subject: Re: [PATCH 02/16] packfile: move packed source into "odb/" subsystem
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000693d510653bf6447"

--000000000000693d510653bf6447
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> In subsequent patches we'll be turning `struct odb_source_packed` into a
> proper `struct odb_source`. As a first step towards this goal, move its
> struct out of "packfile.{c,h}" and into "odb/source-packed.{c,h}".
>
> This detaches the implementation of the packfile object source from the
> generic packfile code, following the same convention already used by the
> "files" and "in-memory" sources.
>

[snip]

> diff --git a/odb/source-packed.h b/odb/source-packed.h
> new file mode 100644
> index 0000000000..c17068a4f1
> --- /dev/null
> +++ b/odb/source-packed.h
> @@ -0,0 +1,80 @@
> +#ifndef ODB_SOURCE_PACKED_H
> +#define ODB_SOURCE_PACKED_H
> +
> +#include "odb/source.h"
> +#include "strmap.h"
> +
> +struct packfile_list {
> +	struct packfile_list_entry *head, *tail;
> +};
> +
> +struct packfile_list_entry {
> +	struct packfile_list_entry *next;
> +	struct packed_git *pack;
> +};
> +

So this is exposed, because outside of the odb, we also use packfiles in
the transport layer. That makes me wonder if these two structures are
better kept alonsigde `struct packed_git` in 'packfile.h'.

[snip]

The rest of the patch looks good.

--000000000000693d510653bf6447
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5c3b482d7cd718fd_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vbTJ4QVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mejk4REFDTUw2NG5VZEc5TjNSL3BNZ3JxdC9TMWtVVgpoUkRPS3V3QUNR
d0IrWVpmVmZaNzh1MCt4TEhvR0JSMUZDUEdUVjNqNis0Mmp5dkI0Uy90SE1tdmh6THp6MnY2Cmsv
MGY3clM3UjdVVE1sV2JJQ3dGcTlWS2VVa2tIMW55a28vWU9XSW5XTzV1Vk4wTDRaZ1NVeHpjOER1
WFQ4cjEKQjJKaS9NUnBoUkZiUllpRjBqWmcwb0VkRXBWRis1dEVuK2VOekZmL2JIc0ZPOWNXK05s
NitWcHRXT0t0SWduQQpQMGdYUkE1TFdsQWFlWmNIRElCTWppTmVyMkVpRmwrOGs2YTkwMFZMSjlQ
N2lzYzZ0VGtTK2lVd1V4clBSVlB5CmxtaHc5NEE1eDRSR1dZMjRSWmM2V2JCUUxVcE1nNjFrTlA5
ajdSdVMwcjRkMzlqSGtVOHd5YWsxY0xkOHpMbG4KbkszckRMbENmcTZaRGMvZUMvcDBuYUx2c3pJ
MnZUaTE1VURwdlNVMXF2SUROK2N6aXVDRzN6ZFZkYjV1Ym9yMgpvNDVMQzN2MG1uWGNRVG5yeWtL
aTI3aW9uY056b3dGODg5VytMOGY5dWpsc0ZqNFBJamwrcDMrbEhZVGVRMlZvCnY1TFRFOXFxN1BH
RjA1VXhvWC81WnZITk82ODF0TXZYT2FOUHpHRT0KPUJqTW8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000693d510653bf6447--

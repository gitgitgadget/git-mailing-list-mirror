Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B480E2EB1D
	for <git@vger.kernel.org>; Sat, 31 May 2025 21:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748727458; cv=none; b=eUTAHpf7ixAIFo9EVmqasGlk0LjxkcttQKEUkTuXubfUZTDCZkl0JLX6HRTCOTxpObIcJ8pASFmyNfajPLijzoE+lbUdkfrFJ7/TAu2KUCSVfWzYa4ywz0zhMd6x3HOwf4a9QFD8+/EcRPqX6Gr7ohemEtqL3kOANbsvhXwJ0y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748727458; c=relaxed/simple;
	bh=aQKapyvgr9Gb9NAoUxz/RXTFwyZ94uhCtF6me4ogw04=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6pfz2tvgRBu7RVtHBxRAd0iG5KMXTtnjUu7y+4eQRy1am9QATQMWmm0LHwaBMrVZFbTdLXP0Lx9S/EQR1VD/MIKgaz/Bw+m4YKXfpY2GBzsyEJ7mZ/VS4/Nvxno8mwcIP603NkrAIt5AABK/clAXnFt9BC3MSYs86AQotaa31Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bL57+f0R; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bL57+f0R"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5240764f7c1so957079e0c.2
        for <git@vger.kernel.org>; Sat, 31 May 2025 14:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748727455; x=1749332255; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Olw5KIncMoOi9CIr1Y8QpKeTCX1JSY8qlnrE3hrDXg=;
        b=bL57+f0RVpz8qdUHU93/w/ms8H7mkjVKCKr+hEXUsuVaMe4wEmd+hMsOkes8kPWYHn
         npYumbSoLqX9X2jMMw2SKeb0mdhZUimNtALJx0/xo+afpU+JpKBgGKCatYnSjwBdqW4a
         CZR6aGjXfcikUG/Uq4Yf9kEjiXcOPaZC4Mv1ij797kFTZyhbec+XlOsWjLf11p2SWhNK
         4YN14wt52fzPU7MkuJfSMmettqlsPcLIpGQaDSj8xyTE3z46hiTuz9o5I0HJVlMUxpeb
         ibNv5FYwT9vLwd5+51QKc8NGb8DrTCSyO8IPLwcAIm+88tLcQhPtUzl96idMOKN1VGtm
         dLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748727455; x=1749332255;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Olw5KIncMoOi9CIr1Y8QpKeTCX1JSY8qlnrE3hrDXg=;
        b=BNGm3ktEeWCsujX/ZNvg9kWcBJ1glg2YRfNkOdKLkDMrRSCZe9pTuy2Tk+LlRZescX
         6Cc9BBEEUcO1ET9J1+CiNb1abOdPC/1hRPxktdLGMVBOAiVE2L5ASYYVqdK88z9tFgRn
         DtAFGo+xtSskBNRiSLIcv8DaZGRyEoPf3kZIukfSqZ0BMxDYoxiJly/zKhuXPqtIieKr
         AQGDAW0EXncnkmTSNy/mwAXJoVKrk6IwUXyFnccajVyIHp8GXSZuKz+3iByv0X0rNyCe
         eze/CtCGCjvJs9KhId2pyQwK7me/PxaIX2MbKcoOCFtTDZQ5CfQnIKB4FFPXcFw1V4Ag
         RHBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmJFUpRa43JCG4e/pqiD5bLO/Ss8li2puvUMiEZVvRcqSWDgZPOrNcPAKb9xYjW3XSbyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB/3LoukfLxsEL8fDUN72bpDI+L2l+13HzqJYzFgcX+GAVQ6Z+
	cbGRWMDBX1p+l1u3lWAvLVuKg8b5fZq7kFReDIZoQ5BKcq6QB8pRK+T2eUNUCuUYHHU5GIH16Gn
	W/ICbe5RbUnAjQlOMGcTJoATA5Lfv1Ts=
X-Gm-Gg: ASbGncvwUnui+zxrrkqFdwjZfxdVYSjQdTFiQFj9zTNMw7Fn6YIw1BG5wZrq2Sb5OnC
	y8KyGxc2Qmkaj4ftj9l6A2u6Area+e216op4tO7Sv11CKItg6JL9I7ledgAarnyzjDOAmgubw7s
	BL8XvrjzrUgPLgw1Sn+IL110/T+5u6jkwtl8pBZabobEZ/lH4ynXpltdloW1hwa7BU0S7Nm9fS9
	6zkPA==
X-Google-Smtp-Source: AGHT+IHiA+6Q6YF23nhnGjzr8k1DlpZI1awsKPAtfMxLmwM9NFczTGt6OKUk9PdwAJM7BpngOg0VkmCmZ43wiBqSDpo=
X-Received: by 2002:a05:6122:1d94:b0:52f:2a3:4bd6 with SMTP id
 71dfb90a1353d-53080f8b443mr6914583e0c.3.1748727455340; Sat, 31 May 2025
 14:37:35 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 May 2025 14:37:34 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 May 2025 14:37:34 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250530-pks-meson-tap-v3-0-676f5e41f2e4@pks.im>
References: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im> <20250530-pks-meson-tap-v3-0-676f5e41f2e4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 31 May 2025 14:37:34 -0700
X-Gm-Features: AX0GCFuX8gmkF7Z3p-n21IQuQe9Lt-gQCLuBaSYA9KU6048KohjaGjXAtO71U3E
Message-ID: <CAOLa=ZQYZ-2yiTi0Fe-b0MVfTLWf3NPmDsMUj2W=APwf1eBc9w@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] meson: parse TAP output generated by our tests
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>, Eli Schwartz <eschwartz@gentoo.org>, 
	Todd Zullinger <tmz@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: multipart/mixed; boundary="000000000000c8f7ac06367556ad"

--000000000000c8f7ac06367556ad
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series starts to parse TAP output generated by our tests when
> executing them via Meson. This has the benefit that Meson starts to
> understand skipped tests and reports how many subtests have been
> executed:
>
>     ```
>     $ meson test t002*
>     ninja: Entering directory `/home/pks/Development/git/build'
>      1/10 t0024-crlf-archive                  OK              0.17s   2 subtests passed
>      2/10 t0022-crlf-rename                   OK              0.18s   2 subtests passed
>      3/10 t0029-core-unsetenvvars             SKIP            0.15s
>      4/10 t0023-crlf-am                       OK              0.18s   2 subtests passed
>      5/10 t0025-crlf-renormalize              OK              0.21s   3 subtests passed
>      6/10 t0026-eol-config                    OK              0.25s   5 subtests passed
>      7/10 t0020-crlf                          OK              0.81s   36 subtests passed
>      8/10 t0028-working-tree-encoding         OK              0.85s   22 subtests passed
>      9/10 t0021-conversion                    OK              3.45s   38 subtests passed
>     10/10 t0027-auto-crlf                     OK             26.35s   2600 subtests passed
>
>     Ok:                9
>     Fail:              0
>     Skipped:           1
>     ```
>
> This new feature is only enabled with Meson 1.8 and newer, which
> contains a bugfix that we have upstreamed [1] to make the TAP parser
> work in `meson test --interactive` mode.
>
> Despite the changes to Meson itself, this patch series also contains a
> couple of fixes for our test suite that caused us to not generate proper
> TAP output.
>
> Changes in v2:
>   - Add a patch to fix an unexpectedly passing test on macOS.
>   - A couple more fixes for broken TAP output.
>   - Link to v1: https://lore.kernel.org/r/20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im
>
> Changes in v3:
>   - Split up the patch that silences output into multiple patches and
>     rework them a bit.
>   - Remove redirect that was retained by accident from an earlier
>     version.
>   - Slight rewording of a commit message.
>   - Treat unexpected passes as failure in prove(1) and when executing
>     the test directly.
>   - Link to v2: https://lore.kernel.org/r/20250527-pks-meson-tap-v2-0-ae360f77786e@pks.im
>

Apart from some small nits from my side, I think the patch series looks
good.

- Karthik

[snip]

--000000000000c8f7ac06367556ad
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9362c3015e973901_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nN2Rwd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMWh1Qy8wYnR4dVBsTmtiMFRYa2ZadXZFVFZjUUtucQp6MkVYYXY2NzlY
anR4TStwc3Bmc2dLblhOTVZ5ZE1JaU51K2g0KzhZNHZwZ2toZHBZOCt2aVR5RWFwQmdsNG9DCjRD
SG9BVnpkTUNEaW5vRGh4ckQrallUNzM3d21WaGU4bEh4UytEc09QWnFUZDJyQ1FsWUFDdVU5THQ4
N0xNN1AKODBCVzBEUDBnVDIzOWp6akR2YVlBM2NaQkhxa2grV29SRDF4RzJ4d2tPZnhpd3BWMjBE
RDUwcHhoeXNKREJ1aAprU2t0eHEyVTVDZWxmTmNBdXBzYXRwTkhOeTZUV3RVdm1HS0RqTHJLdldn
bE9DL0FMbnE4NjNtejdpV01uVytyCjdWVXlUeHJLaGx6NkMxVTRSOEROZnpaOG5hT1o4S3RkMFpY
TU9LZmkvczFTeUY4U09TY0k1b2Z6b0U4c1dqdjAKbGg3WjZVK09ISVBRWXIzUUZaWll5Q0UwUW16
d09sNVR4UmN3V0JXT0VtYlVPdWpnMlBJaGwvc3IzdzVrWGUrTApzYm1HWk1ZWURpQ2svWkltWUdZ
V3BYMnphY2EyVWJRUmd5bm43YmFodkFBc2JRVzc4QlN3NGdZYjVVMGtpNXVkCmdSdDEzK1VkME9S
emlFUlI4ODIzYk5HRWtWNEh6US92R0lhWlNOTT0KPVFFNWUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c8f7ac06367556ad--

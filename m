Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D371D89FD
	for <git@vger.kernel.org>; Thu, 10 Apr 2025 11:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744284647; cv=none; b=EQ2werd6Q597pbcBDiYonbUyPb4naLDmsbmrploPDs4jD4bs1yYyfQ1Mt9J9LQ5q61hZUqDSJOmO0StRRy6Q1hF6ka7uVWoUUpYB/1WTujGUMchMl/imjQQSI+/pVwmHmbgerX3IV25z8IrRMU2EKg69d3auJO5g6Mhj9EULG/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744284647; c=relaxed/simple;
	bh=sVfk6D6o4XeJSHAuLjCJ9kgCK8ZY3EC64ezupFFEJlk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=MRF3KSgC4md58kj04pas/CHT80zIqHrCpxI4w5xy5grnro/jFXRpsbioNGP/R+/A1UTh7WzTl8BgAKAdEkRXLDpv3N0yUclJMa2dDWWc83X/ftW77+R+4xptCMHSjdxPVPmQMHahRYw6fx9HFgSTx/coWwSkEmoqFlsmBe+z5PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnLh4G1z; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnLh4G1z"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso140927566b.3
        for <git@vger.kernel.org>; Thu, 10 Apr 2025 04:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744284644; x=1744889444; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OqOJTpKurNtF1nhSUXbtPK8cY7wAU2Y8/WbO0hzuuTo=;
        b=XnLh4G1zUX2ncjV0zOrWU8xjMeMUeiN4eTXePB5IdsdhyseqpPxxQRNzlDWuH49msA
         R6CUo3GCxbX0JiSIGQGYVBAxNnOO18wV7BxgWHFnLoKjaP2YW3LnrDMgym6OLuvwy0SQ
         Ztyr6bSEJHeaVSpVx1eji9O4Bf/LQL/rPphNW7/hOwVBPYPMtYUssY9Y7JPM/yV/L/m7
         2f7NW7FmUtS2/pB0x8WBwI57K7mEQotpgZvVgZz4jCIS8YMtt04H9s6pWk/LelfS9X1c
         iQha4GVUfFOBcyvjeLG+ZC+tazdqtau22zfxHkEj+ErtxHMdl/XiQRCKetQ4zLw6/npk
         va3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744284644; x=1744889444;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OqOJTpKurNtF1nhSUXbtPK8cY7wAU2Y8/WbO0hzuuTo=;
        b=lXnmUWvFycUusjMSczQMBDxSfQydgvUr+qTmX+REY242u85OrgYHIBCrc7KAPPgZC7
         6ZxoEL7x8Zj1aaa7AmUCZvv9Fz4FjE4q8bvPJw85UEtkxtLnrJDv3m6GpcCO5x7N+3B5
         6W8DgfEdph0AIaXDAD2KMvTcUGw8d9tc3jd1L6ulohdyfVPkmgaI0UKJ0xBDwl6kfWyp
         WrvUVAO/Wio5taRO2YL7ISrtTzJ07BHY3WYnuBkPwK0QhLhG202IEcTqb1vwWDviMcPw
         6vou7PGRaj4gFvZfxxLdBSdgErYMqZsTcMYmBDBU94pzUUzkSl7acD/ZDSRL5SZT+2ku
         CNZQ==
X-Gm-Message-State: AOJu0Yxz+3/qGNhrxFp7J2x+Qb26tN0nwMsntUKHSHeiVkNpkr5c/jif
	ZgEP5cShCceMpnBWvgp0A/KTQSwG948uEnD3axFUBxgTgDR6PISHP0jQbXB7
X-Gm-Gg: ASbGncvELgAJQSpn5W0J7fTlnFucbLflgQxgxRSiZmcewA2QaTSOgITGGUPZUJXi4nO
	bVul7mfZalvSeV3qtp/q3UNgs9mNYtHGg/SkGuGmUUd81ASDlrqoIX+5fgOs/c8zQUxT9rMLbhO
	QKTsJgKHOmHWXBkxCQbhi0rZwlF70CDQI+CRFeEUWKo1yQqjnwTqCIMLm23H4b0W0QWMvSCyYxb
	67hH9jyM6ThzwcIlR45zQ+r3tfkImJxdHUKzxNqlKTZnjfqg2IqO3eyHDEKlo46BtcJmMTdp+j9
	CP7Sby+BCjFreMWqgMQ+RRwPJVXo0CU4s3rSgiwDiku+Ug==
X-Google-Smtp-Source: AGHT+IHW8WyYHXBsD1Wl9CidTuJxT2Y0pxJUTl7CufvwezdlEcwkprfZCaq8SGiTg6LkjaW6yMClLQ==
X-Received: by 2002:a17:907:944e:b0:ac8:1bb3:35b0 with SMTP id a640c23a62f3a-acabd194ec9mr194490866b.20.1744284643735;
        Thu, 10 Apr 2025 04:30:43 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:9936:e3af:b877:72d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bb3553sm260230666b.29.2025.04.10.04.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 04:30:43 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 0/4] meson: add corresponding target for Makefile's
 hdr-check
Date: Thu, 10 Apr 2025 13:30:30 +0200
Message-Id: <20250410-505-wire-up-sparse-via-meson-v2-0-acb45cc8a2e5@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANar92cC/33Nyw6CMBCF4Vcxs3ZML1SIK9/DsKgwwCRCSUerh
 vDuVty7/M/iOwsIRSaB026BSImFw5TD7HfQDH7qCbnNDUYZp6xV6JTDJ0fCx4wy+yiEiT2OJGF
 CQ9a0rdVGVVfIxByp49fGX+rcA8s9xPf2lvR3/cGFqv7DSaNCXRblkVxD3nbnfvR8OzRhhHpd1
 w9h6s98yAAAAA==
X-Change-ID: 20250330-505-wire-up-sparse-via-meson-2e32dd31208b
In-Reply-To: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
References: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
 toon@iotcl.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3174; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=sVfk6D6o4XeJSHAuLjCJ9kgCK8ZY3EC64ezupFFEJlk=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGf3q+KXlFHjcjMT4DK2HY8p1eohTl8WKjtho
 qRsHDOOnj2eN4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn96viAAoJED7VnySO
 Rox/tr4L/j6UojfmSGE5wMQT09mdRszbWJBxne2NbHOjnchEIxG+9guykiykX9gaVl4MuFAPjZe
 UrVOzlx3CehlSlkShQmQyr4XwO86PDOUsjQRYYiRLgcIx8+kBDrjJh2BeuQbUOQz8lrN/k/amGY
 xq2Ucs4W39tCvem9mpGyZeSqzQnQUVEwTcoGr9dRk+rHaO1DUtZJS/SfCbFUJI7yIU1nyGnAjVG
 zy7+qwQlHlpARF0ooVzTqcrTUmEdFvKEgmGdl/6jTjv/AqhTVKMzN9Wm1aSOJqWQ3U7x1g0BdSS
 itapnQxf6tfvl5nFVC1JM6eFm+Ct67HFKaRSMzkHGSJnjQjwZwiswJUq8zsLAcEvTB1VPJjDlY3
 u372wPDkwtzWn+cpdkrAHacXLh1EwKXK/xO9QaUzp/j/CZDFa8NUHb+Clvy8Xnk15i0R2n95ZmX
 iMEv4NCiF6iRkG9ycKz4TMLLsKJ2MYzYJwcacPKOfI5HYnyJxEbyM/1WpVgznakcWMPxd8lBiX4
 KE=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

To bridge the remaining gaps between Makefile and meson, this patch series adds
'hdr-check' to meson to compliment the Makefile's 'hdr-check'.

We also introduce 'headers-check' as an alias to 'hdr-check' as a better named 
replacement in both meson and make and add a note to deprecate 'hdr-check' in
the future.

The first two commits are small cleanups, where we re-organize existing
variables to make it easier to add the target. The third commit adds the
'hdr-check' target to meson. The last commit introduces the 'headers-check'
alias to both meson and the makefile and marks 'hdr-check' to be deprecated.

This is based on master 9d22ac5122 (The third batch, 2025-04-07) with
'es/meson-build-skip-coccinelle' merged in.

---
Changes in v2:
- Add 'hdr-check' to meson, while introducing 'headers-check' as 
  a replacement alias. Schedule 'hdr-check' to be deprecated in the future.
- Link to v1: https://lore.kernel.org/r/20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com

---
 Makefile                       |   4 +-
 ci/run-static-analysis.sh      |   2 +-
 contrib/coccinelle/meson.build |  29 +++------
 meson.build                    | 131 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 142 insertions(+), 24 deletions(-)

Karthik Nayak (4):
      coccinelle: meson: rename variables to be more specific
      meson: move headers definition from 'contrib/coccinelle'
      meson: add support for 'hdr-check'
      makefile/meson: add 'headers-check' as alias for 'hdr-check'

Range-diff versus v1:

1:  aed80c7868 = 1:  c6493671b5 coccinelle: meson: rename variables to be more specific
2:  cf2a8c50c2 = 2:  33e9b21bae meson: move headers definition from 'contrib/coccinelle'
3:  938aac6573 ! 3:  b6be631165 meson: add support for 'headers-check'
    @@ Metadata
     Author: Karthik Nayak <karthik.188@gmail.com>
     
      ## Commit message ##
    -    meson: add support for 'headers-check'
    +    meson: add support for 'hdr-check'
     
         The Makefile supports a target called 'hdr-check', which checks if
         individual header files can be independently compiled. Let's port this
    -    functionality to meson, our new build system too.
    -
    -    Let's avoid the abbreviation and name the target 'headers-check', which
    -    is easier to read.
    -
    -    The implementation resembles that of the Makefile and provides the same
    -    check.
    +    functionality to meson, our new build system too. The implementation
    +    resembles that of the Makefile and provides the same check.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    @@ meson.build: endif
     +    hco_targets += hco
     +  endforeach
     +
    -+  alias_target('headers-check', hco_targets)
    ++  alias_target('hdr-check', hco_targets)
     +endif
     +
      foreach key, value : {
-:  ---------- > 4:  d265cd97df makefile/meson: add 'headers-check' as alias for 'hdr-check'


base-commit: 3a956c5f69873611ae5f8dcb9acd117f66b95ddc
change-id: 20250330-505-wire-up-sparse-via-meson-2e32dd31208b

Thanks
- Karthik


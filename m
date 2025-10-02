Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869A62EDD74
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 10:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759399367; cv=none; b=cUfR/JlMDI/g89U2Ra5myNFv2tEDuAPW1qSNomEzHv/uj7PBHNiQt/hTMDe85NWGzwWvxElut4sLSUkH1tAxRNozy5j/hRTIJ2Wtmiw0j2N3lvZnSa61+3dJoxo69OtMc19WC1lHnwQl2vdh8db24Gw1x4SjCukqTXdCRM23bho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759399367; c=relaxed/simple;
	bh=3+VrHKC5Ctv2FzqihwmZ/Py3AiHij6isoNUgRJ3GJQs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=c+lamn+laDhOcD3tJQQ5xlACWggjbSdy3Pcbfm9rUFd24Ml2uzgCgKDVU5pfk2PrortQgWQ9WjBF7/cTP0zQde5TSobF8Ghphwn6TONecjzlNd8HSjkDmyS068OyeqxB/uZpt7xadwP5zl21Wp4sB/WTcV7t8VVaxWDUGKRK0N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jW+nvZMR; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jW+nvZMR"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5b62ab6687dso984705137.0
        for <git@vger.kernel.org>; Thu, 02 Oct 2025 03:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759399364; x=1760004164; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YxDCQ57L+xXJ0sWXpsUvUWZhDsLn0PpzXDbJsAWLZJ8=;
        b=jW+nvZMRL97ml0lBihAQJl3fzZgHPspbB/JJ8crXuW46KuCcQr2JX1VkuUOkpajHFH
         Uz69aSaRsekipZ70u4EthZoKU3R1UfqNXJXnnZV4MqdSYPRyR2EDfCLKn8OfP4dAoBSj
         KMKKIY082Xmi/Jo31n3PMGMhjgBY1Vl+hR11vsQ3PzhsSdslNQ8Mz2ekT+TubqMcSJAg
         hew1cNA6l3viTV+WPKLCU5mqjvERLrntw55Lb2pc7gAIaP8v+0Yjs8evW+PoVr2ipvJQ
         Dz9iQopGgp3VzZnCKhE/8ldOt6MR9kdI4T3P7BFzFat7TuHnCh9UJsV0arNdp3YBjjsa
         8OZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759399364; x=1760004164;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YxDCQ57L+xXJ0sWXpsUvUWZhDsLn0PpzXDbJsAWLZJ8=;
        b=oDA7n613UCmZSWKSpE9s0p0/BGHsa5k8CJuG91wSFBqZAZw9z0T30fCfErwIZr6dJ3
         iAElQH5sjOx3RiQISqQWKRxuV42kZGOg+0MPUfwKqBcL5tProBRquF1QxzZ6y7p44Om6
         NYdQtxqVfHPWtrPg4NvK5iOLBPj5sHdFnDNlx4qNTfUKacFcsx+hJDx1TjvHLzgECIUc
         /bu8VdiSju50YjWHd38/HT4SVB3v1ibHFxI6ElQkL1A2eXVuBzFCNVWooJ5ljfbTazMb
         +gnC5C+8JRuBiZ1q1ykdP1TVdw95EFRJ9vYiMGPW4a4AXgda1ymS40P374u7V6wS45be
         kxqw==
X-Forwarded-Encrypted: i=1; AJvYcCUibGg9XHSG2zH/SU8iDPgx2aswbqBSeLx/o2kEQMqntJcSLUnd+aXJGEbnnPbnoJFBKeI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwp7CFegPf0rUccxYN+DDgcRY7m/7ulRly7cQ0DlJEZ0MXeAKA
	IFxKwOO74hSlRZaPvB3wBUOdsIp0d+kp9HpP2RWVcwiOgtRPIejMCw8ZRLEUasRyqhy46N+afJ4
	awAUDlXE5rF5OdYCRf9dTyzkPgq5LAV8AJaOa
X-Gm-Gg: ASbGncvKQCB56faA3yYXWk6ex1VD9aMdQL0WPeX1ITpWVnnFcpeS0XWzfqRkI+wo/Kj
	HrzeqoPn1x+YL3gxxfHB0AdQShyhyityCj5PIXuxyiL0UFbrF6t7Ua56TCuPUeXKnT04g33gAkl
	/+r5HoX3dZ4SntaIEFkk8Ny6ZPjEfEOSUHeMJ+m5laexEPIRUXheE7/vjcglsCwHc81+g2L4s+I
	fopWfcD7lkfKz9OOFYoItI6Re3eeAQ6PtLeDcgzy+j8fB6lHXg6sxcS+xBzn2r2xw==
X-Google-Smtp-Source: AGHT+IGxs3K7aPuNOiNDaGgR+raL46jDgP+r2bWyeqqfmz5/Vdg/ZzqQ2LJ74bp8SmqfjQjIshdbov/ISe9dgqGeWiU=
X-Received: by 2002:a05:6102:c8d:b0:59e:2c90:fae2 with SMTP id
 ada2fe7eead31-5d3fe6e7b21mr3234466137.30.1759399364360; Thu, 02 Oct 2025
 03:02:44 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 Oct 2025 03:02:43 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 Oct 2025 03:02:43 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqv7l06gwi.fsf@gitster.g>
References: <xmqqv7l06gwi.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 2 Oct 2025 03:02:43 -0700
X-Gm-Features: AS18NWCBQ0XRGj9DNSOySTQGYwwSS-A84eX4IlvB8Lc6C1stNLf8SXuptQHe16Y
Message-ID: <CAOLa=ZSkSopXe0jXMO1MB0pzPTRrMxY-Y8VgoY9va+YetB-mYQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2025, #11; Mon, 29)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000002199c906402a16fb"

--0000000000002199c906402a16fb
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> * kn/reftable-consistency-checks (2025-09-26) 7 commits
>  - refs/reftable: add fsck check for checking the table name
>  - reftable: add code to facilitate consistency checks
>  - fsck: order 'fsck_msg_type' alphabetically
>  - Documentation/fsck-msgids: remove duplicate msg id
>  - reftable: check for trailing newline in 'tables.list'
>  - refs: move consistency check msg to generic layer
>  - refs: remove unused headers
>
>  The reftable backend learned to sanity check its on-disk data more
>  carefully.
>
>  Comments?
>  source: <20250926-228-reftable-introduce-consistency-checks-v4-0-c96fd8551c0d@gmail.com>
>
>

I've addressed the comments from the previous versions, will also try to
get someone from my team to review this!

Thanks

--0000000000002199c906402a16fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e6894878defd0c63_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qZVRjRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM1ZCQy85NFhUMnAvamRaTisrNFNDRnFkUDFoN1ppbQp5MmxweVVDVzhh
ZXdxeXRZY2VkRVhlV3A5bittL2s5Y0M4OUdKSWw0RS9WL055c1oxQ2hiRit0SUtnazBVRzAxCkp6
dzU5SjFETldEVzc3SnBNVm93bFNIY25TZFJ4U1ZOTHJzRm5rR1VpdERjeS84SFo3V2w2MjhXR1Rp
aDNUT2EKK29DTDJBbEFBV01odlJUMndtV1RhR3dCYjZ5Nms1eUMzYUl2VnM3WXUyMEZOT1UrS1di
STArWnJhQTN1WGxpWQorWUc3bTNTR3pSRHVVMFk4QWNta3I1V1l2UENoOG8yRW5aQ0tNWWdpblMv
SDkzdXFwYTdmNUVkcDZiY0g0TEt3CldkaVA3Qit5WGJVa0I4SnlvSFd0RWE0QWJmYWROcVJyUWJi
WGZVVThzak4xbkpVOWxwV2tybEl3ZnVmaEJud2oKNWhoQnJhSldYdkR2eERvc1dJc2ZoR1pjZGRs
OXA3T1p2d3hSUWtPY1ZUWGs3QldSYU9NZlZ1aUJQeDl4VDFLeQp2MmE5SGFsYWUyelhqNnFqaFRO
d2x3bjhzQkxOdXRRdGcvQUZTOSs3OHpZMnRFVXBNTE9DTkZyM0dRNVlyeG81CjJQcGJCRkJHQUNO
SmxScWVkOTBiSGhKeGdOaysxUHNWZk1xaXl0ST0KPXBaVEUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002199c906402a16fb--

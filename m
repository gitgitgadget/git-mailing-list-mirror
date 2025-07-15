Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFBF2D9EF1
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 11:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578979; cv=none; b=TffrGo5aZcbfXsauWVhDoRvjTn3RRwfTOagVOlLhr5nrtkIuA1xJnYxqizL3WAxcQerMKlxKZARSZegUjDO3g8S5Jx9YQoKs/Fipyf0WM6jEA5gZ7SqQwy9uieV4EEqdXo6grN2WNjNjm9e6X5EYaJDTaXYYjvbdZM+rJnw4hcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578979; c=relaxed/simple;
	bh=mivw3vCo/mKQ6LR0Ptl3jonbyviVMtnAcTJRcWSEYx0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=K7gjuAlMZ1r33PCTdiv7clGSGAGdoKdZ7jxmb7HgWlEr7G4Td/TtnoCplS3VHzm4cH0PTZTv0ANnsDjwv3xBRhYuxw9b5CK1aSKXyGup0VBK2g5UAi+vYAlHpJsbvRJ+b6owl0XZzVufhzzgQ6a/NOMnGXTuAxk9BIJhfTDZXBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzeXMpZw; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzeXMpZw"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5346b75d719so4915256e0c.1
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 04:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752578977; x=1753183777; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RKHZxsgDzNHYoyT/DoY0NeC7rNMRIOoNK2qtJSIoimE=;
        b=NzeXMpZwIcSHWlA+PMsUBSuPasl7Yq5s66PfQzQcL1Wzm8W7fnSKAU/W+aRO8HvRRM
         iHKKZKor1l1qt3orQNOFVMIS7wsS/A32A+vOpcnclKYh4HLRIodN86/ytC7SAoJTjBeu
         otZsCTMK2/XAF97tnUUlpFlFD+cTZcjZrpCuxXENZuuq8ffZBfQ2g3VLMLSe4gg6zb26
         TInmwvYT/cyd/OVPoubfVsGZM0YKBy+T4Q0OdPCkF9KSBM0wNaHk3CpYWIbLrJuGJivL
         +5tMqOy2n2zUyu2z3SY2VKZj/mKJttatelYMWcqdvFABCc+XxINMNXc7kNf+7enh/Bim
         eMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752578977; x=1753183777;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RKHZxsgDzNHYoyT/DoY0NeC7rNMRIOoNK2qtJSIoimE=;
        b=rWZZftGo3qUvBL9Ltc+M894C7tNKdlmgw1M28pmNdjd84ZXbxP7gkYrT/1T2WMRity
         PH3JxW72d1joaqI1ypuhLf6Y/V2TJ51e+lf2MB/FWtBK4rrQ9DIBlmN8fLmSVRYZsxPS
         Wn4MqztYFhRcIXTYbV7zAF131/QSsP44PPLFSWPhKnIPcZieqTMPoUgvsRMbO+VKP6Kg
         YnUxHP9iVf0BIESHPu/iMB0K1dNvde/J0XocQ/xYwC7pywuG1avU0oFZRLrDP2LGut0n
         5W5eOdHFyNPOtB5PomCtCDBds7ZHHLMMKYCoVuhp69CnYF+/3Niut1LPxFncNXV3j5tT
         CUTw==
X-Forwarded-Encrypted: i=1; AJvYcCUT0JuzvN53QXMw18MpYJb+pWKQPrO3z9qPn/DadZwkYCcIX4/WSzI3DU0UQEaxupVLvnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVL/04PNIC6K4VUYBbpVP9pJ0PEb4jePB60jfBr0Xpe5byGeKY
	MYwO9pWejonBcVpaP4UHRK279hCwFsKnpEXZZiUBBLOuuZlEEYn3gp259AscIYa1IKc5mGHKvmb
	JH1OFMfvAmpyOFfItk6UXTr9IetP/dpg=
X-Gm-Gg: ASbGncvk7Dy5t+mw/7y6F9JGQ6jHRIcH6W+CnvmqRwZe9qxojwGHMEJOqdQLZMBDaNH
	eKw3GMUGxgA7yi3oheR6EUD6nuiZhfM/vwCsBGPF2DJKpmkuPl/DrbiMWO4UoErAQhLvmFmkTAg
	XYR/O2MPW/v+m3h9xC6jDZ8VKF5ikJafJ9/kR45Xmxl4x81u7aQEWKwIt4iWYe/v7BBv/XtQ42n
	V6cUYC+cetpd4XBQJSv+cNSpvtfGnlOF8tf4o4k
X-Google-Smtp-Source: AGHT+IGIPm7kP/MJDe9GxpxHmYbwDi//4BJyAxbU1tDbyo+ZflIzwtsT1Gv5XuER1riXQkNzVaJmqq91VTJP9IoA0Rw=
X-Received: by 2002:a05:6122:4707:b0:535:aea0:795a with SMTP id
 71dfb90a1353d-537323362a7mr803147e0c.1.1752578977187; Tue, 15 Jul 2025
 04:29:37 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Jul 2025 06:29:35 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Jul 2025 06:29:35 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqa556sddb.fsf@gitster.g>
References: <xmqqa556sddb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Jul 2025 06:29:35 -0500
X-Gm-Features: Ac12FXxCWNdmz7EiJguKlYXh15jRXHIaKLEeBTWQdF2dXDJbo8ZjbiMFJUOz4po
Message-ID: <CAOLa=ZTtgQqMZLNL0jLfVMWaSgn7-APt_NYVpJTj4zz54kXH-A@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2025, #04; Mon, 14)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000006069430639f617d8"

--0000000000006069430639f617d8
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> * kn/for-each-ref-skip (2025-07-11) 4 commits
>  - for-each-ref: introduce a '--start-after' option
>  - refs: selectively set prefix in the seek functions
>  - ref-cache: remove unused function 'find_ref_entry()'
>  - refs: expose `ref_iterator` via 'refs.h'
>
>  "git for-each-ref" learns "--skip-until" option to help
>  applications that want to page its output.
>
>  Will merge to 'next'.
>  cf. <CAP8UFD06KKF0A0WjBSw77A7fKp_pGJGVyw-OPd8-X92h=RSF+w@mail.gmail.com>
>  source: <20250711-306-git-for-each-ref-pagination-v4-0-ed3303ad5b89@gmail.com>
>

Christian left some comments, so I've pushed a new version here.

[snip]

--0000000000006069430639f617d8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 35d0a497feb0e129_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oMk81NFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNkRTREFDZDdpTVdpbnhaQXduWVJWbkpFR0NiVlI2bwpuOE42ZEU3OTR2
YW94Y0x6bGtIOUc5emt4YytDUkN2UGtFbWsxcHFTckl0cjNNcjZ2RkZxb0FrcExWdVU2d3VqCnVQ
VGpab3k2QmFZN0VMbjFwd2RxOTgzWlA3a1Rlc3JLaS9TS2twbDFtZkErUWJLejVtd1VYNlVKdGMy
N1RWaWkKR3d5ZFI2dEVjODVIMFNhd0VvVERlc0ZuYTRObENiZzQzM1lnK2RVU3pobGJacThKa0Q5
MDhnNG1qM2NCRVlyRApUUjd2bVREUE05VTZ2S1BaNzVnVW5landROHJ6cnpnNDB1SDBtREpvZkF4
SVZGSVdWcVRRSzU5ZVYzZmpPSER6CkozREdnUm9KaXNnUklHR1JvcEhyMUV3aUN5aXpIdC9JSnhE
WWhEeHc3cytmT3dGbHJtNlFqWmxqaHhlaEVqenkKWXRiVlVJeEN3Y1BtaWFMTWJJaFc1aHNWZ0Ry
aWdGOHBlOTFVZmNGcDBPQnFmeWNmajVKSkErU054NnV0ZWgzWgpJMUdzZ1RWbXJrdHlHMzVkZlY3
Sk5iNlJjZTYreXlIN2wwRlRKSkRPYVh2Z2E2V1ZSQTlqak94azA0WUoyUDloCkhKMTdMcmRxaHlv
YWRPcENxTHYzelhCQmtVTTJzY21kUFZDSmRucz0KPUNaYTIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006069430639f617d8--

Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E03618D65E
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731679996; cv=none; b=WIeDSrzyhDdriVuSZCmdIj1tlVhZNVLAadwf/MbEQwmPsAH+i2KJ0BPvq9WUUOHbVNS+jiA+LS3vRUGPopy4JvzYnkedg7laZq12KDh1hSoP5CAmLu/nMsI/kSEfEUVAWvWryDYUjB50uakXhAeqfO7Z36i/3deR8t0B+1sfiiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731679996; c=relaxed/simple;
	bh=ICBLUaAzcr1qE4OBeBn5SVngvdYgjVw/1E3h/f3Xt+g=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tSVXK0gzhLW736cEFGeWpWZtKuN2zuZA5HFUsU2FbG+X4r6WfGiUVbQ1yeTZEZHS/0afMaDa06rg1HruR8+EriO9GKRstWNnri+Uv0UYAqtzoHD6kgXxTpRlmqqH+fnbDymyShdIvKMc0P/RFxJh9iCk25tt5KscyJg8dG/0cBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2tOVnfn; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2tOVnfn"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3e5f533e1c2so981672b6e.3
        for <git@vger.kernel.org>; Fri, 15 Nov 2024 06:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731679993; x=1732284793; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YP4MrJ6/1UkrrxcpdTqw4hx4kQDJ6onSpFpBzs+ZXoQ=;
        b=W2tOVnfnfzpq8m5qI8qmSvkYp8AhztB6V2/7oU1NsO7vabYPZ2sRfEW7xnnGnPQTZs
         TIH7CE21VRTJTkLYr31NmiHyeJ2kC6k06QdbFWh5rN6K9XN823ZRYaFREw4cJp1GXJzG
         VVTNPdbqcur2bIJAHWKfaNOusomKlzwd21bbXLmrcFv4GHaRHNan829m9r6fpwMZp+08
         Ap3ayviKTvVcVlpICgWdiAKv9ItDPvr2+R1n1nSFGyb2EGaTpUBj+V+07KImnSPo1XD9
         BueswDsE4adR4m5DEgyadubCI2+iKK5l5VwZLD5/R0rGJUWea6VL/9tRimfL4POogSwh
         UyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731679993; x=1732284793;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YP4MrJ6/1UkrrxcpdTqw4hx4kQDJ6onSpFpBzs+ZXoQ=;
        b=rsQFND55U3tONRKr3/80bIhRO+BrNUcSSI/XdOOdQqkfmVp/Y81LQKpdCwbKIZ6QX5
         ZLY0jf6bSm+oNCq4dRuHFwZSaSqDifUCDB0PSXFFxqmV1vcQTKAN1W9qsDMM9+pv0Z4v
         bBu4Bh7EKnvMQiZa2Xjpj3h8wWvqyVDDTEpiz4lKHxb6atX4cotXgZRQnsvui6mDhwmd
         nWEOWxbv2pHL9tzrJ5SzqsmS7BOZvSW80ReGpCBC6bB2QV5HGVHIZbndDLNdF5xoL3uf
         BvRMa0qwAphEOLez+E+qtNdnhYjZKs1A+smeCOhSGjfNnyD8U6LjgD9yPLbeH6HEehOA
         MEhQ==
X-Gm-Message-State: AOJu0YxjzFFzh6hX87vbBB19FpWlzcsAX90jk5nz8IVCTWx4YEDM/8uB
	LyzSJ7X7OlrgSnvNJt07pTxC5Q/pYL3Kc0M6IhO3yzOhR6cm5KH4RGl83B6UCHOPShThBGH52NZ
	5m4s9xcNXcsu+5FVPBUQc22/6L3hsQmfU
X-Google-Smtp-Source: AGHT+IHMf1VPZB+oz2NopVVqrCCQJhBIjScYyfHQJUoJjWRUqu0ViZK4Q2GoNXL00p1QwXfyAb1VW1orrQYC+eC9X90=
X-Received: by 2002:a05:6808:2213:b0:3e7:635c:f1c2 with SMTP id
 5614622812f47-3e7bc7ad82dmr2942836b6e.4.1731679992882; Fri, 15 Nov 2024
 06:13:12 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 15 Nov 2024 06:13:11 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
References: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 15 Nov 2024 06:13:11 -0800
Message-ID: <CAOLa=ZTmdzZBu7M8Q4UdJPKx_LvJQruSQkrm_6XtksOKuLoM-Q@mail.gmail.com>
Subject: Re: [PATCH 0/8] Change midx.c and midx-write.c to not use global variables
To: git@vger.kernel.org
Cc: me@ttaylorr.com, peff@peff.net
Content-Type: multipart/mixed; boundary="000000000000d868420626f42a0f"

--000000000000d868420626f42a0f
Content-Type: text/plain; charset="UTF-8"

Karthik Nayak <karthik.188@gmail.com> writes:

> Similar to the earlier patch series on cleaning up packfile.c and
> removing usage of global variables [1], we change the midx.c and
> midx-write.c files to no longer use global variables.
>
> This is done by the following:
>   - Usage of repository variable already available in existing structs.
>   - Passing down repository variable from other subsystems.
>   - Modifying all subcommands to obtain repository variable from the
>   command in `builtins/` and passing down the variable from there.
>
> The biggest change is in the first commit, wherein we modify all
> subcommands to add the repository variable. Since the subcommand
> definition are not often changed, it shouldn't cause too many conflicts
> with in flight topics.
>
> Since the `packfile.c` cleanup is still in flight, this series is based
> on top of master: b31fb630c0 (Merge https://github.com/j6t/git-gui,
> 2024-11-11) with those patches merged in.

There are some topics in `seen` which would conflict with this series. I
think the fixes should generally be trivial and I'll try and iron them
out in the next version.

--000000000000d868420626f42a0f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: edeb0d79d1eee322_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jM1Z2UVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md3NpQy85eUM3VktGdXZGTHZSTjFiRkpMeUtRdU9SRQpJcEUwN09qSGVE
N1NGMzRWQmlac2lFYTFvQUxkeXFwZlM0dXViTHVqck9XejEwT1k4aVBNaUJSeGRRZVRDMDlQCmVv
UVBEN3RzcVIyUFQxZk5hT1R0VEFKNHA4d1NzNFo4YW10VkY3ZVJDL3luNkFOZ2ZRWHd0Yk1ZbjhC
bDN6V1QKUERWNnUyMmJuTUd2MHhZZzRtYUpVS1pqZ1FaZXp5WTFQQk9wcnVxM0NyKzF1OGx2b2pa
NytOaVlhbEllQXE2NAo3RWNNeTcwVlB4WXBXSGlOY2JiM3hRZnFyaTRUTHhuRHBKeWZJcURtcWZu
TkIycm9wYzNGbTVkMEJ0Y3NhRHJWCitNNVVXUUVUcHQxd2xaZVBzS01mSmkvTmcvNUJtOHpHZXBv
TG5Ib3VUbDBIeXVmcDkxRVByaUtpaXZMOFQvWmIKZ3hCZHF0UFUrVjFiMGN4YVNoUUdpLzgrTUJQ
QlVOemltU0JZdzNRWlZETXhBdlhWUDh5a0h0VkdzdHorNm1mMQptaUZadFVzOGZQMW9GdWRlcmp1
bFRzWGRBbUxRK2czL2FhVHBmdmU0dDNpQ2Mrc3VBY2JlMm40VVA2MzBuNUc3CkZHQnFkYytCYlA3
Q0E2T0x2d1pEUmRyU1BTQ2FNR0N5QzB6ZDZkST0KPUJxUjIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d868420626f42a0f--

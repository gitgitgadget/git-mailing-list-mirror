Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE891E522
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 23:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710979149; cv=none; b=XYbXbtxE6vGbloOC6jvfWE3hrGihx69Sc+duO62IV/2TyDUFVuci9YrQISWeh+dMcjG0E0/hD5L0IVO5UXH/tLz8HiWNCXDIIQ5BDgOtjhvbUVllq1zmDPUmjge/7KeiOUpYR9OzS7f1lK/viH1BDOoGV8n4BLnOYY+G2soFKsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710979149; c=relaxed/simple;
	bh=ozbJzt7G4ITn2SFtacfg6Epsxggl1/PKRGTCzpnqCOk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pu5w3BEYvHEco9sSDQmKAeMZlL5aJG0ObXyKb5KThNpRI//wdDqdb2dSynqf4x9ubS+aYTxp62f9tCBHblhUnJkDPLIBUGv0StiSXniY0kiWqp96QJQVcsSOOmgJ2xzmm5MmCHoioHf2rzmIwiCY43dCHBgqszc1IMP2O3NgL4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYN06wQc; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYN06wQc"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-229b2396180so334047fac.0
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 16:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710979147; x=1711583947; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=c71rt4kc03okiRteJNQl3ztdIo0kjTEFuYDCrn30W9w=;
        b=nYN06wQcOAGtJzKXwjhh7gPb7odXxEiXFUp+p5LzSigX8J5A7y7Wpl8YWhWD2RVNdI
         EW3tuulFY+nbuFxuPGOTRZXw1CuOCChefaHKInT+Nji5ZQXTHtTGNAq6dtpIXuNcNRNn
         /7XP8SbWUowgjwCG6j3lrBJR7Y5G6IJNZxt7A9j42MKEYw2PVIqQ5T4xROSmUbhlfHQM
         RbYztks3k7zqW4s6KsQeCofqcRrzuGe9A4q4WcnjKfT3FCPAs/PUAanW/Wto4Ibd/dJB
         8CuYYX09Pdsc/651oZvacXNIDm9RCSukzrUbYywm6lurwtGGIjT3sv9/qsLv6gOnXKfd
         Sr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710979147; x=1711583947;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c71rt4kc03okiRteJNQl3ztdIo0kjTEFuYDCrn30W9w=;
        b=KHxm6ccaBbSjtkgso0B85K3KjQcGSNN+jHm2CWi/5Z9dirmytRg+P3nvgvICkq05Xp
         FRMOJYeix7mq3NsEnoSnnLHAqcHhSf1keC+P/X9IS0ITQBlvrKIScHLafXspbJK7hACS
         sNbApfwI59mJ7iGxgbzPtDlBv/ZAg62Wu/qanLQm58dE9Ts1drplIZ+4VFHXmzsLX1cp
         38Kx5Xqt6Qx68AdsmBSVwlYlN2eOJdPv9l4CSTkq/W5yQ4rst08BVP983UCE/g2FYz0W
         WRwjDZkP/7OXym7M286cpdI9HdnoOELQb5pomXOQwYGG1Kb8p4eIGH0y/IS+VmtgWDx6
         515A==
X-Forwarded-Encrypted: i=1; AJvYcCV3E9ikMQOrGp6TXpcksfjwIZlNP9JIZIV2lQ903dZoQ0ns1bxNTPEt7RPhvgcMYXvuvWL9kFaqgL70SH8c9t/bSn6I
X-Gm-Message-State: AOJu0YxRf1QRXAucuQNv1JmbZTROhb2KDF8ks3AyDbgmQ4rF2c+jBpFd
	IB91nM5NvXRb54/7d0rDRjEMI4CzHuJR4ZRdpVQghVdtVD+cx6w6JVJaKA7Ayzkr+MmKZqSW//u
	IujoDB024dMRnPkQEX8FhDPjNWTc=
X-Google-Smtp-Source: AGHT+IHiCBC66XYU12PhDJEzEwtBSDpewkmhUjyMEw/DpvrnoWW4jjC7oy617CnrcTAwAQaFsKCXfNTp8LvoVz1BCZ4=
X-Received: by 2002:a05:6870:6589:b0:21f:d1e6:d8e1 with SMTP id
 fp9-20020a056870658900b0021fd1e6d8e1mr7793667oab.27.1710979147363; Wed, 20
 Mar 2024 16:59:07 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 Mar 2024 16:59:06 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <71f4800d36bcc77d8f36c5fc7b48eccbb90e6a93.1710706119.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im> <71f4800d36bcc77d8f36c5fc7b48eccbb90e6a93.1710706119.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 20 Mar 2024 16:59:06 -0700
Message-ID: <CAOLa=ZRRCLOcXvn=F8eXH5N0kncPhu968_se8tG43VDEjZruwQ@mail.gmail.com>
Subject: Re: [PATCH 15/15] builtin/gc: pack refs when using `git maintenance
 run --auto`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000004c172c06142060b4"

--0000000000004c172c06142060b4
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When running `git maintenance run --auto`, then the various subtasks
> will only run as needed. Thus, we for example end up only packing loose
> objects if we hit a certain threshold.
>
> Interestingly enough, the "pack-refs" task is actually _never_ executed
> when the auto-flag is set because it does not have a condition at all.
> As 41abfe15d9 (maintenance: add pack-refs task, 2021-02-09) mentions:
>
>     The 'auto_condition' function pointer is left NULL for now. We could
>     extend this in the future to have a condition check if pack-refs
>     should be run during 'git maintenance run --auto'.
>

Ok, this answers my question in the previous email.

> It is not quite clear from that quote whether it is actually intended
> that the task doesn't run at all in this mode. Also, no test was added
> to verify this behaviour. Ultimately though, it feels quite surprising
> that `git maintenance run --auto --task=pack-refs` would quietly never
> do anything at all.
>
> In any case, now that we do have the logic in place to let ref backends
> decide whether or not to repack refs, it does make sense to wire it up
> accordingly. With the "reftable" backend we will thus now perform
> auto-compaction, which optimizes the refdb as needed.
>
> But for the "files" backend we now unconditionally pack refs as it does
> not yet know to handle the "auto" flag. Arguably, this can be seen as a
> bug fix given that previously the task never did anything at all.
> Eventually though we should amend the "files" backend to use some
> heuristics for auto compaction, as well.
>

Agreed, thanks for the clear explanation here.

--0000000000004c172c06142060b4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 635bf531f46b821f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1YN2VFa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNnpZQy85ZkovVEU1QjZOUnBvSEFJZ0FVQTdVZTkyWgpxR2lPMmE0aHV0
VTFRalZpb3hjZTNWeTVpOE5PQ1AzM2pKemZVUFV5Mkt6amVUWExQaFJDMG1xWUlQS3ZLRTFPClds
RVFMMXhic1RUc3FXd2gyM2UrSTFYRmVPekZFQjRZZ3pvODgzdlM5bFZoeFM5NzdmVXROU2xta0dm
RFdWNUEKUGpIRXY5U1ZySzJEM1VSdytQNUY0b2F1emVqOXpYR3haTmhYUXZUcFJXeVVKMGFlR2tj
dDBhRXVnRzFMU2xORwpYVVhaRkJmbDVkdkhDUDNoaE4xK1NmSUx6UmJuOERyLzZWenlUQjNoUVEr
UDFsdCsyVms2NU80OFRyZnlJV0kyClpKbDQyQzMxL1YvUDR1cXVKRld0TUJ0dTB1bTVjbmpNU0Rq
VmRtMHFCZTFIbHZaMXVNYzJ1bXh5VE0yekRaWjMKQWc3MkV0QzYwQjE5T2NUOFgzWk1UNEZ5YWRi
VW1RQmFCQlVrS1ltcHBDcE9JMWVjMFM3bmJCNTFZeXd6OFpvMwprMGVqMytXMFo3N0lBNTM3YTkz
bVNibUNkb1FPTnJjNkpFRUdxUlpYV0ptUFVWSE9BeC9yOEluWWpWeU0vcGRLClJVbEVQY3RyNjlu
TlkxMk8ycVRxNXRtSVJuV0VKZTBMQ1ExeVZyOD0KPVBLQ3MKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004c172c06142060b4--

Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149DA12E1E9
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 11:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729423010; cv=none; b=VboEo5bowAj6hFTj7PX+VvVnvXeEV9RbV3rCBqj3R5CVfn4UdkxU51mFzp37T+wKtF55ippoHpJXldTM4lJecxNNaot+N/BLYwgOAvO+dO9j8lIqNurdz5G+ZNvy27XUc0LdoAw/tvtatSFgFwIBMxSo1jAS9aX6i2P6x3VpIbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729423010; c=relaxed/simple;
	bh=3NeHrpQ20FCOvWoAN+iVBbWYQCagx6CyaXwiUkfDw5k=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ejwM1M1vHq1dvZayMYaQEZ5ivU9ORBB6erpWplWLhYE+wVV0/7/Z6GBLw6T8sKODTbneq25HY+lfgRhEOGEAQqKWXlmTkC51cBM1AiLIWu1hS/Fz190CRhyekNmu/LndYkl+rNSRwpFmTBrZ53HHtyJCBmSZ+BEQLQjTUx5MmSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RjhNftyM; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjhNftyM"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-84fe454176bso1114460241.1
        for <git@vger.kernel.org>; Sun, 20 Oct 2024 04:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729423008; x=1730027808; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pUHJXapId9ek9UGZH1yDgaQHWbFbnAJMZ4qTRVfViWk=;
        b=RjhNftyMtxNmXkFtTqGIZrenqiaW/+4VzhfyIL/VgYbL/2U/rIX5Hz095wyPJsk7SN
         fc0PLXGSYFaVbSkWXX49cSQkSbyBsRis6Uhd6VpiECWqiXfto1Cjzt598/ZMwxfu4O2Z
         9F1xg/T5OlaCyUS1IeT/HKQ4XKqBbx2K/bOzNYbJ/9uVFTY+JWbjaOhbnnLwTttSoYxF
         YV2fE6yqQipZKI9LNjiPdXR36BPpH7PX6OXuqtxMU/hYHcHb00DZM7+cYZh8vMO7vxFg
         kCxrGkPjej/8OSSiFNI51Ed3U0u5doofuIt7KTauoAZFbSUsQoa4tiU7kUhwEO78+oON
         1IOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729423008; x=1730027808;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pUHJXapId9ek9UGZH1yDgaQHWbFbnAJMZ4qTRVfViWk=;
        b=apDd7tpkGgQ11HgM8pwyy9kvVag0uYJR1s7BLQ8+Wmus5GNTk1H7PqUg4rN0zgK+Su
         nX9ej0knG8+8J+WiwztqRAFYt4oolPdHkyzfUWFng542EJu+ZJ7DvIHuSjfrylL3a+zs
         DRQYhYfSJrP29XPKgPWSp6pHD44O1TqHKS7trAa5KGTb1qTMNgnG0sEd3aWaT94imK67
         /UsntU4JVVkbjn/KjHQqKtEtPtjNHpjnO2BcgdiQkZgeTAYnGrUEorin7mA+9iI9LB26
         sdV2IKR3lx+9jzi+dwS7tgHN7z74/N1lvZH4bC50JAHpKgzebMsV7SRSBm1CzmujrzgQ
         HcFg==
X-Forwarded-Encrypted: i=1; AJvYcCUSYD2f/VTyWspzxAUtGf7cJh+eI8UFo1M2w5xTc5TFURYXN8vJDiQU95k5tPWIgMs7OyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww+AsfY457ZGslqoSHde6U3fl63gVkCnlz0feIz0+f6+D8xkiF
	4gFhgmrXlHNdMBSDSOhBM0gcjgvojgWtJ56GfjwhtCZbwVw87vEbE7ST7PVXcxbvfudffCCtYkm
	N6H+Kn573G3vU6YvlRQWq28cMlCk=
X-Google-Smtp-Source: AGHT+IH+BMn7kmG42T9WpKKSrZap5ND/KNteOPy5NdPJ1BVEhM3N4LcAoVvaziojXPDB82Df5tq9msQIq+fFyfHuh2A=
X-Received: by 2002:a05:6122:d89:b0:50d:5be4:c39d with SMTP id
 71dfb90a1353d-50dd98f3ca0mr6722409e0c.0.1729423007893; Sun, 20 Oct 2024
 04:16:47 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 20 Oct 2024 06:16:47 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1729367469.git.code@khaugsbakk.name>
References: <cover.1729017728.git.code@khaugsbakk.name> <cover.1729367469.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 20 Oct 2024 06:16:47 -0500
Message-ID: <CAOLa=ZRAG82ZLZMWcHgF-==yhRENv1Kkg_LbrpWDbN1tL9S+yg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] doc: update-ref: amend old material and discuss symrefs
To: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, phillip.wood@dunelm.org.uk, gitster@pobox.com, 
	bence@ferdinandy.com, me@ttaylorr.com, sunshine@sunshineco.com
Content-Type: multipart/mixed; boundary="0000000000000d82e30624e6accd"

--0000000000000d82e30624e6accd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> This series removes or moves some old material in the update-ref doc and
> improves the discussion of symrefs, opting for a high-level description
> with some redundancy (see patch 5/6) in order to avoid a reported
> mistake/confusion.
>
> The end goal (after all patches are applied):
>
> =E2=80=A2 First paragraph (in Description) describes the first form
> =E2=80=A2 Second paragraph the second form
> =E2=80=A2 Third paragraph mentions symrefs and explains why `--stdin` sup=
ports
>   them
> =E2=80=A2 A new section whither the symlink (FS) vs. symrefs discussion i=
s moved
> =E2=80=A2 Link update-ref to symbolic-ref and vice versa
>

Thanks for working on this, I have gone through the patches, I think it
is in a great state.

Karthik

[snip]

--0000000000000d82e30624e6accd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 828f64c2740a8b42_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jVTVwMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNStEREFDQUU4Z21wa1ZsSzJBZUM2V2hQOEtHSzlRVgo1aUZjUWNyNFRE
RVNPYjJ6ZHlZaWdPWndNMXhVRDNrRGxBRW1uMzBJQWFmcnl0Q0VCNkpqSDBMV3Z6clMvdGsvCmJk
WjVyRXBqUmQxbDRkSWZjbWkwditkOGZoM2xLelhLbWdZNEl4RlJTMWMxL1BRUGFmKzZXVktUbG5X
R1V3OWQKN0kzeFZPdEcyTHR1azJoQjdrUEpUUFVDM3hmQXEybktoRTNkdlNTRzh5TDhSRDAycTFQ
SjYxckYvWGUycHNlUQpqcTMvSzZmM2ttVnE2Um95UkZaSGloL2ZSQTZmdGxUTDBPclZkbndWNk91
QnVBQk55THpQdUpFK3crSnpSM2Q5CkRHN3kxbjhxZDFWYm1WSVc5OUsvcXRlMHRMYU0yUzRycmZw
bnZXYlN2ZU8vYTlyNmdLSk4vaTZWQU52K1djVVoKQ2N5RkVSQzVRNi9Gd0h5QmdKbmExUjhHNWJ5
cG1MNVdzczBVTk1lSjVYUEluSklRSGE4eU1TejBWM3orcXppQQovMlNmQ0UzK3Z6b1RVYUNJY3Iv
bVJ1STM2VWxrck5GcTdOR1Y1bGQweER4QnZ5WiszU2lES3BvWTlEYnBLb0pCCmErZlNXSUtxcW1N
dTRVUDE2YjhWczNEMTU2Y0VNT3NqWkQyYUcxRT0KPUhyeE4KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000d82e30624e6accd--

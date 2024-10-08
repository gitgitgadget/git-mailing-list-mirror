Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E7929CEB
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 07:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728372597; cv=none; b=DjHhfmeA1ltOTMHGu/4otofV2d98U7f9fb0J/N3T2t5uNuXC6Ez+J3QQXRZjhIYd2gxSoe8/Pl4NrN8MauSkugB6W945ln11CSdVekhfE4APa+duRepozmf/DuD76aRX86Sde8y4C1d5ONRWTstdQpR2w3z1pYAbJOqzt8jxwyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728372597; c=relaxed/simple;
	bh=MYzxhgev0pz+w+5oq4rOfkGL6RoUSybhSdMnXGTFAOc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vpng3Gq9PeUghby+j5VgbF9BfPZIc733ZKgmYBhLdJvtEzHpL/a8WkJiEZEQPnXqhKaDlbtvhnRPIMmxRxeq3NIgJs9wkRczogUhxy2VJuTJUlKNVNwA+9R3LtHfQlAM1E/Lil8RLKl16TcYrOCwOzGJsqILvsgOb1BKfHzeD7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a190oFpE; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a190oFpE"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-84e962c9a99so1623855241.2
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 00:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728372595; x=1728977395; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MYzxhgev0pz+w+5oq4rOfkGL6RoUSybhSdMnXGTFAOc=;
        b=a190oFpErQDYKY1SngaMPiJt0sWdE7NxUtbrdArLjGZO/YaoWM4aVEfaNgiMEfalWy
         a8O4pujGjehQ0P0ht5KrmIkm20+uJzpBs9V3TAcxQsz8rEcSmP3LTyeMwHmK0o/bebc1
         MSThWIFr22yQNRGFqGcSLInDy4UdAhGPCVqDWdANj4cejkaffGz8cnP81HJ3bPOwHqTF
         WZQqa8grnYFAkAJfwfEdovJSdSWWfIZAPIk93Pjp5MEwWbsb2owpr8AV1ymIo9XBhmfi
         99QrPGqLal+VUVrfWqWVv19jtnUWvLHbcXSQ5I/IHoZAyZtrO6zpmHhm6iCC5V1acjYi
         04MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728372595; x=1728977395;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MYzxhgev0pz+w+5oq4rOfkGL6RoUSybhSdMnXGTFAOc=;
        b=Ii0U21A+BGT70QAuw5VoCtgf8p4/+RvI/4vOig2sIdHw00KkbQvuZ9WbnLHnC+XUqe
         oByOXtB/R9CjMrdzvEUA05f3qPuXVLL5Vu8MueZR2gzppYOWJJkyjutLyiI3Ikd1qcdZ
         8XTx5m2Fp6teOqYQxV+ZcT492o3XHXAY8iQ1fql4+mxD2l3h1f1GSfK0SYYVQ34vhFhr
         6r6ZBsb2WCb1Ag1Vki6C8PTwieLeWfQxaqZgcCoI1VaLbDWlfqaK3jRXN/oD16nY1Pzz
         mDd0+NwS5xUqsR64AHsFTM+mWbquAuCmpvNH49nLVy4mZ74DLaa7a1chym4uBA6tILhB
         whGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBPcwaXeOcsAIz8szH2pzNXWy4n09VnPHSIjgItyZk7z7xjxl15Q0DNS4jbkZih+8GDdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM00382mPRvTqQaqM2RRHLAdUO2xdY1pTkm5IsUk9253yU3fUl
	2JZPtFLoLygi2g8xhx0Gqr8P9L/BTRW0o0a/TJphH/V+orXnTVYNbGPMvnBcDsn9LI9T68dffXy
	EIg8ikD2PySBqr9we9O+HNTDoowCDKvwS
X-Google-Smtp-Source: AGHT+IHhqM5TyLibPCOCgGi1pLjdoAwA2WlS4TznEkbEJ71Yq6Xen7+XBinrJMVGymunB9Wf27x2LUPD2kaekA7O80I=
X-Received: by 2002:a05:6102:3a0b:b0:49b:e62d:b5d4 with SMTP id
 ada2fe7eead31-4a4058fc020mr12303742137.21.1728372595105; Tue, 08 Oct 2024
 00:29:55 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Oct 2024 00:29:54 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Zvj-hjBXlWr803Us@ArchLinux>
References: <Zvj-DgHqtC30KjJe@ArchLinux> <Zvj-hjBXlWr803Us@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 8 Oct 2024 00:29:54 -0700
Message-ID: <CAOLa=ZQ4VO52nGjTX1nbzj3zxSjijmBUAsEq=OsOFo8xjMwVYQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] ref: initialize "fsck_ref_report" with zero
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="00000000000092429a0623f21a6b"

--00000000000092429a0623f21a6b
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

> In "fsck.c::fsck_refs_error_function", we need to tell whether "oid" and
> "referent" is NULL. So, we need to always initialize these parameters to
> NULL instead of letting them point to anywhere when creating a new
> "fsck_ref_report" structure.
>
> The original code explicitly initializes the "path" member in the
> "struct fsck_ref_report" to NULL (which implicitly 0-initializes other
> members in the struct). It is more customary to use "{ 0 }" to express
> that we are 0-initializing everything. In order to align with the the

s/the//

[snip]

--00000000000092429a0623f21a6b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 28966fd2d434b424_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jRTMyNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meWtUQy85dzcwUkw3QXRnTDIvbnlzTjdhUE1CTmErcwo5UE5LcWlqOTFk
Qk11ZkRoZjdXVWxicWlpWTJENEoveFBQSnorQnNqVzBnVkJ0OTUwZ2VXR3RZVkZzN3p2NFI2CmtD
aWVIRXFoZ2drY3RFTm5aZVJ5UEl5WG15bTI2czlsWTZiQXhBY0dLVUEwSVhtRUNLMDN1MjBrVk9v
UCtYYUkKeldJKy9PclhacDh1K0pYSzBzTjJOQjJtU21GcFVEWDhldnJMRTY1ZFc0b1JNTjV0WlIv
c01lbytwUkVLT3FregpJQnU4d3AzanRveVVrZDdXTnYwY0VuK3FhU0piQm9Ubm9qUGRPZUhuTGxM
TGtJM0t5Yk8za1hSblhQUDlzMDJ4CmZHK0ppWC85dHo5VXo0c1hUWG5sMEFJZDd1alI3a3N6SVNH
aU9MR3hxcVRQRll5RVpiUTV1aHFBV2R5dWJnQzUKbERCWmNYaWtuQWxxakV3SmpyaGFCWnJMV3Bu
VUVVZUdGYUpMZDZ4cHNtNVJXM3M3ckRRNjBQVzFlOWtaY0R4Kwo5czl0WVFheFhTVzlOQXNueEpY
Zld3WlRzYm1icHhHanJDSUdlUUZ1Ykl1b2pyWklwMXV2SkNMSmVqUEFvbE8wCmI0azFaL3FsWkNW
dEx0V3k5NmVFNzIwVEFkMm9Wcy9YS2RlSlhzQT0KPVVoWUoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000092429a0623f21a6b--

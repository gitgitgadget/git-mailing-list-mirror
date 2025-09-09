Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026A92C15BB
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 09:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757410385; cv=none; b=e1agwzeY4ipgRv0Y1DsB4JWeLitdXwCEQ1uNAjWTnJI1mXjb9Xel/xOqBASDIsmUc4DOxSSAS7mVTpIeqUTh1sNfm8zAz6Rk10rva0piJQifFhGY/JgfvwEw8SxQqpvfRE+7bFJSflys/DOeMpMCtUYilBl+ouWhS0geawlpDWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757410385; c=relaxed/simple;
	bh=+L2HrKEl4mQcLL3BHwR/MRIXZ+BxmYUSu42PDYpIdkI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RcIt3t1rSqkQbMVoG0jS1XLY0qODJUrjZBnO/T76h2tPKQqO1xWH0ERb8+oPenVuFo7hwadHAH7vpLO5wzCDNfLXuRsR8L7pvtW4WwkoF5IUcTVBxeg+qE0kS0n+QFYDX95kFY0ZEOmrlfLG3h8L5I8cNLE1CJrAmK+moG9YxfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUYjwArx; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUYjwArx"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-544ba00733aso3676125e0c.1
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 02:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757410383; x=1758015183; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FhyQUkFkjstICla2EOyWT9ZNq41seHmWz2QKWcDejG4=;
        b=ZUYjwArxgPdt/WMOLoImoKIDLn52tmLTTuKl2j72zoPB/cfgi7WY9AzeNhe3Ds1NJm
         uKaXXFkWXB0QTN7YQgzQCRSgeCCyedvMVwt8ZtGEtbVXGk579s6+Z6Ntk4sfdqAlqchy
         fKeBR9GHIolgQkrAvFrCAyghWgfWEYru/Z23VdF3cALT9XloR3IT6rBA3ccbUa8St2en
         b0ltphid3rghr1l3woW2JLaWejZwxhhW9A5yN1xF/rKhCFIbwpXuMCBo51btsMh79QFR
         EorVy4H7OFXdEbCk6KtqRYndlHi5tHBFYiQJZ8iHl/MvlheeX9xtFEadVhEIenBZO3BX
         qXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757410383; x=1758015183;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FhyQUkFkjstICla2EOyWT9ZNq41seHmWz2QKWcDejG4=;
        b=F1KoriKSqrwHxOaJjNXqY33Q8NMQOXNLQ8vkk8vNNMtGMIAV/w5s7uYC96BsFiE6mb
         vywmNcxUgzFBlV6EN6XvwjsZqa/PajhZCE/bl7frMyV6auKJu1VUKxMNPRMAQNgucv/k
         1FE25Scn2UG8A/HF+KQB+iSV+pi29KTJvh6gcuOFg7KfACRqZHlfdhYS0Gw5H+fUci62
         Kgd38u3IRKplH9UIQZ1AgXUDp/ClZ/idtrVjv6ojxZRJzOrfqyDP3u7/fWwaIZDHvt9S
         hKOEXfw6gRMd/sq7gRv4Qgj4P4DCGlxs3+1MVZS59OvGSUkI6cCPSjZ8lwcXlh9iW0+v
         VktA==
X-Forwarded-Encrypted: i=1; AJvYcCVmi/dGjzN5HbCWVUv/PrGzN+dr96KjWHuckb9DgEgGixAa5Nh1uWGl6Sg5IKTp8D7rzFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzISUGPixPGntCx56TSGc8g7nYmQHNV8Hw7FaChe28Y7bpOTJso
	eBMasWSMwQH+K8BIw+95isXrpEri+T6uYJfVbA04QrYDn0v6CeH50RgI7hSBqw1UpC2jmYt1e0o
	YkdWpF02zrejDDTmCCUb4MvQxVPJH4jM=
X-Gm-Gg: ASbGncsSD9jvaAE9GxoRfVT/nDYrkQriW2gkUEJE1nx72JidWedFbJ9YaVMryhGBMJT
	LnAbK6UcAcaynDlkxrECg6ZdB603U5lPoW2gwOgalQ0ZQZiSqPs/isSLqpV7bjMUAWUQRrAFr6x
	QvUIatA7Dy69Ja6gau830KHYVZJ+75JEEhfqzZ5+zcMNUapIQpN54p8GhKf8uXyBgBtUxft9eIp
	Pifdw==
X-Google-Smtp-Source: AGHT+IGqPQ6zkJNB8Iiwb+g3xG39pRN02DPbwxUvnB235GyNrz38KDdzpbPM+LY0hdNdFG9pBSbinQZZlLV4pFl5v8g=
X-Received: by 2002:a05:6122:8291:b0:542:97fa:2b17 with SMTP id
 71dfb90a1353d-5473c5c6275mr3594713e0c.9.1757410382658; Tue, 09 Sep 2025
 02:33:02 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Sep 2025 05:33:02 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Sep 2025 05:33:02 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im> <20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 9 Sep 2025 05:33:02 -0400
X-Gm-Features: AS18NWAm3dcm9ouC0xYML2KdNBcHCkTxpVPzMgst5Qhxq0LKBs_pK3soaAQueuU
Message-ID: <CAOLa=ZStgwBN0fMK3YxoqeR+1i772f621supva3Kvr7YPq4g8g@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] packfile: carve out a new packfile store
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000009564d3063e5afd44"

--0000000000009564d3063e5afd44
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> information about a object database's packfiles is currently distributed
> across two different structures:
>
>   - `struct packed_git` contains the `next` pointer as well as the
>     `mru_head`, both of which serve to store the list of packfiles.
>
>   - `struct object_database` contains several fields that relate to the
>     packfiles.
>
> So we don't really have a central data structure that tracks our
> packfiles, and consequently responsibilities aren't always clear cut.
> A consequence for the upcoming pluggable object databases is that this
> makes it very hard to move management of packfiles from the object
> database level down into the object database source.
>
> This patch series introduces a new `struct packfile_store`, which is
> about to become the single source of truth for managing packfiles, and
> carves out the packfile store subsystem.
>
> This is the first step to make packfiles work with pluggable object
> databases. Next steps will be to:
>
>   - Move the `struct packed_git::next` and `struct packed::mru_head`
>     pointers into the packfile store so that `struct packed_git` only
>     tracks a single packfile.
>
>   - Push the `struct packfile_store` down one level so that it's not
>     hosted by the object database anymore, but instead by the object
>     database source.
>

I did an entire re-read of the series, since I didn't review v2 and
there were a lot of changes in the middle. Overall it looks great, I've
left some small questions/comments on the first few patches feel free to
ignore!

Thanks,
Karthik

--0000000000009564d3063e5afd44
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b4e64e77fdfb2648_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pLzlFb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOUFVREFDR0VGRnpyQko4V2w4dy9HaDhLOFExSW9xMApRYWlFOWZqM0Rs
dzlHcEF6d2hXUXk5REljK3ZiV0FYMFRxNThBL0RrUk1WRHU3Ry9mLzJ0dDV1YmFkYnZGRk94Cmx6
WHhpWWEvOGR4YmNzV0hqMmV2Q1lQU2hyUnlacFp4K3REenJObzhXWWt3eUN2bkwrN21mVWRxRjRY
VzM5VXgKQ2EvMjFjSmFycGdrcHhMWVRmdkpldC9aVk42b1JydjlDMnJXTzlsN1A3NDhRc3JaU3Nl
REtUT3RhRjJPVElrNApEdDVmQ2h3Z2s4OHFYd2xZUXNWckJPbWNyOTJ1TWtnU3RDYm9ZMDliSVNP
VmZ1VzZ0ck0rMDBBdEZpVXhnSy90CjB6MjQ1bG5JZStmT2Fod2g3RkdQamVORHBwdDVXL1RMUVdx
TlR4eitkNmRvak9VNmM5V21NZkdYZVI2V2ZuZGgKMUVXb3B5dzV4ZlNaWFAvMlI2K0U3Ym9VTFg3
MXIvcEN0NzE4ZXlUM3VMWUtIRXlQbUNoRS9xam13dHZyYk1nMgprbHJJdVo4Z2hRQ1JaM0FqTnpJ
cDBnTndYVTFqR09ZUHh6M2gzdWpJNnpLZE9VMHJLTFpTTDFFVk50dVczMzlZCkhjQlNrZVVhOStV
VHFPVnBydUtWdnNxS21hSlJ6dVpHNUhGRWlhOD0KPVNUOEwKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009564d3063e5afd44--

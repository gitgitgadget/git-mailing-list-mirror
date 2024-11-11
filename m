Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F07A15B971
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321734; cv=none; b=qIkqgxptrsMBiOe3sPlKhQlA0rtCS3+jSAxer3q55bBKlGyRYj7W63GdrZP6UFuUyqqJS4zmqjClkBAUo6mByolwNBnDP62RBF1PWgRB83eQxoDy/ix8qujEipalmzj21SkoIBh9P9yfB4AUafz/l9Fi8Gr7UQhWScr3ByYA9hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321734; c=relaxed/simple;
	bh=EoIHEPPUWxnz08rJiQBfpxDmSjfqqPcx+8OvwFBbKws=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=f9e4ksAGhDDTMJJ8TQ+qZ1p/UyiBEKVxBRx8dNTWzCL2xh56azjHTIgoVtpX5JAkSSAUvM25QF5sMyscrUXUF3M2n4Lj9Z8oZHoFtnEQDf38hSSWhjh6vGPeBhkupZ2XOIGc6aBgIlBsMKkO9hYRKVg0NMsiZc1hgJFbm/lob9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aa4id+2t; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aa4id+2t"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-513de426746so1875829e0c.3
        for <git@vger.kernel.org>; Mon, 11 Nov 2024 02:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731321732; x=1731926532; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EoIHEPPUWxnz08rJiQBfpxDmSjfqqPcx+8OvwFBbKws=;
        b=Aa4id+2t9g4AtL2dmhSvZq4YPS5nq0inJf1AEMGp5CgAF1g1mZkbakBiRNC0vrMwgx
         dn6nxU9XZJzFmW4YgcMs7VXy8zObKNn5CQJ0O1+abfdzHqvneVouXcnux8r4QXc+5DhB
         fBfQqxGhlrQXbb/5DbCIdnY2NgoVDnn+Y+7M0GND+eOqXuL6GnnpNasLYYKsZ/Crw3CU
         Xj1hBrLGvqTDNlvdQvMU5uIfNSAhIxfCfJZrPnjXLlgLUqV65Fba3Bm56GIMcDmYJfGi
         nX+C6h5O42B75smwRc4ce96dWa8x2ELeJkZDLVZIUucboMPSTuwyTqBinSUa6hh/fc7u
         NW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731321732; x=1731926532;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EoIHEPPUWxnz08rJiQBfpxDmSjfqqPcx+8OvwFBbKws=;
        b=dEh+aJeiuY7xlLmFNBARs0I55HWj05DaMHGuW+Jhhcp9gLf7z0ajPgufPBTMi7DaKg
         eTqNytOpAKQTDJO8MMenaPl5xa2b+Ei60fbtvTEsbvwvfLtEsHrbczoQFeyewea2tVmw
         cJUNhfdmWaOfzfdQonv9RnbTH2Xh/1xBPXhPvidpyO6m79Ei9jU3VX9pltOK4XmSnwzi
         2S0UAfCdIivftfa8TftifWDaWMuPGCTqckrUeXudzrv2iAnJNM/3WaYwq5lCQlZ7pQz6
         wOiyRsOiQey7VCc4BT8b4vcvN2hJPqUTa72CKqQa5NSLNSrIa2cgdMvn7ADt1cEIu3my
         pYpA==
X-Forwarded-Encrypted: i=1; AJvYcCV6IzWnjJDSqOl8T6JzctXFfuXqu5fP0dEeaELX7sFoUEBS1rh7I4BucnY38nf5GUwalXk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4dA+rsd76EoSF3xdM14MNvw70Aq5l3qrupgLUSNdI28w1hECs
	LuS6z4ft0lF6KMrz/4d/Vr9Vt7+Wp6th7TVcjMGYTFT2TgnHqSLdj7h5qPN4E8eJ5kv0Avnsj51
	kFvR+KiTSJDji8p960miP9gtPmaWEe/NE
X-Google-Smtp-Source: AGHT+IGJFzBwufr2bjU/GI7V0X51BI2yBvyNAMoArUrYTpYjz7t9K9KK8NAJipa+VXCkQjFyZch6LXYtJX97GhRe7mQ=
X-Received: by 2002:a05:6122:828a:b0:50d:47c9:9683 with SMTP id
 71dfb90a1353d-51401b9012emr11410381e0c.4.1731321732298; Mon, 11 Nov 2024
 02:42:12 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 11 Nov 2024 02:42:11 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <20241108-pks-refs-optimize-migrations-v1-4-7fd37fa80e35@pks.im>
References: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im> <20241108-pks-refs-optimize-migrations-v1-4-7fd37fa80e35@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 11 Nov 2024 02:42:11 -0800
Message-ID: <CAOLa=ZSKH_OY5XG+toFUT2fD+6c7fshNZDfcOOSydxH23D91Zg@mail.gmail.com>
Subject: Re: [PATCH 04/10] refs/files: support symbolic and root refs in
 initial transaction
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000d895f40626a0c087"

--000000000000d895f40626a0c087
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The "files" backend has implemented special logic when committing
> the first transactions in an otherwise empty ref store: instead of
> writing all refs as separate loose files, it instead knows to write them
> all into a "packed-refs" file directly. This is significantly more
> efficient than having to write each of the refs as separate "loose" ref.
>
> The only user of this optimization is git-clone(1), which only uses this
> mechanism to write regular refs. Consequently, the implementation does
> not know how to handle both symbolic and root refs. While fine in the
> context of git-clone(1), this keeps us from using the mechanism in more
> cases.
>
> Adapt the logic to also support symbolic and root refs by using a second
> transaction that we use for all of the refs that need to be written as
> loose refs.
>

The patch looks good. I was wondering if another way would be to just
add symref and root ref support to packed-refs. But that might be a
bigger undertaking than what we're doing here.

But thinking about it, seems like we can do that in a backwards
compatible way too.

The changes in this patch look good.

[snip]

--000000000000d895f40626a0c087
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a91e7f8af169e329_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jeDM0QVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNCtPQy85OTREVURhMktpUTA2ZXZ5cjh6NGtxUjRQUQozOXl4enZiOFdv
L3lOSk5XUU5zOGI0dnBGSUtHQWY2MWIrRHlGS0Q1NHEzcmRObnFmSTN4MmE0azM0aVcwdEZqClFV
bkd6TTZQTkFvOEJoQW95MFQ5c2JFc1BuSjlPUk4wUk93c000di9yckxmRlo0TkJ3QzF3dVlMSUpL
Rm1WT3AKNlRwMG4yZWtTbHhqd2ZOYUVRdDZrekIvdjRYNVlCdnBnTTRJQmFuN05SdW5jUzI5NUxp
aU9Ua09FZVZmaTh2KwozdmEvM29wVEFyWk5zelVNUWI3emJQbmdGZWFxb2hmSEhESnMzYU4yejVV
ODNYUkZML3g4SnpnemlkaCtJbUZhClBlRTUzMk00Q1pnWUd6OURkVVdJMDQzQTliNzg3VzRhVFZm
Q3BFWHdrMk1IOHh0UlFWc3A5UGhVcWNFZ2FBRXoKUVZTTGgvczF1aTE0TDY3VmFXdUZkYkF3ZjZk
MjdrU09kOXBCSksrRUxVQTZFZEIxa2Z3ejZNckFXdVlGbm9jUQpXMFFTUmZOeVhHem44QmFJUEw2
aTlBT2VXOStyNWFVdzV6QTNJYU0zWU56R2xzWFh2WmtrL1pUVXFtSHdTb2NhCkgxRHlOa0IxNkp2
UnViZCt4enBDRFMyT2ZSYU94MHp6MmJNWVdFaz0KPVVzU2IKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d895f40626a0c087--

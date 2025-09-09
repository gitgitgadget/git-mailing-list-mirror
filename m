Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1244B1D5CE8
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 07:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757404190; cv=none; b=qkWN79MRoJ3JEm/ZBjM1ZB0g8qrCk6/SbjsyZHNUdFbJ0BQgYch3WKAPd9e6G9FERYDBbpUzVUM1mys2VwENjSzQkCKb29Wj7ki6IfbAcLM6Bddkbvw0gl7nlaXpKK2cUPzhDlo0e47NRD6QiIsx/GnHFccz0yqpxsDQaE43E7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757404190; c=relaxed/simple;
	bh=p9nlhxtSMSOkEaA5QIWj7oDCCF6ohk/lKj4UCFusbiQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QECTIv4ZiNFl48UYdZJ40U8khU8g0wXjU6hhVMS4bavP44Mgm3c4W9lb5DPjvzsytyhtEiKfU+IqtlZP7kPTqUyEJ72Ukwmv1rpiCAn5/JG//4aGgPikjyAbWxD6Od0B568UgbphZFKDe/7/jsv1ZF+efF0NyJf1kKKXEziHwdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRjN1K3O; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRjN1K3O"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-544bd485420so2172402e0c.2
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 00:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757404188; x=1758008988; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rsd8NMydnX/5sHXLXnhoQ5u08Rbls/Cws6NrdRx9oL8=;
        b=jRjN1K3Os9qQ3zYc81N+4Kk/Q3rWBcbEAxChe250eFbpx9iHwSiNeeZMZNp2lVzvgO
         g1Jivm2gaw71bJs2B9IOoxlazws+Yz4KeKr1b5nyO4KcvwM0J/lg+YNf4SYC4MHv0WA0
         thLkD/+xyveyqyhaW4qJn1Dp2DoRtXJAQ2nvHZamB3eVaXanKBnxJlDoZvUPmQ96UwUa
         MAtGoXa3TA9MGJ6k8Ifg3IadSkLwF7WVx505WQV6czzeL696zPRI9SJgYWrslP+6bNlI
         0ickfbZz66mvgZt+dZSE+YW+VKMmHgB5Fn5ChFhPfR5nX0xvz61iEnTW50TYyE5EvzHP
         B0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757404188; x=1758008988;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rsd8NMydnX/5sHXLXnhoQ5u08Rbls/Cws6NrdRx9oL8=;
        b=lrwiMlgTkymhcgWDMwraBq1/SRIBE8NMdQjeDFaYu3frMw1WIT5uyE++KuQ3cPrQ/J
         gE6lsUTxYJW5wBrNS5QcWudMVDxUkvvEvsjW8rN6WDLjurbDvIrqX0FotVAosxQmyXt8
         +EDlini98KQGbBrFKXJpgm/0SCfWZBrH4kBTbqOG2Wa7osap0tQohEs7/AWUcCZBbJWa
         4BLZ7eNB6Ar0pv5pS5J9IoZcaIbQnVgVcHHyyhFpTAL0sfRKXgMl8xT2TsCfFXHReNk4
         pwJorXYLB46miQqEAMNM8d1STfNjeAR4qCrw2XmNw0P4PDnt/g+/8CQl32CbhG1mg7On
         ayRg==
X-Forwarded-Encrypted: i=1; AJvYcCVK7koj75FBnEgIQPU55c4IVeIzTK3HRlcMV0W0/p/B10TSpqsSOs8IWHQYh+Md/xWouxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7VhkcmdZbUgdZMUQLnCJ+HW1kY+a/Jw1yD/CBdDT+jjGWMY2G
	Egu0N5D3UlnUag0SRNRbhISt+Ni7KIyRfWtubVee/+GkbjvvPOhe4ycDZ0rMqK1m/xoea6q8X7Q
	D30T+WSdo8nUTK5pIiKe0AFh/gpX7aMI=
X-Gm-Gg: ASbGncuU1PjJeX+wTPDvvMhr8iEpH9Epg4/cWqhY9gMf3xZejQZXARTEKviZqlTeC6J
	PIJpRkn9LepEhngYx8kJv/HyBFnpjghfPyL0Bt+IHXZ53neV0GI65uqqdsLDPBwav7QTfk/LZX+
	BoNvw7dCHWHMoBGWsJlx3Icfg14YF3NURgd+FmWj3LNHPiNW1fCcJVETal17+tt9pOJwOLHDfBU
	hqugV6Bft2NqBX4
X-Google-Smtp-Source: AGHT+IEW9dWGidE7wXA3tiQtJi1+93h51O8/vvXnw5hvAGkYaWYdl1GG7f0RZMjoMxfdL298yXd60G2gjF0H2uPQkbc=
X-Received: by 2002:a05:6122:1d14:b0:53c:6d68:1cd0 with SMTP id
 71dfb90a1353d-5472c3ccfecmr2946255e0c.14.1757404187800; Tue, 09 Sep 2025
 00:49:47 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Sep 2025 00:49:47 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Sep 2025 00:49:47 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250902-b4-pks-packfiles-store-v3-1-6925278efeda@pks.im>
References: <20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im> <20250902-b4-pks-packfiles-store-v3-1-6925278efeda@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 9 Sep 2025 00:49:47 -0700
X-Gm-Features: AS18NWAIp4FI86sqVfhIxwRXtzAf0TlRxwhXlnFDtprH8eqBiRArz6F8E5XeBzc
Message-ID: <CAOLa=ZR0H+2qy5jR=iTnBPWQKpbX_1zBef60iK6VUENP6mU=yA@mail.gmail.com>
Subject: Re: [PATCH v3 01/15] packfile: introduce a new `struct packfile_store`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="00000000000057517c063e598c30"

--00000000000057517c063e598c30
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Information about a object database's packfiles is currently distributed
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
> Introduce a new `struct packfile_store` which is about to become the
> single source of truth for managing packfiles. Right now this data
> structure doesn't yet contain anything, but in subsequent patches we
> will move all data structures that relate to packfiles and that are
> currently contained in `struct object_database` into this new home.
>
> Note that this is only a first step: most importantly, we won't (yet)
> move the `struct packed_git::next` pointer around. This will happen in a
> subsequent patch series though so that `struct packed_git` will really
> only host information about the specific packfile it represents.
>
> Further note that the new structure still sits at the wrong level at the
> end of this patch series: as mentioned, it should eventually sit at the
> level of the object database source, not at the object database level.
> But introducing the packfile store now already makes it way easier to
> eventually push down the now-selfcontained data structure by one level.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb.c      |  1 +
>  odb.h      |  3 ++-
>  packfile.c | 13 +++++++++++++
>  packfile.h | 18 ++++++++++++++++++
>  4 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/odb.c b/odb.c
> index 75c443fe66..a2289ea97d 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -996,6 +996,7 @@ struct object_database *odb_new(struct repository *repo)
>
>  	memset(o, 0, sizeof(*o));
>  	o->repo = repo;
> +	o->packfiles = packfile_store_new(o);

I assume that the packfile_store needs a linkback to the odb for some
reason which is utilized in the future commits. reading on.

[snip]

--00000000000057517c063e598c30
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ab95c9aeddc7c44c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pLzNCa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMGxXQy80dWtaSHV2UGtVWVgxeDBHWkV5QkJDRVU4UQp5ZXFCVmVIWHlO
M2t1ejh2UWpsUjEzZFRIcU1TUit2NU1PdXJZRkZ1am5qV3FEbFJyNEpSN1RndW56U3BiL3F2CnNj
SEJBb1hDSFdNdnBpZDZtV05RT1ZBKy9QcS8zaTRubGsreXBBTUJmYzlPRjhrVklVTFkzRXphUjll
SEhSQjgKb2x6WmNpelc5aDNjb2FLbkwrSzBhTk5telZzaVhid0lzVWtTQ3JocHFvRXAvQlZZL2lR
WEEwYlIzcGppNkIwcQo4QmE2NUEvR2Jhc2FoOEgzS1d4VUNoenFsNXhpakFwSXFFTm1LcTFZTVp2
YXBMT1NDZW0zaEZjZmZkeEg1TjlvCmxtdVZhRUJUR0hIallRN0dDaFJmanB4Q2tNc3huSGxjZG5r
YUlUZHduTkhRY3dPOG1tUm5rM1VXZWd0SVZGQW4KSGg4eVVoK0xwam4ydnFXTGpZNU9yaFlQT2ZT
TWd1OUhxeXN2T3Mvd2pOUXlmUmhUaHlSaWt3NzZEZS9Eakw4NApPWm0wV3BqSEthMzB1OTlqc1Jr
MjBJN1QwSS9qaVkzUXZyS3lNenJjbHk3d3dlSUJNL0FzM3ZwalFXZUxWN0NTCkZ3b1RoRVNpanZp
bFZ4SnZBek51Um5GU21odWtvU3JWRERCQmZCYz0KPWtqL3QKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000057517c063e598c30--

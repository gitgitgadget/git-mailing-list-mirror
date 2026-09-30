Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9732E1F0E
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 11:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769566; cv=none; b=Jm7KUC3vXOyVXRQaPNJdbipntpGk/EX3xwBCaw1F60SEf81i3Wp3ukLeaZk/aw2ubIbctEFHUqy5hictJ922ZWhQX2qvAlM4Qg66aYuFb2nB3HYKoi15sZmLbUMgsYSg7tWhxJ8E1E8/nqFm1RgEEeDyP9ozPyEv1cc48VIxGNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769566; c=relaxed/simple;
	bh=Jx349V7p7FOfHp+dyqxUEVkXMXIx+5TIY56xopEN0hw=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=bsBZhvrJUN95OgFkHS0DCT45+4Ioj3isEtWesjeHNk1OiIGHAO0Y60pCJOUBCpHml4IqdW/aXMzLJ4GBQnHO8ud6jjBt3hYR2Db0Nsjmz+iDWmb2kCUzJKTE2mHzdhEShnsviNToKzEkkw+/tK6gdaeXFObdsDsEjSUEEzyo8sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=au8F9RiI; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="au8F9RiI"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffed768deso11400425e9.1
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 04:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790769563; x=1791374363; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EZr698hgiWIqapXMEzeX08fm8Z7TfI8zbISK/Q3LgKM=;
        b=au8F9RiIMLtC2oKkmhsg5BldrcQM0yO3moAY3opqSr7OfGvIg/8x3ewt3MzJlVyMgf
         qFbbyu36jWE58eCsNWfBQWn5AolO6Vc7qMUY5DS9sYBSS2RVT8DSrxCCtMlb9gs2HsZC
         mVXh1IU+tWbScO4FIcuxVtapM4Bmzd18k6M2wwdMobL73E50/C0WiGWA/dnGZ+iWpUqj
         r4P9h1WJ0DWa8FBon3SBBhY+BIopi5BDeOS1IfrVJ8FN7IDul0agsAieQhv4om1ZFU4K
         ddfQYrmWtjRwBEWSquUbKZspU3K4wPrkpzi1sUjnBsSdTZdN7NTvsltKQ7gNZM1RA6PX
         hdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790769563; x=1791374363;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EZr698hgiWIqapXMEzeX08fm8Z7TfI8zbISK/Q3LgKM=;
        b=lbvQeYihiW8ndTEYdA5Nu2Fj8/bi8Jru53S7UbDpgOgwxNclLoihGypr84KmpmpSX2
         5vnqQFlsif8POOjihNMclHk+ru4VBEdivrkBuUnt+c6nStZyZS1AyBS+rUdNIRYP0+F2
         Q0gjBkV7EpNrmvukIyZav/poFYK9/+Z6lcvi8VIBBf3x3CPEAGmIgivlsIR4f5tce8MS
         yeee7pzABAjGuUaQ8QcCo/mI0cTZQVaBIFrySK9N+PO7F+vJeuFFDxo5Ag+jj2I/yh27
         0iDVVSrFgcpxoHdnBsJHv8XlwB/88WDDdYqD0s4YLgHHRlI10DOaLMIxENemE3ouCgta
         nnoQ==
X-Forwarded-Encrypted: i=1; AKwUvBwbsFydtPgW1J6semAdPbD1Rjuu1SQLz78L+7xUKVKYHpZLcCxuuLtIuZJ7hEOQOcfS4O8=@vger.kernel.org
X-Gm-Message-State: AFuF++lu6/PK4w9ctw5w0GkfsEkASt9yDRRfiua/uPeBG/86x7wVyD0S
	az4tLuD6OgNgtElbg4fVcZJPZ5z0LwdbeZ6hX+0e/39GBJFfbe84sZwcb2r+b5wKrs8=
X-Gm-Gg: AYBFou1wvI+wC1cz7Ejbqh0hQdCJLs82BkX7DZBWN0oW7dhKY80FmQWT4PXBeIPRppg
	iQKyahi1ascmUHlQr+yGR/RwofZLl+sBebutLjDp/Db5rCHX0+sfC7jiOtoGRq+ZG7whJIovy0g
	4m0WqGY2SI7MvfFX72FzxTkEo3K/ZCtE76dkyg11oPu+8heK/ToUU+IDOBkckPt5A0J+sAypp5a
	YtkjUkidXcxP+Rxmc6OlXjaJCwF7xO5mEqrY0PjbxaU3LT4X/490J9UYjBBy8PVWoWiTHklhXQH
	KE5C6TnLKxvcGXtmZJlpMZzT4I4I+3QR7fgQScHO/E/cHmJ7QrCa/nPvGYGj2ObNelVFK7mLPZ+
	WiV1+29pvCSjiIaszOCFDKZ+mShcze0G9GMeOvchDwX6yOI5ywynVC9lQ9oRVj+vxdtrjqWHJJV
	+Rllmy4DigpKcgryq6yBK/9SfzOYGlf0CGIleTv4AfSbNk5AlvJMD0U+dt/hE4LBFtGx2WDIgqq
	uAxDA9cORsMGX9ztA6vbzDtWLkxP50bZWpMZPTu+hMwrQXASJ50G5JBEreO1sederbdewhu6H32
	TF1Zb9nW7nz0UU0EJPkMhntmmElcvWhdP3jol9gYnISXLqO+lKkUz8OSfeDEGxCTT/lCAGWvRUx
	KH7fpwtSPpdHOo/4TImrqs3gTHIBfVmFNcg==
X-Received: by 2002:a05:600c:4e86:b0:4a0:ec5:46d9 with SMTP id 5b1f17b1804b1-4a01b12ae3emr18958935e9.0.1790769563050;
        Wed, 30 Sep 2026 04:59:23 -0700 (PDT)
Received: from localhost ([2001:818:c665:a700:4e1:afcc:bdec:a44d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a017520f98sm45132705e9.8.2026.09.30.04.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 04:59:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Sep 2026 12:59:21 +0100
Message-Id: <DLSMTVIXW120.3F87OEHJW1LEC@gmail.com>
To: "Karthik Nayak" <karthik.188@gmail.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>, <git@vger.kernel.org>
Cc: "Derrick Stolee" <stolee@gmail.com>
Subject: Re: [PATCH RFC 2/5] fetch-object-info: add enum for
 fetch_object_info() statuses
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260930-backfill-dryrun-v1-0-1128f247ee01@gmail.com>
 <20260930-backfill-dryrun-v1-2-1128f247ee01@gmail.com>
 <CAOLa=ZQ8hvAxpU6SQ-KvN4eK5xMtJh4PoLXfDiNPmG89GQkMYQ@mail.gmail.com>
In-Reply-To: <CAOLa=ZQ8hvAxpU6SQ-KvN4eK5xMtJh4PoLXfDiNPmG89GQkMYQ@mail.gmail.com>

On Wed Sep 30, 2026 at 11:56 AM WEST, Karthik Nayak wrote:
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
>> fetch_object_info() dies when the server does not advertise the
>> object-info capability. That is fine for git cat-file
>> remote-object-info command, which cannot work without it. However
>> a subsequent commit needs fetch_object_info() to not die, to be
>> able to fallback.
>>
>
> Nit: The last sentence reads a little weird, perhaps:
>
>   However a subsequent commit uses fetch_object_info() optionally and
>   requires it to not die.
>
> Or something?
>
> But I think we should just squash this into the next commit. It doesn't
> really need to standout on its own.

Okay, squashing them makes sense.  I only split them to avoid having the
enum buried among the signature changes.

Will fix, thanks.

>
>> Add "enum fetch_object_info_status" so that fetch_object_info() can
>> report this case to its callers. It is used in a subsequent commit.
>>
>> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
>> ---
>>  fetch-object-info.h | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/fetch-object-info.h b/fetch-object-info.h
>> index 2fba96c6f7..663a7f3ae7 100644
>> --- a/fetch-object-info.h
>> +++ b/fetch-object-info.h
>> @@ -16,6 +16,12 @@ struct fetch_object_info_results {
>>
>>  #define FETCH_OBJECT_INFO_RESULTS_INIT { 0 }
>>
>> +enum fetch_object_info_status {
>> +	FETCH_OBJECT_INFO_OK =3D 0,
>> +	FETCH_OBJECT_INFO_ERR =3D -1,
>> +	FETCH_OBJECT_INFO_NOT_ENABLED =3D -2,
>> +};
>> +
>>  struct oid_array;
>>  /*
>>   * Sends git-cat-file object-info command into the request buf and read=
s the
>>
>> --
>> 2.54.0


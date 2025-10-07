Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8156374EA
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759847279; cv=none; b=CPzHq6IkF7XQJmT15EnEFbCEOHVa9cd4p/XNkUMVtc7Ya5UiWlYaPuTGfT0HPFKMIIpm3W3hbqB0r+z4qvGulwz5f0baltVBcXkx55oYStr08ko0FoRmHTST3jv9Xe+ozEf9kBNuGdBEtb152fcPXBJUQQe17uKle4e4G2Wtijc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759847279; c=relaxed/simple;
	bh=LCHeYhPX2vxruvfrSK02jLOASRt0w4ro1LRbNsV0ocw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=XJ2CAbtbXLPwnvljKxXwOFO2oJw/J3RSDTwtA7kjsW5BMRIle/F1cE1pIcMMlXMeDejXgiHkJuoJk0K/aVGOUS7cUwiIPbc60/TVLGkRsI3YkmN+VridbF6OG9E5y45VMX8kIe/5NLcWQ1aQDfKUP9cSd5im4UIx+5svvsUzWPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lg7wCYGX; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lg7wCYGX"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5565a83f796so5262038137.1
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 07:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759847277; x=1760452077; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gIWmVjaiyiG38fQI1PcJXIDJNbHcf5NSPvreC/tzyFg=;
        b=lg7wCYGXN+AmkCRxpQx6ZJMg3jqs7YLz74ZK5wsG3Hg6Szavw9p1TciTxBfOFE1LAK
         k+CyBGoxWZ9uzXzptN3Gz432sIDu9s89S8eofdRGFUOux3GK3ykwzgGrVvHle1dQpGhl
         1iGWQ5apmfpShZic8//JLxy0a/s5WI5Vzcj+thG4RxmznL2zKGIug5OX2Pd+MIDQhrZL
         hXvw7T/K2NJsblZpgXObZVKUr3bOFMoHNMPIDqq1M9Wcf87DDSoBKhW0K9D+7v10MQFJ
         OraVjR+i/G69ptyutLH+Z0XyU1TX1wubnQyEwpDBABDluMeSs4BPjnmVvfbBsLPG+21e
         SDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759847277; x=1760452077;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gIWmVjaiyiG38fQI1PcJXIDJNbHcf5NSPvreC/tzyFg=;
        b=aT62C7HLG2VhtmvSZLYpwURlbVt2LnAXFCulXSD6ze8ZjuoWRZiYwa5QlMiKWfHK3s
         UBVbm4CWJDb3vP1mCgc5xUmCA6yigzDz8/clbuoxGm/GD+jsca00uxG7wEXlJvdShf66
         amidXRJGvGC2JWUJQRVEqBm7gwC0zrwfRMiaVMSiD97agZ6tcPILWyVHp6keK1aY2Yn6
         Zw6bpHy2ncbD3lONzB6wOkib8aVBt+MlybdjkqL0YVgeVFKFGNTA9qdzI93/Un/2h+eJ
         NivXVXqLPZ1QUBxNaFG6ORyqV2kpGpGuwJ7JaM0+gkMEIG/U3OshhyZtA6Xscrpr8fnX
         i3Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUcO3jkaXfUPZET+lcUJTsbCCSmwADiMMUb4e3DcMjC9wIgf4dvRxxd4Oo7BigUFwIHKxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0j8wuDoVC6qlq/ftQ9lRFWiDJ2AHykYw9F0M1aPwviv0Dl3nV
	QTldJ7ytqQ02drdDucFhPqBUi7UAMFhkY6D7TfSldNcU3df3PCkrKiqY6F0GhlCXt/XapdQZI/7
	Vl0xDh8j9jHPSCPGARUiWVu772JeoHiBVKP4t
X-Gm-Gg: ASbGncvdl/faRfKf3iDnHQGuM3udKMxNn3bCq1YOYYkxfYwi8ql8Qu7zpNggyUArT9n
	NHoCX1B2gYBdoU8SwiNQb9O0fcTY+usShpvh1RrDE/7MKk38F+TucLWaySx/nzeB4iGaP80M0WZ
	lq9edlcW5rNL1n1imwdvwC9xRra1xIvp0gVgaaVZhY7xptBP9QC9KnjjfzYkCfWyeO0c9gqCAKK
	Q1eAMPBoxGGSBNwOMN2UC06LUSql6iX08CSZxQ7KAFKeHcBo4X/9OJFQU6RDg==
X-Google-Smtp-Source: AGHT+IFw86o6W48Xpo2sRXTTihvSAUqSXB+4ODS9bToI3EtopVYtUDWOItVd3KX3v2I9231y+P5D0bHwkYe55nDs7Yw=
X-Received: by 2002:a05:6102:3586:b0:523:a3a2:2638 with SMTP id
 ada2fe7eead31-5d5d4cba2c9mr1721101137.2.1759847276460; Tue, 07 Oct 2025
 07:27:56 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 7 Oct 2025 07:27:55 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 7 Oct 2025 07:27:55 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-3-916cc7c6886b@pks.im>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
 <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-3-916cc7c6886b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 7 Oct 2025 07:27:55 -0700
X-Gm-Features: AS18NWCiz1UWolcHCxxdM1OR-SocUrrf2-AxunIMgzwG7C1ZHOk5O9NxV6lfllc
Message-ID: <CAOLa=ZTL7kY6_2AqjYJGrjnKgwWVBbjrtgha-dBR-ijL7C87tg@mail.gmail.com>
Subject: Re: [PATCH 03/13] refs: refactor reference status flags
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000c5d9550640925f45"

--000000000000c5d9550640925f45
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The reference flags encode information like whether or not a reference
> is a symbolic reference or whether it may be broken. This information is
> stored in a `int flags` bitfield, which is in conflict with our modern
> best practices; we tend to use an unsigned integer to store flags.
>
> Change the type of the field to be `unsigned`. While at it, refactor the
> individual flags to be part of an `enum` instead of using preprocessor
> defines.
>

Using an enum is much nicer.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs.h | 41 +++++++++++++++++++++--------------------
>  1 file changed, 21 insertions(+), 20 deletions(-)
>
> diff --git a/refs.h b/refs.h
> index 2b24a3d997..8f484e2ffc 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -333,27 +333,28 @@ struct ref_transaction;
>   * stored in ref_iterator::flags. Other bits are for internal use
>   * only:
>   */
> +enum reference_status {
> +	/* Reference is a symbolic reference. */
> +	REF_ISSYMREF = (1 << 0),
>

Nit: It would also be nice to rename these flags to
'REFERENCE_STATUS_*', since that seems to be the pattern we generally
follow. Doesn't have to be in your series though :)

Rest looks good.

--000000000000c5d9550640925f45
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 171634f8ffee1e6b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qbEkya1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMlUzQy85cHRyMmZVbUZzRE5WYVBrL1I2dWd5QkQ0eAowRDBIY3UyTzdu
bmVXcnlqdlVDV1ZFQXUzdHlxOVJRRkRTd1JMUjgyK015RzhjWUNsOEF0cVZsT1dRT3JFcHBTCnRE
MTBBSm1lNFhmdGtydTFVTEFWMDBOSVZjQjVzb0FXVm5MOTA3Skd6WW9LSzdUMVBML2o0VWNJWDdo
ZDRBS2kKbVltYkJkbmp0U2s1UDFLNFp4OGdXNEJwSmdFaUNFWUJqMG1Hb1NQRWdOS1RsT2F3cCsx
QS9rU3ByMEJ4Z2gyOApiQXROM2JTMGc0elJhY0tMQ2x4TlVDejJLcnRPUFpOUTdVazdIN29DWVNL
aE8wMVBrcXd1Y1hEcXZRM3QxbFp5Ck03S2lUN3A2YTZoM1FhN245Wm5KL2xRTkV1cGUxUzQ4WkhO
bVAvMHUySWd6QkZoNEM3WkZyalpRRU5UcXUwRTMKQzRxVmtOSUtZYU9GMDZzV0dBTG9wM1VIaDZt
WkVNREpOWHR5dmF6dFJyK3Z5VDRnMU9CQ3l1bkRERjBLMExrNAppeGR4ZkNETy9hQ3FHZWt0QkRE
WHJjRDBRSm11bG9JUXhxL1MzbEw4a2ZnVzd6U2ZTT1ExZFRsNTlDaWZhOVp4ClYyZy9ydkRZMmxU
c0pUV1Y1RHlxM3FkWE5oakNUdXJhaHlyVEsyWT0KPThNRnYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c5d9550640925f45--

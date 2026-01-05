Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C723A33C1A6
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 11:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611387; cv=none; b=L+dz/W8HAVyIHRIqA+8gKKV9+0Kl9AaKsGWUrkWsG5Jw3eM/hu9iYz1nGMhFbt6ovsuYk7yTCWOMzLKv04m7vyOpnwPLBi3pJ/RZ6NETshil7NvkreK/WKMF/kwbvevCllK450gBtJsJ4zVxGG/hDkckICzf62o+bsiZmbfvbz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611387; c=relaxed/simple;
	bh=WvTX0mwTXf+a+06DOSb9pRPOCXrGu0gGX+ufEuy3Iso=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mHoVoMVC78FLNnl/wAG95tJ3WEHPCSPEOCHGYBoaPSVLdHu6aMUU0t6WWfA+4rjyJGmN2BuH5keQ0YOuG8d2ouJI+3mIFlqysw11654FwMtraqzsrkcYS3KGdMpgWrScF7Ph/LyM09WGzXx0oZHMwv4+QElGTfskfXuMaHUQWwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsvMPYWm; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsvMPYWm"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5dbd150efe8so5498913137.0
        for <git@vger.kernel.org>; Mon, 05 Jan 2026 03:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767611385; x=1768216185; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cyiLBBDDzsJnRsozIaJK1X9MW8WkF5QCiUIGKnBriHY=;
        b=WsvMPYWmeB/3hubciW7IFS5UIk7MkZnnoPwq/Fae7Q4B8vERzh6jjkk7UNIvigLDZR
         G6X5NNGSf6FJ65dTnweD+Od/n642vwIiS97ZKl4wiAQxX7kJegxWOygy09/HNUrSyYVs
         A0hAAD2bb1WHHHHfz52sAcU6AHjos09dpBRhUBQ79ZSKjsn2Xb5ZG1VZPIyf0e4K3OxK
         i3LgiDNUMnd+JBi/rtg8b80SMfV74r8D3RZlhIXQ9N6/yupyNUC2m768V3ZEVvytfWdG
         hmRcCxqiWJdSBJtITwWGN7wFIzdBbTLYi1WqbBnOs0JdanBEh52DQeGyr0kRIOW1F+lF
         NR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767611385; x=1768216185;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cyiLBBDDzsJnRsozIaJK1X9MW8WkF5QCiUIGKnBriHY=;
        b=bP5tGDJTqphTDfmVLmkiy/321FbosyvHUsWdzbwNzjTCSTAn/MzCeEmUpiOXgQu/dH
         6c4S3oDgNsZ+P0BZbn80kjr0hH9WzMiiWeo/+5v/Rt/mbZeuasyWqefNnyvzILcvBUJl
         KVQqw+GxMzxrCNcnzUZYR6BXYgImp+/h/V1ETuL+XcR9V6FeNBg9sA5eKH8AC2C3NzIf
         k9Bft6YbFhLl/BJaWAaZY94AosLctetg86xXwq1Ax0QY2fsZtsSN4OSYCNrcjBfp03Fw
         gO02Y4sMk0mQVNwdhet9cWZlQZ/+a/jtKZ7druw/hxGZc/XM6y3pa/rm1p/CAeiNn77V
         vpOg==
X-Forwarded-Encrypted: i=1; AJvYcCXGp0ykQ93ZcYGVw9LE3kuwywXk9osiMeKxluHbhLjL+DuGkkx2yccw9k75TR+HRa75C3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsNdA/6GEHbF4PjDA5jFsBLdRFrmczffILMdGstbPKbADB6aZk
	aCzZc+NU57qkFazjdKXvbmCHeio7VNegWlxWhq9deZuM2ER5pu8OPjMxVtparFllDivkYlsGuFo
	JAdyfsin4nH5SGmcSUEpngNq7fxxYVPQ=
X-Gm-Gg: AY/fxX7YeOe1bDjmbsECOpACE9xHqgWj5XTPxQYj1Do/dUQ3wx7X6uu/u4UkMErvgQs
	GaqnpHSTdqFJRM+6OKf6j9rPTYoBg2adz3uWqiPZsC58ZcQA/l/oukYNyruoFnWeG1Psl7n1yaL
	nyhF4Uks3BNSzfXa9nV0yvq69Z7VgmNxMpUN5jJY7VOEa96qqOIIFXiRRTYBsQZm66Yorxi0bpX
	EzDqraQnmHSYEi4BHTDj2asQBns0t1Hplt3t7gab1WyTn1166v2X3mWMy1bSQa4udimNQWsmtMJ
	mfMPE+t9tP4JdCHAsTjsIpcIw0rr2A==
X-Google-Smtp-Source: AGHT+IEf5t0lbCEs8DafJAnNfLXghTPHkS7HanXpygsQ/n0A75oKjwY2y3HGn3uH4OH11ysX/T2oSqJbzVej0ZtQlqc=
X-Received: by 2002:a05:6102:5687:b0:5dd:89ab:aa08 with SMTP id
 ada2fe7eead31-5eb1a6d1d02mr14360797137.19.1767611384719; Mon, 05 Jan 2026
 03:09:44 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 5 Jan 2026 03:09:43 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 5 Jan 2026 03:09:43 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aVfzMsN2ouY3UBFG@ubuntu>
References: <aVfzMsN2ouY3UBFG@ubuntu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 5 Jan 2026 03:09:43 -0800
X-Gm-Features: AQt7F2rMEyZnvOJRQCKVRWOjXQXZx2GP7DKhwmLAnmML0PNITye9ncIsvapA57Q
Message-ID: <CAOLa=ZTOKvEQaMxymi+mRcqyNy4bZ4JbK2HPtq6CeewjHMo_=g@mail.gmail.com>
Subject: Re: [Outreachy PATCH v2] environment: move "core.attributesFile" into repo-setting
To: Olamide Caleb Bello <belkid98@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, Christian Couder <christian.couder@gmail.com>, 
	Usman Akinyemi <usmanakinyemi202@gmail.com>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>
Content-Type: multipart/mixed; boundary="000000000000b0030a0647a218f6"

--000000000000b0030a0647a218f6
Content-Type: text/plain; charset="UTF-8"

Olamide Caleb Bello <belkid98@gmail.com> writes:
[snip]

> @@ -927,8 +921,13 @@ static void bootstrap_attr_stack(struct index_state *istate,
>  	}
>
>  	/* home directory */
> -	if (git_attr_global_file()) {
> -		e = read_attr_from_file(git_attr_global_file(), flags);
> +	if (istate && istate->repo)
> +		repo = istate->repo;
> +	else
> +		repo = the_repository;
> +	attributes_file_path = repo_settings_get_attributesfile_path(repo);
> +	if (attributes_file_path) {
> +		e = read_attr_from_file(attributes_file_path, flags);
>  		push_stack(stack, e, NULL, 0);
>  	}
>

For my own understanding, when can `istate` be NULL?

[snip]

--000000000000b0030a0647a218f6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d2b9e38f5db20beb_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sYm0vWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM2duQy85bDlhYmMwcHVqK2FBOWxQWExuTjFsWDBvZwpoaHFXbk5GNzNq
R2NCVFVyTXF2VGdhTkRYOFg4aytFa3cyd1BEQVNxVHJBaGNERkJNWkdJWmpkbVNCUTVhNXpECmdN
MTBLLy9wRFF5VDRnVkZMeHV1aUc2VThPMWJkSU9FZHBZN043dDhPMW9jeU9qbEdzaDV1MTIyQzI2
U1BMWUwKbjZ5M1RkQXhCRU9RNmUyVHY2SlhMb0FsV3c1ZUNNbDUvZkQrV3NiVXBZY1BJbTlvNEJB
Q0lEWUMzaUFkMlMvcwpmTTc3QXhFYzF6UGV1UmJ4MGVtNWVhQ0tFbjRWUGhGL241c0JjTU9oVW91
bUpZTEVabmlIcTFGTmwrUUlpY3V6Cis2SFpWQm9lRTRaeE44cVd2MC9KK3NLckdVNkdRYnQ2c2Jj
Syt3dWxwcEJRaG9BT3I0MzcwenlUa0tHQzNzdnkKWWdRTXZtWnZsU1hHcTBTdXdua2VmZGRycmc4
M2k4QkZORDlzRFN0NEptQkZDK05kZ2NvVDZwNFllMWlKWjZ4agpQTFhkcFFEZUZMSFdBZTF0YXZw
dUJVZDNoK3dwRnZyV2RxTFBLRUZCbk1sNHVZNGFPcEJoKzBYVzM0NjFQUnZVCkdRVlp0cDNobURQ
WlUvK2ZEOVFzQzQ5N3AvSTZ6alhXbFo2NUoxVT0KPU5GRjQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b0030a0647a218f6--

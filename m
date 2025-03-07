Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29455219E98
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 13:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741354083; cv=none; b=PE6f7p41f9/QdDwc2913rtgw0gD4THPn9Nqs9yG4yv0pNE8bL9MKC4OX9+vTotLqi/wEcSG1LhP6KkM3UlgPgcxSBnCZOtu4d2iBzfp7GBZlA9lXxG6Hex7oH1sjZcB0UQzRzGB+PynZ95cMIET6/sNQh5ZAeFdLTj1ZqZA1STk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741354083; c=relaxed/simple;
	bh=6SI+hzIIYbaWvzlsgafUgbDH3o9RBnlVjfS21Psrp2Q=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LcEEJ+SQWCGdo2E25gxE3yJqFgMH+wN1hOMajoAuxifjyN53zmuE7Uc7AzqS7hkzwLwUNaTCfrZaYcmxhI4YWtjPwSDuV1AJZr55ASAOo0GCSXRVf2ETBYFpJiTkgCmgo2jyYpJEM1gRvpNK6qdaMnHfw30tr9HekDhXGOFdfBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcQX+RPz; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcQX+RPz"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-8670fd79990so778545241.3
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 05:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741354081; x=1741958881; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lnDOA4kqhV3Atpf4VTJqZZpRx+JcMe0dwMe1M8AXSMw=;
        b=QcQX+RPzz6h9n8W5jMLFQqtylanSPlWnnloMJGWRsSAi9DH87nv7qxibMVWWOpiWur
         ejlCNgCa89RzF6qhkJnbQ+zM13hYz0cFSAyFWsiVVv1P8wtJf6czfU9UXwkhxqq2bYx9
         454jVnu8SbND6nPRTSTodXXAPU2TBUwIRD4P9wExMgxsR4eZ8pDj3x1vwWGOe4bjhPNL
         SrjoEDPKoa2H535EYCKP6+JwADQ0uinus1ySLo3JDxFpdNJXqFJCjP9PR64pXWe1fEu/
         5V20TGdU/6SvMzxV+cjvoDcx12xCZChaZVjD6cmjqhX9Ce8IhRTICc66s/e+O2vQYsbx
         TsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741354081; x=1741958881;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lnDOA4kqhV3Atpf4VTJqZZpRx+JcMe0dwMe1M8AXSMw=;
        b=ZjqQexl4jedATYTJKDCXJOIznRIH5y4ufxC1xZK6yQatTse6LjJ/HtbmXjLF4NZzYL
         HloOyGgaslD637Lyvgt3T16+5tsPtl7as3gljdlV8OzZ+ZchOcUx+pURrlt65hjWCAx7
         awBzankJxKxUTQr3Gk1VlJpPdh42vXgAwzOCqqaGXa0doFhVTO+2gOIz32ZssPDaKjkM
         LOhczaYYLlABLJA0EEeUAWjlSAvwXUAnQ3JO9DgXNdeOu211u/WXSIvROa/tL/ofbS6/
         cwxfGVHJ2dHEQlwC4WeyzFclATD0CJV/vx92RCPB0WndbJTbk/rAzAnqXydiXs01LvHp
         gFCQ==
X-Gm-Message-State: AOJu0YyJsFG+kbc2kod/yOr0Dh3eqCsCG1nObfxJZEevAgrbph1xmYd8
	KKOP445OmgJvEeW47EyygexQlw01BfRjacdktKZPYKCORAXiP+0HPmxFLHgYdTuvXGzwyI/L5Ju
	/ij7obom3GJGd6ky1Zb7vVwx69N6LvQww
X-Gm-Gg: ASbGncucLDcSfrYq8ZPJHgwq/M5H/9eAvnyNkzR25cqzhnQ42Hab3Gl7X5Cu2wtFFsX
	C10MaaE8dILNBKLN1edEut1WGRnZsVT+HaaqNbXf+HpwveoSiKT0PkkkUW/8RUMyMwCKJHg5bv5
	n2+VRaGRmtEL5Hv5ZDlCNH2rGOvys=
X-Google-Smtp-Source: AGHT+IGOgu5AifEmjUdT+u16VRj9OQDf2UfBgt4+WOl4ZKliuKgMWuz+awkIyhkTTkxNRguNAo2Zf+PRs1CSaqaEKBw=
X-Received: by 2002:a05:6102:578f:b0:4bb:eb4a:f9f2 with SMTP id
 ada2fe7eead31-4c30a5e7d42mr2064136137.9.1741354080824; Fri, 07 Mar 2025
 05:28:00 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 7 Mar 2025 07:28:00 -0600
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z8rtuZysCngh5FQd@pks.im>
References: <20250307-493-add-command-to-purge-reflog-entries-v1-0-84ab8529cf9e@gmail.com>
 <20250307-493-add-command-to-purge-reflog-entries-v1-2-84ab8529cf9e@gmail.com>
 <Z8rdg90kxmKHHbyh@pks.im> <CAOLa=ZSMLwt53TwziCe71UbKWgRyNgg5VvUwTUUDkN60ymmFPA@mail.gmail.com>
 <Z8rtuZysCngh5FQd@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 7 Mar 2025 07:28:00 -0600
X-Gm-Features: AQ5f1JprZhOP7UNfn1foDjJRQLqFdu1Agf0GsU1_KKg_YPEKJhstoC-dZJSQ6cA
Message-ID: <CAOLa=ZQfsJdjzpopWGRdQALOiz87Xi=_1YDwarUwCz7jXgGK4Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] reflog: implement subcommand to drop reflogs
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000006a8f47062fc09797"

--0000000000006a8f47062fc09797
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Mar 07, 2025 at 06:53:31AM -0600, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> > On Fri, Mar 07, 2025 at 12:17:26PM +0100, Karthik Nayak wrote:
>> >> @@ -447,10 +456,56 @@ static int cmd_reflog_exists(int argc, const char **argv, const char *prefix,
>> >>  				   refname);
>> >>  }
>> >>
>> >> +static int cmd_reflog_drop(int argc, const char **argv, const char *prefix,
>> >> +			   struct repository *repo)
>> >> +{
>> >> +	int i, ret, do_all;
>> >> +	const struct option options[] = {
>> >> +		OPT_BOOL(0, "all", &do_all, N_("process the reflogs of all references")),
>> >> +		OPT_END()
>> >> +	};
>> >> +
>> >> +	do_all = ret = 0;
>> >
>> > Can't we initiailize the variables directly when declaring them?
>> >
>>
>> We can, let me fix it! I'll also move the initialization of 'i' down to
>> the loop while we're here.
>
> You can also avoid declaring `i` here at all and just declare it inside
> the loop.
>
> Patrick

--0000000000006a8f47062fc09797
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5a6a99b87dfa0403_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mSzlGOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNEQ0Qy80b01JVFBpZ292OUM5V29ydWN1UVIvOElwUgo4SFlkOEVTME1R
ZFlyYnEyN1RxQmJZQ0tmNCtwb3hsRDdxWngwWjdIaEFiWjhXSXR4OUIxYjFpRy8xdWVWYllkCkpR
UTk0RVBYOHV3cE5RNTFWYnJyMzRTWU1CWGE5eEhBeWRDZEZvU09odzB1K2IzL0M3dE8yM2hVZklM
VHNHenIKd1gxVGY3WituVjJJTVlaK3dBTnVBalpMcHU0TWh5TSswS2t5MmtUVnl2SnZVbCtjL0RS
SGNUQm01YUw0Z1oyLwozL0JzdG1lZU5sbFFXU3cxMkVjQUpJeDBOOWZiRHRQZ0hBUDEybGN6eUJq
Vndmcm5IeVFFRkZtTEJBRjZ4eHJYCmt5RWhnZ244KzRsbWxjbW50K0gvdDgxVTltc05ubHB2UEEy
dnJQSFhDS1FwUm13YmFNOXc1UnkxVDIwejJFNisKS0RxZzk5Q0V1Sk1VN05uNEU5QmpyZzVZRjFK
WGlsUVpQdTB1d2dVVWhneVlxcE9ZaXk3UCtOQU52S2p6MW0vRgpvMldkY3ZMdk5BR2tCRU8xN0dM
b3pFNTZNTW5MS1NnZ2t2TDZIcC9ra2ZVQzRMbmU0d0JRUmtGNEdFOUdhbTNDClAxQ3AxOUI0TFhK
ZW81Sy9jQTQ1TlVhbnF3TkdadVR4T2svRzlOcz0KPUZkT2sKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006a8f47062fc09797--

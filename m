Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE082F7CFE
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751634849; cv=none; b=HL3l7X3IwqIePfoRW/qf1sD+Xwr/v4wtTYTve9ZuI738QaJWBaY2Nn0i0NGZt0PsxdU55x7pupqvrOlrPEVFDisTh7qwsDnD8bJ9HxTjXXGJDQPXA7CTcaI21kY/CyW4GH3NM6GlEbIWZ1od7wgRGCeuxTwllIyrapzU5yYm+yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751634849; c=relaxed/simple;
	bh=81mz9hV14wjBhCMqqt0anITBd8V8wI8N7IZAtAbShsg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tn8QigVa1JAXsKfGhxO1YFznOkLCji5/gLQ8m3JAz13vv0bFQmJdD82fRAofXFqh1r/RJamtmwMdWfVz8Ytm6kODZOdOXTWH+35YkeM7dBQ0H2FgcHa6KDarH7wbLtNNBff5Em4L+S7+wS4Z38vIQQmVcd9j25T7uySAE0FGrlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvXzYdCe; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvXzYdCe"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a43afb04a7so6886731cf.0
        for <git@vger.kernel.org>; Fri, 04 Jul 2025 06:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751634847; x=1752239647; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ylws+unJlv5TTWO56M4D5G9nEaqfxRzuSBpHPAzHPwI=;
        b=GvXzYdCeQv1aIZ7SmPYSTbXZXZoamvapMAy1gWm5CY8yW+FJny8ewdOQvF5RcUVpbj
         dKS3rLZIdGRn9HkNA3wPAMr87+unilpPUriCRtQdZEB8QXerElO/9sIEL6qRiHTZZgqg
         M+1vVIlDpzt8I46BT32KufysFY9mivC1imrcaFVzfO+HhB0BHIuc2WYFKRixZwnZ3aLI
         iskd/z1q2qHcBo8aTseE1xiU7+STlNKDrOyctF0WxAb9BzPTZCZJUscyAHcAnG3gWqex
         WYYuZ9Mge/iwiEyzAe1VAa/ljkrBnzXwGL95iSBrFdPjxPb2DA6s5jmUD66KdkB5D85U
         GgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751634847; x=1752239647;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ylws+unJlv5TTWO56M4D5G9nEaqfxRzuSBpHPAzHPwI=;
        b=Jkem/4z7q4LWCN4VrxXFCFdzuXBz7RUBwwuetBUggmr8G5dqgtDV0cOfrvOpfCK408
         Vo1+w3dMQFG9ThuJInX0MnHk6mduCe+OluIGM0hlUiaXsnzqElYbPZ90+wewd5csckx9
         rPK0Q+Ct/2Vnqf4QpYUfOghneO/7kEySeHnNLGxP9twJok4aOEmQJTU6xPUWbMHPv7y9
         9gCfF8zZcgiHsg02C6GnNUbutSUV6sgEWXeu8XjhtLI2BMZC4rTmyvO662LaSro+rmvO
         zCayyu+jY+as4kGqe3qg9VRrFR8pgJkD3z7V+a7QX36kiPQSY7wQU+8yOcXbHOLlRkQe
         JY7A==
X-Forwarded-Encrypted: i=1; AJvYcCUI7t5VEquq+2zxLhwVzhDZh5mterAZ/dh7Y62yQKWynwjk5634iBLFz5Yc2pFh1/TuVa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO1uJ3DLQpUC84mEawCu9HpLI6KY3zCGwQ+MmhF9eAd4HYd9IY
	9EwH4ajNFWF19u07aQuHv9MnlFvertuSYse6mq+v3AshRQkOrSc5v2FHwFP1O6HE9EI19LcNTpE
	z55NuQmAYLWjR+iEdFPSTFydVwr7K0wA=
X-Gm-Gg: ASbGncurUpw76MDBOwrfE4WMejM5bg7g2vvBaQYMwR3J6ZcHcHd/xct5r0hnrXQJ4OY
	sZ57JR5axG9ZhciOIMYjo2ntN2dLy3oePW5UR+zJyIi3DKfFgcNIwuTl4pCmR9MlmDx9Uv2mkSN
	kjjWyhBUMUENT3PW2AnjgN/hDlz1vh3xxoaS4T/HWkkw5+Ep7HByX2
X-Google-Smtp-Source: AGHT+IGTGNIhoS4/7A3GVUiDeDj8PXFmkmTZKbBeYKwds82Y47g9QZtolXB/4VdvUU8H2AKqooh5MB7u3UwCrJpzlYA=
X-Received: by 2002:a05:620a:1b9c:b0:7d3:8ffa:f1bc with SMTP id
 af79cd13be357-7d5df194ad6mr213310785a.58.1751634847045; Fri, 04 Jul 2025
 06:14:07 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 4 Jul 2025 06:14:05 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250704-pks-reftable-default-backend-v3-0-a1eb63e8442a@pks.im>
References: <20250702-pks-reftable-default-backend-v1-0-84dbaddafb50@pks.im> <20250704-pks-reftable-default-backend-v3-0-a1eb63e8442a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 4 Jul 2025 06:14:05 -0700
X-Gm-Features: Ac12FXx1PMWZ4CnoLTEyfBUV2UNcd5D-8BkLrr6utfdSBxvPpV7Ic1-ziMIXGbE
Message-ID: <CAOLa=ZS31zV==wu6YXG-9m=hUW_8gTkXbWCBJbCuS46+07HeFQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Add reftable by default as a breaking change
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, ryenus@gmail.com, 
	Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000d62c5006391a442b"

--000000000000d62c5006391a442b
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> the recent thread at [1] motivated me to hack together this tiny patch
> series that paves our path towards making the reftable backend the
> default backend. It does two things:
>
>   - It announces the breaking change for Git 3.0.
>
>   - It makes it the default now already when "feature.experimental" is
>     enabled.
>
> The first item is subject to ecosystem support, most notably in
> libraries like Gitoxide, libgit2 and JGit. The second item is intended
> to extend the user base to power users so that we get more test exposure
> out in the wild before we make it the default in Git 3.0.
>
> Changes in v2:
>   - Improve the breaking changes announcement a bit based on feedback.
>   - Introduce a `REF_STORAGE_FORMAT_DEFAULT` define.
>   - Print the default ref format as part of `git version --build-options`.
>   - Link to v1: https://lore.kernel.org/r/20250702-pks-reftable-default-backend-v1-0-84dbaddafb50@pks.im
>
> Changes in v3:
>   - Small tweaks to the commit messages.
>   - Mention better data compression as another benefit.
>   - Link to v2: https://lore.kernel.org/r/20250703-pks-reftable-default-backend-v2-0-5a27e72a8c5e@pks.im
>
> Thanks!
>
> Patrick

The changes in this version look good and as expected. This looks good
to me.

Thanks

[snip]

--000000000000d62c5006391a442b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: de368bc9ce2fd822_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1objA1d1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mdytaQy93TXgvOGhkSXd6UnpvZ1JTUGtqeTZmNUNVTQpCNm11VitYUjAx
bUNGdmNXbjBHc1Jyd0tGWURuR3hqSzNMd1NBRnhkb3NJaDRteVRzQ2lqbnd3WXcwd2xqTlMxCjFr
dXU0MzNFazhkcDZjaHN6dDN4VHdScVZ1eGdsalJER1E1YVIrV2ZpckFrVzhzYllTRloxVkh5SkVt
SmRqRTMKSFgzWnFzSmd1bjlzQUFRQ25ad3cvZWtFNUJaV05IbVN6N0N0ZEQ2eGQ1Rm82YWpqUTFB
M3ZTU0FObTRPZkk4bwpyZ0hONi85OHJHc0xFQ0JoWk9sOHNpWm1vY1hpcVFDa01icVd6cGRJZFMw
Vys2dGZPMEpuZHhldWhvNmY1OVNsCmhGL3pyTkk4TnVTWnhKZHRjVjVDbEpPUi9vZWFIeHd3YTNh
Ulk2bnlIcWExcjVvUDlzd1hMeEMrMHI0ekYxeEEKVExrSm1ERjFVYzRwSG4xbjJtRlVhd1g2cTFY
K3NoUUNYWDE4SVg5SjdMMWNQcEdxc3pCY1RhUlZDZmt0MGpaaQpESjN5UDl5RHZjWEJIZ0RWTk8v
SUZKSXpFNzFUdlhpbllNcUx0Wnk0TnUzZ1hpSGJTdHhXcDBOb2RldDVxaWlBCkI5YUFNUmlJVEZx
bStKNHNXckZrY21vVWtvd1drVVczczVRbE0yQT0KPXA1WnoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d62c5006391a442b--

Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BEE63C83
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 17:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808571; cv=none; b=KIpqh0KPddv+mL68ECPgqbaKxof75VZAe4QJ8PDqPnn5f4sLwALb1kx4eVE9eu59hvoSuWG5hm/4r4mN03SP42F16I178JlDwdlIqojyIu/ewVQz3CggmDfnhs/K76IbdvOXkZf9cV4VLxB+zW+uRU7KWzLjWRpdZDMSobhFfGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808571; c=relaxed/simple;
	bh=+gOpdMuOlw316OqfCtxOzsQ7bEBJh6NYC6TeCz3Kt10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s3HE/fPbDHhK6a/mzoyMSEWt3HrzkJVPiVnnrdmLLxjJU93Yg0ppqMK411EBGmtl6zjxjqBi0CMX7VZMA+sZxrJrmJqiz1LhbsBqVivaj0OoF/FVqfQcM4RoB8UfI+bPWwQ/6ERLTfkJFdYgE3bSdk8lJylGNeakwExUPl6+z6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-783e22a16d4so170540385a.0
        for <git@vger.kernel.org>; Thu, 01 Feb 2024 09:29:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706808568; x=1707413368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9FeHS2bqh0egntY2346kVIrR5spedpQkrH5VZfVGSvY=;
        b=fQv1u8Vb0klZ1OawRShECSPzihIdGgARjjxOvY/4PzhEqjkD9iz1Bij1KzhkUI+vBA
         ytODBPA8zSNA+HJFdrTCaHSEUw2Txl0I1MG2WJaYCthKMVSa5rOoWNCiOv8eZ+34j4qR
         1VL3sel4C2VbZgCDZ3hwBoMCXoE+MIXc6e2+lZmxRm0bwqKkYRr0PCyrEWSKlqNj7QDd
         mXDqoAYsQG5FskTkhQNDTEqZaze6w21L6aP3vvmJU74gRrB4IsVR9qZPq7yRxyFFDq/Z
         at40kZk01sWy/tUVmuacl/pQYaRDzAUH5+P6K28ztOg4oh38up6g5ejTwAXWOOGaNSa0
         CuTA==
X-Gm-Message-State: AOJu0YwvR9DMWRXvJ1N/ei0WXspF83tZ6FLJLdjCn2gZB4So1yeHoKaB
	9XZucTqhiz7IkJgeCbLZKZp8S23SQnDPDp0En4l9Vo49vqzces7C/WvdGz7O0gIggvTJsick3PL
	Hvgl4l1c8AhJmbvaYmKSuxOa7tmM=
X-Google-Smtp-Source: AGHT+IG0qTlHbctrNaRhSUlKAu8NvM6yOyM7DQ+nQbwXekuqsPyjDy4lFJ5+mQW2MOqZkz6jyI0S53a+yg+YD+RdA+M=
X-Received: by 2002:a0c:db8e:0:b0:68c:3a14:a11d with SMTP id
 m14-20020a0cdb8e000000b0068c3a14a11dmr9914492qvk.28.1706808568194; Thu, 01
 Feb 2024 09:29:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706782841.git.ps@pks.im> <0ca86eba710895f0e22fc15fe5221f5487031f64.1706782841.git.ps@pks.im>
In-Reply-To: <0ca86eba710895f0e22fc15fe5221f5487031f64.1706782841.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 1 Feb 2024 12:29:16 -0500
Message-ID: <CAPig+cQwgYdKCHnu1TUj2JYyQkRF6Ey4hw1MvAVpfhqcwjV04w@mail.gmail.com>
Subject: Re: [PATCH 3/7] reftable/merged: skip comparison for records of the
 same subiter
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 8:17=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
> When retrieving the next entry of a merged iterator we need to drop all
> records of other sub-iterators that would be shadowed by the record that
> we are about to return. We do this by comparing record keys, dropping
> all keys that are smaller or equal to the key of the record we are about
> to return.
>
> There is an edge case here where we can skip that comparison: when the
> record in the priority queue comes from the same subiterator than the

s/than/as/

> record we are about to return then we know that its key must be larger
> than the key of the record we are about to return. This property is
> guaranteed by the sub-iterators, and if it didn't hold then the whole
> merged iterator would return records in the wrong order, too.
>
> While this may seem like a very specific edge case it's in fact quite
> likely to happen. For most repositories out there you can assume that we
> will end up with one large table and several smaller ones on top of it.
> Thus, it is very likely that the next entry will sort towards the top of
> the priority queue.
>
> Special case this and break out of the loop in that case. The following
> benchmark uses git-show-ref(1) to print a single ref matching a pattern
> out of 1 million refs:
>
>   Benchmark 1: show-ref: single matching ref (revision =3D HEAD~)
>     Time (mean =C2=B1 =CF=83):     162.6 ms =C2=B1   4.5 ms    [User: 159=
.0 ms, System: 3.5 ms]
>     Range (min =E2=80=A6 max):   156.6 ms =E2=80=A6 188.5 ms    1000 runs
>
>   Benchmark 2: show-ref: single matching ref (revision =3D HEAD)
>     Time (mean =C2=B1 =CF=83):     156.8 ms =C2=B1   4.7 ms    [User: 153=
.0 ms, System: 3.6 ms]
>     Range (min =E2=80=A6 max):   151.4 ms =E2=80=A6 188.4 ms    1000 runs
>
>   Summary
>     show-ref: single matching ref (revision =3D HEAD) ran
>       1.04 =C2=B1 0.04 times faster than show-ref: single matching ref (r=
evision =3D HEAD~)
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

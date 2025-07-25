Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006222EF9D6
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 17:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753464512; cv=none; b=o4l8Dscs+5LysTAMyQY/zrOCYi5G2AiKmD1AMOyxe/F4jXFT/g2IaXQJzwR5Bi8S4KFQIFvh0WzZk+TXxpQJkNdGWxiJjZT1i6los9ZLjhifHg/jDNx3XxIQLKegei5GDm99/q99r7ubu41M1aUmLxKwtfTxZcVqPlfFsVl78sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753464512; c=relaxed/simple;
	bh=Kt/pUCZ9z1qXK6M+kmQ01eaPuRD8FUnY3sZRHFXXF54=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=qXbSYnjmdL7oet2flWwmXzi/Skzv5htSfkh0iAUO0rQO1oM2gNeAvzpk4Vc2PsEPW7bPq5ExXN3gbXFAktuX6HM9y/hzCoqIYA5G20+ml3tg37IH6SBc5vbDs61d7iVXRDYEkJIWFHtln7F2J10Bq6DRLod2HiJDxtjtjgxznQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ardvdZBZ; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ardvdZBZ"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e8defed8130so638306276.1
        for <git@vger.kernel.org>; Fri, 25 Jul 2025 10:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753464509; x=1754069309; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q0X3P4A0qxUUmI0riumOh6Gkj0SvFfFdsn/Bv/fTkz8=;
        b=ardvdZBZVQMKKxec5SoayBQiQTzwwyCglYeKaAEcsQVnR0yjjd61qjRRx2RWXx9rN6
         RtpINvHJc3+618iqH2Rr9g41JNOO7StqIaLfvBpyfE7UY47EP/Us+bDRZ+CHAbi3Okc+
         8nGvtR9/QYClhRoCDzuaP9uawkabgwBr3jPl/iy8vQG51xBb+ot4HUwgrC6CYp6e8bt7
         GuYIWtK/1tkY9hpw1xGl4yRBsMB3DkUkdBWRkO19kp8h6oSEYDf9sYStOPcJsLX+EjUZ
         DaAGJ38LuM0P8g0BWDboxeqI6zCht53fpahk4KCI+W62FGBUb+OI0d5szXww8eHOm/kS
         n1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753464509; x=1754069309;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q0X3P4A0qxUUmI0riumOh6Gkj0SvFfFdsn/Bv/fTkz8=;
        b=EZOKcn+f3ALLva1xpRdQB0PYa1NzPe41cHsR09fW/Q97L6I0vTegSmgKInq0S79KSn
         TEZzyeHs5s0Ht0+0oISwE4dev0m9i1SvRsLtRXL8ezt772WslNpaRmTvXcBp4jmPEtGf
         BuPxuW/Fnr0msYea2CNNhdsL3wy/oeLIjh+oXwLfS9nvjIKVNIi3hp9XPSClDuVRrPRc
         A2zCaq/j0wjtSfkUjV+65eofPb1E4mcw0AhJ+yz2DmYD6xTJ2SjeQjOiCteAbx3HQ3sK
         kI3RKjIkwnrCCQZQpNDFQ4NC/RGgSEniIEpy97uWtD3JP0tFF3O9d0B7FK/IWgSkr/OI
         PJNw==
X-Gm-Message-State: AOJu0YwdXc0iCIWduKkBVZbvD/Q3yuUc+8w/gaozpLSV2JxKkvY9+EHd
	0LUYhxX5TOKppqrMcOtOIm9nHVgE1QHIGPHA0jg4i9DloXtNCK37DuEsECYgZg==
X-Gm-Gg: ASbGnctCWLbduVI8GM6SmTgdUBmCDD4cZjrkpE0p2jyYyWPn+0tMMm9oQGiQSx3CaFI
	7W9E7bTHybNUIX6AWMNmRrkoQcYJQwBkltzuadKUb7GhahuHkHy9RYe7KN9IjMV47BaRqjoGAK3
	z9pqkGJAS1cBJMzYbiCSdA0t/QYv1fgqmCFWoMWDGVWwMOuWa7DxmpjARuE7NKpnOom44rTyxbY
	bhUwwUE38PQoGmkY6uBU4mTKdlbrhZOfb3wtFhpnQdBdZOJBUaCCEFGVXkd0nAZVS/YjWtwMNSa
	FiWeI+5qVVv4WlgQxh5PDf2ASmWUBFydjUmSAzpDlbkg+FXaO/vCNv9o//VXOMw1dQ57msKRFPD
	PoGXxYI/I014xc4GXsiLMbj21MgMnJ0ESnWzlOhLViSx4ybddthA=
X-Google-Smtp-Source: AGHT+IGDLJB5BD+ngiIqnpOUBfe/9CvTnucBQjPWNKXPUTeNsJJTcfE/gO7bjiVnX8SZ2kZr6tKabg==
X-Received: by 2002:a05:6902:4892:b0:e8d:87da:2112 with SMTP id 3f1490d57ef6-e8df127f475mr3030167276.41.1753464509313;
        Fri, 25 Jul 2025 10:28:29 -0700 (PDT)
Received: from smtpclient.apple ([2600:1004:b011:9b14:6c53:8307:d185:2565])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8df871e8efsm129792276.46.2025.07.25.10.28.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 10:28:28 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v8 1/2] submodule: prevent overwriting .gitmodules entry on path reuse
Date: Fri, 25 Jul 2025 13:28:17 -0400
Message-Id: <E4F5EF8F-4146-46BA-A498-8493706238A7@gmail.com>
References: <CA+rGoLfi9=h0Z86QZ2Y_HQqd+ugrMgkBzLaNSwivvkcDwmT=rg@mail.gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
In-Reply-To: <CA+rGoLfi9=h0Z86QZ2Y_HQqd+ugrMgkBzLaNSwivvkcDwmT=rg@mail.gmail.com>
To: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 20 juil. 2025 =C3=A0 08:25, JAYATHEERTH K <jayatheerthkulkarni2005@gmai=
l.com> a =C3=A9crit :
>=20
> =EF=BB=BFOn Wed, Jul 9, 2025 at 8:20=E2=80=AFAM D. Ben Knoble <ben.knoble@=
gmail.com> wrote:
>>=20
>>> On Sat, Jun 7, 2025 at 11:28=E2=80=AFPM K Jayatheerth
>>> <jayatheerthkulkarni2005@gmail.com> wrote:
>>>=20
>>> Adding a submodule at a path that previously hosted another submodule
>>> (e.g., 'child') reuses the submodule name derived from the path. If the
>>> original submodule was only moved (e.g., to 'child_old') and not renamed=
,
>>> this silently overwrites its configuration in .gitmodules.
>>>=20
>>> This behavior loses user configuration and causes confusion when the
>>> original submodule is expected to remain intact. It assumes that the
>>> path-derived name is always safe to reuse, even though the name might
>>> still be in use elsewhere in the repository.
>>>=20
>>> Teach `module_add()` to check if the computed submodule name already
>>> exists in the repository's submodule config, and if so, refuse the
>>> operation unless the user explicitly renames or uses force to auto incre=
ment.
>>=20
>> I had to read the patch to figure out what "auto increment"
>> meant=E2=80=94perhaps some accompanying docs in `git help submodule`?
>>=20
>>>=20
>>> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
>>> ---
>>> builtin/submodule--helper.c | 28 ++++++++++++++++++++++++++++
>>> t/t7400-submodule-basic.sh  | 23 +++++++++++++++++++++++
>>> 2 files changed, 51 insertions(+)
>>>=20
>>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>>> index 53da2116dd..9f6df833f0 100644
>>> --- a/builtin/submodule--helper.c
>>> +++ b/builtin/submodule--helper.c
>>> @@ -3444,6 +3444,10 @@ static int module_add(int argc, const char **argv=
, const char *prefix,
>>>        struct add_data add_data =3D ADD_DATA_INIT;
>>>        const char *ref_storage_format =3D NULL;
>>>        char *to_free =3D NULL;
>>> +       const struct submodule *existing;
>>> +       struct strbuf buf =3D STRBUF_INIT;
>>> +       int i;
>>> +       char *sm_name_to_free =3D NULL;
>>>        struct option options[] =3D {
>>>                OPT_STRING('b', "branch", &add_data.branch, N_("branch"),=

>>>                           N_("branch of repository to add as submodule")=
),
>>> @@ -3546,6 +3550,29 @@ static int module_add(int argc, const char **argv=
, const char *prefix,
>>>        if(!add_data.sm_name)
>>>                add_data.sm_name =3D add_data.sm_path;
>>>=20
>>> +       existing =3D submodule_from_name(the_repository,
>>> +                                       null_oid(the_hash_algo),
>>> +                                       add_data.sm_name);
>>> +
>>> +       if (existing && strcmp(existing->path, add_data.sm_path)) {
>>> +               if (!force) {
>>> +                       die(_("submodule name '%s' already used for path=
 '%s'"),
>>> +                       add_data.sm_name, existing->path);
>>> +               }
>>> +
>>> +               /* --force: build <name><n> until unique */
>>> +               for (i =3D 1; ; i++) {
>>> +                       strbuf_reset(&buf);
>>> +                       strbuf_addf(&buf, "%s%d", add_data.sm_name, i);
>>> +                       if (!submodule_from_name(the_repository,
>>> +                                               null_oid(the_hash_algo),=

>>> +                                               buf.buf)) {
>>> +                               break;
>>> +                       }
>>> +               }
>>=20
>> This isn't typically what I'd expect --force to do, personally, though
>> in this case it allows me to proceed with an operation that wasn't
>> allowed otherwise.
>>=20
>> Still, I wonder if a user might be confused by "I said 'child' and got
>> 'child2'?"
>>=20
>=20
>=20
> Ok so while fixing the previous versions of my submissions
> I got stumped at this, I found child<incremented val> to be intuitive
> at that time
> but I can see why it may not be intuitive too, I mean I could just
> remove the previous child and add
> the current data as the new child because that feels intuitive for force.
> If that is something which is in the interest I could send the new
> patches as soon as possible.

That sounds more like a typical forceful operation to me.=

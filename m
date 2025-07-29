Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7612382
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 00:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753748128; cv=none; b=bR7Vt+47rSiFojsH8fSQDEpUaADpaagQ2syGglGXGjPOBsG2hZLMeauzGLrBu9eQ7MHxPcJMu8eJDEIFKjzAsFPJ0mMXUNoeVscPQLeKVGCq1bRLoQZd5tD68SBUlCfYPhloecRTTh6clfuDtmAjtmWqPsZWi8W6FtY+hG1ykAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753748128; c=relaxed/simple;
	bh=g/JpymSkyXphqYZgDLpHo3+sIvI+AaLeOYSBWXbgToU=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=VqV6VZUWYXrlnCUNmFcib/woEWJZQu3EtCJwsZoX5FX5uOsLssQOQChpJYKvY7dIQ/chj4kYZiaGSR+InVU+ZA63KTGlo350/HE7Le9EgPAa81X7XMcDjlVok2GkAxbhvB9DqltA2UwKWyBCuGn5fAKfw14XNy0aOgnfJa95Qns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkIkQdoM; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkIkQdoM"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71a39f93879so413397b3.0
        for <git@vger.kernel.org>; Mon, 28 Jul 2025 17:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753748125; x=1754352925; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZdATPp5rePmODaTET2dsxWflw8CBhge8H9G7FPI03GU=;
        b=FkIkQdoMdngBjNeiYLjDZo2FZZjnGDIu1vUgj/SndOfwV+PPbDfwwKKbsoNkXzSSi3
         iy7H8Idn7iYFPY39lunuqCmo5g1VPohYIcnyDHOjI5vJnD0UvRCs+EU/ZPfFwwGkIWsC
         1Ze6TsfzKrJhLvq5v7C1vU+h8oW7lzSZy2ktNxxwWykQqPAHO3DN/vJrsg33XPqsdn8V
         sgVWQKQMNPdavUNHx7NqK00ML5hoOrHVLiV8pPSZqTbM7BjDFjsS0eTXXGf/0OsRNlYE
         pwEhY+qE6N3xnZmXyeukWoTtQ6IgBo2CkQ3qJA1pVbhxyal9K0f14Ngnm8FulF9ASVLP
         7i9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753748125; x=1754352925;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZdATPp5rePmODaTET2dsxWflw8CBhge8H9G7FPI03GU=;
        b=wXi0lvRfRiIOQeyeoIH4zQep2+H1Pwdu2JcKBHdMDmCdmxaAR7jGG3kAFBYXZ/akK6
         vUCuHQNRy+RNl2LKcpi2bV380FwVU5QJFEgs2R4/JbxT4CZgDayn0SVOylY1FUdCBR+u
         mxZqpIIZ5tI43cNkJ9tIlJXvWp3W5N9p7XlGbH/gM50G1HWnlcLibBrk/Fa7l1B9yczX
         EOQPrdoFkgkO0UKkFssbscHuBQgkVHXPI/vn8R7Cn/bybtJT/wW06Xml1MLIE/yM9qAa
         gQBjl0Nlh+u1iqzNgWEpn7P9ReU/YE7Gml19+fGQE5/KV3dYvKF35cCzahT1iHZVz69+
         lbzg==
X-Forwarded-Encrypted: i=1; AJvYcCUh2Dc2GkS9LnFyE5PIa+EEw0sFIG37rlq+iEPcSPPpaazUAMG4T0d3SbsiwpwuFUtteUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrcON7ccz9bXoTeuEWWb4WotJ9wA7kkuzy8/lGgfntCAkU9B7c
	bT/n2jrps/E3FwFIsTFAkIGAGYWqNMmeqU0JjB+ndN7PV3Znzrg2SKaI
X-Gm-Gg: ASbGncuzBwm4O7OAX1XLZzo/B9XgY7cnE+9diHUMA383n2G82tQsQ0bwe5xwHATb1xu
	Na0FX9TIlDyxrWfs3sLcWLlsG2NSR+KnHQHkqB3ArfUNKgZDDVszGpuxXtEi2QCJRVNc4BGwKNI
	S5hMckBtqpp9LbJRDgwg43qPv+LLMZODmqlYXyu7FHgmfH26qiS+j/GSH8mo1CbJBjvVIGgTroV
	55bKnWsxllOmgStT9qTE6oc5/gvcH66gc0t1tzszFstWfY/s00F0ncWgXKIWHWwCVDFmkogvOEd
	/ymzHuwYeJ5EMQF/eqFjxgVO19tm6IxgID7riodVg+IXdMgOOsTe/F3XKB8+NuPGl2n8qpjkQ5n
	3WaULlhINb2+0NKuZDOL5IddW6umLVush0pVlrYCa6xaKSy+QEb4=
X-Google-Smtp-Source: AGHT+IEa/HY/aRLH7ATuaxvxqlAFx8OcRayUAspleBgePop0YTziVh0H3u2YiFU8TPhfBMTDoGDAyg==
X-Received: by 2002:a05:690c:660a:b0:71a:231b:d046 with SMTP id 00721157ae682-71a3485a0d9mr20187817b3.2.1753748125497;
        Mon, 28 Jul 2025 17:15:25 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:59fa:4cd3:495a:22ea])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8df85befb8sm2325688276.12.2025.07.28.17.15.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 17:15:25 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [GSoC PATCH v5 5/5] repo: add the --format flag
Date: Mon, 28 Jul 2025 20:15:14 -0400
Message-Id: <CF7744F0-394B-415D-BECC-9D7CD477B78C@gmail.com>
References: <CAPig+cQn7c5+k06yHOD2jxYTGnny7is=fbo4tOw26eD+4zX-Jw@mail.gmail.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org,
 oswald.buddenhagen@gmx.de, ps@pks.im, karthik.188@gmail.com, gitster@pobox.com,
 phillip.wood@dunelm.org.uk, jltobler@gmail.com, jn.avila@free.fr
In-Reply-To: <CAPig+cQn7c5+k06yHOD2jxYTGnny7is=fbo4tOw26eD+4zX-Jw@mail.gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: iPhone Mail (21F90)


> Le 27 juil. 2025 =C3=A0 18:02, Eric Sunshine <sunshine@sunshineco.com> a =C3=
=A9crit :
>=20
> =EF=BB=BFOn Sun, Jul 27, 2025 at 2:02=E2=80=AFPM Lucas Seiki Oshiro
> <lucasseikioshiro@gmail.com> wrote:
>=20
>> diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
>> @@ -20,11 +20,20 @@ test_repo_info () {
>> +       test_expect_success "null-terminated: $label" '
>> +               test_when_finished "rm -rf repo" &&
>> +               eval "$init_command" &&
>> +               echo "$expected_value" | lf_to_nul >expected &&
>=20
> Simpler:
>=20
>    printf "$expected_value\0" >expected &&

(Below as well): the shell linter I use does prefer to see

    printf %s\\0 "$var"

to avoid issues with the variable containing format specifiers.=20

(Backslash has to be quoted in double-quotes, too, I think? So I left out th=
e quotes here.)

>=20
>> +               git -C repo repo info --format=3Dnul "$key" >output &&
>> +               tail -n 1 output >actual &&
>> +               test_cmp expected actual
>> +       '
>=20
> How confident are we that `tail -n 1 output >actual` is going to
> perform as expected across platforms and versions of those platforms?
> It feels awfully fragile to me. Why slice and dice the output anyhow
> rather than merely crafting the correct expected output in the first
> place and comparing that directly against the actual output? In other
> words, something like this:
>=20
>    printf "$key\n$expected_value\0" >expect &&
>    git -C repo repo info --format=3Dnul "$key" >actual &&
>    test_cmp_bin expect actual

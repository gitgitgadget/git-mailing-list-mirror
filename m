Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA8644D020
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 11:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785323898; cv=none; b=hNQ3ZCYu17AptBg+HNxoVfeHT4noT2rTI0uxMfMx5EDV5Wjfmw+KlWdtNv83tZv/TeJnBAljQ4qSb2i6qL/YNkQyDb/qWThjqeHQFHkpxGGCbL9V3VwuNHaQoiJIY5sKrkqcrzu8vBPZAsQIvZvDE5QtU1UA9Fi4tsLA6d4xBkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785323898; c=relaxed/simple;
	bh=G/32R9AWC3e2aXx9VILHtjn/LgV7HN1MsWAH+6FqEIk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=PuL9eo7RGanH0M2DD1NyyGaYVCrL+6HEX+7ghDJitd59At5H/fblB9LjWkYszE2uA2+VqxTpkB0DBOCf+9WwL78dWG1tuJ3Pbr/y6vW3ZodsCaS9mTixskuTr7EbdBUI0J+xL9FNOwVEp+PcyxTYffbyDUKwsRWdci6yUNvnSrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/udM5sb; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/udM5sb"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47f59f25ec4so332614f8f.2
        for <git@vger.kernel.org>; Wed, 29 Jul 2026 04:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785323895; x=1785928695; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j8nz4dIrDb7xkXQ3nNnj2bflQClivBMXjMEgyEVgbH4=;
        b=E/udM5sbsL1RXBuV59cnaapyobhcRqMx2VJ+NBxT3xpSLCYwfbAaEprStjYE6Zhr5+
         2oZhE+lDhDGU9TAytD58Z5tnCVhJBNCbRhjNUltJGC2JZg5//bm9icvmZifso72Qmm9Y
         jM+qeYP0mZs8jMG25uOstEYIe3D+IFkrcg3mL/0Lco7Bo9TrxKLNL3eJ9HqRyk9B1vzX
         A2/k6QLFjRO1tMe5MJqAtGVQo8Bvp2R22mLR7UL3IJWLe4clyu1up3NDo8GxSwcNw7Ga
         +BMy2Bg4jXuthtUuX3i7VT1WTKy44pmyUVZw3iaFZ/mfAi3FDZONYdJMmYKVx3N6z/Lt
         Jlug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785323895; x=1785928695;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j8nz4dIrDb7xkXQ3nNnj2bflQClivBMXjMEgyEVgbH4=;
        b=HiYysfB0klDyrJOJTl5l2VgNJ/VMZVodGfLYuZKpjd747f028/0VeztcDVm9NbY5bx
         4SwaPQTTM/unfNqWFMgwtqyRi7/sw5VouChHNpIplwneWm266RSO8X/1Fmye+HMunSge
         GaZFZX660p1rCVRYQ9kyzoDTK/mlLA5jW6x8W09vPc38COOe/Df83nY8JlNMXkMVkrau
         qal0+axBlfTN8AfDulPrdpC31yoUJn7q2sYSIJiirHY0iHiYHcObjFnXA8Dto5dqkwY5
         WU0SEk3w7M8ItDHy7mfjvwbPgfaSHlQBEhGYh+5C0OAbwnBd2QQ4X8kIMs9mdkbBAGAM
         OKZA==
X-Gm-Message-State: AOJu0YygbzdQKx3UzOdDeGoFMOtL1wsnwj0owXA7sqZvArpIhTHb0tFy
	PwAYtxM0B9d22zvJscd6uF4QEb9+FXA5rJVY+G6RlouiQBo2cRNtwohX
X-Gm-Gg: AR+sD10V1DrnRGfrb/j55Dtx2A+jDefo5MYamcU1s5YdoTWySQtFkJx5mxFCdT0BGzA
	m/q6RmyXSbXAmAQrM1yTROrdMTNz2SfDLpRveAZd0b0miQo1yoFZoe0eBDnoDHTAfZJXd+PQrvq
	fCk5DDb2mmgNydw4WlffHqJ6GTWqncpUYLUSmawu0MnVOBUw3JmNgBDgniaobd7vRheoIRRj1mh
	ofvoVZsa1AjqI2N6Ns+sTcsJGCPeCa4QGd77+iYZUtqlqGoGj1N9HHeB7zovLG6aTrfL2WZFBdu
	Ni/GM39nlUdNPTBg7Uw92fcK9/hcLWWL9Jfg8zVRfmBG8yzhUnBdU82vIsqvoCdTArVbpwrP6lK
	59m9pg/qX+DSSlbt4/uvmNc7WU0ev3Iue3/jOdruoTJePqsf1NaPfu4voznMLhsCVKTDl27UgsD
	shI5COeJA4SFwKnRsmt0Ei2n/WKSBPl9EQx3u9J4WwJLiIKf3ZHjpUqJGQABVdVnEGcSFT0icXi
	Mcjq8Lf8femwwxtfoZXLigLGgJrq9cATTbBe5+xPStDD5oS9uN5VbW0S+tSrDxm0X9i56E30CXZ
	Wiez/OlZ2KvOe8xt887wzoj6YnW0uSyNy/S+t6Wv8zVxWja8y78kWmDinCwxlfmVtbtlSbFo3dE
	=
X-Received: by 2002:a05:6000:4802:b0:47f:81a9:3f36 with SMTP id ffacd0b85a97d-47fb1e8e26cmr7499602f8f.18.1785323894973;
        Wed, 29 Jul 2026 04:18:14 -0700 (PDT)
Received: from localhost ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6ac44bcsm6800760f8f.11.2026.07.29.04.18.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 04:18:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jul 2026 13:18:13 +0200
Message-Id: <DKB0I229LCE8.CU4ME582YISN@gmail.com>
Subject: Re: [PATCH GSoC 1/5] protocol-caps: add type support to object-info
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Chandra Pratap" <chandrapratap3519@gmail.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
Cc: <git@vger.kernel.org>, <karthik.188@gmail.com>, <gitster@pobox.com>
X-Mailer: aerc 0.21.0
References: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com>
 <20260725-objecttype-support-v1-1-2d4ca3bbabf1@gmail.com>
 <CA+J6zkQFAqZvi-6UaQi6v_OBiT4ihZtCN45vyGCGTbo9TJLJbg@mail.gmail.com>
In-Reply-To: <CA+J6zkQFAqZvi-6UaQi6v_OBiT4ihZtCN45vyGCGTbo9TJLJbg@mail.gmail.com>

On Wed Jul 29, 2026 at 11:53 AM CEST, Chandra Pratap wrote:
> On Sat, 25 Jul 2026 at 17:25, Pablo Sabater <pabloosabaterr@gmail.com> wr=
ote:
>>
>> Teach the server-side object-info handler to accept type as a requested
>> field. When the client includes type in its object-info request, the
>> server returns the requested object type.
>>
>> While at it, fix requested_info->size bit field style.
>>
>> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
>> Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
>> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
>> ---
>>  protocol-caps.c      | 21 ++++++++++++++++++---
>>  t/t5701-git-serve.sh | 27 +++++++++++++++++++++++++++
>>  2 files changed, 45 insertions(+), 3 deletions(-)
>>
>> diff --git a/protocol-caps.c b/protocol-caps.c
>> index 02261be14d..5531d388f0 100644
>> --- a/protocol-caps.c
>> +++ b/protocol-caps.c
>> @@ -11,7 +11,8 @@
>>  #include "strbuf.h"
>>
>>  struct requested_info {
>> -       unsigned size : 1;
>> +       unsigned size:1;
>> +       unsigned type:1;
>>  };
>>
>>  /*
>> @@ -73,15 +74,20 @@ static void send_info(struct repository *r, struct p=
acket_writer *writer,
>>         if (info->size)
>>                 packet_writer_write(writer, "size");
>>
>> +       if (info->type)
>> +               packet_writer_write(writer, "type");
>> +
>>         for_each_string_list_item (item, oid_str_list) {
>>                 const char *oid_str =3D item->string;
>>                 struct object_id oid;
>>                 size_t object_size;
>> +               enum object_type object_type;
>>
>>                 if (get_oid_hex_algop(oid_str, &oid, r->hash_algo) < 0) =
{
>>                         packet_writer_error(
>>                                 writer,
>> -                               "object-info: protocol error, expected t=
o get oid, not '%s'",
>> +                               "object-info: protocol error, expected t=
o get "
>> +                               "oid, not '%s'",
>
> I assume this is a style change? The original line doesn't seem
> long enough to wrap though.
>
> Also, this would break the grep-ability of this error string.

Yes It is a style change and it's ~60columns long, I'll drop the change.
Turns out my nvim settings is showing the vertical guide at ~60 columns ins=
tead
of 80, but that's on me.

>
>>                                 oid_str);
>>                         continue;
>>                 }
>> @@ -93,7 +99,8 @@ static void send_info(struct repository *r, struct pac=
ket_writer *writer,
>>                  * If an object is not recognized by the server append S=
P to
>>                  * the response.
>>                  */
>> -               if (get_object_info(r->objects, &oid, &object_size) <=3D=
 OBJ_NONE) {
>> +               object_type =3D get_object_info(r->objects, &oid, &objec=
t_size);
>> +               if (object_type <=3D OBJ_NONE) {
>>                         strbuf_addstr(&send_buffer, " ");
>>                         goto write;
>>                 }
>> @@ -103,6 +110,9 @@ static void send_info(struct repository *r, struct p=
acket_writer *writer,
>>                                     (uintmax_t)object_size);
>>                 }
>>
>> +               if (info->type)
>> +                       strbuf_addf(&send_buffer, " %s", type_name(objec=
t_type));
>> +
>>  write:
>>                 packet_writer_write(writer, "%s", send_buffer.buf);
>>                 strbuf_reset(&send_buffer);
>> @@ -124,6 +134,11 @@ int cap_object_info(struct repository *r, struct pa=
cket_reader *request)
>>                         continue;
>>                 }
>>
>> +               if (!strcmp("type", request->line)) {
>> +                       info.type =3D 1;
>> +                       continue;
>> +               }
>> +
>>                 if (parse_oid(request->line, &oid_str_list))
>>                         continue;
>>
>> diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
>> index 9a575aa098..d7c93b5b55 100755
>> --- a/t/t5701-git-serve.sh
>> +++ b/t/t5701-git-serve.sh
>> @@ -366,6 +366,33 @@ test_expect_success 'basics of object-info' '
>>         test_cmp expect actual
>>  '
>>
>> +test_expect_success 'type' '
>> +       test_config transfer.advertiseObjectInfo true &&
>> +
>> +       test-tool pkt-line pack >in <<-EOF &&
>> +       command=3Dobject-info
>> +       object-format=3D$(test_oid algo)
>> +       0001
>> +       size
>> +       type
>> +       oid $(git rev-parse two:two.t)
>> +       oid $(git rev-parse two:two.t)
>> +       0000
>> +       EOF
>> +
>> +       cat >expect <<-EOF &&
>> +       size
>> +       type
>> +       $(git rev-parse two:two.t) $(wc -c <two.t | xargs) blob
>> +       $(git rev-parse two:two.t) $(wc -c <two.t | xargs) blob
>
> Can we not use the `test_file_size` tool to do this instead?
> That should also be much more portable.

Yes, I will use it, I didn't know about it.
A test on top of this one does the same pattern, I will fix it too.

Thanks for the feedback,
Pablo


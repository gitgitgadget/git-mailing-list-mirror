Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1F1152517
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 09:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729676934; cv=none; b=raxokglWsEcHrXwu6JxtIWKAYxf6ftiCy9HqX8TzJwX00zF4KvbrVROVuEXI0A82b2cXSDCoEaAFY3UtRbbgny4F1Qjz5qbvq5etj0dmpUSrx3/RPwvhzi8MSb4PusMfa/BaUcNOR4I2pLOJB6TdkRGm8kLeeXqO7CNR2f6uFmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729676934; c=relaxed/simple;
	bh=kpgWHUXEZSpnUxF9p08CJFS2404d+zx1ysrk3OnnLqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dtW/YFFROEv9V35b1FbLBf41YxJ1IRcOZvkhhbzx8DyEnBNzKmQhYp+hI2AsN/czoz+J9hf43jdbZcRw3sCEqoViW4mmWV4oh5djCpHEU0u26ylPgZCjao9VFBEJvrb5Vn/Xu8bZtqGO2ooWeI86hkoyW59NMWaCux/PH4DMkLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+Uyh6MM; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+Uyh6MM"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cb6ca2a776so3641621a12.0
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 02:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729676931; x=1730281731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FohIKkJ3wjvo6MxAafmTbafPL+CKHfsf6Iyy0nRofo8=;
        b=W+Uyh6MMfXyoq4tQLtuoVyy8qVdmCZx+VpKOeUxV93G9kSgvDGw5x+OL19VVhpisfY
         UsyMgkDtMpMiutRl1Ee8IclQiUWqHKrf5/0kJPdxpTuaRcQRuSTmX4GQbC/uLsgGpahi
         SaTpX1Zcp3GqPRWs9pz/b1hrYATfbe0F5H97Fs7eGsSvZcKgIvTHCsXPrJNu0+lSFdWn
         FvuR0LkF2IZvaUkjOAH1Y4aVlRF5N+2U8zlw+bfTU5WWNWZmwbRa1SUrpQmCR0uXGYln
         e0wEd7z/dfeCPuV1nhzeGDpM3FZ7SQRQcG9xTYYjyvdvXTsbJ3MB6jwRgbvvrwxMGE12
         n3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729676931; x=1730281731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FohIKkJ3wjvo6MxAafmTbafPL+CKHfsf6Iyy0nRofo8=;
        b=KJhj16Fihy9iaBgRcQFn6TRcmCYWtRod+2oBI+/URRdOCsGIibDSZrq53M8N2rntZn
         wmfUtui9S/rzQ7rIdSIV2yJw42SgVDSe5vgY3kUahzdmtn+mFjjhwlDkuX83t1hiKDqG
         VpcuKFcsQUIOdr9NWW9kQusLe38PvPUFql9iJuPz1cpNRKdEYdNHhHJ4cJQf/Y8BmiJW
         TEZurMpYn6vcyqvTWFTDWSzIWOF3kcDQ2skl/NO+aE73xg3kgizf9XFYXyiq5aYhaDAA
         nUSo3Hm+ynjsNBgBWGo/XnHm36sI51hR1YOevOnzLM6ppK2gBuhL/PUd4bb/UjEARb0t
         1nWA==
X-Gm-Message-State: AOJu0YwdPAt9Umo1PuI5HTPGaXMSIeqAzNhYo+FAe9OrDtN8AUNgHpcd
	w2vOz6UzsFZ+7cCFV0tE4iMJMN5dPJbyxSaATzbb7N7GLUhmZtzH0j8H45bbwr176SQruB8ypHX
	/os76gDRB9LZ6nEPZTyr0PWLiovc=
X-Google-Smtp-Source: AGHT+IE2cQT/TiWkjf9QqA5lwfXOFAyNWLVT7NCT6Y0Dv1WnhpzXpaGp3aFhOmwbKIJVyTNyFZ/PRhtnTwbL6uVxar4=
X-Received: by 2002:a17:907:ea0:b0:a99:4162:4e42 with SMTP id
 a640c23a62f3a-a9abf8ac2acmr148439966b.37.1729676930750; Wed, 23 Oct 2024
 02:48:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20240926013856.35527-1-eric.peijian@gmail.com> <20240926013856.35527-5-eric.peijian@gmail.com>
In-Reply-To: <20240926013856.35527-5-eric.peijian@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 23 Oct 2024 11:48:37 +0200
Message-ID: <CAP8UFD0-EPZkdWd8xbg-Yt+aSGfJQE1cFz62Oxwjm-8N1sQ2PQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] transport: add client support for object-info
To: Eric Ju <eric.peijian@gmail.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com, 
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com, 
	jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 3:39=E2=80=AFAM Eric Ju <eric.peijian@gmail.com> wr=
ote:

> +       if (transport->smart_options
> +               && transport->smart_options->object_info
> +               && transport->smart_options->object_info_oids->nr > 0) {
> +               struct ref *ref_itr =3D object_info_refs =3D alloc_ref(""=
);
> +
> +               if (!fetch_object_info(transport, data->options.object_in=
fo_data))
> +                       goto cleanup;
> +
> +               args.object_info_data =3D data->options.object_info_data;
> +               args.quiet =3D 1;
> +               args.no_progress =3D 1;
> +               for (size_t i =3D 0; i < transport->smart_options->object=
_info_oids->nr; i++) {
> +                       ref_itr->old_oid =3D transport->smart_options->ob=
ject_info_oids->oid[i];
> +                       ref_itr->exact_oid =3D 1;
> +                       if (i =3D=3D transport->smart_options->object_inf=
o_oids->nr - 1)
> +                               /* last element, no need to allocate to n=
ext */
> +                               ref_itr -> next =3D NULL;

Space characters should be removed around "->".

> +                       else
> +                               ref_itr->next =3D alloc_ref("");

Here for example there are no spaces around "->".

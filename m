Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A9C145335
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 18:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732126848; cv=none; b=U59PbvrBlCYdk44fyUYn2U782QecuCBeCqSvE3xcH0sp+HcUV/ipfwRegU4Lmpi+KxeiTqZLEod+TGwEdCk3THklQCRGunbivmtXC/3TCihDB84Fm3DbVgilWd2tNnM93U5Y/HoFObSVV8gi73vwRDUWP5FI/FXyhCe1DXWcpBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732126848; c=relaxed/simple;
	bh=Vy0WCVRXiZC5sixC33WrH7V7IvqV19fxrD43nI6eoEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nD71r5FCYSxMlMK4jU/GblGNBwf0wqwcWOkjvEwn+4pOZyAFac0YQPYRnpiiw1cgNiJt/cA8qTVCR5WrrA3PZ6nYh/7Up+MFk8Zu/Oa60++eTkgg1FRM/dhGqNqcm2j0QQHlFQ+5PyVFfI8y7UgoNtybkntIvLRcr9eI6xT56PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqvEcZOw; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqvEcZOw"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so12716466b.0
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 10:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732126845; x=1732731645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whdhgO4JFpwNuA6RmEo6sIsSwOW27eJSLHpfJDKG3TM=;
        b=EqvEcZOw9DZstihSfS7tTu3NapW5AW6TFmqTKwNLT5K6X01gLs86ajkm30hOwdhCqS
         vqgWPk1HkyoMsYc1v5VcggqPxPSCF6xCrPl2Ss6klLUPnuS+iSOHPA/SXjHntdD31+e8
         a2wBJ8gpC0NFeaQGvoz3Pt8wngusOdprtzE+UZJfVhxrJuejMGYx5Z45lx8K9L66yDw0
         xvgNfOCli7y7W5TX/dsdqEjnO/FdV40IQJFCCZkOQv2kcoiYfvV/wRCNXT8mvhF9g29X
         9MS4fh82wyk/bKxRpCm4EiVnGFe/FalM8Hu81ec02saKSB7zJNIx7JsK+cc+99+t9x2m
         wSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732126845; x=1732731645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whdhgO4JFpwNuA6RmEo6sIsSwOW27eJSLHpfJDKG3TM=;
        b=m5MC/V6LhPFdSHH2LkScguHp+YbMsIHnMdbRzsDjemSv/tx/BcosijKWVJ090GjvCO
         VblQzvPwfWjCg6nF3XBVtZLzwOQ5PHzyk9P6o6WyL/h/JyMgHe3NYCBnp8qjjvb06TZn
         UWXCphc8WDdRIzivlzX4RJxDp6H4QbTAgslNRK50KBuF2PWPb+33/M7SZjJTklRr1Uhc
         kSQew+4OaGBRp7JeATWQ8BllvxVpULgJcskwXLtrpKuhRzh7owm9zOfjBsIQpxXlsGHm
         /WcrvMuhksNyo13ToYDHQeH0MRqWTHPfB1WGddOj/5jfHNOPOhXfaaJP2QPPuFALTgD4
         WcTA==
X-Gm-Message-State: AOJu0YzmnPkMJ/mppcPGBxw383D9foMjUsCpcyO4P1Utnoi812bh3Tav
	LYRtKmcfa08CkjAtmLvt4XNbqSZDuQ85civ8A3pPu5wuqqhKA+z93klk23zMSiK/hQ9Ff3vDPjJ
	5PBp/F2C4wrTI7Ldj/ROnRvENk8o=
X-Google-Smtp-Source: AGHT+IHW70tOfvv/eXwKQqxN0ESwiSd4tsMgPB/3d/B+hyvvIlCVg7AisUL5yvIa4wg382RI+BPyWUtMholpYFxe3to=
X-Received: by 2002:a17:906:c145:b0:a9a:3cec:b322 with SMTP id
 a640c23a62f3a-aa4dd72b612mr345475666b.45.1732126844952; Wed, 20 Nov 2024
 10:20:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
 <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
In-Reply-To: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 20 Nov 2024 19:20:33 +0100
Message-ID: <CAP8UFD08qQ2hm98dKfMNEABs19Bbs_O6T6EMLpHOofQ9=A_WpQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Change midx.c and midx-write.c to not use global variables
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, shejialuo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 4:38=E2=80=AFPM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
>
> Similar to the earlier patch series on cleaning up packfile.c and
> removing usage of global variables [1], we change the midx.c and
> midx-write.c files to no longer use global variables.
>
> This is done by the following:
>   - Usage of repository variable already available in existing structs.
>   - Passing down repository variable from other subsystems.
>   - Modifying all subcommands to obtain repository variable from the
>   command in `builtins/` and passing down the variable from there.
>
> The biggest change is in the first commit, wherein we modify all
> subcommands to add the repository variable. Since the subcommand
> definition are not often changed, it shouldn't cause too many conflicts
> with in flight topics.

Overall I like the way it's done. I found a few improvements that
could be made to some commit messages though.

Thanks.

Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47E83081B9
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 23:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763680276; cv=none; b=Nvqs0vsXxJa7k+M/OutmyDXkCed2kHSgdfj+sr/99JhfCt5V/8zO3jSHGa1paajOgbgMKMwXLylEcaqwHC6D2N4H4+j6IacAyQaKbzcwGq5s+YfCB9YQDGydBDuxIwWjKwwulR6apLPmGY7ns2oYmb2QB151t6/B1JZ6baNVv/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763680276; c=relaxed/simple;
	bh=TvsYJIN1wHtjaLnrp3lqmp16LDaDvYryzUAP5O4oQac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=GKKODkR7rko63Q9QFyENQA7PLXx19RMvcAdceHWLvP5VEdoLaLhfmkUs73MQ/PkkDSXs4txBJVLDm/eC81kt8ZIVgpbnqYwDGndETnazBp701Y8ByaduufL623dBDN+nSAC1VgBYT+O6vyc7py7LxHMOez96BTCpVKIP5LKIIo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUQOHLnb; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUQOHLnb"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-37ba5af5951so15924421fa.1
        for <git@vger.kernel.org>; Thu, 20 Nov 2025 15:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763680273; x=1764285073; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TvsYJIN1wHtjaLnrp3lqmp16LDaDvYryzUAP5O4oQac=;
        b=PUQOHLnbLo2YWkv9vIO7SYHxRWCAPS9aMx5tpKvbwqfSNfBpQrpqlIDEswNdIq+Mok
         wATBPYQsJ9dir3q4XKqbTB8kDZurLx96UH97HMqjLp0kL+j65GILV87DHGunTKOYVjRp
         WFrFW/ZIYBQ4xKNxAjhfOvYVTubrXHKbCAtJUC48IfDpXo9QWVkX7H5a64RNvv7vponL
         XiuayzOPiB+TqK1EPrh2XK+bZhkZBCtKGIJOlyA04hLCdy0njwDepJxp9VaRiRl3oSCC
         B6WpcLcd9kgwxjZKbZ6/mkUuwOWIX5k1mGh0YVlpgTvmeClEFJv9vjg2d9MY3KU2Zj3i
         E/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763680273; x=1764285073;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TvsYJIN1wHtjaLnrp3lqmp16LDaDvYryzUAP5O4oQac=;
        b=KKAdD9UskGHY+GPVdPyJlJxoy8VMsRQ7bNhz+aAubOiWy7dZiBmRBrBTHsI7CzUPF4
         /sIUbPdH/XTOU7s1tTAIrSsYsPcND5h2fbwQ0SQbNzyhlaGjbqTsQtqgY2suznPNEhlQ
         ikekPS+afW6ab9zjj0CxDg/SFUPIyeQ6MdTNhjGNeNYOaLVQMJbsxCHVV3rLdh8xWH3C
         DAHcL0wRvA5s7+9EPo1Mla4zfCHkAjDVhebOLJxXvsZ7D61XeJFduVoAWJB9PAYjtj5Y
         Wbi113KDMCiJlIC9Zgujvh/twjaQktEUBtNnVL3sJ/kFpvHuNSABw7kxa5sE3I/9TO16
         7iCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHpaSFK3fukcfypaJ33zcnaPb9aRRXcfDwimMM1lZyozdSzcWUA/Z8VYNv6FGOeQMPuEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTwzSsMiy3/fgHUuqAOdctT8/QpUz5uP2CuaAJGeOU+w6i4Dru
	rfedu0f16N9crF07j5UzGGZ3HKvUS6IoKEiLD/ABxsyMMgYp51A6NzrzJlmbircgYawD8ebvRuK
	lqn7hyN4ksoYrQ3Fop/KjaynVn7K1b7nVmQ==
X-Gm-Gg: ASbGnctpsD2m13JdDrjEGRJRgToi9w0VwIzUZlAgjOZ4BT3Wos/Ohj8TA4/DdHAThSa
	tOdMScGO/C/PUbFecMWIHMQsgIj3BhsQTEJDTlrbTUgdZzrFSQAS/EljuAqPXvfajA6Wf4h4P9X
	/2u+1Trh7gc+KzgQ1YNYaVy3NXV1qZK/Jwv6kdzDSo55T7/o6kVOUAqQqpPiiErUO65q1zYtB04
	J6DETR38nBzQsiKvC96m4uIsFK0Tv4GpT5llrlCHaASf4BLkWW1VW+WMtjJsKDOt/2x1gyG
X-Google-Smtp-Source: AGHT+IGdtsKm6fDpHe8aQgFmQWFhoRSAQ6ZRfBTHlg/T9EcH4MvST9PIBCTWh1jcJ/ds61XheKB4PgZa6+ry4pEA5B4=
X-Received: by 2002:a2e:80d4:0:b0:37b:9b58:dcfb with SMTP id
 38308e7fff4ca-37cd91641femr12261fa.7.1763680272468; Thu, 20 Nov 2025 15:11:12
 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <xmqq7bvsjzlx.fsf@gitster.g> <xmqqpl9h9mgo.fsf@gitster.g> <aRudLpkRdRtCAoi3@fruit.crustytoothpaste.net>
 <xmqq4iqsgpu3.fsf@gitster.g> <aR5M65HDuGlTsR77@fruit.crustytoothpaste.net>
 <CAH=ZcbAmAqWMYXhYT3bX_Q8cEkV0ZcjEtM65YS7DXPJbs-L3Wg@mail.gmail.com>
 <CAH=ZcbDER4OysywLZpCc=-GQ+rweSfVAQ-xj0gNd1rF4-=cPWg@mail.gmail.com> <aR-eIooTkjbktsf-@fruit.crustytoothpaste.net>
In-Reply-To: <aR-eIooTkjbktsf-@fruit.crustytoothpaste.net>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Thu, 20 Nov 2025 16:11:01 -0700
X-Gm-Features: AWmQ_bnmrc7GIAe6dItKd-xTbbB7Ep7KNie6CupzvfAlS-SuUxBNbKgYAhLdbAY
Message-ID: <CAH=ZcbAnnakV4RgMJdkJB4hL1HyfbmY07EF-axDbEY_=_tfmFQ@mail.gmail.com>
Subject: Re: [PATCH 00/14] SHA-1/SHA-256 interoperability, part 2
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Ezekiel Newren <ezekielnewren@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 4:03=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2025-11-20 at 19:52:23, Ezekiel Newren wrote:
> > Checkout my retrospective review [1]. Basically if windows + msvc ->
> > <crate>.lib else lib<crate>.a, but it was coded as just if windows ->
> > ...
> >
> > In the github ci these are the only windows combos that are tested.
> > "win build" is windows + gnu + Makefile
> > "win+Meson build" windows + msvc + Meson
>
> So I don't think that fixes the build[0] with this patch:

You are correct. It's part of the whole solution. I'm working on
ironing out all github ci problems in my cargo-workspace patch series
(not yet released). Once I've figured that out I'll publish my series
on the mailing list.

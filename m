Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E29134CC2
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712832013; cv=none; b=ek0riBFDE6c/rFULjBM8rF1lidP2AcoBEfMFctCKL7fs5yE+V/dhKqGA9ZSWBltPubKfvSLhpxPYuZEtnnBZ3HW2sOp2kHB6h+99NR22+pHA3BDz0dPD41xXwyb5C91g/wzhXJz8PoIUNsxUDKgmGRC9vgaGnoc+yHPavZEhJag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712832013; c=relaxed/simple;
	bh=7AD6iht8UUkIDj8TIIxXYRn746Gtk8f+AK5D1KBTbQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ORpFqS9qsQdoHPn+fPO8zK5nRqeUWhJUe/euboAoFKugIknmkZHi6IVAwYp47pU40oDUKevs9CfTSDdV2cadB4OCitW5r3gUf6Xym4pSqWnSskpQacPyEHmlb6QbUgwy0Z6yPo1Fl8dnviELkLVnI0OAFQJS0BB96H8XByPKRr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjdqwwGq; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjdqwwGq"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e3c3aa8938so39217545ad.1
        for <git@vger.kernel.org>; Thu, 11 Apr 2024 03:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712832011; x=1713436811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HceurUqkZoJ/tae8IycMSekq4IZ+U5jUY9BDKvEp/R8=;
        b=gjdqwwGqiE/Qdhv+ux+aGKyws1DJMmeG9ovleWoK4n+AMtUIK4vOWvnrQNZtJrJ/Ts
         2drxTGADChOqoPgpBPcFBR4SOu85Xl5GOcxRrH6AYDpf1dVPED5lM/XyB6S/Ubh7gY+T
         IMDVKQfpwZ7ifwRl3bRzaUcHWulw8PY7D98zjk4swA1iPTrmQdjjiacYQ4muD5ljAZGh
         G5Ntww0ZeUv4GbqFfRIePMuVn6SXZNrS6tKwV3FMYe8bb74vxljEeQ2sW8AyrKe9GYBt
         FFemMxaS9pC2ZGkKhHlK6JsfoVapb2UcHiRTMm7IWlDCED5ZKoYnNALMryKylmdhnCNv
         fNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712832011; x=1713436811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HceurUqkZoJ/tae8IycMSekq4IZ+U5jUY9BDKvEp/R8=;
        b=g6PjsoVfsNVaaxjM1rXKipkAAkWQkrytvdCYmkMjN+koTvj2hufzj88Uv3/GJkej/S
         maXFtgP6d5Z0obcmJPOvRPqckT7Ml2ErMxykwydWOvMeK4X1APmcviAXlDVEl5jMkti9
         HDHznyV2pKv+nes2HyiIGpuJZbttYahnrYT6kqY6D/M8CG42VboTwsbjbuKO1WtYYeoE
         4ZCb4Hhv9pvFurA0LA2TJRUqpHYSwD+ujVeHRfHK8537Pkyii4kA3bpbr9ed/q8tsEWd
         UnAkqCFlf7KGQxtHh7sFXMoug/0iIvYDBwzGo72c1xb32PZ7gk2XILY3KDBf0qUR/L6y
         4q4w==
X-Gm-Message-State: AOJu0YxCKnrcWEgJP/sT9R+pZyo/PXVZne5puifvjF8O6TQJ22b+Yqlg
	I3TyYVm1vS9G8YC8ItC1LzW0z+tqtJ8+I5kKqGl/FaX3CKTiyj+I1bvi2JkuhDBHV2hCJF2g0RU
	E8RKMuxP43fFHi7vgsVm6R0/CSxFD+42o
X-Google-Smtp-Source: AGHT+IGO5b4nKAYevY74NCEyCpKCZvaB3feVTbYiRfmP42/UXXTAiPzoeoyx39IRuuiGGcKTOGV2Kq3qPYveVKiCfaw=
X-Received: by 2002:a17:90a:46c8:b0:2a1:fb5e:6028 with SMTP id
 x8-20020a17090a46c800b002a1fb5e6028mr4966707pjg.20.1712832010823; Thu, 11 Apr
 2024 03:40:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1669.git.git.1707479467028.gitgitgadget@gmail.com>
 <pull.1669.v2.git.git.1712822221.gitgitgadget@gmail.com> <28a5625f32cca6ef134a385fe9ba66962c40100f.1712822221.git.gitgitgadget@gmail.com>
In-Reply-To: <28a5625f32cca6ef134a385fe9ba66962c40100f.1712822221.git.gitgitgadget@gmail.com>
From: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date: Thu, 11 Apr 2024 12:39:59 +0200
Message-ID: <CAN0heSpvKFKVnyve0wvcVJ3gvm5H8OggVTKpz2Se4je3iRHwCw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] doc: git.txt-Fix inconsistency param description
To: =?UTF-8?B?56eD5aS054Gv56y86bG8IHZpYSBHaXRHaXRHYWRnZXQ=?= <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, =?UTF-8?B?56eD5aS054Gv56y86bG8?= <ttdlyu@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Apr 2024 at 10:20, =E7=A7=83=E5=A4=B4=E7=81=AF=E7=AC=BC=E9=B1=BC=
 via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: =3D?UTF-8?q?=3DE7=3DA7=3D83=3DE5=3DA4=3DB4=3DE7=3D81=3DAF=3DE7=3DAC=
=3DBC=3DE9=3DB1=3DBC?=3D
>  <ttdlyu@163.com>
>
> Signed-off-by: =E7=A7=83=E5=A4=B4=E7=81=AF=E7=AC=BC=E9=B1=BC <ttdlyu@163.=
com>

> -    [--git-dir=3D<path>] [--work-tree=3D<path>] [--namespace=3D<name>]
> +    [--git-dir=3D<path>] [--work-tree=3D<path>] [--namespace=3D<path>]

This makes it consistent with the instance later in the document, where
it already says "--namespace=3D<path>". Ok.

However, this is documented as "equivalent to setting the GIT_NAMESPACE
environment variable". And gitnamespaces(7) says
"GIT_NAMESPACE=3D<namespace>", so that is still inconsistent. I also see
this:

  Note that namespaces which include a / will expand to a hierarchy of
  namespaces; for example, GIT_NAMESPACE=3Dfoo/bar will store refs under
  refs/namespaces/foo/refs/namespaces/bar/

So foo/bar isn't a file path. gitnamespaces(7) uses "path", "namespace"
and "namespace path" sort of interchangeably. Even so, I think it could
be a good idea to avoid "path" since it could give the wrong kind of
ideas.

I wonder if this patch should instead change both --namespace=3D<name> and
--namespace=3D<path> to --namespace=3D<namespace> and give some motivation
such as "Make the placeholder consistent with the gitnamespaces
document." What do you think?

Martin

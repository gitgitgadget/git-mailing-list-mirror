Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6553D1EA7EB
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 12:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969740; cv=none; b=hxXRJaJKwxjt6g2KtCV5zRLecWwE/uMTTZ9JPqkggzNrN+QlO+arKKhpQqSuI/H9J6HkOhc0buvaaPFRFj4j7y3m9BQTv1dKk4gntOIJQgf+ymlDNOBtqnQq7itlZzdHdy+AmAn2cBWPdIMKMDtMcVPAHOFTYpj4la1N/hepjYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969740; c=relaxed/simple;
	bh=fxapkRPj7ETPBQ8dUemYMtvgl3lx8q8Fvp5TAsnSft8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ctG+0EAk4p8SntNtEEGFkFC57kKuL1QgBsYWM7BPkcOAXcHUc2xvM9q/iX2MVmfGUrdu2PVFsATwaq/gGdqFy75qBq8z9En9r6X193S+DptSCCwjM8XNEp5rq9AkD1Tk9VBO/cSeUQtxgDK961DEzWE9zI2E9LzNClHtCOiHkNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eflSg3IE; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eflSg3IE"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fbfe16cc39so12354123a91.3
        for <git@vger.kernel.org>; Wed, 19 Feb 2025 04:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1739969737; x=1740574537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxapkRPj7ETPBQ8dUemYMtvgl3lx8q8Fvp5TAsnSft8=;
        b=eflSg3IERYUHANOFjMTjB8lkzTibxr+bfTwOJy8nWxYyjn9hWD7WBZ7k+11a9U+0fn
         nRDn4SvGUB4H9JqZiG0tFaKKSUnljhEb8HZaEiM8c+FDHs3GjrRjSe7teMywZ9Gruh3x
         0iNY3bE5kawUElI9Zo9XgCDbHlbL2/4tCyHmFcEgmlM4j/tSEYX8r17ttlvodSLj+JwJ
         9liDsf/MRQpOkN/II+wzXRh47n5pwcTRzKy9SqKeGDW5y7Nsnf5JSqTXn0bJe4YibLYk
         tadAH3HdQa9m4GZBwWn8bsQrjWJt+EmFFVjG7H99Dv5uHMxuuA295cZQPUOjvYyHs8Id
         o9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969737; x=1740574537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxapkRPj7ETPBQ8dUemYMtvgl3lx8q8Fvp5TAsnSft8=;
        b=OQ4DzaCUCN+BTqoenxRBV4RpBwpllEYopBf3e0kwNISZShVniLqcFSMJroYTTQbIdY
         dMlZGFl4mVd0uXAqdarbC8EYY758B/YysOdRWCmobaOQcamoWGiVlYOpE8UeYgPOO1fu
         H4/0Kb8oeMEcffrQbSdlw07ezSe9hgCDRqI4HjJt5bO9i+O0VTc+dopCq2QNEW+x6Jh3
         rSjRCQILpaK2iTJ6JwJDJ1L73A+o4Gl3CCrDnd0QRIi9QebOaMKazxDNl5C96CrTB6W1
         ELOMjciZu0GmwXF3z6YxV6k5G7ZUs+EtEWQaFKa07oNMVRlodeyR2HgCfivYlMJwKfeZ
         qdvg==
X-Gm-Message-State: AOJu0YxSBrgwOyAKSrl7ReVV48iClVqhhMi44ipGiTI5kLwKbtUIb16y
	SlsuWbg93OE+FLd+PxYx5MxArhneBENw+mGGSSCgODFCWm9CY49pnZ5bauR/fuCFOpcKxYy/unV
	TjL2qOySlpJwmWgUvDzJqPp1I98iwF/+DbqVX6RuGkU7QRThjLh5R4w==
X-Gm-Gg: ASbGncsyq7A0LL3tFg7pATJBLq5KBpDUfGuQ269OU+FzsgJcmjldL9LGwL1h9JpA8V3
	UxOiJZZlPjqcWticSsVh+UJ3FgeI30BKnR1knBLecsvzRt8bEV8G3S/bzmx0wd84JpdRHEW2MtI
	A=
X-Google-Smtp-Source: AGHT+IFxV5Xx8AytameO3HWPfsyCxcYJrCjWcbWFavcbPoge6jnCmA5keUSEgmfsMfGQV+CCPEcj5jPdDx+Z7vO2uWM=
X-Received: by 2002:a17:90b:2f8f:b0:2ef:2d9f:8e58 with SMTP id
 98e67ed59e1d1-2fc411508famr23835339a91.34.1739969737519; Wed, 19 Feb 2025
 04:55:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2728513.vuYhMxLoTh@mintaka.ncbr.muni.cz> <CAG1j3zH1xngk0NZUjHA9Akx526yfEiQ=KsdfyRjE9XAewWV=Sg@mail.gmail.com>
 <2289498.vFx2qVVIhK@electra>
In-Reply-To: <2289498.vFx2qVVIhK@electra>
From: Han Young <hanyang.tony@bytedance.com>
Date: Wed, 19 Feb 2025 20:55:25 +0800
X-Gm-Features: AWEUYZlj-TMC19iuZdFk9OuIrYBg9Cbmfq_dycDLvcX7nmGFEhtwveT3Y0BniwE
Message-ID: <CAG1j3zG-FcGZe-64dmZJOAitjKsnbB5KUUkmQt6edyhM7z_NTw@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH resend] builtin/repack: Honor
 --keep-pack and .keep when repacking promisor objects
To: =?UTF-8?B?VG9tw6HFoSBUcm5rYQ==?= <trnka@scm.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 8:53=E2=80=AFPM Tom=C3=A1=C5=A1 Trnka <trnka@scm.co=
m> wrote:
> With my patch, gc did not touch these two big packs but still collected a=
ll
> the small ones into one new pack as expected. Everything else also seems =
to
> work fine.

Sorry for the long wait. I have tested the patch against a repo with only
promisor packs. There are one big promisor pack and many small ones.
This patch do work as expected, I'll take back the earlier

"... does not prevent the keep promisor packs from being repacked."


> According to the man page for git-pack-objects, it seems to me that this =
is
> how it's meant to work, because the description for --keep-pack says "Thi=
s
> flag causes an object already in the given pack to be ignored, even if it
> would have otherwise been packed." (and something similar for --honor-pac=
k-
> keep). To my untrained eyes, it looks like that's also how
> want_found_object()/add_object_entry() in pack-objects.c handle it.

This is also true. However, the for_each_packed_object macro in repack.c
does not ignore the keep packs. repack still iterating objects in keep pack=
s
and sending them to pack-objects. pack-objects will then exclude these
objects. To avoid doing unnecessary work, objects in keep packs should
not be send over to pack-objects. Checking if the object should be ignore
takes some time, after all.

As for the test, t0410-partial-clone.sh is a better place imo. For the test=
 is
for the partial-clone repos.

Thanks.

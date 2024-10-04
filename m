Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B0B13A257
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728036472; cv=none; b=k1dmJIl5IjaIYWEydBStg5rwne9yAatfFfbFtuVFaJYFAcVG0+IzQ4ej1CV8VZ8T9PfZMnl1OXzK5fSoPXqm7TSghR28EzmwZ04t/uvSL1wRQcWM3v8B5qJhyPWYCwSwOY0V7CS68BCGlmtrRSTKrGhinkg2EAnYniHkzzIZPPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728036472; c=relaxed/simple;
	bh=XH3r3GBYKDFOvS1NeQN7BKLnidIAVY8SE8bDUGG2biA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s3GYPKG/NPbDtH+O0QI0An/vOJtRreQzYULo8BkA/DdoE6apZTVTqVAlSnGKp2TWk2KO1nj5NwSBIkG32Cr1TBT3abjINF6S3HDyYqQ3gAFLIO+naT2Sy5cw6FLV3BCb/7PlvwGCDRU03ZKs8/SsL9yGhaHmV2TS4DBUg29r3Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVERiG0q; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVERiG0q"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37cd8972738so1424937f8f.3
        for <git@vger.kernel.org>; Fri, 04 Oct 2024 03:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728036469; x=1728641269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMUrJ4qpTVLC8i6gTamPxTl9KOLYjkQu1p3ofmqQHnA=;
        b=PVERiG0qEOX7kDKY6O/wMvyNfRGARYJykyLo9cnFXIkgeqR5BI/sd955Q6bQomQv1+
         1s1SbwYlt9ec8C04N1nA7WGe765jyqmInVtVNdqV6pK1WhEQTQr3tjSis2wX0528UQy7
         nGJkt7LoSgvGPPTRR+kQwDvI+SSpq1IiB14ITC0iEixYg36Mbi+nMu2zx14EZEEOqHs+
         lNAbJsBmNRJlR/WXzKnvm8JZZSoKh3aa6btKwNq7kXXny22vdBr9hJoUh58P9o+tK7cy
         7Xc5MnPkb2YpvExtHivNnCwYk41I4YkPf4A3/fyPFFyTDc1+ASQLt2vnJiprJSd/cNM9
         KUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728036469; x=1728641269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMUrJ4qpTVLC8i6gTamPxTl9KOLYjkQu1p3ofmqQHnA=;
        b=QIzzEO5UjRd/cdH+CjsddeUTqBPoJyh5zG443VSgbc+T6MoX0c8HQopvIpr2Fwobyi
         KTSl6JhfhUBBzqiOv0OxRbq1pa604tQ/Wts8CstCEwttLxmgWgK9/MdpJUjZ+S8VKMdN
         P7ywmpYjUApjwI433mLp5FdTsUJFlu/0yIDCebl/3cbi1qX5LF3lN4KJrqrnpMO3T6n5
         P7JZvuoA5yXhQ5/sq9S+yAWEUkk7FTltAE5SKu4oRvQzcw9kVae6QTzpPlP8b9TRm2uj
         7iW7Gba6D6SQQkO4DriYaGvBDdH8/cs702mrV/S7M9uYcOkd0xVcFpQfFgvNrSsIZ9Y4
         JLRA==
X-Gm-Message-State: AOJu0YzqAiKUqmypE1aqfu253wtA4tYvkr79dIg31h+57MaoDo04KuPI
	ckMBeLCTiO5kRuf+I+w+Th5CNCE+fM6g0fPtYe7avJpMvu3pz0CB3qa1Rt8x9eAERvoyePtYxUc
	73fUWyXaRgfgqGOk7S84zvbQjk5s=
X-Google-Smtp-Source: AGHT+IFzgu94u8SVaFn0gcoswAA3gvvZdYPXSgCghc4HDTcXxAcy5TynNdiXpODyd435TcKCtkX8YHV/iePKhraxguk=
X-Received: by 2002:a05:6000:1046:b0:37c:d4a4:3c2 with SMTP id
 ffacd0b85a97d-37d0eb0be52mr1138641f8f.49.1728036468332; Fri, 04 Oct 2024
 03:07:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <faed1d0e-86a8-4dcd-a27f-19dcd9f89f37@web.de>
In-Reply-To: <faed1d0e-86a8-4dcd-a27f-19dcd9f89f37@web.de>
From: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date: Fri, 4 Oct 2024 12:07:35 +0200
Message-ID: <CAN0heSoN-iEdzj1BTw6eRDvRzLkK_oXdSwaG=hxeZUQiYvWZUg@mail.gmail.com>
Subject: Re: [PATCH] archive: fix misleading error message
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Oct 2024 at 17:51, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> The error message added by 296743a7ca (archive: load index before
> pathspec checks, 2024-09-21) is misleading: unpack_trees() is not
> touching the working tree at all here, but just loading a tree into
> the index.  Correct it.

>                 init_tree_desc(&t, &tree->object.oid, tree->buffer, tree-=
>size);
>                 if (unpack_trees(1, &t, &opts))
> -                       die(_("unable to checkout working tree"));
> +                       die(_("failed to unpack tree object %s"),
> +                           oid_to_hex(&tree->object.oid));

The existing instance of this message isn't translated, so it'll still
be a new string to translate. Anyway, it's good to use the same wording
here as elsewhere.

There's also a "failed to unpack trees", but here, we're indeed
unpacking *one* tree.

Good catch!

Martin

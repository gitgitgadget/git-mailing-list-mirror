Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCF62F9C53
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757931469; cv=none; b=RPDjZkc5MlZ2uKAM0ZJCraSbXVAuXDwmnawaRiTusAPMvVoWHUrU1FhWLresSXfPCtRFMIIN+50dGpESgtfoRBqpNqlvujLMcxqRSKB8eQCjpxc17Ol3li8hOoa6MHhZWDckjN9YQC/TX8U6CEUVI0O00KFft6y2g471cn+PdGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757931469; c=relaxed/simple;
	bh=aSFipCxHPb78dR7Sc5vDnzNp6sU7dPyM9hAqYGgNhLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hr1haAN+LY9kUyB146Ho4ZhajzGs7yMhKt0borALVtmbk1VToBdmqUkazb50NAJ2PgyDas/D+u6jKyKWdMxSZsEW5IeU51QwgE60q4xfmsMI0iax+AXNIDWuCbTP1TofCUCSMgbfC93RhblNtxqeGItx3iZVZBjKhGEwAflvF60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xyy1cKjR; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xyy1cKjR"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b04271cfc3eso502520266b.3
        for <git@vger.kernel.org>; Mon, 15 Sep 2025 03:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757931466; x=1758536266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKGNdTJ3ohxByxxq+sEDr7tRlaoTCuGqKUhXQySPvyA=;
        b=Xyy1cKjR2guY4jk3gcVHkJReOwR073+GR+DgG23jXUE+sDuCQBsAP3Zr6rp0/LHkSj
         5Sr1PelMy01y1izikIEXRzEGfpBsCZC7MDiYUu6tsS6CUrGFFL+cEfwL7uv0s22nwQGh
         Q9/atZ33hnsHF6a299V6OphcSUA4Jq2EBCPSrHn7T/5UHKrIu/w0NIFbR+obgv/FwXKC
         uw0kgztld6wPhLWH6qGh7muDxf5jFPQaRoddOciAh9Jj/YsOOYafVZ/snCcYgkPdE+AA
         cGHrKFyBUj+SclKNp8fRl1FV7n6N9ORK+QFkTdjShf/c7Bj+Q0oGH65pB5DIJWcasCnY
         LKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757931466; x=1758536266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKGNdTJ3ohxByxxq+sEDr7tRlaoTCuGqKUhXQySPvyA=;
        b=TAEDIe3IOitu097hF6zGBVCG5+cRZfLLMmHucH0P+EhjwlS8VnnP3tMjgm8cNsaRrm
         YI1CaYPpneLVRXuupj1hdqBfXwcTIfkx3z2sjLFPJxZEr9A1CFu8l/hsozqSwD0EHARi
         gnrFmFvGpVJf3jTwvVWamPrrb9KqwR30z93kZGm1fOVPS228MC7awr389cCAMwD7t9tj
         X5v/N4yUZtU3Fg7c8By0lL41A1Y9ci44CgFGec04IpkwY1fubl4+Iev6JqGPuWjKFLyl
         kX7lyZJ7C0zrL2WYbK6gBOoamK8RpKyVow32nfssavWzyWuUG2Bbycp/k129a/fMZS5w
         FxHg==
X-Gm-Message-State: AOJu0YztIvzhnc0opxo9ImTvNTd1oOlJPPYBitBza0pNmiTOxrJHIfAK
	u24EbO86qNuIygrtKfKIejgoslUKnENUAwExbQTenjD8yNFa9MaVkTg3ZfrXiSsP8wzhLBm1hVn
	Ouh3IJ1DZDJq3U3EPsMcXhbPVwtMUAT4=
X-Gm-Gg: ASbGnctharU6rzWDkpdHZInyrWhnQ3AuoGzsJNVOGUDs1JQ6xCdMkUAXu8M1ZyTNoFe
	t5TN1sorM6jYgBcq7V1yclK5Z3vjlquF1yt1LUCLtBflnirbC6mikaAk4tl51+93qB1lafdlrB/
	7aIWpRakMsgVBbaygzVdJm37d57lVRM556A3iNpXVQEbKgBrpMiizWLxuvsTF6FTQDrcPtY6wPF
	1CiEws67A==
X-Google-Smtp-Source: AGHT+IHuZUun5OLi5kvxusrjC140PVQHJTbV8wNw6vYvkQaDGG8KtlB2rlXwmc9eR0zvfQHvfYkU0hxgDoDJXAQDMFM=
X-Received: by 2002:a17:907:3fa1:b0:b04:5200:5ebe with SMTP id
 a640c23a62f3a-b07c396d4b9mr1321013666b.54.1757931465829; Mon, 15 Sep 2025
 03:17:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912124042.2523683-1-christian.couder@gmail.com>
 <20250912124042.2523683-3-christian.couder@gmail.com> <aMex06JNPVeHaw_d@pks.im>
In-Reply-To: <aMex06JNPVeHaw_d@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 15 Sep 2025 12:17:33 +0200
X-Gm-Features: AS18NWDA5NJV6lRcjhX_d8JxeiJ_2lP2FGykuqjzAPXXvDi9ZTNCA2J7x44m21E
Message-ID: <CAP8UFD3-3zjBBHP-Y9nLO-qEyhkWhD_pxFZhk6rzrC31LanDMQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fast-import: add '--signed-commits=<mode>' option
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 8:27=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Fri, Sep 12, 2025 at 02:40:42PM +0200, Christian Couder wrote:

> >
> > -     /* Process signatures (up to 2: one "sha1" and one "sha256") */
> >       while (skip_prefix(command_buf.buf, "gpgsig ", &v)) {
> >               struct signature_data sig =3D { NULL, NULL, STRBUF_INIT }=
;
> >
> > -             parse_one_signature(&sig, v);
> > +             if (signed_commit_mode =3D=3D SIGN_ABORT)
> > +                     die(_("encountered signed commit; use "
> > +                           "--signed-commits=3D<mode> to handle it"));
> >
> > -             if (!strcmp(sig.hash_algo, "sha1"))
> > -                     store_signature(&sig_sha1, &sig, "SHA-1");
> > -             else if (!strcmp(sig.hash_algo, "sha256"))
> > -                     store_signature(&sig_sha256, &sig, "SHA-256");
> > -             else
> > -                     BUG("parse_one_signature() returned unknown hash =
algo");
> > +             parse_one_signature(&sig, v);
> >
> > +             switch (signed_commit_mode) {
> > +             case SIGN_ABORT:
> > +                     BUG("SIGN_ABORT should be handled before calling =
parse_one_signature()");
> > +                     break;
>
> Let's be defensive and convert this into a `default:` case so that any
> unhandled value will cause a BUG.

Ok, maybe something like BUG("invalid signed_commit_mode value %d",
signed_commit_mode) then?

Note that if we later develop new modes like "re-sign" or
"strip-if-invalid", and users tries one such mode with an old version
of Git, that should already be handled by the following code in
parse_one_option():

    } else if (skip_prefix(option, "signed-commits=3D", &option)) {
        if (parse_sign_mode(option, &signed_commit_mode))
            usagef(_("unknown --signed-commits mode '%s'"), option);
    } ...

Thanks,
Christian.

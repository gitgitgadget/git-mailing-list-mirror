Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA905914C
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 14:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723041808; cv=none; b=kO9CYG9XizmmqIYb5+7ymQrgOhiX3448eWxOXZPZlboL4NQYqn3X3KeBIVr0OlW/zVLeB4Ur86qllRrlqwnALrDRrqvEEupOxcCd6SpxZXxceMPyvCMJoHTg9SaxASj+H2MXpbuWkkYDAnXL/P/yVEcsRAtn5D3naB4VmM519+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723041808; c=relaxed/simple;
	bh=uuXYxhjWcUWLzU13Q1v6aWYP4PeketpcYVRno12+3d8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Psof86yOvG9ce50hct3dDclc3mEA/EJECwaFOgeoKCOj3RYXuD/uA2rMBhg3RmA77dareyO3da15X3q66j67338C66Kd8cCXnNNwUGcRcRZ6QDU8VFmZAa1p4tHwGBoxV36mFIh2UD3OFP2VeySfxPrsd2r1dYQzNL7l5kMLuhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IELvrtam; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IELvrtam"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a79df5af51so1554811a12.0
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 07:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723041805; x=1723646605; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ku8BxPlfuwZ67PbHYibdz7N1yLD5cTMGp7TsUNRD2Xk=;
        b=IELvrtamMmGXV4i6f0Vgo+I4WxVlDsR/cJkaZA5N4tDyQHjhKxQSuHRiPw2nHRPxq7
         /WH0ngaLtKyDk/rFb2+0dtUErAU+2clIxno0lUyqDEQepytvJ7lyoi5R6ypuCUC8legS
         MosKfAHS1Egv4EIhCzq0BfCqfBTZwe9YyUSOtCajw1XNZ81bvp0J1K6ueXylORgYYN6j
         tykEGtd2CT0L3eK4yPfiv5ZlleAG9r7XtusmtV40wCaiNaeyNsvcFXOkxwiSq8WW3XLG
         dJ4BfZSKxixjX9lUhfU10/Wn5HqJbd5B6KtE6uw0cerpfPBjagYXk7+57JPzGhFgLeZs
         IaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723041805; x=1723646605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ku8BxPlfuwZ67PbHYibdz7N1yLD5cTMGp7TsUNRD2Xk=;
        b=otNpvVUF7ydYiBUnmGVbLcFpoVQsOmY/vjph7xpfCPe2iJ2oKiniK3tRLRircOWjfT
         T5wXmrmYNcbDzHpcxIrIUTQ76hPPxOuFcms5WspqcmKY/E2CubA1ZJ1Szp+Z4fZtQtVm
         vjuKxIqy8IoBrBDdLoCaCxH2pzNsclZaRLuUeEdtTEjLfTdG+hDWY6eu+/CmPKvnGeSs
         0syUAzMjSBCKkPbS+rcLAENdH3oFHU7PFHbm9tZEY7Yco5j/0snwwFbLgwgKUoY3gcNK
         CoH3akLW1rM34BCLwCwMdr4jp0sxg6StIwjTzcacomEm3w0zTkTwzBUM5tW0ajG7R9TG
         nD+Q==
X-Gm-Message-State: AOJu0YytJIyDDhYnCPxGX7CPIXd7nXP4NuW0MYZQ81a2eEWZ5wM0kHOZ
	Q1r3mLEvaZcKsxoI0KF/TLmiOBTQa25FylE2GVU6xw7hnNmqw2Wq7ad+ACov9rRI70d1aOIhodb
	TupUWhvqJW2Bb7f5MfItheUuds0AJ9/jKxz4=
X-Google-Smtp-Source: AGHT+IG41zluIi73QSMFYVJyB0+zDSSsT81LI5YVas0NPIy7Gsio/2iz79D1CtkxSFhobs8WebDyIEN3cPPRLtCh95E=
X-Received: by 2002:a17:907:a08a:b0:a7a:a763:842e with SMTP id
 a640c23a62f3a-a807903db50mr199078266b.13.1723041805173; Wed, 07 Aug 2024
 07:43:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806142020.4615-1-chandrapratap3519@gmail.com>
 <20240806142020.4615-5-chandrapratap3519@gmail.com> <ZrME3EXwf2qDfTew@tanuki>
In-Reply-To: <ZrME3EXwf2qDfTew@tanuki>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Wed, 7 Aug 2024 20:12:58 +0530
Message-ID: <CA+J6zkTSBsrTZf2xyec-RaiqP3vJqvJmhVuW8GusbV-ia8CQ=A@mail.gmail.com>
Subject: Re: [PATCH 4/6] t-reftable-stack: use reftable_ref_record_equal() to
 compare ref records
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Aug 2024 at 14:11, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Tue, Aug 06, 2024 at 07:43:40PM +0530, Chandra Pratap wrote:
> > diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
> > index 14909b127e..0c15e654e8 100644
> > --- a/t/unit-tests/t-reftable-stack.c
> > +++ b/t/unit-tests/t-reftable-stack.c
> > @@ -145,7 +145,7 @@ static void t_reftable_stack_add_one(void)
> >
> >       err = reftable_stack_read_ref(st, ref.refname, &dest);
> >       check(!err);
> > -     check_str("master", dest.value.symref);
> > +     check(reftable_ref_record_equal(&ref, &dest, GIT_SHA1_RAWSZ));
> >       check_int(st->readers_len, >, 0);
>
> I think the change itself is sensible as long as we have tests that
> verify that `reftable_ref_record_equal()` itself behaves as expected. I
> don't think we have such tests anywhere though, uncovering a test gap.

We _do_ test reftable_record_equal (which is a wrapper for
reftable_ref_record_equal in the case of ref records) in the
recently ported t-reftable-record test. Here is the test exercising
this function in unit-tests/t-reftable-record.c:

static void t_reftable_ref_record_comparison(void)
{
  struct reftable_record in[3] = {
    {
      .type = BLOCK_TYPE_REF,
      .u.ref.refname = (char *) "refs/heads/master",
      .u.ref.value_type = REFTABLE_REF_VAL1,
    },
    {
      .type = BLOCK_TYPE_REF,
      .u.ref.refname = (char *) "refs/heads/master",
      .u.ref.value_type = REFTABLE_REF_DELETION,
    },
    {
      .type = BLOCK_TYPE_REF,
      .u.ref.refname = (char *) "HEAD",
      .u.ref.value_type = REFTABLE_REF_SYMREF,
      .u.ref.value.symref = (char *) "refs/heads/master",
    },
  };

  check(!reftable_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
  check(!reftable_record_cmp(&in[0], &in[1]));

  check(!reftable_record_equal(&in[1], &in[2], GIT_SHA1_RAWSZ));
  check_int(reftable_record_cmp(&in[1], &in[2]), >, 0);

  in[1].u.ref.value_type = in[0].u.ref.value_type;
  check(reftable_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
  check(!reftable_record_cmp(&in[0], &in[1]));
}

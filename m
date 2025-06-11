Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D61D299
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 13:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749649626; cv=none; b=X4KX+CY9BxyeYF+7896Wyol9pmYBYsG+DevZ3WT5TiWGMcO17wtRBAc1s9eDbUSxq7mNBPXErY+rk7oRe5Vdl6r68S1n5TSNquWyrBTQfHWzDW/Rne23y29L5N/2NF3GO8iZ3yKSXhmggptkSyK4afhMfeuh9RSG4P7CvMMDIDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749649626; c=relaxed/simple;
	bh=DnjiqOFHMl9Oxr+q95TUAAl71Ml6T/BdjhPkOBRMFQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tqi9FfTrfShXkrtZFYd5GZPPOu5gWYa2uMeNTIUHkd66mAJAJSuxRJVBTvX13pv8cusO0xcjm0crD/9jMjQgIMq9zGAnSsArfyt42JuDW8ndp24YF7fCwOhb6lXcoKjDeWspTdZQeLk9Bl2tfaf3lccwdzgM5VYQ/Nk/ImgyxiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGiN3f9Y; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGiN3f9Y"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ade5a0442dfso588161766b.1
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 06:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749649623; x=1750254423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsHrLbPRlyplKg/GmX/8Mktjnspu/p6+hibMvG99eJ8=;
        b=nGiN3f9YbfCZVuyG711tF0A5T90Ol26PRppztYUIf95vRZQjgKoIZrnwY5Rr853Wz9
         8qbISpNwPjMHm1YBxi/mnVxDyHkaeKNkbOrJ4TNeLKi1nkdoC/57CW1FFJMGC6jApfnu
         bwkwzKpXOQorihiFe+mlj3NlMHgkofCeizy/PkUVffdJcYXOqO37NskRWgbqb2DbUY6q
         gRbN29NJSpzyOfO3LXuMi1hQAtVCjFVNmRG31fFwkymSoxwj08fVPLgjwtMSL6mId2cj
         tE+5nNvi+StPbHLF5aZLo5Mq0FNZ5NFv+YtIs/fBiQ4VZ3xTW64fPawV3Ezh2nFeFfQF
         ylqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749649623; x=1750254423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MsHrLbPRlyplKg/GmX/8Mktjnspu/p6+hibMvG99eJ8=;
        b=JqpanNeRvrzloigQN4ID3GSOeRgr7FRlqsNU2383cm/WL5FJbDlKhH0XIkER5EkXRd
         glTkgyc/LvO4pH2CXjgeu2dcUB9exJBvxs+e7APrUSdqoNUx+wI4qgmNRaCxgLKQHL+Q
         ljmeueaK3SBDdEyRMdtuUM9rUTCymCjcEm+PPWpV2juEFjaZbzQAPvIyettDONYD+hln
         CLBkqeAqQJObHIZjn+kRvWwNhx/75CUzzY7gSmn6VVz6TpDcc0gmbxgRP5v8msctmCSM
         HZEMd8Aw38UoLi1tV0LlWqkk8GhK4dGxd9kmzCTVALSBS+7DY5i7bpYJIUwe3KP6uW+b
         SdLw==
X-Gm-Message-State: AOJu0YzEqT21TEQm5YYsuJPK9vDGbx8F5nXgZ4DZGmMdSCuP/S/K74uL
	6SYD1On7DhLc/CgSObLJsBbHG/vLIBeUgEgWphopQYtFSd4ik1UxbyrNKtg6OYA4ZXKElBdKCEW
	2jfapoL/dNRAdHIfRBqibvnhddV+lA9E=
X-Gm-Gg: ASbGncv9Y/03hBC/Uv2a/+oVF3qlptofaQLljwoWmiLVGpLcXWaacB1CzlrvD9kFO5I
	GmE+/KqKTPlWhKdU+B+LFRTRII9bhsrYJNXP245807Ddhbw//W5QgLGbf+eQoMU6BRV5jXzDmdd
	2K6LUzM9pLX8PJpfBjpxf24w8ihmxWkdt/ANHttldiGZXzug==
X-Google-Smtp-Source: AGHT+IHpbkmyJ1BL/iMqc+wxcaGwSVQBoGoGLPyk2SKNBZOG5Wh4oAlGsMKIVva3Z0Uv8YwhsZJqHYcROPeH1c1lOj4=
X-Received: by 2002:a17:907:7253:b0:ad8:9b5d:2c1e with SMTP id
 a640c23a62f3a-ade8971abe6mr350653166b.29.1749649622952; Wed, 11 Jun 2025
 06:47:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429145243.992252-1-christian.couder@gmail.com>
 <20250519141259.3061550-1-christian.couder@gmail.com> <20250519141259.3061550-3-christian.couder@gmail.com>
 <agvpcmvdxxpfwr34mw34dvatqr3rlc72zntgbrhlzynvn4h5rh@5mdgt4mdocnx>
In-Reply-To: <agvpcmvdxxpfwr34mw34dvatqr3rlc72zntgbrhlzynvn4h5rh@5mdgt4mdocnx>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 11 Jun 2025 15:46:50 +0200
X-Gm-Features: AX0GCFtso2mwS9wRNBBvB5Ycfsv-lkI7R7GHRLR-VZBCK51Up0zgnZjsJjJD2O0
Message-ID: <CAP8UFD0xQzHptsQJ9cOUNSri1kQkyJk5dUQgtDtF6NPDTvB0Mg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] promisor-remote: allow a server to advertise more fields
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Taylor Blau <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 10:36=E2=80=AFPM Justin Tobler <jltobler@gmail.com>=
 wrote:
>
> On 25/05/19 04:12PM, Christian Couder wrote:

> > +static int is_valid_field(struct string_list_item *item, void *cb_data=
)
> > +{
> > +     const char *field =3D item->string;
> > +     const char *config_key =3D (const char *)cb_data;
> > +
> > +     if (!is_known_field(field)) {
> > +             warning(_("unsupported field '%s' in '%s' config"), field=
, config_key);
> > +             return 0;
> > +     }
> > +     return 1;
> > +}
>
> Ok, so if the server has an unknown sendField value configured, the
> value is ignored by the server and a warning printed.

Yes.

> > +static char *fields_from_config(struct string_list *fields_list, const=
 char *config_key)
> > +{
> > +     char *fields =3D NULL;
> > +
> > +     if (!git_config_get_string(config_key, &fields) && *fields) {
>
> We could use `repo_config_get_string()` here instead and wire the nearby
> `struct repository`, but as the rest of the file is not doing so it's
> not really a big deal.

Yeah, removing use of the_repository in this file is left for another
future patch series.

> > +             string_list_split_in_place(fields_list, fields, ", ", -1)=
;
> > +             filter_string_list(fields_list, 0, is_valid_field, (void =
*)config_key);
> > +     }
> > +
> > +     return fields;
> > +}
> > +
> > +static struct string_list *fields_sent(void)
> > +{
> > +     static struct string_list fields_list =3D STRING_LIST_INIT_NODUP;
> > +     static int initialized =3D 0;
> > +
> > +     if (!initialized) {
> > +             fields_list.cmp =3D strcasecmp;
> > +             fields_from_config(&fields_list, "promisor.sendFields");
> > +             initialized =3D 1;
> > +     }
> > +
> > +     return &fields_list;
> > +}
>
> Are there scenarios where `fields_sent()` is getting invoked more than
> once? My understanding is that this is invoked only when the capability
> is being advertised. Regardless, I wonder if we really need the static
> initialization here.

I am not sure if `fields_sent()` could be invoked more than once (by
the same process), but I think it's very risky to rely on it being
called just once, and I think it doesn't cost much to be safe.

> > diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-r=
emote-capability.sh
> > index cb061b1f35..27c32b2573 100755
> > --- a/t/t5710-promisor-remote-capability.sh
> > +++ b/t/t5710-promisor-remote-capability.sh
> > @@ -295,6 +295,38 @@ test_expect_success "clone with 'KnownUrl' and emp=
ty url, so not advertised" '
> >       check_missing_objects server 1 "$oid"
> >  '
> >
> > +test_expect_success "clone with promisor.sendFields" '
> > +     git -C server config promisor.advertise true &&
> > +     test_when_finished "rm -rf client" &&
> > +
> > +     git -C server remote add otherLop "https://invalid.invalid"  &&
> > +     git -C server config remote.otherLop.token "fooBar" &&
> > +     git -C server config remote.otherLop.stuff "baz" &&
> > +     git -C server config remote.otherLop.partialCloneFilter "blob:lim=
it=3D10k" &&
> > +     test_when_finished "git -C server remote remove otherLop" &&
> > +     git -C server config promisor.sendFields "partialCloneFilter, tok=
en" &&
>
> This configuration results in the unsupported field warning message
> being printed. This is because of the SP following the comma resulting
> in an empty value in the middle after the string split.

Yeah, right, in the v4 I have added a call to
string_list_remove_empty_items() to avoid spurious empty values and
related warnings.

> > +     test_when_finished "git -C server config unset promisor.sendField=
s" &&
>
> I think we could use `test_config` which would automatically unset the
> configuration after the test.

Yeah, `test_config` is used in v4 to avoid this test_when_finished.

Thanks for your review!

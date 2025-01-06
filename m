Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387D31E87B
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 22:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736204282; cv=none; b=Qd2Q9TpfOcG2GVogq/vefrmH1xoA8uM/LEmsIY6vBSZPs8lF7dRGvcdVvOAGqqeJVAwWiLRLuFj/2+9EoU2eDUzKBmiMWbVezsTrTrKgkldqr8xnCXtYgQgcX1Zmp+vsuV6bNb9M8zuPt2rOCmVBwr0FubFB4HcNU4EzvlpcuyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736204282; c=relaxed/simple;
	bh=X7tjpr79/hRLjKNIrIPAWphrZ0GiancIh0tli0ESL8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=LsXlfifBAmcBx/wNuek2Fq2JDGGZvktNf7aqKIyskWk0hj/KIxMOmtFUljZrFHFSqKke8Bxa+0Kc6NwOKHn0dO+h/QIT5Kt8Ny2jdjG5BjcX6diFTma4Gyubkx1C7CJZwtR5OZfScMvsXK5vEzAhYVMylONW818O30z7y3o9qDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFc/loOq; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFc/loOq"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaf34ec42a5so88327566b.3
        for <git@vger.kernel.org>; Mon, 06 Jan 2025 14:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736204278; x=1736809078; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ux11Di+0MrO0HZRTQIRdedrnI5u6gAa3y/5inHNMCd0=;
        b=KFc/loOqR6179z3YkVcL/mK3iGi6fyv1I8S68qPhUtKdD/yduN2LxPEzhQKU+nFK5s
         dtHbHQlef3yL2/ORkd1RsVfshBstnkzt8C5WHGTmIOQXezWf6qWHfQhtb0zeFJnZFE+n
         SxOdHWGS2T65zOUgbD7p1ZWrB4c0Iz59o2aHHXeZC92H0Zrn81tlSVzklIwSM/LH/8KK
         +stegw+B26aJJLGdaW0DYjTy1BeHXRwGZ5J2Mz0K7ECgvircvvrtU0R1e/PaHgZ3Eea7
         3nrEtGkGnvENIj7SDvXv0qsG9LzXiKVlFu1MV/FJpeiwimM8kAO95DBNuxZIs0LXBVZm
         qXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736204278; x=1736809078;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ux11Di+0MrO0HZRTQIRdedrnI5u6gAa3y/5inHNMCd0=;
        b=ONJAuTveboCFZUc1p7pXSUGmed4tjJHHV+AHynNEIHT62wpQkxbTNihgoyWqHQhqtl
         6uuKLRNB7QVcYAMP3z+FHxW02nJ+/yB/xgMXUnfyDlSP4d4flr684kb8CxwYbXHUJHLP
         y789H3MTGfXArZEP8+BzVGg8TU3FzMwd/FY5rpmkh/LlVP/+1SJjalzjYAkFRVQhNrUy
         l/i0Gmdv6VRONkqW9f3THLyV3MB7TMsJeQ6ITLsgThkcGiVAWYPyabENCnrVvb+0iOQa
         D7TjpovWwqzuXQVi166BDVa5CEw6qy7gglQ7CLlEJpntJqbmVdS+JYM0x0Lt63crKHVB
         Ex4A==
X-Forwarded-Encrypted: i=1; AJvYcCU0XJ17x1yTmFJoZfmQ1IttRt8YamYs7CmRyDHFmapqdQUNNaiEphzuzgDsq/zDlnd6igM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLf0Ce4gz8AR9ogv0cg7Rv0f1eoHZ+XagHsiK/Ov69iXGLyTCM
	E1BYUDh2RFUvkAkVciBpnzb882no9ZDVNdZ4zLg8B0h8PAW8Q1qj9MtoS7kTfii23kE0mn/pVcC
	oLgss5MK+g8QOT1tD6XET1vxYuVE=
X-Gm-Gg: ASbGnctY8ZOzXDMQq+7TDy6eqBx5wzMEtP4not6Of7EzEH1ZoVKFZQ6GF6Fcc2/mwsd
	wfoCCLdpjw6K5pguM5IhCQBmkOOl4W32BG8U6
X-Google-Smtp-Source: AGHT+IHCl7n2ZSkUSgewLLyAaaM5rSyTJLG5hqFrDiUjqHPR2D3mHRjNXpNP1jPpy0kr9oRyNDkoVsxavrtYZgP0iiM=
X-Received: by 2002:a17:907:9447:b0:aa6:35b1:5c02 with SMTP id
 a640c23a62f3a-aac33514901mr1891334166b.9.1736204278250; Mon, 06 Jan 2025
 14:57:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1842.git.1734729534213.gitgitgadget@gmail.com>
 <pull.1842.v2.git.1736193131798.gitgitgadget@gmail.com> <Z3xaE_v45G447HQe@tapette.crustytoothpaste.net>
In-Reply-To: <Z3xaE_v45G447HQe@tapette.crustytoothpaste.net>
From: M Hickford <mirth.hickford@gmail.com>
Date: Mon, 6 Jan 2025 22:57:06 +0000
X-Gm-Features: AbW1kvYMvjYXImWdRx5jj_SajfRmfRxpfsAIlY_vCkIFRQocMwQvB61ygHg3GbM
Message-ID: <CAGJzqsn6kV4LeYKk=qWu3GvbtNrJ5LG9LvbDVMQoHqibR9ieSA@mail.gmail.com>
Subject: Re: [PATCH v2] credential-cache: respect request capabilities
To: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	M Hickford via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Jan 2025 at 22:32, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2025-01-06 at 19:52:11, M Hickford via GitGitGadget wrote:
> > From: M Hickford <mirth.hickford@gmail.com>
> >
> > Previously, credential-cache responded with capability[]=authtype
> > regardless of request.
>
> That's the correct behaviour.
>
> > The capabilities in a credential helper response should be a subset of
> > the capabilities in the request.
>
> No, it should not.  Otherwise, it's impossible for Git to know whether
> the helper does or does not support the capability.  We rely on that
> information to correctly pass data back when saving data.
>
> > diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
> > index bc22f5c6d24..692216cf83c 100644
> > --- a/builtin/credential-cache--daemon.c
> > +++ b/builtin/credential-cache--daemon.c
> > @@ -134,17 +134,16 @@ static void serve_one_client(FILE *in, FILE *out)
> >       else if (!strcmp(action.buf, "get")) {
> >               struct credential_cache_entry *e = lookup_credential(&c);
> >               if (e) {
> > -                     e->item.capa_authtype.request_initial = 1;
> > -                     e->item.capa_authtype.request_helper = 1;
> > -
> > -                     fprintf(out, "capability[]=authtype\n");
> > +                     if (credential_has_capability(&c.capa_authtype, CREDENTIAL_OP_RESPONSE)) {
> > +                             fprintf(out, "capability[]=authtype\n");
> > +                     }
>
> This part is not correct.

Thanks for the review. I'll revert this part and amend the commit message.

>
> >                       if (e->item.username)
> >                               fprintf(out, "username=%s\n", e->item.username);
> >                       if (e->item.password)
> >                               fprintf(out, "password=%s\n", e->item.password);
> > -                     if (credential_has_capability(&c.capa_authtype, CREDENTIAL_OP_HELPER) && e->item.authtype)
> > +                     if (credential_has_capability(&c.capa_authtype, CREDENTIAL_OP_RESPONSE) && e->item.authtype)
> >                               fprintf(out, "authtype=%s\n", e->item.authtype);
> > -                     if (credential_has_capability(&c.capa_authtype, CREDENTIAL_OP_HELPER) && e->item.credential)
> > +                     if (credential_has_capability(&c.capa_authtype, CREDENTIAL_OP_RESPONSE) && e->item.credential)
>
> This part may very well be correct.
>
> >                               fprintf(out, "credential=%s\n", e->item.credential);
> >                       if (e->item.password_expiry_utc != TIME_MAX)
> >                               fprintf(out, "password_expiry_utc=%"PRItime"\n",
> > diff --git a/t/lib-credential.sh b/t/lib-credential.sh
> > index 58b9c740605..324ecc792d5 100644
> > --- a/t/lib-credential.sh
> > +++ b/t/lib-credential.sh
> > @@ -566,6 +566,21 @@ helper_test_authtype() {
> >               EOF
> >       '
> >
> > +     test_expect_success "helper ($HELPER) get authtype only if request has authtype capability" '
> > +             check fill $HELPER <<-\EOF
> > +             protocol=https
> > +             host=git.example.com
> > +             --
> > +             protocol=https
> > +             host=git.example.com
> > +             username=askpass-username
> > +             password=askpass-password
> > +             --
> > +             askpass: Username for '\''https://git.example.com'\'':
> > +             askpass: Password for '\''https://askpass-username@git.example.com'\'':
> > +             EOF
> > +     '
> > +
> >       test_expect_success "helper ($HELPER) stores authtype and credential with username" '
> >               check approve $HELPER <<-\EOF
> >               capability[]=authtype
> >
> > base-commit: 92999a42db1c5f43f330e4f2bca4026b5b81576f
> > --
> > gitgitgadget
>
> --
> brian m. carlson (they/them or he/him)
> Toronto, Ontario, CA

Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496F61FCFDB
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 11:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737978532; cv=none; b=m6GtD3r3GKS6DMwDtFgoHXryGgOl+gqtaX5Ie7yxNvG6dF4FITfTpjY7tXrCSIJtPryzDgQWYZVgFuUteJWPBZJGk68cbMQNQfZ8E4XA5t0e9QPWrM920ftkzLJVirV0X8sGmI1kVeGporMmU+0l6WwOzUD9hoFjk0JPkoQFjrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737978532; c=relaxed/simple;
	bh=pRLh4FR9dT2CtJAGj9OIbruJ22X4t/eP9l9iSMQhyn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XWVuZh0DQzrFAyULhz14HA9kE4i4OQxkKXEY0EVt9vGHeHs7xyUybk3zxCk4nbhE7vev4xcjt+Aoq9p1jQt/i26bvTly1VF4vfG8lEAeMQOXoo5EfEIU7b1bI7T+LyCmJJfT/pHeL4smL4DurNj58/PKwGfBczZEv3FNXcKV0Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jetbrains.com; spf=pass smtp.mailfrom=jetbrains.com; dkim=pass (1024-bit key) header.d=jetbrains.com header.i=@jetbrains.com header.b=EwgDIHPH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jetbrains.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetbrains.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jetbrains.com header.i=@jetbrains.com header.b="EwgDIHPH"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2166651f752so83781365ad.3
        for <git@vger.kernel.org>; Mon, 27 Jan 2025 03:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jetbrains.com; s=googleapps; t=1737978529; x=1738583329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsvWkH08wb0mtM9UF4sCIwmtYuNu4sADDZ8GtyhUT6Y=;
        b=EwgDIHPHS5jOp1CsQ9usYUtZdNS5nLtJeYnBQx9iiw2JSvE/mPo273Calj7z/cTHFi
         cRb45rlJe3Kzc2eo312h0MdzGJhF5AVHfurb1u8Xi4szGD1hUFTxTb/vDHmPYVsT7s9M
         x8meX1iWroyyrYhBC7VdXkA6ZiWU9l3Vklrvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737978529; x=1738583329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jsvWkH08wb0mtM9UF4sCIwmtYuNu4sADDZ8GtyhUT6Y=;
        b=Ob7pL1jP3P5ycNKH3wNXUQxw3OexP3Gt70yv0ZzL/6MhHClWn4qi66g7ujdPANsWCm
         2HAw5MKbzUePdqsHPiXZEwaYHhVE3D0nmNSQnEHllnRxpJF3Yp2z8O5scaQUBNt21tay
         x9UNMlbEnU5hLT8hSzLHXuCVgvbkf6zUiu4M1/JRryAgDWIks9YZzhhgERNiKWRBtANt
         92qyAo88In6+Ixaaqx8Tk/gAH76EULgSogDHkZTwjhyXzIhfgcDqkPjNGQKNMr35pmyt
         n7fQi+DHKnGMX75RCUR/HMQ4ebY32e3sPlyBQRc7qo1vwlpEfyzmJni3jXjPSCCIT5o9
         daHg==
X-Gm-Message-State: AOJu0YxfNC4V1XBGiOWT5K93cFdrSBeXAFkw7bpIvdCaXG1SE3/D6qwe
	wqOu9KbwBu6G7FEK9chuzg3GDHQQaJkV8R0ZMvZArm1Dcds3/RbOpVY0sQy5byjkW4uCXEUSo+5
	gn8BfOxhb4TpDd+QW2GOquxNneRmJLfUee/8LgF69GGEcinml
X-Gm-Gg: ASbGncsAG3G3Uo86Ymcz29tJVF25v+oblhKeTeZtwxK/rQvijVVjjwH3PYtfrQkub9A
	9jO+gVpnQohSgp0/XT0APCAW6fLmFTfQMod+r5c9yT0ZODsQJUzwSsgkNxSuCbg==
X-Google-Smtp-Source: AGHT+IHCHj/mWk3Wood4BCKKsnSMquoZjvSjdN3GtLKP0S24olJIeVweo0Bp5qlSuAQjCpfG8mI3lQUZyjNbpbhLRE8=
X-Received: by 2002:a05:6a00:21c3:b0:72a:bcc2:7748 with SMTP id
 d2e1a72fcca58-72daf8515f4mr58953363b3a.0.1737978529539; Mon, 27 Jan 2025
 03:48:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM6buW5KSDGHD7txroqVa0TN_Ou_eV-LocMy06cPy0ZGDQmY9A@mail.gmail.com>
 <D6ZXVILR1D36.3W0QVQCVE1P2J@ferdinandy.com> <CAM6buW6NbdZ6wLGP6LWePiA7n0At=jxxqtBEUv0fTY6mOdTmyw@mail.gmail.com>
 <D705W1554XJ9.30SRYLNGNOX4@ferdinandy.com> <CAM6buW77CeuKfr3b4SUbYyFaU1OTvRsYBjPBE05YMzJo36bGdw@mail.gmail.com>
 <D706LPHBPUL4.3LN27T1UG1FI2@ferdinandy.com> <CAM6buW4UiCs9pFeH0cxxdhLHCSNO9wLVz9_p4Y0u8LaGWy--ng@mail.gmail.com>
 <D712LKI48ZUD.2UK8FX0YZBEYM@ferdinandy.com> <CAM6buW4e4c_3BgPo_GU64Fvi7XGcP7tuxdaap1LypyFCOZvZEw@mail.gmail.com>
 <D7CEDCJ0KKYL.YS0EWVFCN72X@ferdinandy.com>
In-Reply-To: <D7CEDCJ0KKYL.YS0EWVFCN72X@ferdinandy.com>
From: Danila Manturov <danila.manturov@jetbrains.com>
Date: Mon, 27 Jan 2025 12:48:37 +0100
X-Gm-Features: AWEUYZlHZetwgRkFAgo8kUk8VxVEmTkgV011i5VUaMWTifgfBDFKPr-BVcXyBc8
Message-ID: <CAM6buW5TTwtcCvpbkPBJp2=DuQmQSpUjDh+9u8NY7e4+QJxdGA@mail.gmail.com>
Subject: Re: Git 2.48. Changed behavior of the git fetch
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello. Thank you for the investigation. The patch will help us because
the git command is generated by the code, and it is important to
ensure backward compatibility with previous versions of our product.
Thank you!

On Mon, Jan 27, 2025 at 12:35=E2=80=AFAM Bence Ferdinandy <bence@ferdinandy=
.com> wrote:
>
>
> On Tue Jan 21, 2025 at 18:26, Danila Manturov <danila.manturov@jetbrains.=
com> wrote:
> > Hello. I have done some experiments. For some reason, it works
> > correctly with JSch. With native ssh/https it doesn't work
> >
> > On Mon, Jan 13, 2025 at 5:03=E2=80=AFPM Bence Ferdinandy <bence@ferdina=
ndy.com> wrote:
> >>
> >>
> >> On Mon Jan 13, 2025 at 15:14, Danila Manturov <danila.manturov@jetbrai=
ns.com> wrote:
> >> > According to our CI, the first commit where the bug occurs is
> >> > 5f212684abb66c9604e745a2296af8c4bb99961c
> >>
> >> That makes sense, what is more interesting is why the fix Junio wrote =
later
> >> doesn't work in this case ... I didn't have time to dig yet.
> >>
> >>
>
> I looked up the original thread leading to 6c915c3f85 (fetch: do not ask =
for
> HEAD unnecessarily, 2024-12-06) by Junio, which fixed a similar issue (se=
e
> https://lore.kernel.org/git/444kgiknevb3kwtypjjc2glryaav27t5fafgyzqq5257w=
7o4pf@4fngcyfmvfcp/T/#u).
>
> Originally Josh there suggested just changing the order of adding tags la=
ter to
> the prefixes should solve the issue. I don't think we ever actually figur=
ed out
> why the order of the prefixes should matter, and Junio's patch solved tha=
t
> particular problem by just not asking for HEAD in that case, but it seems=
 that
> the current problem can also be solved by swapping the order of tags and =
HEAD.
>
> This seems like a band-aid again, and I still don't get why the order mat=
ters,
> but I can turn this into a patch if needed:
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index fe2b26c74a..7147f06395 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1768,6 +1768,11 @@ static int do_fetch(struct transport *transport,
>                 }
>         }
>
> +       if (uses_remote_tracking(transport, rs)) {
> +               must_list_refs =3D 1;
> +               strvec_push(&transport_ls_refs_options.ref_prefixes, "HEA=
D");
> +       }
> +
>         if (tags =3D=3D TAGS_SET || tags =3D=3D TAGS_DEFAULT) {
>                 must_list_refs =3D 1;
>                 if (transport_ls_refs_options.ref_prefixes.nr)
> @@ -1775,10 +1780,6 @@ static int do_fetch(struct transport *transport,
>                                     "refs/tags/");
>         }
>
> -       if (uses_remote_tracking(transport, rs)) {
> -               must_list_refs =3D 1;
> -               strvec_push(&transport_ls_refs_options.ref_prefixes, "HEA=
D");
> -       }
>
>         if (must_list_refs) {
>                 trace2_region_enter("fetch", "remote_refs", the_repositor=
y);
>
>
>
>

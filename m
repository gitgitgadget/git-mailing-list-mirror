Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD3A16BE17
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862415; cv=none; b=VP7SUI2r2DVEvyCmmi2GTM9zMaYu69ntV1HKO1gb1JVEvZY4kg7SSn0Fj00BCGUAne9d1pyZyCfcqcPs0Dc3SKLd81FXGRnHY/45LPEmc7j1u56pR/UMQfXyvXlpwQBxXWClkZIpMQsF9fpnmC1UHDe+9Ch6/xpsFneT3BpCeWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862415; c=relaxed/simple;
	bh=8CvkrDB0XUHX+QRGebeI7TuZGQrDIXxzpepFWgS24BU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jGZg7hJw8Dwpn90y3fzvo486iro0jKjXquM4QQOIci9JIA+TP8mcvowoxCNDfluVIXB0Li3Ei0qPXrPUSDpZn22HpYaCRHs/15xL1C8+c73XBEoOw4pQWxLQLGkPfdX4wL4u9JdtuzqSPEl4hxftDEP0319rFatm2wap1iSvfLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zcd5bpH0; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zcd5bpH0"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e673822f76so1278005a12.2
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 03:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741862411; x=1742467211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMrt/z6cZpnQoL4j7Yqq6lBv+cPzMPjU/8dZCaySJ/w=;
        b=Zcd5bpH0gWzOvxvSyvx8AiMi43wkgfuWvoZGpDhFd0piQR299+4rINaVuNSd1j1NxX
         c9kbFDmG/VOvQjcgN5Q20j+yrs+fBjGvtBRju/R8X8jhgsE8X3XVKVqAHW1biFQUIHHY
         NufLymDPWj0/S8dQKpcSYj1ZX7MTRDcdtP/ExKYTM89Qe5XkVCnuhJ379jS6uAWPYpHX
         ZxgtXYWFGQDevQWUZlQzzFM+bu2qEdel4zpduCr6fU1SU+Y0oDw7qs1J7a/KeOHlyQK2
         HMLK3ezOq/IQfr9geGWtw7mMEvIT2CE7YjRDAcnTvpepJOEvg3NWozauhU3RKlvGl/b2
         RZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741862411; x=1742467211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMrt/z6cZpnQoL4j7Yqq6lBv+cPzMPjU/8dZCaySJ/w=;
        b=MrhADFvEVgmKOqhz90WpVDAy7oCFJo1tUzufrQxoTVMon9ovpDwQcgkIX+anmpDWHr
         ygdlqP2hKt7qYkuuuHxPctjP1Vqew3GBGH2lEjCJ07ofQQj1gmq/DZzomw0j7iz9muIG
         xR8fm4mVvf6SPQ+KkunC2+VatXUbCfb/7/y8syD6S/OdJwgzc7OXFS0JAmlPKwJAkwJ1
         t4I/BR0vUbUjl5qy4SeKZovphreiGS6OwgiNylhokqCtur1OKtISUfPmWyOLGY3S8jHQ
         i5YDRiH5nAKnEyqO7S8Nh3h4mvxx5AzUHxCHlm6lHD70JDcHMCYITazJRvu3fj5n+mNP
         rGWQ==
X-Gm-Message-State: AOJu0Yx0Px1r6srvjt1ZCn5FjqMcdFo4lI2nwm6mLwTpzgvP0wUeAyDK
	OzH7n8kc2juNrzB2xqTwlvugZDxidYbNnl+vPFW+ayiGwvjoRCGVA46fmk340XB25qAAZonPiRZ
	jXiXieU5Qo/ywvE99GBZOoBLxxsA=
X-Gm-Gg: ASbGncsk2azotezXP4Ywe1k2NuZTKdtV51xvGwsjW2Q7cLflKvnnr9COCyaGUhsAvgm
	RyM0mAZ3+MCIno7nZxuuB5pLcvJutKkMYFPHy4Yunhzzclk98vtnhR+w285c+7e1q3gqUNAhm6b
	wO2UtLXKf1BAyFQuaJcswo98lE7Mp783Tv0HkYrhE=
X-Google-Smtp-Source: AGHT+IE7If1YK+lgZSbYHeRMRyeKIRN0zMHiq7NQdvcgxToPvw9++ZZIRbWZVaVSErevF+qi4BRo06w1Uv/dR3XUaWw=
X-Received: by 2002:a05:6402:2157:b0:5e5:e78a:c501 with SMTP id
 4fb4d7f45d1cf-5e5e78ac8f9mr25521991a12.13.1741862411212; Thu, 13 Mar 2025
 03:40:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311152413.1059343-1-christian.couder@gmail.com>
 <20250312114628.2744747-1-christian.couder@gmail.com> <xmqqecz2yyg2.fsf@gitster.g>
In-Reply-To: <xmqqecz2yyg2.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 13 Mar 2025 11:39:58 +0100
X-Gm-Features: AQ5f1Jor6E1yhsQCqMEJCeMmpe7JKMSvNnyc-b_loXQ63A9KGGEMLtFSxueHL5Y
Message-ID: <CAP8UFD0QqUG5Gu-XxKi58sEA7VfSJk4gy9hb_93dCw+2QMABYA@mail.gmail.com>
Subject: Re: [PATCH v3] promisor-remote: fix segfault when remote URL is missing
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>, 
	Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Karthik Nayak <karthik.188@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, 
	"Randall S . Becker" <rsbecker@nexbridge.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 6:02=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> >       for (r =3D repo->promisor_remote_config->promisors; r; r =3D r->n=
ext) {
> > +             const char *url;
> >               char *url_key =3D xstrfmt("remote.%s.url", r->name);
> >
> >               strvec_push(names, r->name);
> >
> > +             /*
> > +              * No URL defaults to the name of the remote, like
> > +              * elsewhere in Git (e.g. `git fetch` or `git remote
> > +              * get-url`). It's still possible that an empty URL is
> > +              * configured.
> > +              */
>
> Not a huge deal as it is not telling any lies, but does the second
> sentence need to be said?  An element in the urls strvec being an
> empty string is not all that more interesting than it being an
> incorrect or malformed URL to those who are reading this piece of
> code, is it?  It is also possible that an unreachable URL or
> misspelt URL is configured, but it is not a job of this piece of
> code to worry about them, just like it is none of the business of
> this code if the configured URL is an empty string, no?

Yeah, right, I have removed the second sentence in the next version.

> > +             strvec_push(urls, git_config_get_string_tmp(url_key, &url=
) ? r->name : url);
>
> More on this below.  Unlike "git fetch" and "git push" used as the
> source and destination, the remote URL used in this context are
> exposed to the outside world, and I am not sure the usual r->name
> fallback makes sense.
>
> >               free(url_key);
> >       }
> >  }
> > @@ -356,7 +362,7 @@ char *promisor_remote_info(struct repository *repo)
> >                       strbuf_addch(&sb, ';');
> >               strbuf_addstr(&sb, "name=3D");
> >               strbuf_addstr_urlencode(&sb, names.v[i], allow_unsanitize=
d);
> > -             if (urls.v[i]) {
> > +             if (*urls.v[i]) {
> >                       strbuf_addstr(&sb, ",url=3D");
> >                       strbuf_addstr_urlencode(&sb, urls.v[i], allow_uns=
anitized);
>
> We used to advertise an empty string name to the other end, but we
> no longer do, which is a good hygiene to be strict on what we send
> out.
>
> But now our updated promisor_info_vecs() pushes our local name
> r->name as a fallback. The idea of r->name fallback is to use it as
> a local directory path for "git fetch" and friends, but the local
> pathname has no meaning to the other side, does it?  Is it something
> we want to let the other side even know???

It could happen that the server, the client and the common promisor
remote are all on the same filesystem. Then it would make sense for
both the server and the client to rely on just the remote name,
without any URL configured, to access the promisor remote. So if we
want things to work in this case, then I think the server should
advertise the remote name in the "url=3D" field.

Also it's not like the server is giving away secret information as it
already passes the remote name anyway in the "name=3D" field.

And yeah, the client could be configured with "KnownName" instead of
"KnownURL" in this case, but that wouldn't work if there are other
promisor remotes that the client and the server want to share and that
are not local and therefore need a URL configured on both sides.

> What other uses do the name/url vectors prepared by
> promisor_info_vecs() have?  Is it that we use them only to advertise
> with this code, and then match with what they advertise?

Yes, I think so.

> If we are
> not using these names and urls locally to fetch from in code paths,
> I am inclined to suggest that promisor_info_vecs() should not shove
> these fallback URLs (local directory name implicitly inferred) into
> the names/urls vectors.

We could do that but I think it would make it more difficult to make
things work in the case I discussed above (where the client and the
common promisor remote are all on the same filesystem, and both the
server and the client rely on just the remote name to access the
promisor remote).

> On the other hand, if other callsites that use the names/urls
> obtained from that function do want to see such local pathnames, we
> cannot lose information at the source, so we'd somehow need to
> filter them at various places, I guess.  And this place that builds
> up the string to be sent as capability response should be one of
> these places that must filter.

Other call sites don't use promisor_info_vecs(). It was introduced by
the lop patch series which doesn't change how other code gets the
remote names and URLs.

> > @@ -409,12 +415,42 @@ static int should_accept_remote(enum accept_promi=
sor accept,
> >       if (accept !=3D ACCEPT_KNOWN_URL)
> >               BUG("Unhandled 'enum accept_promisor' value '%d'", accept=
);
> >
> > +     if (!remote_url) {
> > +             warning(_("no URL advertised for remote '%s'"), remote_na=
me);
> > +             return 0;
> > +     }
>
> Except for the above "no URL advertised" warning and returning,
> which is absolutely a good thing to do, I am still not sure how
> relevant various checks for an empty string new code added by this
> patch makes are ...
>
> > +     if (!*remote_url) {
> > +             /*
> > +              * This shouldn't happen with a Git server, but not
> > +              * sure how other servers will be implemented in the
> > +              * future.
> > +              */
> > +             warning(_("empty URL advertised for remote '%s'"), remote=
_name);
> > +             return 0;
> > +     }
> > +
> > +     if (!*urls->v[i]) {
> > +             warning(_("empty URL configured for remote '%s'"), remote=
_name);
> > +             return 0;
> > +     }
> > +
>
> ... would it be so different to pass an empty string as to pass a
> misspelt URL received from the other end?  Wouldn't the end result
> the same (i.e., we thought we had a URL usable as a promisor remote,
> but it turns out that we cannot reach it)?

Perhaps but I think it would be weird if URLs are matching when they
are empty on both sides. I think it makes more sense and is more
helpful to warn with a clear error message and just reject the remote
if any of the URL is empty.

> >       if (!strcmp(urls->v[i], remote_url))
> >               return 1;
>
> Past this point, I am not sure what the points of these checks and
> warnings are; even with these "problematic" remote_name and remote_url
> combinations these warnings attempt to warn against are used, as long
> as the above check said it is OK, we'd silently said "should accept"
> already to the caller.

Past this point we are in the case where remote names matched but
remote URLs didn't match. So I think we should help diagnose things
(with warnings) because it's likely that the intent was for the URL to
also match but a mistake prevented that from happening.

> > -     warning(_("known remote named '%s' but with url '%s' instead of '=
%s'"),
> > +     warning(_("known remote named '%s' but with URL '%s' instead of '=
%s'"),
> >               remote_name, urls->v[i], remote_url);
> >
> > +     if (!strcmp(remote_name, urls->v[i]))
>
> The 'i' was obtained by calling remote_nick_find(), which uses
> strcasecmp() to find named remote (which I doubt it is a sensible
> design by the way).  This code should be consistent with whatever
> comparison used there.

I think comparing remote names case insensitively is fair. It's likely
to just make things a bit easier for users.

In the next version, I have changed the comparison to strcasecmp()
here as I agree it could help if the comparisons are consistent.

> > +             warning(_("remote name and URL are the same '%s', "
> > +                       "maybe the URL is not configured locally"),
> > +                     remote_name);
> > +
> > +     if (!strcmp(remote_name, remote_url))
>
> This is matching what r->name fallback did so it is correct to be
> strcmp().  But (1) it may be way too late after the above "return
> 1", and (2) if we are *not* going to use it, perhaps we shouldn't
> place it in the resulting strvec from promisor_info_vecs() in the
> first place?

We are in the case the URLs didn't match. So yeah we are not going to
use the remote info because we are going to reject the remote (with
`return 0;`) a few lines below. But it would be nice if we can help
users diagnose what happened.

If we notice that remote_name and remote_url are the same it might be
because the URL is not configured on the server side, so the server
passed the remote name instead. It can be nice to tell users that this
might have happened to help them debug.

> > +             warning(_("remote name and URL are the same '%s', "
> > +                       "maybe the URL is not configured on the remote =
side"),
> > +                     remote_name);
> > +
> >       return 0;
> >  }

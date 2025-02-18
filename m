Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2947234973
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 11:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739878958; cv=none; b=C0U9rDTsNYWyOKw/m2qhfe0oduzGxQkyzIzwKinHs1o5qn+/cCs2slAsoH7GBNAmQU3vEsfGpCFMwszlEZAqt+KoF9UNm9mI6QQTjNB0mZgqp4eiOEaAj/9CaJOeZ87nDNPifTJEIsf/7safHBkgEeyZgSAqXmImU4hYzJoNWQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739878958; c=relaxed/simple;
	bh=cbR2+8q3/Af7lL2N9/6y+YH1kzxoKTVmo3u9ENa0WZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MaolmEyC2nvvKIywrVs6prwHvNPwjtNA7ruBvTs7HPrP0jOEL21WzMZmRvdU2Id+8+T6u6L6gzcFtXq55BvypzgSDyvHwUghFMZMpLlhYs6hxzmBFZkoAq7tvlxFvcoMVJcVzvW8cEndmKWg1j+OtNs6VfxlCoZcCRHFRYnriNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5mHFaaU; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5mHFaaU"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5dee07e51aaso8040665a12.3
        for <git@vger.kernel.org>; Tue, 18 Feb 2025 03:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739878954; x=1740483754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3iKcrzd8pokem0svvyUat95DEAEF+Rg20Vr/YYAKzI=;
        b=N5mHFaaUW7n03+yUOwAzloKd5sUGPQO7vtpufZHloxxxwEytT7tp9XSZO3/AeltM/C
         xb9QpuKaYyZvsTlbXJtrDzpq399amnJx76uA/S3WjPo6ctH4kpdEyXwAep7Qa65eiAMf
         29rDoSSlQMJ6wAk32T2DpSfbvHA/jTTw281SNCExjTPofKFDdMNqdRWfDnMMUAxax1Pd
         LFBI3LhTMW0QgQ1aNDkSOays5OlaFBV/5QQ1al2Yaa/43bofnjoJcpLy9ANq9dv3g1iD
         Tr0ew4sp55/EXgGotsbNFxtyC+fRPt3LdlPe2eU4xlIO8o8j4Hp51SEFeqWoBU2bVbOZ
         o3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739878954; x=1740483754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3iKcrzd8pokem0svvyUat95DEAEF+Rg20Vr/YYAKzI=;
        b=I8h2S18F2QE+HDoFBDVcZljsP7WbN1WEw2bpP5zP9BMHmXLmswwF+rttHRhwiWD1LV
         nP9BDec0bB/2NiO4Pem+9Ix7I7fm3R6LOhfTR+r79A86gYq86TJ7rpe3naYkAi33EbAs
         YjjBNmYlXZ+802xCylQ+FbUP/DRk6Q/ArnswLL7X7YlYdjqw8VJoNN+rGU1ruO9dBuqa
         68V/i7r7lvsgiW+44OtXLkSC2/AZDs5ELu17lao3/eoqIaj1h1LCf0zXjbZ0R/ZvB4oW
         cxa8xy2mmjoks7pub7IgCRNnaXrg9SVHdnLr1QKb1Fk7NrK/QBLzDPxD6keR9wmc7NT8
         mR2Q==
X-Gm-Message-State: AOJu0YyQn9QJjvN+DnE8M6Xy/7bg9E3Ea/7f9LlJdce1/9gPmZF16LP1
	JkE1RI0AZ0PNJdnP4Y/USiAdS+8q8Cj/t8pXwDBzE448i90mz2Tv47MVvIPLFOv9PnvGt9VfqmY
	3zOBhxwjHlXKT6CnVG4Sk3B3h558=
X-Gm-Gg: ASbGncs06wJ7EKOWZQwfVwAXE2r+a6GJAOju7iEl7rGkG9mBkNvVlMsBTt2ni4T5kke
	cB8aIw1SGlhbRgB94/HTtPEz01ULCnV4WABRKcaf23pM4C3/9+yUEp/gXqmjza/1QDpyvNdBppZ
	k=
X-Google-Smtp-Source: AGHT+IEWtl7qZgPHRVigCivuFbNa7GKZtcgCkNvlIefTKSlTMAboaC894OqkWw9bTxvnRWyW6SGZTEuNocMfwX0MvVQ=
X-Received: by 2002:a05:6402:51cb:b0:5e0:67a7:f994 with SMTP id
 4fb4d7f45d1cf-5e067a7fb3cmr5224752a12.19.1739878954084; Tue, 18 Feb 2025
 03:42:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206124248.160494-1-christian.couder@gmail.com>
 <20250127151701.2321341-1-christian.couder@gmail.com> <20250127151701.2321341-6-christian.couder@gmail.com>
 <xmqqa5bbq0nb.fsf@gitster.g>
In-Reply-To: <xmqqa5bbq0nb.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 18 Feb 2025 12:42:21 +0100
X-Gm-Features: AWEUYZlxoEFdpkmerbr9CNTHzbdSe82vqlZINuLhkw6cIlIifnY8ejT5Vi3j6G8
Message-ID: <CAP8UFD1z7NiwNqoynFfB5ennORh6wUxLh3gD9xisyA437J3eFA@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] promisor-remote: check advertised name or URL
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, 
	"Randall S . Becker" <rsbecker@nexbridge.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 12:48=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > A previous commit introduced a "promisor.acceptFromServer" configuratio=
n
> > variable with only "None" or "All" as valid values.
> >
> > Let's introduce "KnownName" and "KnownUrl" as valid values for this
> > configuration option to give more choice to a client about which
> > promisor remotes it might accept among those that the server advertised=
.
>
> OK.
>
> >  promisor.acceptFromServer::
> >       If set to "all", a client will accept all the promisor remotes
> >       a server might advertise using the "promisor-remote"
> > -     capability. Default is "none", which means no promisor remote
> > -     advertised by a server will be accepted. By accepting a
> > -     promisor remote, the client agrees that the server might omit
> > -     objects that are lazily fetchable from this promisor remote
> > -     from its responses to "fetch" and "clone" requests from the
> > -     client. See linkgit:gitprotocol-v2[5].
> > +     capability. If set to "knownName" the client will accept
> > +     promisor remotes which are already configured on the client
> > +     and have the same name as those advertised by the client. This
> > +     is not very secure, but could be used in a corporate setup
> > +     where servers and clients are trusted to not switch name and
> > +     URLs.
>
> I wonder if the reader needs to be told a bit more about the
> security argument here.  I imagine that the attack vector behind the
> use of "secure" in the above paragraph is for a malicious server
> that guesses a promisor remote name the client already uses, which
> has a different URL from what the client expects to be associated
> with the name, thereby such an acceptance means that the URL used in
> future fetches would be replaced without the user's consent.

There is currently no mechanism for the URL to be replaced on the
client side by the one advertised by the server. The client will still
use the URL that has been configured in another way, likely the clone
`-c` option. But yeah it could lead to misunderstandings between the
client and the server. And if we later develop such a mechanism to
replace the URL on the client side, or to just temporarily use the one
advertised by the server, this could be a problem.

> Being
> able to silently repoint the remote.origin.url at an evil repository
> you control is indeed a powerful thing, I would guess.  Of course,
> in a corp environment, such a mechanism to drive the clients to a
> new repository after upgrading or migrating may be extremely handy.

Yeah, that's why there are chances that such a mechanism will be
developed later, and we should take care of warning users even if
currently there are no real security risks.

> Or does the above paragraph assumes some other attack vectors,
> perhaps?

No, I don't see another attack vector.

> > +     If set to "knownUrl", the client will accept promisor
> > +     remotes which have both the same name and the same URL
> > +     configured on the client as the name and URL advertised by the
> > +     server. This is more secure than "all" or "knownUrl", so it

Here I see that it should be "knownName" instead of "knownUrl". I have
fixed this in the next version I will send soon.

> > +     should be used if possible instead of those options. Default
> > +     is "none", which means no promisor remote advertised by a
> > +     server will be accepted.
>
> OK.
>
> > diff --git a/promisor-remote.c b/promisor-remote.c
> > index 5ac282ed27..790a96aa19 100644
> > --- a/promisor-remote.c
> > +++ b/promisor-remote.c
> > @@ -370,30 +370,73 @@ char *promisor_remote_info(struct repository *rep=
o)
> >       return strbuf_detach(&sb, NULL);
> >  }
> >
> > +/*
> > + * Find first index of 'vec' where there is 'val'. 'val' is compared
> > + * case insensively to the strings in 'vec'. If not found 'vec->nr' is

I mean "insensitively" instead of "insensively". This is fixed in the
next version.

> > + * returned.
> > + */
> > +static size_t strvec_find_index(struct strvec *vec, const char *val)
> > +{
> > +     for (size_t i =3D 0; i < vec->nr; i++)
> > +             if (!strcasecmp(vec->v[i], val))
> > +                     return i;
> > +     return vec->nr;
> > +}
>
> Hmph, without the hardcoded strcasecmp(), strvec_find() might make a
> fine public API in <strvec.h>.

Yeah, but I didn't find any other places in the code where a
strvec_find() function could be useful.

> Unless we intend to create a generic function that qualifies as a
> part of the public strvec API, we shouldn't call it strvec_anything.
> This is a great helper that finds a matching remote nickname from
> list of remote nicknames, so
>
>     remote_nick_find(struct strvec *nicks, const char *nick)
>
> may be more appropriate.

Ok, I have renamed it remote_nick_find() in the next version.

> When we lift it out of here and make it
> more generic to move it to strvec.[ch], perhaps
>
>         size_t strvec_find(struct strvec *vec, void *needle,
>                  int (*match)(const char *, void *)) {
>                 for (size_t ix =3D 0; ix < vec->nr, ix++)
>                         if (match(vec->v[ix], needle))
>                                 return ix;
>                 return vec->nr;
>         }
>
> which will be used to rewrite remote_nick_find() like so:
>
>         static int nicks_match(const char *nick, void *needle)
>         {
>                 return !strcasecmp(nick, (conat char *)needle);
>         }
>
>         remote_hick_find(struct strvec *nicks, const char *nick)
>         {
>                 return strvec_find(nicks, nick, nicks_match);
>         }
>
> it would be better to use a more generic parameter name "vec", but
> until then, it is better to be more specific and explicit about the
> reason why the immediate callers call the function for, which is
> where my "nicks" vs "nick" comes from (it is OK to call the latter
> "needle", though).

Yeah, I would be fine with this solution if there were other places
where strvec_find() could be useful.

> >  enum accept_promisor {
> >       ACCEPT_NONE =3D 0,
> > +     ACCEPT_KNOWN_URL,
> > +     ACCEPT_KNOWN_NAME,
> >       ACCEPT_ALL
> >  };
> >
> >  static int should_accept_remote(enum accept_promisor accept,
> > -                             const char *remote_name UNUSED,
> > -                             const char *remote_url UNUSED)
> > +                             const char *remote_name, const char *remo=
te_url,
> > +                             struct strvec *names, struct strvec *urls=
)
> >  {
> > +     size_t i;
> > +
> >       if (accept =3D=3D ACCEPT_ALL)
> >               return 1;
> >
> > -     BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
> > +     i =3D strvec_find_index(names, remote_name);
> > +
> > +     if (i >=3D names->nr)
> > +             /* We don't know about that remote */
> > +             return 0;
>
> OK.
>
> > +     if (accept =3D=3D ACCEPT_KNOWN_NAME)
> > +             return 1;
> > +
> > +     if (accept !=3D ACCEPT_KNOWN_URL)
> > +             BUG("Unhandled 'enum accept_promisor' value '%d'", accept=
);
>
> I can see why this defensiveness may be a good idea than not having
> any, but I wonder if we can take advantage of compile time checks
> some compilers have to ensure that case arms in a switch statement
> are exhausitive?

Perhaps, but otherwise I am not sure that using a switch statement
would make the code better. The ACCEPT_KNOWN_NAME and ACCEPT_KNOWN_URL
cases need to share some code and the ACCEPT_NONE case seems better
handled by the caller.

> > +     if (!strcasecmp(urls->v[i], remote_url))
> > +             return 1;
>
> This is iffy.  The <schema>://<host>/ part might want to be compared
> case insensitively, but the rest of the URL is generally case
> sensitive (unless the material served is stored on a machine with
> case-insensitive filesystem)?

I am fine with comparing the whole URL case sensitively. So
"strcasecmp()" is replaced with "strcmp()" in the next version.

> Given that the existing URL must have come by either cloning from
> this server or another related server or by an earlier
> acceptFromServer behaviour, I do not see a need for being extra lax
> here.  We should be more careful about our use of case-insensitive
> comparison, and I do not see how this URL comparison could be
> something the end users would expect to be done case insensitively.

In another email you also said:

> Note that I am not advocating to compare the earlier part case
> insensitively while comparing the remainder case sensitively.
>
> Because we are not comparing URLs that come from random sources, but
> we know they come from a only few very controlled sources (i.e., the
> original server we cloned from, and the promisor remotes sugggested
> by the original server and other promisor remotes whose suggestion
> we accepted, recursively), it should be sufficient to compare the
> whole string case sensitively.

When I implemented this, I was just thinking that some users might for
example spell the scheme part "HTTPS" in their client config and then
complain that it should work when the server advertises the same URL
with "https" instead of "HTTPS", because yeah the <schema>://<host>/
part should be case insensitive. But I agree we can start with
everything being case sensitive and improve on this (likely by
comparing the <schema>://<host>/ part case insensitively and the rest
case sensitively) if/when users complain.

> > -static void filter_promisor_remote(struct strvec *accepted, const char=
 *info)
> > +static void filter_promisor_remote(struct repository *repo,
> > +                                struct strvec *accepted,
> > +                                const char *info)
> >  {
> >       struct strbuf **remotes;
> >       const char *accept_str;
> >       enum accept_promisor accept =3D ACCEPT_NONE;
> > +     struct strvec names =3D STRVEC_INIT;
> > +     struct strvec urls =3D STRVEC_INIT;
> >
> >       if (!git_config_get_string_tmp("promisor.acceptfromserver", &acce=
pt_str)) {
> >               if (!accept_str || !*accept_str || !strcasecmp("None", ac=
cept_str))
>
> Not a fault of this step, but is it sensible to even expect
> !accept_str in an error case?  *accept_str could be NUL, but
> accept_str be either left uninitialized (because this caller does
> not initialize it) when the get_string_tmp() returns non-zero, or
> points at the internal cached value in the config_set if it returns
> 0 (and the control comes into this block).

Yeah, I agree accept_str cannot be NULL here. I have removed
"!accept_str || " in the next version.

> >                       accept =3D ACCEPT_NONE;
> > +             else if (!strcasecmp("KnownUrl", accept_str))
> > +                     accept =3D ACCEPT_KNOWN_URL;
> > +             else if (!strcasecmp("KnownName", accept_str))
> > +                     accept =3D ACCEPT_KNOWN_NAME;
> >               else if (!strcasecmp("All", accept_str))
> >                       accept =3D ACCEPT_ALL;
> >               else
>
> Ditto about icase for all of the above.

These are config values that can take only a specific set of values. I
think those are most often compared case insensitively in Git, for
example there is no distinction between "True" and "true" for bool
values. So I am not sure what you suggest here.

> > +test_expect_success "clone with 'KnownUrl' and different remote urls" =
'
> > +     ln -s server2 serverTwo &&
> > +
> > +     git -C server config promisor.advertise true &&
> > +
> > +     # Clone from server to create a client
> > +     GIT_NO_LAZY_FETCH=3D0 git clone -c remote.server2.promisor=3Dtrue=
 \
> > +             -c remote.server2.fetch=3D"+refs/heads/*:refs/remotes/ser=
ver2/*" \
> > +             -c remote.server2.url=3D"file://$(pwd)/serverTwo" \
> > +             -c promisor.acceptfromserver=3DKnownUrl \
> > +             --no-local --filter=3D"blob:limit=3D5k" server client &&
> > +     test_when_finished "rm -rf client" &&
> > +
> > +     # Check that the largest object is not missing on the server
> > +     check_missing_objects server 0 "" &&
> > +
> > +     # Reinitialize server so that the largest object is missing again
> > +     initialize_server 1 "$oid"
> > +'
>
> Nice ;-)
>
> Here, I also notice that we are not testing that serverTwo and
> servertwo are considered the same thanks to the use of icase
> comparison.  We shouldn't compare URLs with strcasecmp().

Ok, thanks.

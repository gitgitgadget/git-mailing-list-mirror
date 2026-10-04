Received: from mail-wr2-f41.google.com (mail-wr2-f41.google.com [74.125.225.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2103B42C9
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791128430; cv=pass; b=YZM/CPh+8/KLyMlfUiI4DSJGxb0BG5y2NVf22mRllVi1g5m+FpPJ2Zdc8PSw8ECwti8Rld6+4SXUCPrneIX4C+JuzPVlez8d49UcEX0siiv2a/wMMc1Nqx4YLWdzdXvVCufwW+QmzxUvNrcxGFpCqXTzyroQB/vxD6j6to3mrgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791128430; c=relaxed/simple;
	bh=jvtSLqMzSJW96RiyV6HuHO2dUIwNzqgJluBJcD/hbNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qFmJGlkr9pgjRXHv1cdl0u4wSToHh8gAss3XVtj6SONh2x/1winY/ZmQywlKb0xlyqkPOwO8MEPVMlTikgLHt/3Vs0TgkXpHx8qeWjkD4PGQwn94i8LYtrGHo/rS0JevDwYlNGw+WauR57UivZOqYH9wRXmeXTyMrf+kjD5QrH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rt7CTBRT; arc=pass smtp.client-ip=74.125.225.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rt7CTBRT"
Received: by mail-wr2-f41.google.com with SMTP id ffacd0b85a97d-4834977ae75so439901f8f.3
        for <git@vger.kernel.org>; Sun, 04 Oct 2026 08:40:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791128424; cv=none;
        d=google.com; s=arc-20260327;
        b=UQjdCIsN6HonBXEC4dkTTkF1sqpw225GzhGiOK4OaBRuKnSdenCgju8CWYRcUYLCwq
         Z7sNTeeQX95WbU+zwevfqHnifExs+EY0tMlw9aGmNpuLO1HMqiKLbDHmOfQPy6mRY3jK
         Agxw3DABkNUst7GG2B4BSWBM1ho2iBzL48+rKV2QAqdf8Z9pEkDq51bGTuxRzBY1wDFE
         W5tnJ+7VhHrnv3TtWycpifFg3gO8kxreZlzasp/m+xKfGIWVvlHrICJzYdmh1lKV2i1A
         33MtX9L8cp+fzblVSj44G0KUr+n98WqTGFzqdNhxu8S32kroKlziH6HwHOuxceHEN7xH
         ZiyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mqMUObDtKr4o2FzXGdjOU2btsFpaMuzkAXhTorOrECE=;
        fh=9lOeBiTeAI+4FIPMHGbUvHErvC4nv37dZNbhm6sOM2g=;
        b=hmQYOT4jCMX5Pv7onuxoCa6mMuWPVYJqf271j8GNcpBfVwLZDUSjj6K4oKUxoBNvVC
         O+/GF/pTkrmhCbhNuHenBAkTNug1HCKZD2R9bHA6p4sIEGOO6Cwip/RwXw/X9ptQqVyb
         DO91CvMXqZc7SfesFA/JZMalwDzPPFIgVXUz1x75KDxBUQbsFfdvlt4ieqQUKW0ZpM6L
         70TVKwSULKECwBXGGZP6prMcBwfg3u0bXTA1CsZTPoTRB0NnecstzGmYAcUpNRvTvS3f
         rbmS0Ue4p0RZEGN9F409jnUPubSejBoGrZHqLrxA37d9Ux2daea/Od9Bp11Y3iffn2fn
         fPyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791128424; x=1791733224; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mqMUObDtKr4o2FzXGdjOU2btsFpaMuzkAXhTorOrECE=;
        b=rt7CTBRTIbh/bnvToR2ul4t1t/qdGEXf6KSt1zl/sjjo2SbLOeWSv7fI4QbmPDuREk
         IA5Xj0v/I74ScjkwPszEbcJ/uOZlAXRfH3HOCFFEccJANCIKDOlw1nM1u3/hhHfSYlUd
         UBp0Of2CIql9HOuYBe2fadGs3l06Zn9Ye8KOJxBvJH6LcexY1csf2jlH1kZHhAXf4MPS
         t3ohsCI8RyYjWwYQM7Qjn8BAUymK37ect7hqDrQxiBABxAemqC0wSBapIPIMUMD4loOb
         7mgDKUkC9sFTbVh7159TjSRKcU2znMZJwhGmUqEv1FuuXHkvqodtKvSGygA2v2F6weRd
         rcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791128424; x=1791733224;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mqMUObDtKr4o2FzXGdjOU2btsFpaMuzkAXhTorOrECE=;
        b=JZ72JiufEwqtXiGFB8M1pco8liY5xA5+4k6NQu/6Xt6YxV5d1U6snhWAaVT1vxBWH8
         tqzOY+QnlhZr9wWotJLcwiwOXttdsiWIXed2bz4XJeOvsMAOTiNlWqdarU4rWAZjLvII
         lfotfKXBhBLK5BcVDhA758RgNt77wwREnqmUL2Nt94shvCFy2kPD0IbIJtDqXPUKPNZ9
         B/aeoKbtVQxdJvmBYtsJl9U5BkA8HGoC7IuPQf/A9nW/eQ62vxTpjJKjmJtg2R8P8fZl
         cAdS2gaZ9uVklJcSMq+3QygB3Epzo1cJ5nMdpJe+Hz+a38hDXbrILLcpMZVdZRGVfQ/U
         ozmQ==
X-Gm-Message-State: AFq9FYKuZNQi3HwKrHWPvmpqbT7qE2NccT2jQOtjW9tbtgrI13HdT1UE
	G2UJ18tvJgN2BFcvVXwgkMjgzG8Qh4cFB0jfA0Ogzm7ZYgfGb2IZvrXeZNuNswvMgPDWQNaylAT
	cH5p6bCR4hrCNf74sPE8jcqThzL16h0o5JdbL
X-Gm-Gg: AYBFou2+/LS6u9MPQBdnGM2v1pO9fE1LZDHOYLiLDGgLQTHcu1wihKlhaWrMjKfXF1U
	vGsbc8JK25l1+nbE9pSLStRS9+FoTcLi7Bxz/fkKzn+yTZ8XsLaa1N8J4U4qXNv8OMXVyHjuIbE
	EO22a8vHzben2j4cPm6wBxKDO6CsXTNFFiQ6aNK8+zkv6O9ay02NEpBS79nShl6yV4BiSuFGJF5
	1Prh8Y/j69l0TvrIujSXaQ23jYrpKB0no1krTyTMJa6+B16RELfxZWNuVtZC48Sj0axUb2jg/1b
	Rfd+Uo/pjgCVRUMzykrGQCsPlw1IkkW+fEGbm1G40Bmv5fbafM7PeMJw/mu6rpA0AL0hiQHpDxB
	Ce5OgdMsvwR1K
X-Received: by 2002:a05:6000:4707:b0:488:844f:6034 with SMTP id
 ffacd0b85a97d-48b1275c854mr14255558f8f.48.1791128424126; Sun, 04 Oct 2026
 08:40:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925230621.179649-1-colinlewishinton@gmail.com>
 <20261003231422.6004-1-colinlewishinton@gmail.com> <xmqqa4otvbnk.fsf@gitster.g>
In-Reply-To: <xmqqa4otvbnk.fsf@gitster.g>
From: Colin Hinton <colinlewishinton@gmail.com>
Date: Sun, 4 Oct 2026 08:40:13 -0700
X-Gm-Features: AclHuK-USOZgD-wvcVjCoXXw8-HrBaaWvcajMMxp08wY-6CseUxRVXm-Afmd9gk
Message-ID: <CAHeTm9PK=sc4ajmf53rhurd532OST0qYfEaS-Kc5kpGZf1Zw2A@mail.gmail.com>
Subject: Re: [PATCH v4] fetch.c: defer fetch.followRemoteHEAD validation
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, m@lfurio.us
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

My rationale for this recent change came from when I was evaluating
what calls get_follow_remote_head() in my patch.

With the current design, get_follow_remote_head() is only called in
do_fetch() in this conditional else if
(config->follow_remote_head_raw).

If followRemoteHEAD is now NULL because we set it as such in
fetch_config->follow_remote_head_raw =3D xstrdup_or_null(v); Then this
conditional is skipped, and we will never call the die(), and alert
the user that their value is blank.

To fully fix based on your suggestion, I suppose the design question
is, should empty string warn or die?

If empty string should warn, I likely will need to add some value in
the fetch_config struct such as follow_remote_head_seen, and use this
as our conditional in do_fetch() rather than the
follow_remote_head_raw, to account for when followRemoteHEAD was set
to anything. Then when the check in get_follow_remote_head() occurs,
we know to die or warn based on NULL, or bogus.

Visually, it would look something like this.

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 2cb0bcca8b..af22f63954 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -104,6 +104,7 @@ static struct string_list negotiation_include =3D
STRING_LIST_INIT_NODUP;
 struct fetch_config {
        enum display_format display_format;
        char *follow_remote_head_raw;
+       int follow_remote_head_seen;
        int all;
        int prune;
        int prune_tags;
@@ -177,10 +178,8 @@ static int git_fetch_config(const char *k, const char =
*v,

        if (!strcmp(k, "fetch.followremotehead")) {
                free(fetch_config->follow_remote_head_raw);
-               if (!v)
-                       fetch_config->follow_remote_head_raw =3D xstrdup(""=
);
-               else
-                       fetch_config->follow_remote_head_raw =3D xstrdup(v)=
;
+               fetch_config->follow_remote_head_raw =3D xstrdup_or_null(v)=
;
+               follow_remote_head_seen =3D 1;
                return 0;
        }

@@ -189,7 +188,7 @@ static int git_fetch_config(const char *k, const char *=
v,

 static enum follow_remote_head_settings get_follow_remote_head(const
char *setting)
 {
-       if (!setting || !*setting)
+       if (!setting) /*!*setting would return true on "" removing to
warn instead*/
                die(_("missing value for 'fetch.followRemoteHEAD'"));
        else if (!strcmp(setting, "never"))
                return FOLLOW_REMOTE_NEVER;
@@ -1960,7 +1959,7 @@ static int do_fetch(struct transport *transport,
                         */
                        if (transport->remote->follow_remote_head)
                                follow_remote_head =3D
transport->remote->follow_remote_head;
-                       else if (config->follow_remote_head_raw)
+                       else if (config->follow_remote_head_seen)
                                follow_remote_head =3D
get_follow_remote_head(config->follow_remote_head_raw);
                        else
                                follow_remote_head =3D
BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
@@ -2510,6 +2509,7 @@ int cmd_fetch(int argc,
        struct fetch_config config =3D {
                .display_format =3D DISPLAY_FORMAT_FULL,
                .follow_remote_head_raw =3D NULL,
+               .follow_remote_head_seen =3D 0,
                .prune =3D -1,
                .prune_tags =3D -1,
                .show_forced_updates =3D 1,

Let me know if this sounds right, and I will add this in for v5.
-Colin Hinton

On Sun, Oct 4, 2026 at 6:27=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Colin Hinton <colinlewishinton@gmail.com> writes:
>
> >       if (!strcmp(k, "fetch.followremotehead")) {
> > +             free(fetch_config->follow_remote_head_raw);
> >               if (!v)
> > +                     fetch_config->follow_remote_head_raw =3D xstrdup(=
"");
> >               else
> > +                     fetch_config->follow_remote_head_raw =3D xstrdup(=
v);
>
> Hmph, this means that the code cannot distinguish between
>
>         [fetch] followremotehead
>
>         [fetch] followremotehead =3D ""
>
> It would be less code and more expressive if you lost the
> conditional, i.e.,
>
>         if (!strcmp(k, "fetch.followremotehead"))
>                 free(fetch_config->follow_remote_head_raw);
>                 fetch_config->follow_remote_head_raw =3D xstrdup_or_null(=
v);
>         }
>
> > +static enum follow_remote_head_settings get_follow_remote_head(const c=
har *setting)
> > +{
> > +     if (!setting || !*setting)
> > +             die(_("missing value for 'fetch.followRemoteHEAD'"));
>
> Then you can differenciate
>
>         if (!setting)
>                 ... we got '[fetch] followRemoteHEAD' ...
>                 die() as before, complaining that the this is not a Bool.
>         else if (!*setting)
>                 ... we got '[fetch] followRemoteHEAD =3D ""' ...
>
> if we wanted to.  It probably do not need to check for an empty
> string as it will fall through the "else if" cascade below and
> eventually end up with the warning + default.
>
> > +     else if (!strcmp(setting, "never"))
> > +             return FOLLOW_REMOTE_NEVER;
> > +     else if (!strcmp(setting, "create"))
> > +             return FOLLOW_REMOTE_CREATE;
> > +     else if (!strcmp(setting, "warn"))
> > +             return FOLLOW_REMOTE_WARN;
> > +     else if (!strcmp(setting, "always"))
> > +             return FOLLOW_REMOTE_ALWAYS;
> > +     warning(_("unrecognized fetch.followRemoteHEAD value '%s' ignored=
"), setting);
> > +     return BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
> > +}

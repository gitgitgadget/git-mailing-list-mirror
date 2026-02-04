Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CDA239E8B
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770200433; cv=pass; b=gDREHvaRhp3fAsnsEjXiAWd4iKk2qaLlX633YoyTJKpX8xv5AJA1z3vvzERymsnmlLgFyWn72botPevHhgDZArQ5RoqMIsAHhPYSdPaa+TLal3CSXVVbrOEWhNwrGIXPCRnBj9dZ0GavKx7uhOWvp5PPyLUbpGDRPFQQUIOUY1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770200433; c=relaxed/simple;
	bh=TXos41U0dJ27foNtM46LDPdxDz9tBlN7waTiJ8Fdj3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FyBhkTQRkl3rGQ8y8QdeTYvFVemuR9uS2L7RwnKvdFD50kIESnNoBMoFFaMdX8gnhYmhUVTE1ny+h3meQlw1Wgr8RG9Qa0VximQ2NOcafRBxpqOjFRr89RrBlLWG/StlpMsC7FYrere1KG2CTOqbWSFT20c8iRAZm8eGFJwC3Vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nX86w6Tp; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nX86w6Tp"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12460a7caa2so10025894c88.1
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 02:20:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770200433; cv=none;
        d=google.com; s=arc-20240605;
        b=OLG6wrQqg7ol8xX0CoyZ6RYGpRermPcHUwqv4ZU8iWZdidtTaWhCuJJd6xTvEEm2po
         fdB4eHWND6CfvmPtlXUizFCBGyOJtAI8yejF4FchW2LWfcTAdGbvI+2Y+qeJYJt1UFgL
         jJ8hbNprk/+zqRgIcTgPZXKqhn6A/cqylDosOSWki27fewEPcqkeCzlnklDRkvMUF7CP
         qknGQjqJ890zvUn99xCUgF1h92uHd5Iqfw8wHBEio8qqnijB8m4ziFcdNrRJmlxeU9in
         rozQ2K7/M1CRdDbpJcER46Mrvt8B827gRcviO1Bev/H85uJoyBgPVcL/yXZlOFV3WtAp
         VMlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KctOk3EXvPfmRYnUVPZly5RVUnxYoQ1d9b4+c0hyV2g=;
        fh=aY+RodnsZwaVQgtho/D2F/LrJl8TcIGRGapA9S/T9w8=;
        b=Rx14HeWYbBlnuToT3MSCahCZ867SqOrdWGL3gE1Zw0/JL6nM+AJM8bkezi61PxX2NH
         beBEolqnvOJIVqTynf8lCLYGTOn2pDSln1mt6ldHhppEkUrtVlR9q9OlxCWNbavxCEnX
         0qHvw4EGONUVIs0r20g44OTDPQ3Lp/b5Ctc7itpf6kLY60rwNoOWyjPVyzYSh2e4k+Dr
         BLh2gSSknGHQN4WkWGi3MhzkU3jq/y2YWWU0OwQnKiAp7vZv74nwieKU6Kla1jSUmXJk
         o5Umo5W9XCfb3qdYwasgBGQPraTqm3omjGTjlni6RIZoEuSQDS3fkQiQI7s4GiAxkgXi
         KIqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770200433; x=1770805233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KctOk3EXvPfmRYnUVPZly5RVUnxYoQ1d9b4+c0hyV2g=;
        b=nX86w6Tpp+D62ZraQsEA59gvmYK3yNVgTUui+WIkkZlrCOnRS7+Q6OCpMXphkJ/3zX
         HdgqEFdWVnXURclnwTh4mrGKJ1iUvaqE8U10e1ZMAG10ifOvgUXw9x0VV3nS6Qq658cF
         x1V5v0Fyyylfl7JrZd2MMejNLiy5LU6Lls3acJiSNVpKqVdtsqSGPPxUn8VV7tIfCB6o
         TjkBDnvuPB6xpavCyHSRN38nSjzq4azQwsOB33vPUYLwu06sYQMdPFAxb1QvgGo7Rpvq
         E6lyf4bicUA37L8w3JIBsE6fHrLgnumrl37TN+0tDt6QVovluTKsU30LexdT8KEzvOQH
         F7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770200433; x=1770805233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KctOk3EXvPfmRYnUVPZly5RVUnxYoQ1d9b4+c0hyV2g=;
        b=NeaFFo1iqm76PQ/JD37Ook5uED7/JAx3ortEivMI98dhDSpOcEJaLK533eT39QWetm
         WLBcDQavFu2Oaq6BxorcV1fxp98d2OQGQBmrtx1u9NKH7UeVWlD3gZFBPosjpdvtp5DG
         t1RcpvzeEhNoLpa8Og9HhQukJL0GtmVSiFq+ZJBIy3CJcS7Bdn2pMvH91+Ch1MUcPZB6
         46g9ZmE2A1UCScRs0Xq1GeAJ8NcAElybbnTbteozn2EiPPEfextKQg5+v+MSwKDqO8Pr
         ClDtg+aEPMJpBSNzBkLIsofWmw0u2bCMyenxt7qNFmxLOz+rfAVp19VkDg/eI8gnkNnD
         U54g==
X-Gm-Message-State: AOJu0YxhO/MufWGfypTpfota4QUsiASn4IcbvvbJHX4GhFd+GT3j0WQt
	XTgKdR+nz0mUdPwnK55zmMudRx4DUwmpmUVqsA8+/OW976+OfqIg+9TSC/fD+qflJ+sHEtjiO0O
	NSALiC0/G6oI/PFuWml64/RfaCSnEqxo=
X-Gm-Gg: AZuq6aJyV6DcQMTC2MjJ0DnzYZKrb/hemJiHByk1CYNdxL02MIX3Mg1FAS6Ltb16Z31
	KMiDKmjL5ICw2GPa6gskQ0mEtZOkSeYyF8JUoiQ9b2aIDcqUvZt1aq+zX8TngbeKouoNea2F5zh
	mgZu13ITJVd4+ResDPdn0FkGMZ1Rx9/i8nTH7Kcn8fI4kabnJ5KUO8S/oN9YTTRY4H1+epoOnqH
	Li2EpKgzlrxuQkpfH6x0AE7aLc3jbPUcIv3aDWn31p0KahUy3N6M3ToS+muXy/A/5dBOqzKqPqR
	6xkgU07XN0QI2upXBh/PRegG2IhL1Z9W/alQ6I45f9JjUA6+A5cdNCc+
X-Received: by 2002:a05:7022:aa8:b0:119:e569:f622 with SMTP id
 a92af1059eb24-126f47c5a66mr819223c88.27.1770200432662; Wed, 04 Feb 2026
 02:20:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20251223111113.47473-3-christian.couder@gmail.com> <aV4v3JwW0S-c9Dn4@pks.im>
In-Reply-To: <aV4v3JwW0S-c9Dn4@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 4 Feb 2026 11:20:21 +0100
X-Gm-Features: AZwV_QjHA1iuThwcbNjq9ucTc0ddIwNpxe4WsBpAR-GWbPAf38yNeSOQP8oQEUM
Message-ID: <CAP8UFD0Xmfi38=q5FBL6UeoJNqNTw7cD9pAqi_vAr3dFxv2w3Q@mail.gmail.com>
Subject: Re: [PATCH 2/9] promisor-remote: allow a client to store fields
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 11:05=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Tue, Dec 23, 2025 at 12:11:06PM +0100, Christian Couder wrote:
> > A previous commit allowed a server to pass additional fields through
> > the "promisor-remote" protocol capability after the "name" and "url"
> > fields, specifically the "partialCloneFilter" and "token" fields.
> >
> > Another previous commit, c213820c51 (promisor-remote: allow a client
> > to check fields, 2025-09-08), has made it possible for a client to
> > decide if it accepts a promisor remote advertised by a server based
> > on these additional fields.
> >
> > Often though, it would be interesting for the client to just store in
> > its configuration files these additional fields passed by the server,
> > so that it can use them when needed.
> >
> > For example if a token is necessary to access a promisor remote, that
> > token could be updated frequently only on the server side and then
> > passed to all the clients through the "promisor-remote" capability,
> > avoiding the need to update it on all the clients manually.
> >
> > Storing the token on the client side makes sure that the token is
> > available when the client needs to access the promisor remotes for a
> > lazy fetch.
>
> I guess another use case is that a client performs a fresh clone and
> doesn't know anything about the remote's promisors yet, right? In that
> case, the client may want to tell git-clone(1) to accept any of the
> remote's advertised promisors, store it and then use that promisor's
> filter to perform the actual clone.

Actually there are two issues with this.

The first one is the security issue with the client adding a new
promisor to its config that I will discuss below.

The second one is the fact that it's better if the filter suggested by
the server is used right away during the initial clone, but you have
to pass a `--filter=3D<filter-spec>` to the clone option in the first
place when you start the initial clone and the filter suggested by the
server might be different than the one you pass. This is why the
second part of the series implements `--filter=3Dauto`.

> > In the same way, if it appears that it's better to use a different
> > filter to access a promisor remote, it could be helpful if the client
> > could automatically use it.

By the way I have removed this in the version 2 I am going to send
soon, as it could be misleading.

> > To allow this, let's introduce a new "promisor.storeFields"
> > configuration variable.
> >
> > Like "promisor.checkFields" and "promisor.sendFields", it should
> > contain a comma or space separated list of field names. Only the
> > "partialCloneFilter" and "token" field names are supported for now.
> >
> > When a server advertises a promisor remote, for example "foo", along
> > with for example "token=3DXXXXX" to a client, and on the client side
> > "promisor.storeFields" contains "token", then the client will store
> > XXXXX for the "remote.foo.token" variable in its configuration file
> > and reload its configuration so it can immediately use this new
> > configuration variable.
> >
> > A message is emitted on stderr to warn users when the config is
> > changed.
> >
> > Note that even if "promisor.acceptFromServer" is set to "all", a
> > promisor remote has to be already configured on the client side for
> > some of its config to be changed. In any case no new remote is
> > configured and no new URL is stored.
>
> Hm, okay, so that's not yet part of this series. I assume this is going
> to be part of a subsequent patch series then?

My opinion is that we should indeed work on that in a future separate
series, as it could be very useful in setups where clients trust the
server, like corporate setups. For now I prefer to keep things safe by
default and not make it possible.

> > diff --git a/promisor-remote.c b/promisor-remote.c
> > index 5d8151cedb..8d6d2d7b76 100644
> > --- a/promisor-remote.c
> > +++ b/promisor-remote.c
> > @@ -403,6 +403,14 @@ static struct string_list *fields_checked(void)
> >       return initialize_fields_list(&fields_list, &initialized, "promis=
or.checkFields");
> >  }
> >
> > +static struct string_list *fields_stored(void)
> > +{
> > +     static struct string_list fields_list =3D STRING_LIST_INIT_NODUP;
> > +     static int initialized;
> > +
> > +     return initialize_fields_list(&fields_list, &initialized, "promis=
or.storeFields");
> > +}
>
> I'm a bit worried about all the function-local state that we're
> accumulating in those functions. Wouldn't it be preferable if we instead
> had a `struct promisor_remote` that encapsulates the information?

I don't think we have a good standard way to manage information from
the config yet. Some suggestions have been made about using a new
struct for some config options, for example in:

https://lore.kernel.org/git/8899016f-eeef-404b-8da6-ff3a90e81cea@gmail.com/

and perhaps such a good standard way to manage config information will
result from these efforts, but I think it's too early to be sure.

In the meantime, I don't think it's a good idea to spend time on a
specialized way to do it just for promisor remotes.

> > @@ -692,6 +700,132 @@ static struct promisor_info *parse_one_advertised=
_remote(const char *remote_info
> >       return info;
> >  }
> >
> > +static bool store_one_field(struct repository *repo, const char *remot=
e_name,
> > +                         const char *field_name, const char *field_key=
,
> > +                         const char *advertised, const char *current)
> > +{
> > +     if (advertised && (!current || strcmp(current, advertised))) {
> > +             char *key =3D xstrfmt("remote.%s.%s", remote_name, field_=
key);
> > +
> > +             fprintf(stderr, _("Storing new %s from server for remote =
'%s'.\n"
> > +                               "    '%s' -> '%s'\n"),
> > +                     field_name, remote_name,
> > +                     current ? current : "",
> > +                     advertised);
> > +
> > +             repo_config_set_worktree_gently(repo, key, advertised);
>
> Why do we store this information in the current per-worktree config? I'd
> expect that this should be stored in the local config.

Right, repo_config_set_gently() is used now instead.

> > +             free(key);
> > +
> > +             return true;
> > +     }

[...]

> > +struct store_info {
> > +     struct repository *repo;
> > +     struct string_list config_info;
> > +     bool store_filter;
> > +     bool store_token;
> > +};
> > +
> > +static struct store_info *new_store_info(struct repository *repo)
>
> This should be called `store_info_new()` according to our coding
> guidelines.

Fine, `store_info_new()` and `store_info_free()` are now used as you sugges=
t.

> > diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-r=
emote-capability.sh
> > index 023735d6a8..a726af214a 100755
> > --- a/t/t5710-promisor-remote-capability.sh
> > +++ b/t/t5710-promisor-remote-capability.sh
> > @@ -360,6 +360,55 @@ test_expect_success "clone with promisor.checkFiel=
ds" '
> >       check_missing_objects server 1 "$oid"
> >  '
> >
> > +test_expect_success "clone with promisor.storeFields=3DpartialCloneFil=
ter" '
> > +     git -C server config promisor.advertise true &&
> > +     test_when_finished "rm -rf client" &&
> > +
> > +     git -C server remote add otherLop "https://invalid.invalid"  &&
> > +     git -C server config remote.otherLop.token "fooBar" &&
> > +     git -C server config remote.otherLop.stuff "baz" &&
> > +     git -C server config remote.otherLop.partialCloneFilter "blob:lim=
it=3D10k" &&
> > +     test_when_finished "git -C server remote remove otherLop" &&
> > +
> > +     git -C server config remote.lop.token "fooXXX" &&
> > +     git -C server config remote.lop.partialCloneFilter "blob:limit=3D=
8k" &&
> > +
> > +     test_config -C server promisor.sendFields "partialCloneFilter, to=
ken" &&
> > +     test_when_finished "rm trace" &&
> > +
> > +     # Clone from server to create a client
> > +     GIT_TRACE_PACKET=3D"$(pwd)/trace" GIT_NO_LAZY_FETCH=3D0 git clone=
 \
> > +             -c remote.lop.promisor=3Dtrue \
> > +             -c remote.lop.fetch=3D"+refs/heads/*:refs/remotes/lop/*" =
\
> > +             -c remote.lop.url=3D"file://$(pwd)/lop" \
> > +             -c remote.lop.token=3D"fooYYY" \
> > +             -c remote.lop.partialCloneFilter=3D"blob:none" \
> > +             -c promisor.acceptfromserver=3DAll \
> > +             -c promisor.storeFields=3DpartialcloneFilter \
> > +             --no-local --filter=3D"blob:limit=3D5k" server client 2>e=
rr &&
>
> Onet thing that's missing in these tests is to verify that a subsequent
> git-fetch(1) updates the configuration.

Ok, I have added a test using `git fetch`.

Thanks.

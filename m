Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071A84F8BB
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 13:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727702917; cv=none; b=rbO+oNsNtvwEmwR6RjJ4U7B2Gxsa6Afo4MAOH3mIQpggu7a7wFie08eNBX/JB8cZC+zM6JStcNZqyplMSekD7fuTOam1ODYDQV5r7xX+qBkXIFmoq+qVwXmj/ixBsGT4ZfjYemG2WjPXVdNEgWIp/d8qnc5zF0tBwD6HQP/VJxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727702917; c=relaxed/simple;
	bh=CCiugks1YRjll4GRmb4Tgw0f1+zr8za+O+6j3X05AWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OR/IJoqYNvqTOZuvunG1Aer1JaZ4s4WaQDiD3DZj5prMDdS/Ei/NPoi6y3sVX1rzLtW2Gy64U062W0MzAl62nOM24+RM3pOCJKGJ8c71o6i2grEQdwyYupI2DvN9MPx0WmCWEr5E3fr4JLFnq0zg7bYXbVhCPlcxE7Mv+FUQC8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNFqWcbV; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNFqWcbV"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c89bdb9019so1097510a12.0
        for <git@vger.kernel.org>; Mon, 30 Sep 2024 06:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727702913; x=1728307713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYoGNBZXVbZ4rg/WWnS3J+BA/NWfIjrOAqqz5gX50Z8=;
        b=JNFqWcbVsqpaMwuUUgNMHVOQid3gRm4GCIaY19Zy6i6pSWgEEgJ/wkx5Dfc670cNWE
         Dz5jogcxQaUGq+dHuu0R0vPt6zTyDVudSntPCbOg7whhf6/FeJdF/JhkX8bRMMIWzS7D
         gLoFQIJV0VhDC5T2I4I3L3OOHhyVXCQm0gTcP7zzXD3//8tF8ijfsqfMbwhU0EYQDkej
         UnWlJmV7YflnNp90XXB8y4oburPBL4267cAcgfs+xpx2lAjVLlYbv54jngL7netQxOOv
         u5El8ZNT/pK/VcHaO2UGHlXhwStmX/KoER8dPn0k1BENbhHobN5sA0/S+dg2rERJwwMR
         Np5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727702913; x=1728307713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OYoGNBZXVbZ4rg/WWnS3J+BA/NWfIjrOAqqz5gX50Z8=;
        b=AinTKLHsNuBPcjgnIV2z8f+Ebyyasv+X1xpfCodpn5+WCC5KbYNTntqL8dpp5umIpm
         /Jj8D6n3rWHYkgv96etR2QK3AMXajpaDqOmynsxfMqEcc19c6JrSgK9rFLOqDj2i3mFT
         oWfz3jrBJeiHHAESwN5L2Zess9TlEl4FZ6VSnUBjZSwMXmwuEoSTEq5QoHY/gHnJfRrk
         RIjrLvZKCB4ttbHkIH7zNuZuvvIy+V7Pal6Murb9w5FVOOleDyVJPqfeIPlHfyTtLuLl
         0JzTRhkCnd59xG6KUTSlsG5M/Odl5WV/y7MmhkE+5jBcbmQ5EpSjAgUsj9UeplqNUTSS
         fqBg==
X-Gm-Message-State: AOJu0YxAwTma3BwNa3cx+cGaL4AwZ8qz56orQn/SpVOMqN22/M9LGoUZ
	OZf7JX9KX4AyN3gVBx4M/VSmU4VUBtBWsgE9l/i0oACrtFwAA7v8gIPLtfTHsllTT/Z4OQKi6ag
	fDaxL9cGYtpXLQGMkwto5RCDW83o=
X-Google-Smtp-Source: AGHT+IG55yRSO5Gk8Y4HemxCSrFuZ0g8ka+KPG7x92FlPdkBJV+WuzuXk77HBxawsHqht4YbPba4l+Xk1nv9AoowqEw=
X-Received: by 2002:a05:6402:2114:b0:5c8:9f3d:d906 with SMTP id
 4fb4d7f45d1cf-5c89f3dd91bmr1299063a12.18.1727702912931; Mon, 30 Sep 2024
 06:28:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731134014.2299361-1-christian.couder@gmail.com>
 <20240910163000.1985723-1-christian.couder@gmail.com> <20240910163000.1985723-4-christian.couder@gmail.com>
 <ZvpZy9XMpLI0DQQg@pks.im>
In-Reply-To: <ZvpZy9XMpLI0DQQg@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 30 Sep 2024 15:28:20 +0200
Message-ID: <CAP8UFD3+YVE+pgGtSP6gDDN9=-0acuJCnDamWjeCX-g5aqTp3g@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] Add 'promisor-remote' capability to protocol v2
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 9:57=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Tue, Sep 10, 2024 at 06:29:59PM +0200, Christian Couder wrote:
> > diff --git a/Documentation/config/promisor.txt b/Documentation/config/p=
romisor.txt
> > index 98c5cb2ec2..9cbfe3e59e 100644
> > --- a/Documentation/config/promisor.txt
> > +++ b/Documentation/config/promisor.txt
> > @@ -1,3 +1,20 @@
> >  promisor.quiet::
> >       If set to "true" assume `--quiet` when fetching additional
> >       objects for a partial clone.
> > +
> > +promisor.advertise::
> > +     If set to "true", a server will use the "promisor-remote"
> > +     capability, see linkgit:gitprotocol-v2[5], to advertise the
> > +     promisor remotes it is using, if it uses some. Default is
> > +     "false", which means the "promisor-remote" capability is not
> > +     advertised.
> > +
> > +promisor.acceptFromServer::
> > +     If set to "all", a client will accept all the promisor remotes
> > +     a server might advertise using the "promisor-remote"
> > +     capability. Default is "none", which means no promisor remote
> > +     advertised by a server will be accepted. By accepting a
> > +     promisor remote, the client agrees that the server might omit
> > +     objects that are lazily fetchable from this promisor remote
> > +     from its responses to "fetch" and "clone" requests from the
> > +     client. See linkgit:gitprotocol-v2[5].
>
> I wonder a bit about whether making this an option is all that sensible,
> because that would of course apply globally to every server that you
> might want to clone from. Wouldn't it be more sensible to make this
> configurabe per server?

It depends. If, for example, you are in a corporate environment where
you will interact only with trusted servers, then it might be easier
to have only one option and configure it once for all the servers you
are going to interact with. I am Ok to also have an option
configurable per server in the future though.

> Another question: servers may advertise bogus addresses to us, and as
> far as I can see there are currently no precautions in place against
> malicious cases.

The commit message says:

"In a following commit, other values for "promisor.acceptFromServer" will
be implemented, so that C will be able to decide the promisor remotes it
accepts depending on the name and URL it received from S."

and indeed as you noticed in your review of patch 4/4, this concern is
addressed by patch 4/4.

> The server might for example use this to redirect us to
> a remote that uses no encryption, the Git protocol or even the "file://"
> protocol. I guess the sane thing here would be to default to allow
> clones via "https://" only, but make the set of accepted protocols
> configurable.

Yeah, it is another potential config option that could be added. At
this stage I don't want to send a lot of patches with a large number
of possibly useful configuration options as it might appear later that
very few are actually used and useful.

> > diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotoc=
ol-v2.txt
> > index 414bc625d5..65d5256baf 100644
> > --- a/Documentation/gitprotocol-v2.txt
> > +++ b/Documentation/gitprotocol-v2.txt
> > @@ -781,6 +781,60 @@ retrieving the header from a bundle at the indicat=
ed URI, and thus
> >  save themselves and the server(s) the request(s) needed to inspect the
> >  headers of that bundle or bundles.
> >
> > +promisor-remote=3D<pr-infos>
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +The server may advertise some promisor remotes it is using or knows
> > +about to a client which may want to use them as its promisor remotes,
> > +instead of this repository. In this case <pr-infos> should be of the
> > +form:
> > +
> > +     pr-infos =3D pr-info | pr-infos ";" pr-info
>
> Wouldn't it be preferable to make this multiple lines so that we cannot
> ever burst through the pktline limits?

LARGE_PACKET_MAX is 65520 which looks more than enough to me. So
having the pktline limit could actually prevent malicious servers from
sending too much junk.

I wouldn't be against multiple lines if there were reasonable cases
where the current pktline limit might not be enough (or if such cases
appeared in the future) though. It's just that I can't think of any
such reasonable case.

> > +     pr-info =3D "name=3D" pr-name | "name=3D" pr-name "," "url=3D" pr=
-url
> > +
> > +where `pr-name` is the urlencoded name of a promisor remote, and
> > +`pr-url` the urlencoded URL of that promisor remote.
> > +In this case, if the client decides to use one or more promisor
> > +remotes the server advertised, it can reply with
> > +"promisor-remote=3D<pr-names>" where <pr-names> should be of the form:
>
> One of the things that LFS provides is custom transfer types. It is for
> example possible to use NFS or some other arbitrary protocol to fetch or
> upload data. It should be possible to provide similar functionality on
> the Git side via custom transport helpers, too, and if we make the
> accepted set of helpers configurable as proposed further up this could
> be made safe, too.

It's already possible to use remote helpers using different protocols
with promisor remotes and the URL security issues are addressed by
patch 4/4.

> But one thing I'm missing here is any documentation around how the
> client would know which promisor-remote to pick when the remote
> advertises multiple of them.

In most cases for now, I think the server should advertise only one,
and the client should configure that promisor remote on its own and
set "promisor.acceptFromServer" to "KnownUrl", or maybe "KnownName" in
a corporate setting, (see patch 4/4).

If a server advertises more than one, it should have some docs to
explain why it does that and which one(s) should be picked by which
client. For example, it could say something like "Users in this part
of the world might want to pick only promisor remote A as it is likely
to be better connected to them, while users in other parts of the
world should pick only promisor remote B for the same reason."

> The easiest schema would of course be to
> pick the first one whose transport helper the client understands and
> considers to be safe. But given that we're talking about offloading of
> large blobs, would we have usecases for advertising e.g. region-scoped
> remotes that require more information on the client-side?

If region-scoped means something like the example I talk about above,
then yeah, as also discussed with Junio, this could be an interesting
use case.

> Also, are the promisor remotes promising to each contain all objects? Or
> would the client have to ask each promisor remote until it finds a
> desired object?

I think both use cases could be interesting.

> > +     pr-names =3D pr-name | pr-names ";" pr-name
> > +
> > +where `pr-name` is the urlencoded name of a promisor remote the server
> > +advertised and the client accepts.
> > +
> > +Note that, everywhere in this document, `pr-name` MUST be a valid
> > +remote name, and the ';' and ',' characters MUST be encoded if they
> > +appear in `pr-name` or `pr-url`.
>
> So I assume the intent here is to let the client add that promisor
> remote with that exact, server-provided name? That makes me wonder about
> two different scenarios:
>
>   - We must keep the remote from announcing "origin".

I agree that it might not be a good idea to have something else than
the main remote named origin. I am not sure it's necessary to
explicitly disallow it though.

>   - What if we eventually decide to allow users to provide their own
>     names for remotes during git-clone(1)?

I think it could be confusing, so I would say that we should wait
until a concrete case where it could be useful appear before allowing
this.

> Overall, I don't think that it's a good idea to let the remote dictate
> which name a client's remotes have.

Maybe a new mode like "KnownURL" but where only the URL and not the
name should match could be interesting in some cases then? If that's
the case it's very simple to add it. I just prefer not to do it for
now as I am not yet convinced there is a very relevant use case. I
think that if a client doesn't want to trust and cooperate with the
server at all, it might just be better in most cases for it to just
leave the server alone and not access it at all, independently of
using promisor remote or not.

> > +If the server doesn't know any promisor remote that could be good for
> > +a client to use, or prefers a client not to use any promisor remote it
> > +uses or knows about, it shouldn't advertise the "promisor-remote"
> > +capability at all.
> > +
> > +In this case, or if the client doesn't want to use any promisor remote
> > +the server advertised, the client shouldn't advertise the
> > +"promisor-remote" capability at all in its reply.
> > +
> > +The "promisor.advertise" and "promisor.acceptFromServer" configuration
> > +options can be used on the server and client side respectively to
> > +control what they advertise or accept respectively. See the
> > +documentation of these configuration options for more information.
> > +
> > +Note that in the future it would be nice if the "promisor-remote"
> > +protocol capability could be used by the server, when responding to
> > +`git fetch` or `git clone`, to advertise better-connected remotes that
> > +the client can use as promisor remotes, instead of this repository, so
> > +that the client can lazily fetch objects from these other
> > +better-connected remotes. This would require the server to omit in its
> > +response the objects available on the better-connected remotes that
> > +the client has accepted. This hasn't been implemented yet though. So
> > +for now this "promisor-remote" capability is useful only when the
> > +server advertises some promisor remotes it already uses to borrow
> > +objects from.
>
> In the cover letter you mention that the server may not even have some
> objects at all in the future.

I am not sure which part of the cover letter this refers to. If S uses
X as a promisor remote, then yeah, it might not have some objects that
are on X. But perhaps there is some wrong wording or a
misunderstanding here.

> I wonder how that is supposed to interact
> with clients that do not know about the "promisor-remote" capability at
> all though.

When that happens, S can fetch from X the objects it doesn't have, and
then proceed as usual to respond to the client. This has the drawback
of duplicating these objects on S, but perhaps there could be some
kind of garbage collection process that would regularly remove those
duplicated objects from S.

Another possibility that could be added in the future would be for S
to warn the client that it should be upgraded to have the
"promisor-remote" capability. Or S could just refuse to serve the
client in that case. I don't think we should implement these
possibilities right now, but it could be useful to do it in the
future.

> From my point of view the server should be able tot handle that just
> fine and provide a full packfile to the client. That would of course
> require the server to fetch missing objects from its own promisor
> remotes.

It's what already happens.

> Do we want to state explicitly that this is a MUST for servers
> so that we don't end up in a future where clients wouldn't be able to
> fetch from some forges anymore?

I don't think we should enforce anything like this. For example in
corporate setups, it might be easy to install the latest version of
Git and it might be a good thing to make sure the server doesn't get
overloaded with large files when they are supposed to only be stored
on a promisor remote.

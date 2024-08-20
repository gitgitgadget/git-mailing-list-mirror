Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FCB18637
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 12:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724156505; cv=none; b=MOXmhOTiL24ucz+6ecW5Nt7neYNtKZCbDmqlfpwU0qfw9tdWg+EAkfg1HgW0CWvhKHDv+zOMYoX/qLltrw1ABKgT9u5yYplIIBBB9kXlZiHsZ3aEPYy33WKHtFgTmu3BOipR0zfF+W+jDVVrrqCXiXX8+98PKdy+QLLc30wpHL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724156505; c=relaxed/simple;
	bh=d1b6+sU6HKy7tMWqb1Wa9Ydrhl0RcKcOvUjAUbmvFmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbatL0Vhz+WWYvab+1Mpvc1PEJMMZ8Ce2YNfkgzjmY9Anga/FrYO7GaR+gbxVcPY0vP0R1GMNxAjKrO+zqTLsW3VUDBTY24uLchpKwliAkrMo8j4uyTktFq7FA/Je0/xDEQaVqiM+MrCJHsFzOJlzvnjAIPholR+Ppcyxa5tAuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjbFaSB4; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjbFaSB4"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8657900fc1so48440066b.1
        for <git@vger.kernel.org>; Tue, 20 Aug 2024 05:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724156501; x=1724761301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UROvpyAOfKzNEjN6CeVZMsDS26bZEaAEKtULSejZ9J4=;
        b=DjbFaSB4Zi+sXg2JVbgl62IEyepxPH4TErud1HuhEx26jiVh349DnqivXfYL1hDuXG
         zG52cDPfw18rzZrhiscpjGhgEUpwi294tWXtkHZRS+Nveelos/fHvLNM5ihe72vBE85u
         +c0OwKhLQJQu+fLXn23XkFtWNl+VQVSjdVOMZSsDhGN4kYLcM0AXkB7xl8WELgEHqCNE
         G0kxLLqKy/AxcHRQG5sEhqm67yH00SRiSuBqCZuIkHKGbEgoeEN9xIe10yQ7oenSrh4x
         Rl+EMVnxbAMWQrJvKNP9e8XI6ThownyBNWcBHp9d7qIQVvgjcnj4xvQiWQUB3qk+zm66
         5JEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724156501; x=1724761301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UROvpyAOfKzNEjN6CeVZMsDS26bZEaAEKtULSejZ9J4=;
        b=X5/cJClB5M1Gz9jYAEv4DqgU3bBubrzxPFjVznaI3Ou1YDmZi/G6a3VVsiGbPWxv3a
         UavkPkPnrzT3qfYZEV3OAgFtPRBV5Rqm90DJM+W0IzZ+Tkn9ynH5MVPH40U3h+qQXFuC
         K8M7BLNDPjHXRW0OuYrMurHZadvekkfsyIYBQPzTLlgBQqoiuO2DivkNhMnuxxCZhLGP
         D7VYk6fr+o7MJDcWz0W6IADkt+F5F/9Vdz+mG/fWCKHddAVepa/LUx5jOV64BflWBYC8
         TIrwvbe8hUOwhaKXgy4DxmI6WBsdBuQjtFmHX9lYaRTbN6A59zVfHvfL1pavuM1f6MG4
         SCMA==
X-Gm-Message-State: AOJu0YyW390chAghCJ6rIIdTUvbHLcWAXyC+w4j8LLpgo2clKtGTCT8T
	j3+z5F0OSdhVDQjwZL95HlsaMtFivcjMRwysve/x+R7/9Rm2ShWwzfWPJGTHNuAcRnfQqIV8dTe
	hvXSLVn6bgtPJ4KxaAOBroEa/BHs=
X-Google-Smtp-Source: AGHT+IGhj0dtnoxUr6iM8ptw3ySVC2Y+meR0VM4qG0QVA6aXFTJWsCSvYQLOb9d87Udw+/9BfnBV4Bz+UwUe5OT8TMw=
X-Received: by 2002:a17:907:94cd:b0:a80:f7a7:5e39 with SMTP id
 a640c23a62f3a-a83928a985fmr907115066b.3.1724156500683; Tue, 20 Aug 2024
 05:21:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731134014.2299361-1-christian.couder@gmail.com>
 <20240731134014.2299361-4-christian.couder@gmail.com> <xmqqikwl2zca.fsf@gitster.g>
In-Reply-To: <xmqqikwl2zca.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 20 Aug 2024 14:21:28 +0200
Message-ID: <CAP8UFD2kJcus07nO86=Kn7Hkb4z-B+FeEuxJNLRY4SguVtRX-Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] Add 'promisor-remote' capability to protocol v2
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 8:25=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > When a server repository S borrows some objects from a promisor remote =
X,
> > then a client repository C which would like to clone or fetch from S mi=
ght,
> > or might not, want to also borrow objects from X. Also S might, or migh=
t
> > not, want to advertise X as a good way for C to directly get objects fr=
om,
> > instead of C getting everything through S.
>
> If S is a clone that is keeping up to date with X, even if it does
> not borrow anything from X, as long as X is known to be much better
> connected to the world (e.g., it is in a $LARGEINTERNETCOMPANY
> datacenter with petabit/s backbone connections) than S is (e.g., it
> is my deskside box on a cable modem), it may be beneficial if S can
> omit objects from its "git fetch" response to C, if C is willing to
> fill the gap using X.
>
> So it is of dubious value to limit the feature only to cases where S
> "borrows" from X, is it?

I agree. I just blindly copied the word from something you said in a
previous thread, but I should have thought more about the use case you
suggest.

> > To allow S and C to agree on C using X or not, let's introduce a new
> > "promisor-remote" capability in the protocol v2, as well as a few new
> > configuration variables:
> >
> >   - "promisor.advertise" on the server side, and:
> >   - "promisor.acceptFromServer" on the client side.
> >
> > By default, or if "promisor.advertise" is set to 'false', a server S wi=
ll
> > advertise only the "promisor-remote" capability without passing any
> > argument through this capability. This means that S supports the new
> > capability but doesn't wish any client C to directly access any promiso=
r
> > remote X S might use.
>
> I would find it more natural if .advertise is turned off by setting
> it explicitly to "false", we would pretend as if we have never even
> heard of such a capability.

In a reply to Taylor I just sent, I tried to explain why I think it's
a good thing that S can know if C has the capability even if neither S
nor C actually use it.

If, in the future, many servers and repos are transitioned to setups
where promisor remotes and this capability are used, then I think it
could help a lot if S can help C take advantage of X, and better
diagnose issues. And perhaps the other way around (C knowing that S
has the capability or not) could help a bit too.

> > If "promisor.advertise" is set to 'true', S will advertise its promisor
> > remotes with a string like:
> >
> >   promisor-remote=3D<pm-info>[;<pm-info>]...
> >
> > where each <pm-info> element contains information about a single
> > promisor remote in the form:
> >
> >   name=3D<pm-name>[,url=3D<pm-url>]
> > where <pm-name> is the name of a promisor remote and <pm-url> is the
> > urlencoded url of the promisor remote named <pm-name>.
>
> OK, so pm-name cannot have ";," in it (which is sensible, or define
> pm-name more tightly, like "only lowercase alnum").

Not sure what our config allows here. Ideally I think the capability
should support everything our config supports.

>  URL cannot have
> ';' or ',' in it that is an OK limitation as URL encoding can hide
> them.

Yeah, right.

> > For now, the URL is passed in addition to the name. In the future, it
> > might be possible to pass other information like a filter-spec that the
> > client should use when cloning from S, or a token that the client shoul=
d
> > use when retrieving objects from X.
>
> OK.  And obviously they cannot have ';," in them without encoding
> similarly.

Yeah, or maybe using a different encoding if it's better for some reason.

> > It might also be possible in the future for "promisor.advertise" to hav=
e
> > other values like "onlyName", so that no URL is advertised.
>
> Saying "<pm-info> is expected to be extended" should be sufficient,
> without inviting discussions like "what good does it do to give only
> names" that is irrelevant at least at this moment.

Yeah, but in this case Taylor had comments related to advertising
remotes that have a name but no URL, so I think this example could
help people having related questions understand that it could be a
good thing to advertise only a URL name and no URL.

> > By default or if "promisor.acceptFromServer" is set to "None", the
> > client will not accept to use the promisor remotes that might have been
> > advertised by the server. In this case, the client will advertise only
> > "promisor-remote" in its reply to the server. This means that the clien=
t
> > has the "promisor-remote" capability but decided not to use any of the
> > promisor remotes that the server might have advertised.
>
> OK, that is a signal to the server side that it is not allowed to
> omit any objects from its response to "git fetch" request, even
> though they might be available via a better connected remotes.

Yeah, right.

> > If "promisor.acceptFromServer" is set to "All", on the contrary, the
> > client will accept to use all the promisor remotes that the server
> > advertised and it will reply with a string like:
> >
> >   promisor-remote=3D<pm-name>[;<pm-name>]...
> >
> > where the <pm-name> elements are the names of all the promisor remotes
> > the server advertised.
>
> So, this is why we need "name" for each "pm-info"---to give a short
> name associated with the URL of the remote repository.

Yeah, I think it can be valuable to use names to agree on
promisor-remotes that should or shouldn't be used, like we commonly
use remote names with `git clone`, `git fetch`, etc.

> Presumably, C has an option to see if each of the remote suggested
> is reachable and omit remotes that are not available to C from its
> response, so even when .accept is set to "all", the response may not
> list all the names of remotes that S advertised, in general.

I didn't think about reachability or connectivity specifically, but I
agree it might be useful for C to be able to filter in some ways the
promisor remotes that S advertised.

> > If the server advertised no promisor remote
> > though, the client will reply with just "promisor-remote".
>
> In other words, at the protocol level:
>
>  - S uses promisor-remote capability to tell C what are potentially
>    useful alternate remotes to obtain objects that C may want to
>    fetch from S
>
>  - C uses promisor-remote capability to tell S that among the
>    remotes advertised by S, it is willing to use the named remotes
>    as its promisor, which permits S from omitting objects from its
>    response to "git fetch" request from C as long as they are known
>    to be available from these remotes.

Yeah, right.

> I think that makes sense, but I do not see the point of sending an
> empty promisor-remote capability at all.

I hope I gave good enough reasons above and in my replies to Taylor.

> What practical difference would it make to S and C, if S chooses not
> to advertise the capability at all, instead of advertising an empty
> remote list with the capability?  Both tells C that it is useless to
> request promistor-remote capability to S in its response.
>
> What practical difference would it make to S and C, if C chooses not
> to advertise the capability at all, instead of advertising an empty
> remote list with the capability?  Both tells S that S is not allowed
> to omit objects that are obtainable from elsewhere.

I agree that when looking at how Git related things technically work,
it doesn't change anything, but I think we should look at the big
picture too. For GitLab, for example (but I suppose it will be similar
for GitHub and other hosting sites), it will be important to help
users take advantage, as seamlessly as possible, of the feature, and
the more we know about the client they use and its capabilities, the
better job we can do to help them.

> > In a following commit, other values for "promisor.acceptFromServer" wil=
l
> > be implemented so that the client will be able to decide the promisor
> > remotes it accepts depending on the name and URL it received from the
> > server. So even if that name and URL information is not used much right
> > now, it will be needed soon.
>
> OK.
>
> > diff --git a/Documentation/config/promisor.txt b/Documentation/config/p=
romisor.txt
> > index 98c5cb2ec2..e3939d83a9 100644
> > --- a/Documentation/config/promisor.txt
> > +++ b/Documentation/config/promisor.txt
> > @@ -1,3 +1,16 @@
> >  promisor.quiet::
> >       If set to "true" assume `--quiet` when fetching additional
> >       objects for a partial clone.
> > +
> > +promisor.advertise::
> > +     If set to "true", a server will use the "promisor-remote"
> > +     capability, see linkgit:gitprotocol-v2[5], to advertise the
> > +     promisor remotes it is using if any. Default is "false", which
> > +     means no promisor remote is advertised.
>
> Even though I said that there logically is not much reason to tie
> this advertisement to the use of promistor remote by the serving
> side, I am OK if the initial implementation is limited to that
> arrangement.  It would be an easy change to allow this variable
> to take a list of remote repositories that may (or may not) be a
> promisor remote of this repository (in other words, "they are clones
> that are better connected than me") in the future, but that does not
> have to happen in the initial iteration.

Yeah, I will mention something like this in the next iteration.

> It would be less confusing to first-time readers if you described
> the intent a bit better.  Why would the server want to advertise and
> how would the client take advantage of the information?

Yeah, I will try to better answer that question in the doc, cover
letter and commit messages.

> I see that
> the update in this patch to protocol document is skimpy on this point,
> and end-user facing documentation has better exposure anyway, so
> let's see what we can do here.
>
>     The "promisor-remote" protocol capability can be used by the
>     responder to "git fetch" to advertise better-connected remotes
>     that the requester can use as promisor remotes, instead of this
>     repository, so that "git fetch" requestor can lazily fetch
>     objects from these other better-connected remotes.  If this
>     configuration variable is set to "true",...
>
> or something, perhaps?

Thanks for the suggestion. I will base the changes in version 2 on it.

> "no promisor remote is advertised" -> "no promisor-remote capability
> is advertised".

Right.

> > +promisor.acceptFromServer::
> > +     If set to "all", a client will accept all the promisor remotes
> > +     a server might advertise using the "promisor-remote"
> > +     capability, see linkgit:gitprotocol-v2[5]. Default is "none",
> > +     which means no promisor remote advertised by a server will be
> > +     accepted.
>
> Similarly, readers would want to know what the implication is to
> "accept" promisor remotes.
>
>         accept ..., and adds them to its promisor remotes, allowing
>         the server to omit objects from its response to "fetch"
>         requests that are lazily fetchable from these promisor
>         remotes, see linkgit:gitprotocol-v2[5].
>
> or something?

Thanks for the suggestion. I will improve the wording based on it.

> > diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotoc=
ol-v2.txt
> > index 414bc625d5..4d8d3839c4 100644
> > --- a/Documentation/gitprotocol-v2.txt
> > +++ b/Documentation/gitprotocol-v2.txt
> > @@ -781,6 +781,43 @@ retrieving the header from a bundle at the indicat=
ed URI, and thus
> >  save themselves and the server(s) the request(s) needed to inspect the
> >  headers of that bundle or bundles.
> >
> > +promisor-remote=3D<pr-infos>
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +The server may advertise some promisor remotes it is using, if it's OK
> > +for the server that a client uses them too. In this case <pr-infos>
> > +should be of the form:
>
> As this is the protocol documentation, we should describe what goes
> over the wire and what they mean, regardless of how limited the
> initial implementation on either end is.  Advertising the promisor
> remotes the server side relies on is probably not what we want to
> see this capability limited to forever (remember the previous "X is
> much better connected than S" example).
>
>     "it is using, if it's OK ..." -> "the other side may want to use
>     as its promisot remotes, instead of this repository"

Right, thanks.

> > +     pr-infos =3D pr-info | pr-infos ";" pr-info
> > +
> > +     pr-info =3D "name=3D" pr-name | "name=3D" pr-name "," "url=3D" pr=
-url
> > +
> > +where `pr-name` is the name of a promisor remote, and `pr-url` the
> > +urlencoded URL of that promisor remote.
>
> Clarify what the syntax for a valid name here.  Also stress the fact
> that ';' and ',' MUST be encoded if it appears in 'pr-url'.

Yeah, I will do that.

> > +In this case a client wanting to use one or more promisor remotes the
> > +server advertised should reply with "promisor-remote=3D<pr-names>" whe=
re
> > +<pr-names> should be of the form:
> > +
> > +     pr-names =3D pr-name | pr-names ";" pr-name
> > +
> > +where `pr-name` is the name of a promisor remote the server
> > +advertised.
>
> After seeing advertisement, client can use some it picked but it
> does not have to tell the server about it.  Why would it respond
> with the promisor remotes, and what effect does it have to give the
> list of promisor remotes it uses?
>
>     If the "git fetch" side decides to use one or more promisor
>     remotes advertised, it can reply with ...
>     ...
>     where ... the server advertised.  Doing so allows the server to
>     make its response smaller by omitting objects that are known to
>     be lazily fetchable from these other promisor remotes
>     repositories.
>
> perhaps?

Yeah, right.

> > +If the server prefers a client not to use any promisor remote the
> > +server uses, or if the server doesn't use any promisor remote, it
> > +should only advertise "promisor-remote" without any value or "=3D" sig=
n
> > +after it.
>
> It should not advertise "promisor-remote" capability at all.

Let's discuss this above or in a thread started by Taylor's reviews.

> > +In this case, or if the client doesn't want to use any promisor remote
> > +the server advertised, the client should reply only "promisor-remote"
> > +without any value or "=3D" sign after it.
>
> Likewise.  It should not advertise "promisor-remote" capability at
> all.
>
> > +The "promisor.advertise" and "promisor.acceptFromServer" configuration
> > +options can be used on the server and client side respectively to
> > +control what they advertise or accept respectively. See the
> > +documentation of these configuration options for more information.
>
> OK.

Thanks for the review and suggestions.

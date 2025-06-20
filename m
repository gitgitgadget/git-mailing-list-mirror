Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFFE2E6139
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 16:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750435976; cv=none; b=tQOrjOUTgpe7X4RUC5AANq2eXOyG2d2klqHj/G5rYC9pJJzPVpF1JWROt0jWPVfPsy6BEwktBzVcdhBr/MW2gFJ8ct2R+R0yo5UdijRh0EpFy1aubb14TTp9q+Zv+BnFEVw/c1XT3uRQFSQtMT/dhWNsiaFclAJe3qD2c5NNLp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750435976; c=relaxed/simple;
	bh=6RA2Zt5GhQxA/++dGZLr9XXTT9w3NQYLytTYQVv9Ygc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LerXFE4RSFgy5a/J7ia+lovinUReGbId/9p6THL4eIH0HsKg9TJ+r3ZrBhCqBLHYsCUJs6ZsFhQW6kNHJpeCdAg+FFFAYoj3A1Zqv7LMwP+fWTDDFbV8BlDEoEBa5MrUwtFlXa2JGpM3aDYOQFGX9YAmr9C8DzUZll8CrvvbP6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpkXHRMX; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpkXHRMX"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ade48b24c97so332174966b.2
        for <git@vger.kernel.org>; Fri, 20 Jun 2025 09:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750435970; x=1751040770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3uJy+DYqRHHQyQYaJA+z6sGRW4z5v7b2GUCJubPu6K4=;
        b=BpkXHRMX/uVT5HxxqimWlDwusqICZwYy/dqM1zlfJDCKDiEE4zywZbG2VuAziBG5QP
         iCJRafsA94N3+SvGeXYvIU5ayyF9MnCkDIKE6ldPAiexvMve2GDoFQHxAsuEhCGWJ46p
         IJ7xrQFoP+qGMtSLXmV8P5u+AYR8guFrg6syJjrPAj2DQUGYmBx9d6SZBaTtQl28xiz3
         5VSICQbZu7cPA58OJEhrTvPfiI/1Vycu+DvhWriwEjM6e6kBKKGofkt1OtbAfIwn6Xt9
         Ly1/pw+YRkiRBL3swooRRwgUl6PdUheuUL0DfbHaLZ9Mp3Zb4EmPjbGESIhJ5Mw+ClLx
         kMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750435970; x=1751040770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3uJy+DYqRHHQyQYaJA+z6sGRW4z5v7b2GUCJubPu6K4=;
        b=ovBu7B541l6y4ZI8QdAb9FgMIbOJYTN9PuiypjjWawMd52/jq8OK46EQR9Fg15i/aW
         fFhCMfqaXHTd3oM+IBa1/yrox/fZhRA9LzPpZNpnkBwAkfpzrNRqBWdhDjWd5NoqZuH9
         nVHNHdO6ya/48j8k9J1TFSnBCHRFRWApPaZCpk8F82mIl7p1G40Ivz6N9efLdc4bAlig
         bXzpHqWg5KER91I3jfZpHSIrbEoaPW88kY6AQZzQAS2oHGTUpwRUcNMawwLEO2vvgqPP
         kVcVUAoPX084aZV9GMesWIczm3gD36y899egLuH1ANWYl05Op74fft4zZ9Cvd7pYvgqZ
         gHtg==
X-Gm-Message-State: AOJu0YyKZvc42041zLSItmvsGReBbicx0eeFXJgUXoBbsIfGAoJqL9Dv
	s7OUAkAIKCp5G3ajCyqTDKoIAOmgJn3oM7ylFfuzHYdNxddK4My78h9SFopETVmwoUp6CJFIi1+
	hdCbDg5CdFK4K//Ixf8Ki0sBn1E5kO7M=
X-Gm-Gg: ASbGnctR6dC5c5ZdQHYF/I5QcUBUdzN/fpHHSjJ4Pg0rtu+LwWB5YGbGvqg9jDwQ8yK
	hmAzFeUEm3HFei6DTNXVYNrHc0qePrhR0JFiWjV+ZAbnjGcjd5Wtpkwx05YhjsfomQB4lzgumIc
	zIpJDAIc9qrR3LaV9VNAyzI+DONllMNYzuKrYn5cUVZ6rlsMUJzdOSuZYl
X-Google-Smtp-Source: AGHT+IGU8dYU5vn7q/1SXsZi1/pkaAUGV8e8+57R6KgTnxsu6llopVvrqoOsGK6GrwymgjjyiDDHPDv8YUrqid8FVSg=
X-Received: by 2002:a17:907:9809:b0:ad8:9c97:c2eb with SMTP id
 a640c23a62f3a-ae0579c1161mr363567666b.19.1750435969796; Fri, 20 Jun 2025
 09:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618151821.528627-1-christian.couder@gmail.com>
 <20250619133630.727274-1-christian.couder@gmail.com> <CABPp-BF6ZjfJ2MSHkhXQwv00=63qG3wLU8ie=_WVxnWTffFpRA@mail.gmail.com>
In-Reply-To: <CABPp-BF6ZjfJ2MSHkhXQwv00=63qG3wLU8ie=_WVxnWTffFpRA@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 20 Jun 2025 18:12:36 +0200
X-Gm-Features: Ac12FXxSG-WyBVWfzxbHP6kKbmV9wlsks7EPSR3Ck9EFqVUH35CC1umhwZgl_K8
Message-ID: <CAP8UFD24LayEi-=PREqbiyC7PeJbYEP1ghOZ+T-ma=DZVaPtSg@mail.gmail.com>
Subject: Re: [PATCH v4] fast-(import|export): improve on commit signature
 output format
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 11:44=E2=80=AFPM Elijah Newren <newren@gmail.com> w=
rote:
>
> On Thu, Jun 19, 2025 at 6:36=E2=80=AFAM Christian Couder
> <christian.couder@gmail.com> wrote:

> > However, this implementation has a number of limitations:
> >
> >   - the output format was not properly described in the documentation,
>
> Thanks for working on fixing this.
>
> >   - the output format is not very informative as it doesn't even say
> >     if the signature is an OpenPGP, an SSH, or an X509 signature,
>
> Why would it need to say what type of signature it is?  Don't the
> ascii armor lines have e.g. "----BEGIN PGP SIGNATURE----" and "----END
> PGP SIGNATURE----" around it, which fast-import can read as well as
> fast-export?  Is the idea that we strip those lines and now need to
> replace the information we lost?

In https://lore.kernel.org/git/aAq1nvcPRlIPal5l@tapette.crustytoothpaste.ne=
t/
brian said:

"These should be separate fields: one for the hash algorithm and one for
the protocol.  Alternatively, we can just keep the hash algorithm field
and parse the protocol by reading the first line, which will differ for
different protocols."

It would have been nice if you had then said that you prefer not to
have the protocol.

My opinion was that it was better for tools processing fast-export
output to have the protocol as they have to parse the "gppsig ..."
line anyway. So it should be easier for them than to parse the ascii
armor lines.

> >   - the implementation doesn't support having both one signature on
> >     the SHA-1 object and one on the SHA-256 object.
>
> Not sure I understand this; more questions around this later.

In https://lore.kernel.org/git/aD4i7YhUnT5Kgew-@tapette.crustytoothpaste.ne=
t/
brian said:

"Actually, what I was saying is that we should have one for the hash
algorithm that is used in the Git object.  I don't care about the hash
algorithm used in OpenPGP, X.509, or OpenSSH (that is, whether it's
signed with SHA-512 or SHA-256), but we can have multiple signatures in
a single commit such that there's both a SHA-1 signature and a SHA-256
signature."

so I implemented the possibility that there's both a SHA-1 signature
and a SHA-256 signature in a single commit.

If you disagreed with what brian suggested, it would have been nice to
reply to brian then.

> > Let's improve on these limitations by improving fast-export and
> > fast-import so that:
> >
> >   - both one signature on the SHA-1 object and one on the SHA-256
> >     object can be exported and imported,
> >   - if there is more than one signature on the SHA-1 object or on
> >     the SHA-256 object, a warning is emitted,
> >   - the output format is "gpgsig <git-hash-algo> <signature-format>",
> >     where <git-hash-algo> is the Git object format as before, and
> >     <signature-format> is the signature type ("openpgp", "x509",
> >     "ssh" or "unknown",
> >   - the output is properly documented.
>
> Perhaps this was discussed in an earlier round, but if so I either
> forgot or missed it.  What value does <git-hash-algo> and
> <signature-format> provide?  How are they intended to be used?

My opinion on this is that in cases like this we might not always know
what could be useful for tools or users in general, so it might be
better to provide more information that can be easily discarded if not
useful rather than not enough information.

brian seemed to say that <git-hash-algo> and <signature-format> are
important so I just prefered to have both, especially as they are not
costly to get.

> Is the <signature-format> merely self-inflicted pain from stripping
> the ascii armor lines?  If so, would it make more sense to just
> include those armor lines as-is in the fast-export stream and let
> fast-import process it?

The ascii armor lines are kept in the fast-export stream, but
fast-export's ouput is supposed to be processed somehow sometimes
before being fed back to fast-import, so I think we should make it
easy for tools or people processing the output to get signature
information.

>  Then we wouldn't have to introduce all the
> outputting and parsing of this new <signature-format> field and worry
> about the new special "unknown" status.

I think it's a trade-off. If there is a consensus that it's very
unlikely to help anyone, I am fine with removing it.

> Is the <git-hash-algo> due to the fact that we have separate `gpgsig`
> and `gpgsig-sha256` commit headers and we want to use that information
> to avoid writing these headers to the wrong-sized objects (and/or to
> avoid checking whether the signature is valid on the wrong-sized
> objects)?

Yeah, I think it could help with that, but brian might better answer that.

> If so, could that be spelled out in the docs as well,
> especially since it appears that the intent of these headers is left
> unimplemented due to not changing fast-import to do anything with
> them?

fast-import puts back the `gpgsig` or `gpgsig-sha256` headers
depending on <git-hash-algo>, so it's useful at least for that. I will
improve the docs about it.

> And if <git-hash-algo>'s purpose is to ensure they are only used when
> writing same-sized object as what was exported, then...isn't that a
> bug?

I am not sure I understand what would be the bug.

> This series was started because people wanted to be able to do
> things like keeping signature even when they are no longer valid or
> resigning commits that have a no longer commit signature (among other
> uses), but that would mean that if someone exports a sha1 repository
> and imports it as sha256, we don't want to ignore the fact that the
> sha1 commit was signed for those usecases.
>
> If, however, the <git-hash-algo>'s purpose is merely as a performance
> optimization that fast-import can employ in the cases where it checks
> for signatures being valid, so it can avoid checking when it know the
> hash size isn't even the same, then it could make sense.

I think it could be used for that, but I'd like brian's opinion about this.

> But, short of that performance optimization, it's unclear to me
> whether we'd lose anything by simply exporting "gpgsig <contents of
> signature header from original object, including the armor lines>",
> and dropping the <git-hash-algo> and <signature-format> lines
> entirely.  Am I missing something?  (I may well be; I don't know much
> about signing stuff beyond the very basics, and don't mess with signed
> commits or tags much myself.)

I don't know much about signing either, that's why I have tried to
rely on brian's suggestion on this.

> [...]
> > There are no tests in this v4 and in v3 with both a SHA-1 and a
> > SHA-256 signature on the same commit though, as I am not sure yet how
> > to best generate a commit with such signatures. Suggestions welcome!
>
> If no suggestions are forthcoming, it feels odd to implement this with
> no tests.  Would it make sense to leave it out until we know how to
> test it?  (More questions on this below...)

I had hoped that implementing this and then asking how best to test
with both a SHA-1 and a SHA-256 signature on the same commit would be
better to move things forward.

> > +Currently for a given commit, at most one signature for the SHA-1
> > +object and one signature for the SHA-256 object are exported, each
> > +with their respective <git-hash-algo> identifier.
>
> Wait..does this mean fast-export is obligated to walk over both all
> sha1 commits and all "equivalent" sha256 commits when exporting a
> repo?  I thought most operations on the repo would walk over only one
> or the other; walking over both seems to be against the spirit of the
> "fast" in "fast-export".  Am I missing something?  (Possibly related
> question: Does "git log" bother walking over both, or does it only
> walk over one?)  Even if this really is wanted by some users,
> shouldn't they manually request it rather than making exports slow for
> everyone else by default?

No fast-export doesn't walk over both the sha1 commits and all
"equivalent" sha256 commits, it can just process at most 2 signatures
for a given commit, one with the `gpgsig` header and one with the
`gpgsig-sha256` header. I will try to reword the doc to make it
clearer.

> > +A warning is
> > +emitted for each additional signature found.
>
> Why?  This seems odd to me.  Why not merely export them all, and let
> fast-import throw warnings or errors if it sees more than one and is
> not yet prepared to handle multiple signatures?

I am not against implementing both export and import support for any
number of signatures, but it seems that Git in general doesn't support
more than one `gpgsig` and one `gpgsig-sha256` signature well, and
that's also what brian suggested supporting. It's also better than
just 1 signature max which is the current state.

> > -Here <alg> specifies which hashing algorithm is used for this
> > -signature, either `sha1` or `sha256`.
> > +....
> > +       'gpgsig' SP <git-hash-algo> SP <signature-format> LF
> > +       data
> > +....
> > +
> > +The `gpgsig` command takes two arguments:
> > +
> > +* `<git-hash-algo>` specifies which Git object format this signature
> > +  applies to, either `sha1` or `sha256`.
> > +
> > +* `<signature-format>` specifies the type of signature, such as
> > +  `openpgp`, `x509`, `ssh`, or `unknown`.
> > +
> > +A commit may have at most one signature for the SHA-1 object format
> > +(stored in the "gpgsig" header) and one for the SHA-256 object format
> > +(stored in the "gpgsig-sha256" header).
>
> Why?  Does this mean hg-fast-export or hg-fast-import (or a
> jj-fast-export or jj-fast-import) wouldn't be allowed to specify
> multiple signatures?  The fast-export and fast-import streams are
> often used for interoperation with other VCSes, but as far as I can
> tell, you're encoding a restriction on what's allowed that isn't an
> actual problem for git but just a not-yet-implemented state.

I would be fine with rewording this to say that the current
implementation allows at most one signature for the SHA-1 object
format and one for the SHA-256 object format to be imported. But as
far as I understand additional signatures on top of that might not be
very well supported by Git in general, so maybe I should mention that
too?

> If I've
> understood correctly that the restriction is merely due to the current
> implementation, perhaps the wording could be changed to not list it as
> an encoding restriction, but as a current fast-import limitation?

If that current fast-import limitation was lifted, we should probably
still say that additional signatures might not be very well supported
by Git in general.

> Also, I'm slightly uncomfortable with "the SHA-1 object format" and
> "the SHA-256 object format" because of the fact that these tools are
> used for interoperability with similarly-named tools from other VCSes.
> I think it'd be better to just treat them equally as "here was/were
> some signature(s) on the object in the original repo; importers can
> choose what to do with them".

I don't think giving that information prevents tools from other VCSes
from doing what they want with the signatures.

> > +See below for a detailed description of the `data` command which
> > +contains the raw signature data.
> > +
> > +Signatures are not yet checked in the current implementation though.
>
> ...but what does happen with those signatures?  Dropped?  Kept as-is?

This section (about the `gpgsig` command) starts with:

"The optional `gpgsig` command is used to include a PGP/GPG signature
that signs the commit data."

so yeah they are kept as-is.

> Can we just spell this out a bit more clearly?  e.g.
>
> "Signatures are not checked in the current implementation; they are
> used as-is, which may mean the signatures are invalid in the imported
> repository."

It feels a bit redundant but, yeah, the part about possibly invalid
signatures might clarify things, so I am fine with spelling it out
like this. Thanks.

[...]

> I briefly skimmed the implementation and test files, and didn't see
> any problems...but I think it probably makes more sense to get aligned
> on the goals of the format and how these fields are meant to be used
> before diving into those details closer.

Yeah, I would have been happy if we could have been aligned with the
goals of the format and the fields earlier, but better late than
never.

> Thanks for working on this topic.

Thanks for reviewing.

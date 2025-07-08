Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4CF3597A
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 09:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751966237; cv=none; b=EsgZGTWlc7u/tjAMe62ylsymSDgxsHn4XXn/woa+g/c07ZiXJIJmqJEUZgSMUfQoEcemWW9xtcgXHkZzXlN3FUpzBq4OkyPuMZL9irIzqsiBp/SlxuK5WlbpmMRrBlUzsz8VQqAtZY0O3B4KFj/e6Jim148+3QTlySoOBDMKmaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751966237; c=relaxed/simple;
	bh=DI24h+pln3vyVWV/BRiIvAI11cL67NnUZeIMpQBfd5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IbDZmakwiV+bRoyP9EaL0NeNrpJW8M+i3ciX553RyFpggL11csuHG+OGTxARlbBiVpPWmj0ZSWrqTH20zdYDxhf1Zsje8FHyiEm/3EGFf4YFrhlHplMFPOcOjpxuC3e8zyyqxIvMlBwve6JGkL3cQQ3az1hRDVIfTX+Q8W233SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLfNEjdY; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLfNEjdY"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60c6fea6742so8597097a12.1
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 02:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751966233; x=1752571033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vo63RKyWyzI1uI/96M9rB7TnIdFvz98F0PQyY/Z6Lb0=;
        b=HLfNEjdYcq2EmoSGfwT3lP1yHnn9nT/PN2P8ibfhT56LwMvrBaaybzjly1cl8VMGa9
         72bPREn9o+OiQeB4PoIRVsSOIw5LatHmLafe2BWCfwGLw6JoY01RW68FpICRUcuzTFyv
         b/P4gTTWML2A+nj2A39eFnIOi+fStgFlQJ45pzZdorCVG9YYhzaGOCIl9lqaLysIgkFA
         OT5XNLx4rbhxt44m7Dup4QkR8FGTgK/JfiOTMQPXZ7Y16OyBOGD7gUT5rBy6EVvo6Fnr
         ww7e9yPS8KHFwjKAB33Sthqs7J6DhEMg1MsnZYcNizvDD6G6A9MMaEdb2tzJ1JipfAw0
         cyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751966233; x=1752571033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vo63RKyWyzI1uI/96M9rB7TnIdFvz98F0PQyY/Z6Lb0=;
        b=T1dxtPzU/qC7ynKkk6nIQ4bRYoslRMPTfCO2xIVh0Sty+WDItml6UL7FgCRoPn/suq
         qFVuRqFwRUaykf17mqEuOHqx9FjLx6rL/t6aO3unn+Ty9DtQZTew9T2jB2XvlgZ0S+UK
         qacQRSZvIAqE6tpAfEGJuURSUWVmckBDc7tGDAFWD0BwYs7okjHbO4HW8XOfnth26rfH
         hOq2r2D4WBzg5FsPpRFARRf5Ws5ImRaZkm7gaKuUr/0SbHhojX1bn4cDSAHAgxsvdlkp
         vf4VZf6DWn2L+QU4Vy4nj4Lh7AGNQEQC9v8YZ2lFNNmyMj6orbSNrWz6SCuaKvqBbCZJ
         F9Pg==
X-Gm-Message-State: AOJu0YwMcnc+9TFGXJ9kSUY7LyyipPLspuhDZA3c0+/j/4bcXtfXUmXN
	rYZj9Zi7a1XnleLCAia6EfulbgxARI6e+vj4QF76V/klmZvpEWOa0MI54rtk1a8rGjEwDK3cqey
	3xih/SunBGf2IGKhxZVdkXQuRSgzcy8OU4Z+S
X-Gm-Gg: ASbGnctCVBYs/hcLiu43eoaIaEPVmPTR30fUD20HPEk6BWRzMJtssIxQDHSN414yZQH
	VT6NA4UBNT2Exrob8isG9Yvfumlwi5HavlqCHTa6PAEGjlczPAAY95Spslw+S1zjD54LvYBJntu
	nvJPwGT/XCrMZKVGjMJyhMcek5HB0v0P0HFI1to1fqxock6EpuIU6hiw2J1DU/PpnTHMBLeZ5TR
	5yV
X-Google-Smtp-Source: AGHT+IGv43SbrBVPzsIivm4KVoJv9yUfqafg6X/U/KxhDbdTbHsdYgK53pkntz8uNL2CXdxl67GzehfTlwYUICGTf9E=
X-Received: by 2002:a17:907:d701:b0:ae3:6708:941c with SMTP id
 a640c23a62f3a-ae6b0048f2amr251148166b.6.1751966232783; Tue, 08 Jul 2025
 02:17:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618151821.528627-1-christian.couder@gmail.com>
 <20250619133630.727274-1-christian.couder@gmail.com> <CABPp-BF6ZjfJ2MSHkhXQwv00=63qG3wLU8ie=_WVxnWTffFpRA@mail.gmail.com>
 <CAP8UFD24LayEi-=PREqbiyC7PeJbYEP1ghOZ+T-ma=DZVaPtSg@mail.gmail.com> <CABPp-BE8b8Ju3zaB04DzQJoSKwNkHcHTw8q95ux_bb4hOpboBg@mail.gmail.com>
In-Reply-To: <CABPp-BE8b8Ju3zaB04DzQJoSKwNkHcHTw8q95ux_bb4hOpboBg@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 8 Jul 2025 11:16:59 +0200
X-Gm-Features: Ac12FXwWAYoo38J3Peg0baYZM6KhYt-5XsB07SxPzl8EAGCCUfhZtUlRGdJuAmg
Message-ID: <CAP8UFD0Xi+9rA+M_0j0gGpyLTmLYB2u5PT2--cRFqqyrV4NFYg@mail.gmail.com>
Subject: Re: [PATCH v4] fast-(import|export): improve on commit signature
 output format
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 9:12=E2=80=AFPM Elijah Newren <newren@gmail.com> wr=
ote:
>
> On Fri, Jun 20, 2025 at 9:12=E2=80=AFAM Christian Couder
> <christian.couder@gmail.com> wrote:

> > In https://lore.kernel.org/git/aD4i7YhUnT5Kgew-@tapette.crustytoothpast=
e.net/
> > brian said:
> >
> > "Actually, what I was saying is that we should have one for the hash
> > algorithm that is used in the Git object.  I don't care about the hash
> > algorithm used in OpenPGP, X.509, or OpenSSH (that is, whether it's
> > signed with SHA-512 or SHA-256), but we can have multiple signatures in
> > a single commit such that there's both a SHA-1 signature and a SHA-256
> > signature."
> >
> > so I implemented the possibility that there's both a SHA-1 signature
> > and a SHA-256 signature in a single commit.
> >
> > If you disagreed with what brian suggested, it would have been nice to
> > reply to brian then.
>
> Sorry about that.  I hadn't read the whole thread; further, I was
> previously trying to avoid the details of signatures beyond the basics
> and hoping to leave those details to others, but between v2 and some
> words you had in this version plus deciding to just take a closer look
> while on vacation (as I was last week), I decided to try to look a bit
> closer.

Thanks for taking a closer look.

> Turns out, though, that despite my attempts to read a bit more
> documentation and code in the project, I still had a fundamental
> misunderstanding last week when I was responding.  I had been assuming
> that the gpgsig headers would appear on sha1-commits and gpgsig-sha256
> headers would appear on sha256 commits.  I didn't understand that both
> types of headers can appear on both types of commits (so that, for
> example, gpgsig-sha256 would be use the sha256-commit as the source
> and sign that data but write the result to a sha1-commit). I talked
> with brian this morning to ask a few questions and he clarified this
> for me.
>
> (Side note: It might be nice to clarify this in
> Documentation/technical/hash-function-transition.adoc; that document
> did not dispel this confusion when I read it last week.)

I agree that it would help to improve that document. I think it's a
separate topic though.

> And the part I didn't understand the first time around is that e.g.
> the SHA-1 commit can include both the signatures on the SHA-1 object
> and on the SHA-256 object.  (Similarly, the SHA-256 commit can include
> both signatures as well.)
>
> > > >   - if there is more than one signature on the SHA-1 object or on
> > > >     the SHA-256 object, a warning is emitted,
>
> This is now ambiguous to me.  more than one signature using the SHA-1
> as source for signing, or more than one signature recorded within the
> SHA-1 commit?  I think you mean the former.

Yes, it's the former. I am not sure there is a simple and short way to
disambiguate these meanings.

> > My opinion on this is that in cases like this we might not always know
> > what could be useful for tools or users in general, so it might be
> > better to provide more information that can be easily discarded if not
> > useful rather than not enough information.
> >
> > brian seemed to say that <git-hash-algo> and <signature-format> are
> > important so I just prefered to have both, especially as they are not
> > costly to get.
>
> So, with my new understanding, <git-hash-algo> is necessary because if
> you only had the gpg signature on a commit object, you don't know what
> it was a signature of -- it might be a signature of that commit
> object, or it might be a signature of it's "compatibility" object
> created with a different git hashing algorithm.

I agree that it's important for this reason.

> So, fast-import --
> regardless of whether it is writing into a sha1 repo or a sha256 repo
> -- won't be able to know how to check the validity of the gpg
> signature unless it knows whether to check the signature of the sha1
> commit or the sha256 commit. And if the repository that fast-import> is w=
riting to isn't writing compatibility objects for interoperation
> at all, then it won't be able to check any compatibility signatures at
> all; it'll only be able to check signatures of the actual object it
> wants to write.

Yeah, right.

> > > Is the <signature-format> merely self-inflicted pain from stripping
> > > the ascii armor lines?  If so, would it make more sense to just
> > > include those armor lines as-is in the fast-export stream and let
> > > fast-import process it?
> >
> > The ascii armor lines are kept in the fast-export stream, but
> > fast-export's ouput is supposed to be processed somehow sometimes
> > before being fed back to fast-import, so I think we should make it
> > easy for tools or people processing the output to get signature
> > information.
>
> Ah, just for convenience of the importer/processor; fair enough.

Yeah, right.

> > > Is the <git-hash-algo> due to the fact that we have separate `gpgsig`
> > > and `gpgsig-sha256` commit headers and we want to use that informatio=
n
> > > to avoid writing these headers to the wrong-sized objects (and/or to
> > > avoid checking whether the signature is valid on the wrong-sized
> > > objects)?
> >
> > Yeah, I think it could help with that, but brian might better answer th=
at.
>
> I think the answer is actually no, this isn't at all what these are
> about.  These are about knowing how to check the validity of the
> signatures, because the signatures aren't necessarily associated with
> the object they were read from; they could be a signature of its
> compatibility object instead.

First I am now not sure what "wrong-sized objects" meant in your
previous sentence. I thought it meant "object using SHA-1 vs object
using SHA-256". In that case, the <git-hash-algo> could indeed help
check the signature on the right object.

Also git fast-import has to recreate the `gpgsig` and `gpgsig-sha256`
commit headers when importing signatures, so <git-hash-algo> can help
it with that too.

> > > If so, could that be spelled out in the docs as well,
> > > especially since it appears that the intent of these headers is left
> > > unimplemented due to not changing fast-import to do anything with
> > > them?
> >
> > fast-import puts back the `gpgsig` or `gpgsig-sha256` headers
> > depending on <git-hash-algo>, so it's useful at least for that. I will
> > improve the docs about it.

In v5, I have improved the fast-import documentation with the following:

* `<git-hash-algo>` specifies which Git object format this signature
  applies to, either `sha1` or `sha256`. This allows to know which
  representation of the commit was signed (the SHA-1 or the SHA-256
  version) which helps with both signature verification and
  interoperability between repos with different hash functions.

* `<signature-format>` specifies the type of signature, such as
  `openpgp`, `x509`, `ssh`, or `unknown`. This is a convenience for
  tools that process the stream, so they don't have to parse the ASCII
  armor to identify the signature type.

The commit message is improved too.

> > > And if <git-hash-algo>'s purpose is to ensure they are only used when
> > > writing same-sized object as what was exported, then...isn't that a
> > > bug?
> >
> > I am not sure I understand what would be the bug.
>
> It's not relevant given my misunderstanding, but to explain what I was
> thinking last week (note that the first two bullets are my mistake):
>
>   * gpgsig headers only occur on sha1 commits and are the signatures
> of the sha1 commit sans the gpgsig header
>   * gpgsig-sha256 headers are similar with respect to sha256 commits
>   * we were using <git-hash-algo> as an optimization to only sign
> commits in fast-import if the repository we were writing to was using
> the same hash function as the repo we were writing from
>
> In such a case, that'd be a bug for anyone that wanted a
> 'resign-commits-that-were-previously-signed-if-the-signature-becomes-inva=
lid'.
> Although a signature of a sha256 commit clearly won't verify if we
> exported a sha256 repo and imported it as a sha1 repo and tried to
> verify that signature using a sha1 commit, that doesn't mean we should
> just ignore the fact that the sha256 commit had a signature.  The user
> clearly expressed the intent to resign any commits that had a
> signature before but where the signature is no longer valid.

I see.

> > > This series was started because people wanted to be able to do
> > > things like keeping signature even when they are no longer valid or
> > > resigning commits that have a no longer commit signature (among other
> > > uses), but that would mean that if someone exports a sha1 repository
> > > and imports it as sha256, we don't want to ignore the fact that the
> > > sha1 commit was signed for those usecases.
> > >
> > > If, however, the <git-hash-algo>'s purpose is merely as a performance
> > > optimization that fast-import can employ in the cases where it checks
> > > for signatures being valid, so it can avoid checking when it know the
> > > hash size isn't even the same, then it could make sense.
> >
> > I think it could be used for that, but I'd like brian's opinion about t=
his.
>
> No, I was just wrong; it can't be used as such a performance
> optimization.  A signature of a sha256 commit stored in a sha1 commit
> (or a signature of a sha1 commit stored in a sha256 commit) isn't
> accidental, it's part of the intentional design of the hash-function
> transition.
>
> But, it might mean that the rules for what to do with signatures in
> fast-import need to be more complex than what I previously
> wrote...which I'll comment on a bit below.

Ok.

> > > Wait..does this mean fast-export is obligated to walk over both all
> > > sha1 commits and all "equivalent" sha256 commits when exporting a
> > > repo?  I thought most operations on the repo would walk over only one
> > > or the other; walking over both seems to be against the spirit of the
> > > "fast" in "fast-export".  Am I missing something?  (Possibly related
> > > question: Does "git log" bother walking over both, or does it only
> > > walk over one?)  Even if this really is wanted by some users,
> > > shouldn't they manually request it rather than making exports slow fo=
r
> > > everyone else by default?
> >
> > No fast-export doesn't walk over both the sha1 commits and all
> > "equivalent" sha256 commits, it can just process at most 2 signatures
> > for a given commit, one with the `gpgsig` header and one with the
> > `gpgsig-sha256` header. I will try to reword the doc to make it
> > clearer.

In v5 all the signatures are exported, so the doc is now:

"While all the signatures of a commit are exported, an importer may
choose to accept only some of them. For example
linkgit:git-fast-import[1] currently stores at most one signature per
Git hash algorithm in each commit."

I hope it avoids misunderstandings.

> Right, but fast-import might need to *write* both sha1 commits and
> sha256 commits (or at least write one of them and keep a mapping
> between the two in memory) in order to correctly verify and process
> both gpgsig headers...or at least, it will be unable to verify
> signatures of compatibility objects if people do not have the
> appropriate extensions.compatObjectFormat config setting set within
> the repository they are importing to.

Yeah, it seems to me that when extensions.compatObjectFormat is set,
then a compatibility mapping between objects can be used. I don't
think using it should be part of this patch though. When I will work
on making it possible for fast-import to check signatures, I will try
to use it to write both sha1 commits and sha256 commits, and check
both signatures.

> This actually expands the usecases I mentioned previously a bit.
> Those usecases were:
>
> (A) Make fast-export include signatures, and make fast-import include
> them unconditionally (even if invalid)
> (B) Similar to (A), but make *fast-import* check them and either error
> out or drop them if they become invalid
> (C) Simliar to (B), but make *fast-import* re-sign the commit if they
> become invalid
> (D) Similar to (A), but make *fast-import* re-sign the commit even if
> the signature would have been valid
>
> Cases (B) and (C) might either need special care or need to bifurcate
> into additional options given that we can have two signatures on a
> commit.  "Validity of gpg signature stored in the commit" now becomes
> "Validity of gpg signatureS stored in the commit".  Whereas before we
> only considered the cases of "no valid signatures" and "all valid
> signatures", we also need to worry about the case where one signature
> is valid and the other is either known to be invalid or simply cannot
> be checked because this repo isn't set up to write compatibility
> objects.

Yeah, I agree that there might be new cases to consider. I don't think
this affects this patch though as long as it allows one signature for
each hash to be exported and imported which is the case.

> > Yeah, I would have been happy if we could have been aligned with the
> > goals of the format and the fields earlier, but better late than
> > never.
>
> I think the proposal for the fields in this version make sense now,
> but it might have been easier to get alignment if (1) we could get
> real testcases of the multiple signature case,

There is such a multiple signature test case in v5.

> and (2) we could see
> the actual code for fast-import to deal with the signatures (trying to
> guess the needs of the importer and the meanings of the fields we
> export is supposed to be is harder when their usage has been left
> unimplemented).  That said, I also understand you wanting to avoid
> implementing too much and throwing things away if we disagreed on
> early decisions.

Yeah, I prefer to move forward step by step on this.

> Anyway, I'm on board with these new fields and their purpose, though
> I'm still curious if we start diverging when we run across surprises
> as we dig further into the implementation.

As we have clearly warned that the current implementation is
experimental, I think we should have more flexibility to adapt the
formats and behaviors if we run across surprises in the next steps.

Thanks for your thoughts and reviews.

Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4176EA927
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749220917; cv=none; b=gwFRDxaqr1jPm2C49EeJemjb7sPc5UQshNX4N/BPMhcXSkDTL58MDkDXg12j+zUPgbhMIdUz/EIhI14HfDDpv1J1UUaR2SiusAAj/KCFE9IJNoADW82esTMSCj+izVQHFOBNJ2d5wSpY+m++QCzS7Fgin3Fduo030rK+Cq9NOUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749220917; c=relaxed/simple;
	bh=cMugRzBc70273etm9sBOxwBDZyiDTnIoOYXU9zXFd98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VrvhfvnbWXYPha7udtHlpidPY3BqILFuVTcksYpIORCInyBml/uiAyq3f/hp1D3PP2e9s51jjH3BXWc2PYUGldfTqknmW/95aYYn809/xPGX30COZVpKnRR7osQJ9VK1hSQzaipJv+aPRjvzIgnU7ZaRxeFxkTDt95gK86SdJcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMu6aJy0; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMu6aJy0"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7d0a2220fb0so247960785a.3
        for <git@vger.kernel.org>; Fri, 06 Jun 2025 07:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749220914; x=1749825714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XU6Pb4rkVm217YPAZfAu5XRHmtrXlPPlCwfo4kSRho=;
        b=lMu6aJy0G/bPq1Xl24ZEi1Pj8UZlk+TglWdpRyPPe4WOEWhtv1TQL7ryxTeNG5INOn
         s8syqmmD1b26XztmeCGJ8k2UeGTphxBH9N8WHZ/n/lRmBt1Qx7WhxqVnyd8IcBRe3nXC
         T3/HcfBNcbGzSuLJnA/qqtgQLB9m/mCgVa5vsJgm6iYxIiyrROkmNI2tGgWvYh9NI0zA
         MW4uy6Wipf1nDLrUAi/gIK4qmYFpZCx/5lrZBDmUzv1CpeEDFZTpB9Uv5MSLHp5lb2RP
         AhJgsl4enHx/YeHTroC193zWieRG1VP437rjHPmVjTt20/PIzap9TPS7Kt8ZXW5Xz9Ja
         Cgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749220914; x=1749825714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XU6Pb4rkVm217YPAZfAu5XRHmtrXlPPlCwfo4kSRho=;
        b=CmmX8gF6Tod/xyIHSxYD50JNV6n0d0gcHJCOOenV4wREmd1ulTTVxntFFQq3n77iKd
         xyJoNF7BUvXeW7nKE3uXqxUbgVOSMGYBNCc1+9uge6qVWOHTMFs1UEVdZXgZw+BbnDBX
         43eDVinOWgZmwOGu+kTpkx2ilbTMEDS4eFyAVK/WOCR7arz1NhiqqU5isIJKhK+z5/B/
         dNpd+hXx1KrfhMYGrV3sOHiSo35icjGkYozeIsK+lALRF7Grv4kNDSgGyMf0bvYrPby7
         PveQyoLqRuzzJBccOuEiaAd18+qZ32gHB1W+8L+7f50+1imIMOruqXqxvxB6Q2rNNcnV
         VM3g==
X-Gm-Message-State: AOJu0YzgcDxkhXBbK8XO3GFO4mFqKprlx2Ogi2FTXlycZUs46RjcYeIs
	7ApMjwmj3pnzVcVXW9m8CJEaHgLSYO8KDKpUZVNscaqEMtKWEqOflOFHwB7jIo/TGUbpB0gEzl0
	Pz6BvA+bF78PaywWluo9y43Njo+7Fk8ymO8uX03A=
X-Gm-Gg: ASbGncuenBcEc6F0+ycFx0wY4Fy8PQN1mOvSOAM5KL71mFXmMSGeOzaN1QjXT6iAvzV
	orUt4WRFK2+djQ1wJbxC+x8lwNq/3FUKzKn3O0gFaeQCrJqarLbJg90+eb41YcVebXNevqK4BZw
	FmYkhaxSLQYwfuroMESAgMdbTU2EYxJ/I2kGjdkkwzbeKx7a++6DHHVbUlOyt/xNic/eQnTHUxo
	Ts=
X-Google-Smtp-Source: AGHT+IE1rPwW6hoaGbCWMSLAaRhp67HsLl9rn2pXoWdTa6HzF2zKbc4aMk67YqmpUNkxfRse9jX/RuK0XS23Z8wLjB8=
X-Received: by 2002:a05:620a:800b:b0:7c7:9379:9190 with SMTP id
 af79cd13be357-7d2298d850amr545369285a.49.1749220913982; Fri, 06 Jun 2025
 07:41:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524073628.58944-1-jayatheerthkulkarni2005@gmail.com>
 <20250524073628.58944-3-jayatheerthkulkarni2005@gmail.com>
 <xmqqcyburu6z.fsf@gitster.g> <CA+rGoLfpj2tepMSWLfNeVkwXfzHZB7Vc8_GJ+_=bWkQSzZ+Sjg@mail.gmail.com>
 <xmqqh60wf850.fsf@gitster.g>
In-Reply-To: <xmqqh60wf850.fsf@gitster.g>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Fri, 6 Jun 2025 20:11:42 +0530
X-Gm-Features: AX0GCFtzNU1qAf7cHGDCdW320oKKtCk3o2JQF49z2ODF-IhNdXSft8BK-88rDFc
Message-ID: <CA+rGoLdTT3kdELUyHdZLWyy8e6AbfRU7kDFcVUdCmVtDi11hMw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] submodule: skip redundant active entries when
 pattern covers path
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 9:52=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com> writes:
>
> >> The new helper is a maintenance burden to keep in sync with
> >> submodule.c:is_tree_submodule_active(); if we really want to go this
> >> route, the patch should extract that "ah, submodule.active is set so
> >> let's turn it into pathspec and see if the path matches" part of the
> >> logic to make sure the logic is shared.  But I am wondering if we
> >> can do this without any new helper.
> >
> > I've actually done something like this, but I've wrapped the core logic=
 within
> > the if else after checking [1]
>
> I do not think I follow what you want to say here.  Care to rephrase?
>
> >> I.e.  Can we replace this if() condition with something like this?
> >>
> >>         /*
> >>          * Explicitly set 'submodule.<name>.active' only if it is not
> >>          * 'active' due to other reasons.
> >>          */
> >>         if (!is_submodule_active(the_repository, add_data->sm_path)) {
> >>
> >> That is, we ask if the submodule is already active (we are before
> >> adding submodule.<name>.active for this thing---if may be active due
> >> to submodule.active or submodule.<name>.url) and enter the block
> >> only when it is not yet.
> >>
> >> That way, this codepath does not have to worry about the exact logic
> >> that determines if a submodule is 'active' even when its .active
> >> configuration variable is not set.
> >>
> >> >               key =3D xstrfmt("submodule.%s.active", add_data->sm_na=
me);
> >> >               git_config_set_gently(key, "true");
> >> >               free(key);
> >
> >
> > I've done the exact thing in a bit different way
>
> I am confused again, as this reads as if it is an oxymoron --- did
> you write the exactly the same thing as suggested above, or did you
> write something different?
>


Ok so I'm expand on why I thought this would work;

- if (!git_config_get("submodule.active")) {
- /*
- * If the submodule being added isn't already covered by the
- * current configured pathspec, set the submodule's active flag
- */
- if (!is_submodule_active(the_repository, add_data->sm_path)) {
+ if (git_config_get("submodule.active") || /* key absent */
+   git_config_get_string_multi("submodule.active", &values)) {
+ /* submodule.active is missing -> force-enable */
+ key =3D xstrfmt("submodule.%s.active", add_data->sm_name);
+ git_config_set_gently(key, "true");
+ free(key);
+ } else {
+ for (i =3D 0; i < values->nr; i++) {
+ const char *pat =3D values->items[i].string;
+ if (!wildmatch(pat, add_data->sm_path, 0)) { /* match found */
+ matched =3D 1;
+ break;
+ }
+ }
+ if (!matched) { /* no pattern matched -> force-enable */
  key =3D xstrfmt("submodule.%s.active", add_data->sm_name);
  git_config_set_gently(key, "true");
  free(key);
  }
- } else {
- key =3D xstrfmt("submodule.%s.active", add_data->sm_name);
- git_config_set_gently(key, "true");
- free(key);
  }
 }

To clarify: My aim with the current patch wasn't to create a
general-purpose helper, but to very precisely control the conditions
under which submodule.<name>.active =3D true is written during a git
submodule add operation. But I sure did have a thought that something
like this should exist.

The goals I considerat core when adding a new submodules should be
something like
a. The submodule should become active. This is the primary user expectation=
.
b.The configuration should be as clean and intentional as possible.
Avoid redundant entries if the global submodule.active already covers
the new submodule.
b. The configuration should explicitly reflect the active state if
there's no global policy, or if the global policy.

This was my underlying goal to be very specific.

Your suggestion to use if (!is_submodule_active(the_repository,
add_data->sm_path)) is elegant in its reuse of existing logic.
However, I find these following things

i. Scenario: submodule.active is globally ABSENT.
is_submodule_active() will return true (as submodules are active by
default in this case).

Therefore, !is_submodule_active() will be false.

Result with your suggestion: submodule.<name>.active =3D true would not
be written. The submodule is active by default, but this isn't
explicitly recorded for the submodule itself. Also a reason why the
test failed after digging a bit deeper this is the possible
explanation I found.
Specifically Test case 9 from t7413

test_expect_success 'is-active, submodule.active and submodule add' '
test_when_finished "rm -rf super2" &&
git init super2 &&
test_commit -C super2 initial &&
git -C super2 config --add submodule.active "sub*" &&

# submodule add should only add submodule.<name>.active
# to the config if not matched by the pathspec
git -C super2 submodule add ../sub sub1 &&
test_must_fail git -C super2 config --get submodule.sub1.active &&

git -C super2 submodule add ../sub mod &&
git -C super2 config --get submodule.mod.active
'

ii. My patch's behavior in this scenario (And not as a general purpose help=
er)

The first condition git_config_get("submodule.active") ||
git_config_get_string_multi("submodule.active", &values) evaluates to
true because submodule.active is absent.

Result with my patch: submodule.<name>.active =3D true is explicitly writte=
n.

Let me also clarify on what I mean by the _similar_ and _different_
statements I sent above.
The outcome is what I meant was _similar_ the patch link I sent in the
above mail, explicitly adds only when it doesn't find
new submodule to be active, and I verified it with a documented test
added as the tenth test in t7413 where it shouldn't add
an active twice and the outcome is what I found _similar_, the
_difference_ however are in the methods of getting to the outcome,
and adding guardrails. That's the underlying thought with that statement.

To reinforce the above ideas her e aer some points I would like to make:


The logic implemented in the else block (reading submodule.active and
iterating with wildmatch) is indeed a partial re-implementation of
what is_submodule_active might do internally. However:

It's highly localized to this specific decision point in git submodule add.
It's concerned only with the submodule.active pathspecs.
is_submodule_active might have broader considerations (as you hinted,
e.g., submodule.<name>.url's presence, though that's less relevant for
the .active flag itself).
The benefit of precise control over config generation for add might
outweigh the risk of this small, localized logic diverging, especially
since submodule.active's pathspec interpretation is fairly stable.

The core distinction is that is_submodule_active() answers "Is this
submodule considered active right now based on all existing rules and
defaults?". My patch attempts to answer a slightly different question
for git add: "Given the current global submodule.active policy, do we
need to explicitly set submodule.<name>.active =3D true for this new
submodule to ensure it's active and clearly recorded as such?"
And that is the reason why I had to mention the _different_ and _same_
statement within the same statement.

My approach aims to set submodule.<name>.active =3D true unless an
existing, valid, and matching global submodule.active pattern already
makes it active. This leads to what I feel is a more robust and
explicit configuration outcome from git submodule add.

Perhaps the ideal long-term solution would involve a more nuanced
helper function (which I'm more than happy to write, if I get the
green flag.), but for the immediate improvement to git add's behavior,
I believe this patch strikes a good balance, prioritizing explicit
activation and config clarity for newly added submodules.



Also to clarify :)
I tried to dig and clarify as much as I can
I maybe wrong in some places cause obviously I'm still relatively much
newer to the source code.

But I thought providing a huge para with what I thought would be
helpful for corrections.

Thank you for reading all the blab : )

- Jayatheerth

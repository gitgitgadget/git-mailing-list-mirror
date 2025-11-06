Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D628F1EB9FA
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 22:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469575; cv=none; b=bASYhx3rB+SlPunhG+A0RSj+ceN7b65cgV5AaIt+Q4V8m/KCV3UwE6Y8BX/KkNgzN85gXP/dCpGbbKgCoa1Po5oA4mxSNZpQQdu8+JL+kZvBgOsD4XTv/DM3jsOdtB0J/aunAVI0l559dVOGra1mnmgQR0Ax2FB3/E9sMCWTCYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469575; c=relaxed/simple;
	bh=UpjoOqGjLMHlKgqlOZypVpU6Gfj3ADUwdEY0tfLz//I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uUQ71rbGaxMt+qIsmUsNwjN1d1Ndwg6ARznt4cWYReO6WuE6Wq01y10GJBR9Uf20fp6Mmn96BGabch4CfsvtmMiwsV5E0NtJkXVVGZHUNvHLqk2EyMNZy3qBELflG9mWY/xTFVNjgqsJ/Hpa/JLLgObMtAnNZChcD86jW1mD1AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkMF2Clx; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkMF2Clx"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-37a49389deeso1254361fa.0
        for <git@vger.kernel.org>; Thu, 06 Nov 2025 14:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762469571; x=1763074371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYAnaGTj7WmJE3I7KkYqJ4UxdvHa0X10ieALGBFFgzA=;
        b=JkMF2ClxwVSu8d2Gzy8JV6uxcc6wzk6/1J1QSA6kDixev6BPjEaN4QrAAUHxAFDnIK
         TnEKYFcUZ2St9kVIWi96/4vg7uF45D/d7PzbuslR+mzoF1f0shuPBRfzi2rLcuhvSyF/
         8aGE07XejsWW/c0bMQFuwszLe7LjGCyLHyNzrtxpaUNSrSsaZEtPPkXGk9xVIKFa7iQh
         SlJyYuSU7h6vYxD4DjQRY8u0Fjo6j4jjLACJekRvNI8duhBQnPmE5XxlZJjes7vDxqXz
         k1uN8OucJlZVy/tWrcHw4KCLfdGrnjzbGozj1Iyx817loAm9p3BITRu+d6GLhrr56fGC
         NDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762469571; x=1763074371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JYAnaGTj7WmJE3I7KkYqJ4UxdvHa0X10ieALGBFFgzA=;
        b=GYLvONfoROMifhgvf/cSO+e9IMNnc9TnZ5jWTbFWlE3LSFSFbfrrZJ4fsFfilVPnJF
         g062q+x0F1o7psmgRMW/giP0D8eBbVx/sszn1JHszZ3GrnxP2XyJsTuoZ/DJLU0gw7Dc
         Sc1XG+fjgH301onq20nzqiXemoBe20o1TbnADxonHer5Ts7ScX+h1WRHDXEnMLnluvRj
         zj7NTTBzvm6PlC8J5OTEcNpRhyHuU+Y7GduOooxcBOwX2yeAIDeoe3NjASOif1EUjtbS
         gUi3xAstD8KvvZaBy2LfPk98PpgcPlyKTPxO2MKnv9XEaBFKLepqDoNrBnD6W25dJKHg
         Gh7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWwalFG80MFICdDA5CYCxloLuGKh1HnN8j35JtswWeOpnO3Dy6DOm4vcInhumvuZwtXq5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB0WcT2a9V/0mo02KzUoX5jA6XYfYayCcKw2L7pDDc/r9h3iib
	VaNw+MrnDG0ux0aPz0/Z1Q9yWFoNKzMAiAhugxAagFlAAfcek12zbF3qF3VhVkTJc5vSd4jgNUE
	3OvRL/bSDJFULHpkyyfhSFGB1VjWAuds=
X-Gm-Gg: ASbGncudx6gtNJVV+9FrKVjf0g4IfzlWK1Mm/5/qY7A69fB+lPRdtcsCpuChsR3Nz3r
	GpWrl1No7oVHuRklCEfXvEFUW3qNDPPwt5GC93UMqEuv9AtY+OXqxT09XmX0Q76SP2KthSlM1bo
	uw0LiGy9zhnTMvLUu3qHLHIy/rBvz6lAxTlCo/rKSnzsPyHRsNbA8e+mx7mD7L2oyIV0F0K6HrH
	CKr+G6xEaDnGbmafG19Us8qk+DS7urEgj+DApgJLRrF7ORAzvwm8O6KWN41og==
X-Google-Smtp-Source: AGHT+IGke+e6ybWmhgF9EbOzsS9k9ZbYRqzdEkU390rR3oVQvyuYb5LwarOQEo8bUGreBy4ZQwEueRSesZ0g0Kfy+ME=
X-Received: by 2002:a2e:870c:0:b0:37a:485b:5c62 with SMTP id
 38308e7fff4ca-37a7311e9dcmr2147841fa.4.1762469570508; Thu, 06 Nov 2025
 14:52:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
 <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com> <88133848d1a317f8a95c19ee5482b828a3f8705f.1761776388.git.gitgitgadget@gmail.com>
 <995f77a3-b94c-46df-87d3-22c7b2a3c762@gmail.com>
In-Reply-To: <995f77a3-b94c-46df-87d3-22c7b2a3c762@gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Thu, 6 Nov 2025 15:52:39 -0700
X-Gm-Features: AWmQ_bmQKagtvQm7Xqmou76rqnpmit8Mh1up3FWyEi7-KcYYqEAvT5m25F-N_iI
Message-ID: <CAH=ZcbA25eyMhQpvK7eh=ydZkg5RdzbdRFEdj-22T+d1VuTazA@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] doc: define unambiguous type mappings across C
 and Rust
To: phillip.wood@dunelm.org.uk
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Chris Torek <chris.torek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 2:55=E2=80=AFAM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
> Hi Ezekiel
>
> On 29/10/2025 22:19, Ezekiel Newren via GitGitGadget wrote:
> > From: Ezekiel Newren <ezekielnewren@gmail.com>
> >
> > Document other nuances with crossing the FFI boundary. Other language
> > mappings may be added in the future.
>
> Thanks for adding this, I've left a few comments below. Overall I
> thought it was very well written.

Thanks.

I felt it was necessary since C vs Rust types keep coming up over and
over again. I'm flexible with the wording of this document. I was just
trying to convey a firm and clear stance on what is and isn't proper
in Git.

> I tried building an html version of
> this but even after adding it to the list of TECH_DOCS in
> Documentation/Makefile with
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 47208269a2e..2699f0b24af 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -143,6 +143,7 @@ TECH_DOCS +=3D technical/shallow
>   TECH_DOCS +=3D technical/sparse-checkout
>   TECH_DOCS +=3D technical/sparse-index
>   TECH_DOCS +=3D technical/trivial-merge
> +TECH_DOCS +=3D technical/unambiguous-types
>   TECH_DOCS +=3D technical/unit-tests
>   SP_ARTICLES +=3D $(TECH_DOCS)
>   SP_ARTICLES +=3D technical/api-index
>
> it fails with
>
> $ make -C Documentation/ technical/unambiguous-types.html
>                                        Merge branch
> 'ps/object-source-loose' into seen
> make: Entering directory '/home/phil/src/git/Documentation'
>      GEN asciidoc.conf
>      * new asciidoc flags
>      ASCIIDOC technical/unambiguous-types.html
> asciidoc: ERROR: unambiguous-types.adoc: line 139: undefined filter
> attribute in command: source-highlight --gen-version -f xhtml -s
> {language} {src_numbered?--line-number=3D' '} {src_tab?--tab=3D{src_tab}}
> {args=3D}
> asciidoc: ERROR: unambiguous-types.adoc: line 162: undefined filter
> attribute in command: source-highlight --gen-version -f xhtml -s
> {language} {src_numbered?--line-number=3D' '} {src_tab?--tab=3D{src_tab}}
> {args=3D}
> asciidoc: ERROR: unambiguous-types.adoc: line 177: undefined filter
> attribute in command: source-highlight --gen-version -f xhtml -s
> {language} {src_numbered?--line-number=3D' '} {src_tab?--tab=3D{src_tab}}
> {args=3D}
> asciidoc: ERROR: unambiguous-types.adoc: line 187: undefined filter
> attribute in command: source-highlight --gen-version -f xhtml -s
> {language} {src_numbered?--line-number=3D' '} {src_tab?--tab=3D{src_tab}}
> {args=3D}
> asciidoc: ERROR: unambiguous-types.adoc: line 199: undefined filter
> attribute in command: source-highlight --gen-version -f xhtml -s
> {language} {src_numbered?--line-number=3D' '} {src_tab?--tab=3D{src_tab}}
> {args=3D}
> asciidoc: ERROR: unambiguous-types.adoc: line 213: undefined filter
> attribute in command: source-highlight --gen-version -f xhtml -s
> {language} {src_numbered?--line-number=3D' '} {src_tab?--tab=3D{src_tab}}
> {args=3D}
> asciidoc: ERROR: unambiguous-types.adoc: line 224: undefined filter
> attribute in command: source-highlight --gen-version -f xhtml -s
> {language} {src_numbered?--line-number=3D' '} {src_tab?--tab=3D{src_tab}}
> {args=3D}
> make: *** [Makefile:396: technical/unambiguous-types.html] Error 1
> make: *** Deleting file 'technical/unambiguous-types.html'
> make: Leaving directory '/home/phil/src/git/Documentation'

I've never created documentation for Git before, so this helps. I'll
incorporate your suggestions.

> > +=3D=3D Character types
> > +
> > +This is where C and Rust don't have a clean one-to-one mapping. A C `c=
har` is
> > +an 8-bit type that is signless (neither signed nor unsigned)
>
> I found this a bit confusing. Isn't the signedness of "char"
> implementation defined rather than it being "signless"
>
> > which causes
> > +problems with e.g. `make DEVELOPER=3D1`.
>
> I'm not sure what this is referring to - maybe -Wsign-compare?

When I build Git with `make DEVELOPER=3D1` and I compare uint8_t with
char it complains about a difference in signedness. When I compare
int8_t with char it also complains about a difference in signedness.
So it is implementation defined, but it's also neither signed nor
unsigned according to DEVELOPER=3D1 since it complains either way.

> > Rust's `char` type is an unsigned 32-bit
> > +integer that is used to describe Unicode code points. Even though a C =
`char`
> > +is the same width as `u8`, `char` should be converted to u8 where it i=
s
> > +describing bytes in memory.
>
> I'm dreading the point where we start sharing "struct strbuf" with rust
> and have to change the "buf" member from "char*" to "uint8_t*". While it
> is not used in the xdiff code it is ubiquitous everywhere else and there
> are lots of places where be pass the "buf" member to functions expecting
> a "char*".
>
>         git grep -E '(\.|->)buf\W'
>
> has over 4000 matches

This is why I started in Xdiff since its code is mostly isolated. I
think that we might have to bite the bullet and deal with the ugly
mapping of char on the C side and u8 on the Rust side when dealing
with strbuf. Maybe as we translate more of C into Rust someone will
have a better suggestion. I think my ivec type would be better since
strbuf is almost a special case of my ivec type, but dealing with
strbuf is outside the scope of this patch series.

> > If a C `char` is not describing bytes, then it
> > +should be converted to a more accurate unambiguous type.
>
> That's a good point.
>
> > +While you could specify `char` in the C code and `u8` in Rust code, it=
's not as
> > +clear what the appropriate type is, but it would work across the FFI b=
oundary.
> > +However the bigger problem comes from code generation tools like cbind=
gen and
> > +bindgen. When cbindgen see u8 in Rust it will generate uint8_t on the =
C side
> > +which will cause differ in signedness warnings/errors. Similarly if bi=
ndgen
> > +see `char` on the C side it will generate `std::ffi::c_char` which has=
 its own
> > +problems.
>
> Yeah, we definitely don't want to be using "std::ffi::c_char" in our
> rust implementations. I do wonder if we might want to use it (or CStr)
> judiciously in function parameters and immediately convert it to u8 in
> the function body where the function is called from C though.

That's basically the design pattern I've been using.

In many of my translations from C to Rust I create a Rust stub
function that takes pointer types and wraps them into safe types which
then get handed off to a safe Rust function. I think that in the cases
where CString/CStr is required the Rust stub function would create a
&[u8] slice for the safe function to operate on.

> > +=3D=3D=3D Notes
> > +^1^ This is only true if stdbool.h (or equivalent) is used. +
> > +^2^ C does not enforce IEEE-754 compatibility, but Rust expects it. If=
 the
> > +platform/arch for C does not follow IEEE-754 then this equivalence doe=
s not
> > +hold. Also, it's assumed that `float` is 32 bits and `double` is 64, b=
ut
> > +there may be a strange platform/arch where even this isn't true. +
> > +^3^ C also defines uintptr_t, but this should not be used in Git. +
> > +^4^ C also defines ssize_t and intptr_t, but these should not be used =
in Git. +
>
> [u]intptr_t and ssize_t are used in git already. As Junio has pointed
> out there are sane uses for these types but we don't want to use them in
> structs or function parameters where the struct or function is shared
> with rust.

You're right, I should update the phrasing. Something like: "These
types shouldn't be used if their explicit purpose is for FFI. Whether
as a field in a struct or part of a function signature." I'll update
the wording.

> > +
> > +=3D=3D Problems with std::ffi::c_* types in Rust
> > +TL;DR: They're not guaranteed to match C types for all possible C
> > +compilers/platforms/architectures.
>
> Is this official policy of the rust project?

No, this is a personal inference based on logical deduction. The c_*
definitions have changed over time with new Rust version releases, and
Git targets more platforms/architectures than what Rust officially
supports. While it's not guaranteed that it won't work everywhere.
It's also not guaranteed to work everywhere either. On top of that
we're targeting 1.63.0 who's c_* definitions are different in 1.89.0
which I show an example of with c_long_definition. Can anyone say with
certainty that Rust got these mappings right or wrong for all possible
C compilers/architectures/platforms? If so (which I highly doubt)
could someone provide a link?

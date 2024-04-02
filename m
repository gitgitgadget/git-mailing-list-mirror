Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1744186146
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712067545; cv=none; b=Wn2Y4wIJyLkUowVHv0a//lpAF8ynjA68lW0wO7kzWGULU1csmKZGnIConI7qltbP4tdL2qCEFmeRb+kftJoM9I7948cYNZ+9qubKyJt2tDKmXuXuphzLfTKksmiHXt5TgIFuECelaI/dcFlxMM2C56yDVEsR4vFcusBKJFZW6Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712067545; c=relaxed/simple;
	bh=R8OoqDl3Qt3akDXaYX15+Aermb+So6Enc3oVarGOIH4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=EeqfuE3/Rfd3wjuSfUPVCioX/OJS6Pxdz4e1WhkfOqz7EKPN43NwZnS3CoiXrR7KSKhLiwrno8SY9uQSugDxnEAkNuoJNOUVsvweFtM/xysHAyylXt17SpkHv24qSpwVxIIRfz9R2+mT1qnQJnPJsT1/6s0vLrF9ot7AJjbT4+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h2IG6mpV; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h2IG6mpV"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-431347c6c99so1116771cf.0
        for <git@vger.kernel.org>; Tue, 02 Apr 2024 07:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712067543; x=1712672343; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbS/plaeliupwVOypLM6q0/QDlFtZYZS9R09hap/LLM=;
        b=h2IG6mpVWFr+x/Acyp1XKfpWqau0NIu2uLgpYOTs2eEMXqend+s7PeQvYVNcTLpp7l
         BnzodHr1PyanfBXjDc8I3BqqJ3Peg54RuuOLwKr037pdO8WBRRHG+4Zq4vA+0G0+DC3t
         lpbRcIsL8gr1RuL8bnTVUYEgrFw2nQVZT87V0Ob6Z5v7BzzZwJa42XYee4o1gIzHZaao
         Q7dMFz3DhnC+H8qax7BzYkBRspDiazOz9X/OmBLxuy6+SXVy/n1TqfyPeFdYPCAftWhj
         29j396HJZDmoqCv6AmqGOFNGMXV9A6dNSsQC0A557b+37jXvTBEBj8DGr94KWlbePBgb
         p34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712067543; x=1712672343;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZbS/plaeliupwVOypLM6q0/QDlFtZYZS9R09hap/LLM=;
        b=IvVG67BCgmhzYFsmGYPIDzysBfz+9s03wC/iJ43AurwYL7lZKKS3c6/XDvOmpLtbYq
         u1jpUrI94IZe+pizMkqDyPPDZ7JZEuUT4orbykzQpIoKciCOrDkJfuv6v6nGcD84cUOd
         CmX1BfwUL6QCk7torCSZjdvS26PHHfhvP4nxOSTNmwFrD3bsLu4yb1DG0ajnOcUdE+p0
         POPz7qomybe83HliL50T5jtrdlSfE2Y2GByeFKefSizkcZC3W+eLaPeI7DZRyQtqXvuJ
         00jdbhjAEvOXrjCcOsh8f+oLzD92s0Fu9ue+rJN9AKgSbOaF2+x8LsTtbX7/xYk1n+Hn
         oHLw==
X-Gm-Message-State: AOJu0YwUaMqEhBd5xGx+oEjCZ7fgYXO59xM+HnSzkZrdZvvtcRqyj5TW
	XY/62EQOyRgiT0R2wZdiZ+/ab16pOZdKfNlyRvFoP0xLBo3fyh0NHbgcw4H2NwV6yyTPAUazQX8
	o1YTQMIKcCDKNgLY15cQYDnqtSU3u3A8FbCowcKlaNTDgVDZiFPwtYVY=
X-Google-Smtp-Source: AGHT+IHmK+HC3raedDz9Oe7GAqwr0IXZQp9R/qJhgc+5fJs2dIiLY5d5InkDv8lL4kiF407RO3tJZTcmUjQpXYuz1tE=
X-Received: by 2002:a05:622a:2589:b0:431:3771:1081 with SMTP id
 cj9-20020a05622a258900b0043137711081mr1197261qtb.23.1712067542513; Tue, 02
 Apr 2024 07:19:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Calvin Wan <calvinwan@google.com>
Date: Tue, 2 Apr 2024 07:18:51 -0700
Message-ID: <CAFySSZAB09QB7U6UxntK2jRJF0df5R7YGnnLSsYc9MYhHsBhWA@mail.gmail.com>
Subject: [RFD] Libification proposal: separate internal and external interfaces
To: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This proposal was originally written by Kyle Lippincott, but he=E2=80=99s
currently on vacation for the next two weeks so I=E2=80=99m helping start t=
his
discussion for him (from here on out Kyle is the =E2=80=9CI=E2=80=9D).

TL;DR: I'm proposing that when creating a library for code from the Git
codebase, we have two interfaces to this library: the "internal" one
that the rest of the Git codebase uses, and the "external" one for use
by other projects. The external interface will have a different coding
style and platform support than the rest of the codebase.

When thinking about potential issues and complications with
libification, I encountered a few broad categories of issues, and I'd
like to list them briefly (edit: turns out I can't be brief to save my
life) and float a proposal that may help minimize them.

Definitions
-----------
- When I say "Git" or "the git executable/binary" or whatever, I'm
  referring to "the collection of binaries, tests, etc. that are part of
  the main git repo" unless I say otherwise.
- Similarly, when I say "internal" I mean "for use by <that collection
  of programs>". When I say "external" I mean for use by stuff that's
  not part of the Git repository.

Assumptions
-----------
- Libraries that we're providing can be either statically or dynamically
  linked. Git will link statically to its own Git libraries. External
  projects may use either.
- Git must continue to be compilable and usable on all platforms it's
  currently supported on. Libification can't take that away. However,
  since libification is producing new interfaces for new use cases,
  there is no requirement that we make these new interfaces usable on
  all platforms, especially at first.
- We'd like as little churn and "uglification" of the main codebase as
  possible.

Issues
------
- Symbol name collisions: Since C doesn't have namespacing or other
  official name mangling mechanisms, all of the symbols inside of the
  library that aren't static are going to be at risk of colliding with
  symbols in the external project. This is especially a problem for
  common symbols like "error()".

- Header files: This is actually several related problems:
  - Git codebase's header files assume that anything that's brought in
    via <git-compat-util.h> is available; this includes system header
    files, but also macro definitions, including ones that change how
    various headers behave. Example: _GNU_SOURCE and
    _FILE_OFFSET_BITS=3D64 cause headers like <unistd.h> to change
    behavior; _GNU_SOURCE makes it provide different/additional
    functionality, and _FILE_OFFSET_BITS=3D64 makes types like `off_t` be
    64-bit (on some platforms it might be 32-bit without this define).
  - <git-compat-util.h> is expected to be included as the first header
    file in the translation unit, so as to make _GNU_SOURCE and similar
    #defines have the desired effect. If a translation unit (in an
    external library consumer) has already included <unistd.h>, we can't
    rely on them having had _GNU_SOURCE defined ahead of time
  - We can't just `#include <git-compat-util.h>` at the top of our
    external interface headers,
  - Git's header files make regular use of inlining. We can't assume
    that external projects are going to use static linking, and we can't
    assume that external projects are going to use a C-compatible
    language (they might not use our header files at all), so inline
    functions seem risky at the interface layer.

- Compatibility: Using code from the git codebase as a library is a new
  use case, we do not have the backwards compatibility requirements that
  we do for Git itself. We should take full advantage of this, and
  explicitly state what compatibility guarantees we are providing (or
  not providing).

Proposal
--------
Let's have a distinction between the "internal" interface (used by Git),
and the "external" interface (used by everyone else). The "external"
interface has several differences from the rest of the git codebase:

- Minimal. Only include symbols and types that we explicitly want to be
  part of the interface
    - This is both for API evolution abilities and providing a "well-lit
      path" to usage. Internal header files may have a lot of similar
      but slightly different functions that can be very confusing, or
      are highly specialized.
    - Most languages will not be able to include our headers. Reducing
      the interface to the minimal necessary means it's easier to
      identify when the interfaces change and update the
      non-C-compatible-language bindings.
    - The external interface should have as little code/new
      functionality as possible. All actual functionality should be in
      the internal interface(s).

- No inline functions. This is similar to minimal. We should put as
  little as possible in the header files, especially since many use
  cases involve using the library from a language that can't even
  #include them at all.

- Self Contained. The header files must work if they are the first/only
  #include in the external project. They must include everything they
  need, and not assume it was already handled for them.

- Tolerant. The header files probably won't be the first/only #include
  in the external project's translation unit, and they should still
  work. This means not using types like `off_t` or `struct stat` in the
  interfaces provided, since their sizes are dependent on the execution
  environment (what's been included, #defines, CFLAGS, etc.)

- Non-interfering. Our header files must not change fundamental things
  about the execution environment. This means they must not do things
  like #define _GNU_SOURCE or #define _FILE_OFFSET_BITS=3D64

- Limited Platform Compatibility. The external interfaces are able to
  assume that <stdint.h> and other C99 (or maybe even C11+)
  functionality exists and use it immediately, without weather balloons
  or #ifdefs. If some platform requires special handling, that platform
  isn't supported, at least initially.

- Non-colliding. Symbol names in these external interface headers should
  have a standard, obvious prefix as a manual namespacing solution.
  Something like `gitlib_`. (Prior art: cURL uses a `curl_` prefix for
  externally-visible symbols, libgit2 uses `git_<module_name>_foo`
  names; for internal symbols, they use `Curl_` and `git_<module>__foo`
  (with a double underscore), respectively)

- Translating. The external interface provides "external" symbol names,
  and potentially more compatible function interfaces than the internal
  interface does, and exists to translate from one domain to another.
  Most functions in the external interface will be just a single call to
  the internal interface. Examples:
    - Internal interface is `void foo();`; external interface would be
      `void gitlib_foo() { foo(); }`
    - Internal interface is `void foo(off_t val);`; external interface
      could be `void gitlib_foo(int64_t val) { foo(val); }` -- here we
      accept int64_t instead of off_t due to the issues around the size
      of off_t
    - Internal interface is `void foo(strbuf *s);`; the external
      interface might be `void gitlib_foo(char *s, size_t s_len) {
      strbuf sb; strbuf_init(&sb, s_len + 1); strbuf_add(&sb, s, s_len);
      foo(&sb); } ` -- since strbufs own the memory they hold, strings
      that come via the external interface might need to be copied to be
      memory safe.
    - Internal interface was `void foo();` but gained a new parameter.
      We don't need to expose this parameter in the external interface,
      and instead can just use a sensible default. External interface
      can remain `void gitlib_foo() { foo(NULL); }`

Proof of Concept
----------------
I think we should continue with the git-std-lib work as a manual
separation of the .c files and associated header files that comprise the
very lowest level of functionality in the git codebase. This manual
separation would only produce a library with an "internal" interface. We
should also start to apply these ideas by defining an "external"
interface which has a subset of the functionality in git-std-lib.

Automatic symbol hiding
-----------------------
One of the main driving forces behind my proposal above is avoiding
significant churn in the git codebase, for example needing to rename
every function in the codebase that's not static. While many function
names are unlikely to collide, such as `parse_oid_hex`, others are
significantly more likely, like `error` or `hex_to_bytes`. Needing to
rename all "plausible" collisions to things that are unlikely to
collide, like `GIT_error` or `GIT_hex_to_bytes` is tedious, error prone,
and unpleasant.

I have possibly discovered a truly remarkable solution, but this
footnote is too small to contain it. Wait, no it's not. This isn't fully
tested yet, but has shown promise in my initial tests using clang on a
Linux machine.
- Compile the "internal" interface(s) and all supporting code with
  `-fvisibility=3Dhidden` to produce .o files for each .c file
- Compile the "external" interface(s) without hiding the symbols
- Produce a .a file that contains that code, for use by git itself
- "Partially link" the everything, using `ld -r`, to produce a single .o
  file
- Use `objcopy --localize-hidden` to actually hide the internal symbols
  from the "partially linked" .o file

This should leave us with two static libraries: one that has the symbols
marked as "hidden" but still usable, for use in git itself, and one that
contains the external interface, but doesn't expose the hidden symbols.

There may be similar solutions possible on other platforms, or there may
not, and we may need to do the great renaming (either in the code
itself, or via something like a giant set of linker scripts). While my
proposal to have a separation between the internal and external
interfaces is a requirement for making this automatic symbol hiding
solution work, I don't think that a failure to make the automatic symbol
hiding solution work means that we shouldn't have the internal/external
split. It's only one contributing point in favor of having the
internal/external split.

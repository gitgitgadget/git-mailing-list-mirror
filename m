Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250841A705A
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 16:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727972249; cv=none; b=IoV6zPfKqjLP32Sx3velABwfpN/7cOAhXKF7UI68rBy865H0uOWSRBuEK7RvebXmA9s2FWUd1Oq/cQaMjdVGHM0GWuh8AI9Rn/OoXYo8MXdikbMjnNkn2TkIYwFMIwaE+oylCWP5VGR/MkxKBLDUeCK2x8ajJmd0W1P61U3dIUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727972249; c=relaxed/simple;
	bh=yMzttiWqCl0JFyY7xl4CLDu4vAuxr3WBSJtK2D28ktU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ApmGa7+j8SEBSILKJbmm0Fh0pgJLKOsYmDTLBaYrFibvbLspSdeIKNGPMY/zpCoFm5OxCZ2sOJyeA5cne5xZVkKU+fzrMhwhhZ5fmeLFu2AY2myAQkF9AO9oUXzAe5ai/DiJms2Rn8V1DQhW8xpA8/2t7/NxntQ6iMtc34Rb2UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ws6fAqtp; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ws6fAqtp"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4582fa01090so306041cf.0
        for <git@vger.kernel.org>; Thu, 03 Oct 2024 09:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727972247; x=1728577047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Am1ywZ0uccj+67VoCF+RBPR+ms6fvda7Ag+t2E+DIAk=;
        b=ws6fAqtpa/Sj7bsHzrKqDmJ2ZbjSDjmUtHov1rV4CliJe2EcqR2qCfmNFPKwUHMFFT
         hPHXgvlmuxJRefduUw+p4jwCXIyRvM6VgNc4yQqASRgxFyVr7E00xI8i/BIy2ZP9oMNo
         HvniTOna7i+OYgHnPyZHa4f7tGs7Lbc+0qhmgVytVTM9oUZdfuK5TRsIiVCiOdFb1cmt
         Wyx7fSI/RLQ0D0GvuCVn1RGcmN5P+0v8nmUxzJ4/Hn58sHgdfmLv7wIXq/6g76umWtKw
         3wqV5kPxWjEzy8bGOzKvJlayY9eP1lOcLMLls8N2kPtbaOWUk7obhgaTe+hiTl+Z5kZr
         Xebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727972247; x=1728577047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Am1ywZ0uccj+67VoCF+RBPR+ms6fvda7Ag+t2E+DIAk=;
        b=vnd+u0Ec2QVUpor+Etxrzgo9nM+1Af1psFD73TL8YctJQvGxp8I79EJ7qsbCpgmCWs
         2dpiITHlh04t7YwVzzOxSrRHQsZ01xe9Wi3RO7WYCB+CHMNazclaH5vBX0M2mrwmwmQd
         Ud5TzdFfSifnUS5p4x7z4rtAyCwmCWm0PxBrg//v5heinamCo1im3MF82NdVbLBkd2Wf
         BbdAC3Ahj5RoukyPlDodQxmXSaU28I0OeLEZT3GJOnDJHkI9+2+OY1GiOZN21yGffh8y
         iPTfPu9U/uMKlhGkNjefH65Oe9IGaY7yWTIOytUvPgTCGD0OyBsGVM2RTBkOmNAuLR6L
         nohQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsuOKl/9iDATSmqynqIjZigIGk4/BzSABMEGvCICapFwp/k4QK50j8bQhTEeET6O9QP+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKtM0LulXVWKpIK4mvgpIr8Uw5xvE+53t+3AXZhYUbVApY+4Z5
	A6LTowb9MSQ/7ksenJWDPQaZB7sjR/FEI7aH8LymRcquwPvPhiHiJTBEyek2StduKIn/+RiSKK9
	S57tKUoqESJejqEdSbY8DMw0PSx9iDuYS6xN0
X-Google-Smtp-Source: AGHT+IEDvGf/c9LFppg2dJk5H4PH2Nbbu6VgT6LsD4uPrp0xgGPEX3CsMEMJrgA9Dg/8xrnRazG+5/lEZRmVWgdb8JQ=
X-Received: by 2002:a05:622a:7d92:b0:447:dbac:facd with SMTP id
 d75a77b69052e-45d8e2a3b10mr3849491cf.24.1727972246484; Thu, 03 Oct 2024
 09:17:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930220352.2461975-1-sandals@crustytoothpaste.net>
 <20240930220352.2461975-2-sandals@crustytoothpaste.net> <2d2f14ea-cfdc-4b52-948f-b42c8f6e41de@gmail.com>
In-Reply-To: <2d2f14ea-cfdc-4b52-948f-b42c8f6e41de@gmail.com>
From: Emily Shaffer <nasamuffin@google.com>
Date: Thu, 3 Oct 2024 09:17:12 -0700
Message-ID: <CAJoAoZnhY0Z7XdNqt8A598jptiNVDJC=4kT5n_n1FCGN5GkXRg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] Add a type for errors
To: phillip.wood@dunelm.org.uk
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 2:54=E2=80=AFAM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
> Hi brian
>
> Thanks for working on this.
>
> On 30/09/2024 23:03, brian m. carlson wrote:
> > There is work underway to move some of the Git code out into a reusable
> > library.  In such a case, it's not very desirable to have the library
> > code write random errors to standard error, since this is an antipatter=
n
> > which annoys terminal users.
> >
> > Instead, we will expect callers of our library function to return
> > errors.
>
> Isn't it the callers that will expect the function to return an error?
>
> > The reusability of our library will be substantially improved
> > if we return typed errors so that users can easily determine what kind
> > of error might have occurred and react differently based on different
> > contexts.  For example, if we are looking up an object in a partial
> > clone and it's not found, we might decide to download it, but we might
> > return an error to the user if the problem is instead that the revision
> > specified is not syntactically valid.
> >
> > To help the libification process and make our code more generally
> > maintainable, add an error type.  This consists of on 64-bit integer,
> > which contains bit flags and a 32-bit code, and a pointer, which depend=
s
> > on the code.  It is designed to be passed and returned by value, not
> > pointer, and it is possible to do so in two registers on 64-bit systems=
.
> > Similar functionality works well for error types in Rust and for the
> > standard library's lldiv_t, so this should not pose a problem.
>
> Part of the reason it works well in rust is that it supports
> discriminated unions with pattern matching and has the "?" macro for
> early returns. In C the code ends up being quite verbose compared to
> taking a pointer to error struct as a function parameter and returning a
> boolean success/fail flag.
>
>      struct git_error e;
>      struct object_id oid;
>
>      e =3D repo_get_oid(r, "HEAD", &oid);
>      if (!GIT_ERROR_SUCCESS(e))
>          return e;
>
> With a boolean return we can have
>
>      struct object_id oid;
>
>      if (repo_get_oid(r, "HEAD", &oid, e))
>          return -1;
>
> where "e" is a "struct git_error*" passed into the function.

I actually don't find this complaint all that compelling; it's not
hard to write a shorter macro that can be used inline, so we can do
things like:

    ERR_VAR(e);
    if(ERR(e, repo_get_oid(...))
      return e;

or even a macro to do the return if desired:

    ERR_VAR(e); // or, i guess we can be not SO lazy and just write
struct git_error e here, whatever :) )
    RETURN_IF_ERR(e, repo_get_oid(...));

For better or worse, you can do a lot of things in a macro, so I don't
see verboseness as much of an issue because I think we can hide a lot
of it this way.

>
> > Provide the ability to specify either an errno value or a git error cod=
e
> > as the code.  This allows us to use this type generically when handling
> > errno values such as processing files, as well as express a rich set of
> > possible error codes specific to Git.  We pick an unsigned 32-bit code
> > because Windows can use the full set of 32 bits in its error values,
> > even though most Unix systems use only a small set of codes which
> > traditionally start at 1.  32 bits for Git errors also allows us plenty
> > of space to expand as we see fit.
>
> I think the design of the struct is fine. It does mean we need a global
> list of error values. GError [1] avoids this by having a "domain" field
> that is an interned string so that error codes only need to be unique
> within a given domain. I think that for a self-contained project like
> git a global list is probably fine - svn does this for example [2].
>
> [1] https://docs.gtk.org/glib/error-reporting.html
> [2]
> https://github.com/apache/subversion/blob/be229fd54f5860b3140831671efbfd3=
f7f6fbb0b/subversion/include/svn_error_codes.h
>
> > Allow multiple errors to be provided and wrapped in a single object,
> > which is useful in many situations, and add helpers to determine if any
> > error in the set matches a particular code.
>
> The api appears to require the caller know up front how many errors
> there will be which seems unlikely to be true in practice. I think a
> more realistic design would allow callers to push errors as they occur
> and grow the array accordingly. For example ref_transaction_prepare()
> would want to return a list of errors, one for each ref that it was
> unable to lock or which did not match the expected value but it would
> not know up-front how many errors there were going to be.
>
> It would be useful to be able to add context to an error as the stack is
> unwound. For example if unpack_trees() detects that it would overwrite
> untracked files it prints a error listing those files. The exact
> formatting of that message depends on the command being run. That is
> currently handled by calling setup_unpack_trees_porcelain() with the
> name of the command before calling unpack_trees(). In a world where
> unpack_trees() returns a error containing the list of files we would
> want to customize the message by adding some context before converting
> it to a string.
>
> > Additionally, provide error formatting functions that produce a suitabl=
e
> > localized string for ease of use.
>
> I share Emily's concern that this function has to know the details of
> how to format every error. We could mitigate that somewhat using a
> switch that calls external helper functions that do the actual formatting
>
>      switch (e.code) {
>      case GIT_ERR_OBJECT_NOT_FOUND:
>          format_object_not_found(buf, e); /* lives in another file */
>          break;
>      ...
>
> I know this is an RFC but I couldn't resist one code comment
>
> > +#define GIT_ERROR_SUCCESS(e) (((e).code =3D=3D GIT_ERROR_BIT_INIT))
> > +#define GIT_ERROR_SUCCESS_CONSUME(e) ((git_error_free(&(e)).code =3D=
=3D GIT_ERROR_BIT_INIT)
>
> git_error_free() returns the code as in integer so we don't need ".code"
> here. Also our coding guidelines would suggest git_error_clear() for the
> name of that function.
>
>
> In conclusion I like the general idea but have concerns about the
> verbosity of returning an error struct. It would be helpful to see some
> examples of this being used to see how it works in practice.
>
> Best Wishes
>
> Phillip
>

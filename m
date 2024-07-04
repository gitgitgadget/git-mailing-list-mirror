Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEE3170836
	for <git@vger.kernel.org>; Thu,  4 Jul 2024 07:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720077348; cv=none; b=ihAw13SdY8Evoneh8vzcApNGtsd1ZsCk5fljWb2giYr0rZhrUWniuZyYduxFUk/mvxSov1Wf/ozLFC8UmhC5J8mlSaZez5uWuGo/C2L+ozCfMua5Q2WknJLuT6Uk7isxp9K31dmRWVNpboJMAHZ6nTXIR7g9JfafMhxAd07zKPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720077348; c=relaxed/simple;
	bh=B7FnEoxoLHZjeAtbB76Id9Xsmur/YePJpWKHbrUN2dU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=tiCpTCcisAzoHHcQPcprimZEr1aBePkV7Cd6I2r7x/AY3GrnG90RChXCZPMCPt6+mO31wknzWb0k9Gi22+XwR6KFhVaF9LbGzaIiJCwtl/uDVEe6Qt2X3JEy+nxlEaD772MhooapVOV9aA7gDsv3sBLfY3bpLNQA4JlLame6khk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUYNrKQN; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUYNrKQN"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dfa71ded97bso258004276.1
        for <git@vger.kernel.org>; Thu, 04 Jul 2024 00:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720077346; x=1720682146; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pza5ZefLJY3G/i7vSOrLotWXK7jVVrC8y5bfdAGHuo8=;
        b=eUYNrKQNCirnfrnCO5asvzu1pcf2881gBotmDvn40gMoym3DCEjQf+lbksvsI1XVjz
         CYlW9LSK2FJuUyaxPbqb6eYyfBtBc5WZxr3KUBatTUQUpIy3QpBNebOktLqW1koNyCk0
         3Ar/9ez6/m+7VqoAYywz7whM7n67RNabh04wMdtRQrvRjhCPJ4ILLxvD+ZTo5DRDp183
         4h3wPtPqI/BkBmBHPiVLuwRcSS0CX0AliXxEweHwzoPGRbNQuQe7WoIg2ZresLFZSrUQ
         xxRSi1ASp+G2qrX1G+J22TD3J9L9oOQwcBZtQ4xUMoUFDODY/oNZkNYPfdNctiV7t9uz
         oIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720077346; x=1720682146;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pza5ZefLJY3G/i7vSOrLotWXK7jVVrC8y5bfdAGHuo8=;
        b=WJH+9m3HRQVHMB12owtag5u/0HH0/ED/bop59qPkJDDIYgWvI/fCONQo/1x+rOOnFr
         0B5DoBKjiQmt0Om09wopuuXlP7PAyA+3voCgC6nbOlg5osTlRoZyCIdsSl7hTUs0lPu0
         nbSWsyN9PFojveiN+JQDoa9jItaO3wlIoqa0PL9PDjCIYB5dvh/PY7UykG38pdLR0ZZm
         bUJuVWtkPdVT/owc1nE4dMPNBUPo33pEObSrMI/QAVx4NwYad1UXDyy7PmCXzAUVqIb8
         kkO6flmdC0J6Mf4i8aDXsM2nyZKjboY7weXtmyB/fcU6ye9HhC+z9jFrbU09/9+ziq3c
         lNsA==
X-Gm-Message-State: AOJu0YzLMoQ0i8jBEj5ojFU4wQVZGT1cE8Zbebm8f5RXutsybM24LIkp
	tUa4LgscxVi+LfnE+V27eP77+lAxQBvNE4PNgmvza38pYSR8sNwo3zNwtLUcUF8n4OOdO8SGaRv
	But6cCkoT/Ga/0WC/vBDrA96oIYdgZQ==
X-Google-Smtp-Source: AGHT+IE/leAJ9IAD2180chLpDXMBW6QxHa7iwB4vYC+Y3pxXxpal3pcfrlln0l3YUyKxTESwewljItpargHHi6AxG1Q=
X-Received: by 2002:a25:2647:0:b0:e02:c458:c70f with SMTP id
 3f1490d57ef6-e03c2a67ac9mr318253276.22.1720077345792; Thu, 04 Jul 2024
 00:15:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFjaU5sAVaNHZ0amPXJcbSvsnaijo+3X5Otg_Mntkx2GbikZMA@mail.gmail.com>
 <772a1bd2-dd21-459a-8b95-7605fd7f52dc@kdbg.org>
In-Reply-To: <772a1bd2-dd21-459a-8b95-7605fd7f52dc@kdbg.org>
From: Emanuel Czirai <correabuscar+gitML@gmail.com>
Date: Thu, 4 Jul 2024 09:15:35 +0200
Message-ID: <CAFjaU5tmurBrTu_oGu526c362bi9eEgKWV9unwbBGmm9r7Dznw@mail.gmail.com>
Subject: Re: `git diff`/`git apply` can generate/apply ambiguous hunks (ie. in
 the wrong place) (just like gnu diff/patch)
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 11:01=E2=80=AFPM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 03.07.24 um 17:24 schrieb Emanuel Czirai:
> > With the aforementioned `diffy` patch, the generated diff would actuall=
y be
> > with a context of 4, to make it unambiguous, so it would've been this:
> > ```diff
> > --- original
> > +++ modified
> > @@ -1186,8 +1186,12 @@
> >                      self.gctx.shell().warn(msg)?
> >                  }
> >              }
> >          }
> > +        if seen_any_warnings {
> > +            //use anyhow::bail;
> > +            bail!("reasons");
> > +        }
> >          Ok(())
> >      }
> >
> >      pub fn emit_lints(&self, pkg: &Package, path: &Path) ->
> > CargoResult<()> {
> > ```
> > this hunk is now unambiguous because it cannot be applied in more than =
1
> > place in the original file,
>
> This assertion is wrong, assuming that the patch is to be applied to a
> modified version of 'original'. There is nothing that can be done at the
> time when a patch is generated to make it unambiguous, not even if the
> entire file becomes context. The reason is that the modified 'original'
> could now have the part duplicated that is the context in the patch, and
> it would be possible to apply the patch any one of the duplicates. Which
> one?
>
> -- Hannes
>

tl;dr: you're correct indeed, a hunk is truly unambiguous only when
`git apply` determines that, and it thus depends on the target file to
apply to; `git diff` can generate unambiguous hunks only with respect
to the unchanged original file, but applying that hunk to a changed
original file  only determines if a hunk is relatively unambiguous,
that is, unambiguous with respect to that changed original file. Both
diff-ing and patch application are needed to ensure unambiguity.

That is correct, which is why it's necessary to have `git apply` also
modified so that it tries to apply each hunk independently to the
now-modified original to see if it can be applied in more than 1
place, and if so, fail with the proper error message; in addition,
after applying it, it would try to apply it again, just in case
applying it created a new spot for it to be reapplied, and if it
succeeds to re-apply it, it would fail again. I kind of mentioned this
I believe, if not, my bad.
Both `git diff` and `git apply` would have to each ensure that the
hunks are unambiguous for the hunks to be considered unambiguous,
therefore you're correct in your statement that my stating that the
hunk is unambiguous right after generation via a fixed `git diff` is
wrong. It's merely unambiguous only in the context of applying it to
the original file, but as soon as a new modified original file is
presented, it can be ambiguous as it is, unless `git apply` can
determine that indeed it cannot be applied in more than 1 place in
this new modified original file, but both: applied independently(just
to be sure) and during the application of all previous hunks until
then, maybe even more than these 2, because the following hunks can
create new spots for it, so a reapply could make that hunk succeed
even if all others would fail. Not entirely sure here, how to properly
ensure this, that's why someone more knowledgeable might.

Ah, I see that I actually tried to say this(the above) after that
statement  but I used wrong wording "will fail" instead of "should
fail" or "would fail" (if fixed, that is):
> this hunk is now unambiguous because it cannot be applied in more than 1
> place in the original file, furthermore patching a modified future file
> will fail(with that `diffy` patch, and ideally, with `git apply` if any
> changes are implemented to "fix" this issue) if any of the hunks can be
> independently(and during the full patch application too) applied in more
> than 1 place.

For what's worth, barring my lack of explaining, the `diffy` patch
I've mentioned already does this: makes sure the generated hunks are
unambiguous at diff generation, and unambiguous at the time of the
application of the patch. But definitely both are required.

I guess, I call the hunks unambiguous at diff generation but it
implies they're only unambiguous on the original file, and because
patching is also "fixed", patching can ensure the hunks cannot be
applied in more than in 1 spot and I thus call them unambiguous at
patching as well. But both are required (diffing+patching) to ensure
that indeed a hunk is truly unambiguous, therefore, you'd be right to
say that any static diff file even if it had the whole file as context
cannot or shouldn't be called unambiguous, because that's only half of
it; because applying that diff as patch(which is the second half of
it) is necessary to see if it's unambiguous as it depends on the
target that it's applied on. Thus even if the generated hunks(or
patch) is unambiguous from the point of view of having generated it,
applying it to a modified original file can cause the patching to fail
if ambiguity is detected. Seems better to fail(either at diff
generation, if context length is too high, or at patch application if
ambiguity is detected) than to silently succeed and hope that a
compilation will catch it, or worse a runtime behavior is eventually
spotted to be wrong. Rust files appear to be far more prone to this
ambiguous diff generation due to rustfmt which formats them like seen
above with 1 brace per line, and having the possibility of consecutive
such braces...

Thanks for your reply. Definitely need to think more about calling
hunks unambiguous, without also specifying that they're truly only so
only when applied(which really makes them only as strong as
_relatively_ unambiguous, since they depend on the target file to be
applied to). Maybe call them semi-unambiguous, or unambiguous with
respect to original file, unclear yet. Perhaps whoever decides to make
a patch for this issue can call them differently, or just be aware of
this.

Cheers! Have a great day everyone!

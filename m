Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2671BC4E
	for <git@vger.kernel.org>; Thu,  4 Jul 2024 10:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720088654; cv=none; b=unSK2O+kBaqgzh+iZy4B8sA1q1Z6IeYv9r5I7uwvqxuVWhTGlkM9uMRCcsljCwb5eX8Ydcvof1MXQpcBolY7TNr/7gib0j1hyigCKBiwRoIvNVsl7fMWDb4AksD9cT5fYaFSuMXMfE5KqhgieHkneTiCXWnA2OA1CXYjM80owc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720088654; c=relaxed/simple;
	bh=6Iiga9DZb0MH9bswov4Qj45e0Gu1iukjeIe82kPj5Eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=jkIoUSHIKSRjeEylhykMEU9GlQsUkK5/pBVj3CUbF6jOrO1EM5m7IgC2NwNKC0rgzX11WhJc/bQuzYq5IHdG5wSN5c7BCDgfyRc0pSc68G1uD/fvhkItfFj7p80AW5FsHLJ4NqHsgsG7mS9/qLS4uLDnxM+fqMeTdgQPmaYAf8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hg+F6oJN; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hg+F6oJN"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-64b5617ba47so4547517b3.3
        for <git@vger.kernel.org>; Thu, 04 Jul 2024 03:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720088651; x=1720693451; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sw2e4PPcbt+8gBqSBolsm8gfjicdclR/VwVorVfE/1o=;
        b=hg+F6oJNj8ubpI9E3fCPwhwv55esR5gIh3mAUUod8LdpZEX3i870dgpuJVNpvBTTJs
         t6fq+2Y7j8LIvnRImzWLULCmfpGmhyS7Vl3HIy0FWLYi1ipoqR+FtyLZJbZ5lNVdOV4v
         UjjnzJbRB29T/Dad/5fBfwFHtyHaJF29i0RrpZ98Wb6IwXmzQdBiJOtHtvE+irPdKt3s
         4gk8QnRwm0hCnOUMLwEFLQE7gDB+GieN9KXTHl3f8FpfmZCNq6K8J9oR0zAVgyVpAl87
         JSK/fnUL4rTDiPReHdDvnACzKfxzCf1hLuIl3XIlD69tvQWCqrDnNU0dH1wUMKSmIbVq
         hrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720088651; x=1720693451;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sw2e4PPcbt+8gBqSBolsm8gfjicdclR/VwVorVfE/1o=;
        b=LPikTd9MarY7AyNbR9fFjunf2vF2dW7OQnNTdF6StVqaUecirMhjBGSYGWlJf4yMQd
         sft8zFG+vJWIq9ytNPdf7EsgGeiKTi19WWFge78vZBWQzXXZyougSa5rwyUJ3BK0AYwN
         4dC5yiMBkG5+zDUyIIBAgoAbSr/R3UKNxEiVY8Y0ta1PAEoXuFxXXrGW5JOMQPBYXjKb
         2T7ULMuDK/OcmVrJm3D6ty5DC65fGt3ntLCNyZ/gLqXnEDIsfAYtlRqSknwH/7YOr/0f
         MgnATDM3mQlvH3XVqvxx32V45bweJ60vY442M3byMxghdmpsCsjgbWmWuma6ywkqX7PV
         eWaQ==
X-Gm-Message-State: AOJu0YzUiVHE1tw551NQNxXd9G5wbKDasMb9z+pJTIopg06+jZktgrTn
	VvC3vm4ifwJnMjJRwbWkqpFeaP41U+6lFiCwZ/MV6MNMIDMBJFLhwQS/mPuG8HqioQxHjPumB6w
	fQsjJZjTyrkxZFg750pzJ2sXsEH+YUQ==
X-Google-Smtp-Source: AGHT+IHEeesVRvcHT2MZ+S36Fy/vI5cFW9HEqRTYRecVJqCZglQoD3GIvedDHHifo5ABKKDogMVSkZZwBdHoFKU7ifw=
X-Received: by 2002:a25:680b:0:b0:e02:b745:b2c6 with SMTP id
 3f1490d57ef6-e03c1b7fea7mr1096095276.44.1720088651293; Thu, 04 Jul 2024
 03:24:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFjaU5sU04-aUyfHLhYkR7jSqB18He-aEt=B_C41DkMnvm2zFQ@mail.gmail.com>
In-Reply-To: <CAFjaU5sU04-aUyfHLhYkR7jSqB18He-aEt=B_C41DkMnvm2zFQ@mail.gmail.com>
From: Emanuel Czirai <correabuscar+gitML@gmail.com>
Date: Thu, 4 Jul 2024 12:24:00 +0200
Message-ID: <CAFjaU5vwEQYuWJmKRpu=FRR-EzmfUdbi8znNHABAA5HjXC+opg@mail.gmail.com>
Subject: Re: `git diff`/`git apply` can generate/apply ambiguous hunks (ie. in
 the wrong place) (just like gnu diff/patch)
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I wasn't aware of this until now, but by searching the `bug-patch`
mailing list for the word "ambiguous" I've found only this result from
2011:
https://lists.gnu.org/archive/html/bug-patch/2011-08/msg00007.html
So the idea I've suggested isn't new(I'd guess anyone in this domain
would think of it as a potential solution).
I'll paste the relevant part:

On 08/16/2011 05:22 PM, Junio C Hamano wrote:

Given a patch that is not precise and can apply to multiple places,
"patch" and/or "git apply" can apply it to a place you may not have
intended. It may feel like a bug if that happens to a preimage that is
bit-for-bit identical to the version you prepared your patch is against,
but I would rather think, instead of blaming "patch" and/or "git apply",
it would be more productive to prepare a patch with larger context when
you know that the preimage file you are patching has many similar looking
lines, to make it _impossible_ for it to apply to places different from
what you intended.


Eric Blake<address@hidden>  writes:

Yes, I know that as well - the particular patch that sparked this
thread was ambiguous with three lines of context, but unambiguous with
6 lines, even when an offset still had to be applied. So maybe you
raise yet another feature proposal: What would it take for git to
generate unambiguous patches - that is, when generating a patch with
context, to then ensure that given the file it is being applied to,
then context is auto-widened until there are no other offsets where
the patch can possibly be applied? In other words, if I say 'git diff
HEAD^ --auto-context', then the resulting patch would have
automatically have 6 context lines for my problematic hunk, while
sticking to the default 3 context lines for other hunks that were
already unambiguous. Of course, this only protects you if starting
from the same version of the file (since any other patch can introduce
an ambiguity not present at the time you computed the minimal context
needed for non-ambiguity in your version of the pre-patch file).

And there are links to two issues for gnu diff/patch:
https://savannah.gnu.org/bugs/index.php?34031
https://savannah.gnu.org/bugs/index.php?34032

The first issue has a patch from 2023, but it's unclear to me if this
is at all useful for our issue which seems to be the same as the
second issue(which has no patch).

On git's mailing list (this one), there are over 7000 results for the
word "ambiguous", so I haven't even tried.

On Wed, Jul 3, 2024 at 5:21=E2=80=AFPM Emanuel Czirai
<correabuscar+gitML@gmail.com> wrote:
>
> This doesn't affect `git rebase` as it's way more robust than simply extr=
acting the commits as patches and re-applying them. (I haven't looked into =
`git merge` though, but I doubt it's affected)
>
> It seems to me that no matter which algorithm `git diff` uses  (of the 4)=
, it generates the same hunk, because it's really the context length that m=
atters (which by default is 3), which is the same one that gnu `diff` gener=
ates, and its application via `git apply` is the same as gnu `patch`.
>
> side note:
> `diffy` is a simple rust-written library that behaves (at version 0.4.0) =
the same as normal diff and patch apply(with regards to generated diff cont=
ents and patch application; except it doesn't set the original/modified fil=
enames in the patch), and since my limited experience, I've found it simple=
r to modify it to make it so that it generates unambiguous hunks, as a proo=
f of concept that it can be done this way, here: https://github.com/bmwill/=
diffy/issues/31 , whereby increasing the context length(lines) of the whole=
 patch(though ideally only of the affected hunks) the initially ambiguous h=
unk(s) cannot be applied anymore in more than 1 place inside the original f=
ile, thus avoiding both the diff creation and the patch application from ge=
nerating and applying ambiguous hunks.
>
> But forgetting about that for a moment, I'm gonna show you about `git dif=
f` and `git apply` below:
> 1. clone cargo's repo:
> cd /tmp
> git clone https://github.com/rust-lang/cargo.git
> cd cargo
> 2. checkout tag 0.76.0, or branch origin/rust-1.75.0
> git checkout 0.76.0
> 3. manually edit this file ./src/cargo/core/workspace.rs at line 1118
> or manually go to function:
> pub fn emit_warnings(&self) -> CargoResult<()> {
> right before that function's end which looks like:
> Ok(())
> }
> so there at line 1118, insert above that Ok(()) something, doesn't matter=
 what, doesn't have to make sense, like:
> if seen_any_warnings {
>   //comment
>   bail!("reasons");
> }
> save the file
> 4. try to generate a diff from it:
> git diff > /tmp/foo.patch
> you get this:
> ```diff
> diff --git a/src/cargo/core/workspace.rs b/src/cargo/core/workspace.rs
> index 4667c8029..8f0a74473 100644
> --- a/src/cargo/core/workspace.rs
> +++ b/src/cargo/core/workspace.rs
> @@ -1115,6 +1115,10 @@ impl<'cfg> Workspace<'cfg> {
>                  }
>              }
>          }
> +        if seen_any_warnings {
> +            //comment
> +            bail!("reasons");
> +        }
>          Ok(())
>      }
>
> ```
> Now this is an ambiguous patch/hunk because if you try to apply this patc=
h on the same original file, cumulatively, it applies successfully in 3 dif=
ferent places, but we won't do that now.
> 5. now let's discard it(we already have it saved in /tmp/foo.patch) and p=
retend that something changed in the original code:
> git checkout .
> git checkout 0.80.0
> 6. reapply that patch on the new changes:
> git apply /tmp/foo.patch
> (this shows no errors)
> 7. look at the diff, for no good reason, just to see that it's the same(k=
ind of):
> git diff > /tmp/foo2.patch
> contents:
> ```diff
> diff --git a/src/cargo/core/workspace.rs b/src/cargo/core/workspace.rs
> index 55bfb7a10..92709f224 100644
> --- a/src/cargo/core/workspace.rs
> +++ b/src/cargo/core/workspace.rs
> @@ -1099,6 +1099,10 @@ impl<'gctx> Workspace<'gctx> {
>                  }
>              }
>          }
> +        if seen_any_warnings {
> +            //comment
> +            bail!("reasons");
> +        }
>          Ok(())
>      }
>
> ```
> 8. now look at the file, where was the patch applied? that's right, it's =
at the end of the wrong function:
> fn validate_manifest(&mut self) -> CargoResult<()> {
> vim src/cargo/core/workspace.rs +1040
> jump at the end of it at line 1107, you see it's our patch there, applied=
 in the wrong spot!
>
> Hopefully, depending on the change, this kind of patch which applied in t=
he wrong place, will be caught at (rust)compile time (in my case, it was th=
is) or worse, at (binary)runtime.
>
> With the aforementioned `diffy` patch, the generated diff would actually =
be with a context of 4, to make it unambiguous, so it would've been this:
> ```diff
> --- original
> +++ modified
> @@ -1186,8 +1186,12 @@
>                      self.gctx.shell().warn(msg)?
>                  }
>              }
>          }
> +        if seen_any_warnings {
> +            //use anyhow::bail;
> +            bail!("Compilation failed due to cargo warnings! Manually do=
ne this(via cargo patch) so that things like the following (ie. dep key pac=
kages=3D and using rust pre 1.26.0 which ignores it, downloads squatted pac=
kage) will be avoided in the future: https://github.com/rust-lang/rust/secu=
rity/advisories/GHSA-phjm-8x66-qw4r");
> +        }
>          Ok(())
>      }
>
>      pub fn emit_lints(&self, pkg: &Package, path: &Path) -> CargoResult<=
()> {
> ```
> this hunk is now unambiguous because it cannot be applied in more than 1 =
place in the original file, furthermore patching a modified future file wil=
l fail(with that `diffy` patch, and ideally, with `git apply` if any change=
s are implemented to "fix" this issue) if any of the hunks can be independe=
ntly(and during the full patch application too) applied in more than 1 plac=
e.
>
> I consider that I don't know enough to understand how `git diff`/`git app=
ly` works internally (and similarly, gnu `diff`/`patch`) to actually change=
 them and make them generate unambiguous hunks where only the hunks that wo=
uld've been ambiguous have increased context size, instead of the whole pat=
ch have increased context size for all hunks(which is what I did for `diffy=
` too so far, in that proof of concept patch), therefore if a "fix" is deem=
ed necessary(it may not be, as I might've missed something and I'm unaware =
of it, so a fix may be messing other things up, who knows?!) then I hope so=
meone much more knowledgeable could implement it(maybe even for gnu diff/pa=
tch too), and while I don't think that a "please" would be enough, I'm stil=
l gonna say it: please do so, if so inclined.
>
> Thank you for your time and consideration.
>
>

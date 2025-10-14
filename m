Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DA630F539
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 08:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760429107; cv=none; b=QVgPWafQukhncNkGh6rbXxkz2pQJS8BEsDnX+U5VsiFIxEzaRU94e6rY0tqSBFQ44PjMHhq4BY9UIPkJ9FqNPv7Qw8SbEMW2Kv/KXWOcy4LTdxVryqVjKe1+p0zq2nMfNa4U2f7Ps4xhJdloy12RWwxNKi5Zznyxe0uPyu8h6/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760429107; c=relaxed/simple;
	bh=5gixdJA1792G9/8Q4/PYhKxRofKo+i5puhMhkFpGKY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YbssCUzXt1BKkdwnUfRygdqo4hDf1l7xm5JA8YCMMhd1mBhfR4/v2SrPmp6A4lpz9NCap9IRF42/niDobVFgGvfyn8X16gHRmba4crgEjYa8Kd/h4avfFFbI9YEdCdK+Ye038AAVOQuPWVAcXS/z3AwjFCoe3RVh7dPJ4j5gGjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVKk4vVq; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVKk4vVq"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-875d55217a5so704704485a.2
        for <git@vger.kernel.org>; Tue, 14 Oct 2025 01:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760429105; x=1761033905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uneWgZRXUVwKtHwGx2jgZD7wCwyLwanVJbjO3UCbk4=;
        b=lVKk4vVqqbKaMkNeU5cCqdahWxkOhIRC7C7mk8+PXhMIUEijpv2AP2mQdpLY8xqY53
         vzyFnkBOzi3wUMldqhPXIUIu7F330wGxUalRSKWLfZJ+ME3mKxTLo6/Dl7vY9wNAZ1Xr
         oIqyDUJVRyrAgdQGGPp6ztit9pTEpS9lzWgx7o9jBM457eJm67TXrnr0TgrnB7d12Moc
         f8F7fEhFmpHsJIBBASp/nqmgv8pRstlgfSGtHBJ7IHxepUdF7KcYA5SdRTSPvPiCXult
         dxGNx2Oo8OrTJ9AjBRjcJAsr3BKaA+fsK6v13xaHwjwSRwye9szPLjCI0GakxaTo7UKT
         6VXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760429105; x=1761033905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0uneWgZRXUVwKtHwGx2jgZD7wCwyLwanVJbjO3UCbk4=;
        b=rL+ggbtQS1nQxLkyH2zSvwmYbmDuGWrvslTNN6PnFR6MTdyLNIMTyWIINjFbc5EtnD
         igbmX1H1B5zNQtilESD3Rg8k0Ev/jvT2t1uiV5XkuPPPY9oa4rodnQC/cq0p0Zoq0npy
         y17ksCA0umQ7A9EMsnDAuStA+Lk/kLvKzHqZNzySMaT60kqxE9q+jH/ZnJGpEdj1iWFk
         OvSVPZhfHs1rHV3s8AzkziJC7EBSSFkBPTPm3UFAI+gmxg+l9hPG9tl3cUSGFec8/n/v
         FMymEjXDZbtXzEQSfMgeEFmAt0mdsvcvn2lkDwSS9KZgzfflriCV/KBZGEkXp3X82a2f
         M1rA==
X-Gm-Message-State: AOJu0Ywqaw3i0gzjcQSdgGW86HtT9rfkcvtYyBKL29u3+NEtHjEkagJi
	1NqPQ/KvIbSLTKAorAmHl8khBvW2qF0TjNewJtTlOPns3geqrFAwufbizMhapPvzSW08I2QQu2T
	h24Y7YUr8R3lgTGhTT9e53pc6YZ9g0S4=
X-Gm-Gg: ASbGncurGNtYhKNG1hxtF1awLXRmflUQ0GgbDo4SNqCjsK0OLuMDBmu6XIHktJ9H+Bl
	VAYwN6Z9lwISNGIhbAN0tMVXgsRiqCgCfzWEqHrv57RX+ExulLWC6tIwqTOefDvgHRhSK6uelVP
	rfI8DlYqsBtnIWBjSPEJHIIwUF74EhP1vR9s3D1Ow+wx2fXlbwMsMFSI9wOWdM45TlD1NCjm/nQ
	gYQTxlN9rR5drTURoMyc33SYpnq7lffnujr4xqM3RYKa46/c2NMrKo6b5YiLwKVmWqRDQOhccE=
X-Google-Smtp-Source: AGHT+IFxmlyD9noCJUqCKMR6N7Fz3hYCaHGNQinLTxZlb/6zIKI7UNN3K8pCRvnO7zFyLnjWRqfldprNNICHRUce61g=
X-Received: by 2002:a05:622a:198c:b0:4e0:1bf9:b5c0 with SMTP id
 d75a77b69052e-4e6ead0a593mr288620901cf.32.1760429104997; Tue, 14 Oct 2025
 01:05:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013174658.236940-1-okhuomonajayi54@gmail.com> <xmqqecr6yypu.fsf@gitster.g>
In-Reply-To: <xmqqecr6yypu.fsf@gitster.g>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Tue, 14 Oct 2025 09:04:53 +0100
X-Gm-Features: AS18NWC4LeF-FlfryRfsvDYUyhZt-KRO2fIfm2arebddd_pM5JDxHFAbEjVGtVE
Message-ID: <CAFpMFfCAzT0MoVhWmkkY9osSgZtHyb_95j=JOV5f3-y2bE2EPQ@mail.gmail.com>
Subject: Re: [PATCH] [PATCH] [Outreachy] builtin/patch-id.c: clarify SHA1
 usage for patch IDs
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the explanation!
 I=E2=80=99ll update the patch so it doesn=E2=80=99t touch the_hash_algo gl=
obally, and
instead uses SHA1 only for the patch-ID computation itself. I=E2=80=99ll al=
so
tweak the comment to make it clear that this is just part of the
bigger work to standardize patch-ID handling across Git

On Tue, Oct 14, 2025 at 4:00=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:
>
> > Patch IDs in Git must always use SHA1, regardless of the repository's
> > object hash. Previously, the code relied on `the_hash_algo` which could
> > vary depending on the repository, and included a NEEDSWORK comment
> > suggesting this should be fixed.
>
> I do not think that is what the comment suggests to do.
>
> Read it again:
>
>     ... should be removed in favor of converting the code that
>     computes patch IDs to always use SHA1.
>
> There are code paths that compute patch IDs elsewhere, and they are
> not immediately below the NEEDSWORK comment.  The code relies on
> the_hash_algo and that is why the "hack" makes repo_set_hash_algo()
> call.  The suggestion is to convert that code that hashes patch to
> compute patch IDs not to use the_hash_algo that is repository
> dependeant.  I think get_one_pathcid() function in the same file is
> one of them.
>
> > This patch updates the comment to clearly state that SHA1 is required
> > for patch IDs and sets the hash algorithm to SHA1 if it is not already
> > set. This ensures consistent computation of patch IDs in accordance
> > with git-patch-id(1).
>
> And if it is already set?  I think what your first paragraph claims
> to be problematic is that case, and the patch does not touch that
> case at all.
>
> Blindly setting the_hash_algo to SHA-1 may not be the end of the
> "solution", so whoever wants to work on this needs to be extra
> careful.  If the code after this point, starting from the call to
> generate_id_list() we see in the post context, need to touch any Git
> objects in the current repository (e.g., to obtain patch text or
> some configuration data), such accesses need to use the hash that
> the repository uses.  Only the final "now we have this patch, and we
> learned what the configuration says how we should compute the
> patch-id.  Let's hash the patch text following the specified
> algorithm" step should use SHA-1 as the hash algorithm.
>
> Perhaps we are lucky that this program has *no* need to access
> objects in the repository (my quick scan says this seems to work on
> an external text file and does not generate diffs locally out of
> objects), and it may not depend on configuration data coming from
> any objects in the repository (there are some configuration variables
> whose values are blob object names that instructs Git to read such
> an object).  In such a case, then the solution may be to always
> make the code ignore the_hash_algo and unconditionally using SHA1.

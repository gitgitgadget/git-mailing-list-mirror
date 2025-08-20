Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672DE274651
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 21:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755725268; cv=none; b=THumi6KEpLFmXFMjAM5xNTXb7iscMD0PrYTDJdO2bnStUsuOwcvKaJ0IXr44tZtQQi8VZO5v1p1/Z8y4xgFDtTyEnmEojvv5mdjsJBlSoRPzrARkt59tTMDlfJHz1iV0Qfe0YCWSujnKgnIh3kdmM3nJamprYCJ3dgkSLZ0X+GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755725268; c=relaxed/simple;
	bh=nIBPISyatIiF53JOEuQO3Qo2D8j0eXBgS5ZCvtkeKcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uiuSzCw28jCBw5F0qYEN/TRFY7EJhAgf/gsQKGBraV+MfScdRAmFG/trSb6kk57cit2QevYgS4AxK9V1xvHkUjW50nJN1koc1GwAb1+rgSzcRfFm2pNmRPHCPKGZ2+LnLoJ6hwfn1TD4PspF9yqu4ozBrhujbhVMkWI6XtMkWc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYFau0mS; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYFau0mS"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb72d5409so47146266b.0
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 14:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755725264; x=1756330064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOiA21vWUaq3fsYCSw+hdWxTc4rt6eA4FDCwD2p1EB8=;
        b=YYFau0mSfCZjbFpfxBQqfSecqfDJtKpgB6dLenxjQ9rE5X34YI+kiEiOIi28js11Z3
         Gt3RP2z/9ycBt+0Fk24giDkD+z29R9EMrCXjXi/FhrLN24SUkvaVeF/AtTF/uO6mU78a
         nwGCajwV+7t+K/1Q8eycoAEJ4idfeTRNQaIRxevB/SR+aUENxuWFtRiT9UcnxqUIvVMa
         RUrZWqf3c3xrwuW2wUqOuFKTnNK5PjJ+o243Wk5lo4nm2OAAfthd5KCivIvHPBjQI67i
         Qia5Jo/sK/AEdzJsmTx4MB5SKyFCX+IUffEOjksbhLhcXEKrl3jwDSRJfM1VAAq8wkjp
         9nyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755725264; x=1756330064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOiA21vWUaq3fsYCSw+hdWxTc4rt6eA4FDCwD2p1EB8=;
        b=f664DCiycLFeVIRWC+ZcRST26tqHWBU88+UjVmzzQ2qBBmCQuQ4ekZyG2IzHcLLUZC
         yRx8A/r88PG3PhQKzGwvYCPpD7mAQC3gUvkCxUIdDeUPtj3iQglTzqZOuwVZCjADuMBi
         NBqCUdwpBdNleQXrxZ2dud+3reRb0VbCk77BJXP556cOBk5SnfseU1aCvNgoor/RSlh2
         eL2gZpx/3esHhQIg5p+ARNVUG1ZRm5OQIzlLfUjVEJktqQApqaXrmQd7SuardhWU9fNI
         /V0juZVX2ml3FAaLiE37dzAuBYyj9u7PXdwaltyqVGWUm76Lm3XvnqiZzGyl3ylNBWfE
         oEtg==
X-Gm-Message-State: AOJu0YzuSddjKe7vUx+/uPzgIXBERnvTFbO+jjYIDefLo77N4J2hxyvA
	T0hL4vTXCzN8+XfB0CpgEc9J0iTBr4AfIZJ1QW/RhJlm8fVOJYaVeS0N3/xAHI5uf+Oo73gCF4o
	7KF6bsry6bBUv4f3b2lIR8slDinuVhQkcqCEa
X-Gm-Gg: ASbGncs8UsrKaNvkcAqqS5By7oBhrys7OOv/aaqeAI5FP9ggNE4w9BzdGncoVPByWVh
	MJUIxLbGGG6TX2TLWbGICvNsE7wMIGewpVyEPFXQY/Mk7PJLsXFcvd4OCiaa79s6DE9dD7PEu4a
	tJoi8/ghNZ0sz2sEt1aEfjKqks3NzR2HMnNegHQu+o80HwMlcj8r46WE866zKPp2Oi7WjhpNGNY
	03Ewer9eOB3dhuRqH6gSmjBO7amP9MJZEfPVdJPPS09O9IqOF0=
X-Google-Smtp-Source: AGHT+IHkW9cvDT+ttd/6VRGPBGgJz1D8JrezG77EiZhgYBEGavW4mug1rYUTmkfYJJBrwv21ouFLcjVqTXiAb0OTjMA=
X-Received: by 2002:a17:907:3e0a:b0:af9:2bb9:ea36 with SMTP id
 a640c23a62f3a-afe07ac18f1mr22974766b.7.1755725263636; Wed, 20 Aug 2025
 14:27:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im> <20250819-b4-pks-history-builtin-v1-11-9b77c32688fe@pks.im>
In-Reply-To: <20250819-b4-pks-history-builtin-v1-11-9b77c32688fe@pks.im>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 20 Aug 2025 17:27:32 -0400
X-Gm-Features: Ac12FXx_tYiqXjuAxo8YfFiFcUBqz0walN-Ivl47oJm-B1E-LCW9bkhGppePREo
Message-ID: <CALnO6CBuwDVMZ-QTay+PUiXKsWMsABJcs1pAB=uUXf7-DJ4Mnw@mail.gmail.com>
Subject: Re: [PATCH RFC 11/11] builtin/history: implement "split" subcommand
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 5:05=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> diff --git a/Documentation/git-history.adoc b/Documentation/git-history.a=
doc
> index 6e8b4e1326..f0f1f2a093 100644
> --- a/Documentation/git-history.adoc
> +++ b/Documentation/git-history.adoc
> @@ -47,6 +48,26 @@ reorder <revision> (--before=3D<revision>|--after=3D<r=
evision>)::
>         commit. The commits must be related to one another and must be
>         reachable from the current `HEAD` commit.
>
> +split <revision> [--message=3D<message>] [--] [<pathspec>...]::
> +       Interactively split up the commit into two commits by choosing
> +       hunks introduced by it that will be moved into the new split-out
> +       commit. These hunks will then be written into a new commit that
> +       becomes the parent of the previous commit. The original commit
> +       stays intact, except that its parent will be the newly split-out
> +       commit.
> ++
> +The commit message of the new commit will be asked for by launching the
> +configured editor. Authorship of the commit will be the same as for the
> +original commit.
> ++
> +If passed, _<pathspec>_ can be used to limit which changes shall be spli=
t out
> +of the original commit. Files not matching any of the pathspecs will rem=
ain
> +part of the original commit. For more details about the _<pathspec>_ syn=
tax,
> +see the 'pathspec' entry.

Glossary entry?

> +       /*
> +        * But we do ask the user for a new commit message. This is in co=
ntrast
> +        * to the second commit, where we'll retain the original commit
> +        * message.
> +        */

Interesting. I can see using the original as the template for _both_,
or the first instead of the second. jj's split works a little
differently (especially with their notion of descriptions), so I can't
use them as a reference for the behavior.

I suppose this is one of those "everybody has their preference"
things, but I think giving the message in both new commits as the
template gives splitters the most information available when writing
the message. (Of course, in my editor, I can presumably do something
like ":Git show -s <split-commit-ish>" if I want.)

> +       if (!commit_message) {
> +               split_message_path =3D repo_git_path(repo, "SPLIT_MSG");
> +               strbuf_addch(&split_message, '\n');
> +               strbuf_commented_addf(&split_message, comment_line_str,
> +                                     _("Please enter a commit message fo=
r the split-out changes."));
> +               write_file_buf(split_message_path, split_message.buf, spl=
it_message.len);

I also noticed the commented template differs substantially from the
regular commit template, and my editor doesn't recognize "SPLIT_MSG"
as a commit message file.

The latter can be fixed elsewhere, but for the former: perhaps it's
worth using the usual template with the wording here prepended?
Respecting commit.verbose / commit.status, too.

BTW, if I quit the editor with an error here, I'm left back where I
started. So I'd have to re-stage changes if I wanted to split again,
which is a bit different from how interactive rebase will leave me
with the partially staged changes. Obviously that's harder to do with
the in-memory index + automatic re-application of remaining patch when
finished, so maybe a note in the docs about this being "all or
nothing"?

Best,
D. Ben Knoble

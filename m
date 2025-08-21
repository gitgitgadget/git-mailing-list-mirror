Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5457D20D50B
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 12:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755777857; cv=none; b=bg6R75NZte3LdqvG8Fst3DxSxcCmumNj1daFLfdRMn74CaR0Ayd2VzAqaizVLt8HhU3ERFJn0Ac3t+45IQUQhIUTgfAxSGkan8RDTfcMgvvpAq593z5vDy5QzsROUqLlo6hU+sdFzhKC8lOqyXp46kGhUkvwQoKEe1hsKQqLiYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755777857; c=relaxed/simple;
	bh=GJysM8of32DssOFVH+kjHqfsCvxPBbvjArPTx4U3000=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CkLtLyKmHU3sYiTqTomAVgeCUrpog0IFwIa6Y7MvctFSrRLHkwaWxb1rO0dA/0v85/fQ1eoOeQewgvA0cxYI2lRZY1PXpWuNxAFSgNc9vNPb0+IDpe5FWmVPIztmivxVpZ2nqDkhQcfWQtGdPd19H80xHbzif55sTZmT8CRe+sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baZkqp0p; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baZkqp0p"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e934c8f9757so841059276.2
        for <git@vger.kernel.org>; Thu, 21 Aug 2025 05:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755777855; x=1756382655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AylpGyRQVKEluT2VJMK2TkLtWYwRvWSi+CYNhBXtWkQ=;
        b=baZkqp0p6jHU2NU47EMqrFPi5LEWqB/LWkBsU4X6QdGm08r6NPft3pegjvuYfXx79n
         UDLGXw/eL6i4ixAiXBBdHHga6yZ8XSXoRhx9xGywwibGUtY/eh40hHTPjl4yMoot52c7
         vlg95v8x8hkqsRGxkO2opbL1qWWTeN1TwA3N90ep9w/xanbCo/BMj05siL4Ry3b67uCI
         HnNinm0kfohvTmkzaJv4NCHZaqzFQZI53yeHi5x3UMvXDPfs8Z1bQvZlVJUcgDS8CLhn
         hZVC8xnFoIMy5dRObyVnqa/IKJNdsUc1F1g9uIt35tAfLjgUf4ji3e5vqP0qJEsySDI4
         XYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755777855; x=1756382655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AylpGyRQVKEluT2VJMK2TkLtWYwRvWSi+CYNhBXtWkQ=;
        b=qj3NccnSH//qNKf+8pYw+p1vqPjA365OOQEHflP224WQxsdepGYwqgrRkZVqj+qSmi
         qoM9+jE7xz1/+4b/op1ugRxQqrPyBNunNkZVKqafG5rSJvavM3mQTPPl/UiQH/XkvpJE
         du1tras+bGpyLyl0O+gXJGDiRvpGw2auk3pwysRem1bimWtKXTvxLKPFARgUemXYiFig
         ZCIoJlYQc9M+TGWdVy5epLTl/gg5sbCKXbtLBaV94bGvHC0uyTZSflrEzVAoVw+UdDpi
         nOmmwkMu3hAz/Uupvkw4c2eE+I34/kT1G9vH9jxfOcA++Rsil+GYlSSIx0nDBBM5/Al9
         4uEg==
X-Gm-Message-State: AOJu0YzJo4Fdd8lNVVA5YCPJZMDGAFYGugXF2uwmjNgFvCOWtVCtdVWd
	OzSdqyTy3pC6I3BY+6XLed0HWWJ8YFRnI7GnyFo5OSHsno2sPR/o+KN2tzuKsLCmw/PhsLv+iWE
	Udn4ny1BFeCUNZLxUmuQm9xjpiU+cgf53i1fRrgcfmCPY
X-Gm-Gg: ASbGncvwjaoDIl1orqWTK1RhtMv/of77+JvVPzpFZATWq8CS+P5d7c3E0zoiM1bFGYx
	dAby+XxI/t/Q74eOGxnJ1aiC4t7tRPO7mcQavZxR5TNpOidQLUw9ENinUi78aIKsqFAdHzFHlQt
	fNhXcHcUMTiFB+3kZixyjRgAIF6+f6ugyBnFDCJ2hZO5qBCohpLzZVSJWKWTi5AKWLaAoyO0R/k
	jxWJD9v
X-Google-Smtp-Source: AGHT+IEmKi1lrKuBL29Abkos2DWjKDD4zhVBjn9M0g7Sy3fwbKJ2RCEzBP0wc2p2Gn8Rb+O8NtEie3NCQb2meggzGMk=
X-Received: by 2002:a05:6902:460f:b0:e95:1a34:1fbf with SMTP id
 3f1490d57ef6-e951a3420dbmr39590276.16.1755777854527; Thu, 21 Aug 2025
 05:04:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGedMtd_atWTAQXOPSJThB_tpHiOSY=PUhrfFxFZOEkgUtHf1w@mail.gmail.com>
 <xmqqfrdok1g6.fsf@gitster.g>
In-Reply-To: <xmqqfrdok1g6.fsf@gitster.g>
From: Seyi Kuforiji <kuforiji98@gmail.com>
Date: Thu, 21 Aug 2025 13:04:02 +0100
X-Gm-Features: Ac12FXyeGuaDsaWRXc8wzDiZ-6wyvzpGYbmFQF-RNBIzT-4KtcwwqSmfS6vlMGc
Message-ID: <CAGedMtf2CW_L8uSc1KRqmAoJ=2Sw4t5AL2AC0uKQJb5keX63ZA@mail.gmail.com>
Subject: Re: [FEATURE] Proposal: git format-patch with `--with-line-numbers` flag
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, Taylor Blau <me@ttaylorr.com>, 
	Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Mon, 18 Aug 2025 at 18:02, Junio C Hamano <gitster@pobox.com> wrote:
>
> Seyi Kuforiji <kuforiji98@gmail.com> writes:
>
> > While working on converting unit tests and sending patches, I ran into =
a
> > pain point during review. The reviews by Junio, Patrick, and others poi=
nted out
> > issues in my patches, but without line numbers in the emailed code
> > context, it was sometimes hard to know exactly which line was being
> > referenced. I had to manually count through the diff hunks, which slowe=
d
> > things down.
>
> Count through?  I do not usually see a review that talks line
> numbers (e.g. "your change to line 772 is wrong and should look like
> this"), so I am not sure which review comment against which patch
> you had trouble with.  Can you give us an example or two?  URL into
> the lore archive would be good.
>
> One things I try in my reviews is, even though I trim my quotes
> heavily and leave only the part I comment on, I try to leave the
> filename part (i.e. "diff --git" line) and the hunk header (i.e. "@@
> -L,K +M,N @@" line) in.  See
>
>     https://lore.kernel.org/git/xmqqikla86id.fsf@gitster.g/
>
> for an example.
>
Ah, thanks for the clarification; that makes sense now. Up until this
point, I didn't know the hunk headers "(@@ -L,K +M,N @@ lines)"
provided enough context in terms of the lines the changes were made. I
just never read them and usually just jump to the reviews on the code
changes, and I try to locate the changes locally :(. I agree this
already provides sufficient context, and I've definitely learned
something new here :). I am wondering if a description of this is
covered in our documentation. If not, maybe I could add it, since I
imagine others might have the same question.

> > To address this, I=E2=80=99d like to propose adding an option to `git
> > format-patch` (e.g., `--with-line-numbers`) that would include line num=
bers
> > numbers alongside context lines in the generated patch. This would not
> > affect patch application (`git am` / `git apply`), but would be a visua=
l
> > aid for mailing list readers.
>
> "This would not affect" how?  If you show something like below, it
> would break it so badly that the patch would not apply at all, so
> you may have something else in mind, but I do not know what it would
> be.
>
> diff --git a/t/t0450-txt-doc-vs-help.sh b/t/t0450-txt-doc-vs-help.sh
> index 980130be78..e12e18f97f 100755
> --- a/t/t0450-txt-doc-vs-help.sh
> +++ b/t/t0450-txt-doc-vs-help.sh
> @@ -112,16 +112,19 @@ do
> 112     adoc=3D"$(builtin_to_adoc "$builtin")" &&
> 113     preq=3D"$(echo BUILTIN_ADOC_$builtin | tr '[:lower:]-' '[:upper:]=
_')" &&
> 114
> 115-    # if and only if *.adoc is missing, builtin shall be listed in t0=
450/adoc-missing
> 116-    result=3Dsuccess
> 117+    # If and only if *.adoc is missing, builtin shall be listed in t0=
450/adoc-missing.
> 118     if grep -q "^$builtin$" "$TEST_DIRECTORY"/t0450/adoc-missing
> 119     then
> 120+            test_expect_success "$builtin appropriately marked as not=
 having .adoc" '
> 121+                    ! test -f "$adoc"
> 122+            '
> 123+    else
> 124             test_set_prereq "$preq"
> 125-            result=3Dfailure
> 126-    fi &&
> 127-    test_expect_$result "$builtin appropriately marked as having miss=
ing .adoc" '
> 128-            test -f "$adoc"
> 129-    '
> 130+
> 131+            test_expect_success "$builtin appropriately marked as hav=
ing .adoc" '
> 132+                    test -f "$adoc"
> 133+            '
> 134+    fi
> 135
> 136     # *.adoc output assertions
> 137     test_expect_success "$preq" "$builtin *.adoc SYNOPSIS has dashed =
labels" '

There isn't a need anymore for my proposed changes to the way `git
format-patch` operates.

Best regards,
Seyi Kuforiji

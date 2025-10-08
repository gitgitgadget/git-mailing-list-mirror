Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9681C2BDC25
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 03:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759895875; cv=none; b=ZSwN0ou/Am5wv+bw8jnyeFF8zWv787D5C76mWISZBYCEfE+xKDoaBfLvvz1/I4TSDqQFJ2YPokptH8wRtT8lEXbvT51itwG4s0XYo7CcfBh0Q//91B85HXkbHnskfpm/KwuAiLUTrkY7HtpKefYehCbi3lDpN9PpNZTaQyG6+tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759895875; c=relaxed/simple;
	bh=HzuXmlJVtd9i862QK6lz4n+4oJ5MZsyS57CdW/GyJ2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pePo/mNKu9SA71A0L1/5Epyd/MR7yOejPlIRExtsqLFRtteo203+6Q11lgbAlzgNhFWyLL9PX91iTspjpGjsdx3jnjR+2T7l7VQ2kI1GcTeEyd/4t5Z+bgT1zRmX0m6pbcty2YCLsFKvLIKppnQRuhNbpAiTvHV8oRgJUi4+g0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhTdF/hJ; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhTdF/hJ"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-9298eba27c2so299787239f.3
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 20:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759895872; x=1760500672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PJsSsWPqhakJCc0wnPkvEdZna8CmSxyTI8H4TcCAI4=;
        b=VhTdF/hJNDT2cPzbMnvhw+oNsFtGWkkLYfS9RqqmSJzTwBx3X6/mOSSNdz4pQqshie
         Zq32xvjARog/e2W3uq+WeFCr5X9rOFTUMoTMW/IaQjO2Zh6s5rzDjkdZu1ask+QudOCm
         NzuxCQ5iAAOd1e1WWsyiuFOptci+nDbyCZU5XjQZ1G8aTpx9ORm4ZqPUdLO+moryVRh8
         0lgpglJqAdB8wdSAdiQ5aurq9zQOifyi0DnE7B6JpXlEFn6vJTjsnNORwU/KdwjgpLAV
         xEws6YW6o1x3gbk1S8FkDSedmkrE+A1+2JN/2wpWu5h6DhvJrsIO0AUoq4Ko1x6QbglA
         1SmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759895872; x=1760500672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4PJsSsWPqhakJCc0wnPkvEdZna8CmSxyTI8H4TcCAI4=;
        b=m1u0rkHNiVWq9X6xpANOH6hKLun+PMMB2BMZIW37guS0Ksl4eZQEKiSQ3UKAOogE1/
         Hh0UxpRgnShedPh10rEohx2zpqy4g4dD5PF5Jlb87SKG//oYI/HCmMm7jsQyhUzrEHqU
         NYanx/Jl9WJRdYQmJf3t3h2yQgLP20PABZUbxOPYpy5MvpAl0wRn3iO5GEt97J3CdNbd
         ej2X5YpzIzRApibC6eqT/usjPLCJx/W1Zt+JyAs6y1jECF7eiv8zOTHzUEd5swfce+2a
         lRtui1wYneD653+ekUNOmL4X7oJx8DrgryfY1CFSNsBJmwKULjaDGHFYVkvaIwVr5E2o
         9uiw==
X-Gm-Message-State: AOJu0Yy5Ox+S01atWyuOYGwhWdvzTnGYoxkzTzjjBhQ0C63tN3YwyeFE
	C6mIT76ror4cGT/4wgqUh/LFtWlDvs9DdKwS9JipgdUY783OiRxgl7VTaQ09RvbPddbnLDZuCat
	YpAwP6uZI9noXg8AwBv+OiSEpNBWBJpK7GQ==
X-Gm-Gg: ASbGnctTZg/blAzeQO6pOXsYAO7jj1IrUA0Fnv4RlbyLK6euYTBK/XXk3dWBecekLu+
	DuyYto1S1EAN5Wp6wL6sM/kk3uDfUuP2dQhYTRXIzEWpAeWqG1c4B2O8lVTB/sIvGq+BIDb8bXy
	bU+A3SE+Nca4VHqigH2y/Dx26xFbyUonI3wWI8NJXqwMjhd+VgZaHjUKkc/3ZW8xjZRcgQTdmsE
	aBMNIz+U/lihIdnCPHM96TO+dAk5RSz5bvAWW82nSiRFt0Sd469mNGAd0ltLQVd
X-Google-Smtp-Source: AGHT+IE3SeMnQ+NbW2VQxFtqMBnwSCVDjuQuZpka+/M7jtvvolPVPXb8ROEEFU/d51NxDQ5IPSi8VzFw+SEyAmZ3JrA=
X-Received: by 2002:a05:6e02:2164:b0:42b:2f98:3fc2 with SMTP id
 e9e14a558f8ab-42f873ec98bmr17135765ab.17.1759895872498; Tue, 07 Oct 2025
 20:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002221233.541844-1-ramsay@ramsayjones.plus.com> <20251002221233.541844-4-ramsay@ramsayjones.plus.com>
In-Reply-To: <20251002221233.541844-4-ramsay@ramsayjones.plus.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 7 Oct 2025 20:57:41 -0700
X-Gm-Features: AS18NWADVyv6ifUeB8NnIaswa1jwpUpMo35Z1cm6HKMiVpj2bIF2CN9oVtOBHqc
Message-ID: <CABPp-BEYF6MdcaXU1qAYctRBAt754j7PGkE3Tgjmm03bBkBjNQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] doc: sparse-checkout.adoc: fix asciidoc warnings
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>, Derrick Stolee <stolee@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 3:13=E2=80=AFPM Ramsay Jones <ramsay@ramsayjones.plu=
s.com> wrote:
>
> Both asciidoc and asciidoctor issue warnings about 'list item index:
> expected n got n-1' for n=3D1->7 on lines 928, 931, 951, 974, 980, 1033
> and 1049. In asciidoc, numbered lists must start at one, whereas this
> file has a list starting at zero. Also, asciidoc and asciidoctor warn
> about 'section title out of sequence: expected level 1, got level 2'
> on line 17. (asciidoc only complains about the first instance of this,
> while asciidoctor complains about them all, on lines 95, 258, 303, 316,
> 545, 612, 752, 824, 895, 923 and 1053). These warnings stem from the
> section titles not being correctly nested within a document/chapter
> title.
>
> In order to address the first set of warnings, simply renumber the list
> from one to severn, rather than zero to six. Fortunately, this does not
> require altering additional text, since the enumeration of 'Known Bugs'
> is not referred to anywhere else in the document.
>
> In order to address the second set of warnings, change the section title
> syntax from '=3D=3D=3D title =3D=3D=3D' to '=3D=3D title =3D=3D', effecti=
vely reducing the
> nesting level of the title by one. Also, some apparent (sub-)titles are
> not marked up with sub-title syntax, so add some '=3D=3D=3D ' prefix(s) t=
o the
> relevant headings.

Kinda surprising; if it's complaining about lack of title nesting, I'd
think you'd need a '=3D title =3D' somewhere before using '=3D=3D title =3D=
=3D'.
Maybe jumping skipping one nesting level it's fine with, but skipping
two is where the problem starts?  No idea.

> In addition to the warnings, address some other formatting issues:
>
>   - the use of heavily nested unordered lists is not reflected in the
>     output (making the file totally unreadable) because each level of
>     nesting requires a different syntax. (i.e. replace '*' with '**'
>     for the second level, '*' with '***' for the third level, etc.)
>   - make use of literal blocks and manual indentation to get asciidoc
>     and asciidoctor to display even remotely similar output.
>   - make use of labelled lists, in some places, to get a similar looking
>     output to the input, for both asciidoc and asciidoctor.
>   - replace the trailing space in: `git grep ${SEARCH_TERM} OLDREV `
>     otherwise the entire line in which that appears is removed from
>     the output.

Again, sorry for putting you through all this; I had assumed
Documentation/technical/ was stuff meant for other Git developers to
see and didn't need to be typeset with asciidoc or asciidoctor and had
never attempted to run the documents I added there under either.
Someone else renamed them to .adoc...


I skimmed through the document, and it all looked like typesetting
changes which don't impair the readability of the source text, so
seems fine to me.  (Same with the previous patch)

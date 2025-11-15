Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2CF1DE4E1
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 23:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763249616; cv=none; b=W8StMuxZXyvxFoHuV0VrxrHCxE6khOa9BYArHofb+LL+dZatCYlzkm8nikfy3+chExcH6gObnXCK9Gs4TCOrSON12qJevu/9DnW77dkBSZIuAy9Lago0qhRwPaFR5FeZfEhNCu7D2VcXX0nGFpnMjkIjOdYFKQPGV4EUFGuKf2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763249616; c=relaxed/simple;
	bh=yTlDp15ZkfTklttvBgR41ZCDna/kQwFLvuIRshn6obk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dkLmv8ogXNo9ywm10RR9Oy/pr5wxHjY6iLwyAS9uiwtRY9pULQEeQseF0u5GpJDYTXezcYP71b8lc+D0iW0XMDK3+8cf8i91OuqIufrBqH5vPZnrLtz/2Y1KNvd+831lVNAHnNx3qQpQU5IQPcTNbYKwTyj9uKHXb/ls0smcQo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sympoiesis.com; spf=pass smtp.mailfrom=zeta-soft.com; dkim=pass (2048-bit key) header.d=zeta-soft-com.20230601.gappssmtp.com header.i=@zeta-soft-com.20230601.gappssmtp.com header.b=cG9YBbYU; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sympoiesis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zeta-soft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zeta-soft-com.20230601.gappssmtp.com header.i=@zeta-soft-com.20230601.gappssmtp.com header.b="cG9YBbYU"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b73669bdcd2so364867166b.2
        for <git@vger.kernel.org>; Sat, 15 Nov 2025 15:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zeta-soft-com.20230601.gappssmtp.com; s=20230601; t=1763249612; x=1763854412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cn0P261hgL8IIgIE6kGpHxIWMWOugXiAOzW7f6dx0DQ=;
        b=cG9YBbYUaU+mHLaWraKxRWb9D4oOzwuDlWE7jrq86accYq/8uBpzkp1wSUl88FGZnH
         tTcc3Sc7tRuOEp9NQ59r+x550Sa+J9Nf/XrPd6A8pnalGWniOcR80/LDlGFcp+04ZPra
         04TZouWijef1OFx1Y5WAMNfZxxWwa6c6Y0RM94wnIk3N+dTmd2i8HHBIWHhGOsc6oj8i
         tRbKBhC+cAbOSp8bPxnmu2pKF0wc4/eOtz7uuRUdwWgjzgP9y8j3enmTO/ZYxZQWA4rm
         IK07MqhPrFgQrGDCCXog4NRoizmevjpoz6qW5mep6xO5aCeCQG0O6a3tKFo7YBSnT9hT
         O8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763249612; x=1763854412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cn0P261hgL8IIgIE6kGpHxIWMWOugXiAOzW7f6dx0DQ=;
        b=hmU/sgNGEyMENGgC2/DkTlguddI1C1c779QMRHnIm30Dhyn86hqB+UtzSDWEb71AeO
         8YQLcXUyN7jET2QNo/c7EDkcF2l4MG5vfnOIs6n7QpwMA+XB4CTQ1J4zI3eEV5PqIg1G
         yDQcxqG3x6glzO2CPfgLPM6UMZty2rS3F71FFvBR0xzROaUs3rXyNJ68z++LB0kL4Ykq
         k0UcdRqmzx4rtIa8rwb+9ekX0Cz+6nVSMFair5bJSf44Vj9ZXrneJRYRCJM7bEPYoZr8
         STFqJZqaVNyV0Zq1azmucICCKkBrphoXtgDWYtG6U6hgbrJmSDYJZuYrmjRwiVw/XoMj
         b15A==
X-Forwarded-Encrypted: i=1; AJvYcCXdYjnppggX4JQukTCyPqrNb8ROwWr2wqI67Q8CinzT3Vcwr6Wn7n8FqaS0wG8xP2e4qGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7rIv6b1nrFkm0pY7KjWIsVN2YsSVAPD08JOtKt/eMZbQdtqHs
	imWW62YarSa+7icrLaNRkwvbB6me7iXOGO70JrW32QyNFXzbnZJ0jcZfA0QB6hCTMz1Vm0tBPpV
	zaWeTgMZE+94m6fewwmZji1j/7ChbRKIoa9J/NecxSA==
X-Gm-Gg: ASbGnctaFzoszG2R5btl8+d6oSpkTmYqd9pXSYNILWsSuQhsc55XB8OQ4BBbS3ZstEp
	dj20oSj/a3KtZg+MQuSIozGly1BJp9tcFIgoQ9jGatDPsooj2AKCT6pEw8lubl50eD2vszC7sPV
	goKwXxvUSz2Bd2XdkF2tBWZQDLLZ+SjNwHsfWI5w4/KOWqAOHNMvb2nP+p37ogL4cAQiITFeAAp
	mfKNu0w9PZW3k8XQ4YlAytdvMYVTk16eMzDONsu981FHrC9YoQWC0Qw1H0pLYl7Fp0=
X-Google-Smtp-Source: AGHT+IHlB3k5jcamtC/KaSupG/qeIDstpvo9a2i/ArGEo6lDRnvXSEofDGG2Pu6ojnqEmZ4DGewP10IA6JCMYQHOCcc=
X-Received: by 2002:a17:906:b74e:b0:b73:7bef:dab9 with SMTP id
 a640c23a62f3a-b737befdb8bmr293567866b.39.1763249611839; Sat, 15 Nov 2025
 15:33:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2000.git.1763201865025.gitgitgadget@gmail.com> <773d3233-c890-4df9-8f7e-32ff8a48651e@kdbg.org>
In-Reply-To: <773d3233-c890-4df9-8f7e-32ff8a48651e@kdbg.org>
From: "Scott L. Burson" <Scott@sympoiesis.com>
Date: Sat, 15 Nov 2025 15:32:54 -0800
X-Gm-Features: AWmQ_bkCzRZ8WDNB21dHj6ZSlmW3b55V6Cc0FU4Kye9RyKotto2jwfHUi-GdVOs
Message-ID: <CAF5LJ4D4q2S2VFhvEgVOe1Ar0e6cu=H3e_o_98VwHN7wYHh+DQ@mail.gmail.com>
Subject: Re: [PATCH] diff: "lisp" userdiff_driver
To: Johannes Sixt <j6t@kdbg.org>
Cc: Junio C Hamano <gitster@pobox.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Jaydeep P Das <jaydeepjd.8914@gmail.com>, Atharva Raykar <raykar.ath@gmail.com>, git@vger.kernel.org, 
	"Scott L. Burson via GitGitGadget" <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 9:06=E2=80=AFAM Johannes Sixt <j6t@kdbg.org> wrote:
>
> [Cc the author of the Scheme driver]
>
> Am 15.11.25 um 11:17 schrieb Scott L. Burson via GitGitGadget:
> > From: "Scott L. Burson" <Scott@sympoiesis.com>
>
> Please
> add a lot more details why the Scheme driver is unsuitable for Lisp and
> why a new driver is needed.

Here is text I propose for the commit message:

----
Common Lisp has top-level forms 'defun' and 'deftype' that are not
matched by the current Scheme pattern.  Also, it is more common when
defining user macros intended as top-level forms to prefix their names
with "def" instead of "define"; such forms are also not matched.  And
some such forms don't even begin with "def".

On the other hand, it is an established formatting convention in the
Lisp community that only top-level forms start at the left margin.  So
matching any unindented line starting with an open parenthesis is an
acceptable heuristic; false positives will be rare.

However, there are also cases where notionally top-level forms are
grouped together within some containing form.  At least in the Common
Lisp community, it is conventional to indent these by two spaces, or
sometimes one.  But matching just an open parenthesis indented by two
spaces would be too broad; so the pattern added by this commit
requires an indented form to start with "(def".  It is believed that
this strikes a good balance between potential false positives and
false negatives.
----

I discussed the pattern with some other experienced Common Lisp
developers on a mailing list, and this is what I settled on after
incorporating their feedback.

> It is customary to mark changes to the drivers in the subject line with
> "userdiff:". Have a look at `git log userdiff.c`. It would be
> appreciated to stay away from nerdy tokens like "userdiff_driver" when
> the change can be summarized in plain English language.

Will do.

> >
> > Signed-off-by: Scott L. Burson <Scott@sympoiesis.com>
> > ---
> >     diff: "lisp" userdiff_driver
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2000%=
2Fslburson%2Flisp-userdiff_driver-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2000/slb=
urson/lisp-userdiff_driver-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/2000
> >
> >  userdiff.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/userdiff.c b/userdiff.c
> > index fe710a68bf..e127b4a1f1 100644
> > --- a/userdiff.c
> > +++ b/userdiff.c
> > @@ -249,6 +249,14 @@ PATTERNS("kotlin",
> >        "|[.][0-9][0-9_]*([Ee][-+]?[0-9]+)?[fFlLuU]?"
> >        /* unary and binary operators */
> >        "|[-+*/<>%&^|=3D!]=3D=3D?|--|\\+\\+|<<=3D|>>=3D|&&|\\|\\||->|\\.=
\\*|!!|[?:.][.:]"),
> > +PATTERNS("lisp",
> > +      /* Either an unindented left paren, or a slightly indented line
> > +       * starting with "(def" */
> > +      "^((\\(|:space:{1,2}\\(def).*)$",
>
> Compared to the Scheme driver, this regular expression is
>
> - more restrictive because it does not permit arbitrary indentation;
>
> - less restrictive because it permits everything that begins with "(def".
>
> What would happen if this regular expression were added to the Scheme
> driver? Would it pick up additional and unwanted hunk headers is typical
> Scheme code?

That is a good question.  I don't think so, but I don't work in Scheme.
I see that you have CC'ed Atharva Raykar; let's see whether he would
have any objection.

I would point out that Scheme is a dialect of Lisp, not the other way
around.  (Lisp is unusual in being a family of languages, rather than a
single language.)  And having a separate "lisp" driver might aid
discoverability.

But I understand: Scheme got their driver in first, and you have to fight
against the tendency of the driver list to grow unboundedly.

Ooh, that reminds me: if we do decide to add a "lisp" driver, I'll also nee=
d
to add it to 'Documentation/gitattributes.adoc'.

> The string literal for hunk headers can contain "\n"

Noted.

> > +      /* Common Lisp symbol syntax allows arbitrary strings between ve=
rtical bars */
> > +      "\\|([^\\\\]|\\\\\\\\|\\\\\\|)*\\|"
>
> The Scheme driver has an similar description of this word token, but it
> has only half as many backslashes. Is the difference necessary? Isn't
> actually one or the other incorrect? (I did not try to understand what
> this version here does.)

It's not important, but technically, Common Lisp allows an escaped
backslash between vertical bars, but the R7RS formal grammar does not.
However, I just tried Chicken Scheme, which claims to be at least
partially R7RS compliant, and it does accept the escaped backslash.  I
am left to conclude that Scheme implementors think that the omission
of the escaped backslash from the R7RS formal grammar is an oversight
(I think so too).

Of course, no one would actually write a symbol name with an escaped
backslash in it unless they were submitting to an obfuscated Lisp
contest.  So we are really being pedantic here.  Still, may as well allow
it.

Atharva, any comments?

-- Scott

Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFF21EA7E6
	for <git@vger.kernel.org>; Sat, 10 May 2025 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746877614; cv=none; b=InX9vS8dozoGYu64GTXtCAzhizmqbUvoRd+ZfGtWiic5IpCw/3NY4iF8PfG2qHwy+uJIjChy50fg20Wcj1fXIT6TTHzns7KBuhVEU5EIJ3Z9IhQR/qSzlEWepIlDRlaVwuAovARGuEffBlc1YLqNNNOK25MQroqOLUac2anhDyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746877614; c=relaxed/simple;
	bh=qwCXehBqsG/dh+CR15Zy1tT/+5iBDsGt1VfEEtkHsIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JxFRA9XVpfYtCUBoSj14ESYExilCDuu4aL5iNd29d2xCtMD0gJaagRu+a9ZE7W96qyfUheCmftUhfLVYSzrPdK8lvqX5uOZmshkFuVWrF7y7xUNcKN9PIWHlD/+G2S4zYXwXtzQfR0PNBkRxYn48ndPnyYEPDNo9c9fx6HsgzhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ciFE81cg; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ciFE81cg"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2d060c62b61so3113562fac.0
        for <git@vger.kernel.org>; Sat, 10 May 2025 04:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746877612; x=1747482412; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k+p0jrJR+MkkgnX7XZDspznJPs97lS/2FV5Dy98UwSM=;
        b=ciFE81cgGQQlstNT1+bQR7xoDtwkXqKxF1HM3bDzWKy1VXiyNh1BrhVtwDkz37Obbo
         I3etEMjpNCRTj+JnIXP719zYzRsKyfAzaoBW6oHl48B/ExcMhxiatxCYP2+IpSGFbgrI
         J2xhpOuTFIuGa79bbu3W+Z6VzOQGMgvwNAPswYZ6NfIzwEHRzxummpn360C9nOJ3XyVD
         2PIkRYrXwdSS2DzHWBPPMOvzYMjw7WJlsHshZMuZ5djDtdfwx6OKYB6df6ODkyUePv/J
         9d+5fF00Jm1waeH8vbALWTuNTWUt1/XlAArvZMdtxwxokLJOslBzbdobTq6DTyMpNkSG
         KAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746877612; x=1747482412;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+p0jrJR+MkkgnX7XZDspznJPs97lS/2FV5Dy98UwSM=;
        b=GF0D+oH+xJbBevUrqkNiVSLaT7hSwgKqwtQRRU6SxQMEpViaTtoXsJQs778VLwNtvr
         8EUKKu2uLII3vlol9Xm3z/s6gYypfi3XNERT2/CA34ZCMhfYKxUC1ghUCbAp3/72zgaN
         XPRZFrDDG6/X2+cuVL7iTLyOqUd/JkqCPFjVW9TtZoVCWRieYNzmCJJxvmq6YZvSGuu+
         n5kPZ3dnH+h6PDY/vGUtfDj5VxFze6n9QGmjzITE5VWivBEQD6nekEuy50cuMXiT5cd9
         6LtYY2FbXh5RrwOpZcTiELwgDZZeeZ1jddEsoXyphduUhJCi3zqcOX0sYSK1/LJ6BpiV
         WqXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2qba9TTYPsMe8QviNDACA6d1hqzwTAmB7gX/hjwcB7tBgKdLroUp33JZI6JB/4shO9Io=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn+x4lvnGz7gOtAnaWI8R1sr2OLcfapn0ADzRT42C5W/GMjebB
	EPPtIyZvMC9+3ZJl/7EjqykzuDJ/hUfKLolweL0y5GxGlOWsOX9ZUOl4aOqb8sTmmgFDOzkavzy
	+xLLzwmInUU+czyyRrcYjVhmskYA=
X-Gm-Gg: ASbGncvHwftvzCCx+tqv426COO8QWTR7vqUFBf5NLmrHetALlq+EmGdKitcvJir5goc
	Wg0ZiB1+1dzuRN5K+kv/G+r1DaQd+yYKNxqbEHDhFqc6kTqd96/VdJomBZ8qgpIizoOSf9CNllm
	gd/vEiGoZ3Sq+sTyz2aY72RQZUQsQDnFnE6TTvChC8u0/l0ISd6Q9rsx9jEAzHk7Nijbk=
X-Google-Smtp-Source: AGHT+IGD/lLJe9U1q6abkBB3pJX5UST6GWRvQkgFlws65M9NTphkyXB+Sd95uP9EOAGfI/TS64XLONNF9bWdeguVxA8=
X-Received: by 2002:a05:6870:e994:b0:2d5:4898:fbe8 with SMTP id
 586e51a60fabf-2dba4277d4emr3771770fac.13.1746877611831; Sat, 10 May 2025
 04:46:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328200525.4437-1-dhar61595@gmail.com> <20250330134018.9662-1-dhar61595@gmail.com>
 <20250330134018.9662-2-dhar61595@gmail.com> <9d548d94-eed8-434a-a9ef-67df694c5c79@kdbg.org>
In-Reply-To: <9d548d94-eed8-434a-a9ef-67df694c5c79@kdbg.org>
From: MOUMITA DHAR <dhar61595@gmail.com>
Date: Sat, 10 May 2025 17:07:30 +0530
X-Gm-Features: AX0GCFtd-682lvVIyc6BGGxFZazVvkicxML4soNsroZbzJ_xUBecs3rOUjUJ2vI
Message-ID: <CAF=ncLbaxYPRx79wYVgpMFuV7UGSObMD+A3zTssWvtVJmXHXVg@mail.gmail.com>
Subject: Re: [PATCH v4 1/1][GSOC] userdiff: extend Bash pattern to cover more
 shell function forms
To: Johannes Sixt <j6t@kdbg.org>
Cc: Eric Sunshine <sunshine@sunshineco.com>, Junio C Hamano <gitster@pobox.com>, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Atharva Raykar <raykar.ath@gmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 May 2025 at 22:00, Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 30.03.25 um 15:39 schrieb Moumita:
> > From: Moumita Dhar <dhar61595@gmail.com>
> >
> > The previous function regex required explicit matching of function
> > bodies using `{`, `(`, `((`, or `[[`, which caused several issues:
> >
> > - It failed to capture valid functions where `{` was on the next line
> >   due to line continuation (`\`).
> > - It did not recognize functions with single  command body, such as
> >   `x () echo hello`.
>
> Good.
>
> > Replacing the function body matching logic with `.*$`, ensures
> > that everything on the function definition line is captured,
> > aligning with other userdiff drivers and improving hunk headers in
> > `git diff`.
>
> Personally, I am a bit allergic against marketing speak. *Of course* do
> we intend improve the code. No need to mention it.
>
> > Additionally, the word regex is refined to better recognize shell
> > syntax, including additional parameter expansion operators and
> > command-line options, improving syntax-aware diffs.
>
> Good. (But see above about "improving".)
>
> > Yes I will be careful about the commit messages.

> > Signed-off-by: Moumita Dhar <dhar61595@gmail.com>
> > ---
>
> > diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
> > index f51d3557f1..0be647c2fb 100755
> > --- a/t/t4034-diff-words.sh
> > +++ b/t/t4034-diff-words.sh
> > @@ -320,6 +320,7 @@ test_expect_success 'unset default driver' '
> >
> >  test_language_driver ada
> >  test_language_driver bibtex
> > +test_language_driver bash
> >  test_language_driver cpp
> >  test_language_driver csharp
> >  test_language_driver css
>
> Including a test for word-diff is very much appreciated!
>
> > diff --git a/t/t4034/bash/expect b/t/t4034/bash/expect
> > new file mode 100644
> > index 0000000000..a0f7cbd5a3
> > --- /dev/null
> > +++ b/t/t4034/bash/expect
> > @@ -0,0 +1,30 @@
> > +<BOLD>diff --git a/pre b/post<RESET>
> > +<BOLD>index 09ac008..60ba6a2 100644<RESET>
> > +<BOLD>--- a/pre<RESET>
> > +<BOLD>+++ b/post<RESET>
> > +<CYAN>@@ -1,25 +1,25 @@<RESET>
> > +<RED>my_var<RESET><GREEN>new_var<RESET>=10
> > +x=<RED>123<RESET><GREEN>456<RESET>
> > +y=<RED>3.14<RESET><GREEN>2.71<RESET>
> > +z=<RED>.5<RESET><GREEN>.75<RESET>
>
> OK.
>
> > +echo <RED>$USER<RESET><GREEN>$USERNAME<RESET>
>
> This tests a typical variable expansion. Good.
>
> > +${<RED>HOME<RESET><GREEN>HOMEDIR<RESET>}
>
> A more elaborate variable expansion does not include the surrounding ${
> }. Good.
>
> > +if [ "<RED>$a<RESET><GREEN>$x<RESET>" == "<RED>$b<RESET><GREEN>$y<RESET>" ] || [ "<RED>$c<RESET><GREEN>$x<RESET>" != "<RED>$d<RESET><GREEN>$y<RESET>" ]; then echo "OK"; fi
>
> This line also only tests variable expansions and is quite redundant. It
> could test the operators that we see, but it doesn't. See below for
> ideas how to do that.
>
> And all from here...
>
> > +((<RED>a<RESET><GREEN>x<RESET>+=<RED>b<RESET><GREEN>y<RESET>))
> > +((<RED>a<RESET><GREEN>x<RESET>-=<RED>b<RESET><GREEN>y<RESET>))
> > +$((<RED>a<RESET><GREEN>x<RESET><<<RED>b<RESET><GREEN>y<RESET>))
> > +$((<RED>a<RESET><GREEN>x<RESET>>><RED>b<RESET><GREEN>y<RESET>))
> > +${<RED>a<RESET><GREEN>x<RESET>:-<RED>b<RESET><GREEN>y<RESET>}
> > +${<RED>a<RESET><GREEN>x<RESET>:=<RED>b<RESET><GREEN>y<RESET>}
> > +${<RED>a<RESET><GREEN>x<RESET>##*/}
> > +${<RED>a<RESET><GREEN>x<RESET>%.*}
> > +${<RED>a<RESET><GREEN>x<RESET>%%.*}
> > +${<RED>a<RESET><GREEN>x<RESET>^^}
> > +${<RED>a<RESET><GREEN>x<RESET>,}
> > +${<RED>a<RESET><GREEN>x<RESET>,,}
>
> ... to here also only test variable expansions, but not the operators.
> As written, they are totally redundant and should be dropped or improved.
>
> To test, for example, that '##' is kept together as an operator, you
> have to have
>
>    ${x#*/}
>
> in the pre-image and
>
>    ${x##*/}
>
> in the post-image, so that we see
>
>    ${x<RED>#<RESET><GREEN>##<RESET>*/}
>
> in the result. If '##' were two tokens (due to a bug in the pattern), we
> would see
>
>    ${x#<GREEN>#<RESET>*/}
>
> in the result.
>
> You should go through all not-single-character operators and have a
> pre-image and a post-image where one characters is added or removed. The
> following is not a correct test:
>
> pre:    ((x+=b))
> post:   ((x-=b))
> result: ((x<RED>+=<RESET><GREEN>-=<RESET>))
>
> because we would see this result even if the pattern has a bug that
> recognizes only one of += or -=, but would split the other one. A
> correct test would be:
>
> pre:    ((x+b))
> post:   ((x+=b))
> result: ((x<RED>+<RESET><GREEN>+=<RESET>))
>
> > +${!<RED>a<RESET><GREEN>x<RESET>}
>
> Here, you should have no '!' in the pre-image and the '!' in the post
> image and not change the name. Then the test demonstrates that '!' is
> its own token and not merged with '${' (if that is the intent of the
> test; otherwise it is a redunant test).
>
> > +${<RED>a<RESET><GREEN>x<RESET>[@]}
>
> If you want to test that '@' is not merged with the brackets, then you
> can have, for example '*' in the pre-image and '@' in the post image.

>
> > +${<RED>a<RESET><GREEN>x<RESET>:?error message}
>
> Either redundant or another two-character operator to test.

Ok I got it.
>
> > +${<RED>a<RESET><GREEN>x<RESET>:2:3}
>
> Redundant.
>
I understand I will remove it.

> > +ls <RED>-a<RESET><GREEN>-x<RESET>
> > +ls <RED>--a<RESET><GREEN>--x<RESET>
>
> Both are good tests.

Thank you. I understand the suggestions about the word diff tests and
I will remove the redundant ones and write the correct tests .
>
> > diff --git a/userdiff.c b/userdiff.c
> > index 340c4eb4f7..4c77c7e0f6 100644
> > --- a/userdiff.c
> > +++ b/userdiff.c
> > @@ -64,15 +64,27 @@ PATTERNS("bash",
> >            /* Bashism identifier with optional parentheses */
> >            "(function[ \t]+[a-zA-Z_][a-zA-Z0-9_]*(([ \t]*\\([ \t]*\\))|([ \t]+))"
> >        ")"
> > -      /* Optional whitespace */
> > -      "[ \t]*"
> > -      /* Compound command starting with `{`, `(`, `((` or `[[` */
> > -      "(\\{|\\(\\(?|\\[\\[)"
> > +      /* Everything after the function header is captured  */
> > +      ".*$"
>
> I remember suggesting to capture everything after the function header.
> However, If I am not mistaken, this does not do what I intended (and as
> written it means that a pointless matching operation happens). The hunk
> header shows everything that is in the outermost parentheses (group).
> This catch-all, however, is even outside the outermost group and not
> captured. It should be above the closing parenthesis that we see in the
> context.

> I am sorry I want to understand a thing  , we want everything from the function name to the end of the line to be the hunk header right ? So in the pattern "^[ \t]*"
/* Start of captured text */
"("
"("
     /* POSIX identifier with mandatory parentheses */
     "[a-zA-Z_][a-zA-Z0-9_]*[ \t]*\\([ \t]*\\))"
"|"
     /* Bashism identifier with optional parentheses */
     "(function[ \t]+[a-zA-Z_][a-zA-Z0-9_]*(([ \t]*\\([ \t]*\\))|([ \t]+))"
")"
/* Optional whitespace */
"[ \t]*"
/* Compound command starting with `{`, `(`, `((` or `[[` */
"(\\{|\\(\\(?|\\[\\[)"
/* End of captured text */
")"
if I replace
"[ \t]*"
"(\\{|\\(\\(?|\\[\\[)"  part with .*$ then will it not capture the
entire line ? I mean the outermost group ends here-

 /* End of captured text */
")"
right ? What am I getting wrong ?

> To test for this, you can have one test where "RIGHT" is not the
> function name, but in the comment on the function header line.
>
> >        /* End of captured text */
> >        ")",
> >        /* -- */
> > -      /* Characters not in the default $IFS value */
> > -      "[^ \t]+"),
> > +      /* Identifiers: variable and function names */
> > +       "[a-zA-Z_][a-zA-Z0-9_]*"
> > +      /* Numeric constants: integers and decimals */
> > +       "|[0-9]+(\\.[0-9]*)?|[-+]?\\.[0-9]+"
> > +      /* Shell variables: $VAR, ${VAR} */
> > +       "|\\$[a-zA-Z_][a-zA-Z0-9_]*|\\$\\{"
> > +       /* Logical and comparison operators */
> > +      "|\\|\\||&&|<<|>>|==|!=|<=|>="
> > +      /* Assignment and arithmetic operators */
> > +      "|[-+*/%&|^!=<>]=?"
> > +      /* Additional parameter expansion operators */
> > +      "|:?=|:-|:\\+|:\\?|:|#|##|%|%%|/[a-zA-Z0-9_-]+|\\^\\^?|,|,,?|!|@|:[0-9]+(:[0-9]+)?"
>
> What is the purpose of this "/[a-zA-Z0-9_-]+"? It would mean, for
> example that changes in alphanumeric path names would include the slash
> in the changed part. I don't think this should be here.

> Ok I got it.

> > +      /* Command-line options (to avoid splitting -option) */
> > +      "|--?[a-zA-Z0-9_-]+"
> > +      /* Brackets and grouping symbols */
> > +      "|\\(|\\)|\\{|\\}|\\[|\\]"),
> >  PATTERNS("bibtex",
> >        "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
> >        /* -- */
>
> -- Hannes
>

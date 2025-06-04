Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79238111BF
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 21:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749072007; cv=none; b=ubzJ7I9LbJA/u3hQNj5fI20KG6LvdwvyQAnPIcXn7qRtonBJEfhaDqgA5lFkfZs5NSEFZzEid70JLlADUp8pmHXWYGZVqL4degw2G/xm1d1I38NGVSifMoselSDN8JfJjkJy5Clbx0WBy0clqPqkC5TBYx4MaZZr1Fy1kT6DCsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749072007; c=relaxed/simple;
	bh=ttSHYlPEppqROFo/o6PENSvsF1R+EZETIiWlnaY2OGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KhFhK9RI+w+VUvo/0ySqoVsQCLeLARsiMC3syQN6pNJU28e/GxysRaMrrePtA1KOfH7Y7bgKVmxPNONOhmB2I7VlGqmZ+oXUHayR1jpA9AwgcZFAUSu9YhrkMnduxB0Wyd6RpUGdJ9y0dlosUuu/xHKO531ZbKTzmcuxxhW7HTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMx6tRCD; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMx6tRCD"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad572ba1347so42881766b.1
        for <git@vger.kernel.org>; Wed, 04 Jun 2025 14:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749072004; x=1749676804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssSrACPVIeUhv2p6s6BHq/mD67KUHosrHyT21FRfNFw=;
        b=IMx6tRCDL7ttZbOtpBYd+xGShqX5Mk6v/62DnKt3fKLA/HIvG6moAI4RaqQy56/eCQ
         ZbGXCv9/IwetvoXmvFX9mNA/JopBfpIQH/KGlXAy296bhP2/OV8DVX29BulXXAxVTLjK
         VXbpN7FhbGqyDIaoVIXF9OJfPAmsbdEcJBMP6ivkOO8yJeOG84f2fhKUGwiZABmWXu13
         lSsT8Y06sECbG4MZGKLC7QQfLCHh9zgN1+Z2JZbcIEk9cUV7OKMMoXUfb58g8eBzH5SI
         sZWc1efFKgEuaZ9ji55SCrl1cl0tMWIF9b/CbUcPHJYQ+iPQYokjld9pB49iry3aUsN3
         Ds0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749072004; x=1749676804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ssSrACPVIeUhv2p6s6BHq/mD67KUHosrHyT21FRfNFw=;
        b=ip8Uz7T3JIWMEuK956PYIgh8PDHOm7m1dCaBYfrLGvfUyPJfxQmrolJ6TY2F8L3dZ6
         j3wPL4TM+pWVFyUXnwThBcHZCcR7nOfzHMcvqH6QX8F2LFXmTLs/4BVwXA6I4YMZM3JV
         tAYpwQZvhoyzuRv+XHkLOheEqXgteLf6iZ6KWNXS6W+oI9Lrstm5+hp11kT3TtfPZ7DL
         wxZZXDW6oYNafByxT8rYtl3Sg3p6qRgLrimZ6/Axo98TM1jIVDxK02Evg77a1l7rwpUe
         HX5CEtrzkRNi0jP6QzoLDWtmoAV5hs2s0Rx6s3B4jsmfPVCUXKtMQYNT+Hfov13PIdzN
         VHPw==
X-Gm-Message-State: AOJu0Yx4uER4gSM+LgVHbnHbKzUSL49oB+z+TP4wq5guUog9X4mfW/MX
	x985RBRMq1zguuqOxFAbSY75+qp0f9WgC7l8zuRTT/fSjwKkGR2L1YWdhM27RvWsADedNnVc5x2
	pBtPfZVZ+UTx08XQd2i+S0wiwHtmtV+EK+3hf+FM=
X-Gm-Gg: ASbGncs53RPgbtRpK0CxZXn7jlrHMVM7END6pjycD7/LxDH1XoH/0SRZRsXfdonVLJq
	S1txZDFQjr6RIsP1ShM1+ZDyc6PIKKTm5lQQOtCUz5nlmJ04AOl1IhjJKybQfzzicGnESQfPF1e
	BECCVaoWbvzOp8XkRu8lB//zIw/aokyaGrvtpHXTOqr6q/xrFWENbBuZ0dFuhpWX1amg==
X-Google-Smtp-Source: AGHT+IHvZj3ixzk5TUIm8HL+BQmCoz+GoG3JBS5yBnRD+sUIL4gock9BO9A0W9ZsyAQ8VU6l1fXzHH5i5MCIByrochc=
X-Received: by 2002:a17:907:9597:b0:add:fd7c:ae9 with SMTP id
 a640c23a62f3a-addfd7c1985mr323318666b.45.1749072003510; Wed, 04 Jun 2025
 14:20:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604094100.80598-1-derick.william.moraes@gmail.com> <20250604094100.80598-2-derick.william.moraes@gmail.com>
In-Reply-To: <20250604094100.80598-2-derick.william.moraes@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 4 Jun 2025 17:19:52 -0400
X-Gm-Features: AX0GCFst0xMKSqqT0Ob5lxZ_-bX_TJmblj6USFCx5bV1YePE41LKNG-kKFpKi9k
Message-ID: <CALnO6CBx0ZBXXq9wX_T_YPUYjJESTR28WX-DG5d351FBA2py9g@mail.gmail.com>
Subject: Re: [GSoC PATCH 1/1] userdiff: add javascript diff driver
To: "Derick W. de M. Frias" <derick.william.moraes@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 5:44=E2=80=AFAM Derick W. de M. Frias
<derick.william.moraes@gmail.com> wrote:
>
> Add a userdiff pattern for javascript, and 13 test cases for instances
> of function declarations in javascript.

I didn't see any test cases dealing with nested functions, which might
add some value?

>
> Signed-off-by: Derick W. de M. Frias <derick.william.moraes@gmail.com>
> ---
>  .../javascript-anonymous-function-assigned    |  4 +++
>  t/t4018/javascript-arrow-function-assigned    |  4 +++
>  t/t4018/javascript-arrow-function-assigned-2  |  1 +
>  t/t4018/javascript-async-function             |  4 +++
>  t/t4018/javascript-async-function-assigned    |  4 +++
>  t/t4018/javascript-class-function             |  6 ++++
>  t/t4018/javascript-function                   |  4 +++
>  t/t4018/javascript-function-assigned          |  4 +++
>  t/t4018/javascript-generator-function         |  5 ++++
>  t/t4018/javascript-generator-function-2       |  5 ++++
>  .../javascript-generator-function-assigned    |  5 ++++
>  .../javascript-generator-function-assigned-2  |  5 ++++
>  t/t4018/javascript-method-function            |  6 ++++
>  userdiff.c                                    | 28 +++++++++++++++++++
>  14 files changed, 85 insertions(+)
>  create mode 100644 t/t4018/javascript-anonymous-function-assigned
>  create mode 100644 t/t4018/javascript-arrow-function-assigned
>  create mode 100644 t/t4018/javascript-arrow-function-assigned-2
>  create mode 100644 t/t4018/javascript-async-function
>  create mode 100644 t/t4018/javascript-async-function-assigned
>  create mode 100644 t/t4018/javascript-class-function
>  create mode 100644 t/t4018/javascript-function
>  create mode 100644 t/t4018/javascript-function-assigned
>  create mode 100644 t/t4018/javascript-generator-function
>  create mode 100644 t/t4018/javascript-generator-function-2
>  create mode 100644 t/t4018/javascript-generator-function-assigned
>  create mode 100644 t/t4018/javascript-generator-function-assigned-2
>  create mode 100644 t/t4018/javascript-method-function
>
> diff --git a/t/t4018/javascript-anonymous-function-assigned b/t/t4018/jav=
ascript-anonymous-function-assigned
> new file mode 100644
> index 0000000000..d3c1728dd8
> --- /dev/null
> +++ b/t/t4018/javascript-anonymous-function-assigned
> @@ -0,0 +1,4 @@
> +const RIGHT =3D function (a, b) {
> +
> +    return a + b;
> +};
> \ No newline at end of file

Notice these files don't match the *nix convention of having a newline
at the end. I find that some editors like VS Code have broken defaults
[1] and require a settings change to get this correct, but notably
Git's diff machinery will reliably warn you.

[1]: https://stackoverflow.com/q/44704968/4400820

> diff --git a/t/t4018/javascript-arrow-function-assigned b/t/t4018/javascr=
ipt-arrow-function-assigned
> new file mode 100644
> index 0000000000..5f0b056f61
> --- /dev/null
> +++ b/t/t4018/javascript-arrow-function-assigned
> @@ -0,0 +1,4 @@
> +const RIGHT =3D (a, b) =3D> {
> +
> +    return a + b;
> +};
> \ No newline at end of file
> diff --git a/t/t4018/javascript-arrow-function-assigned-2 b/t/t4018/javas=
cript-arrow-function-assigned-2
> new file mode 100644
> index 0000000000..9e923f4261
> --- /dev/null
> +++ b/t/t4018/javascript-arrow-function-assigned-2
> @@ -0,0 +1 @@
> +const RIGHT =3D a =3D> a+1;
> \ No newline at end of file
> diff --git a/t/t4018/javascript-async-function b/t/t4018/javascript-async=
-function
> new file mode 100644
> index 0000000000..7f99b8c89a
> --- /dev/null
> +++ b/t/t4018/javascript-async-function
> @@ -0,0 +1,4 @@
> +async function RIGHT (a, b) {
> +
> +    return a + b;
> +};
> \ No newline at end of file
> diff --git a/t/t4018/javascript-async-function-assigned b/t/t4018/javascr=
ipt-async-function-assigned
> new file mode 100644
> index 0000000000..9a01d9701f
> --- /dev/null
> +++ b/t/t4018/javascript-async-function-assigned
> @@ -0,0 +1,4 @@
> +const RIGHT =3D async function (a, b) {
> +
> +    return a + b;
> +};
> \ No newline at end of file
> diff --git a/t/t4018/javascript-class-function b/t/t4018/javascript-class=
-function
> new file mode 100644
> index 0000000000..9f216d7174
> --- /dev/null
> +++ b/t/t4018/javascript-class-function
> @@ -0,0 +1,6 @@
> +class Test {
> +  RIGHT() {
> +    let a =3D 1;
> +    let b =3D Value;
> +  }
> +}
> \ No newline at end of file
> diff --git a/t/t4018/javascript-function b/t/t4018/javascript-function
> new file mode 100644
> index 0000000000..d11ad34aff
> --- /dev/null
> +++ b/t/t4018/javascript-function
> @@ -0,0 +1,4 @@
> +function RIGHT (a, b) {
> +
> +    return a + b;
> +};
> \ No newline at end of file
> diff --git a/t/t4018/javascript-function-assigned b/t/t4018/javascript-fu=
nction-assigned
> new file mode 100644
> index 0000000000..38eaecafc6
> --- /dev/null
> +++ b/t/t4018/javascript-function-assigned
> @@ -0,0 +1,4 @@
> +const RIGHT =3D function test (a, b) {
> +
> +    return a + b;
> +};
> \ No newline at end of file
> diff --git a/t/t4018/javascript-generator-function b/t/t4018/javascript-g=
enerator-function
> new file mode 100644
> index 0000000000..af7cbb50a3
> --- /dev/null
> +++ b/t/t4018/javascript-generator-function
> @@ -0,0 +1,5 @@
> +function* RIGHT() {
> +
> +  yield 1;
> +  yield 2;
> +}
> \ No newline at end of file
> diff --git a/t/t4018/javascript-generator-function-2 b/t/t4018/javascript=
-generator-function-2
> new file mode 100644
> index 0000000000..d40b395f5c
> --- /dev/null
> +++ b/t/t4018/javascript-generator-function-2
> @@ -0,0 +1,5 @@
> +function *RIGHT() {
> +
> +  yield 1;
> +  yield 2;
> +}
> \ No newline at end of file
> diff --git a/t/t4018/javascript-generator-function-assigned b/t/t4018/jav=
ascript-generator-function-assigned
> new file mode 100644
> index 0000000000..b45d069949
> --- /dev/null
> +++ b/t/t4018/javascript-generator-function-assigned
> @@ -0,0 +1,5 @@
> +const RIGHT =3D function* (){
> +
> +  yield 1;
> +  yield 2;
> +}
> \ No newline at end of file
> diff --git a/t/t4018/javascript-generator-function-assigned-2 b/t/t4018/j=
avascript-generator-function-assigned-2
> new file mode 100644
> index 0000000000..2c4bc271ab
> --- /dev/null
> +++ b/t/t4018/javascript-generator-function-assigned-2
> @@ -0,0 +1,5 @@
> +const RIGHT =3D function *(){
> +
> +  yield 1;
> +  yield 2;
> +}
> \ No newline at end of file
> diff --git a/t/t4018/javascript-method-function b/t/t4018/javascript-meth=
od-function
> new file mode 100644
> index 0000000000..37e380cc6f
> --- /dev/null
> +++ b/t/t4018/javascript-method-function
> @@ -0,0 +1,6 @@
> +const Test =3D {
> +  RIGHT() {
> +    let a =3D 1;
> +    let b =3D Value;
> +  }
> +}
> \ No newline at end of file
> diff --git a/userdiff.c b/userdiff.c
> index 05776ccd10..94134e5b09 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -237,6 +237,34 @@ PATTERNS("java",
>          "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
>          "|[-+*/<>%&^|=3D!]=3D"
>          "|--|\\+\\+|<<=3D?|>>>?=3D?|&&|\\|\\|"),
> +PATTERNS("javascript",
> +     /* conventional named functions */
> +     "^[ \t]*(async[ \t]+)?function[ \t]*\\*?[ \t]*([$_a-zA-Z][$_a-zA-Z0=
-9]*)[ \t]*\\(.*$|"
> +     /* assigned functions */
> +     "^[ \t]*(const|let|var)[ \t]+([$_a-zA-Z][$_a-zA-Z0-9]*)[ \t]*=3D"
> +     "[ \t]*(async[ \t]+)?function[ \t]*\\*?[ \t]*([$_a-zA-Z][$_a-zA-Z0-=
9]*)?[ \t]*\\(.*$|"
> +     /* arrow functions */
> +     "^[ \t]*(const|let|var)[ \t]+([$_a-zA-Z][$_a-zA-Z0-9]*)[ \t]*=3D"
> +     "[ \t]*(\\([^\\)]*\\)|[$_a-zA-Z][$_a-zA-Z0-9]*)[ \t]*=3D>[ \t]*\\{?=
.*$|"
> +     /* functions declared inside classes and objects */
> +     "^[ \t]*(static[ \t]+)?(async[ \t]+)?(get[ \t]+|set[ \t]+)?\\*?[ \t=
]*"

I didn't see any test cases using these modifiers, either, not that we
have to test 100% of all cases.

> +     "([$_a-zA-Z][$_a-zA-Z0-9]*)[ \t]*\\([^)]*\\)[ \t]*\\{.*$",
> +     /* identifiers */
> +        "[$_A-Za-z][$_A-Za-z0-9]*|"
> +     /* hexadecimal and big hexadecimal */
> +     "0[xX](?:[0-9a-fA-F](?:_?[0-9a-fA-F])*)n?|"
> +     /* octa and big octa */
> +     "0[oO](?:[0-7](?:_?[0-7])*)n?|"
> +     /* binary and big binary */
> +     "0[bB](?:[01](?:_?[01])*)n?|"
> +     /* decimal, floting point and exponent notation (eE) */
> +     "(?:0|[1-9](?:_?[0-9])*)(?:\\.(?:[0-9](?:_?[0-9])*))?(?:[eE][+-]?(?=
:[0-9](?:_?[0-9])*))?|"
> +     /* big decimal */
> +     "(?:0|[1-9](?:_?[0-9])*)n|"
> +        /* punctuation */
> +        "\\{|\\}|\\(|\\)|\\.|\\.{3}|;|,|<|>|<=3D|>=3D|=3D=3D|!=3D|=3D{3}=
|!=3D=3D|\\+|-|\\*|/|%|\\*{2}|"
> +        "\\+{2}|--|<<|>>|>>>|&|\\||\\^|!|~|&&|\\|{2}|\\?{1,2}|:|=3D|\\+=
=3D|-=3D|\\*=3D|%=3D|\\*{2}=3D|"
> +        "<<=3D|>>=3D|>>>=3D|&=3D|\\|=3D|\\^=3D|&&=3D|\\|{2}=3D|\\?{2}=3D=
|=3D>"),
>  PATTERNS("kotlin",
>          "^[ \t]*(([a-z]+[ \t]+)*(fun|class|interface)[ \t]+.*)$",
>          /* -- */
> --
> 2.50.0.rc0.62.g658f0ae201.dirty
>
>


--=20
D. Ben Knoble

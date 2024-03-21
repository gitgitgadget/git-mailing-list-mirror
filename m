Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A6D762C6
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 12:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711023671; cv=none; b=c0sL1/Ix9S0N9kRDYASfmQlnSAc6FcbdZtjKmfCWxTbBWM2mXU98wSbvs6CudAgJzdh/fp1eVER3tWYni0QM6CVxkiBzzp/p4V5/SLsc8Avgl6sJiZZvdPLLzh/vuzUv/YGmn0xiiSM+GTIWP61B2vFBdk0fQB9AIABzSk+z4GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711023671; c=relaxed/simple;
	bh=XJLo8iSLQvC0XnwU5VQv3xQYjBluh/omvgM+MTomb2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJoR/Oq1hl4ufJoKYMQvbRO2Knsu3SYUu5deuu7D2a3YJbksP8ST8o4dwtz1IhkLyrjU/Les9aB7b2Op9o4idIrAdEd8nJmcfv/n4hSbZYYqOKEG6Fia5Vuomkho5vwSvlngiHc+2/zdld5kBj2Uuuj0Q59rmiUwNmtlC5RlYDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UCQ2ZRyW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OMFN7N4J; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UCQ2ZRyW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OMFN7N4J"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id B67971380136;
	Thu, 21 Mar 2024 08:21:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 21 Mar 2024 08:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711023668; x=1711110068; bh=0dG9gh5PfB
	Gv5TLOHr8dGuyRcxFXc7C5SMSmqqESkWI=; b=UCQ2ZRyWr4GMrQteIsw0Pr6Svt
	AuI9uFzrr7Vp6RgI86PyZpMN2up0gKPSYyGkMjnIkjluCpuaUD+u4ifxMpynGPYX
	tnbXUKGBX8bf3nGll9t5/VsFSBmrcvWTsOy7jJIgg9UJudRsuU1wouOHCagWx+Yd
	pgIsmR8Zy94WhJ/4DsUtnlry+3Aihm6CRs03YTXzI0AJ0qmhz8xFyEMfZSiX9Sme
	5+lVtSz5kCdC54hORdmWwZa8gAkiYv3FWDqmIX1Tp6Q/4ZB9MXaBFntJ9E4ZNYxm
	7alrP3az99aUuyCtC1WeRc6eobfcOwuTs0/vi298P7J5mB2VupRGGyiLcpUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711023668; x=1711110068; bh=0dG9gh5PfBGv5TLOHr8dGuyRcxFX
	c7C5SMSmqqESkWI=; b=OMFN7N4JuEKwY44IJwc4s0/TWo+mMHmNWeB4k+ZHNYsd
	+MSBcYDPcHrSQ2Pzp+vO1AG2NFfDSn/bk5CynpDZ9gmUA+93JBaM6VjEEMQwkL7U
	yQEws2kxFJjo6Q0Xqf5FLzZ5y4vbXqeVmLZUEk6OwOOpkq0sgckCrSThj8ANe1RW
	Sn538FXvUakvz8ghwnVzf0Q3V3vqYXAWgPsyMO8dcZ8DhhuTgjfTtmMhRS/6QRix
	Av5UScK0dJJvdjKvraxppXuCzwnE7gfmbxfLz71AFdq50q0YhuFA6a22w6GOGC3K
	WmXOjQOrc6ohs2Ml7AvLcGGHYLXGV4IyocoYR1Fbrw==
X-ME-Sender: <xms:Myb8ZQlgGckd7G37qXb-GLczndgypAp4c_UUlp2UM0WeD5aAdtRDeQ>
    <xme:Myb8Zf0VWArhJ5zoo03ugtoIwj18x6lbmiPA6uOpbYTg4zq5tIAbRw4iqMdkV5Fny
    QtJjl1nCUXOMOBGRA>
X-ME-Received: <xmr:Myb8ZeoC3y0vSa_-fhsXccKh_NmqiyzzuBNMgmQzDurPX37qwHbHME2tnZyvJzI9O-T3vrjIUQ2xbNSRM6Ol-KQY4CRoTS2dhATvs8RU4cqBNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeigdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtdorredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehfefhuedtvedtfeeiteeugefgfeelgeelveehffeukeelfefhieekteevudfhffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:Myb8ZcnlLcVFaTZRNXp8WiDu69UDSuYnrFxhaea26FlG8Tp0Lwxxkw>
    <xmx:Myb8Ze0wjZC5AqaAAZdcZZ_es939JomEDSplIOufDhtg9B9jyxS1gA>
    <xmx:Myb8ZTtfdYdbnb14w39hZiaubxUhXH1xJUU7XSSbVz2GxHpZ-5ozZg>
    <xmx:Myb8ZaUfiodJ7fBPoWdBuVEUp8niBQ5i9MsgEUqbY6DyGdX-1NXddA>
    <xmx:NCb8ZTxRdqpIqp8WtjuhteyR4idmvoW_MqSe7VB_g-p99INsv1ZmLQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 08:21:06 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 40c9277e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 Mar 2024 12:21:02 +0000 (UTC)
Date: Thu, 21 Mar 2024 13:21:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Utsav Parmar <utsavp0213@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC][PATCH] userdiff: add funcname regex and wordregex for
 typescript language
Message-ID: <ZfwmMKLBjtYvUPUV@tanuki>
References: <20240319185938.243667-1-utsavp0213@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z0FZYmWKTun4wITd"
Content-Disposition: inline
In-Reply-To: <20240319185938.243667-1-utsavp0213@gmail.com>


--Z0FZYmWKTun4wITd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 12:29:38AM +0530, Utsav Parmar wrote:
> This patch adds a builtin driver for typescript language supporting regex=
 for both function name and words. Also updates the `.gitattributes.txt` to=
 reflect this.

Please be mindful that we typically wrap commit messages at 72 columns
per line. Furthermore, we don't typically say "This patch", but rather
use an imperative style. So instead of saying "This patch adds a biultin
driver", we'd say "Add a builtin driver".

> gitattributes: add typescript language to hunk headers support
> t4034: add tests for typescript word_regex
> t4018: add tests for typescript funcname regex
> userdiff: add funcname regex and wordregex for typescript language

We don't usually provide such bulleted-list-style changes for each of
the files. In this case, it shoul be fine to say something "Add tests
and documentation for the new driver".

Last but not least, this message is missing your signoff.

I would recommend you to read "Documentation/MyFirstContribution.txt",
which explains all of this.

I can't really say much regarding the remainder of your changes given
that I'm neither familiar with "userdiff.c" nor with TypeScript. I hope
that others can chime in here.

Patrick

> ---
> Index: userdiff.c
> diff --git a/userdiff.c b/userdiff.c
> --- a/userdiff.c	(revision 2953d95d402b6bff1a59c4712f4d46f1b9ea137f)
> +++ b/userdiff.c	(revision 6724df99624834d9b7278a0bc95fa319f526a1fe)
> @@ -297,6 +297,22 @@
>  	 "|([^][)(}{[ \t])+"),
>  PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
>  	 "\\\\[a-zA-Z@]+|\\\\.|([a-zA-Z0-9]|[^\x01-\x7f])+"),
> +PATTERNS("typescript",
> +         "^[ \t]*((enum|interface|type)[ \t]+([a-zA-Z][a-zA-Z0-9]*)+.*)$=
\n"
> +         /* Method definitions */
> +         "^[ \t]*[a-z]+[ \t]+([A-Za-z_][A-Za-z_0-9]*)+([ \t]*=3D[ \t]*(f=
unction)?)?([ \t]*[A-Za-z_<>&][?&<>|.,A-Za-z_]*[ \t]*)*[ \t]*\\([^;]*$",
> +         /* -- */
> +         "[a-zA-Z_][a-zA-Z0-9_]*"
> +         /* Integers and floats */
> +         "|[-+]?[0-9]*\\.?[0-9]+([eE][-+]?[0-9]+)?"
> +         /* Binary */
> +         "|0[bB][01]+"
> +         /* Hexadecimals */
> +         "|0[xX][0-9a-fA-F]+"
> +         /* Floats starting with a decimal point */
> +         "|[-+]?([0-9]*\\.?[0-9]+|[0-9]+\\.?[0-9]*)([eE][-+]?[0-9]+)?"
> +         /* Operators */
> +         "[-+*/%&|^!=3D<>]=3D?|=3D=3D=3D|!=3D=3D|<<=3D?|>>=3D?|&&|\\|\\|=
|\\?\\?|\\+\\+|--|~"),
>  { "default", NULL, NULL, -1, { NULL, 0 } },
>  };
>  #undef PATTERNS
> Index: t/t4018/typescript-arrow-function
> diff --git a/t/t4018/typescript-arrow-function b/t/t4018/typescript-arrow=
-function
> new file mode 100644
> --- /dev/null	(revision b60d253ea78063d444f7131c3100388a7cdac060)
> +++ b/t/t4018/typescript-arrow-function	(revision b60d253ea78063d444f7131=
c3100388a7cdac060)
> @@ -0,0 +1,4 @@
> +const RIGHT =3D (one) =3D> {
> +    someMethodCall();
> +    return ChangeMe;
> +}
> Index: t/t4018/typescript-class-member-function
> diff --git a/t/t4018/typescript-class-member-function b/t/t4018/typescrip=
t-class-member-function
> new file mode 100644
> --- /dev/null	(revision b60d253ea78063d444f7131c3100388a7cdac060)
> +++ b/t/t4018/typescript-class-member-function	(revision b60d253ea78063d4=
44f7131c3100388a7cdac060)
> @@ -0,0 +1,7 @@
> +class Test {
> +	var one;
> +	function RIGHT(two: string) {
> +		someMethodCall();
> +		return ChangeMe;
> +	}
> +}
> Index: t/t4018/typescript-enum
> diff --git a/t/t4018/typescript-enum b/t/t4018/typescript-enum
> new file mode 100644
> --- /dev/null	(revision b60d253ea78063d444f7131c3100388a7cdac060)
> +++ b/t/t4018/typescript-enum	(revision b60d253ea78063d444f7131c3100388a7=
cdac060)
> @@ -0,0 +1,6 @@
> +enum RIGHT {
> +    ONE =3D 1,
> +    TWO,
> +    THREE,
> +    ChangeMe
> +}
> Index: t/t4018/typescript-function
> diff --git a/t/t4018/typescript-function b/t/t4018/typescript-function
> new file mode 100644
> --- /dev/null	(revision b60d253ea78063d444f7131c3100388a7cdac060)
> +++ b/t/t4018/typescript-function	(revision b60d253ea78063d444f7131c31003=
88a7cdac060)
> @@ -0,0 +1,4 @@
> +function RIGHT<Type implements AnotherType>(one: number): Type {
> +    someMethodCall();
> +    return ChangeMe;
> +}
> Index: t/t4018/typescript-function-assignment
> diff --git a/t/t4018/typescript-function-assignment b/t/t4018/typescript-=
function-assignment
> new file mode 100644
> --- /dev/null	(revision b60d253ea78063d444f7131c3100388a7cdac060)
> +++ b/t/t4018/typescript-function-assignment	(revision b60d253ea78063d444=
f7131c3100388a7cdac060)
> @@ -0,0 +1,4 @@
> +const RIGHT =3D function(one: number): Type {
> +    someMethodCall();
> +    return ChangeMe;
> +}
> Index: t/t4018/typescript-interface
> diff --git a/t/t4018/typescript-interface b/t/t4018/typescript-interface
> new file mode 100644
> --- /dev/null	(revision b60d253ea78063d444f7131c3100388a7cdac060)
> +++ b/t/t4018/typescript-interface	(revision b60d253ea78063d444f7131c3100=
388a7cdac060)
> @@ -0,0 +1,4 @@
> +interface RIGHT {
> +  one?: string;
> +  [propName: ChangeMe]: any;
> +}
> \ No newline at end of file
> Index: t/t4018/typescript-type
> diff --git a/t/t4018/typescript-type b/t/t4018/typescript-type
> new file mode 100644
> --- /dev/null	(revision b60d253ea78063d444f7131c3100388a7cdac060)
> +++ b/t/t4018/typescript-type	(revision b60d253ea78063d444f7131c3100388a7=
cdac060)
> @@ -0,0 +1,4 @@
> +type RIGHT =3D {
> +  one: number,
> +  ChangeMe: CustomType
> +}
> \ No newline at end of file
> Index: t/t4034-diff-words.sh
> diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
> --- a/t/t4034-diff-words.sh	(revision b60d253ea78063d444f7131c3100388a7cd=
ac060)
> +++ b/t/t4034-diff-words.sh	(revision be6b88ac5ca33921af60ee42f71397011ef=
b1806)
> @@ -338,6 +338,7 @@
>  test_language_driver ruby
>  test_language_driver scheme
>  test_language_driver tex
> +test_language_driver typescript
> =20
>  test_expect_success 'word-diff with diff.sbe' '
>  	cat >pre <<-\EOF &&
> Index: t/t4034/typescript/expect
> diff --git a/t/t4034/typescript/expect b/t/t4034/typescript/expect
> new file mode 100644
> --- /dev/null	(revision be6b88ac5ca33921af60ee42f71397011efb1806)
> +++ b/t/t4034/typescript/expect	(revision be6b88ac5ca33921af60ee42f713970=
11efb1806)
> @@ -0,0 +1,57 @@
> +<BOLD>diff --git a/pre b/post<RESET>
> +<BOLD>index e4a51a2..9c56465 100644<RESET>
> +<BOLD>--- a/pre<RESET>
> +<BOLD>+++ b/post<RESET>
> +<CYAN>@@ -1,16 +1,16 @@<RESET>
> +log("Hello World<RED>!\n<RESET><GREEN>?<RESET>")
> +<GREEN>(<RESET>1<GREEN>) (<RESET>-1e10<GREEN>) (<RESET>0xabcdef<GREEN>) =
u<RESET>'<RED>x<RESET><GREEN>y<RESET>'
> +!<RED>a<RESET><GREEN>x<RESET> ~<RED>a a<RESET><GREEN>x x<RESET>++ <RED>a=
<RESET><GREEN>x<RESET>-- <RED>a<RESET><GREEN>x<RESET>*<RED>b a<RESET><GREEN=
>y x<RESET>&<RED>b
> +<RESET>
> +<RED>a<RESET><GREEN>y
> +<RESET>
> +<GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>/<RED>b a<RESET><GREEN>y=
 x<RESET>%<RED>b
> +<RESET>
> +<RED>a<RESET><GREEN>y
> +<RESET>
> +<GREEN>x<RESET>+<RED>b a<RESET><GREEN>y x<RESET>-<RED>b
> +<RESET>
> +<RED>a<RESET><GREEN>y
> +<RESET>
> +<GREEN>x<RESET><<<RED>b a<RESET><GREEN>y x<RESET>>><RED>b
> +<RESET>
> +<RED>a<RESET><GREEN>y
> +<RESET>
> +<GREEN>x<RESET><<RED>b a<RESET><GREEN>y x<RESET><=3D<RED>b a<RESET><GREE=
N>y x<RESET>><RED>b a<RESET><GREEN>y x<RESET>>=3D<RED>b
> +<RESET>
> +<RED>a<RESET><GREEN>y
> +<RESET>
> +<GREEN>x<RESET>=3D=3D<RED>b a<RESET><GREEN>y x<RESET>!=3D<RED>b
> +<RESET>
> +<RED>a<RESET><GREEN>y
> +<RESET>
> +<GREEN>x<RESET>&<RED>b
> +<RESET>
> +<RED>a<RESET><GREEN>y
> +<RESET>
> +<GREEN>x<RESET>^<RED>b
> +<RESET>
> +<RED>a<RESET><GREEN>y
> +<RESET>
> +<GREEN>x<RESET>|<RED>b
> +<RESET>
> +<RED>a<RESET><GREEN>y
> +<RESET>
> +<GREEN>x<RESET>&&<RED>b
> +<RESET>
> +<RED>a<RESET><GREEN>y
> +<RESET>
> +<GREEN>x<RESET>||<RED>b
> +<RESET>
> +<RED>a<RESET><GREEN>y
> +<RESET>
> +<GREEN>x<RESET>?<RED>b<RESET><GREEN>y<RESET>:z
> +<RED>a<RESET><GREEN>x<RESET>=3D<RED>b a<RESET><GREEN>y x<RESET>+=3D<RED>=
b a<RESET><GREEN>y x<RESET>-=3D<RED>b a<RESET><GREEN>y x<RESET>*=3D<RED>b a=
<RESET><GREEN>y x<RESET>/=3D<RED>b a<RESET><GREEN>y x<RESET>%=3D<RED>b a<RE=
SET><GREEN>y x<RESET><<=3D<RED>b a<RESET><GREEN>y x<RESET>>>=3D<RED>b a<RES=
ET><GREEN>y x<RESET>&=3D<RED>b a<RESET><GREEN>y x<RESET>^=3D<RED>b a<RESET>=
<GREEN>y x<RESET>|=3D<RED>b
> +<RESET>
> +<RED>a<RESET><GREEN>y
> +<RESET>
> +<GREEN>x<RESET>,y
> Index: t/t4034/typescript/post
> diff --git a/t/t4034/typescript/post b/t/t4034/typescript/post
> new file mode 100644
> --- /dev/null	(revision be6b88ac5ca33921af60ee42f71397011efb1806)
> +++ b/t/t4034/typescript/post	(revision be6b88ac5ca33921af60ee42f71397011=
efb1806)
> @@ -0,0 +1,16 @@
> +log("Hello World?")
> +(1) (-1e10) (0xabcdef) u'y'
> +!x ~x x++ x-- x*y x&y
> +x*y x/y x%y
> +x+y x-y
> +x<<y x>>y
> +x<y x<=3Dy x>y x>=3Dy
> +x=3D=3Dy x!=3Dy
> +x&y
> +x^y
> +x|y
> +x&&y
> +x||y
> +x?y:z
> +x=3Dy x+=3Dy x-=3Dy x*=3Dy x/=3Dy x%=3Dy x<<=3Dy x>>=3Dy x&=3Dy x^=3Dy x=
|=3Dy
> +x,y
> Index: t/t4034/typescript/pre
> diff --git a/t/t4034/typescript/pre b/t/t4034/typescript/pre
> new file mode 100644
> --- /dev/null	(revision be6b88ac5ca33921af60ee42f71397011efb1806)
> +++ b/t/t4034/typescript/pre	(revision be6b88ac5ca33921af60ee42f71397011e=
fb1806)
> @@ -0,0 +1,16 @@
> +log("Hello World!\n")
> +1 -1e10 0xabcdef 'x'
> +!a ~a a++ a-- a*b a&b
> +a*b a/b a%b
> +a+b a-b
> +a<<b a>>b
> +a<b a<=3Db a>b a>=3Db
> +a=3D=3Db a!=3Db
> +a&b
> +a^b
> +a|b
> +a&&b
> +a||b
> +a?b:z
> +a=3Db a+=3Db a-=3Db a*=3Db a/=3Db a%=3Db a<<=3Db a>>=3Db a&=3Db a^=3Db a=
|=3Db
> +a,y
> Index: Documentation/gitattributes.txt
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribute=
s.txt
> --- a/Documentation/gitattributes.txt	(revision be6b88ac5ca33921af60ee42f=
71397011efb1806)
> +++ b/Documentation/gitattributes.txt	(revision 2891f81b087a3f1c89d1417c4=
0ba576aaa30feb9)
> @@ -902,6 +902,8 @@
> =20
>  - `tex` suitable for source code for LaTeX documents.
> =20
> +- `typescript` suitable for source code for TypeScript language.
> +
> =20
>  Customizing word diff
>  ^^^^^^^^^^^^^^^^^^^^^
>=20

--Z0FZYmWKTun4wITd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX8Ji8ACgkQVbJhu7ck
PpRjsBAAjs8tI+ULZxG89UsItE1wbdK5jF4yrDrhMm+cI9B+D3JUG1dSXVhyzgv0
JIk6+CNSzX2axSbqirfylOBk00Zt4RPlL9NL6xSW7ijcoo+L32o+FgegMAe5/HP9
jIfc+sAX7zRsSPW0WqLnxGedmUL49VdWQyUJmqoqGr8dxhuRe4UoRfBRAbshtwTh
vYDHm0V4YcnspoM5nZRhmmwAXItY/J/JBG9R+7FxXZMj36/aHrpRtVAYtyhqg7jW
96R9zktqOlzxITVzlEjqNygEUYI3yBXEF+x0KWEEBj4sea8DYJLl6+ZYS7KUGnxt
XagVmlV/ZBoah1XjZeLjuSsBB2N4dAZllntOy6EzUQkRkMj8TLeSm+fA1XFc07dZ
XyTgIKqClaLYUdDM0rJNT5rugqsdzqoxjAcgN/iFIjxyHLPHl7j1AICRP/MUao1O
lrygTqBtqme/AFCJWAEz91FC291zw4Snf49oN0XPwxzhnqV8cpZPjpcMGBZ+G50F
EqP7ZJuVuCC0PFY70tKmNdFWlWlVtYHcmO71SAB16wzp7RAGbHC1rR/Wirq01Kbb
rIvQICo+d9Q00+JcaRb+SQqz5QLEGm9Z2NATCYD2J+ndHkypn5bNz9v3zjEbrbCs
Chzi/AFsJjHmAN1SR21TJPB/063Nv3KimiCWde3gkknHjufuuxU=
=sCeI
-----END PGP SIGNATURE-----

--Z0FZYmWKTun4wITd--

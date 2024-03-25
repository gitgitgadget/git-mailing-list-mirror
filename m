Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057E854910
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 07:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711352230; cv=none; b=MvMBPhpXI8vFFmf1SUWa56Hj/h5qfClS7E3edIcXj6txNJYd8+xDfcGnJ3GJoJvZGhma1ho+9G0zATmOJmzuOqVMstL8k2Jbebq6u9gL9/sH2c3hwQbgiULuLJRPIE7X6ut7BO+QAmSfsjQhfcxNExQ7j3BXNJERSsU2IPHWYPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711352230; c=relaxed/simple;
	bh=UEFk6pbujnL6tOIENxwqtI3jBB+oFKgtFBTdCJoQjVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyHxEGho6w0GaQfakR/C2bZImuMv9uqkoPJXMScpPM8ucJjLIzx8OWwxvnlrSxEuZvr7+lJGH7oHV4J/Wgm3cnDtCgbQWU54g5YjCzNkO2qQSOOO/xeZgCWtKqFbegKWYVZsZ1SZorTt6mr0XXdaFPh8aHNpJp88l2OsplID004=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KQWFRBIO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xbIC3yEJ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KQWFRBIO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xbIC3yEJ"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1986113800E7;
	Mon, 25 Mar 2024 03:37:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 25 Mar 2024 03:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711352227; x=1711438627; bh=Zg3xqvE/sr
	WFFqMLqZFFarDfUkPAn3hQj/NnmXGNTSs=; b=KQWFRBIOWd/9fyoNEbRt7AVTHB
	z+vHTbm1N53S3A0fGzxqKdC0f4J9UlhktpY4CTRbkQqw5OP3t6gUZLql2ooXcA6u
	zaaGtHAXn5LZnGuiE6vE9qllAAX5fH3uCDeMouh7nQB0FMeD8vIwudGzaZG3u6AB
	qXiGJ+TUjTw7zdEWEkCgM4BbWDMsrzGcrxyzeRX06er5sUyAYVWu4+3RIqByttwx
	ztFO6StcnIXYYAilVxTEuvJPGDJzwniDYwf9vib/2rH5s9Jmj+pDfufp8A62JqCZ
	z+UbAYBoVY+CKiDdjhBQLKaUCVDU1yN+gt5EUHF7Tti/EeK7G9TlBevE148A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711352227; x=1711438627; bh=Zg3xqvE/srWFFqMLqZFFarDfUkPA
	n3hQj/NnmXGNTSs=; b=xbIC3yEJfZphAD9BQoKmRMcFCd4CEDjK0lnJpU/CweS1
	JF8AGxHxi1tbPm1vgnNknvp4WyU/Lx/VJJ0dEmtqXlgxGPhpYDBKHDFVRTD+lVcK
	FT7/ncWD5Yiu6t9thELVgarnCpgQg4WdixsifFw4N6OpIMjgWDzf8m1CnnH4704/
	exZnmOgPaJiHDvRFMeXn+02TiwPLLlM4LftK5AAk8K9hogUSD5x+HoVtGB41eJRc
	ISfip46hoTS6OvXOVdaz3Fmrpgq3gmXQjS9W32ojuFx/5QCJvqonrxC4OOTJs/o/
	JrIhN1PTW6/xhqGhe8M+Rys4bzYXZ2XZ5NaUsCNXUw==
X-ME-Sender: <xms:oikBZpquOdalXLYYuJDGkUp2qz-grT8hQykyigDuRr6Ct7SO_zAwAg>
    <xme:oikBZrrPW9PIvof18RVqk2Crzf_LSPhIWkcI-Z9aOaYlSZiwefJQeBMMShYLlpCU-
    C81cK0dHOoLPXzNhw>
X-ME-Received: <xmr:oikBZmPmkD2q3Xk8_DkjrQ-9oA8sF-gDhaiGkIezkuaWFM1EtaTQ-4g1mxWXRVvyqGEMHIsjVAJ5ddjLdPdYVAwTRadU-eNrWak3N9_4U8SyxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtkedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:oikBZk521ueCgKoV6TNjU3ZSXiyWGaoetTX4J7JncCACWJzLvWiuDg>
    <xmx:oikBZo43xlS4dT53CKpY4x3McnUSDNS0jV2JEGZcuNLhwPZNyDApMQ>
    <xmx:oikBZsjXHQrfGl12CZguA548K_ag7ni8U7ZpC7U85Nr06StLVZI5nA>
    <xmx:oikBZq4hkO3K8gkxZONhGfzAEcOWY1dVUo6RGKIo_dCwSvjrAMYiGg>
    <xmx:oykBZmlubiQR3FV32dB9pP7y8wB-KVat1ZeXMsjo5nW2CdB8opSMkQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 03:37:06 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c912d13a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 07:36:55 +0000 (UTC)
Date: Mon, 25 Mar 2024 08:37:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Utsav Parmar <utsavp0213@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] userdiff: add builtin driver for typescript language
Message-ID: <ZgEpnmdKtSvMH8SQ@tanuki>
References: <20240319185938.243667-1-utsavp0213@gmail.com>
 <20240324174423.55508-1-utsavp0213@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7YF8nqVJDiVojXPy"
Content-Disposition: inline
In-Reply-To: <20240324174423.55508-1-utsavp0213@gmail.com>


--7YF8nqVJDiVojXPy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 11:14:23PM +0530, Utsav Parmar wrote:
> There are no implementation or test changes in this patch. It simply reli=
es on the git formatting rather than the IDE git UI formatting that I belie=
ve messed up in the parent email.

Commit messages are supposed to be at most 72 characters wide, so please
reflow the commit message to match that limit. Furthermore, when you
send an updated patch, please make sure to increment the patch version
so that folks have an easier time to follow the evolution of your patch.
This can be done by passing e.g. `-v2` to git-format-patch(1) or
git-send-email(1).

Other than that I don't have a lot to say about this patch and will hope
for somebody else to review the TypeScript-related things.

Thanks!

Patrick

> Signed-off-by: Utsav Parmar <utsavp0213@gmail.com>
> ---
>  Documentation/gitattributes.txt          |  2 ++
>  t/t4018/typescript-arrow-function        |  4 +++
>  t/t4018/typescript-class-member-function |  7 +++++
>  t/t4018/typescript-enum                  |  6 +++++
>  t/t4018/typescript-function              |  4 +++
>  t/t4018/typescript-function-assignment   |  4 +++
>  t/t4018/typescript-interface             |  4 +++
>  t/t4018/typescript-type                  |  4 +++
>  t/t4034-diff-words.sh                    |  1 +
>  t/t4034/typescript/expect                | 33 ++++++++++++++++++++++++
>  t/t4034/typescript/post                  | 16 ++++++++++++
>  t/t4034/typescript/pre                   | 16 ++++++++++++
>  userdiff.c                               | 16 ++++++++++++
>  13 files changed, 117 insertions(+)
>  create mode 100644 t/t4018/typescript-arrow-function
>  create mode 100644 t/t4018/typescript-class-member-function
>  create mode 100644 t/t4018/typescript-enum
>  create mode 100644 t/t4018/typescript-function
>  create mode 100644 t/t4018/typescript-function-assignment
>  create mode 100644 t/t4018/typescript-interface
>  create mode 100644 t/t4018/typescript-type
>  create mode 100644 t/t4034/typescript/expect
>  create mode 100644 t/t4034/typescript/post
>  create mode 100644 t/t4034/typescript/pre
>=20
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribute=
s.txt
> index 4338d023d9..4461c41054 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -902,6 +902,8 @@ patterns are available:
> =20
>  - `tex` suitable for source code for LaTeX documents.
> =20
> +- `typescript` suitable for source code for TypeScript language.
> +
> =20
>  Customizing word diff
>  ^^^^^^^^^^^^^^^^^^^^^
> diff --git a/t/t4018/typescript-arrow-function b/t/t4018/typescript-arrow=
-function
> new file mode 100644
> index 0000000000..85a3d9cd6b
> --- /dev/null
> +++ b/t/t4018/typescript-arrow-function
> @@ -0,0 +1,4 @@
> +const RIGHT =3D (one) =3D> {
> +    someMethodCall();
> +    return ChangeMe;
> +}
> diff --git a/t/t4018/typescript-class-member-function b/t/t4018/typescrip=
t-class-member-function
> new file mode 100644
> index 0000000000..f34b0a2bac
> --- /dev/null
> +++ b/t/t4018/typescript-class-member-function
> @@ -0,0 +1,7 @@
> +class Test {
> +	var one;
> +	function RIGHT(two: string) {
> +		someMethodCall();
> +		return ChangeMe;
> +	}
> +}
> diff --git a/t/t4018/typescript-enum b/t/t4018/typescript-enum
> new file mode 100644
> index 0000000000..8c045a45ec
> --- /dev/null
> +++ b/t/t4018/typescript-enum
> @@ -0,0 +1,6 @@
> +enum RIGHT {
> +    ONE =3D 1,
> +    TWO,
> +    THREE,
> +    ChangeMe
> +}
> diff --git a/t/t4018/typescript-function b/t/t4018/typescript-function
> new file mode 100644
> index 0000000000..62cf63f669
> --- /dev/null
> +++ b/t/t4018/typescript-function
> @@ -0,0 +1,4 @@
> +function RIGHT<Type implements AnotherType>(one: number): Type {
> +    someMethodCall();
> +    return ChangeMe;
> +}
> diff --git a/t/t4018/typescript-function-assignment b/t/t4018/typescript-=
function-assignment
> new file mode 100644
> index 0000000000..49c528713e
> --- /dev/null
> +++ b/t/t4018/typescript-function-assignment
> @@ -0,0 +1,4 @@
> +const RIGHT =3D function(one: number): Type {
> +    someMethodCall();
> +    return ChangeMe;
> +}
> diff --git a/t/t4018/typescript-interface b/t/t4018/typescript-interface
> new file mode 100644
> index 0000000000..6f3665c2af
> --- /dev/null
> +++ b/t/t4018/typescript-interface
> @@ -0,0 +1,4 @@
> +interface RIGHT {
> +  one?: string;
> +  [propName: ChangeMe]: any;
> +}
> \ No newline at end of file
> diff --git a/t/t4018/typescript-type b/t/t4018/typescript-type
> new file mode 100644
> index 0000000000..e1bb2d8371
> --- /dev/null
> +++ b/t/t4018/typescript-type
> @@ -0,0 +1,4 @@
> +type RIGHT =3D {
> +  one: number,
> +  ChangeMe: CustomType
> +}
> \ No newline at end of file
> diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
> index 74586f3813..4e3cf415c2 100755
> --- a/t/t4034-diff-words.sh
> +++ b/t/t4034-diff-words.sh
> @@ -338,6 +338,7 @@ test_language_driver python
>  test_language_driver ruby
>  test_language_driver scheme
>  test_language_driver tex
> +test_language_driver typescript
> =20
>  test_expect_success 'word-diff with diff.sbe' '
>  	cat >pre <<-\EOF &&
> diff --git a/t/t4034/typescript/expect b/t/t4034/typescript/expect
> new file mode 100644
> index 0000000000..19605fec4d
> --- /dev/null
> +++ b/t/t4034/typescript/expect
> @@ -0,0 +1,33 @@
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
> <RESET>
> +<RED>a<RESET><GREEN>y
> <RESET>
> +<GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>/<RED>b a<RESET><GREEN>y=
 x<RESET>%<RED>b
> <RESET>
> +<RED>a<RESET><GREEN>y
> <RESET>
> +<GREEN>x<RESET>+<RED>b a<RESET><GREEN>y x<RESET>-<RED>b
> <RESET>
> +<RED>a<RESET><GREEN>y
> <RESET>
> +<GREEN>x<RESET><<<RED>b a<RESET><GREEN>y x<RESET>>><RED>b
> <RESET>
> +<RED>a<RESET><GREEN>y
> <RESET>
> +<GREEN>x<RESET><<RED>b a<RESET><GREEN>y x<RESET><=3D<RED>b a<RESET><GREE=
N>y x<RESET>><RED>b a<RESET><GREEN>y x<RESET>>=3D<RED>b
> <RESET>
> +<RED>a<RESET><GREEN>y
> <RESET>
> +<GREEN>x<RESET>=3D=3D<RED>b a<RESET><GREEN>y x<RESET>!=3D<RED>b
> <RESET>
> +<RED>a<RESET><GREEN>y
> <RESET>
> +<GREEN>x<RESET>&<RED>b
> <RESET>
> +<RED>a<RESET><GREEN>y
> <RESET>
> +<GREEN>x<RESET>^<RED>b
> <RESET>
> +<RED>a<RESET><GREEN>y
> <RESET>
> +<GREEN>x<RESET>|<RED>b
> <RESET>
> +<RED>a<RESET><GREEN>y
> <RESET>
> +<GREEN>x<RESET>&&<RED>b
> <RESET>
> +<RED>a<RESET><GREEN>y
> <RESET>
> +<GREEN>x<RESET>||<RED>b
> <RESET>
> +<RED>a<RESET><GREEN>y
> <RESET>
> +<GREEN>x<RESET>?<RED>b<RESET><GREEN>y<RESET>:z
> +<RED>a<RESET><GREEN>x<RESET>=3D<RED>b a<RESET><GREEN>y x<RESET>+=3D<RED>=
b a<RESET><GREEN>y x<RESET>-=3D<RED>b a<RESET><GREEN>y x<RESET>*=3D<RED>b a=
<RESET><GREEN>y x<RESET>/=3D<RED>b a<RESET><GREEN>y x<RESET>%=3D<RED>b a<RE=
SET><GREEN>y x<RESET><<=3D<RED>b a<RESET><GREEN>y x<RESET>>>=3D<RED>b a<RES=
ET><GREEN>y x<RESET>&=3D<RED>b a<RESET><GREEN>y x<RESET>^=3D<RED>b a<RESET>=
<GREEN>y x<RESET>|=3D<RED>b
> <RESET>
> +<RED>a<RESET><GREEN>y
> <RESET>
> +<GREEN>x<RESET>,y
> diff --git a/t/t4034/typescript/post b/t/t4034/typescript/post
> new file mode 100644
> index 0000000000..b1b03a7666
> --- /dev/null
> +++ b/t/t4034/typescript/post
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
> diff --git a/t/t4034/typescript/pre b/t/t4034/typescript/pre
> new file mode 100644
> index 0000000000..13a0b2138c
> --- /dev/null
> +++ b/t/t4034/typescript/pre
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
> diff --git a/userdiff.c b/userdiff.c
> index 92ef649c99..dbb5d7c072 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -297,6 +297,22 @@ PATTERNS("scheme",
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
> --=20
> 2.34.1
>=20
>=20

--7YF8nqVJDiVojXPy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBKZ0ACgkQVbJhu7ck
PpQOLxAAhcFnasDMYDi212+QsupCOH4rue6JLNea+7BV/iOIkOg/nQYld+VHbNui
Qym6RkuOEaSsPGrfCy0NM7qKSaWsxhCi64PFmMq5ZegqdZJWXIxKEvYr/2OE+dfm
5PefLzGLI+lXVHMvhi0K9LxkC7lkgFZ2JMK4Cbl9+YYM6ulGgXaWBco8frlIuKqd
4534jNKo+7UR6s+JMBwE2bunkBjG5j6cFhj/kT8j+4KfqK02mnILRF0rFs6I//2K
3L3wPzTWfBD8VrFdrHpqpO7bmt2JM62u2MLISnV7GgBgrZtCZvTOjFS2obxLEUcI
8TTZnOkMwmRhDluwtO5d/zFJJ37b/RXRngPRxMFlq2VEg7fcfQid9rdxj4BKQNjM
m5nEZVozok4Rli0knG11SHzBZS1ONDpTjSBApkgelN7q42UdYsMYTNWMAvXsGxbH
tmNCcu4abCJ6BooDGkP6GYA+6pDfyJFLvLTkXUjUmwkpZIYSyzlQtL3P/AsQP1vG
iPu/0JiSw2yGDafMcaAGk/tQuwMvorVDyGuMUa3TcWAdMJqVmSbEhWik+pp5n5MC
63Kh27lRm0OdCDPzmQDyxTNgzxA9kkRERYlEIUmll4QaLvfdOgP72nFDyppWvECX
eMcBzNncHk2Rn1+AYvtXUy1/237iwhpWnJxxzDU6uHyteuNCQ14=
=hEQf
-----END PGP SIGNATURE-----

--7YF8nqVJDiVojXPy--

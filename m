Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2B01E906F
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 19:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730836558; cv=none; b=MQ2N45ZWKW1mEMfxYnenrdo52EMtW7LIx113LLpzbGaOzbtuCBLEB6hI4cPHTet/wZLCb3VPRoLKfvAQ6pqSDHkPf6jVhi9ZXh56WWAjQkCtypbjtAfkwI21DrASyQJhhJ+WocY2M6k/CN0UMvaCuRsQKvIF1z7KEka0/nXgSQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730836558; c=relaxed/simple;
	bh=3i/X9Ii7Jmy0uUHqtWeHi1AGYAFeRUCJHkP4D24mnCs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NU+PNTN9ulnZ5KcHiLj85wRppxejz0tOmwFG6B0ettpQatSjgq2M24fkFV/r+yCweMLpcJRZSIgX+fTIAxs9lx6yCKRl43zmgJf99inhig63XKS9Ani9on8wSbkD9Cdhog4p8aV9eKWoA55vSsRxJNsWAvjXvcHeBEJ3skCGZkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=ctWTTXri; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="ctWTTXri"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730836524; x=1731441324;
	i=johannes.schindelin@gmx.de;
	bh=dRCdIirT4L0l+MrAKm6dDEtOBZxmK841BZDQROkQet8=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ctWTTXriHvzLmodgxNBP/Dyru06dRW79biOLTK5cbiEzF8Q0/T/kJ5aprB1MZS6J
	 xblSlJ5Q+3YJrF3dIGvNuG18IvgS4lvBNNeoMkikfYxnju6NGL00Qk6Wo9LQT/i7w
	 5W/zgWN5Kz/qoCceZhE7NMCHr0xN52NXlzxMbMq7LuSQH6ChoYyL+h0ry7Bwo1DUw
	 QqGr0DG6tOtOLKqdeJc8IqP/ORU6Cbv1WnlO9Hh8b86qf0O53vg9s7sTr7kMsoZzv
	 jhhTZdH4RTkpZdOf/Ru4sChi+gyF30kGC8ub21x28dXgHvlRcN+DhIAU6lFwARqS6
	 0GwwWElI9HRgJ312XA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.65]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MY6Cb-1tKfCL1tNN-00Pvya; Tue, 05
 Nov 2024 20:55:24 +0100
Date: Tue, 5 Nov 2024 20:55:23 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org, 
    =?UTF-8?Q?Alejandro_R=2E_Sede=C3=B1o?= <asedeno@mit.edu>, 
    Toon Claes <toon@iotcl.com>, Taylor Blau <me@ttaylorr.com>, 
    Ed Reel <edreel@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
    Edgar Bonet <bonet@grenoble.cnrs.fr>, Jeff King <peff@peff.net>, 
    "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 5/5] cmake: set up proper dependencies for generated
 clar headers
In-Reply-To: <bb005979e7eb335b0178094251b5c37682d7d47b.1729506329.git.ps@pks.im>
Message-ID: <3b2cb360-297a-915c-ae27-c45f38fa49b9@gmx.de>
References: <CAOO-Oz3KsyeSjxbRpU-SdPgU5K+mPDcntT6Y4s46Mg_0ko9e_w@mail.gmail.com> <cover.1729506329.git.ps@pks.im> <bb005979e7eb335b0178094251b5c37682d7d47b.1729506329.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1f8wXUEZLVm3NtML53en0hr/r7yu1epO7yQL1QaaLcef21yjg2/
 TmdzcgaQmgq8Y5pZ/mcGaMj3Gg1t0JoRG0GPJ2yOyKu40m6Q4465dPKLKs5nLS57zyfjkIV
 EXlRpvWhVbIwAV/m597mwQPkxBFmUtM0IxmQdTmg2FSUhvqnIyMQjlF3+CwyvX6ARQJp6Qp
 YjiHEwO6dEb7f0NY3CblA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lku22hh4Cs8=;pbuOQX4e27RfMvzHWmbjdv4zPfy
 JIDZS0oXO4WjdHObckWrNLdktDrmdEuSnBjTvMZjYdl/FKMf98MY3L2GmuQZd9hA6Kso52wjD
 qRAYxaFo3dZ0hTfv5R7iRY48rinWz403F09P7dzozwPk5QIo7nk/v5VdzjMW30uKE4PgtLwUY
 NyiDCNMXa6CRuSumI0mbehg0c50j4OjkjiUDXIRGRIUpLvPvWQbeNBBnBcEkQUft+hV8IvANX
 zNlVGAsHy1OlRYtu7YX9qpuTUq0yZqCct/I9rHE2pFK8pjiFLx4FFcQuFSStWaz1UpZkPGD/G
 6nKf7b57nsgo9w46Mao+En5Us+oNER7ubmAFjKtAfc9cP4NrdfzvMQJNimmcVjUjI/G08PQVD
 Zun7nR7bce9Ua+IA9LzsJr2N0ZFCPKK8YyOATzpj36CY/hYpDotwsIHvXYHsBl96CPNSOs49j
 teJIWAnSnuyJkzsuyO0qsEH6YffRbbD7XeHq372EBhKPDSFgb2XHXuwxli5XnxsXk/TJswesj
 HagTsb5mZH0XM/YazoCgOW5m1rGQANNl74YKsW1PWip6NSZnHQC7a2xORQjhL6TVA5pqNnIEP
 f7PDQQRmfrtZMbPvIaike3cA9qyYq31fnpWve5Tj+m2cOFV7Nsv8T2KdyR1XJ8X0Hz5wCJF7l
 K+IrAwGK4WPMIF04FwWuEdc3dhOfi3hifS1Xc+PHymMxvaWPODhmWszKTdzK8jHMPdzJX2qfr
 Fu1Eu1K2aiRCa6sbCN/ZxJplVI8zWUVMYCjziGcEGj9hpLwVwpDHt0HTsx6rFpGl6uHPsKO7J
 5sYEa4ODwdWpRHRUb9BeAqKg==
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Mon, 21 Oct 2024, Patrick Steinhardt wrote:

> The auto-generated headers used by clar are written at configure time
> and thus do not get regenerated automatically. Refactor the build
> recipes such that we use custom commands instead, which also has the
> benefit that we can reuse the same infrastructure as our Makefile.

For the record: I did not use a shell script to generate the header for a
specific reason: Unix shell scripts are not native to Windows. Therefore
they cannot in general be run on Windows, however that was precisely the
idea for the CMake definition: to be run on a vanilla Windows with Visual
Studio installed.

Sadly, even Git's CI definition sets things up in a way that Git for
Windows' Bash can be used in the CMake definition, but in the intended use
case (opening a checkout of git/git in Visual Studio without any further
tools required) won't have a usable Bash.

Therefore I am unsure whether this patch is desirable.

Ciao,
Johannes

>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  contrib/buildsystems/CMakeLists.txt | 50 +++++++----------------------
>  1 file changed, 12 insertions(+), 38 deletions(-)
>
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/=
CMakeLists.txt
> index 093852ad9d6..9f80ab92656 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -1002,46 +1002,20 @@ foreach(unit_test ${unit_test_PROGRAMS})
>  endforeach()
>
>  parse_makefile_for_scripts(clar_test_SUITES "CLAR_TEST_SUITES" "")
> -
> -set(clar_decls "")
> -set(clar_cbs "")
> -set(clar_cbs_count 0)
> -set(clar_suites "static struct clar_suite _clar_suites[] =3D {\n")
> -list(LENGTH clar_test_SUITES clar_suites_count)
> -foreach(suite ${clar_test_SUITES})
> -	file(STRINGS "${CMAKE_SOURCE_DIR}/t/unit-tests/${suite}.c" decls
> -		REGEX "^void test_${suite}__[a-zA-Z_0-9][a-zA-Z_0-9]*\\(void\\)$")
> -
> -	list(LENGTH decls decls_count)
> -	string(REGEX REPLACE "void (test_${suite}__([a-zA-Z_0-9]*))\\(void\\)"=
 "    { \"\\2\", &\\1 },\n" cbs ${decls})
> -	string(JOIN "" cbs ${cbs})
> -	list(TRANSFORM decls PREPEND "extern ")
> -	string(JOIN ";\n" decls ${decls})
> -
> -	string(APPEND clar_decls "${decls};\n")
> -	string(APPEND clar_cbs
> -		"static const struct clar_func _clar_cb_${suite}[] =3D {\n"
> -		${cbs}
> -		"};\n")
> -	string(APPEND clar_suites
> -		"    {\n"
> -		"        \"${suite}\",\n"
> -		"        { NULL, NULL },\n"
> -		"        { NULL, NULL },\n"
> -		"        _clar_cb_${suite}, ${decls_count}, 1\n"
> -		"    },\n")
> -	math(EXPR clar_cbs_count "${clar_cbs_count}+${decls_count}")
> -endforeach()
> -string(APPEND clar_suites
> -	"};\n"
> -	"static const size_t _clar_suite_count =3D ${clar_suites_count};\n"
> -	"static const size_t _clar_callback_count =3D ${clar_cbs_count};\n")
> -file(WRITE "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h" "${clar_decl=
s}")
> -file(WRITE "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite" "${clar_decls}=
" "${clar_cbs}" "${clar_suites}")
> -
>  list(TRANSFORM clar_test_SUITES PREPEND "${CMAKE_SOURCE_DIR}/t/unit-tes=
ts/")
>  list(TRANSFORM clar_test_SUITES APPEND ".c")
> -add_library(unit-tests-lib ${clar_test_SUITES} "${CMAKE_SOURCE_DIR}/t/u=
nit-tests/clar/clar.c")
> +add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.=
h"
> +	COMMAND ${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-decls.sh "${CMA=
KE_BINARY_DIR}/t/unit-tests/clar-decls.h" ${clar_test_SUITES}
> +	DEPENDS ${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-decls.sh ${clar=
_test_SUITES})
> +add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
> +	COMMAND awk -f "${CMAKE_SOURCE_DIR}/t/unit-tests/clar-generate.awk" "$=
{CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h" > "${CMAKE_BINARY_DIR}/t/uni=
t-tests/clar.suite"
> +	DEPENDS "${CMAKE_SOURCE_DIR}/t/unit-tests/clar-generate.awk" "${CMAKE_=
BINARY_DIR}/t/unit-tests/clar-decls.h")
> +
> +add_library(unit-tests-lib ${clar_test_SUITES}
> +	"${CMAKE_SOURCE_DIR}/t/unit-tests/clar/clar.c"
> +	"${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
> +	"${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
> +)
>  target_include_directories(unit-tests-lib PUBLIC "${CMAKE_BINARY_DIR}/t=
/unit-tests")
>  add_executable(unit-tests "${CMAKE_SOURCE_DIR}/t/unit-tests/unit-test.c=
")
>  target_link_libraries(unit-tests unit-tests-lib common-main)
> --
> 2.47.0.72.gef8ce8f3d4.dirty
>
>

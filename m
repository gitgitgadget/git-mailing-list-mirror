Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D3E70823
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749227900; cv=none; b=MqvAapw6hkOfdecEXrA2Y31dfV7FKaS4rO7u/6n89bXktT/+tjdT0Hv+MzB2PTby3M3yMqjt2pJsop3dPFL5ul/UW+p/impviOKxHwGQgUAdYB+mtDDnZqhiCuz4euPYwd+oOV92pnmht1t059ZTMku94O+xI+4nuGPY88SAL7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749227900; c=relaxed/simple;
	bh=RUvFH7nKkaMKB3nfeAYMV9H2dHCkbjhCKL/VUvrZ474=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FMViFXfV8GZ3UTkBTcr4vTzF1WFEY5YE8UFCkpMOPOhcWwoiOczBUafasR4nCS9qj+iB4JryGqeMVnfCsA7RoMDeCk3vGitiQPfaO6BtnQqr3s7xsGpZZOEyOxdVGtOwWyAEp2IqmAlNQQvUEkA3zvvdTt53GwFxjzri8BekEwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HsZ0kGz+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E6OZAp5o; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HsZ0kGz+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E6OZAp5o"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0BBC725400A0;
	Fri,  6 Jun 2025 12:38:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 06 Jun 2025 12:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749227896; x=1749314296; bh=6VLWFUgIeP
	SrwnBxvoWjiXEGLyDbujVcImtG1lfihUc=; b=HsZ0kGz+L8b5T/Cp33No4bZQtu
	oRt7VblDT7uKtk4PlguUBP6zx3B6VC0vL9T61jEbFmsYh1KWC9uG4tpTbVxHUIbI
	6YEzQUUKvU7dQQJXHCQ2kGyC9xTQPfmLXAdnu5MH+FvBzteABOAWEWQRky407iIl
	nI8StocAxa4zgjnI1gmXNULrrENLjYINHJJ5X999CND1BlxgRvOcsJt9kX/ISiED
	FXtrXj3eTmpGy/dtkAzp9MmpkdzZRYuV4gds6XIOsRq4VrbUvhP4XJ6xPEqyHnT9
	dGVsdvmUTheb5ft2chK3BwyZ1Xs/UrORWsmjy2HsRfmIjdq2YDcZMFavaZSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749227896; x=1749314296; bh=6VLWFUgIePSrwnBxvoWjiXEGLyDbujVcImt
	G1lfihUc=; b=E6OZAp5omFxlq9fILvVZuq2x08/C3Xw5M9ZqihGpymLqKd0+VNb
	QuoQTgMtXZkyXC4sfoW/Rbz++uZJ+hWADkvbrQfN2zgbXb2dTB1gucdDb99lkZBx
	UbSSpPMlS9bF/ZOzIJPG9IWNjgNAjX8sRcpfkwGqY6mNMfDVHaHkuR3247eDyYqy
	DrzampzXnN+1c0YC8e0LJwQNMcj8Le/ls+jZKg/EHhM8md0Y2PPu+PCEGd5SBlFW
	fs2+zB2R8LkdV4WuFJwgSEne3aCH18kbuzkPXOZUbzHBNwlkBPU2C2DvBMPfNjgH
	GRDAV08CkLpt4LaFo0WfqbqCmnd4v3nZ4GA==
X-ME-Sender: <xms:eBlDaLazFa5Ok4Sbo_vARzidFFaBCG40hro3Xcsh8BPoMFe67J67jA>
    <xme:eBlDaKYkcWZ1ZaWNcqH6HXJK6Pu5inmYEJRTFU6fZ3LKOjtEP37QV75ArW3mMr5KE
    BdIjTb393Vpb79YUg>
X-ME-Received: <xmr:eBlDaN8WgvnP2VnjIY4qz2rwfNL6JvTIVvtOAKziEtWAt3CuxDfNY-0LrjtXI4utTSV4CbSK6SIiapVVe21yA60-O3i67v03W35l>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdehfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepjeetfeevjeduvdehueehueevfeehheethfev
    udeludduhfeliedtieffleduveetnecuffhomhgrihhnpehimhgrphdqshgvnhgurdgtfi
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehgrghrghgrughithihrgdtkeeslhhivhgvrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuh
    hnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepiihihigrohes
    ughishhrohhothdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtoh
    hothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhr
    tghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepph
    hhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:eBlDaBqDZ9ngaACq0QzIRTcOR0zma9NOU3pkcbTYzBV-E_Qspb_dNw>
    <xmx:eBlDaGryFzUIs6KJMLc_WPIRPBNtcySX8vnA_4h0m0fcS3FDp_-vfw>
    <xmx:eBlDaHQPnAUpbqYT0I28buiC0EPkoBoP-CHWpMYCcTkoKOfG3wSbZQ>
    <xmx:eBlDaOpd4uJXgCSP0vKTNT566YdqDdir_ODQ7sM-RfiDZBUrl0NL0g>
    <xmx:eBlDaP8xMI3LlDo9mPHO5cHvf1-UxjQOs7O5QTdeEG7_u6e9rAxN2IrC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Jun 2025 12:38:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Zi Yao <ziyao@disroot.org>,  brian m carlson
 <sandals@crustytoothpaste.net>,  Jeff King <peff@peff.net>,  Ben Knoble
 <ben.knoble@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v13 02/10] imap-send: add support for OAuth2.0
 authentication
In-Reply-To: <PN3PR01MB95974F9ED808F60A915D054CB86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Fri, 6 Jun 2025 06:59:12 +0000")
References: <PN3PR01MB95974F9ED808F60A915D054CB86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Fri, 06 Jun 2025 09:38:14 -0700
Message-ID: <xmqqmsak3jwp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> Ok so I was wrong here. The warning actually comes when we compile
> WITHOUT NO_OPENSSL, since auth_oauthbearer is a function there, and
> will attract waddress warnings,

But the patch in this thread, when compiled with NO_OPENSSL, gives
"-Wunreachable".

--- * ------ * ------ * ------ * ------ * ---

$ make V=1 CC=clang DEVELOPER=YesPlease CFLAGS=-Waddress NO_OPENSSL=NoThanks imap-send.o
    * new build flags
clang -o imap-send.o -c -MF ./.depend/imap-send.o.d -MQ imap-send.o -MMD -MP  -Werror -Wall -pedantic -Wpedantic -std=gnu99 -Wdeclaration-after-statement -Wformat-security -Wold-style-definition -Woverflow -Wpointer-arith -Wstrict-prototypes -Wunused -Wvla -Wwrite-strings -fno-common -Wunreachable-code -Wcomma -Wtautological-constant-out-of-range-compare -Wextra -Wmissing-prototypes -Wno-empty-body -Wno-missing-field-initializers  -Waddress  -I. -DGIT_HOST_CPU="\"x86_64\"" -DHAVE_ALLOCA_H  -DUSE_CURL_FOR_IMAP_SEND -DNO_OPENSSL -DSUPPORTS_SIMPLE_IPC -DSHA1_DC -DSHA1DC_NO_STANDARD_INCLUDES -DSHA1DC_INIT_SAFE_HASH_DEFAULT=0 -DSHA1DC_CUSTOM_INCLUDE_SHA1_C="\"git-compat-util.h\"" -DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C="\"git-compat-util.h\"" -DSHA256_BLK  -DHAVE_PATHS_H -DHAVE_DEV_TTY -DHAVE_CLOCK_GETTIME -DHAVE_CLOCK_MONOTONIC -DHAVE_SYNC_FILE_RANGE -DHAVE_SYSINFO -DHAVE_GETDELIM -DHAVE_GETRANDOM -DFREAD_READS_DIRECTORIES -DNO_STRLCPY -DSHELL_PATH='"/bin/sh"'  imap-send.c
imap-send.c:1344:5: error: code will never be executed [-Werror,-Wunreachable-code]
 1344 |                                 memset(&cb, 0, sizeof(cb));
      |                                 ^~~~~~
imap-send.c:1322:5: error: code will never be executed [-Werror,-Wunreachable-code]
 1322 |                                 memset(&cb, 0, sizeof(cb));
      |                                 ^~~~~~
imap-send.c:1300:5: error: code will never be executed [-Werror,-Wunreachable-code]
 1300 |                                 memset(&cb, 0, sizeof(cb));
      |                                 ^~~~~~
imap-send.c:1278:5: error: code will never be executed [-Werror,-Wunreachable-code]
 1278 |                                 memset(&cb, 0, sizeof(cb));
      |                                 ^~~~~~
4 errors generated.
make: *** [Makefile:2820: imap-send.o] Error 1

--- * ------ * ------ * ------ * ------ * ---

See the patch attached at the end [*] that you can apply to 'seen'
to try out; the result compiles with all combinations of gcc/clang
and with and without NO_OPENSSL.

Having said that, I think you should first clean up the repetitions
before piling a lot of different auth_method on top.

A part of the resulting code after applying [*] to 'seen' looks like
this:

	} else if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
		if (!CAP(AUTH_CRAM_MD5)) {
			fprintf(stderr, "You specified "
				"CRAM-MD5 as authentication method, "
				"but %s doesn't support it.\n", srvc->host);
			goto bail;
		}

		/* CRAM-MD5 */
		memset(&cb, 0, sizeof(cb));
		cb.cont = auth_cram_md5;

		if (NOT_CONSTANT(!cb.cont)) {
		fprintf(stderr, "If you want to use CRAM-MD5 authentication mechanism, "
			"you have to build git-imap-send with OpenSSL library.");
		goto bail;
		}
		if (imap_exec(ctx, &cb, "AUTHENTICATE CRAM-MD5") != RESP_OK) {
			fprintf(stderr, "IMAP error: AUTHENTICATE CRAM-MD5 failed\n");
			goto bail;
		}

This pattern repeats for different auth methods as you add
copy-and-paste, which made the code way too long and too deeply
indented to be readable.  Why not make the above into a single
helper function that you can reuse, so that the call site can become
something like

	} else if (!strcmp(srvc->auth_method, "PLAIN")) {
	    if (try_auth_method(srvc, ctx, "PLAIN", AUTH_PLAIN, auth_plain))
		goto bail;
	} else if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
	    if (try_auth_method(srvc, ctx, "CRAM-MD5", AUTH_CRAM_MD5, auth_cram_md5))
		goto bail;
	} ...

If you did it at the very beginning of the series (i.e. when you
only have CRAM_MD5 you inherited from the original before adding all
the other new ones), each addition would become a lot simpler and
main flow in the the resulting code would become quite simple like
the above.

static int try_auth_method(struct imap_server_conf *srvc,
			   struct imap_store *ctx,
			   const char *auth_method,
			   enum CAPABILITY cap,
			   int (*fn)(struct imap_store *, const char *))
{
        struct imap_cmd_cb cb = {0};

	if (!CAP(cap)) {
		fprintf(stderr, "You specified "
			"%s as authentication method, "
			"but %s doesn't support it.\n",
			auth_method, srvc->host);
		return -1;
	}
	cb.cont = fn;

	if (NOT_CONSTANT(!cb.cont)) {
		fprintf(stderr, "If you want to use %s authentication mechanism, "
			"you have to build git-imap-send with OpenSSL library.",
			auth_method);
		return -1;
	}
	if (imap_exec(ctx, &cb, "AUTHENTICATE %s", auth_method) != RESP_OK) {
		fprintf(stderr, "IMAP error: AUTHENTICATE %s failed\n",
                	auth_method);
		return -1;
	}
        return 0;
}

So here is that [*] patch that is incorrectly indented to avoid even
deeper nesting.

---- >8 ----

 imap-send.c | 49 ++++++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git i/imap-send.c w/imap-send.c
index 6dbbf37125..bba2ef0cd0 100644
--- i/imap-send.c
+++ w/imap-send.c
@@ -1267,16 +1267,16 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 					goto bail;
 				}
 
-				#ifdef NO_OPENSSL
+				/* PLAIN */
+				memset(&cb, 0, sizeof(cb));
+				cb.cont = auth_plain;
+
+				if (NOT_CONSTANT(!cb.cont)) {
 				fprintf(stderr, "You are trying to use PLAIN authentication mechanism "
 					"with OpenSSL library, but its support has not been compiled in.");
 				goto bail;
-				#endif
-
-				/* PLAIN */
+				}
 
-				memset(&cb, 0, sizeof(cb));
-				cb.cont = auth_plain;
 				if (imap_exec(ctx, &cb, "AUTHENTICATE PLAIN") != RESP_OK) {
 					fprintf(stderr, "IMAP error: AUTHENTICATE PLAIN failed\n");
 					goto bail;
@@ -1289,16 +1289,16 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 					goto bail;
 				}
 
-				#ifdef NO_OPENSSL
-				fprintf(stderr, "If you want to use CRAM-MD5 authentication mechanism, "
-					"you have to build git-imap-send with OpenSSL library.");
-				goto bail;
-				#endif
 
 				/* CRAM-MD5 */
-
 				memset(&cb, 0, sizeof(cb));
 				cb.cont = auth_cram_md5;
+
+				if (NOT_CONSTANT(!cb.cont)) {
+				fprintf(stderr, "If you want to use CRAM-MD5 authentication mechanism, "
+					"you have to build git-imap-send with OpenSSL library.");
+				goto bail;
+				}
 				if (imap_exec(ctx, &cb, "AUTHENTICATE CRAM-MD5") != RESP_OK) {
 					fprintf(stderr, "IMAP error: AUTHENTICATE CRAM-MD5 failed\n");
 					goto bail;
@@ -1311,16 +1311,15 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 					goto bail;
 				}
 
-				#ifdef NO_OPENSSL
-				fprintf(stderr, "You are trying to use OAUTHBEARER authentication mechanism "
-					"with OpenSSL library, but its support has not been compiled in.");
-				goto bail;
-				#endif
-
 				/* OAUTHBEARER */
-
 				memset(&cb, 0, sizeof(cb));
 				cb.cont = auth_oauthbearer;
+
+				if (NOT_CONSTANT(!cb.cont)) {
+				fprintf(stderr, "You are trying to use OAUTHBEARER authentication mechanism "
+					"with OpenSSL library, but its support has not been compiled in.");
+				goto bail;
+				}
 				if (imap_exec(ctx, &cb, "AUTHENTICATE OAUTHBEARER") != RESP_OK) {
 					fprintf(stderr, "IMAP error: AUTHENTICATE OAUTHBEARER failed\n");
 					goto bail;
@@ -1333,16 +1332,16 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 					goto bail;
 				}
 
-				#ifdef NO_OPENSSL
+				/* XOAUTH2 */
+				memset(&cb, 0, sizeof(cb));
+				cb.cont = auth_xoauth2;
+
+				if (NOT_CONSTANT(!cb.cont)) {
 				fprintf(stderr, "You are trying to use XOAUTH2 authentication mechanism "
 					"with OpenSSL library, but its support has not been compiled in.");
 				goto bail;
-				#endif
-
-				/* XOAUTH2 */
+				}
 
-				memset(&cb, 0, sizeof(cb));
-				cb.cont = auth_xoauth2;
 				if (imap_exec(ctx, &cb, "AUTHENTICATE XOAUTH2") != RESP_OK) {
 					fprintf(stderr, "IMAP error: AUTHENTICATE XOAUTH2 failed\n");
 					goto bail;

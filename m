Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B3C38C
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 10:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713696150; cv=none; b=afvHhvcIk/IlGmd5yqA/CY5N7ZUYO01DjcNg89RoO3USwI6tYME28A9oF1D/0GPpr8drF52FG0BvSrfgI9si/SY9j+89AfUfagaToZq5YgKv0yOA7k/evWDixRO4cIRus3lCUIUQe4t2JP1vycQpv7uCd2vfXSyeDJak+1m04Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713696150; c=relaxed/simple;
	bh=Vxb7ANfPOGwtqj8ptT2+mmxf2VC/IXG3J78ndvHvO4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HQ8g6DL9PIk69xUEr0Aw9qHc9tLAnq0Oh7DrBuhStwssR5J6XE7wesC/vW521YSHU4oqKYyxdHzREs0x27LH71AvnGwmzPFaCKF9R/Ys/z5oC57OK3FOGrB2OZkax4kGx2YeMi+aP7yHILRjEd+uIYU2Tfw5k7nae3C0VnbLh5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=XFXNRLEB; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="XFXNRLEB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713696139; x=1714300939; i=l.s.r@web.de;
	bh=CpyQGeb7rtI2NqTBddMxBZ9Z3nWxyjWyaCZB4gzUciI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XFXNRLEBJFYPMEicrHdfToSUSPekoX7FqlQP94dcJBUH4eVv1p/6QZrMjlkc302v
	 3a5RT1BMz87OUAPWHeTzEKjE8En8DrBVtkAbP1FOYIbSoC79IGE2svdqv82CmUluW
	 2uI9takhmK1ie4crJhZUEbCRWOGT5LqGuzrJGwueJKXpsXxvMULWqLIBAThtWoeE8
	 gtQzkJWx+BoaG5VCFggu0Jwdm04uqvT2BeED8elaf/pWwBg6EB2FH0yA+xRw0Lc/9
	 u+DMJRmBZldVoHeNmgp0VwaI1ybzk4JbzyK8ucChh9fygJctFqTO/hpk+tdmE1YfR
	 PhPr0SX3w+HhISTs8Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.5]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjgXH-1sRjjV3h8d-00iVvm; Sun, 21
 Apr 2024 12:42:18 +0200
Message-ID: <82561c70-ec33-41bf-b036-52310ffc1926@web.de>
Date: Sun, 21 Apr 2024 12:42:18 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible git-diff bug when using exit-code with diff filters
To: German Lashevich <german.lashevich@gmail.com>, git@vger.kernel.org
References: <CACDhgro3KXD0O9ZdE1q46jmXE0O=vf-Z+ZX50WMqmRHAeowGAA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CACDhgro3KXD0O9ZdE1q46jmXE0O=vf-Z+ZX50WMqmRHAeowGAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:76sSd5dEIPc+hd2BFhL1+b0rj5DS0UHp5SvYwyYaVOI46DL4bRi
 H2IZe6xS932/fsXxPyp8Km5snF2ifu5ewDzz/Mca4kLJ9gzkqqK4rlB6BRbFHAezz87THWk
 G2i4QkH0Q76TQtEDAF4cUIWXRoJAYzvhVU0KdBJGshK5CCPCx9w66rJ4qFQE68pUqY6erb7
 iq13gWimPZ8HErbzTX6PA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:v7Qs9eLjoYg=;WhS+hDB+HjJMEF6IwbkkKII4Hee
 K9fUH8lU9o/cj7MlkpfMEqCMwt7EbmjSVPavhAfDgTodnsDIQ/ZRgIdqZNjnQQvWT/OhI9Wl1
 ilhu5hBo3Yeg6z0rB1v745sdbeidMEutJ3KAZKEXTNJrg9GeD10bkIWtZ5NVjkETJA3ED9LHO
 goJiDaBCV11vekyff2gEFCSBqm0i24YaEpX6x0DHyVIKwYSxjBn58RFRpOLodloneFCf3OmSt
 U4y/d7euuzakOghkoUDHqZHKoD38krjwjtDzN+usri0HIJNCuMEFw4dRTsPUAsokHPTI9A0ls
 FEmusHbMJ5k9t7nh1cZ8WZJrK97Y20Tnpem/gZw7kd5v+3qw0sH6DsD00Jr7IyV0nfHJSYAZF
 NCm5dxIaONB4m+k8zvj1V6LyaYVKRgUYym/3zBlaJZ+Hyy9RbEluXGMmhc4uFPQIFky9KvxCC
 rPi/a5I4zTwlH77WFa6aqFfTF1HPL/X4ND9j+pIeB1sfGWLPJH/Hb/w6wuwhDbkU44l0bB4DV
 Ww7yllwUrUwOWSE3DS6QALZFO7m07ED+9ZVCB3CUqxy+Cv8rdwoZHuq22JjHtg3n7a+z8+eLQ
 xZ9vFhTXH9MrUgZOTba9KiOUKrl/2yyVCbBfU+W3fpmODZAdv7rqXjHe1h6u/KbSKtWsdAxTy
 YhL/94JC1+FrcNYt+V0cn3GkGT1ghFu5rxKuxQS6nVIzAEIMMm6un4ydXZxc7EuxFftWq6Hcb
 MT/wKP5SzVwT9l1rx93OKIaufNy2TVklky88Dp1zRoLPQlordqzJU6DB3TAYnUPXIi6LPNsEP
 ECRb0y6688BODP8Z4DH/p7NA8EZUOgzpPk0kqYHknWx+I=

Am 20.04.24 um 03:13 schrieb German Lashevich:
>> What did you do before the bug happened? (Steps to reproduce your issue=
)
>
> I configured a diff filter via gitattributes to use a custom script that=
,
> sometimes, can change the files being compared in a way that there are n=
o
> differences between them.
> Then I used `git diff --exit-code` on the changed file.
>
>> What did you expect to happen? (Expected behavior)
>
> I expected `git diff --exit-code` to return 0, since there are no differ=
ences
> between the files after the filter is applied.
>
>> What happened instead? (Actual behavior)
>
> `git diff --exit-code` correctly produces no output, but returns 1.
>
>> What's different between what you expected and what actually happened?
>
> The difference is that `git diff --exit-code`, instead of returning 0, r=
eturns
> 1 even when there is no output.
>
>> Anything else you want to add:
>
> I have prepared a repository with a test case that reproduces the issue.
> You can find it at https://github.com/Zebradil/git-diff-exit-code-bug-re=
pro
> The Readme file in the repository contains instructions on how to reprod=
uce
> the issue.

You can more easily reproduce it by setting the environment variable
GIT_EXTERNAL_DIFF or the configuration setting diff.external -- no
attributes needed.

The output of external diffs does not influence the exit code currently.
We don't even have a way to find out if there was any output.

The patch below pipes it through a buffer and sets found_changes only if
something was written.  It fixes the error code for external diffs
producing no output, but breaks several am, pull and merge tests (t4150,
t4151, t5520, t6424, t6430, t7611).  So diff_from_contents doesn't work
quite as I expected.

And slurping in the whole output of external diffs is inefficient, of
course.  That could be fixed later by using a small buffer and writing
directly as we read.

Ren=C3=A9


diff --git a/diff.c b/diff.c
index 108c187577..76631644e5 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -40,6 +40,7 @@
 #include "setup.h"
 #include "strmap.h"
 #include "ws.h"
+#include "write-or-die.h"

 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -4404,8 +4405,18 @@ static void run_external_diff(const char *pgm,
 	diff_free_filespec_data(one);
 	diff_free_filespec_data(two);
 	cmd.use_shell =3D 1;
-	if (run_command(&cmd))
-		die(_("external diff died, stopping at %s"), name);
+	if (o->flags.exit_with_status) {
+		struct strbuf out =3D STRBUF_INIT;
+		if (capture_command(&cmd, &out, 0))
+			die(_("external diff died, stopping at %s"), name);
+		if (out.len)
+			o->found_changes =3D 1;
+		write_or_die(1, out.buf, out.len);
+		strbuf_release(&out);
+	} else {
+		if (run_command(&cmd))
+			die(_("external diff died, stopping at %s"), name);
+	}

 	remove_tempfile();
 }
@@ -4851,6 +4862,7 @@ void diff_setup_done(struct diff_options *options)
 	 */

 	if ((options->xdl_opts & XDF_WHITESPACE_FLAGS) ||
+	    options->flags.exit_with_status ||
 	    options->ignore_regex_nr)
 		options->flags.diff_from_contents =3D 1;
 	else
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index fdd865f7c3..26430ca66b 100755
=2D-- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -172,6 +172,14 @@ test_expect_success 'no diff with -diff' '
 	grep Binary out
 '

+test_expect_success 'diff.external and --exit-code with output' '
+	test_expect_code 1 git -c diff.external=3Decho diff --exit-code
+'
+
+test_expect_success 'diff.external and --exit-code without output' '
+	git -c diff.external=3Dtrue diff --exit-code
+'
+
 echo NULZbetweenZwords | perl -pe 'y/Z/\000/' > file

 test_expect_success 'force diff with "diff"' '


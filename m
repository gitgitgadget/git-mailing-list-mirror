Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03371D5CE0
	for <git@vger.kernel.org>; Sat, 22 Nov 2025 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763817916; cv=none; b=K7/SYDQ+zUZ6oc/xxUK4ipjIQ70dDB1C/OdLGNLN0ybLnmkI2VZQfBbCYsSSY3A8zwulNgh9KFUG2tDjIeSHTCYxwcEWDN/tyuXL1J9EaVM9BEZAk6DvjyOWcwo0uTjPlbNQurWssb8HKtu6g5w6e2c44I1l+1pyPhS22XTYmDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763817916; c=relaxed/simple;
	bh=+QCHCHut3gQuoXL5Z15R+w8EjaS9XDIykDzHdHd47Yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ladp8Wso2nhOxkjJX4ki3iR8E23gxH1HHqoBcKjSl65jM/u2YxBHJLpdBviCF5tuXefmOdI56ouVu87cY64LiKHahukdnlgZAm033UhGwCOzrwOhQe+6gmod4rbGs3sIVewv9vQ0hvFcCBKF14vI0On5gyzqpXYhnIgtGT3jb94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=RXIeRCR5; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="RXIeRCR5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1763817899; x=1764422699; i=l.s.r@web.de;
	bh=eX9JA8tPAjgFrBQu5DS3we+eSMeZ8Cx2Hm2miHbNST8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RXIeRCR5/VQIDK4+z4dZYll5N031u4sYiAD6L1jVXsi198wnK8rGXTpxNfEF2q0G
	 VsEN5ql/oUTCKwpJgMf5ttdRfOxwzgCg8ZyLYLscvOph+4Wdrk8I6CkM/os9vqahd
	 GYtVefmwPk42h6XRqBFhxzOQKsw11AYMpewNEjju1oRvxL4vtJkd+MWvIYklyu9QX
	 nqFtNEGxaoDZUtljOaOl1AjrnC/EYGMEv4ldHp558NotAtZ8BKAt1bCuphiNDZFjN
	 /D27mWk4DFbCWChsPcDWeI5Smn1MUs6aMkzsdACbAfCYDKMb8fk64HOOEz7h1lhnw
	 b+SSY7Mt8Z/1HvfBHg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([91.47.146.25]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MMGyK-1vg7i91K8E-00MHI5; Sat, 22
 Nov 2025 14:24:59 +0100
Message-ID: <fd7023d3-c9a8-4828-b1a2-ac5a1459cbda@web.de>
Date: Sat, 22 Nov 2025 14:24:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wrapper: simplify xmkstemp()
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
References: <058c5722-30f5-4bc5-90f5-24e4c6f3ff8f@web.de>
 <xmqqbjl0iax6.fsf@gitster.g>
 <20251118094621.GB530545@coredump.intra.peff.net>
 <3b1cb53a-6427-4626-a768-1961e25514f8@web.de> <xmqqqztvc51s.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqqztvc51s.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:neQbqaSLudSEcyoRsn2s5KmLqOzXOjxfuBCK1MGAzcFpaxddrvn
 J32kbIkY9GYMUk4GPUUxBIscZRn2Nvnnwvtg7XdMJXLh5w6qng0hOSAYuKmu1NGY8/rCygZ
 rBALFkCOe60hIZCr5hq9fhlCcHuTPWHWnlhcmD9kcZD42c0N2zbMDubmbae8gDu/jCf0S+B
 +vVpyjbUp4kOUgjCeMp2g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pJTRFWN7v0o=;iwtjUJMKm6iusBkPuHbCwW9cW6r
 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
 cdd6NLvM55hrnCyix+BQCXxX94crXZWzoGDhQJ

On 11/19/25 12:08 AM, Junio C Hamano wrote:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
> When somebody asks:
>=20
>     On this and that platforms, mkstemp() is natively available.
>     Why are we using git_mkstemp_mode() instead?
>=20
> after seeing this patch, I am tempted to say "Why not?"  Are there
> legitimate answers to my "What not?"

My reluctance to let go of mkstemp(3) is seeping through.  I like that
function.  Let's see if I can get over it.

>  - the platform native one could be more performant?

Good question.  A platform could use non-portable tricks like using a
particularly cheap source of randomness or a system call that creates a
file with the next available name matching a prefix.  As there any that
do, though?  We can find out by measuring, patch below.

On macOS 26.1 I get:

$ hyperfine -w3 -C 'rm /tmp/tmp_*' -L fn mkstemp,git_mkstemp_mode "t/helpe=
r/test-tool mktemp -n 1000 -f {fn} /tmp/tmp_XXXXXX"
Benchmark 1: t/helper/test-tool mktemp -n 1000 -f mkstemp /tmp/tmp_XXXXXX
  Time (mean =C2=B1 =CF=83):      56.7 ms =C2=B1   0.4 ms    [User: 3.7 ms=
, System: 52.5 ms]
  Range (min =E2=80=A6 max):    56.0 ms =E2=80=A6  57.3 ms    23 runs

Benchmark 2: t/helper/test-tool mktemp -n 1000 -f git_mkstemp_mode /tmp/tm=
p_XXXXXX
  Time (mean =C2=B1 =CF=83):      54.2 ms =C2=B1   0.4 ms    [User: 3.1 ms=
, System: 50.7 ms]
  Range (min =E2=80=A6 max):    53.7 ms =E2=80=A6  54.9 ms    24 runs

Summary
  t/helper/test-tool mktemp -n 1000 -f git_mkstemp_mode /tmp/tmp_XXXXXX ra=
n
    1.05 =C2=B1 0.01 times faster than t/helper/test-tool mktemp -n 1000 -=
f mkstemp /tmp/tmp_XXXXXX

Weird.  How can mkstemp(3) burn measurably more system cycles?

>  - the platform native one could be more secure?

It could if it works deterministically, or uses a better source of
randomness, or our code contains an exploitable flaw.

>  - using the platform native one, we can lose out custom code?

Not much unless we're willing to give up performance on those platforms
for the cases where we want to set the file mode.  There is mkstemps(3)
for allowing a suffix and mkostemps(3) for also allowing to set open(2)
flags, but I couldn't find an equivalent of git_mkstemp_mode().

A replacement could look like this:

int git_mkstemp_mode(char *pattern, int mode)
{
	int fd =3D mkstemp(pattern);
	if (fd >=3D 0 && mode !=3D 0600)
		fchmod(fd, mode);
	return fd;
}

That's basically what happens if we give the test helper a non-default
mode value.  Unsurprisingly the extra fchmod(2) call has a significant
cost:

$ hyperfine -w3 -C 'rm /tmp/tmp_*' -L fn mkstemp,git_mkstemp_mode "t/helpe=
r/test-tool mktemp -n 1000 -m 0700 -f {fn} /tmp/tmp_XXXXXX"
Benchmark 1: t/helper/test-tool mktemp -n 1000 -m 0700 -f mkstemp /tmp/tmp=
_XXXXXX
  Time (mean =C2=B1 =CF=83):      67.2 ms =C2=B1   0.4 ms    [User: 3.9 ms=
, System: 62.9 ms]
  Range (min =E2=80=A6 max):    66.6 ms =E2=80=A6  68.1 ms    22 runs

Benchmark 2: t/helper/test-tool mktemp -n 1000 -m 0700 -f git_mkstemp_mode=
 /tmp/tmp_XXXXXX
  Time (mean =C2=B1 =CF=83):      54.3 ms =C2=B1   0.7 ms    [User: 3.1 ms=
, System: 50.6 ms]
  Range (min =E2=80=A6 max):    53.5 ms =E2=80=A6  57.1 ms    24 runs

Summary
  t/helper/test-tool mktemp -n 1000 -m 0700 -f git_mkstemp_mode /tmp/tmp_X=
XXXXX ran
    1.24 =C2=B1 0.02 times faster than t/helper/test-tool mktemp -n 1000 -=
m 0700 -f mkstemp /tmp/tmp_XXXXXX

If we keep the mode-setting variant anyway, the rest is just a bunch of
trivial wrappers that cannot possibly add a performance problem and are
easy to check for security issues.

> One upside might be that doing so would make the behaviour more
> predictable, in that even on a platform with native mkstemp(), we
> would use the same implementation as what we use on Windows.  But
> I do not know how much upside it is in practice, either.

Using a single implementation everywhere is easier to code, test and
maintain.  A flaw in it would have a bigger blast radius, though.

Can we depend on git_mkstemps_mode() and co.?  We already do.  Can
we depend on them in cases where we don't need a suffix and mode
0600 suffixes?  I don't see why we can't.

Ren=C3=A9


=2D-- >8 ---
Subject: [PATCH] test-mktemp: allow testing mkstemp(3) and git_mkstemp_mod=
e()

Allow testing two more functions for creating temporary files by using
parseopt to provide options for selecting them.

Allow specifying custom file permissions to exercise git_mkstemp_mode()
fully.

Also add an option for calling the selected function a number of times,
which allows for easier performance tests.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/helper/test-mktemp.c | 73 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 3 deletions(-)

diff --git a/t/helper/test-mktemp.c b/t/helper/test-mktemp.c
index 2290688940..9b8bc95683 100644
=2D-- a/t/helper/test-mktemp.c
+++ b/t/helper/test-mktemp.c
@@ -3,13 +3,80 @@
  */
 #include "test-tool.h"
 #include "git-compat-util.h"
+#include "parse-options.h"
+#include "strbuf.h"
+
+static char const * const test_mktemp_usage[] =3D {
+	N_("test-tool mktemp [options] <template>"),
+	NULL
+};
+
+static int test_xmkstemp(char *template, int mode)
+{
+	int fd =3D xmkstemp(template);
+	if (mode !=3D 0600)
+		fchmod(fd, mode);
+	return fd;
+}
+
+static int test_mkstemp(char *template, int mode)
+{
+	int fd =3D mkstemp(template);
+	if (fd < -1)
+		die_errno(_("unable to create temporary file '%s'"), template);
+	if (mode !=3D 0600)
+		fchmod(fd, mode);
+	return fd;
+}
+
+static int test_git_mkstemp_mode(char *template, int mode)
+{
+	int fd =3D git_mkstemp_mode(template, mode);
+	if (fd < -1)
+		die_errno(_("unable to create temporary file '%s'"), template);
+	return fd;
+}
=20
 int cmd__mktemp(int argc, const char **argv)
 {
-	if (argc !=3D 2)
-		usage("Expected 1 parameter defining the temporary file template");
+	struct strbuf template =3D STRBUF_INIT;
+	const char *function_name =3D "xmkstemp";
+	int mode =3D 0600;
+	int count =3D 1;
+	struct option options[] =3D {
+		OPT_STRING_F('f', "function", &function_name, "name",
+			     N_("select the function to call"),
+			     PARSE_OPT_NONEG),
+		OPT_INTEGER('m', "mode", &mode,
+			    N_("specify file permission bits")),
+		OPT_INTEGER('n', "count", &count,
+			    N_("specify the number of files")),
+		OPT_END()
+	};
+	int (*fn)(char *, int);
+
+	argc =3D parse_options(argc, argv, NULL, options,
+			     test_mktemp_usage, 0);
+
+	if (argc !=3D 1)
+		usage_with_options(test_mktemp_usage, options);
+
+	if (!strcmp(function_name, "xmkstemp"))
+		fn =3D test_xmkstemp;
+	else if (!strcmp(function_name, "mkstemp"))
+		fn =3D test_mkstemp;
+	else if (!strcmp(function_name, "git_mkstemp_mode"))
+		fn =3D test_git_mkstemp_mode;
+	else
+		die(_("unsupported function: %s"), function_name);
+
+	for (int i =3D 0; i < count; i++) {
+		strbuf_reset(&template);
+		strbuf_addstr(&template, argv[0]);
+		close(fn(template.buf, mode));
+	}
=20
-	xmkstemp(xstrdup(argv[1]));
+	strbuf_release(&template);
=20
 	return 0;
 }
=2D-=20
2.52.0


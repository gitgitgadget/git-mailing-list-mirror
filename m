Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB62F155A52
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 16:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730134689; cv=none; b=htHnoFk7Eg7t97G64kkptlkrxMTzDJzeSr3mi4Lkgph6Dq+nLu9vKETmuBX1ZcG3FBmTwq4yc4d2dExsrqZBFXGWJQoijlBqee3/anqiOx3vkJes+seSpXMHaYoR+hc/zaG9d6gubW+teK3pKr1iPKvGIYSJ+vnblhxazPO6ha4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730134689; c=relaxed/simple;
	bh=kTrbvjfCDY3P4b/Hv+uxIInfsiBJ0uKO87q6+q3mdyE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=YzuuqcdQaVOaRLoNqcgOuF2kWq0qEM0Fwz5wyd+EnqW9fpUT8TVsnUY4a4+LN+z1H4tE6ws27n+8LUlQi6p4Mxs+32AiSEoyx69i1onE/jRwRzXPYX67pEXHJviygTlN5nRqGLVnqpG/PkxaUS2VwV3wHa7fI/t+soESsX1dsm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJW5bfyy; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJW5bfyy"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e31af47681so3596039a91.2
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 09:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730134686; x=1730739486; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kTrbvjfCDY3P4b/Hv+uxIInfsiBJ0uKO87q6+q3mdyE=;
        b=mJW5bfyycpJIvhtBWV9go6SeZmS3RwV6pWCf8H7BeiWHzFHFFuUL/PQREiOMKOivUq
         g84NOebEHmV10+ukecKstOPUFUEoc340d1b7dGvHusNhitkNDqxGx49o6X0Hcu3SnIYM
         skmaTgnzflDCA6K/2clWCbzatGuxXrwJg3p/SMOOhaX5N+JD/UheoZKpHBiJkuiskfKk
         +CdPQw6QmxK5NyP5w6t/6taY0BTEalBgGNlQBbKf4so4TFa4gYrpNc2ZXgBBbU58sDj9
         EaLwFxDBcXxTdpf4HF03BTNMs98zZ6+O2nRlxgHnWTNwUkZpuFcfRjtC6xYwRRHoOQmE
         BUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730134686; x=1730739486;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kTrbvjfCDY3P4b/Hv+uxIInfsiBJ0uKO87q6+q3mdyE=;
        b=iU3njqmTWy5pzF4jAvxiLbVAKSOtUleo2nmBfJt6omgUl/yGGeQllqo+RCwZ93P/A5
         YDb7UAPzGElnDH43Om6e69TzQ+fWOqDx4Q5I2mdro6l+i8V5xveXJ3777PY0amNwMoSg
         a8i0p5aKCK2X1eV/1c3mzxiQDV9u9U8lyHNVBd1Sx/ssrTzuWe53a/ExJOPfgpqwN/gR
         7/SkBOZkrm5TLenZ2nne8Q/j9Z41fWy9Bs19Didy6hIg9pjlfZJ6D5FjYmLWgehq4HYN
         OCg9l12imbxHdGb0pI7gyla+DxA3tiijSMgIH2ErHu7WOhlY1w+rFnH61kOFHS12p24C
         hHjQ==
X-Gm-Message-State: AOJu0Yy2tshwGtHqeOTu/VTkAEoYygABiDANxLCwpEGpbjcdaEc7tS5N
	msTB27cBJTV5Ph++bBlxKFMEYZdUJI2Ex3aEYjdWfRMva4DiFUU3YZ2pkqkCgEz52hED3Jdphy2
	ZK6UXoRuxAlHtwgcKPU41UGSoSMcakyiJ
X-Google-Smtp-Source: AGHT+IHaAxd5dcaGegCOUuwWGtZBMLloqCmcSizKpEwSNUWOiF0uKPfZKMxqZ5E6RMP6zJzlryP4he5mO6WOfdZQ85c=
X-Received: by 2002:a17:90a:6b0e:b0:2e2:ffb0:89f6 with SMTP id
 98e67ed59e1d1-2e8f106ba6emr10773459a91.15.1730134685578; Mon, 28 Oct 2024
 09:58:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Peregi_Tam=C3=A1s?= <petamas@gmail.com>
Date: Mon, 28 Oct 2024 17:57:54 +0100
Message-ID: <CAExmRTbMCayh+vHW3g=2p=FMb=VKXomEbn7_0t+kK-eF79JnEA@mail.gmail.com>
Subject: Inconsistent handling of corrupt patches based on line endings
To: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000591ac106258c5fb0"

--000000000000591ac106258c5fb0
Content-Type: multipart/alternative; boundary="000000000000591abe06258c5fae"

--000000000000591abe06258c5fae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I might've found an inconsistency in how git-apply treats corrupt patches
(representing empty context lines with completely empty lines instead of
lines containing a single space - usually a result of a "trim trailing
whitespace" editor setting) based on whether the patch file uses
Windows-style line endings (CRLF) or Unix-style line endings (LF only).

Regardless of whether I use LF or CRLF in original.txt, "git apply --check
--ignore-whitespace" will happily apply intact-win.patch (uncorrupted patch
file with CRLF), intact-unix.patch (uncorrupted patch file with LF) and
corrupt-unix.patch (corrupted patch file with LF), but reports "error:
corrupt patch at line 6" for corrupt-win.patch (corrupted patch file with
CRLF).

My intuition tells me git-apply should either fail for all corrupt patch
files (regardless of EOL) or it should apply the corrupt patch to work
around the issue caused by misconfigured text editors (regardless of EOL).

Am I missing something, or is this a bug/inconsistency in
git-apply's behaviour?

Thanks in advance: Tam=C3=A1s Peregi

**What did you do before the bug happened? (Steps to reproduce your issue)*=
*

1. Rename either original-win.txt or original-unix.txt to original.txt
2. Run the following commands:
2.1. git apply --check --ignore-whitespace intact-unix.patch
2.2. git apply --check --ignore-whitespace intact-win.patch
2.3. git apply --check --ignore-whitespace corrupt-unix.patch
2.4. git apply --check --ignore-whitespace corrupt-win.patch

**What did you expect to happen? (Expected behavior)**

I'd expect one of the following:
- All 4 commands succeed.
- 2.1 and 2.2 succeeds, 2.3 and 2.4 both fail with "error: corrupt patch at
line 6"

In other words: corrupted patches should either be accepted or not,
regardless of what EOL markers are used in the patch file.

**What happened instead? (Actual behavior)**

Only 2.4, i.e. applying corrupt-win.patch has failed.

**What's different between what you expected and what actually happened?**

2.3 and 2.4 should have the same result.

**Anything else you want to add:**

While the example seems contrived, it has been encountered in the wild when
I was copying a port from https://github.com/microsoft/vcpkg (set up with
autocrlf=3Dfalse and all files treated as binaries in .gitattributes) to my
company's repository (set up with autocrlf=3Dtrue and patch files treated a=
s
text). The patches and application worked in Microsoft's repo, then worked
on my machine (Windows) in our repor, but failed in CI on Windows, and
started failing on my machine after switching to a different branch and
switching back due to "git checkout" converting the newline characters.

I think these kind of corrupt patch files should fail to apply
consistently, but being able to apply them is also acceptable. However, the
current inconsistent behaviour (apply if patch is LF, but fail if patch is
CRLF) is confusing, and causes "works on my machine" issues.


[System Info]
git version:
git version 2.46.0.windows.1
cpu: x86_64
built from commit: 2e6a859ffc0471f60f79c1256f766042b0d5d17d
sizeof-long: 4
sizeof-size_t: 8
shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
feature: fsmonitor--daemon
libcurl: 8.9.0
OpenSSL: OpenSSL 3.2.2 4 Jun 2024
zlib: 1.3.1
uname: Windows 10.0 19045
compiler info: gnuc: 14.1
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.ex=
e

--000000000000591abe06258c5fae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<br><br>I might&#39;ve found an inconsistency in ho=
w git-apply treats corrupt patches (representing empty context lines with c=
ompletely empty lines instead of lines containing a single space - usually =
a result of a &quot;trim trailing whitespace&quot; editor setting) based on=
 whether the patch file uses Windows-style line endings (CRLF) or Unix-styl=
e line endings (LF only).=C2=A0<div><br></div><div>Regardless of whether I =
use LF or CRLF in original.txt, &quot;git apply --check --ignore-whitespace=
&quot; will happily apply intact-win.patch (uncorrupted patch file with CRL=
F), intact-unix.patch (uncorrupted patch file with LF) and corrupt-unix.pat=
ch (corrupted patch file with LF), but reports &quot;error: corrupt patch a=
t line 6&quot; for corrupt-win.patch (corrupted patch file with CRLF).<br><=
br>My intuition tells me git-apply should either fail for all corrupt patch=
 files (regardless of EOL) or it should apply the corrupt patch to work aro=
und the issue caused by misconfigured text editors (regardless of EOL).<br>=
<br>Am I missing something, or is this a bug/inconsistency in git-apply&#39=
;s=C2=A0behaviour?</div><div><br></div><div>Thanks in advance: Tam=C3=A1s P=
eregi<br><br>**What did you do before the bug happened? (Steps to reproduce=
 your issue)**<br><br>1. Rename either original-win.txt or original-unix.tx=
t to original.txt<br>2. Run the following commands:<br>2.1. git apply --che=
ck --ignore-whitespace intact-unix.patch<br>2.2. git apply --check --ignore=
-whitespace intact-win.patch<br>2.3. git apply --check --ignore-whitespace =
corrupt-unix.patch<br>2.4. git apply --check --ignore-whitespace corrupt-wi=
n.patch<br><br>**What did you expect to happen? (Expected behavior)**<br><b=
r>I&#39;d expect one of the following:<br>- All 4 commands succeed.<br>- 2.=
1 and 2.2 succeeds, 2.3 and 2.4 both fail with &quot;error: corrupt patch a=
t line 6&quot;<br><br>In other words: corrupted patches should either be ac=
cepted or not, regardless of what EOL markers are used in the patch file.<b=
r><br>**What happened instead? (Actual behavior)**<br><br>Only 2.4, i.e. ap=
plying corrupt-win.patch has failed.<br><br>**What&#39;s different between =
what you expected and what actually happened?**<br><br>2.3 and 2.4 should h=
ave the same result.<br><br>**Anything else you want to add:**<br><br>While=
 the example seems contrived, it has been encountered in the wild when I wa=
s copying a port from=C2=A0<a href=3D"https://github.com/microsoft/vcpkg">h=
ttps://github.com/microsoft/vcpkg</a> (set up with autocrlf=3Dfalse and all=
 files treated as binaries in .gitattributes) to my company&#39;s repositor=
y (set up with autocrlf=3Dtrue and patch files treated as text). The patche=
s and application worked in Microsoft&#39;s repo, then worked on my machine=
 (Windows) in our repor, but failed in CI on Windows, and started failing o=
n my machine after switching to a different branch and switching back due t=
o &quot;git checkout&quot; converting the newline characters.</div><div><br=
></div><div>I think these kind of corrupt patch files should fail to apply =
consistently, but being able to apply them is also acceptable. However, the=
 current inconsistent behaviour (apply if patch is LF, but fail if patch is=
 CRLF) is confusing, and causes &quot;works on my machine&quot; issues.</di=
v><div><br><br>[System Info]<br>git version:<br>git version 2.46.0.windows.=
1<br>cpu: x86_64<br>built from commit: 2e6a859ffc0471f60f79c1256f766042b0d5=
d17d<br>sizeof-long: 4<br>sizeof-size_t: 8<br>shell-path: D:/git-sdk-64-bui=
ld-installers/usr/bin/sh<br>feature: fsmonitor--daemon<br>libcurl: 8.9.0<br=
>OpenSSL: OpenSSL 3.2.2 4 Jun 2024<br>zlib: 1.3.1<br>uname: Windows 10.0 19=
045<br>compiler info: gnuc: 14.1<br>libc info: no libc information availabl=
e<br>$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\ba=
sh.exe</div></div>

--000000000000591abe06258c5fae--
--000000000000591ac106258c5fb0
Content-Type: text/plain; charset="US-ASCII"; name="original-unix.txt"
Content-Disposition: attachment; filename="original-unix.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_m2t8kfpv4>
X-Attachment-Id: f_m2t8kfpv4

YQoKYgpjCmQKZQoKZgo=
--000000000000591ac106258c5fb0
Content-Type: application/octet-stream; name="intact-win.patch"
Content-Disposition: attachment; filename="intact-win.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m2t8kfpr3>
X-Attachment-Id: f_m2t8kfpr3

ZGlmZiAtLWdpdCBhL29yaWdpbmFsLnR4dCBiL29yaWdpbmFsLnR4dA0KaW5kZXggZTc1ODJiNy4u
OTQwYjVhNiAxMDA2NDQNCi0tLSBhL29yaWdpbmFsLnR4dA0KKysrIGIvb3JpZ2luYWwudHh0DQpA
QCAtMiw2ICsyLDcgQEAgYQ0KIA0KIGINCiBjDQorTkVXIExJTkUNCiBkDQogZQ0KIA0K
--000000000000591ac106258c5fb0
Content-Type: application/octet-stream; name="intact-unix.patch"
Content-Disposition: attachment; filename="intact-unix.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m2t8kfpn2>
X-Attachment-Id: f_m2t8kfpn2

ZGlmZiAtLWdpdCBhL29yaWdpbmFsLnR4dCBiL29yaWdpbmFsLnR4dAppbmRleCBlNzU4MmI3Li45
NDBiNWE2IDEwMDY0NAotLS0gYS9vcmlnaW5hbC50eHQKKysrIGIvb3JpZ2luYWwudHh0CkBAIC0y
LDYgKzIsNyBAQCBhCiAKIGIKIGMKK05FVyBMSU5FCiBkCiBlCiAK
--000000000000591ac106258c5fb0
Content-Type: application/octet-stream; name="corrupt-unix.patch"
Content-Disposition: attachment; filename="corrupt-unix.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m2t8kfpc0>
X-Attachment-Id: f_m2t8kfpc0

ZGlmZiAtLWdpdCBhL29yaWdpbmFsLnR4dCBiL29yaWdpbmFsLnR4dAppbmRleCBlNzU4MmI3Li45
NDBiNWE2IDEwMDY0NAotLS0gYS9vcmlnaW5hbC50eHQKKysrIGIvb3JpZ2luYWwudHh0CkBAIC0y
LDYgKzIsNyBAQCBhCgogYgogYworTkVXIExJTkUKIGQKIGUKCg==
--000000000000591ac106258c5fb0
Content-Type: application/octet-stream; name="corrupt-win.patch"
Content-Disposition: attachment; filename="corrupt-win.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m2t8kfpg1>
X-Attachment-Id: f_m2t8kfpg1

ZGlmZiAtLWdpdCBhL29yaWdpbmFsLnR4dCBiL29yaWdpbmFsLnR4dA0KaW5kZXggZTc1ODJiNy4u
OTQwYjVhNiAxMDA2NDQNCi0tLSBhL29yaWdpbmFsLnR4dA0KKysrIGIvb3JpZ2luYWwudHh0DQpA
QCAtMiw2ICsyLDcgQEAgYQ0KDQogYg0KIGMNCitORVcgTElORQ0KIGQNCiBlDQoNCg==
--000000000000591ac106258c5fb0
Content-Type: text/plain; charset="US-ASCII"; name="original-win.txt"
Content-Disposition: attachment; filename="original-win.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_m2t8kfpz5>
X-Attachment-Id: f_m2t8kfpz5

YQ0KDQpiDQpjDQpkDQplDQoNCmYNCg==
--000000000000591ac106258c5fb0--

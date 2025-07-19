Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F7220B80A
	for <git@vger.kernel.org>; Sat, 19 Jul 2025 21:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752962012; cv=none; b=MKeMYMx01SzScvF8ZMFqJLSavGoc+2laZPDkJyrtWYduW9DRTBuDJ+MUk5S18ARgiAsU/pQkR70mOmp9h+wi9IGa+A7SNVTNAjpf1wqezQGkYc23ONkIz98oDFQF/ysySe2xHo0m5bepeVPt8fw7o0297FBmGgoNiQYp9goAmm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752962012; c=relaxed/simple;
	bh=hnQJnAnk3nBctYJ+uDC3f8rtaIRW+VnLAsx96wdDtTk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=c/NKS8ELB35WNtoKtD5fgEE4u76xT2fslOJ2lLuywByiYbvTehrR2QGYAvc/wzq/X1AsUTcORlZHjpD6NEcgAYdnSzdLF159EfTCCCXEc0NZplLnf92w8TbIL9EoPhSYiMcKVgwfZYNRznZmlsXSAO45tx6Fk1x99/pev0e+wFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=tibapriZ; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="tibapriZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1752962006; x=1753566806;
	i=johannes.schindelin@gmx.de;
	bh=8TbaGKjr0WTZ8hzhXwR4GcnhnduF3CVvOEOEcCJDhss=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tibapriZirFAM119lMCWBMKoTwpKD4GlBPVns0cLdcL68Ra2YH2rdVFPfD/5SXaa
	 R1/6BZc+ye8B14IafFzgHu8sbiX4Sk4hTJeI0Oa/a0f3OTwpbwEVbEgmUOKvxxVN7
	 dXKb6MLcTMpo6NXntW8Jph5lEVSZLWQbc/kDOmsHkRYjcIbtwCF+aokV2ZkzXc0j5
	 TamO1zC0mox0lyskeVbaNs/5scu3rjWstRMoJmFj/XpjOtUZywH8YgBIWae07FwiV
	 ZrYGpeWg7YKPHYLOxT0Ljpp9z4fqASvh1b40jyiu99JBReRFQoCLsY8civIasX7eK
	 DbgGm+8mS8JxTB1H2g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.246]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCbEp-1uVJ130q9b-00HIPk; Sat, 19
 Jul 2025 23:53:26 +0200
Date: Sat, 19 Jul 2025 23:53:24 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>, 
    Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 0/7] RFC: Accelerate xdiff and begin its rustification
In-Reply-To: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
Message-ID: <ac871bc4-df93-31f4-55f2-d6fc538a422d@gmx.de>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1520652556-1752962006=:26933"
X-Provags-ID: V03:K1:Z3t+WbimZOcXIWWcSwNQhHvy8MKrwVO7IdU2gBb/TDRJP4FrAM3
 ruElquJv8pGuI3Qk65v51BhQ/sSw0t35AybjwdjioWF0arfcSrZmxEP59csvBoh2vL2tMQ7
 ihlGxoXEegEY733rJzCo3PdzcHk9EemplXkF/bVVeN/8TBgyRhDoZceO/4MZeqO44lCHT4b
 aTDtPX+CsEqKh+vH/6cUA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GuTCdgBBgX4=;+8nAyi5kLCuC19RUAPLvi3W4+dU
 RpSVo7aFJjEqx3x2pJd93CY24kPMNRBc9FMGmjKijYmc/dXm9u5/1f0uZiZ5jH2LpFMX7cdE4
 t8IUqO55AWQRLfLDV9HcyVJMbMZPgGM6hI5JnVmePsbHpb04LFJtUS/q52knq2Dw7wvnNpYgJ
 Bt7CoirUCCdk1UkLIIrEQChP/jKVal91C2LnGWR0thDOeh+jbIQkKMS+CQfIwvoVrtC5Si69w
 1NWWvr+kILG8WA5VWSXhK4qFBncWr/SoUjZk6DIpcB/ZkzUZD/NyVsHG/ybz9FoWJo+nk4h3Q
 PnPuW9qKR9PxcS0ItOAkvg+mWqolaRpMrbWWykzBvvByFMXyFdZaMquEJ9gPSJtPSU6cgUwAx
 AeUY3xJuMQZPrPzPI5eqpi68nanEDtiBKrjSe8Il6mAtBjGb0NNRmvgf8YuYRb716LT3czQeQ
 cPqbjVmgKj8Bdso5tiVyah3csq0wpuuKRqFP0hgmP+AQRN7Trw8vf5dMtQjAG3F3iw+2uek/g
 byaKROj5mdyXZVeMrJQGbJUhW7XiSEz5aeEbbulMM6nPD+0JYs9anNwSXMLIfy0dcPq8xLCTN
 hE5vXWRycEFfK9LtlyTCfwc1pQxlBCfODID03GkIhDAl4NyOUyU85yA36vUKYcMcq9NOs7DgA
 qw3QU0voZNeOcWRMuM+7U0vpMbNIskTgZZDlmmUUNi8jVAMeuAZsDCsO4W2A6+SxUExPziI+4
 X2sk542P8I/pPul6+Ucjn11io+gI89kk7TRpJc9j2/H5ldeKxj+Xyrp9hs8IGjca9a/ysBmfi
 ifVkooGF20pyQpYI4vtNp7g6dBvqxu+ZdtyFhlSeSGTMQmiPyiYpNCqhL9bqRDc268rx1pzJM
 T46Xst7Lp1MJZepDw+WcotitW1psQvvyzoZQN3sbgUNagPqPhIJYd05eNpUe5ylHEB2mnAGzM
 6nMZNH62PUTlyXa9IPTTaOJ404sIm4HheKhMcjECG4ab9YLbXfwghB3q2e5rbkg64Xs7gcRdE
 8al9RBSvrJRvM14VgmMmReak6Qywp21ho5iLsovQ1LoC4n8yYjVkJXTrj4SobjyTByImZBpuz
 VQPsKunqMtIOzjuxOWcVTjiXuHZptBVSSpkDRQrcRZSKIGTgtJEBqr3Xim8vE5Weu3Rnu1KJq
 GLdwepGod8lL4juuNC8xJS/vydGXbBgLq2T6KRwiGt4RGm0rB/SqofkXJ03qVCMvCPPN28wfO
 V4GklN4MEVTs1p8BRU4f5PuO9Dmh/mo30wguqiq5eaBLhM4eU4I+jNJnjMjgDytkEXorS1DGo
 m7brMCcfepNRL+KIr3eJMjGQXJ6QZIK8pOQIuvW5mFBVcU5S8ovrhwFIYSQ+GSdthiYy9jm2x
 K3YwNQSg0WZ1qJDsi4xjscbHhAOwMS2XjwoqNta3NwJeSN+bUdYcj+IwF00Z+FK27hxIvECB9
 3CyNAia96SxM86EP0qbKQSe5Dq8J0ki0GwS474NB/q/Vs5R6g5rZVKHmJOlvEpqWXf1Acn9Fd
 1W4Ccnqp1SNk5nyG9z6JVk5rXyMY0fR8ZGXuZjk0VKHBlgAIuG+PiCW/UwxtfgJLDWd14pKkU
 8umhMvaH31MLthedjIhwYbU1Y2ae683F4dD6M0kML/tV6aX8kNB8wqH76KsXUa5JCFpulCz7w
 gmZDQRAnLnx/QTx6CWIKH+95Oy4d3mWuMUcOLeKND1n/EdUalQC1Eq7sc/LrYxlzabEx5Mq6v
 Gd/kWSx8pCqjbPjovS/X+c9V5VuSuGvPvF4eN1PQKSYTd+sr8ygndtUnb+DyUlellnHE1QvzK
 wjDoAzjMz+AQEmfPbX4YWlPy5tki6PDesLuSMMWRTGlUIKe2RG5Qd5+pqf1ySk/SoHHK7PJ2j
 0RLCQ3jK82r2rze04uL6Jb5C8Afp6ZmVq3TmPMdPk7rd0Zp77tmi2vs8BRcNs7NPF6aPRjtBJ
 RBy0gbLMaSWqrF0VsYqM40gj16lI5L9jYOjPunNxtKwfsKqj+bpZuMOLRuR4E1Jo1jE3F7LSx
 FBgHKySW0ZZq1s24jdA0YE88vIzK3r3XTmUZ3gjbOcMTXDwLlZLwHmQK/MYPpGQEDftJPU6GC
 wrR3bovCtknok6+Cr6+phbJ1rVKvo1z4aG0wbAGeHCw2IZgszvEvsEFhscne9l2dMtpwMPe0A
 uM1wz7sTHFA8EX4Gy8W215T8PrNpWJbneRiZFqL9iM5P1W5H9zY7PbXrNMIxyQecTeQSagDZv
 G0jbK4TSq3SuhRUKolKM3qi73QEITZ7Llb4RphFFVqZJGKyVhT0THk4U4K5nln6NYeBd6PLt1
 9u7hvMGxBPT7bughF8JSRjiosmuQwxl4KYzGQc9YlEXZzG0Qfz9MDg+kuvWZE6Tt0u9/4ZN33
 PBWFPoPxyT9dWvuklkSfhmN7hIkh752XZC8CSPBkx6DNvaM53AUz8rncPu/JbTL7urq9RQZnr
 6GSOLtZG02WVqwOxCMDGAzDCuqY5pimUQ8p9S/1zEII8F20VfCA8fCLLOo6D6AVpYG8ooKFpp
 Mk6/6Si9v5OJoy7yqij1NHbnBSlHj11A85PV0rEU3MoNyXdKFhJ80Tj4lnqZhpjK75nrANKwG
 Aj3vG4O56eS0ioaVJNNZdfBGQ30IoElkK5nprq7aqHrjX+U0UJNKZcWzwaOgU1K/dudjXVb5i
 gWawvDVhwTSFV16DLeSxi6o/GHcOcL20zZx86Q1BlzNtI9azV1rzJryEnGGao0dhGRWK7IVoq
 bBV+S5irW8huHyanpQ2uu6EBiG3kG6FNqZpFCyThPFMg+wrgygVyEnRdp07mNZJ+GA7Zaer4Y
 jXD9Yc5QkTjbGSgxj2uKokoTxoxtskETKfL9IRT9ZFAFwtxBq4k/5OqBv4J+HG5B8IpEhrGAn
 /WbdEjFZPRK8Yyvyg6ThOKQ42X2k7B379weEgfvt8rrwVmmOrgFzh9k4cek8Pq0buJtL+6DX6
 IVzSl7ALE35iHIEJZJUMt8I8C7Nb1FOmoIIh0O5Am1mhUBHuhDmunz5R6nleC8PV6jBStIWvk
 T/AjsQxKM4+QPToMv/1lFY7lR5h7EGUclVmDwuCK3FqE9huQhKK1YEeHAWAry2EA0A64e5Uk4
 TzyqBGMDiQpoUsR6CRSy+lgXea/LEG6JxsWz2Ek3a3LJnvPc2bYt2hSQJkPdjwz4ajYGGGtAa
 Rqx6D/DqoYKE5amoMO7bNOmLXFnKtTWkEYkf37MfJPU0AhmRA13XmBtjuwKDUgh7cE0ejrcHP
 mgTMjY/+LKeSXaYE3/2PBlMYHa78j5OYVV6wkdDmRjOStRX4rodmU4+CzH+dG3c5LAWDjxo20
 dofHgpkN4bQzN29VdslG0nBxQ7z4/0+/4f1orqi5SNu8MYsC9RMCHLjwnGhCOy2xcEpC1SndP
 IBdKHB5Qj8DYTD0uM/f4wdXAQUPxZcmwtuX3BIUGGGziiSiLf6aJJ0fb1d+AS0GXzTqV6uuS+
 6YZ2XI7Fw8d/8gIPek7T8cvuuq2FDYBk/5UgyvBEjXWDcwCksfcVLqPVex37buaid32XynXjq
 upYkUEu2JMB0UxT3frLcFvcXYPYdGmC6hDnpYUL4rPGXbhJuFm1kKWLFg4MT53+88zMMvL78k
 PyL71HMBzrDcDLPtBCpqFrba+ERqhYdZ7FgHkF7hbJ8C5ZTXF8k2Hyf8jC6QeS6TKL04PhESc
 lf0timXdJn68p5I/+sQbYLYy6V8Y7j0SgtDKUfdqXj4i6C2vhr7J2YhyM+4g/QvwSyA0hTO4D
 rcvYQ2TZIDCipwkLEoeWIRmRYPjIy1V7Y5hOVNLKAQH2MBja0StCrTEeFUq0=

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1520652556-1752962006=:26933
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ezekiel,                                                               =
                                                                          =
                                                                 =20
pleasure to make your acquaintance!

On Thu, 17 Jul 2025, Ezekiel Newren via GitGitGadget wrote:

> 1. Windows fails to build. I don=E2=80=99t know which rust toolchain is =
even
>    correct for this or if multiple are needed.  Example failed build:
>    https://github.com/git/git/actions/runs/16353209191

There are a couple of problems, not just one. Here are the patches that I
would like to ask you to take custody of (for your convenience, I have
pushed them to https://github.com/dscho/git as the `xdiff_rust_speedup`
branch). Please find them below. They _just_ fix the build, but the tests
with win+Meson still fail (and as "win+Meson test" jobs keep the logs of
the failed tests a well-guarded secret, due to time constraints I have to
stop looking into this for now).

Thank you for working on this,
Johannes

=2D- snipsnap --
=46rom 72c50ee3f9df5ccfe48bf6f44b2c6bba05a680bf Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Sat, 19 Jul 2025 21:24:07 +0200
Subject: [PATCH 1/3] Do support Windows again after requiring Rust

By default, Rust wants to build MS Visual C-compatible libraries on
Windows, because that is _the_ native C compiler.

Git is historically lacking in its MSVC support, and the official Git
for Windows versions are built using GCC instead. As a consequence, a
(subset of a) GCC toolchain is installed as part of the `windows-build`
job of every CI build.

Naturally, this requires adjustments in how Rust is called, most
importantly it requires installing support for a GCC-compatible build
target.

Let's make the necessary adjustment both in the CI-specific code that
installs Rust as well as in the Windows-specific configuration in
`config.mak.uname`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 ci/install-rust.sh | 3 +++
 config.mak.uname   | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/ci/install-rust.sh b/ci/install-rust.sh
index 141ceddb17cfe..c22baa629ceb7 100644
=2D-- a/ci/install-rust.sh
+++ b/ci/install-rust.sh
@@ -28,6 +28,9 @@ if [ "$BITNESS" =3D "32" ]; then
   $CARGO_HOME/bin/rustup default --force-non-host $RUST_VERSION || exit $=
?
 else
   $CARGO_HOME/bin/rustup default $RUST_VERSION || exit $?
+  if [ "$CI_OS_NAME" =3D "windows" ]; then
+    $CARGO_HOME/bin/rustup target add x86_64-pc-windows-gnu || exit $?
+  fi
 fi
=20
 . $CARGO_HOME/env
diff --git a/config.mak.uname b/config.mak.uname
index 3e26bb074a4b5..fbe7cebf40edd 100644
=2D-- a/config.mak.uname
+++ b/config.mak.uname
@@ -727,19 +727,28 @@ ifeq ($(uname_S),MINGW)
 		prefix =3D /mingw32
 		HOST_CPU =3D i686
 		BASIC_LDFLAGS +=3D -Wl,--pic-executable,-e,_mainCRTStartup
+		CARGO_BUILD_TARGET =3D i686-pc-windows-gnu
         endif
         ifeq (MINGW64,$(MSYSTEM))
 		prefix =3D /mingw64
 		HOST_CPU =3D x86_64
 		BASIC_LDFLAGS +=3D -Wl,--pic-executable,-e,mainCRTStartup
+		CARGO_BUILD_TARGET =3D x86_64-pc-windows-gnu
         else ifeq (CLANGARM64,$(MSYSTEM))
 		prefix =3D /clangarm64
 		HOST_CPU =3D aarch64
 		BASIC_LDFLAGS +=3D -Wl,--pic-executable,-e,mainCRTStartup
+		CARGO_BUILD_TARGET =3D aarch64-pc-windows-gnu
         else
 		COMPAT_CFLAGS +=3D -D_USE_32BIT_TIME_T
 		BASIC_LDFLAGS +=3D -Wl,--large-address-aware
         endif
+
+	export CARGO_BUILD_TARGET
+	RUST_TARGET_DIR =3D rust/target/$(CARGO_BUILD_TARGET)/$(RUST_BUILD_MODE)
+	# Unfortunately now needed because of Rust
+	EXTLIBS +=3D -luserenv
+
 	CC =3D gcc
 	COMPAT_CFLAGS +=3D -D__USE_MINGW_ANSI_STDIO=3D0 -DDETECT_MSYS_TTY \
 		-fstack-protector-strong
=2D-=20
2.50.1.windows.1


=46rom ef6e4394ae26d8f28cb0d9e456810ce0818e623b Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Sat, 19 Jul 2025 23:08:11 +0200
Subject: [PATCH 2/3] win+Meson: allow for xdiff to be compiled with MSVC

The `build_rust.sh` script is quite opinionated about the naming scheme
of the C compiler: It assumes that the xdiff library file will be named
`libxdiff.a`.

However, MS Visual C generates `xdiff.lib` files instead; This naming
scheme has been in use in a very, very long time.

Let's allow for that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 build_rust.sh |  7 ++++++-
 meson.build   | 12 +++++++++---
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/build_rust.sh b/build_rust.sh
index 4c12135cd2050..694d48d857a58 100755
=2D-- a/build_rust.sh
+++ b/build_rust.sh
@@ -44,7 +44,12 @@ fi
=20
 cd $dir_rust && cargo clean && pwd && cargo build -p $crate $rust_args; c=
d ..
=20
-libfile=3D"lib${crate}.a"
+if grep x86_64-pc-windows-msvc rust/target/.rustc_info.json
+then
+  libfile=3D"${crate}.lib"
+else
+  libfile=3D"lib${crate}.a"
+fi
 dst=3D$dir_build/$libfile
=20
 if [ "$dir_git_root" !=3D "$dir_build" ]; then
diff --git a/meson.build b/meson.build
index 047d7e5b66306..5e89a5dd0e00f 100644
=2D-- a/meson.build
+++ b/meson.build
@@ -277,8 +277,16 @@ else
   rustflags =3D '-Aunused_imports -Adead_code -C debuginfo=3D2 -C opt-lev=
el=3D1 -C force-frame-pointers=3Dyes'
 endif
=20
+compiler =3D meson.get_compiler('c')
+
+if compiler.get_id() =3D=3D 'msvc'
+  xdiff_lib_filename =3D 'xdiff.lib'
+else
+  xdiff_lib_filename =3D 'libxdiff.a'
+endif
+
 rust_build_xdiff =3D custom_target('rust_build_xdiff',
-  output: 'libxdiff.a',
+  output: xdiff_lib_filename,
   build_by_default: true,
   build_always_stale: true,
   command: [
@@ -288,8 +296,6 @@ rust_build_xdiff =3D custom_target('rust_build_xdiff',
   install: false,
 )
=20
-compiler =3D meson.get_compiler('c')
-
 libgit_sources =3D [
   'abspath.c',
   'add-interactive.c',
=2D-=20
2.50.1.windows.1


=46rom 9c3b017cfa069211027fbb1f6d3b97c8e7edda81 Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Sat, 19 Jul 2025 23:22:57 +0200
Subject: [PATCH 3/3] win+Meson: do allow linking with the Rust-built xdiff

When linking against the Rust-built `xdiff`, there is now a new required
dependency: Without _also_ linking to the system library `userenv`, the
compile would fail with this error message:

  xdiff.lib(std-c85e9beb7923f636.std.df32d1bc89881d89-cgu.0.rcgu.o) :
  error LNK2019: unresolved external symbol __imp_GetUserProfileDirectoryW
  referenced in function _ZN3std3env8home_dir17hfd1c3b6676cd78f6E

Therefore, just like we do in case of Makefile-based builds on Windows,
we now also link to that library when building with Meson.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index 5e89a5dd0e00f..af015f04763fd 100644
=2D-- a/meson.build
+++ b/meson.build
@@ -1260,6 +1260,7 @@ elif host_machine.system() =3D=3D 'windows'
   ]
=20
   libgit_dependencies +=3D compiler.find_library('ntdll')
+  libgit_dependencies +=3D compiler.find_library('userenv')
   libgit_include_directories +=3D 'compat/win32'
   if compiler.get_id() =3D=3D 'msvc'
     libgit_include_directories +=3D 'compat/vcbuild/include'
=2D-=20
2.50.1.windows.1

--8323328-1520652556-1752962006=:26933--

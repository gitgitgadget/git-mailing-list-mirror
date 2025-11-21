Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E543002BD
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 21:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763761148; cv=none; b=ch3kuN0YfByMnjC469UoQ1TQwj+ck3zG5m6xRCCQ73SE0hXD3NVk40Sv3GdF23b8Vcu5+CIaPtnyrHcYGoFU1HSbZ39BLxdDiIltPFeXJh5nSltwgCATqelR14lI9Na5kpaNmy+krU1YplQjPpLeW1qLtHVOXrzgfrmgIDb9xYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763761148; c=relaxed/simple;
	bh=IyIY4Jnne3EhixBbLQBlT3NLyYIchm8s4ArS2xMyNmg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RNNJvWrnqKbY5UKX9drg5+8teCWb0nxloUYYCst18aVQrcH6ncBRgYAfy5qi3RUxC2VIXHmzthon2WegHsuUp1m7ROuwUefVMnnAXYrdOdnvOP4MlpjQo/4NmY/Zkwsmyk/uElFVJeIfrl+H8RNDL/HSpHP3Tne6HstRTCwHoy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZRjuhr6g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=otlM9937; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZRjuhr6g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="otlM9937"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0E4307A0120;
	Fri, 21 Nov 2025 16:39:04 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 21 Nov 2025 16:39:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763761143; x=1763847543; bh=iIu+CFzvQj
	vbHPk3iZFnW2JIEYMQJW4uZWkSxF7KZG4=; b=ZRjuhr6gOkxhmkscKstSy+P1tH
	T0+Lv6prS9SSv+rzMxiIiULRoim6fg+PpWZExGP8fsIx14tSsjOnIlUjFYd+fjjv
	asQS2R434pya2UU5Porr5+gSwVbpu/SUnUYg+ccU3ex5G9Pi01zTW10TzBleT7Oy
	dacwPtIoQiNfw+veqeDHNi+n9nqEnvfrI4CydJkXVKHPZDj3H2haF1ebjXu5ubyS
	etWrJiL61KtfI+g6T+NbHuPZ9JzK0NRHmEPsr+uMf1KITrhovYHo8XvAyjUK2Lra
	hetRC4LxkCss0Dp/Nh1BeFiTiZP8GL5T9FN0G4om23Ojb9yvvoxwqxP7OBBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763761143; x=1763847543; bh=iIu+CFzvQjvbHPk3iZFnW2JIEYMQJW4uZWk
	SxF7KZG4=; b=otlM9937Qp+IXqpNLaPh4ooNRp8xmDsvhfF+9IXYY/gOXyhoff1
	yHvnVoimiKRPe599++muIPhVLlEdLLAscXvYCawkK4SuW+mbTcqIpI4ivthO7/oi
	erFfLzIWhcfhV/klS3s3++VQAZYWZPbuKh8ndK6rEuzTyb6IAKk4QWlTFWwK6G7s
	CYqz9R5jUbgc4JOy4u35vLbc85w2ehYgO7CwqdH1pnPzBEs/PJoF135dwEUELoqf
	PjvDFcev5uj7m9b2Otj/G46oXsxAVaD3+2h4LVtBTjaRUNghPVyPMymQTSHjoZ4Y
	Zf/ZcvQlKy4Vxb07pKJuXfJclqgabdEqdQg==
X-ME-Sender: <xms:99sgafPIJHUZjH_U4iGtM0nEqRlpMWBNPgs9DLQ5dDirIkXEWMCQ2w>
    <xme:99sgacjB6xnKCiwcjp_0FnjSB5AtgFRad4hMTyFmT2W6Jq03t_cxI9E80tzjEQLeA
    q2aEleS_2El1H7b4gkkKBQGOqimKdzNMK7akWJI-nZgMwlq_Xlx>
X-ME-Received: <xmr:99sgaR4H-XTuhKBNaYtCX285NgrqMJqg2mBRfNantTLhYJV0vBOK8R_NOJxaFXBWbQldxyebdkbjjfq059vFHbgpHmFYJGAEx_eg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedutdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjoh
    hhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopegviigv
    khhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpth
    htohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopegvrhhi
    tghsuhhnshhhihhnvgesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsrdhtoh
    hrvghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:99sgaT2xoSsjdOftEdrJsD-V2zor946iWWcjnExfwLvG6o8jZppdQg>
    <xmx:99sgact00aT-mwKhnZDbT5euvklHtxExqdoFZ7rWtwdkGKEYWgotkA>
    <xmx:99sgaZ7S4iIwXUkWM-_WIU6DJZy9DTNRwpxwsOaEJ4rq2GiX1-iiEw>
    <xmx:99sgaYedfJqhLQN0hIJu3H5Pmi-1DYxWKudxbcOxJo47klNJ1gXpeA>
    <xmx:99sgaZ-GBea9paIQZ8nDjPAjKULebVx18eqV57Z5tb62Nbu6hKO99NZ7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 16:39:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,  Patrick Steinhardt
 <ps@pks.im>,  git@vger.kernel.org,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Karthik Nayak <karthik.188@gmail.com>,
  Eric Sunshine <ericsunshine@gmail.com>,  Chris Torek
 <chris.torek@gmail.com>
Subject: Re: [PATCH v3 6/6] rust: support for Windows
In-Reply-To: <dc753c0e-eb93-948c-55f7-bb0e91772c83@gmx.de> (Johannes
	Schindelin's message of "Fri, 21 Nov 2025 09:18:47 +0100 (CET)")
References: <20251015-b4-pks-ci-rust-v3-0-13810af33bd5@pks.im>
	<20251015-b4-pks-ci-rust-v3-6-13810af33bd5@pks.im>
	<CAH=ZcbB8cRgCTp-Q_CxJ4VFNY1+w+C20zgx9bMre4-hNmPrD7g@mail.gmail.com>
	<dc753c0e-eb93-948c-55f7-bb0e91772c83@gmx.de>
Date: Fri, 21 Nov 2025 13:39:01 -0800
Message-ID: <xmqq34673w22.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Here is my patch (with proper handling of MSVC, but obviously it no longer
> applies without conflicts):

Thanks.  Here is my attempt to make it apply to 'master'.

It seems to pass win+Meson build & test for 'master'.

  https://github.com/git/git/actions/runs/19583133885

But curiously, the tip of 'master' has been happy without this fix,
and it does not help when brian's SHA-256 interop topic merged
further on top, but I didn't look any further.

--- >8 ---
Subject: [PATCH] meson(cargo): Visual C produces gitcore.lib, not libgitcore.a

On Windows, when Visual C compiler is used to compile, the resulting
library that is created is called gitcore.lib instead of libgitcore.a
library archive.

Johannes sent a fix in <dc753c0e-eb93-948c-55f7-bb0e91772c83@gmx.de>
that was based on an older code base, which I attempted to forward
port it to apply to today's codebase.

Based-on-the-patch-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 src/cargo-meson.sh | 14 ++++----------
 src/meson.build    | 11 ++++++++++-
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/src/cargo-meson.sh b/src/cargo-meson.sh
index 3998db0435..4a46f731d8 100755
--- a/src/cargo-meson.sh
+++ b/src/cargo-meson.sh
@@ -7,9 +7,10 @@ fi
 
 SOURCE_DIR="$1"
 BUILD_DIR="$2"
+LIBNAME="$3"
 BUILD_TYPE=debug
 
-shift 2
+shift 3
 
 for arg
 do
@@ -26,14 +27,7 @@ then
 	exit $RET
 fi
 
-case "$(cargo -vV | sed -s 's/^host: \(.*\)$/\1/')" in
-	*-windows-*)
-		LIBNAME=gitcore.lib;;
-	*)
-		LIBNAME=libgitcore.a;;
-esac
-
-if ! cmp "$BUILD_DIR/$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/libgitcore.a" >/dev/null 2>&1
+if ! cmp "$BUILD_DIR/$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/$LIBNAME" >/dev/null 2>&1
 then
-	cp "$BUILD_DIR/$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/libgitcore.a"
+	cp "$BUILD_DIR/$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/$LIBNAME"
 fi
diff --git a/src/meson.build b/src/meson.build
index 25b9ad5a14..f37f0a5f58 100644
--- a/src/meson.build
+++ b/src/meson.build
@@ -3,6 +3,14 @@ libgit_rs_sources = [
   'varint.rs',
 ]
 
+# The exact file name depends on the compiler
+if meson.get_compiler('c').get_id() == 'msvc'
+  libname = 'gitcore.lib'
+else
+  libname = 'libgitcore.a'
+endif
+
+
 # Unfortunately we must use a wrapper command to move the output file into the
 # current build directory. This can fixed once `cargo build --artifact-dir`
 # stabilizes. See https://github.com/rust-lang/cargo/issues/6790 for that
@@ -12,6 +20,7 @@ cargo_command = [
   meson.current_source_dir() / 'cargo-meson.sh',
   meson.project_source_root(),
   meson.current_build_dir(),
+  libname,
 ]
 if get_option('buildtype') == 'release'
   cargo_command += '--release'
@@ -21,7 +30,7 @@ libgit_rs = custom_target('git_rs',
   input: libgit_rs_sources + [
     meson.project_source_root() / 'Cargo.toml',
   ],
-  output: 'libgitcore.a',
+  output: libname,
   command: cargo_command,
 )
 libgit_dependencies += declare_dependency(link_with: libgit_rs)
-- 
2.52.0-168-gcf2c56d51e


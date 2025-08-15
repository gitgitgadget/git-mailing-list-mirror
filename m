Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B969145B3F
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 01:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755220987; cv=none; b=HkcN1sie2zHwj7Xtv0whbEKq3CbuHIei080y//6GLu5nqxJw/hhZ1x66HApMxlfwWUK/GUmbNm1cdLN1h7/xCyKEHUDOASjlvZdBvgEgfK/casnA7sW49exw+xzUOHFbvL2BCWHJUP43+5ZNe8AS/BxD15xhYyS/xKvn+yjdHpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755220987; c=relaxed/simple;
	bh=7GE5cPvWoMNlfvRGW4PufIVGj8vETRSB9DgkbfnuLKc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cwi3+MrCoqZB7RhQs7m4CMm9WsVto1wIniPoM9B/I62NVwuIDKmLAJ9YuksnKr8NJB9+DzLGsIegj8OdHd7HN4D0KmEnz6Ji/PchKiH4dLo9zbAPoI47XiT8a8+/N4/6NGuYdXn6iCeA3A2Pm854tkidLasWo/5tupFSWWr3Qzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fdv+VgrT; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fdv+VgrT"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45a1b0b6ac4so7563655e9.2
        for <git@vger.kernel.org>; Thu, 14 Aug 2025 18:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755220984; x=1755825784; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYpfhp1f818tAWgVi0NaYGL52I1NZwmsvlDDItIZFGI=;
        b=Fdv+VgrTmTnEz5e4zphH224alhyLeCsF4zqoz+E0HlVZ153bLeUkMRM84nGXjSSnhM
         x97n+NICtWK4rpPH1EQYKgWonX665fcq8Oi7n+PTJ6+7wBgpBAAxDUWenIrT3vTohndD
         f1CeTpzoR6ve/aOyfzBqbcE8ROvgrmkJ/dSl2zrecrtnH92+wcFkQt9zKLdjKGTpoxzI
         I2LdQX6lTst3a/9euLJJeYLt/ykhyXeAQeutHX5CqJxoDFUsCnZB6C5J1xt+81WFLdE/
         JTIEaNv0SUSooaLR5YcW4PQyj70nt2NjzVeWWSRrWROIAe8jO/eMLGAURprGRXqYzBet
         h7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755220984; x=1755825784;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NYpfhp1f818tAWgVi0NaYGL52I1NZwmsvlDDItIZFGI=;
        b=LpYT1dV2Qrdw0D1IiROOYiyd6JKndmGzy6C0kbiCgzpPwaROA+A2YoZ0pePNm4LAln
         NiTwjjC9+43dZm9sVjP59Jl1/lpfcB+MYQOkWI5lJwSt4EBAYrqPYAfwcps96MSZb4kX
         MkjgKEa5Iwz5r0Gg+RdavSMVDSBoY8mjZmDaom8bElhC6mouIGNIO+B5/tnFyNIDAgFa
         Zb+opeBAskXC/ePord3sx6jqodJOPlNi4RTAVZo+FvRz97nlMOnJvcwbPcl+hmIxLD3z
         vmZAvV46KklOPXjgSFbE/YVEw5E3yMGhRuV0SLcvVsDWQmq4tuE4E8TRTX7loy8dTPU+
         hATQ==
X-Gm-Message-State: AOJu0YyWZBaUNOSn8ojf1Do2mEdFlaCXsaLBnoKjTMoMugLNMoWmsaZj
	be15I0JuWBjhxOFD/JqEp/VQO6EfC20STpvYd+LHj+T+46D/GBvNMIsgD/9Epw==
X-Gm-Gg: ASbGncu4cCLPKZjveMVvKhDpaZBCZ7izTgaFDUOzbiFC7HAFjRPHvCRWVnVFknItK/b
	MSPsVi9xpZKyl1M0TO21AYK9GukXWDkF+ASDdFHXnFZ5TOeOhEBiXDn24T7Nl4CCiZr6borpYCe
	b8K7w+DrUcvwA5BUwjvIyMS62bQnw0c9UViQs6GWlsPNmOQ3dH7iQuA051n224iGnqwlzleRndl
	UNnvWer+TOWMg9ph2uKjMYoMtp2NAjrgLQhuUWreIUTyWdSXfUVhj8be4OyafklfoTAT44XKDnE
	4LAudq6QeOfzC7a25vbDj1JANJqTvl/lZw7kbq2gbFirmDuEvlISmuko/A1jzT+cC7mj//T2nu0
	O3OuzuhBoZn0+kMWd/5e43BA=
X-Google-Smtp-Source: AGHT+IH5lqjmqLkzBJl6DajAv68/CofZawL8Za1FQPJ0KC+rhEW8XgecAQSq508Frmnb8+NDbGa41Q==
X-Received: by 2002:a05:600c:b99:b0:458:bbed:a81a with SMTP id 5b1f17b1804b1-45a218095b4mr3590225e9.10.1755220984047;
        Thu, 14 Aug 2025 18:23:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bc85csm39330405e9.5.2025.08.14.18.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 18:23:03 -0700 (PDT)
Message-Id: <1194de3f39c76da76b7cbf045162c9c9c8cd5be4.1755220973.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
	<pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 Aug 2025 01:22:45 +0000
Subject: [PATCH v2 10/17] win+Meson: allow for xdiff to be compiled with MSVC
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Taylor Blau <me@ttaylorr.com>,
    Christian Brabandt <cb@256bit.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Eli Schwartz <eschwartz@gentoo.org>,
    "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
    Patrick Steinhardt <ps@pks.im>,
    Sam James <sam@gentoo.org>,
    Collin Funk <collin.funk1@gmail.com>,
    Mike Hommey <mh@glandium.org>,
    Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `build_rust.sh` script is quite opinionated about the naming scheme
of the C compiler: It assumes that the xdiff library file will be named
`libxdiff.a`.

However, MS Visual C generates `xdiff.lib` files instead; This naming
scheme has been in use in a very, very long time.

Let's allow for that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 build_rust.sh |  7 ++++++-
 meson.build   | 12 +++++++++---
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/build_rust.sh b/build_rust.sh
index 4c12135cd205..694d48d857a5 100755
--- a/build_rust.sh
+++ b/build_rust.sh
@@ -44,7 +44,12 @@ fi
 
 cd $dir_rust && cargo clean && pwd && cargo build -p $crate $rust_args; cd ..
 
-libfile="lib${crate}.a"
+if grep x86_64-pc-windows-msvc rust/target/.rustc_info.json
+then
+  libfile="${crate}.lib"
+else
+  libfile="lib${crate}.a"
+fi
 dst=$dir_build/$libfile
 
 if [ "$dir_git_root" != "$dir_build" ]; then
diff --git a/meson.build b/meson.build
index 047d7e5b6630..5e89a5dd0e00 100644
--- a/meson.build
+++ b/meson.build
@@ -277,8 +277,16 @@ else
   rustflags = '-Aunused_imports -Adead_code -C debuginfo=2 -C opt-level=1 -C force-frame-pointers=yes'
 endif
 
+compiler = meson.get_compiler('c')
+
+if compiler.get_id() == 'msvc'
+  xdiff_lib_filename = 'xdiff.lib'
+else
+  xdiff_lib_filename = 'libxdiff.a'
+endif
+
 rust_build_xdiff = custom_target('rust_build_xdiff',
-  output: 'libxdiff.a',
+  output: xdiff_lib_filename,
   build_by_default: true,
   build_always_stale: true,
   command: [
@@ -288,8 +296,6 @@ rust_build_xdiff = custom_target('rust_build_xdiff',
   install: false,
 )
 
-compiler = meson.get_compiler('c')
-
 libgit_sources = [
   'abspath.c',
   'add-interactive.c',
-- 
gitgitgadget


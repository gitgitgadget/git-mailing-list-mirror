Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB69858217
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 21:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705700299; cv=none; b=JsJxgiW83IYsi29Cx0gKobRMEoz7xMnp69NfpO85Dlsx3FYoLrB33U7snnIerg05PcZm0KTlHVgcZVnr2gwexEdttQaNDySeM/iHMot1Cq19ZVtdf7q7xwSv6DTAUs5c5xTQiQi/cbooAcay5+PvasS3AnLeqVZMCWw7jwEmy5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705700299; c=relaxed/simple;
	bh=w99Bbuu7ym+WN3qHG/0ggf9L6fio6HR/B750yqp5jS4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=lbxiytgS2Jjq0+VEPTALXywntwVZ+jLkGKohrXzL8KK5YX3wuRJL4u1QkTrQy2APV58GpGSvNx8I1686KZOfP2bjEf4niY9QYY1Do1FVIhCFTmhRG5l1CcoBnPNifdNvDbKCwUOYqTLR9gjFfX4YNR1WY/sFxkU7mvUCasFGvvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oAjCrIK/; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oAjCrIK/"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ffa078355bso16690627b3.2
        for <git@vger.kernel.org>; Fri, 19 Jan 2024 13:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705700297; x=1706305097; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d3kkhdZa3GGuEn3JvOK/h0ZHibOey7KaISISVpfcmfo=;
        b=oAjCrIK/h7t/i8MDBT8DeW9qVKCU6cQZnvAyqY0FCTS+5SBeN1/e7sc2tGsG8zDrEN
         8fTkmSzKl1g3PahAGOrfaEQPRWd8FSCdxK70rI2caybjsxCdK3cfggcZpEBF6ZXdU7Iy
         UxLXxvCepbKWo3j0sXxP56uK2pAd61MDZ1WFma/0EUCbS37hYPB74KsFN5IRn+GGwwZX
         1D1tTt2mbzNVopnM+cI/SChSOZMuG0oWcVOPvy/klGadJoKh62RM3Rvp0oQADw7mM9W3
         wYWngUlfSN/qYPMWTN48kGdRrtJFtK/+K9XEAhIuNTnT1FkLSjWs4EXb2IfbXrRTRG16
         9fJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705700297; x=1706305097;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d3kkhdZa3GGuEn3JvOK/h0ZHibOey7KaISISVpfcmfo=;
        b=aFQ/+9vak3tdtd82gEEdjneq+hnETxcrwofmhAI2ntjTQ0uCzfhuwTfSvs7DcdaFb6
         grN9Zvw6lIeONF1d5EljWM5ydZH4Dryirt8DzcMNjqqmM2qPKQUBPoSSaK1cpgGmUMqU
         pt8LRgQeK5/QGj7m9Up4xCUxXOdfj2OJB3jjIodB+NiAvEuxgchkJxQav6D5KDQ+yQUF
         gYDNsF54CqKQauu8YUwqcsc0kN+F10XWuFXlPq4f/8PWl4kzjWlfxuzFvDu8+v4XOTzw
         l6tV/mOu0DqIFenTCf0cSackfnAmTSYK1t9eWWVbzSkDLV+orCbFe4Ys7ZzsJZflYM1D
         ACNA==
X-Gm-Message-State: AOJu0YyZAqpg6eV113KDyB2oyM92Y5Snaw4P1sb6lZJgTJ79Gt8Tz9ws
	hRp9KdUab0YIS8kM1dwuQRQ8v48iyWXW1MgNV2v6XOWczfc5FuW3VGTIeK3PbM5X0tuTbZTuS9+
	uYlHX1bOL+kVVqyFqj76U1F/J6AHFU7zxiT7nyzimAbloE/6e/GX8R0I6EMI+xS5sV4OfgoNKq9
	7YFq8Lgu+qj/gl+PG8ByjCq3x/ds3Tp2Xa+4vaAso=
X-Google-Smtp-Source: AGHT+IHMTnW6j6eTDZ9+m/3Xm/rK4MWM/pVWnv2jMyH6Q31MnmMu3uuLoD11cTt/T4TlLSzBSGL9Hhm9WjcRmA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:3aa6:e329:52e1:bd8c])
 (user=steadmon job=sendgmr) by 2002:a0d:dd92:0:b0:5ff:9df0:2a4 with SMTP id
 g140-20020a0ddd92000000b005ff9df002a4mr242246ywe.7.1705700296822; Fri, 19 Jan
 2024 13:38:16 -0800 (PST)
Date: Fri, 19 Jan 2024 13:38:12 -0800
In-Reply-To: <cover.1705700054.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705700054.git.steadmon@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <9332e225e44b29be25d10229b05f0b9775b85568.1705700054.git.steadmon@google.com>
Subject: [PATCH 1/2] fuzz: fix fuzz test build rules
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When we originally added the fuzz tests in 5e47215080 (fuzz: add basic
fuzz testing target., 2018-10-12), we went to some trouble to create a
Makefile rule that allowed linking the fuzz executables without pulling
in common-main.o. This was necessary to prevent the
fuzzing-engine-provided main() from clashing with Git's main().

However, since 19d75948ef (common-main.c: move non-trace2 exit()
behavior out of trace2.c, 2022-06-02), it has been necessary to link
common-main.o due to moving the common_exit() function to that file.
=C3=86var suggested a set of compiler flags to allow this in [1], but this
was never reflected in the Makefile.

Since we now must include common-main.o, there's no reason to pick and
choose a subset of object files to link, so simplify the Makefile rule
for the fuzzer executables to just use libgit.a. While we're at it,
include the necessary linker flag to allow multiple definitions
directly in the Makefile rule, rather than requiring it to be passed on
the command-line each time. This means the Makefile rule as written is
now more compiler-specific, but this was already the case for the
fuzzers themselves anyway.

[1] https://lore.kernel.org/git/220607.8635ggupws.gmgdl@evledraar.gmail.com=
/

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Makefile                  | 14 ++++++++------
 oss-fuzz/dummy-cmd-main.c | 14 ++++++++++++++
 2 files changed, 22 insertions(+), 6 deletions(-)
 create mode 100644 oss-fuzz/dummy-cmd-main.c

diff --git a/Makefile b/Makefile
index 15990ff312..1e9bd6430f 100644
--- a/Makefile
+++ b/Makefile
@@ -752,6 +752,7 @@ SCRIPTS =3D $(SCRIPT_SH_GEN) \
=20
 ETAGS_TARGET =3D TAGS
=20
+FUZZ_OBJS +=3D oss-fuzz/dummy-cmd-main.o
 FUZZ_OBJS +=3D oss-fuzz/fuzz-commit-graph.o
 FUZZ_OBJS +=3D oss-fuzz/fuzz-date.o
 FUZZ_OBJS +=3D oss-fuzz/fuzz-pack-headers.o
@@ -762,7 +763,7 @@ fuzz-objs: $(FUZZ_OBJS)
 # Always build fuzz objects even if not testing, to prevent bit-rot.
 all:: $(FUZZ_OBJS)
=20
-FUZZ_PROGRAMS +=3D $(patsubst %.o,%,$(FUZZ_OBJS))
+FUZZ_PROGRAMS +=3D $(patsubst %.o,%,$(filter-out %dummy-cmd-main.o,$(FUZZ_=
OBJS)))
=20
 # Empty...
 EXTRA_PROGRAMS =3D
@@ -3850,16 +3851,17 @@ cover_db_html: cover_db
 #
 # make CC=3Dclang CXX=3Dclang++ \
 #      CFLAGS=3D"-fsanitize=3Dfuzzer-no-link,address" \
-#      LIB_FUZZING_ENGINE=3D"-fsanitize=3Dfuzzer" \
+#      LIB_FUZZING_ENGINE=3D"-fsanitize=3Dfuzzer,address" \
 #      fuzz-all
 #
-FUZZ_CXXFLAGS ?=3D $(CFLAGS)
+FUZZ_CXXFLAGS ?=3D $(ALL_CFLAGS)
=20
 .PHONY: fuzz-all
=20
-$(FUZZ_PROGRAMS): all
-	$(QUIET_LINK)$(CXX) $(FUZZ_CXXFLAGS) $(LIB_OBJS) $(BUILTIN_OBJS) \
-		$(XDIFF_OBJS) $(EXTLIBS) git.o $@.o $(LIB_FUZZING_ENGINE) -o $@
+$(FUZZ_PROGRAMS): %: %.o oss-fuzz/dummy-cmd-main.o $(GITLIBS) GIT-LDFLAGS
+	$(QUIET_LINK)$(CXX) $(FUZZ_CXXFLAGS) -o $@ $(ALL_LDFLAGS) \
+		-Wl,--allow-multiple-definition \
+		$(filter %.o,$^) $(filter %.a,$^) $(LIBS) $(LIB_FUZZING_ENGINE)
=20
 fuzz-all: $(FUZZ_PROGRAMS)
=20
diff --git a/oss-fuzz/dummy-cmd-main.c b/oss-fuzz/dummy-cmd-main.c
new file mode 100644
index 0000000000..071cb231ba
--- /dev/null
+++ b/oss-fuzz/dummy-cmd-main.c
@@ -0,0 +1,14 @@
+#include "git-compat-util.h"
+
+/*
+ * When linking the fuzzers, we link against common-main.o to pick up some
+ * symbols. However, even though we ignore common-main:main(), we still ne=
ed to
+ * provide all the symbols it references. In the fuzzers' case, we need to
+ * provide a dummy cmd_main() for the linker to be happy. It will never be
+ * executed.
+ */
+
+int cmd_main(int argc, const char **argv) {
+	BUG("We should not execute cmd_main() from a fuzz target");
+	return 1;
+}
--=20
2.43.0.429.g432eaa2c6b-goog


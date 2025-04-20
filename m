Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7AB1E47CC
	for <git@vger.kernel.org>; Sun, 20 Apr 2025 13:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745155180; cv=none; b=HX0uDLWPWGUVIorxl2kDsybPUY/it7Kkp+gR8pseHt4vZJ+EJZqzy8woOvSxvcA/BSWQgwym8UGjr0clw8aX+2DxOHH6sZRV2nOI9+35EtRgRpObEDBzL/kWCPICveJgCDQ+p7LZLCeWnnXQpgPSKY0AuAHh5fUwTFciopfiXI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745155180; c=relaxed/simple;
	bh=qQXXp2LzODnf0JqAZabzVLanPVHW78gP2JicVS+M0ug=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=Ze9vX6f6mTDiTz977c8csF+qRDVzpGTAsBGkYVBf32JcKftAWNNjV9p65+BWCUrXN0w1zcNFF9uMvdeiaO2xPsu9I9Dezr9hGCOj0rIrwJRDNSuV9D4ciTxL6TIY4nasRmURehBuzBBxNp1bAl6l57t++Ul/vdRBO7agZr2BPo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZDWxWJc; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZDWxWJc"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2c663a3daso578398166b.2
        for <git@vger.kernel.org>; Sun, 20 Apr 2025 06:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745155176; x=1745759976; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sv3595JPWUDXgBn7pE7p7CRgtnEi3ASBQrz3xhKyYA0=;
        b=XZDWxWJcNDzJm00muOuAh6A7xfckq+kuEiQHduxYzbdMBcv2w2sTPfHvQMggYzTwe8
         3/E0CBKsTS2qzXYiGY7KYUW+AD5EsPwQ+x7YbX8tpYyorP0YNE5GDhRnrkcNUcS/Dou8
         /haLDGhtfR4EipS8WvNZO9j6Pf6IRW/ipdUaK5680pgHZBgPrI23EZ2Uy6omssIWaJht
         JWPUMjQ+oaaIwH1BGctvaD7uO/1y0O6eIX9PtrjT66Ri8OP1u+hE+YYG0GmPKNHX3mF4
         qptnozOrYV2dKU0z4eWeCOyaatyjNcDOv16qyA2WAeGf7TLDVQetqyYrT10tK4zE91i2
         Tkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745155176; x=1745759976;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sv3595JPWUDXgBn7pE7p7CRgtnEi3ASBQrz3xhKyYA0=;
        b=pxiSQK6vn7UGs10FcyhclyDkY+CCirsbzPh6J+9a8qTidp+krlOh4d0+a8PugArgLG
         hrf1ItFTURpiwDS/KKocQcL6gqQuuPmi9TjNaVCAzCGFSv6visMe0FH6VMBoe49n10+5
         Cd+/TjgymabTBzgn4xbEXdZXSP4QsplhXDF1TPjMqLhPzVgmLEcZ340pF0H/JaNZNFED
         5d1fU6UfJfO3s56DrjUAj6dmXeAOFT1rGxQyODhNRpzXPdvV3L+uY9JECJhecWo0o0jk
         SucCUvqJK+oSVjiFzSFF9++9LlV+rRFHEhVIaeiCEo+tNJ6aAmKjnR5dniSl2FWoRIYt
         RjyA==
X-Gm-Message-State: AOJu0YzbsL143jZ3MhXhwU8/eWifdfRg9F/XXwkj/ryLXZbU0i7CgEnw
	fm4gnugiekipjFhyj3Ggv6dthrJTNGAVcGKO9PcEPsGZ2hYt0kWh
X-Gm-Gg: ASbGncviLA10CnQieGtGmqVEnF+iZMHjncecH4Z8A/ikkleMKuyDv5RLeWYKee8vZq9
	2c2YgZNDr5SZn498wi2Z2HMLJcR8h0tdweG7i0hnvo0M7HuJAEXXeIWwn8AR1hiL4XSStBHZKwV
	7W88aN8AMKL/CmUNI0pXzqqHg33ZOcP17IDV+LIUjcwnsdqT0a1ag/qZ9UuPlHhtgxEs30FM4xw
	dRUY51pGw5mZYKCzuc4dHFob2O7SMAsbdc2ZYmjxnjswLesjhJsgXrSzb4NdYgaUPCX/evKTBfg
	G/Sk2Qlkw0aar8P3oY8x2bxkpgYOWOTcQ3rnCnj2inbW7V4=
X-Google-Smtp-Source: AGHT+IGCptSdQTRb3fZ1o/COA+9sEQyrpX91vl4xvrRKlnXfX8tonml8JKRZagx6be2UgLyNKB1KfA==
X-Received: by 2002:a17:906:6a15:b0:ac7:391b:e68a with SMTP id a640c23a62f3a-acb74e8c945mr629992166b.60.1745155176146;
        Sun, 20 Apr 2025 06:19:36 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:7cb7:e0fd:4535:dd46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6eefc703sm397872566b.94.2025.04.20.06.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 06:19:35 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 0/5] meson: add corresponding target for Makefile's
 hdr-check
Date: Sun, 20 Apr 2025 14:21:32 +0200
Message-Id: <20250420-505-wire-up-sparse-via-meson-v4-0-66e14134e822@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMzmBGgC/4XOPQ7CMAyG4augzBglTtJWTNwDMYTUBUv0RwkEE
 OrdScsCDDC+Hp7PDxEpMEWxXjxEoMSR+y6HWS6EP7ruQMB1boESrdRagpUWrhwILgPEwYVIkNh
 BS7HvAEljXWuFstqLTAyBGr7N/HaX+8jx3If7vJbUdH3BRla/4aRAgipNWZD15HSzObSOTyvft
 2KCE75h6s+XCTPm/N5Y7yuHZL8x/Y6ZP5jOGNW+oLLBojQf2DiOT1Q/yBtiAQAA
X-Change-ID: 20250330-505-wire-up-sparse-via-meson-2e32dd31208b
In-Reply-To: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
References: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, toon@iotcl.com, 
 gitster@pobox.com, phillip.wood123@gmail.com, ps@pks.im
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7072; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=qQXXp2LzODnf0JqAZabzVLanPVHW78gP2JicVS+M0ug=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGgE9GbeFplwz2w7CkLDgWcTajSv0aG6zZ+tN
 5YFSpMhUTvbq4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoBPRmAAoJED7VnySO
 Rox/Iu0L/2S59qoN4A1RVzuqDCTotm5aWndEsvWFDPPNFYL0p+k130ywrRIiCdKI9CHsCKhr7tn
 w/ug2fWu4u7Kdu28AMFo5Z6ukDiFYnqxt/2kfoOf2blZpG/v2HY8JBuFon7Wu0vuDJGc7siu8Fs
 nfyI3p1j67Sadlnslyq4KRDx01QBCMl2HB3MdLxvT93YfFmsIX1V1sK7PZk4KvnJ9idlkBs5Nmi
 JutmStt5203KU6mRI6No5/VDAqf5SO391fIqlK6SUNN3ukCA3/z/AZqU2rY6EhliAifzzDtr5H/
 czSi3pQ0uXhSnEYDEksk9EP5g3ozmYSl0sgB39HL9AKVWrH2mP/rwFaSt+c9A0TcERBhY20ivg2
 Or8FtYPYfC9jOUpIF29ps3oy67wBRTe6a34j6nMFSJEbacPozpfdPsOlFFQOdFyz0MUDfXcoKWl
 /47BeHhGmIhKOIOvK0EPeAQ9V2leP0+w33Pma93k7jhrQ0c5RIXEJaVk61M8Zxgd8QSMyb4bK08
 bQ=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

To bridge the remaining gaps between Makefile and Meson, this patch
series adds 'hdr-check' to Meson to compliment the Makefile's
'hdr-check'.

We also introduce 'headers-check' as an alias to 'hdr-check' as a better
named replacement in both Meson and make and add a note to deprecate
'hdr-check' in the future.

The first two commits are small cleanups, where we re-organize existing
variables to make it easier to add the target. The third commit adds the
'hdr-check' target to Meson. The last commit introduces the
'headers-check' alias to both Meson and the makefile and marks
'hdr-check' to be deprecated.

This is based on master 9d22ac5122 (The third batch, 2025-04-07) with
'es/meson-build-skip-coccinelle' merged in.

---
Changes in v4:
- Rename headers to headers_to_check, since these headers are only used
  for static analysis.
- Added a commit to rename third_party_sources -> third_party_excludes
  and remove a duplicate.
- Fix a typo 'gcrpyt' -> 'gcrypt'
- Remove 'generated_headers', since we use 'git ls-files' and that would
  already ignore files within '.gitignore'.
- Link to v3: https://lore.kernel.org/r/20250414-505-wire-up-sparse-via-meson-v3-0-edc6e7f26745@gmail.com

Changes in v3:
- Some renames:
  - headers_generated -> generated_headers
  - meson -> Meson
  - headers-check -> check-headers
  - headers_check_exclude -> exclude_from_check_headers
- Rewrite 'headers_check_exclude' to also contain dirs so we can skip
  listing individual header files.
- Move 'xdiff/*' to 'third_party_sources' and cleanup
  'exclude_from_check_headers'.
- Use 'echo' instead of 'echo -n'.
- Use `fs.replace_suffix` instead of `str.replace`.
- Link to v2: https://lore.kernel.org/r/20250410-505-wire-up-sparse-via-meson-v2-0-acb45cc8a2e5@gmail.com

Changes in v2:
- Add 'hdr-check' to meson, while introducing 'headers-check' as
  a replacement alias. Schedule 'hdr-check' to be deprecated in the future.
- Link to v1: https://lore.kernel.org/r/20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com

---
 Makefile                       |  4 +-
 ci/run-static-analysis.sh      |  2 +-
 contrib/coccinelle/meson.build | 31 ++++-----------
 meson.build                    | 86 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 98 insertions(+), 25 deletions(-)

Karthik Nayak (5):
      coccinelle: meson: rename variables to be more specific
      meson: move headers definition from 'contrib/coccinelle'
      meson: rename 'third_party_sources' to 'third_party_excludes'
      meson: add support for 'hdr-check'
      makefile/meson: add 'check-headers' as alias for 'hdr-check'

Range-diff versus v3:

1:  bc69638da5 = 1:  337431cf0f coccinelle: meson: rename variables to be more specific
2:  de50343e66 ! 2:  2b5bde0cb0 meson: move headers definition from 'contrib/coccinelle'
    @@ contrib/coccinelle/meson.build: foreach source : run_command(git, '-C', meson.pr
      
      coccinelle_headers = []
     -foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_sources, check: true).stdout().split()
    -+foreach header : headers
    ++foreach header : headers_to_check
        coccinelle_headers += meson.project_source_root() / header
      endforeach
      
    @@ meson.build: builtin_sources = [
     +]
     +
     +if git.found()
    -+  headers = []
    ++  headers_to_check = []
     +  foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_sources, check: true).stdout().split()
    -+    headers += header
    ++    headers_to_check += header
     +  endforeach
     +endif
     +
-:  ---------- > 3:  2c5c9a9dc8 meson: rename 'third_party_sources' to 'third_party_excludes'
3:  fadfc7ef07 ! 4:  5b166c8bcd meson: add support for 'hdr-check'
    @@ Commit message
         the required dependencies.
     
         Also add the 'xdiff/' dir to the list of 'third_party_sources' as those
    -    headers must be skipped from the checks too!
    +    headers must be skipped from the checks too. This also skips the folder
    +    from the 'coccinelle' checks, this is okay, since this code is an
    +    external dependency.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## meson.build ##
    -@@ meson.build: third_party_sources = [
    -   ':!t/unit-tests/clar',
    +@@ meson.build: third_party_excludes = [
    +   ':!sha1dc',
        ':!t/unit-tests/clar',
        ':!t/t[0-9][0-9][0-9][0-9]*',
     +  ':!xdiff',
      ]
      
      if git.found()
    -@@ meson.build: if git.found()
    -   endforeach
    - endif
    - 
    -+generated_headers = [
    -+  'command-list.h',
    -+]
    -+
    - if not get_option('breaking_changes')
    -   builtin_sources += 'builtin/pack-redundant.c'
    - endif
    -@@ meson.build: builtin_sources += custom_target(
    -   ],
    -   env: script_environment,
    - )
    -+generated_headers += 'config-list.h'
    - 
    - builtin_sources += custom_target(
    -   input: 'Documentation/githooks.adoc',
    -@@ meson.build: builtin_sources += custom_target(
    -   ],
    -   env: script_environment,
    - )
    -+generated_headers += 'hook-list.h'
    - 
    - # This contains the variables for GIT-BUILD-OPTIONS, which we use to propagate
    - # build options to our tests.
     @@ meson.build: endif
      
      subdir('contrib')
      
    -+exclude_from_check_headers = generated_headers
    -+exclude_from_check_headers += [
    ++exclude_from_check_headers = [
     +  'compat/',
     +  'unicode-width.h',
     +]
    @@ meson.build: endif
     +if sha256_backend != 'nettle'
     +  exclude_from_check_headers += 'sha256/nettle.h'
     +endif
    -+if sha256_backend != 'gcrpyt'
    ++if sha256_backend != 'gcrypt'
     +  exclude_from_check_headers += 'sha256/gcrypt.h'
     +endif
     +
     +if git.found() and compiler.get_argument_syntax() == 'gcc'
     +  hco_targets = []
    -+  foreach h : headers
    ++  foreach h : headers_to_check
     +    skip_header = false
     +    foreach exclude : exclude_from_check_headers
     +      if h.startswith(exclude)
4:  66c5798df7 ! 5:  97e2e46dc1 makefile/meson: add 'check-headers' as alias for 'hdr-check'
    @@ meson.build: if git.found() and compiler.get_argument_syntax() == 'gcc'
          hco_targets += hco
        endforeach
      
    +-  alias_target('hdr-check', hco_targets)
     +  # TODO: deprecate 'hdr-check' in lieu of 'check-headers' in Git 2.51+
    -   alias_target('hdr-check', hco_targets)
    -+  alias_target('check-headers', hco_targets)
    ++  hdr_check = alias_target('hdr-check', hco_targets)
    ++  alias_target('check-headers', hdr_check)
      endif
      
      foreach key, value : {


base-commit: 3a956c5f69873611ae5f8dcb9acd117f66b95ddc
change-id: 20250330-505-wire-up-sparse-via-meson-2e32dd31208b

Thanks
- Karthik


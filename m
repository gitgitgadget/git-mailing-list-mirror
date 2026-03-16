Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBAE320A0E
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 07:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773647457; cv=none; b=ijZ9uozoHTF9WXDae16S9QBdU7X28r+oaREU8R+46Xab+hSrYyeIakaOFBSsWDYs38/ZetAL7wZ1WEKjSRf0A7Tw3TvVThhXu9fFVJUVb9U6bl62L5At97DNs7AAeUUvAyfntuYwh5SAIJZ8sFIBTGQc8tLfjsjxUOslTHShKJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773647457; c=relaxed/simple;
	bh=QWfrZj0hEXPxEwDXVJUH59TegiPtj3eUHYbRc+QjMSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ewvu1UPux0UxjnRXce5OeciyeJ+fB51HNFUj7nFdrMMDetbRWARTJIdNjJiLjE7UAdBZSE/81T+Le8aZfPx41OWpRF+fzS7f7OsUgAhk31Frxni2vVP04M2BFdTmQHfB4WJWzs4huXUCzGbryRRjUzfZvmYwKnIL6iTndkDUMu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Bfm2ITmQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=otVk/Hos; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Bfm2ITmQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="otVk/Hos"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4F3F71400233;
	Mon, 16 Mar 2026 03:50:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 16 Mar 2026 03:50:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1773647455; x=1773733855; bh=jpb3P+p8hO
	apUiV7QEqo2GcmK1eLmynODxjUqws2eVI=; b=Bfm2ITmQoFeYm6bGqUujmrZkpi
	W2UCxmvlgB+8jxhTNvbVannOqYeO1jS+hCp8mwM9VKX9m/O71v30OLR1FvVLZ/yk
	DlyB7PU9hCB+EG9bU5/Pboa3YgGeg1eKI6Be1hNKtBeNeLfC721614bMXefvfzCh
	RxCHPqmnlYO7Mg2mjheHAE2hNiEMtUsHVRRmLc5OQw/EHsEurnoQ/yMVlyhsu4U6
	Pxt5paQojzHdELxKi+no7bxdZs6U/u9k5s4aLvrp2nsPT00Y9WH37zTJAnHG7+Za
	vYo7BqPH3sapwnpZPE2wMAR7BOpTdKRG6ThTIK1JwPu5dS9eKhgOB5vSWwdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1773647455; x=1773733855; bh=jpb3P+p8hOapUiV7QEqo2GcmK1eL
	mynODxjUqws2eVI=; b=otVk/Hos9glxBDbjoo/xhjIOXRCReZAkh3oq/tM/KLvu
	HIw4HsTiG6nkpFyK9ABrnmqkIqu3I1vBKCny0BM2ufKf7yjf3Ozj78QrrIYNNoIO
	Vt6D3hnD6fYCsApJwKJGwk+KikygLAOymlVc5IH2XLR/MR4mlcd/+Te3HgityuDk
	wn5aO+ncE25EfhmFg6CtVe8tQGgpmIzBN9B6mo4A09JDGowcVFXWwi2onDfeuTQ7
	ws6ucnKRqFpWMtKFoSiKhb9JGxICguzGe44SyS8q09v2JctNOEqPIJ+rTJwVwfHu
	7UB+XPyOBGFiKZ+y5RIhvgR8khB3dQjcAvvFpjEDtg==
X-ME-Sender: <xms:X7a3aQSyopPsCnM461kjE14BuY_Y_o1vgk8lZbULfHWIDNv_8AVGlQ>
    <xme:X7a3aVNbt00RN-FoxtovAMCkRSGc_MOXnK46nv-cI-3kDbjee09pAaeLcEWD-PMrz
    Ymd5qG7snEA9gcza7WdKKPpu-LvGyoRv1vo_lZlQxSjT8ymATho>
X-ME-Received: <xmr:X7a3abN8IDKwyHphoHvr0yTGBLQUzCoBlwul4XFY0ucYDTnqi6kppyI4PEP74qSu_Z6U0dfG5AlrOP2GjX_0WdCzhY-cXG_tb42ICTTdt-I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleejkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    eigfeitdffffdvvdeuheehjeehheeludduhfehkeekgeeggfeuffehveegteejfeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehsrghmuhgvlhdrthhhihgsrghulhhtsegv
    nhhsqdhlhihonhdrohhrgh
X-ME-Proxy: <xmx:X7a3adttrJ-bUNy1KwVHc4DuGjhhdGP7G_nOvUgD-qwT-YONrO4FAA>
    <xmx:X7a3adUDY4F5KODRg7qCAbPtrwRgjqAOnbLjwOBlffXckpB-4QB_iw>
    <xmx:X7a3aduAh1Xt_VYkMxuLdPKs4ZnXmadXi1-0fqdQzcD4xt2slu1r3w>
    <xmx:X7a3aRWpLUpuctWmfaac9DrprNdhAL3iG1KgL4-5kcHMMiRqqdhzwg>
    <xmx:X7a3afZB1Oix-gC9Rnzk3dKZvEKPz3NHgr6_GTHVvSeITTiHftKWbFeT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 03:50:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f5c09b52 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Mar 2026 07:50:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 16 Mar 2026 08:50:43 +0100
Subject: [PATCH] clar: update to fix compilation on platforms without
 PATH_MAX
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-b4-pks-clar-without-path-max-v1-1-40b4bc91fdc0@pks.im>
X-B4-Tracking: v=1; b=H4sIAFK2t2kC/x3MQQqDMBAAwK/Inl1IUg2tXxEPq26bpVVDkqog/
 t3gcS5zQOQgHKEpDgi8SpRlztBlAYOj+cMoYzYYZax6aIt9hf4bcfhRwE2SW/4JPSWHE+1IRtl
 nrevxxQZy4QO/Zb/7tjvPC8ImT/JuAAAA
X-Change-ID: 20260316-b4-pks-clar-without-path-max-a2068515d9e2
To: git@vger.kernel.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

Update clar to e4172e3 (Merge pull request #134 from
clar-test/ethomson/const, 2026-01-10). Besides some changes to
"generate.py" which don't have any impact on us, this commit also fixes
compilation on platforms that don't have PATH_MAX, like for example
GNU/Hurd.

Reported-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

as discussed in the thread at [1]. Thanks!

Patrick

[1]: <20260312191901.174808-1-samuel.thibault@ens-lyon.org>
---
 t/unit-tests/clar/clar.h      |  4 ++-
 t/unit-tests/clar/generate.py | 79 +++++++++++++++++++++++++++++++++++--------
 2 files changed, 68 insertions(+), 15 deletions(-)

diff --git a/t/unit-tests/clar/clar.h b/t/unit-tests/clar/clar.h
index f7e4363022..9ea91d3d0e 100644
--- a/t/unit-tests/clar/clar.h
+++ b/t/unit-tests/clar/clar.h
@@ -15,8 +15,10 @@
 # define CLAR_MAX_PATH 4096
 #elif defined(_WIN32)
 # define CLAR_MAX_PATH MAX_PATH
-#else
+#elif defined(PATH_MAX)
 # define CLAR_MAX_PATH PATH_MAX
+#else
+# define CLAR_MAX_PATH 4096
 #endif
 
 #ifndef CLAR_SELFTEST
diff --git a/t/unit-tests/clar/generate.py b/t/unit-tests/clar/generate.py
index fd2f0ee83b..2357b2d6d2 100755
--- a/t/unit-tests/clar/generate.py
+++ b/t/unit-tests/clar/generate.py
@@ -8,7 +8,7 @@
 
 from __future__ import with_statement
 from string import Template
-import re, fnmatch, os, sys, codecs, pickle
+import re, fnmatch, os, sys, codecs, pickle, io
 
 class Module(object):
     class Template(object):
@@ -147,7 +147,7 @@ def __init__(self, path, output):
         self.path = path
         self.output = output
 
-    def should_generate(self, path):
+    def maybe_generate(self, path):
         if not os.path.isfile(path):
             return True
 
@@ -223,34 +223,85 @@ def callback_count(self):
         return sum(len(module.callbacks) for module in self.modules.values())
 
     def write(self):
-        output = os.path.join(self.output, 'clar.suite')
-        os.makedirs(self.output, exist_ok=True)
+        if not os.path.exists(self.output):
+            os.makedirs(self.output)
 
-        if not self.should_generate(output):
+        wrote_suite = self.write_suite()
+        wrote_header = self.write_header()
+
+        if wrote_suite or wrote_header:
+            self.save_cache()
+            return True
+
+        return False
+
+    def write_output(self, fn, data):
+        if not self.maybe_generate(fn):
+            return False
+
+        current = None
+
+        try:
+            with open(fn, 'r') as input:
+                current = input.read()
+        except OSError:
+            pass
+        except IOError:
+            pass
+
+        if current == data:
             return False
 
-        with open(output, 'w') as data:
+        with open(fn, 'w') as output:
+            output.write(data)
+
+        return True
+
+    def write_suite(self):
+        suite_fn = os.path.join(self.output, 'clar.suite')
+
+        with io.StringIO() as suite_file:
             modules = sorted(self.modules.values(), key=lambda module: module.name)
 
             for module in modules:
                 t = Module.DeclarationTemplate(module)
-                data.write(t.render())
+                suite_file.write(t.render())
 
             for module in modules:
                 t = Module.CallbacksTemplate(module)
-                data.write(t.render())
+                suite_file.write(t.render())
 
             suites = "static struct clar_suite _clar_suites[] = {" + ','.join(
                 Module.InfoTemplate(module).render() for module in modules
             ) + "\n};\n"
 
-            data.write(suites)
+            suite_file.write(suites)
 
-            data.write("static const size_t _clar_suite_count = %d;\n" % self.suite_count())
-            data.write("static const size_t _clar_callback_count = %d;\n" % self.callback_count())
+            suite_file.write(u"static const size_t _clar_suite_count = %d;\n" % self.suite_count())
+            suite_file.write(u"static const size_t _clar_callback_count = %d;\n" % self.callback_count())
 
-        self.save_cache()
-        return True
+            return self.write_output(suite_fn, suite_file.getvalue())
+
+        return False
+
+    def write_header(self):
+        header_fn = os.path.join(self.output, 'clar_suite.h')
+
+        with io.StringIO() as header_file:
+            header_file.write(u"#ifndef _____clar_suite_h_____\n")
+            header_file.write(u"#define _____clar_suite_h_____\n")
+
+            modules = sorted(self.modules.values(), key=lambda module: module.name)
+
+            for module in modules:
+                t = Module.DeclarationTemplate(module)
+                header_file.write(t.render())
+
+            header_file.write(u"#endif\n")
+
+            return self.write_output(header_fn, header_file.getvalue())
+
+        return False
 
 if __name__ == '__main__':
     from optparse import OptionParser
@@ -275,4 +326,4 @@ def write(self):
     suite.load(options.force)
     suite.disable(options.excluded)
     if suite.write():
-        print("Written `clar.suite` (%d tests in %d suites)" % (suite.callback_count(), suite.suite_count()))
+        print("Written `clar.suite`, `clar_suite.h` (%d tests in %d suites)" % (suite.callback_count(), suite.suite_count()))

---
base-commit: 67006b9db8b772423ad0706029286096307d2567
change-id: 20260316-b4-pks-clar-without-path-max-a2068515d9e2


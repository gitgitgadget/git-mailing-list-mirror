Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59E6299952
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 07:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961475; cv=none; b=Yjs6+ZA7H8B8GgIOrzJ035r3zfu2wiCBkJnVBsZCwRXiyPh9hH6avwfsOxdQtwE6tSa/A8YS7ZXjSDld4Tq8SI/3lXVJLAmdZVnFfF9n0PzUkgk8O9WLsqyACCWohOo9uHD6MM/56XkTi96DhKrBXxBkDjRwKRWdmAtZmMaH5Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961475; c=relaxed/simple;
	bh=pvdEgr2OMh9tSPD22gr1dFFGAjTVD2KyR1MAiISTp68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V9H4cTbJ39yV4tvhQFpskv/+zezLrYtrZslraDHWejAvaL+xEZFd4Hic+XX2oN6FH22gch7Qx04Tf23eexB1o9rXFBm7g+7sTvWTUbbImp1WuzdhiD3ADAv77NGngxwYwyLCB2ZlcKt3s9jyucA4Qeone6zr5nMmMlV9DOi8sqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=wXPegfy+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kjqUjHWJ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wXPegfy+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kjqUjHWJ"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 05ECBEC0B5A;
	Tue,  8 Jul 2025 03:57:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 08 Jul 2025 03:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751961473;
	 x=1752047873; bh=bY18c6Na0HcGj3JnbNTthyY1geHUvQDdMU4gy+XbLh4=; b=
	wXPegfy+L6VafekpEW3J6kmVU18xA9Cty2V0fvpf0WOHJ2uzwmR2cuENALYeHYCi
	dkQzNcEAfw8yNj2e0Ze9Gbo6G6yN44aYLL/pVsVh24AO/bgFvKUbOU8hSQbcM9AQ
	kp3D7DXqb/2HJkwQDZtQoxzu4RmlbFrM2KSXIfiZJom6gp19W64oOlOqggsksIAd
	JTp4l7Ly2hCw727XalxEj6i8cKYIi3Wf2GoZApxNCVJU6EUnZ6wNZcCEtSlMzcje
	V1ySS1KKb5DdEoQTkBhrXP7sW+0XV/5LUvGLlCKr37x3fUqdNuES/cPXi1/9SWzV
	GUAQ0AnEx01r4ojRW7+IoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751961473; x=
	1752047873; bh=bY18c6Na0HcGj3JnbNTthyY1geHUvQDdMU4gy+XbLh4=; b=k
	jqUjHWJdBhDjSRlrE+IBnBAGbHVrSTwn4WqixXYDcKu0p1EysKnx+A+ChpE6WxiO
	gRVEcJKn0Oq0lKqP1Hdo5GeNjjDNM5vpwIt0bXKyLlq/Non+cMuUC9I8adT1HYDJ
	msS3wZCnjY2AyvSzDJ+avZaTPHx3bBWQZhhyunH6WZgidCPavDFHeyirZaQtR0z2
	Ji+NBbmYae3LtzznQFBQ6AN7S8YtIhU1QmM20MY3CprRkhxQ4bJY/M0XsZ5uuTdL
	KAJCweICsZHO4JSAF0suZm6A+UHyeerUskqFKLx9zpJJ6dn48W4iZU1+f7QYHsQp
	r9E9xyZa4Z8OoQg/HQvRg==
X-ME-Sender: <xms:gM9saAfQjITCtEK0-NyUzxqV1fMnQLYu_vn43scFgFCcSl98gjPljw>
    <xme:gM9saC-sxDFNG92CWIn92PQRBnU7tEYjWbRBwqOR7SlRBwYC46Q6sGXEmw6r8XYKm
    tltOgnBZY_h01_2tg>
X-ME-Received: <xmr:gM9saNqo8-_BbHsIeFIVvTo5SZsL0A0FHyb1vpk0MudRhpIG7V3MJoJKq3yKDhfEFVQaXdImPoXLwLEts1n_O0ukA9KN3_tCY48uHFJzcXM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepihhrvggttggrrdhkuhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvthdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdr
    phhluhhsrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghs
    tghhfigrrhhtiiesghgvnhhtohhordhorhhg
X-ME-Proxy: <xmx:gM9saHA3c9cE_GAtKSFKYShMAuJGVmRIy_j8hADDzj84NW79YZuolQ>
    <xmx:gM9saPw-63mXhIzwK2iwLZgdlO2r29n1n02pacsWlpAHPD8W3we7gw>
    <xmx:gM9saE0VVMfoISC6F9J1I2tl3zUFHRK72P7y7DVsQZgjlO5sUOo-wA>
    <xmx:gM9saPytm2FDLoWPkTKjVLoHTmm-6yup6cNG6e1tx6HSo03nyP66yQ>
    <xmx:gM9saMd6MngTsBUiu-1OSQiOZ1lA50cm4Z6-bldzZILVZMf9YKnmuvGp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 03:57:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f0db05c9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 8 Jul 2025 07:57:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 08 Jul 2025 09:57:42 +0200
Subject: [PATCH v2 1/8] meson: stop discovering native version of Python
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-b4-pks-meson-cleanups-v2-1-94ac53cd4b95@pks.im>
References: <20250708-b4-pks-meson-cleanups-v2-0-94ac53cd4b95@pks.im>
In-Reply-To: <20250708-b4-pks-meson-cleanups-v2-0-94ac53cd4b95@pks.im>
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, irecca.kun@gmail.com, 
 Eli Schwartz <eschwartz@gentoo.org>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

When Python features are enabled we search both for a native and
non-native version of Python. This is wrong though: we don't use Python
in our build process, so there is no need to search for it in the first
place.

There is one location where we use the native version of Python, namely
when deciding whether or not we want to wire up git-p4(1). This check is
invalid though, as we shouldn't check for the build host to have Python,
but for the target host.

Fix this invalid check to use the non-native version of Python and stop
searching for a native version of Python altogether.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/meson.build b/meson.build
index 7fea4a34d68..21fdff0f496 100644
--- a/meson.build
+++ b/meson.build
@@ -866,9 +866,8 @@ if host_machine.system() == 'cygwin' or host_machine.system() == 'windows'
 endif
 build_options_config.set_quoted('X', executable_suffix)
 
-python = import('python').find_installation('python3', required: get_option('python'))
-target_python = find_program('python3', native: false, required: python.found())
-if python.found()
+target_python = find_program('python3', native: false, required: get_option('python'))
+if target_python.found()
   build_options_config.set('NO_PYTHON', '')
 else
   libgit_c_args += '-DNO_PYTHON'
@@ -1979,7 +1978,7 @@ if perl_features_enabled
   subdir('perl')
 endif
 
-if python.found()
+if target_python.found()
   scripts_python = [
     'git-p4.py'
   ]
@@ -2202,7 +2201,7 @@ summary({
   'iconv': iconv.found(),
   'pcre2': pcre2.found(),
   'perl': perl_features_enabled,
-  'python': python.found(),
+  'python': target_python.found(),
 }, section: 'Auto-detected features')
 
 summary({

-- 
2.50.0.195.g74e6fc65d0.dirty


Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AE219B3F6
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321550; cv=none; b=r/6nNV0fu3tuxL3uADUAyvUmFXjfV54Yt3eiusG4YQD9WZcWCXGhneHAWL+oCJqNDeJ4vzyB7l44m2ZXY9+z5T8gMpORUxJd6UnWZODXZ3DxkV8ZoQuEeWGapAanCF3esPVVHpNr5zSNQtoNDR7NS1W1NHDfjWxYGSdlZUYfIyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321550; c=relaxed/simple;
	bh=mfgoz1DosbtOHNxdBKnVVHOrjaR/lQ2u9iFOwaZPEus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pXrJt8matmICjniKYtJ+P4gpR4k+fND+cXX9LHi6i1GIswlbXsqEelj32DrZsgRjuXeA5eFuagWkJUGj+O6SOzeC69QUDSFqz9G0yKL7BQKCfbNrflaU5Tj80Jf2dOB45MtJDPoCrZC8ITJX1VFvaFR730HYXfoo8f8tziZ0tpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GNlsR7dq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g1m/vRY/; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GNlsR7dq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g1m/vRY/"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B4CA5114015D;
	Mon, 11 Nov 2024 05:39:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 11 Nov 2024 05:39:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731321547;
	 x=1731407947; bh=4C0HTFg88x5iUZnWU1EFaeYX2BVG8rRiNIGev6DpJf8=; b=
	GNlsR7dqT0oXzT9h542CfKe06RIrlsO+BZC0rzLXpA1tm/bAZFtajcLX+wd2t4Ip
	ErsXlO9cqBa2H7vVXcDo3n5Nj9m5GjGE1gWhqogmlyzcvS7JeiD//X99s+8sKOav
	DQrJaTBCiOne9ed7VEOvpZNwFmwtmEmocKnoP2q6lesO/wgFq3mvKmoW1hMPGOF2
	Khu6A9nKEn+7N0YwToRMyXY50GLQbI3V80eMnDsbtvjd/mG6SxaMwmgAziREoM6w
	kfWxzlden7Y9bQmMybI8CEFLlK/vzFFDO7y7ocln3Srdh54TdUBwPFtcUlQRlYp+
	yMEtZrbYyRZcurqb0zl6uQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731321547; x=
	1731407947; bh=4C0HTFg88x5iUZnWU1EFaeYX2BVG8rRiNIGev6DpJf8=; b=g
	1m/vRY/kzBKAVGaxJLRgOiEEgO5U5eBHgMDYCcjnbD2sBmxxo54cxl/FvEXhqFqa
	euEULzgKijoRCN4N68kngOPDnpRWD8k4i5TTVYA+Es/TMe7KN4CQ51b9Qgc0R7EY
	WL6Ojxc57OA+SJsxCLN/6gjfe7OiVlZIeK1iTr+vQQlAbtfKRyzAKgaQI1YF7vrx
	Vwr9hpEJae3eboJh8MNKZ2b9tywrUsEESAKJEszBXDvyQHZXhS3rPyzhNt3cF9gj
	ygd96jVXX+UopysODYIWjthZQm5csNgVD2rmBMQMjIVEQYlztgNyQAMtScIScZMt
	WFDxxjaoA1iJRnV6FbO/g==
X-ME-Sender: <xms:y94xZ4YWE7KEEIOZg14QB1fqHMLBW3NMyfjieNpSZCD_pdd1E6egTg>
    <xme:y94xZzYX2zcoNLC8ZZfnFro7qZoPSCLAh_R7Bpw_0gw9DrryUEBpRNlkmr0NhmYpF
    u1ZjpS8sKEtSeRiWw>
X-ME-Received: <xmr:y94xZy--S9BC_MUAnd9lfCmW5JQlGdCVJpNoRoHs5k8Ti-4hHh72uI40B8iSfWkPNdKMPXG5-BZ_yIXBu624mq0fzCwcYMi8HsmTTKNkPyoZXfU2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehrjhhushhtohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:y94xZyqgVRdVYvGJiucb-_3EM9WtTxqCfeahifs5aPL4JANpBgYuRw>
    <xmx:y94xZzqyVixI_yw7WTkf0julE8Yq28V6EfgiD4vjfyy2SC7qzGm7PQ>
    <xmx:y94xZwSbaN8lIA2SViarW8582zT-i66sRKyUy4xasuo0VptMQNQ5BA>
    <xmx:y94xZzoqHe2euVTkF50gbfXFKwuxcDaEynpR1_mmDWQ5j3Br1MKRog>
    <xmx:y94xZ60MDBX-uCabbitfsLzns-gWqfBa8heky0JcJ6tRR0wVWc8crDj_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 05:39:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d565888c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 10:38:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 Nov 2024 11:38:52 +0100
Subject: [PATCH v2 23/27] t5601: work around leak sanitizer issue
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-b4-pks-leak-fixes-pt10-v2-23-6154bf91f0b0@pks.im>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
In-Reply-To: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
X-Mailer: b4 0.14.2

When running t5601 with the leak checker enabled we can see a hang in
our CI systems. This hang seems to be system-specific, as I cannot
reproduce it on my own machine.

As it turns out, the issue is in those testcases that exercise cloning
of `~repo`-style paths. All of the testcases that hang eventually end up
interpreting "repo" as the username and will call getpwnam(3p) with that
username. That should of course be fine, and getpwnam(3p) should just
return an error. But instead, the leak sanitizer seems to be recursing
while handling a call to `free()` in the NSS modules:

    #0  0x00007ffff7fd98d5 in _dl_update_slotinfo (req_modid=1, new_gen=2) at ../elf/dl-tls.c:720
    #1  0x00007ffff7fd9ac4 in update_get_addr (ti=0x7ffff7a91d80, gen=<optimized out>) at ../elf/dl-tls.c:916
    #2  0x00007ffff7fdc85c in __tls_get_addr () at ../sysdeps/x86_64/tls_get_addr.S:55
    #3  0x00007ffff7a27e04 in __lsan::GetAllocatorCache () at ../../../../src/libsanitizer/lsan/lsan_linux.cpp:27
    #4  0x00007ffff7a2b33a in __lsan::Deallocate (p=0x0) at ../../../../src/libsanitizer/lsan/lsan_allocator.cpp:127
    #5  __lsan::lsan_free (p=0x0) at ../../../../src/libsanitizer/lsan/lsan_allocator.cpp:220
    ...
    #261505 0x00007ffff7fd99f2 in free (ptr=<optimized out>) at ../include/rtld-malloc.h:50
    #261506 _dl_update_slotinfo (req_modid=1, new_gen=2) at ../elf/dl-tls.c:822
    #261507 0x00007ffff7fd9ac4 in update_get_addr (ti=0x7ffff7a91d80, gen=<optimized out>) at ../elf/dl-tls.c:916
    #261508 0x00007ffff7fdc85c in __tls_get_addr () at ../sysdeps/x86_64/tls_get_addr.S:55
    #261509 0x00007ffff7a27e04 in __lsan::GetAllocatorCache () at ../../../../src/libsanitizer/lsan/lsan_linux.cpp:27
    #261510 0x00007ffff7a2b33a in __lsan::Deallocate (p=0x5020000001e0) at ../../../../src/libsanitizer/lsan/lsan_allocator.cpp:127
    #261511 __lsan::lsan_free (p=0x5020000001e0) at ../../../../src/libsanitizer/lsan/lsan_allocator.cpp:220
    #261512 0x00007ffff793da25 in module_load (module=0x515000000280) at ./nss/nss_module.c:188
    #261513 0x00007ffff793dee5 in __nss_module_load (module=0x515000000280) at ./nss/nss_module.c:302
    #261514 __nss_module_get_function (module=0x515000000280, name=name@entry=0x7ffff79b9128 "getpwnam_r") at ./nss/nss_module.c:328
    #261515 0x00007ffff793e741 in __GI___nss_lookup_function (fct_name=<optimized out>, ni=<optimized out>) at ./nss/nsswitch.c:137
    #261516 __GI___nss_next2 (ni=ni@entry=0x7fffffffa458, fct_name=fct_name@entry=0x7ffff79b9128 "getpwnam_r", fct2_name=fct2_name@entry=0x0, fctp=fctp@entry=0x7fffffffa460,
        status=status@entry=0, all_values=all_values@entry=0) at ./nss/nsswitch.c:120
    #261517 0x00007ffff794c6a7 in __getpwnam_r (name=name@entry=0x501000000060 "repo", resbuf=resbuf@entry=0x7ffff79fb320 <resbuf>, buffer=<optimized out>,
        buflen=buflen@entry=1024, result=result@entry=0x7fffffffa4b0) at ../nss/getXXbyYY_r.c:343
    #261518 0x00007ffff794c4d8 in getpwnam (name=0x501000000060 "repo") at ../nss/getXXbyYY.c:140
    #261519 0x00005555557e37ff in getpw_str (username=0x5020000001a1 "repo", len=4) at path.c:613
    #261520 0x00005555557e3937 in interpolate_path (path=0x5020000001a0 "~repo", real_home=0) at path.c:654
    #261521 0x00005555557e3aea in enter_repo (path=0x501000000040 "~repo", strict=0) at path.c:718
    #261522 0x000055555568f0ba in cmd_upload_pack (argc=1, argv=0x502000000100, prefix=0x0, repo=0x0) at builtin/upload-pack.c:57
    #261523 0x0000555555575ba8 in run_builtin (p=0x555555a20c98 <commands+3192>, argc=2, argv=0x502000000100, repo=0x555555a53b20 <the_repo>) at git.c:481
    #261524 0x0000555555576067 in handle_builtin (args=0x7fffffffaab0) at git.c:742
    #261525 0x000055555557678d in cmd_main (argc=2, argv=0x7fffffffac58) at git.c:912
    #261526 0x00005555556963cd in main (argc=2, argv=0x7fffffffac58) at common-main.c:64

Note that this stack is more than 260000 function calls deep. Run under
the debugger this will eventually segfault, but in our CI systems it
seems like this just hangs forever.

I assume that this is a bug either in the leak sanitizer or in glibc, as
I cannot reproduce it on my machine. In any case, let's work around the
bug for now by marking those tests with the "!SANITIZE_LEAK" prereq.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5601-clone.sh | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 9fe665eadfb685f2cc9937a1dd5ec005a0d50fb7..d0c18660e33113e64a293c695239a1c1a7975add 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -544,12 +544,16 @@ do
 		test_clone_url [::1]:$repo ::1 "$repo"
 	'
 done
-#home directory
-test_expect_success "clone host:/~repo" '
+
+# Home directory. All tests that use "~repo" are broken in our CI job when the
+# leak sanitizer is enabled. It seems like either a bug in the sanitizer or in
+# glibc, but when executing getpwnam(3p) with an invalid username we eventually
+# start recursing in a call to free(3p), until bust the stack and segfault.
+test_expect_success !SANITIZE_LEAK "clone host:/~repo" '
 	test_clone_url host:/~repo host "~repo"
 '
 
-test_expect_$expectation_for_ipv6_tests "clone [::1]:/~repo" '
+test_expect_$expectation_for_ipv6_tests !SANITIZE_LEAK "clone [::1]:/~repo" '
 	test_clone_url [::1]:/~repo ::1 "~repo"
 '
 
@@ -569,9 +573,9 @@ do
 		test_clone_url "ssh://host.xz$tcol/home/user/repo" host.xz /home/user/repo
 	'
 	# from home directory
-	test_expect_success "clone ssh://host.xz$tcol/~repo" '
-	test_clone_url "ssh://host.xz$tcol/~repo" host.xz "~repo"
-'
+	test_expect_success !SANITIZE_LEAK "clone ssh://host.xz$tcol/~repo" '
+		test_clone_url "ssh://host.xz$tcol/~repo" host.xz "~repo"
+	'
 done
 
 # with port number
@@ -580,7 +584,7 @@ test_expect_success 'clone ssh://host.xz:22/home/user/repo' '
 '
 
 # from home directory with port number
-test_expect_success 'clone ssh://host.xz:22/~repo' '
+test_expect_success !SANITIZE_LEAK 'clone ssh://host.xz:22/~repo' '
 	test_clone_url "ssh://host.xz:22/~repo" "-p 22 host.xz" "~repo"
 '
 
@@ -597,8 +601,8 @@ done
 for tuah in ::1 [::1] user@::1 user@[::1] [user@::1]
 do
 	euah=$(echo $tuah | tr -d "[]")
-	test_expect_success "clone ssh://$tuah/~repo" "
-	  test_clone_url ssh://$tuah/~repo $euah '~repo'
+	test_expect_success !SANITIZE_LEAK "clone ssh://$tuah/~repo" "
+		test_clone_url ssh://$tuah/~repo $euah '~repo'
 	"
 done
 
@@ -615,8 +619,8 @@ done
 for tuah in [::1] user@[::1] [user@::1]
 do
 	euah=$(echo $tuah | tr -d "[]")
-	test_expect_success "clone ssh://$tuah:22/~repo" "
-	  test_clone_url ssh://$tuah:22/~repo '-p 22' $euah '~repo'
+	test_expect_success !SANITIZE_LEAK "clone ssh://$tuah:22/~repo" "
+		  test_clone_url ssh://$tuah:22/~repo '-p 22' $euah '~repo'
 	"
 done
 

-- 
2.47.0.229.g8f8d6eee53.dirty


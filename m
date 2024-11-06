Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AA3204F95
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 15:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905895; cv=none; b=Q36B9Cmacf+iQmTCbMUqKul/HPKDzqLvR0FBzcV77GFauG3mWhikU57v/VPBPl7fNiHachgKzNX50z2GF295Oq4YMECBn1RzhDowKI3Z1QuKXHolE3wDr2CuG/MTwDHn5u8ZuKA7YcEXNIwDrFAmcAEK9jRIMIyvyrXtp6QO0lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905895; c=relaxed/simple;
	bh=H6LmaHEn5l4pdh5WywsPZpYC7pG4lr0QVKNV3Ckt90M=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpyeCNAb8l5NF+sKP4RiAU6BV11zuM/c6e8wvA0mp1cF60GVeB0yyIqNdoPRC9sLkRZvRgaaTSUtDkQu9V25DEK4wqCTDZM/ly4i+TryMkZQi7BFTRBETdpVnggU60+EFW69D3SEJCyCSyxb3pZl6dPCaWGvKG/Vf8JBliBaJnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DbzDhj6Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Iw9qkyDJ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DbzDhj6Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Iw9qkyDJ"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 449D513801AE
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 10:11:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 06 Nov 2024 10:11:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730905893; x=1730992293; bh=Ea1ibsqAo5
	8Dv0LlWVtXdIO2PfDFJo6f/FkmyuKFZA4=; b=DbzDhj6YcULj040x9X7pRqyyt8
	nhVJOlMX+RqigTBWn3Q6O7ScmWeh3lxbZZrXMKgjRA+RXNIVrMDuNJ7tMdgtva2O
	MfQQVZwlerUIabvSHuuIRQL7LJJkruQTbL8KrJ2sRtV0opHF6jznE0Y8VdNqZQlb
	rMpOoEHRsbd2QfjBfHaK681sIK6g1vZlUOjtj7ZLnCaDXhzQrI9NwMQe+5sPuA0T
	Cw38S36syxLVRWyiNFzuA2pTCV7xmtr3TStPl1BuwhTX9eQ/1X1kO7vIvRB+4fcI
	m9h0aC4KSam/4VwN+UFUhunMS7SIghEscvq+s5f8ZMe5X4Z+dE5F/ONJ+wow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730905893; x=1730992293; bh=Ea1ibsqAo58Dv0LlWVtXdIO2PfDFJo6f/Fk
	myuKFZA4=; b=Iw9qkyDJCAOEOAOy+HV0190m15q/RChv8D8hYYxRPsbP4LmcRfw
	48R4tVgSb2rVSiLgApTDI9tyQfkUyVDAm/KdmhudysyDTqAqAqzjGtZiSk7sDQyY
	YEUR64EQypzlcd2UNyyuF5qvFcv0JwQtXXvqAHBF2Ns1n61EL6FX4zDEzq35Mpqh
	A4k5JRtidQEgk+pVwFygQ+E/MSwXQ0nXWa4xothl4KI/H2YZ9jQLXsZ9N9cd4+cN
	+iMF7No9gMtBPUU3bDbMTipK7aVJ3mM3O7gVbsEbL6RGfv5qEFx7l83PLeW6Z4hH
	W73Q1kyXAkVSBt6JmNCQuqpZtbC8/uDmBGw==
X-ME-Sender: <xms:JYcrZwctoJxS2dL6C4n8YoHuRWCiEVyUp3Vt72IRmFD72SrHw8C1LA>
    <xme:JYcrZyOSEXWkDlA7PR8RINwkuWbrEozeZk4IbC4qOdmJxRup8uxeoLgxso77ScdkV
    v1da8A-kEwr5FAbJA>
X-ME-Received: <xmr:JYcrZxgDa6uP_FM6Eh7v4g9RVI72Tp9Od002WSSPelW84xlfAqh5ySy76fA3Ok-LaUM0iSsvuAsIi54Jlx5CqhLG_0bLQClDE1wPmry5i0uSdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukf
    hfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeeggedvge
    dvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghrufhi
    iigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:JYcrZ19NWxDcAhOLL1ojRIL5Dqb0zmp-y0OFbxTnJaKBx-ccTj9pNA>
    <xmx:JYcrZ8sPO_C-NqSlPejRw2ffCV3jMGHWPv951917iw43C_kZK7e9bQ>
    <xmx:JYcrZ8G3YHPV8cfINnaAEyURtwPkIzE89nEng3M7XyFQNSx7uFBQpA>
    <xmx:JYcrZ7M0zzvB4uFSVwJ0Tc0boi8hfiHLtsDJTUMbXJXOpvfwjnkwOw>
    <xmx:JYcrZ5UF5Rs7WJqo4JlXSwlfoo7tKh3fAX3qiBERV-EIK7bR-35nDoPx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Nov 2024 10:11:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ab45bf83 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Nov 2024 15:11:08 +0000 (UTC)
Date: Wed, 6 Nov 2024 16:11:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 22/26] t5601: work around leak sanitizer issue
Message-ID: <c3f74fcf9c9ed0af9d44ef1e368d6964e7180afe.1730901926.git.ps@pks.im>
References: <cover.1730901926.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730901926.git.ps@pks.im>

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
index 9fe665eadfb..d0c18660e33 100755
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


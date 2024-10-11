Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05693209F26
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 05:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624797; cv=none; b=YHh4VqJtqyFrhiegCoGZGkUCCnH6vgVmWiBKttDkxT2OE5bkNcJ5ORhbdl+EonvfBHK7sun/ZB2m6CNZ6awVM1H4HiJezYyMZwCvU5NnPU3FFrDvOo0BDtr0EmXeFF0WdJYBdlmunQBsJt2jYEZXOZw4RHRTFVzJfr2buL2WvCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624797; c=relaxed/simple;
	bh=OEvDcfACMWNiYTfHzZsPsUPELbf3qHVq/aCU7QHSMvA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHE4P+fh1faB65UblHTf9i67hWu266qn0U9zUDbfL6xB3XpzywYYuoOM919zMPUcPlK4WZUFr61RiL2tZ0C8wLvK9QyE9WSOmuPjpUOS8UWcJbsKoHs8NQbPzJejopsMWqglCtqQ8BnuVuS6k4fdxbGL4BtQQ9T3Ad6q1eFIa4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZPtn1Z9Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NCI9nIZp; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZPtn1Z9Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NCI9nIZp"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 625F511400C4
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 01:33:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 11 Oct 2024 01:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728624795; x=1728711195; bh=bU96al8XAz
	r05kZnrtryHWvk8Wuwnp04MUcAVh0RnUQ=; b=ZPtn1Z9ZrTfLnmml183/NVSnCT
	28KmCsERv/fmA5OmWfeqU3UXwXJcGAsAapUXJfcVMgYlnoeHpDf24w8pMJVYREH8
	EurTgTqr8KQRcpJPvbJ31MWCdf5LObnYcvav9nZfDlJOHMk0vZAiTdG4mZYGUSU5
	eBGRyGesCeaZeApK+7lPsP0MgP117xOP17Nxxw06kY47gnYA4lfm3k5xv3h6jdOE
	dJJZ3JROAG0DrFwvERpWtlIKLyYw9yjC/tzJWoH38Z3cikRjbhhlbdo3/YrCV8Ah
	HbWaMov2BIRASuQadAV+nP7/IMxsVV+0mB18l/zVLZmoyaye2Rh5AhAH/c/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728624795; x=1728711195; bh=bU96al8XAzr05kZnrtryHWvk8Wuw
	np04MUcAVh0RnUQ=; b=NCI9nIZpiSfUdQ/fH31HoTn18QgE3pkqHKCeKBL3leFG
	MO/fVsYP/AP3gIkg1yP/haU9XQt3Htf4NtMc/0GNI7SlTPJ/hHD+zVWLh8an+Qh0
	Wo/wkt0Tg5MAKkbUblsSSfH+R8+i+diljvbtpXan1qTlTFNgxJHeHCvuNyTY6T10
	2R5TixPQh0elKfg5sMEEr71qSPr0YD8R0/TXgQHVcpF+Z+2wxNioRy3DnM78cuhO
	JKt6ufAV2VmOLN7+j8pD/i+e+pTtN8uAjFQ9LIdgH8+9US0RsdTlujtwt2UjyD3i
	SrRhVVubColp1RxOeJHWCc3QgODfTDnQqDCN4tFDiA==
X-ME-Sender: <xms:m7gIZzSdRj22hjE-Tn5QAr_uxf4NUc92a7yq7POVAc5WOa9oGMzb6w>
    <xme:m7gIZ0zDM9SvXn3LTL3UzTVAXWPodRaudHHFkL_O6jGypiIXIjUPvLkQq0zzDk5sK
    jlf7JCVYoa1-v5MuQ>
X-ME-Received: <xmr:m7gIZ43H8MQP4oagf_03Iv10mlWfjhtFTrkr2wc8Xlx5_22w1PzTsGLbakGcmhxQPueWJ0davHUDrGH0JU_CxSLDKGJEyByJNj4Y6b-bx7OJXxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:m7gIZzARra67ooSg7P67lkbX7_O9tnl8_eYc7zxAVIpQykKZkU4ODA>
    <xmx:m7gIZ8g1pZHhTBPVlC9Xgk6TuWU7BG2X3UvnsybHAr3-oJAooi81pQ>
    <xmx:m7gIZ3oy8PbNXuVjouF_XrePAT0-Vm7LwgQe7LMzpRkrHRjmxPs1hA>
    <xmx:m7gIZ3irtLjbklXN0gsyhHaAWlHdl5fGMPgp6yGRemSqybAX67o8yg>
    <xmx:m7gIZ4YSQ2nCALTJHHo5qnsWUiFamF73XiTx5hxqPl2IhHfdgnoZiDz6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 11 Oct 2024 01:33:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e839673e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 11 Oct 2024 05:32:08 +0000 (UTC)
Date: Fri, 11 Oct 2024 07:33:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 21/21] list-objects-filter-options: work around reported leak
 on error
Message-ID: <6a2baf0d3e538e5f450c45c22248fbc3fefd77af.1728624670.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728624670.git.ps@pks.im>

This one is a little bit more curious. In t6112, we have a test that
exercises the `git rev-list --filter` option with invalid filters. We
execute git-rev-list(1) via `test_must_fail`, which means that we check
for leaks even though Git exits with an error code. This causes the
following leak:

    Direct leak of 27 byte(s) in 1 object(s) allocated from:
        #0 0x5555555e6946 in realloc.part.0 lsan_interceptors.cpp.o
        #1 0x5555558fb4b6 in xrealloc wrapper.c:137:8
        #2 0x5555558b6e06 in strbuf_grow strbuf.c:112:2
        #3 0x5555558b7550 in strbuf_add strbuf.c:311:2
        #4 0x5555557c1a88 in strbuf_addstr strbuf.h:310:2
        #5 0x5555557c1d4c in parse_list_objects_filter list-objects-filter-options.c:261:3
        #6 0x555555885ead in handle_revision_pseudo_opt revision.c:2899:3
        #7 0x555555884e20 in setup_revisions revision.c:3014:11
        #8 0x5555556c4b42 in cmd_rev_list builtin/rev-list.c:588:9
        #9 0x5555555ec5e3 in run_builtin git.c:483:11
        #10 0x5555555eb1e4 in handle_builtin git.c:749:13
        #11 0x5555555ec001 in run_argv git.c:819:4
        #12 0x5555555eaf94 in cmd_main git.c:954:19
        #13 0x5555556fd569 in main common-main.c:64:11
        #14 0x7ffff7ca714d in __libc_start_call_main (.../lib/libc.so.6+0x2a14d)
        #15 0x7ffff7ca7208 in __libc_start_main@GLIBC_2.2.5 (.../libc.so.6+0x2a208)
        #16 0x5555555ad064 in _start (git+0x59064)

This leak is valid, as we call `die()` and do not clean up the memory at
all. But what's curious is that this is the only leak reported, because
we don't clean up any other allocated memory, either, and I have no idea
why the leak sanitizer treats this buffer specially.

In any case, we can work around the leak by shuffling things around a
bit. Instead of calling `gently_parse_list_objects_filter()` and dying
after we have modified the filter spec, we simply do so beforehand. Like
this we don't allocate the buffer in the error case, which makes the
reported leak go away.

It's not pretty, but it manages to make t6112 leak free.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 list-objects-filter-options.c       | 17 +++++++----------
 t/t6112-rev-list-filters-objects.sh |  1 +
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 00611107d20..fa72e81e4ad 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -252,16 +252,14 @@ void parse_list_objects_filter(
 	const char *arg)
 {
 	struct strbuf errbuf = STRBUF_INIT;
-	int parse_error;
 
 	if (!filter_options->filter_spec.buf)
 		BUG("filter_options not properly initialized");
 
 	if (!filter_options->choice) {
+		if (gently_parse_list_objects_filter(filter_options, arg, &errbuf))
+			die("%s", errbuf.buf);
 		strbuf_addstr(&filter_options->filter_spec, arg);
-
-		parse_error = gently_parse_list_objects_filter(
-			filter_options, arg, &errbuf);
 	} else {
 		struct list_objects_filter_options *sub;
 
@@ -271,18 +269,17 @@ void parse_list_objects_filter(
 		 */
 		transform_to_combine_type(filter_options);
 
-		strbuf_addch(&filter_options->filter_spec, '+');
-		filter_spec_append_urlencode(filter_options, arg);
 		ALLOC_GROW_BY(filter_options->sub, filter_options->sub_nr, 1,
 			      filter_options->sub_alloc);
 		sub = &filter_options->sub[filter_options->sub_nr - 1];
 
 		list_objects_filter_init(sub);
-		parse_error = gently_parse_list_objects_filter(sub, arg,
-							       &errbuf);
+		if (gently_parse_list_objects_filter(sub, arg, &errbuf))
+			die("%s", errbuf.buf);
+
+		strbuf_addch(&filter_options->filter_spec, '+');
+		filter_spec_append_urlencode(filter_options, arg);
 	}
-	if (parse_error)
-		die("%s", errbuf.buf);
 }
 
 int opt_parse_list_objects_filter(const struct option *opt,
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index 0387f35a326..71e38491fa8 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -5,6 +5,7 @@ test_description='git rev-list using object filtering'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Test the blob:none filter.
-- 
2.47.0.dirty


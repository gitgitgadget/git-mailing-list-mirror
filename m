Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26F9275AF5
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278194; cv=none; b=US9M2n+08vsoSj3C+SVQug7K22OKVwGVlhWAGOnriUOEyik6C/jAGVx7yyoERdMi44oBDLsxqz4ovdH9ZNGegpoHUgwcJb2xth0uual7VUibuedLM9F5OCQz+D1oQpKE0CniLbhrXGXWM0aOMb0NT0M1NtCMSnLbEly5s/ykUco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278194; c=relaxed/simple;
	bh=9bz+9cu7vKAejhn1Mys1cfjKDSNHMjF0SiJMYsufnwI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KcBuwdOPijnZyWI2SG9M0NpUb3siWEGzM7Egyt/nLFALPkDkAVl3JJHpCCBgIh/BRd3NxB63oKrMLHvZFF8LSVIGTyDK+73OD7WRNrebsflwO9hvcO/48KuSlwdxVNbkjNjMeibzxkMN4HtLlMwlfrZTvR3woGICWsumIwXrQdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BkG1dfLg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sWaIx4rS; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BkG1dfLg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sWaIx4rS"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6567C7A009F;
	Mon, 23 Mar 2026 11:03:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 23 Mar 2026 11:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774278192;
	 x=1774364592; bh=5A/dNcRoiE5PEO6/aNE0jZR20DmWUPvj+YoK2LpUUhU=; b=
	BkG1dfLgAHuyTI6PKycmhaqy2FUy5bYGZMPAQAA8IwSrWsDcsZ9bgyguSQd/cOO8
	NnX4Me+fJKkkXWi8LhUYHBvR+/DDHAjuZlvzS8LzL3U7BtmuB6RPJ7I7y/fLXGIv
	4PxKYrsaEayb3Cobe1xn2puuDUjzLmynUKEzzsZ5g/R8YuXapa7UXc3mS8duumIH
	xdbr2UyvkzZchra6Sk4S6/IOvcgWJC5c06cyEiwZMd6zyYbEpMgIEwlJ8dlmkFF4
	P/Q19lPpK3qUAn1fmntPYKmHBKpHeowtUh9uQqQBHQTBK7tIaESczESaFnvxMv8R
	ig85KP4i5nV8879O+6PgiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774278192; x=
	1774364592; bh=5A/dNcRoiE5PEO6/aNE0jZR20DmWUPvj+YoK2LpUUhU=; b=s
	WaIx4rSj8Q+bxgmcqCKwR+6xQXAFs5Ihn9s4vY8Ez+CZBLjB+xNkrU9MlwWShX0P
	U0EexGZ6llb2OA0BiR+IJMQ3ywltorDWl3ldai1tWi8UxELZ+Qy08Ncw0OtCBEHt
	J+SHOiqgdhxrbcIyL+a8dGINp0WMC+1uqKYgzlb+12MIz5LpoXRgaGcwb6sf1AOu
	i9Y/1u5P0w462wpKif/O/kJ+jQ0SoRCb16jLlr3opxv7Ktvy584OzCClPq391/Yl
	CNJAlZvBVLR+UMhEfqGHXOXScobbURSIipwtzDlqn1N2XO97NQspWTiXMArfrbvr
	bc9bqLI0u33r+lMShTEbA==
X-ME-Sender: <xms:MFbBaSvPb5h5fV-2Iemg_jiAGUpfAF4wjP6qDACFb5GvZ6ACRIX1Dg>
    <xme:MFbBadd283lN578tv-eUwV_wjVJpK0edxmkO0Bxv9o5htDRUDlKs0em7bHMSYCkSG
    lpI_B3SWtjlfoOcVurZiRYmK4E9Opt76VA7HuSay2-y2cbxAXAlSA>
X-ME-Received: <xmr:MFbBaba5691uRO0KF4p9LUmZoNl8y8ivIlxPjGyC0Q4BJSon_y-6Z4pr8aXjRrNkauoOFqCTKC4_15hft-zVI4fAB8EX9YqGsaub0ZPeFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeltddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:MFbBaYXf2XXngQbgQTV4_2XcSXUuWvkTOgcSd9XHaqSA5aOEBeIeeg>
    <xmx:MFbBaVgn-Drm0jH18rJiE4hu1sHwGzy-l9Wi-8Cx_UkX0tqQiT6ieA>
    <xmx:MFbBaeW7uUGv6SKb9BMO_LVGg3x7urFI0lYKORz_ZKwMqFkEPncfhw>
    <xmx:MFbBaUNxlYOTRuIJvDX4Jz_VTRvxYTQVtjkNI_3-S_Tj3cY3WyU7Cw>
    <xmx:MFbBaeHOqusL1Wxzn6Z43EbuHI78FXmlyC_iEVRqy3bmrXyYBWd5uZqx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 11:03:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 856b4b18 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Mar 2026 15:03:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Mar 2026 16:02:52 +0100
Subject: [PATCH v2 01/12] fetch-pack: move fsck options into function scope
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-b4-pks-fsck-without-the-repository-v2-1-e8dc79bca651@pks.im>
References: <20260323-b4-pks-fsck-without-the-repository-v2-0-e8dc79bca651@pks.im>
In-Reply-To: <20260323-b4-pks-fsck-without-the-repository-v2-0-e8dc79bca651@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

When fetching a packfile, we optionally verify received objects via the
fsck subsystem. The options for those consistency checks are declared in
global scope without a good reason, and they are never cleaned up. So in
case the options are reused, they may accumulate more state over time.

Furthermore, in subsequent changes we'll introduce a repository pointer
into the structure. Obviously though, we don't have a repository
available at static time, except for `the_repository`, which we don't
want to use here.

Refactor the code to move the options into the respective functions and
properly manage their lifecycle.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 fetch-pack.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 6ecd468ef7..ec5abb92b5 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -51,7 +51,6 @@ static int server_supports_filtering;
 static int advertise_sid;
 static struct shallow_lock shallow_lock;
 static const char *alternate_shallow_file;
-static struct fsck_options fsck_options = FSCK_OPTIONS_MISSING_GITMODULES;
 static struct strbuf fsck_msg_types = STRBUF_INIT;
 static struct string_list uri_protocols = STRING_LIST_INIT_DUP;
 
@@ -1100,6 +1099,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 				 struct shallow_info *si,
 				 struct string_list *pack_lockfiles)
 {
+	struct fsck_options fsck_options = FSCK_OPTIONS_MISSING_GITMODULES;
 	struct repository *r = the_repository;
 	struct ref *ref = copy_ref_list(orig_ref);
 	struct object_id oid;
@@ -1235,6 +1235,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 		die("fsck failed");
 
  all_done:
+	fsck_options_clear(&fsck_options);
 	if (negotiator)
 		negotiator->release(negotiator);
 	return ref;
@@ -1654,6 +1655,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				    struct string_list *pack_lockfiles)
 {
 	struct repository *r = the_repository;
+	struct fsck_options fsck_options = FSCK_OPTIONS_MISSING_GITMODULES;
 	struct ref *ref = copy_ref_list(orig_ref);
 	enum fetch_state state = FETCH_CHECK_LOCAL;
 	struct oidset common = OIDSET_INIT;
@@ -1882,6 +1884,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	if (negotiator)
 		negotiator->release(negotiator);
 
+	fsck_options_clear(&fsck_options);
 	oidset_clear(&common);
 	return ref;
 }

-- 
2.53.0.1118.gaef5881109.dirty


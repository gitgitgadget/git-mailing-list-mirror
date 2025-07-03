Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EF476C61
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 06:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751523341; cv=none; b=Kiwh0NrTt1SDBp2cWIJhML2V3iVWv/pCqUW+TsWPUiuQOksYLFj426C1BTTdmaTl8+GC1y4xuMG4TD5CBnk6U8EYk7LlVITm30ZErDMrP0dDXesUfpnct1qYPOFdsc3tku/PaeeZs9uboEEVEsMQtTFwZBa8D/1FSTTNs/lPpwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751523341; c=relaxed/simple;
	bh=fyewCfh4yawDnkzmDi+02L7nbfcLy1Ppx3bL0OKR3go=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=PQMNXICNor19K40Y+rrfhqC6/pgLRVCHr8mrwYBlCpntnQbJKfPOC9zsddCfiPbkyd3bFMi3PO2Q3fmbuSerIWl94u5ttc/kB12caVv9WY932zCmEhPIVQfZFFA9/Phi4Dq0WJ8eFkdLN4kPie8m8km6jeQ+t6XQiyZeUkg1cPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mwOXVBqU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RaEOKr5+; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mwOXVBqU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RaEOKr5+"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id BE10A1D0006A;
	Thu,  3 Jul 2025 02:15:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 03 Jul 2025 02:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751523337;
	 x=1751609737; bh=pGnjey2jHANwvqmxjduacfP8Q6FC8bsNdMzg77s7ypE=; b=
	mwOXVBqUNfY5RPbZdXuAfTc0OJf1ylD5E8RrF1DttfdsoTToCj70vDVsKdqDe8TH
	mmDY8oVvpFCsIYyNRvgwdawORLlt+c8OpaRG0+XN7pv+AueMcegV1voRuO3LJSSM
	49efeDjswxqMi4I9wqtepF2G7UGtu30Otx+EGxmcznMEYezdXQVNNikQzC1stgDa
	p03wdj49K/fFft6bkZKzh11QBsPus2rIEX4WZBnAnAt7s6VcoEMnAixBqipkfCuq
	ReqB70cQnf+hwU5hAGLflQGC2FoKdZeLbAWNfbTCfE2wEeGMGVe2y8mFAnJTgqAg
	zNYL6s9rSpzif32wiVa0IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751523337; x=
	1751609737; bh=pGnjey2jHANwvqmxjduacfP8Q6FC8bsNdMzg77s7ypE=; b=R
	aEOKr5+OlL7Tiiabfw3Ng/+GVhQ27tL7CUeH4EIrwear9CLYe5eMliLTg7Njggi1
	aKQW0+DvJem24k9nz5LMGl7zvyi7IwqL2YRTvzw2bU0Y4AshUFcwpQaoqOLvo5lf
	WKzime1O15Fz63LT/mxfOhXjfowjYLtG5ttJPxhfQXcGnQOZfexyUPpsZRfBXCj9
	9cppK/U0jrTnlAs/CqEs468Jn/cpQE1xxzQ4gn/5O4dvhnfRcgDNxwD0ompKB2U2
	d2s6g7sSdeeK0Pmu91eFl5vV4rnWRvQhQ2ubPk5p2SH2Od6iLeSHHqD4t/K08bt5
	F15ZGg7vU9M5iWGATKMOw==
X-ME-Sender: <xms:CSBmaH80NXwXWte3nPo6iUjCvM4E23y6W8t6vTAmyhjw0MPAgyPqFg>
    <xme:CSBmaDuQ237T2HjiqriERWCvtL3OxgCT3LtodZDkjSSYR7ZJfdbX5CzkoPsRsem8v
    1MbzSh9ScvJ8tkXHQ>
X-ME-Received: <xmr:CSBmaFDD1V7qijavlhB_ICDvsK-i1jm89WwuAZ3_CBTrN3iOkPRSiKcEmHNAi4b6vmcaMcOmAdrU3w3HJVpDTaS4IvDrmNMiDjoh6dBPRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epteeuueehhffhiedtueehtddtieekfedtudehtdehfefhgeffveeggedthfehuedvnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeej
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehjrgihrghthhgvvghrthhhkhhulhhkrghrnhhivddttdeh
    sehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhihvghnuhhssehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehs
    rghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudek
    keesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:CSBmaDd1ISFEx56ZAGdQCHhabtXow7RYWannGgaYGRrqhCY6qkqQzw>
    <xmx:CSBmaMMWhiepWqlVQj5wpYye_oj2aohDOrFK2nbkdZL229dfxukX8g>
    <xmx:CSBmaFl_NeN4PUwAJgCjXnN_hQWfVOoMyGBpT909Igw_SSMxfmtvkA>
    <xmx:CSBmaGvA2tTTK5NdD6oqR57HtVflHHvg_zTMFsZ9sN6pMVx07wCvqw>
    <xmx:CSBmaFb2_UCXaGZl_z75imMPDiX6dGaLZniOu7vznRdKZBY_z4LFGnWd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 02:15:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ec5ca86a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 3 Jul 2025 06:15:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/2] Add reftable by default as a breaking change
Date: Thu, 03 Jul 2025 08:15:29 +0200
Message-Id: <20250703-pks-reftable-default-backend-v2-0-5a27e72a8c5e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAEgZmgC/42NQQ6CMBBFr0Jm7ZhSRI0r72FYTNupTEAgbSUaw
 t0tnMDl+3l5f4HIQTjCrVgg8CxRxiGDPhRgWxqejOIyg1a6VhelceoiBvaJTM/o2NO7T2jIdjw
 4PNtK+araXIKcmLIpnz3/aDK3EtMYvvvbXG7rn+G5RIXXkzPkHHlTq3vWj/KCZl3XHy2K6WXFA
 AAA
X-Change-ID: 20250702-pks-reftable-default-backend-6c30f330250a
In-Reply-To: <20250702-pks-reftable-default-backend-v1-0-84dbaddafb50@pks.im>
References: <20250702-pks-reftable-default-backend-v1-0-84dbaddafb50@pks.im>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, ryenus@gmail.com, 
 Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

Hi,

the recent thread at [1] motivated me to hack together this tiny patch
series that paves our path towards making the reftable backend the
default backend. It does two things:

  - It announces the breaking change for Git 3.0.

  - It makes it the default now already when "feature.experimental" is
    enabled.

The first item is subject to ecosystem support, most notably in
libraries like Gitoxide, libgit2 and JGit. The second item is intended
to extend the user base to power users so that we get more test exposure
out in the wild before we make it the default in Git 3.0.

Changes in v2:
  - Improve the breaking changes announcement a bit based on feedback.
  - Introduce a `REF_STORAGE_FORMAT_DEFAULT` define.
  - Print the default ref format as part of `git version --build-options`.
  - Link to v1: https://lore.kernel.org/r/20250702-pks-reftable-default-backend-v1-0-84dbaddafb50@pks.im

Thanks!

Patrick

[1]: <xmqqtt3vkhwk.fsf@gitster.g>

---
Patrick Steinhardt (2):
      BreakingChanges: announce switch to "reftable" format
      setup: use "reftable" format when experimental features are enabled

 Documentation/BreakingChanges.adoc | 44 +++++++++++++++++++++++++++++++++++++
 Documentation/config/feature.adoc  |  6 +++++
 help.c                             |  2 ++
 repository.h                       |  6 +++++
 setup.c                            | 14 ++++++++++++
 t/t0001-init.sh                    | 45 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 117 insertions(+)

Range-diff versus v1:

1:  f12545f39d3 ! 1:  0b4cf2c7a25 BreakingChanges: announce switch to "reftable" format
    @@ Documentation/BreakingChanges.adoc: Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zo
     +  multiple advantages over the "files" format:
     ++
     +  ** It is impossible to store two references that only differ in casing on
    -+     case-insensitive filesystems with the "files" format. This issue is
    -+     especially common on Windows, but also on older versions of macOS. As the
    -+     "reftable" backend does not use filesystem paths anymore to encode
    -+     reference names this problem goes away.
    ++     case-insensitive filesystems with the "files" format. This issue is common
    ++     on Windows and macOS platforms. As the "reftable" backend does not use
    ++     filesystem paths anymore to encode reference names this problem goes away.
     +  ** Similarly, macOS normalizes path names that contain unicode characters,
     +     which has the consequence that you cannot store two names with unicode
     +     characters that are encoded differently with the "files" backend. Again,
    @@ Documentation/BreakingChanges.adoc: Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zo
     +     significantly outperforms the "files" backend by multiple orders of
     +     magnitude.
     ++
    ++Users that get immediate benefit from the "reftable" backend could continue to
    ++opt-in to the "reftable" format manually by setting the "init.defaultRefFormat"
    ++config. But defaults matter, and we think that overall users will have a better
    ++experience with less platform-specific quirks when they use the new backend by
    ++default.
    +++
     +A prerequisite for this change is that the ecosystem is ready to support the
     +"reftable" format. Most importantly, alternative implementations of Git like
     +JGit, libgit2 and Gitoxide need to support it.
    @@ Documentation/BreakingChanges.adoc: Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zo
      
      * Support for grafting commits has long been superseded by git-replace(1).
     
    + ## help.c ##
    +@@ help.c: void get_version_info(struct strbuf *buf, int show_build_options)
    + 			    SHA1_UNSAFE_BACKEND);
    + #endif
    + 		strbuf_addf(buf, "SHA-256: %s\n", SHA256_BACKEND);
    ++		strbuf_addf(buf, "default-ref-format: %s\n",
    ++			    ref_storage_format_to_name(REF_STORAGE_FORMAT_DEFAULT));
    + 	}
    + }
    + 
    +
    + ## repository.h ##
    +@@ repository.h: enum ref_storage_format {
    + 	REF_STORAGE_FORMAT_REFTABLE,
    + };
    + 
    ++#ifdef WITH_BREAKING_CHANGES /* Git 3.0 */
    ++# define REF_STORAGE_FORMAT_DEFAULT REF_STORAGE_FORMAT_REFTABLE
    ++#else
    ++# define REF_STORAGE_FORMAT_DEFAULT REF_STORAGE_FORMAT_FILES
    ++#endif
    ++
    + struct repo_path_cache {
    + 	char *squash_msg;
    + 	char *merge_msg;
    +
      ## setup.c ##
     @@ setup.c: static void repository_format_configure(struct repository_format *repo_fmt,
      			repo_fmt->ref_storage_format = ref_format;
      	} else if (cfg.ref_format != REF_STORAGE_FORMAT_UNKNOWN) {
      		repo_fmt->ref_storage_format = cfg.ref_format;
     +	} else {
    -+#ifdef WITH_BREAKING_CHANGES
    -+		repo_fmt->ref_storage_format = REF_STORAGE_FORMAT_REFTABLE;
    -+#else
    -+		repo_fmt->ref_storage_format = REF_STORAGE_FORMAT_FILES;
    -+#endif
    ++		repo_fmt->ref_storage_format = REF_STORAGE_FORMAT_DEFAULT;
      	}
      	repo_set_ref_storage_format(the_repository, repo_fmt->ref_storage_format);
      }
    @@ t/t0001-init.sh: test_expect_success 'init warns about invalid init.defaultRefFo
     +		sane_unset GIT_DEFAULT_REF_FORMAT &&
     +		git init refformat
     +	) &&
    -+	if test_have_prereq WITH_BREAKING_CHANGES
    -+	then
    -+		echo reftable >expect
    -+	else
    -+		echo files >expect
    -+	fi &&
    ++	git version --build-options | sed -ne "s/^default-ref-format: //p" >expect &&
     +	git -C refformat rev-parse --show-ref-format >actual &&
     +	test_cmp expect actual
     +'
2:  1fff73157a9 = 2:  3fddba1a29a setup: use "reftable" format when experimental features are enabled

---
base-commit: 83014dc05f6fc9275c0a02886cb428805abaf9e5
change-id: 20250702-pks-reftable-default-backend-6c30f330250a


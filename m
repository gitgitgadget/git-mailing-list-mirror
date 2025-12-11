Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919C72C3774
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 07:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765437613; cv=none; b=OgnrkhES/QAxY1odVtobG8BAxw26SBVHTuOsKCh5nq8IbtnypJYqdaWW0f+NgjAx1c0pfeB0poicmoC7ljNg+z0Oa8ZfWfkUeVJoKS5wAP6shrw/6t1BCTT0PUGbSMzp/XLQwXiS/AErrmmqXxCjVilCa4n1+8NoVgXtpxN02gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765437613; c=relaxed/simple;
	bh=zb9WyzK6xkQa7vn6vVeV8VsJlT6momx8blDjpLFbUAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uEBIIuzbpl/zQF5QzyulFD6NNxtyRx0aaIE9r65mYk43dLC6lPkiJvFfcPg7v3plTze0GmxV1s5lnKpSRSFQ9d72SOQ+nCK2Gp18LlNbuPylSGkfAJPJ7L+6vwntETExSerafz5IyFOOsPSiqkEAgiFY499cjXVFh+qiTWovKJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AxujI5xQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZipmUkqs; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AxujI5xQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZipmUkqs"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id B179B1D00192;
	Thu, 11 Dec 2025 02:20:10 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 11 Dec 2025 02:20:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765437610;
	 x=1765524010; bh=v5J1qYaowwegHaKKCLIfidHvOn380EEqM0EAHOXqXEk=; b=
	AxujI5xQQz9IF97Rbq45c3VsvZSkUBpPDKrLciRwVXiv0msUCOIkmQvhwf0wFczs
	Hdef5AJO3EwczCFhnssxWQN6tHONWsMwRbgga6odSUOCCBoB3D2mPcVK8GyDYCEe
	soaxUKzzehOX8RF7ZICZhCGyGGAnWLz1Ef9Dvfb/dDE3qa5kzU7bLYYYhqSIW1lu
	fhGZtJBPEKqoJTyBr3zt62HTA+jNhAvsVf9wuYcD4VAbW9DvfJr3IbG7S4+Tz3QS
	nqT/KpMFCHnQTNIIqLlLe02Nex7ny4BQ0tTpOuNyn0RJLkHnlCrgixpWg61fTmFy
	MW/0Ol1isiWQO8++T+Qg8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765437610; x=
	1765524010; bh=v5J1qYaowwegHaKKCLIfidHvOn380EEqM0EAHOXqXEk=; b=Z
	ipmUkqs6TqIqqy5CQOM51cI4X89PHyyWpOoOGDeA+UsNTn+uILkOvSdenlxZXDsp
	xKydtYo7LBuZCzWPiGxfDlW1DvZMN5M1TDr6wnWGfcgzjbms4FzNEcztryVgkzvT
	MeuqrWgykOziKO7pEahxnJQkrzqvAcvbl2IsDibOY1DfKqqOEOO2iPep/vScABbS
	+D1V/A1eBJA+bDNrtP92NVUJUsrs6DU7GFXe72OY9/GvbnpOoUIFXFH12PVroWUa
	OuuQHREmbScuapaCVBe1mCVuuSXIBiRR2oP1Sy16lqtt7L2+L6BDYUPZVH4DXQCj
	oUOsvaWsX/I9pfEIfM/3Q==
X-ME-Sender: <xms:qnA6aYUkFoheq0P2gIZ3FjItKCn4KLi0jJw48U7Id4k8rAI2duWF7Q>
    <xme:qnA6aUACq4iTH1LhMcKgxHnXBAwJxZZnm0KQAGdd-dnMOtoCa5KFjkW-aguxzYTKC
    eCIKV-j7lRYCFwKQIHyYWgVY4ksH523zlAl51JmM8rnOj9KHIFO>
X-ME-Received: <xmr:qnA6aZx9U5wUwLEzqkPEmSJ5gzCP3EPsY1u6tI-i8tOzzUQH_cMaigr3aKb56ys5nNn2aH0SPCIhpnbxZpw7mJU4JWb56yjhFds09PmplL7F>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhhih
    hnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:qnA6aRAnAY8pZ27Q17ymK_H7Tk1iwWHZGDfIKlPF_L9DH82v3qCGHQ>
    <xmx:qnA6aWZ9tznCb6l1-mjcjygFXgd-hvJYadDrM5R4dU5V_XLqaMWiZw>
    <xmx:qnA6aZiJY4bH8kC2TEen4XM52vrxqsfEGMBczZahwGNmMt3j89KEQw>
    <xmx:qnA6aY4v87vXeoGv10B-eMbwxbAxzYjvTeOTLvflqvdmCFZECvSiKA>
    <xmx:qnA6aYD8mdMg0-YvsjFxI7HznRT1tQLMl3hwNOU3BseONRW0Tve0Sj3v>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Dec 2025 02:20:09 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 557e8982 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Dec 2025 07:20:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 11 Dec 2025 08:19:59 +0100
Subject: [PATCH v2 2/2] odb: properly close sources before freeing them
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-odb-related-fixes-v2-2-bdf875ce51fc@pks.im>
References: <20251211-odb-related-fixes-v2-0-bdf875ce51fc@pks.im>
In-Reply-To: <20251211-odb-related-fixes-v2-0-bdf875ce51fc@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: b4 0.14.3

It is possible to hit a memory leak when reading data from a submodule
via git-grep(1):

  Direct leak of 192 byte(s) in 1 object(s) allocated from:
    #0 0x55555562e726 in calloc (git+0xda726)
    #1 0x555555964734 in xcalloc ../wrapper.c:154:8
    #2 0x555555835136 in load_multi_pack_index_one ../midx.c:135:2
    #3 0x555555834fd6 in load_multi_pack_index ../midx.c:382:6
    #4 0x5555558365b6 in prepare_multi_pack_index_one ../midx.c:716:17
    #5 0x55555586c605 in packfile_store_prepare ../packfile.c:1103:3
    #6 0x55555586c90c in packfile_store_reprepare ../packfile.c:1118:2
    #7 0x5555558546b3 in odb_reprepare ../odb.c:1106:2
    #8 0x5555558539e4 in do_oid_object_info_extended ../odb.c:715:4
    #9 0x5555558533d1 in odb_read_object_info_extended ../odb.c:862:8
    #10 0x5555558540bd in odb_read_object ../odb.c:920:6
    #11 0x55555580a330 in grep_source_load_oid ../grep.c:1934:12
    #12 0x55555580a13a in grep_source_load ../grep.c:1986:10
    #13 0x555555809103 in grep_source_is_binary ../grep.c:2014:7
    #14 0x555555807574 in grep_source_1 ../grep.c:1625:8
    #15 0x555555807322 in grep_source ../grep.c:1837:10
    #16 0x5555556a5c58 in run ../builtin/grep.c:208:10
    #17 0x55555562bb42 in void* ThreadStartFunc<false>(void*) lsan_interceptors.cpp.o
    #18 0x7ffff7a9a979 in start_thread (/nix/store/xx7cm72qy2c0643cm1ipngd87aqwkcdp-glibc-2.40-66/lib/libc.so.6+0x9a979) (BuildId: cddea92d6cba8333be952b5a02fd47d61054c5ab)
    #19 0x7ffff7b22d2b in __GI___clone3 (/nix/store/xx7cm72qy2c0643cm1ipngd87aqwkcdp-glibc-2.40-66/lib/libc.so.6+0x122d2b) (BuildId: cddea92d6cba8333be952b5a02fd47d61054c5ab)

The root caues of this leak is the way we set up and release the
submodule:

  1. We use `repo_submodule_init()` to initialize a new repository. This
     repository is stored in `repos_to_free`.

  2. We now read data from the submodule repository.

  3. We then call `repo_clear()` on the submodule repositories.

  4. `repo_clear()` calls `odb_free()`.

  5. `odb_free()` calls `odb_free_sources()` followed by `odb_close()`.

The issue here is the 5th step: we call `odb_free_sources()` _before_ we
call `odb_close()`. But `odb_free_sources()` already frees all sources,
so the logic that closes them in `odb_close()` now becomes a no-op. As a
consequence, we never explicitly close sources at all.

Fix the leak by closing the store before we free the sources.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/odb.c b/odb.c
index dc8f292f3d..8e67afe185 100644
--- a/odb.c
+++ b/odb.c
@@ -1132,13 +1132,13 @@ void odb_free(struct object_database *o)
 	oidmap_clear(&o->replace_map, 1);
 	pthread_mutex_destroy(&o->replace_mutex);
 
+	odb_close(o);
 	odb_free_sources(o);
 
 	for (size_t i = 0; i < o->cached_object_nr; i++)
 		free((char *) o->cached_objects[i].value.buf);
 	free(o->cached_objects);
 
-	odb_close(o);
 	packfile_store_free(o->packfiles);
 	string_list_clear(&o->submodule_source_paths, 0);
 

-- 
2.52.0.270.g3f4935d65f.dirty


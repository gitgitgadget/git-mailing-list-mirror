Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF7039B4AF
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 09:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782381472; cv=none; b=PnczTzno0M6jTFxKVmwUMNjqvUngBlKnnVzkvB8pwySYMJEdLQDL6Z+08c6Vlg50IL8AFMUIPLuf+d3MJs5pLFkCZ/YrsieVxluRzBoWGdJzcYbYLnaKNVxCr5bSkV5VIWtTW7SF3m0KOXJRZb2G/FCQVT4EyCvs5OhITQp1BkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782381472; c=relaxed/simple;
	bh=XoQu7197YZ9jnMPsioFN31YnFzdvg74ukuUSWwvJ+O0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=WyrZYpAVLEt5+KrLoS6hVee4hcdHSe6frxJ1IQfpWgG4GwIT0iyyk1FB/Ay48zYlILnGZkk2ZnaRpQE9ewlcW5lDPoSrec/kM2G/pGhg5NoUq7oe/uHBqlSG44+36ucM3JchCZ0Is8lwS5PVKKCRRkmtgYkL+7n373ngoTUnA1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N97j3JIc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ru4JMt2b; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N97j3JIc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ru4JMt2b"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 226021D000B8;
	Thu, 25 Jun 2026 05:57:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 25 Jun 2026 05:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782381469;
	 x=1782467869; bh=7LN87OC6Bz6QiC7H2WrN8j6ZzIkac/nFWWCFZRLxhEE=; b=
	N97j3JIcfB32MJB6G6NLAOcs5/B1eytZ7l2ilYj9XRuTWjMEo6PB47QLvlkNnEyZ
	7ppvz/4XPm+QqZsYWaTynEHphXGjZQMOUoJ2XmJlIqQ3Z2fpIweoBUcleh9hrBkA
	6JsnHnSqnl1nv/V6jGlrgtXfBzBgJ/nzAf8RM+gOb49igEGSDG/FYgcGhQSWCjgU
	dz3TYB2TNEYUWroUDrVEw684V2LDYnyTZLaEpJcB6Dp+LdPBPSIiu+lw94zedd7Z
	po7VWP7pURcWTClLYIXc54c8Xj80b0IyD70n2VcKzNKpCSBtN1G5+JX4IbbTkjx8
	WBSV9KHTcwXA6cCTnVcBmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782381469; x=
	1782467869; bh=7LN87OC6Bz6QiC7H2WrN8j6ZzIkac/nFWWCFZRLxhEE=; b=R
	u4JMt2bBuElc93Z9guC0kSbcfSBUltQNiVWl7g9Ig6EOlLCqFxAac1N0xusIR4x8
	3iuBOO2aTHOgKibX9npBpaxQJcAWEdWTb/0xFsK0wJ2s4Pnbe5N7Y3nB18ihqawG
	1wHKaVNoGq31xQl8VzGdxnmi9AB5R+RlQGp/EvDiHycYFwa+gn2JuGQpLiYH1ZZH
	q8QaKb0KFnrETZ3dwSJRvSpyuc3FNo41m4ZRqHWda71CpnWcCv7N/MRyX9t5kj0w
	85pOqaMgzv156Qng/6vhBY8AlokhcbtezvpQjiNt3wxxtSCoOTKw8I2as6RNDNWl
	mVLpdO4gjYjg3FeGBvFcg==
X-ME-Sender: <xms:nfs8aiWYJQ-nUL6NB81rxMgaZ0G_z_RdkD42flcI3n418o3VYYGzog>
    <xme:nfs8amD9oEMBylVctuYGwtpbiGBHvYTLNjLgrLsN4Cjd___9x0JGMYOc--IhnKLtB
    dRMTt6LZeho7ta5Agksnd2Bx4stEJWcykt8l7ystwzR9EeYJOEPgw>
X-ME-Received: <xmr:nfs8ajwqLnhH-CPDo9JFTlhvo8RjgdHXQTppeRqZC0I18VFwnrUV5yEpt8jj8DHhWYgMBR9kkhX2fISchVxaYSx27I0ZpXPqVwPg6sKl4g>
X-ME-Proxy-Cause: dmFkZTGaRO3grUjqTW4QvA9iPsNjfUHMpS2+iZaMYwKN7z3UKWZ8qXDpMnDExPlIR/qNUo
    KR550cA7XaupOtAoseaB7qZ4uQ7HHU+VmijRbha2W8eledO7CLSkFmmsvPqxsEjos+mFsE
    7wKQuVBfpUs9UXWgw16lxII1T+YJq8qus1CEXYvhZzFDsODFKMuPG2zcVu9a31RsCe8/SK
    /TPqQoKjS/8uChm13CGbYaNj/IW7oS/FxrVP/e0VPFco8pcHsx2vkQnh1MhHdb/KtKzJny
    r1NPTH4dbo/Qra4U3IUUB4C74lMkAs1TgMTu29yQ/vVOqxmpA57yJyuTrwQbM4INpEbRmb
    AgP1HR0zMP5B/976JjhlUBkoyQsQbjErq9DKXPxgk+aJclEOjuME5NJ+BF/mASGrLLeyzn
    IO2ofKugASeJx9flRkIlaqKjs2Lehe1bodG4IjwmuKV2YJS+deSHTlFFGrhRQ9X4aktAdA
    +RdsNbSWl7W8ljmGSETSpSGihtFLuBriCrS1P86k8wmcLGa5KVFFxaKLTqJhSmPfv1YgdW
    +oSiUGA7jZ56tzu6CyJ2e5gcPs2ysEOFcU6UxcaiyXce04y4LHL3y8yWsAeKc7HmycnPqV
    YyPTaFK1TPvrSg2VAxxQquL2R2Th2dcRW3uXRkCs8asHXt0A7vhOXaqzzkUw
X-ME-Proxy: <xmx:nfs8ajBntIX66DFBgvfOtolSw3GfNxEOd0Wu9vlodSVFhrPcSqcDyg>
    <xmx:nfs8agaLJi2IuRTcfvUla54BHHGSSvkgHA9yzFUHIOmU39I6lc1Mxw>
    <xmx:nfs8argWakLEubwb6F6dD4ByUqmqAOJHgmPJKGRBep1XEPEAN0VhZQ>
    <xmx:nfs8ai4GCIcWo_bhFPnIfcGP6qD7DiszHVZXAWpWbNRi1eFsFCdXnA>
    <xmx:nfs8ajoVz64wkta2r2kbZs14u-vrj3_gEY8PJeIj3Q67ZzBhY5evhnHT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 05:57:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d95c521f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 25 Jun 2026 09:57:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/4] connected: search promisor objects generically
Date: Thu, 25 Jun 2026 11:57:38 +0200
Message-Id: <20260625-pks-connected-generic-promisor-checks-v3-0-7308f3b9dc44@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJL7PGoC/42Oyw6CMBREf4V0bU25RR6u/A/jgpYLVENLWiQaw
 r97i8a4dDnJzDmzsIDeYGDHZGEeZxOMsxTkLmG6r22H3DSUGQjIRZ4CH2+Ba2ct6gkb3qGlvea
 jd4MJznPdo6YGVFKqtpUCyoYRa/TYmsfmOV/eOdzVlSARHhu9CZPzz+3InMbexwn/OueUCw4HV
 DXkVUnjE+32ZmBROMMvMvsXCYRMJTSFRMwKVX2R67q+AOK+4OA8AQAA
X-Change-ID: 20260612-pks-connected-generic-promisor-checks-2933bff3028d
In-Reply-To: <20260622-pks-connected-generic-promisor-checks-v1-0-25eba2698202@pks.im>
References: <20260622-pks-connected-generic-promisor-checks-v1-0-25eba2698202@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15.2

Hi,

this patch series refactors "connected.c" so that we search for promisor
objects in a generic way instead of reaching into internal of the object
database. As a result, the connectivity checks will work properly in
repos that don't use packfiles in the first place.

The series is built on top of 8d96f09e92 (Merge branch
'js/objects-larger-than-4gb-on-windows', 2026-06-19) with
ps/odb-source-packed at 1bba3c035d (odb/source-packed: drop pointer to
"files" parent source, 2026-06-17) merged into it.

Changes in v3:
  - Fix reversed logic for whether the promised object was found, which
    broke in v2.
  - Add a test that verifies that we indeed use the optimized check.
  - Match the hash before computing the flags so that we break out of
    the loop more eagerly.
  - Link to v2: https://patch.msgid.link/20260624-pks-connected-generic-promisor-checks-v2-0-132d73ee47b9@pks.im

Changes in v2:
  - Fix the accidentally-dropped call to `odb_reprepare()`.
  - Add a preparatory commit that splits out `check_connected_promisor()`.
    I think also splitting out `check_connected_rev_list()` would only
    have diminishing returns, so I skipped that part.
  - Link to v1: https://patch.msgid.link/20260622-pks-connected-generic-promisor-checks-v1-0-25eba2698202@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (4):
      odb/source-packed: extract logic to skip certain packs
      odb/source-packed: support flags when iterating an object prefix
      connected: split out promisor-based connectivity check
      connected: search promisor objects generically

 connected.c              | 98 +++++++++++++++++++++++++++++++-----------------
 odb/source-packed.c      | 50 +++++++++++++++++-------
 t/t5616-partial-clone.sh | 24 ++++++++++++
 3 files changed, 125 insertions(+), 47 deletions(-)

Range-diff versus v2:

1:  74d1d04183 = 1:  93b7b3b4cb odb/source-packed: extract logic to skip certain packs
2:  02aa39bf1e ! 2:  3fd0885b85 odb/source-packed: support flags when iterating an object prefix
    @@ odb/source-packed.c: static int for_each_prefixed_object_in_midx(
      
      	for (; m; m = m->base_midx) {
     @@ odb/source-packed.c: static int for_each_prefixed_object_in_midx(
    - 			const struct object_id *current = NULL;
    - 			struct object_id oid;
    + 			if (!match_hash(len, opts->prefix->hash, current->hash))
    + 				break;
      
     +			if (opts->flags) {
     +				uint32_t pack_id = nth_midxed_pack_int_id(m, i);
    @@ odb/source-packed.c: static int for_each_prefixed_object_in_midx(
     +					continue;
     +			}
     +
    - 			current = nth_midxed_object_oid(&oid, m, i);
    + 			if (data->request) {
    + 				struct object_info oi = *data->request;
      
    - 			if (!match_hash(len, opts->prefix->hash, current->hash))
     @@ odb/source-packed.c: static int for_each_prefixed_object_in_midx(
      	ret = 0;
      
3:  ff9df84f65 = 3:  47a4732daf connected: split out promisor-based connectivity check
4:  a10d2e6a1e ! 4:  239abf2731 connected: search promisor objects generically
    @@ Commit message
         flag. This will yield all objects that have the exact object name and
         that are part of a promisor pack in a generic way.
     
    +    Add a test to verify that we indeed use the optimization.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## connected.c ##
    @@ connected.c
      
     +static int promised_object_cb(const struct object_id *oid UNUSED,
     +			      struct object_info *oi UNUSED,
    -+			      void *payload UNUSED)
    ++			      void *payload)
     +{
    ++	bool *found = payload;
    ++	*found = true;
     +	return 1;
     +}
     +
    @@ connected.c: static int check_connected_promisor(oid_iterate_fn fn,
      	odb_reprepare(the_repository->objects);
      	do {
     -		struct packed_git *p;
    -+		opts.prefix = *oid;
    ++		bool found = false;
      
     -		repo_for_each_pack(the_repository, p) {
     -			if (!p->pack_promisor)
    @@ connected.c: static int check_connected_promisor(oid_iterate_fn fn,
     -			if (find_pack_entry_one(*oid, p))
     -				goto promisor_pack_found;
     -		}
    -+		err = odb_for_each_object_ext(the_repository->objects,
    -+					      NULL, promised_object_cb,
    -+					      NULL, &opts);
    ++		opts.prefix = *oid;
    ++
    ++		err = odb_for_each_object_ext(the_repository->objects, NULL,
    ++					      promised_object_cb, &found, &opts);
     +		if (err < 0)
     +			return err;
      
    @@ connected.c: static int check_connected_promisor(oid_iterate_fn fn,
     -
     -promisor_pack_found:
     -		;
    -+		if (err > 0)
    ++		if (!found)
     +			return 0;
      	} while ((*oid = fn(cb_data)) != NULL);
      
      	return 1;
    +
    + ## t/t5616-partial-clone.sh ##
    +@@ t/t5616-partial-clone.sh: test_expect_success 'partial fetch inherits filter settings' '
    + 	test_line_count = 5 observed
    + '
    + 
    ++test_expect_success 'partial fetch does not spawn rev-list connectivity check' '
    ++	test_when_finished "rm -rf connectivity-remote connectivity-client" &&
    ++	git init connectivity-remote &&
    ++	test_commit -C connectivity-remote one &&
    ++	git -C connectivity-remote config uploadpack.allowfilter 1 &&
    ++	git -C connectivity-remote config uploadpack.allowanysha1inwant 1 &&
    ++
    ++	git clone --no-checkout --filter=blob:none \
    ++		"file://$(pwd)/connectivity-remote" connectivity-client &&
    ++
    ++	# When doing a partial fetch where all tips are part of a promisor pack
    ++	# we want to skip the connectivity check, as these objects are allowed
    ++	# to not be fully connected.
    ++	test_commit -C connectivity-remote two &&
    ++	GIT_TRACE2_EVENT="$(pwd)/partial.trace" git -C connectivity-client fetch origin &&
    ++	test_subcommand_flex ! git rev-list --objects --stdin <partial.trace &&
    ++
    ++	# Otherwise, when doing a fetch where any of the tips is not part of a
    ++	# promisor pack, then we must run the connectivity check.
    ++	test_commit -C connectivity-remote three &&
    ++	GIT_TRACE2_EVENT="$(pwd)/full.trace" git -C connectivity-client fetch --no-filter origin &&
    ++	test_subcommand_flex git rev-list --objects --stdin <full.trace
    ++'
    ++
    + # force dynamic object fetch using diff.
    + # we should only get 1 new blob (for the file in origin/main).
    + test_expect_success 'verify diff causes dynamic object fetch' '

---
base-commit: 4a8e7a446f41435e157131162dfe901eca9250fe
change-id: 20260612-pks-connected-generic-promisor-checks-2933bff3028d


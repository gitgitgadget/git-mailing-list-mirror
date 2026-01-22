Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7523142B744
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 12:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083529; cv=none; b=barmGLkojM/1l2Vk8ev3hsHa6WOTl/wdtO+9ieyJ+Cb0ufdfG+ms8xwrUKeO1pcKfdyE9mNCkV178sbBDoC5YxaiLjhkwtFZ4C8tFAeBFmoPOcbLThxg2kZSFf+r7h+IomCAaB36azrxK3KLmdK6IU6Dx3MTvz1Dc3xFu7q4KDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083529; c=relaxed/simple;
	bh=OLhuV/Cn1cKLT0fkKCzhqGrfeSrU3q8yDY6mRqZItw4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=UqFlqnkXCcApA5GgU0OyxivQWyLs4d1KPBdLhPO6y8rAyW5PFUKiDCY6g8WFjrrqeEhIgAkV1q3jYhe+dNf16XADC3s4dupwGHhIhs+98UfS3EFlOVG86Fl8symc2AICdm5L+YWIlEgT9Kixp6g2n82IP6qgfv2+Wm9fyX5vUyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FryQkQ08; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FryQkQ08"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so10050245e9.2
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 04:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769083523; x=1769688323; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qTiwv+GqyUsrGEjtumdR/EGtRGxwm9TUZgXcBwTaI+o=;
        b=FryQkQ087v21WkE5BTdT6kqLflOrFPqdWuwizJPF0BAFkvIyKR4HRL/PhTgtN4SEba
         0PxW2VvqXUQOh5qlBgjS+k9xiEFE7+4vrQn2DRIgqzrVlvcJnqSlPGGo5rU8GhQENT3s
         1KsCW1d9/Ekogp3mn33WiXVgmSe0XAnIq0unqVR3m9KEA4FJASi2reyv6kBCgVtbRe4E
         ed96tlKDdguVv0KpIvzQA6YcaOQlk+uP7MIePt7f9AMM2RwTNyZbzgXQRlc1A506e3vs
         0/HGMVbFfY6szpu8QytTdo1QFaA2kBu5vahQKflr8sTP6WbWadPYOiMxUhlmA+tuRy+t
         ZWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769083523; x=1769688323;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTiwv+GqyUsrGEjtumdR/EGtRGxwm9TUZgXcBwTaI+o=;
        b=aPSYdCU0uFDJd5w2DrKgC7ho97sSj/dNoZUDWDd5zWfIHEW6uIfcseR7Aj2rWKds7h
         qjn1/Z5uTSnxnVF1ri9YHpnmRjoqa7AkoeIBYXkD3aALKzALQcsL/m6urdLvpl0zJh3F
         Oy6PSGckCx7fMGQzNDW1zomTvRs5vi96S2Fh9E7yAgRZEKFP1dDGVXV2hfr45Sv6tmgV
         wNHcT15lmakfq8Ojl50cVMqwy00WYDE5g5DceILlZgwrkR+OwByf+fWDAb85zGYtFiy0
         vvpnTcGqBj92hgr8Z3Ts0COEqcPAfi7TmfaKqfm4H8B8Ttc+ZMDnG8irfioalM/UdtW/
         KcIw==
X-Gm-Message-State: AOJu0Yz8gbto8GgBbW0QuPO6E/JiKyMXGbv4YEZ81OzvEkhUMfrMNuMd
	vEs/fW6voZtpMD15JG/9xEnmDGuR8gL4+1Ml/21fiZBKJy0Yrj74G0ri0IccUQ==
X-Gm-Gg: AZuq6aIp7O6GflXdq9xj4E7CO5pvIRMWBCXlc5qZISjb3Hrjhjp3zN9zdeIt08cSrtA
	jAoyNXWzcrlXOnfsrhDWS/QRxz9bW1+Br0KmTCc9xjC1/YxgWseTNwyTALir/pJ+hMF2zbPbbvC
	dou33nqNfqFoCL9KBq7MuNZ5M/VCe7aba938xiL3C141tT1v74+aL26Pq1MK4vS6pPsgtnB2jxb
	0v+nWmXpTQNxUnq7OIuxsGo3U88K0pr4RoKkKcjrSTQg1cOVq1bhS2MV3MEm9aG8fAbmyfaOqfS
	m6fr7StZnINEs9YPwZZKZryU5v12D/DxwvMowlBk6DD49iZE/HvKc40NxuoogKpEFLDat4vrcB+
	JByNct/IPgjnI0ZxC3XjA3qX6Uj5VPw0nREoBa1RzvfrU3fYnH3S/4wfkg5qRh8gP5cv4Ds88Pe
	FySwKSuzXJs5vUz7uMNO/aQ0msF4qB
X-Received: by 2002:a05:600c:3f10:b0:475:e067:f23d with SMTP id 5b1f17b1804b1-4803e7f03c1mr127726755e9.25.1769083522827;
        Thu, 22 Jan 2026 04:05:22 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:ef49:411:ff92:1c50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-480470403d3sm64926445e9.5.2026.01.22.04.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 04:05:22 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 0/6] refs: provide detailed error messages when using
 batched update
Date: Thu, 22 Jan 2026 13:04:54 +0100
Message-Id: <20260122-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v4-0-2ddba0832440@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGYScmkC/7XOy26EMAwF0F8ZZV1XefDsqv9RdRGCAVdDMsIMb
 TXi32uoKqHu2eUm1/F5KMaJkNXL5aEmXIgpRQnZ00WFwccegVrJympbaGMcFM7BhP2EvFXhmni
 Glnwf5UABRrn3MvU5YITbnQeKPUQphjSONENqPjDMDHOSXzqGAX3LYMqyKhqrqzrzSlbf5I2+d
 tbb+2/m+z65WbbGQDyn6Xt3L2br/RGzc4iLAQ1d3lWNKV3ItXntR0/XZxlSG3GxR0RxEsIKora
 511iHsnP2P8IdEFafhHCCQI1tY2sfGuyOiHVdfwBL1KGqVAIAAA==
X-Change-ID: 20260113-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-17786b20894a
In-Reply-To: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
References: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
To: git@vger.kernel.org
Cc: peff@peff.net, newren@gmail.com, gitster@pobox.com, 
 phillip.wood123@gmail.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=16903;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=OLhuV/Cn1cKLT0fkKCzhqGrfeSrU3q8yDY6mRqZItw4=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGlyEoBbG/Ee2QxfzO0D6aC8rnwnSsJkbep2L
 6TF6FYUMsmTN4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpchKAAAoJED7VnySO
 Rox/vU8L/28FnaLfEi6kxHfyVasNAYICXgqeJqXJsQticdWdKysk+GrDL1L9yGaci8KkqdTO8AR
 Ha9d5ZoABzlknFlIW3nQLyOnKpZjdrNXnotEAPQyBvW9O5rFMxCugXO2HnjkXUYZmrHJ2fXUys+
 oJWgMFeoMs7WYTSvTO9RrEdSvUykx+41SZbeRcc5jWVcyHPszNYphY65IxmVeqa15DzeLVvq8rb
 SRu05oKPu52MXanNx9ExH5a1VK9o0ZTDjaaqLSWO3W+59AkcIkx7odmyyChMAvXdQ5cC8/7y7Am
 X12N6p5Oo9haCfaSs1VxJD1nPxMp/eCvYQCV4TcIJqT64fWEQIUR1Vu6oqmegijuS5EAML/siMT
 klg0uX0Pol8UhGujbpI830zFBKtU/OU+mdwObTN6Wo2RU+7lxgW32TUPJpVHgEpGRXK6/feEY9U
 fZgrJoaWTy0e/0qeQ+6B8ZLPJywTVhUwYTdVSDZ21+wRT1JQWouIMUR6ASAM7TXzzFQPg7OoCX5
 0o=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The refs namespace uses an error buffer to capture details about failed
reference updates. However when we added batched update support to
reference transactions, these messages were never propagated, instead
only an error code pertaining to the type of failure was propagated.

Currently, there are three regions which utilize batched updates:

  - git update-ref --batch-updates
  - git fetch
  - git receive-pack

While 'git update-ref --batch-updates' was a newly introduced flag, both
'git fetch' and 'git receive-pack' were pre-existing. Before using
batched updates, they provided more detailed error messages to the user,
but this changed with the introduction of batched updates. This is a
regression in their workings.

This patch series fixes this, by passing the detailed error message and
utilizing it whenever available. The regression was reported by Elijah
Newren [1] and based on the patch submitted by Jeff King [2].

[1]: https://lore.kernel.org/all/CABPp-BGL2tJR4dPidQuFcp-X0_VkVTknCY-0Zgo=jHVGv_P=wA@mail.gmail.com/
[2]: https://lore.kernel.org/all/20251224081214.GA1879908@coredump.intra.peff.net/

---
Changes in v4:
- In the last commit, instead of propagating {*list, count}, propagate
  an array with {*list, nr, count} and use ALLOC_GROW. This simplifies
  the variables passed and cleanups the code.
- Link to v3: https://patch.msgid.link/20260120-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v3-0-e0edb29acbef@gmail.com

Changes in v3:
- Drop the first commit.
- For the last commit, where we delay 'git fetch' status information,
  delay all information to the end. Also use a list to compliment the
  existing strmap, this ensures that the order is maintained.
- Link to v2: https://patch.msgid.link/20260116-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v2-0-925a0e9c7f32@gmail.com

Changes in v2:
- Updates to the commit messages to be more descriptive.
- Instead of passing the char pointer for the error description, pass
  the 'strbuf' itself. This makes the API a lot cleaner to deal with.
  Also avoids having to remember to reset the strbuf after usage.
- Chalk out a separate commit for using a 'goto next_ref' in
  `refs_verify_refnames_available()`. This makes the intention much
  clearer.
- For git-update-ref(1), keep the existing implementation as is and only
  output the detailed error message to stderr.
- For git-receive-pack(1), use 'rp_error()' for detailed error message
  while keeping the current implementation as is.
- Added a separate patch to handle missing information in git-fetch(1)'s
  status table. This involves delaying updates to the end, where update
  success/failure information is available. I'm not too confident about
  this approach though, we could also drop it from the series and I
  could pick that up independently. This is still 1.19 ± 0.02 times
  faster than non-batched version (v2.50.0) in the files backend.
- Link to v1: https://patch.msgid.link/20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com

---
 builtin/fetch.c         | 255 +++++++++++++++++++++++++++++++++++++-----------
 builtin/receive-pack.c  |   7 +-
 builtin/update-ref.c    |   7 +-
 refs.c                  |  46 +++++----
 refs.h                  |   1 +
 refs/files-backend.c    |   5 +-
 refs/packed-backend.c   |  12 +--
 refs/refs-internal.h    |   4 +-
 refs/reftable-backend.c |   5 +-
 t/t1400-update-ref.sh   |  71 ++++++++------
 t/t5510-fetch.sh        |   8 +-
 t/t5516-fetch-push.sh   |  16 +++
 12 files changed, 312 insertions(+), 125 deletions(-)

Karthik Nayak (6):
      refs: skip to next ref when current ref is rejected
      refs: add rejection detail to the callback function
      update-ref: utilize rejected error details if available
      fetch: utilize rejected ref error details
      receive-pack: utilize rejected ref error details
      fetch: delay user information post committing of transaction

Range-diff versus v3:

1:  f5fa12101b = 1:  f89b8a3526 refs: skip to next ref when current ref is rejected
2:  6911cab2c7 = 2:  c988070f5f refs: add rejection detail to the callback function
3:  c20fc32d3e = 3:  f419704bca update-ref: utilize rejected error details if available
4:  8b5ce22c65 = 4:  0c50af08f3 fetch: utilize rejected ref error details
5:  73a43ddeeb = 5:  758a265930 receive-pack: utilize rejected ref error details
6:  f9b76d57f8 ! 6:  c22d759ae8 fetch: delay user information post committing of transaction
    @@ builtin/fetch.c: static void display_ref_update(struct display_state *display_st
     +	struct object_id new_oid;
     +};
     +
    ++struct ref_update_display_info_array {
    ++	struct ref_update_display_info *info;
    ++	size_t alloc, nr;
    ++};
    ++
     +static struct ref_update_display_info *ref_update_display_info_append(
    -+					   struct ref_update_display_info **list,
    -+					   size_t *count,
    ++					   struct ref_update_display_info_array *array,
     +					   char success_code,
     +					   char fail_code,
     +					   const char *summary,
    @@ builtin/fetch.c: static void display_ref_update(struct display_state *display_st
     +					   const struct object_id *new_oid)
     +{
     +	struct ref_update_display_info *info;
    -+	size_t index = *count;
    -+
    -+	(*count)++;
    -+	REALLOC_ARRAY(*list, *count);
     +
    -+	info = &(*list)[index];
    ++	ALLOC_GROW(array->info, array->nr + 1, array->alloc);
    ++	info = &array->info[array->nr++];
     +
     +	info->failed = false;
     +	info->success_code = success_code;
    @@ builtin/fetch.c: static void display_ref_update(struct display_state *display_st
     -			    int summary_width,
     -			    const struct fetch_config *config)
     +			    const struct fetch_config *config,
    -+			    struct ref_update_display_info **display_list,
    -+			    size_t *display_count)
    ++			    struct ref_update_display_info_array *display_array)
      {
      	struct commit *current = NULL, *updated;
      	int fast_forward = 0;
    @@ builtin/fetch.c: static int update_local_ref(struct ref *ref,
     -			display_ref_update(display_state, '=', _("[up to date]"), NULL,
     -					   remote_ref->name, ref->name,
     -					   &ref->old_oid, &ref->new_oid, summary_width);
    -+			ref_update_display_info_append(display_list, display_count,
    -+						       '=', '=', _("[up to date]"),
    -+						       NULL, NULL, ref->name,
    ++			ref_update_display_info_append(display_array, '=', '=',
    ++						       _("[up to date]"), NULL,
    ++						       NULL, ref->name,
     +						       remote_ref->name, &ref->old_oid,
     +						       &ref->new_oid);
      		return 0;
    @@ builtin/fetch.c: static int update_local_ref(struct ref *ref,
     -				   _("can't fetch into checked-out branch"),
     -				   remote_ref->name, ref->name,
     -				   &ref->old_oid, &ref->new_oid, summary_width);
    -+		info = ref_update_display_info_append(display_list, display_count,
    -+						      '!', '!', _("[rejected]"),
    -+						      NULL, _("can't fetch into checked-out branch"),
    ++		info = ref_update_display_info_append(display_array, '!', '!',
    ++						      _("[rejected]"), NULL,
    ++						      _("can't fetch into checked-out branch"),
     +						      ref->name, remote_ref->name,
     +						      &ref->old_oid, &ref->new_oid);
     +		ref_update_display_info_set_failed(info);
    @@ builtin/fetch.c: static int update_local_ref(struct ref *ref,
     -					   remote_ref->name, ref->name,
     -					   &ref->old_oid, &ref->new_oid, summary_width);
     +
    -+			info = ref_update_display_info_append(display_list, display_count,
    -+							      't', '!', _("[tag update]"), NULL,
    ++			info = ref_update_display_info_append(display_array, 't', '!',
    ++							      _("[tag update]"), NULL,
     +							      _("unable to update local ref"),
     +							      ref->name, remote_ref->name,
     +							      &ref->old_oid, &ref->new_oid);
    @@ builtin/fetch.c: static int update_local_ref(struct ref *ref,
     -					   _("would clobber existing tag"),
     -					   remote_ref->name, ref->name,
     -					   &ref->old_oid, &ref->new_oid, summary_width);
    -+			info = ref_update_display_info_append(display_list, display_count,
    -+							      '!', '!', _("[rejected]"), NULL,
    ++			info = ref_update_display_info_append(display_array, '!', '!',
    ++							      _("[rejected]"), NULL,
     +							      _("would clobber existing tag"),
     +							      ref->name, remote_ref->name,
     +							      &ref->old_oid, &ref->new_oid);
    @@ builtin/fetch.c: static int update_local_ref(struct ref *ref,
     -				   remote_ref->name, ref->name,
     -				   &ref->old_oid, &ref->new_oid, summary_width);
     +
    -+		info = ref_update_display_info_append(display_list, display_count,
    -+						      '*', '!', what, NULL,
    ++		info = ref_update_display_info_append(display_array, '*', '!',
    ++						      what, NULL,
     +						      _("unable to update local ref"),
     +						      ref->name, remote_ref->name,
     +						      &ref->old_oid, &ref->new_oid);
    @@ builtin/fetch.c: static int update_local_ref(struct ref *ref,
     -				   remote_ref->name, ref->name,
     -				   &ref->old_oid, &ref->new_oid, summary_width);
     +
    -+		info = ref_update_display_info_append(display_list, display_count,
    -+						      ' ', '!', quickref.buf, NULL,
    ++		info = ref_update_display_info_append(display_array, ' ', '!',
    ++						      quickref.buf, NULL,
     +						      _("unable to update local ref"),
     +						      ref->name, remote_ref->name,
     +						      &ref->old_oid, &ref->new_oid);
    @@ builtin/fetch.c: static int update_local_ref(struct ref *ref,
     -				   remote_ref->name, ref->name,
     -				   &ref->old_oid, &ref->new_oid, summary_width);
     +
    -+		info = ref_update_display_info_append(display_list, display_count,
    -+						      '+', '!', quickref.buf, _("forced update"),
    ++		info = ref_update_display_info_append(display_array, '+', '!',
    ++						      quickref.buf, _("forced update"),
     +						      _("unable to update local ref"),
     +						      ref->name, remote_ref->name,
     +						      &ref->old_oid, &ref->new_oid);
    @@ builtin/fetch.c: static int update_local_ref(struct ref *ref,
     -				   remote_ref->name, ref->name,
     -				   &ref->old_oid, &ref->new_oid, summary_width);
     +		struct ref_update_display_info *info;
    -+		info = ref_update_display_info_append(display_list, display_count,
    -+						      '!', '!', _("[rejected]"), NULL,
    ++		info = ref_update_display_info_append(display_array, '!', '!',
    ++						      _("[rejected]"), NULL,
     +						      _("non-fast-forward"),
     +						      ref->name, remote_ref->name,
     +						      &ref->old_oid, &ref->new_oid);
    @@ builtin/fetch.c: static int store_updated_refs(struct display_state *display_sta
      			      struct fetch_head *fetch_head,
     -			      const struct fetch_config *config)
     +			      const struct fetch_config *config,
    -+			      struct ref_update_display_info **display_list,
    -+			      size_t *display_count)
    ++			      struct ref_update_display_info_array *display_array)
      {
      	int rc = 0;
      	struct strbuf note = STRBUF_INIT;
    @@ builtin/fetch.c: static int store_updated_refs(struct display_state *display_sta
     -				rc |= update_local_ref(ref, transaction, display_state,
     -						       rm, summary_width, config);
     +				rc |= update_local_ref(ref, transaction, rm,
    -+						       config, display_list,
    -+						       display_count);
    ++						       config, display_array);
      				free(ref);
      			} else if (write_fetch_head || dry_run) {
      				/*
    @@ builtin/fetch.c: static int store_updated_refs(struct display_state *display_sta
     -						   &rm->new_oid, &rm->old_oid,
     -						   summary_width);
     +
    -+				ref_update_display_info_append(display_list, display_count,
    -+							       '*', '*', *kind ? kind : "branch",
    -+							       NULL, NULL, "FETCH_HEAD", rm->name,
    -+							       &rm->new_oid, &rm->old_oid);
    ++				ref_update_display_info_append(display_array, '*', '*',
    ++							       *kind ? kind : "branch",
    ++							       NULL, NULL, "FETCH_HEAD",
    ++							       rm->name, &rm->new_oid,
    ++							       &rm->old_oid);
      			}
      		}
      	}
    @@ builtin/fetch.c: static int fetch_and_consume_refs(struct display_state *display
      				  struct fetch_head *fetch_head,
     -				  const struct fetch_config *config)
     +				  const struct fetch_config *config,
    -+				  struct ref_update_display_info **display_list,
    -+				  size_t *display_count)
    ++				  struct ref_update_display_info_array *display_array)
      {
      	int connectivity_checked = 1;
      	int ret;
    @@ builtin/fetch.c: static int fetch_and_consume_refs(struct display_state *display
      	ret = store_updated_refs(display_state, connectivity_checked,
     -				 transaction, ref_map, fetch_head, config);
     +				 transaction, ref_map, fetch_head, config,
    -+				 display_list, display_count);
    ++				 display_array);
      	trace2_region_leave("fetch", "consume_refs", the_repository);
      
      out:
    @@ builtin/fetch.c: static int backfill_tags(struct display_state *display_state,
      			 struct fetch_head *fetch_head,
     -			 const struct fetch_config *config)
     +			 const struct fetch_config *config,
    -+			 struct ref_update_display_info **display_list,
    -+			 size_t *display_count)
    ++			 struct ref_update_display_info_array *display_array)
      {
      	int retcode, cannot_reuse;
      
    @@ builtin/fetch.c: static int backfill_tags(struct display_state *display_state,
      	transport_set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, NULL);
      	retcode = fetch_and_consume_refs(display_state, transport, transaction, ref_map,
     -					 fetch_head, config);
    -+					 fetch_head, config, display_list, display_count);
    ++					 fetch_head, config, display_array);
      
      	if (gsecondary) {
      		transport_disconnect(gsecondary);
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
      	struct fetch_head fetch_head = { 0 };
      	struct strbuf err = STRBUF_INIT;
      	int do_set_head = 0;
    -+	struct ref_update_display_info *display_list = NULL;
    ++	struct ref_update_display_info_array display_array = { 0 };
     +	struct strmap rejected_refs = STRMAP_INIT;
    -+	size_t display_count = 0;
     +	int summary_width = 0;
      
      	if (tags == TAGS_DEFAULT) {
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
      
      	if (fetch_and_consume_refs(&display_state, transport, transaction, ref_map,
     -				   &fetch_head, config)) {
    -+				   &fetch_head, config, &display_list, &display_count)) {
    ++				   &fetch_head, config, &display_array)) {
      		retcode = 1;
      		goto cleanup;
      	}
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
      			 */
      			if (backfill_tags(&display_state, transport, transaction, tags_ref_map,
     -					  &fetch_head, config))
    -+					  &fetch_head, config, &display_list, &display_count))
    ++					  &fetch_head, config, &display_array))
      				retcode = 1;
      		}
      
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
     +				       transport->remote->name,
     +				       &rejected_refs, &err);
     +
    -+	for (size_t i = 0; i < display_count; i++) {
    -+		struct ref_update_display_info *info = &display_list[i];
    ++	for (size_t i = 0; i < display_array.nr; i++) {
    ++		struct ref_update_display_info *info = &display_array.info[i];
     +
     +		if (!info->failed && strmap_contains(&rejected_refs, info->ref))
     +			ref_update_display_info_set_failed(info);
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
      	if (transaction)
      		ref_transaction_free(transaction);
     +
    -+	free(display_list);
    ++	free(display_array.info);
     +	strmap_clear(&rejected_refs, 0);
      	display_state_release(&display_state);
      	close_fetch_head(&fetch_head);


base-commit: 8745eae506f700657882b9e32b2aa00f234a6fb6
change-id: 20260113-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-17786b20894a

Thanks
- Karthik


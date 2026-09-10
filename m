Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA0137E5FA
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 15:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052966; cv=none; b=cgUQ1niCvZd2JJjSUap+rd0yCIT5rBZMX0o10AcfqNmtjkCcEOM8ULpanpeU5/ilmTMuPPHkFu95h2TKQoSTv+1SmNLPARVQsLeBmpxVsDPgO/sG7PJKvYmhv3HAN2JrjCH9jlss2K8Z+pt4L1KcvEVUrX8I6K6QTwvGXRyVrkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052966; c=relaxed/simple;
	bh=0BFJ7GO9tq87vUisHQ2XGXulu0BNtv/+AzLrUbB4FCY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=KBrcth7U/80WFtcFzJ9oDm/Ex4pyWVf1CKhEQX3+ZcWuerRITR8Rw/vDWrTnFiVt/vHHbM33eBg4ubuEDpbdGkmjgRH31hr0qUde6pwJV6OyZyFfRniW6crldcMK+GF5JIHYQTo3zdOt9Q8qCb6Qpk7kGhAp5FJX1OZflQMApY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YEyuw7LB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vxi1qKqf; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YEyuw7LB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vxi1qKqf"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3CFBB14000B0;
	Thu, 10 Sep 2026 11:09:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 10 Sep 2026 11:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789052958;
	 x=1789139358; bh=NVMFrFyU1ggquzPSMGQlg6OcrxGq5xa0bfqrj7Z4tRk=; b=
	YEyuw7LBKSgFwjqrcilgV7SKjWl8VuC5/+s3O0rIlTdIm0zN2Qzc3ltDU0T7vEK7
	cpm9/MWDfDHo/3xl9m8yfZxScU05sXni0AXvb9Z/kB7dzhgLuH33sa+Xrux+fX89
	rWm93eU2g67pynRqCJGCd5Rl0qKYsqYxZcI8zEIAbtPeHRtOVkhkDjJCJuhoyKRk
	Is6TjqbM+iLb+I2VEM7VLfosJec2EXUh1smLe0k5Q3SGFNux/TZ2UOg+XPeN6YcZ
	NCmVAqrF5LCWn3q8DDPg2twQxcmWiGr8w16cThIwegWZ/6fk0OlvSIUpCNpaam/6
	5qhaVdGTsCIVzJkgMjZuRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789052958; x=
	1789139358; bh=NVMFrFyU1ggquzPSMGQlg6OcrxGq5xa0bfqrj7Z4tRk=; b=v
	xi1qKqfYgWe/dtrKTd1qOtuTsJ1YDkwD49hfIPWn9m84argGwi4lEFasRSZtYzx5
	/sw2ei+M62YUQWxct62KfnIzix2z/1joqm7REtH2w5ozxWvpEXO9Y+I7J+Xz0xr4
	Bgrskm0BS8Ld4k1/wZ5lhVCCq/+KysYF44prPKJo4k1ucajkZGT4qIryy/pf1vM9
	nve4v95DtgqzqUPfJtFFKRdFYn4AYGhWlsr/g68ip8hCDXexaBWs6jojTm2x+U/z
	pXqnHPPptoVPMylEtLRsWB42ZRIxC1XmYfVT4Zb4XytmECQUpdlNxsxDF5Hk1ouW
	cuBuDttZ1+JOIj+dYYdpw==
X-ME-Sender: <xms:HciiarQ490qq5vC970VfPUZYx3P1gbw9fwwX87RWWtB7KhU0uoFnRA>
    <xme:HciiajrDUYFp5f9pBcIkWFtIVmQTxbwOUqwYh0bdDf__1W0zQpOgJqQPsFXTqDxjv
    5l2Q2BMPSfhOfzpX-M9BPd7aq9cVBxkEWMe8v_-a1HZFEAaza83>
X-ME-Received: <xmr:HciiapLOwG2puaqQcekfEYCHXSC_oCxfvnM2VebYCpKOvXcA7WiQ1A>
X-ME-Proxy-Cause: dmFkZTGN6xSUBaqNR640g2ilb75Gvn9aJSM8YQ5fp9pLqmx8snJf/Lv7Omo1HbWNNsJVA7
    HQnrz2utIwFrW5DRf0tsJI9cGmsxetiRbEs78t3KETq10sBHfAxOvhG6rKOsbKKFpwMDc5
    hSana6MKB7Dl7z7MdzeXUusXRVipLi9CEf/7tCuaAKUG9eK3fNfKsMghAP/kmhS3Uwxefe
    3EFFyCjorl44klox7aYhOR+H1NNSHHYlRcPnxnr9J19uwA6YYDKH1YvQ2xE5BM1YIQrGWF
    tbW9AhFky5Ke3d7qkHy28v6IK9hqg9aI1Q61TmA223X10t9ylnO7UTWVwAtNvoTTeFBoQp
    vOFYetTH076/CtKCDeEwBuF0WXO1PBjhn2CGDa8ut79GSSNQnYlmvF0DhZbE0A/id6+9H0
    Dxlh0Gohvluci2Ga8tQjC82eT3qMKwo/WeLLRELzLeGEI6xq5L2sILh6imoyMXqvqZxu+o
    +1pWWL3jFh6CnSgXDVJ9s2MRQR1XbHl70UyHRV8qVaDmeRpT0SCUDlghwhm/y/T2AY0Fzc
    WI5um9KCwOq8fie/M0/ExAPk/TpOrDfT09Ws5Qn9JD9Fg8HuRYOyxnqXQxRRZP6Woxd6TZ
    qpawXXAEteM8HZLdQNzSYlHNcbtV61P8ECojABMlZB2S8E9dSKAaIlvoWd0Q
X-ME-Proxy: <xmx:HciiampK6IQftLIP_OW65IygeowNuqmfMTsOg-82TuuaVFHBnFZLxQ>
    <xmx:HciiahyokAQG3uVIaRUr9r1vaOlDYps3SBLIh2e5kNTIBWeGgooR1w>
    <xmx:HciiaqMVbS7Zfdu9qZiulLLwxxBI_mAESj9GsnJPYBxRaHKJFQAP-g>
    <xmx:Hciiam7wX2j6ripvgYh_hEZmmXMozc2OwbBaY9bTejBmiLTnjNiLSg>
    <xmx:HsiiasE6f-1Kgk1nZKDp3Bm9rcI4mkKOKSwb8OMJs6wUKIFz1pHlzoEd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 11:09:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5a865c55 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 10 Sep 2026 15:09:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 0/9] odb: write alternates at creation time
Date: Thu, 10 Sep 2026 17:09:10 +0200
Message-Id: <20260910-pks-odb-write-alternates-at-creation-time-v5-0-8d10c4238edc@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XOTU7DMBCG4atUXjNo/NckXXEP1MXYnlADTSrbD
 aAqd8cpCNpllp80fl5fROYUOYvd5iISTzHHcajDPmyEP9DwwhBD3UKh2mIrNZzeMozBwUeKhYH
 eC6eBCmegAj4xlQpAiUeGrUGJgV1nCEX1Ton7+HltPe9/dj67V/ZlCSwXh5jLmL6un5nkcvfbV
 XZFd5KA0ElppXbUWa+f6tvHeBRLdFI3rJZrWFVZYh+UbpUj6e9Y/c922KxhdWUbbQM66zQj3rH
 mlu3WsKayoaWm7XuvFZs/dp7nbyLWRWL2AQAA
X-Change-ID: 20260813-pks-odb-write-alternates-at-creation-time-64010deb94a0
In-Reply-To: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
References: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

Hi,

writing alternates into the object database currently happens via
`odb_source_write_alternate()`. But while that creates the ability to
create alternates at arbitrary points of a source's lifetime, we don't
use that functionality in the first place. Instead, we only ever write
alternates when creating a new repository.

This design is suboptimal due to a couple of reasons:

  - It requires us to have a `write_alternates()` callback, which is
    overblown as we never even write alternates to an object database
    after it has been created.

  - We're about to make alternates an implementation detail of the
    object database's backend in a future patch series, so alternate
    implementations may not even support them.

  - The backend has more flexibility with how exactly alternates are
    configured when it itself is in full control over their setup at the
    time where it creates the object database itself.

This patch series thus refactors how we handle alternates so that we
don't write them ad-hoc anymore. Instead, the series introduces a new
option for `odb_source_create_on_disk()` that makes it handle those
alternates at creation time.

This is part of the bigger goal of moving handling of alternates into
the "files" backend.

This series is built on top of 2c3adbb2c4 (The 18th batch, 2026-08-24)
with ps/odb-eagerly-load-alternates at 0076dc9f81 (odb: drop
`alternates_db` field, 2026-08-17) merged into it.

Changes in v5:
  - Rename `add_one_alternate` and `add_one_alternate_data` to
    `collect_one_alternate` and `collect_alternates_data` to clarify
    their intent a bit.
  - Drop extra parameter in `collect_alternates()`.
  - Clarify why we compute `commondir` even though it's unused.
  - Link to v4: https://patch.msgid.link/20260909-pks-odb-write-alternates-at-creation-time-v4-0-d8a78ffc32e4@pks.im

Changes in v4:
  - Add documentation for the different functions that play a role in
    creating repositories.
  - Link to v3: https://patch.msgid.link/20260907-pks-odb-write-alternates-at-creation-time-v3-0-735d0b5b3e00@pks.im

Changes in v3:
  - Refactor `init_db()` to not create the reference and object database
    at all anymore. Instead, it's now called `create_repository()` and
    it is responsible for creating the initial repository skeleton,
    only. This allows us to get rid of the flags and overall makes the
    logic more straight-forward by moving the command-specific logic
    into the respective commands.
  - A couple of typo fixes.
  - Link to v2: https://patch.msgid.link/20260831-pks-odb-write-alternates-at-creation-time-v2-0-aecd2382ba1c@pks.im

Changes in v2:
  - Use a lockfile to write "info/alternates" during creation time.
  - Remove useless "strvec.h" include by reordering declarations a bit.
  - Link to v1: https://patch.msgid.link/20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (9):
      setup: split up concerns of `init_db()`
      builtin/clone: defer setup of the object database
      builtin/clone: move around `setup_reference()`
      builtin/clone: refactor handling of "--reference{,-if-able}"
      builtin/clone: move setup of alternates for shared local clones
      builtin/clone: move setup of alternates for non-shared local clones
      odb/source: support writing alternates when creating the database
      builtin/clone: write alternates via `odb_create_on_disk()`
      odb/source: remove the ability to write alternates

 builtin/clone.c            | 111 +++++++++++++++++++++++---------------
 builtin/init-db.c          |  32 ++++++++---
 odb.c                      |   9 ----
 odb.h                      |   7 ---
 odb/source-files.c         | 130 ++++++++++++++++++++++++++-------------------
 odb/source-inmemory.c      |   7 ---
 odb/source-loose.c         |   7 ---
 odb/source-packed.c        |   7 ---
 odb/source.h               |  43 +++++----------
 setup.c                    |  61 ++++++++-------------
 setup.h                    |  47 +++++++++++-----
 t/t5604-clone-reference.sh |  25 +++++++++
 12 files changed, 264 insertions(+), 222 deletions(-)

Range-diff versus v4:

 1:  30a1faa807 =  1:  e5d789fdfa setup: split up concerns of `init_db()`
 2:  7a646ebe92 !  2:  94a19390b4 builtin/clone: defer setup of the object database
    @@ Commit message
         namely alternates. When initializing the object database we do not yet
         know whether we'll need alternates or not because this depends on the
         repository we're about to clone from. If it is a local repository and
    -    the user has passed "--refernce{,-if-able}", then we will end up writing
    -    alternates into the object database.
    +    the user has passed "--reference{,-if-able}", then we will end up
    +    writing alternates into the object database.
     
         The ugly part though is that we cannot determine where the repository is
         getting cloned from before it has been initialized. While we of course
 3:  af77d0e9e3 =  3:  e9ccb5b1bd builtin/clone: move around `setup_reference()`
 4:  2ca937bce1 !  4:  30c4933fb0 builtin/clone: refactor handling of "--reference{,-if-able}"
    @@ Commit message
         the alternates into it one by one.
     
         Prepare for this refactoring by collecting the alternates into a strvec.
    -    Rename the function to `collect_alternates()` to clarify its scope.
    +    Rename the function to `collect_alternates()` to clarify its scope, as
    +    it does not set up the references itself anymore.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ builtin/clone.c: static char *get_repo_path(const char *repo, int *is_bundle)
      }
      
     -static int add_one_reference(struct string_list_item *item, void *cb_data)
    -+struct add_one_alternate_data {
    ++struct collect_alternates_data {
     +	struct strvec *alternates;
    -+	int required;
    ++	bool required;
     +};
     +
    -+static int add_one_alternate(struct string_list_item *item, void *cb_data)
    ++static int collect_one_alternate(struct string_list_item *item, void *cb_data)
      {
    -+	struct add_one_alternate_data *data = cb_data;
    ++	struct collect_alternates_data *data = cb_data;
      	struct strbuf err = STRBUF_INIT;
     -	int *required = cb_data;
      	char *ref_git = compute_alternate_path(item->string, &err);
    @@ builtin/clone.c: static void copy_alternates(struct strbuf *src, const char *src
     -	for_each_string_list(&option_optional_reference,
     -			     add_one_reference, &required);
     +	if (option_required_reference.nr || option_optional_reference.nr) {
    -+		struct add_one_alternate_data data = {
    ++		struct collect_alternates_data data = {
     +			.alternates = alternates,
    -+			.required = 1,
    ++			.required = true,
     +		};
     +
     +		for_each_string_list(&option_required_reference,
    -+				     add_one_alternate, &data);
    -+		data.required = 0;
    ++				     collect_one_alternate, &data);
    ++		data.required = false;
     +		for_each_string_list(&option_optional_reference,
    -+				     add_one_alternate, &data);
    ++				     collect_one_alternate, &data);
     +	}
      }
      
 5:  4ba60fc24b !  5:  5141c179e2 builtin/clone: move setup of alternates for shared local clones
    @@ Commit message
     
         Note that the logic for cloning a local repository with "--no-shared" is
         not yet part of `collect_alternates()`. This will be handled in the next
    -    commit.
    +    commit, but means that at this step, we may compute `commondir` without
    +    it being used. It will become used in the next step though.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ builtin/clone.c: static void copy_alternates(struct strbuf *src, const char *src
      
     -static void collect_alternates(struct strvec *alternates)
     +static void collect_alternates(struct strvec *alternates,
    -+			       const char *src_repo, bool is_local)
    ++			       const char *local_source_repo)
      {
      	if (option_required_reference.nr || option_optional_reference.nr) {
    - 		struct add_one_alternate_data data = {
    + 		struct collect_alternates_data data = {
     @@ builtin/clone.c: static void collect_alternates(struct strvec *alternates)
      		for_each_string_list(&option_optional_reference,
    - 				     add_one_alternate, &data);
    + 				     collect_one_alternate, &data);
      	}
     +
    -+	if (is_local) {
    ++	if (local_source_repo) {
     +		struct strbuf commondir = STRBUF_INIT;
     +
    -+		get_common_dir(&commondir, src_repo);
    ++		get_common_dir(&commondir, local_source_repo);
     +		if (option_shared)
     +			strvec_pushf(alternates, "%s/objects", commondir.buf);
     +
    @@ builtin/clone.c: int cmd_clone(int argc,
      
      	create_object_database(the_repository);
     -	collect_alternates(&alternates);
    -+	collect_alternates(&alternates, path, is_local);
    ++	collect_alternates(&alternates, is_local ? path : NULL);
      
      	for (size_t i = 0; i < alternates.nr; i++)
      		odb_add_to_alternates_file(the_repository->objects, alternates.v[i]);
 6:  4f3c8fb936 !  6:  b0ed987d1c builtin/clone: move setup of alternates for non-shared local clones
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## builtin/clone.c ##
    -@@ builtin/clone.c: static int add_one_alternate(struct string_list_item *item, void *cb_data)
    +@@ builtin/clone.c: static int collect_one_alternate(struct string_list_item *item, void *cb_data)
      	return 0;
      }
      
    @@ builtin/clone.c: static void copy_alternates(struct strbuf *src, const char *src
      
      static void collect_alternates(struct strvec *alternates,
     @@ builtin/clone.c: static void collect_alternates(struct strvec *alternates,
    - 		get_common_dir(&commondir, src_repo);
    + 		get_common_dir(&commondir, local_source_repo);
      		if (option_shared)
      			strvec_pushf(alternates, "%s/objects", commondir.buf);
     +		else
 7:  47548ac464 =  7:  4cc70ca1dd odb/source: support writing alternates when creating the database
 8:  4e3be623dd !  8:  2cea0312bd builtin/clone: write alternates via `odb_create_on_disk()`
    @@ builtin/clone.c: int cmd_clone(int argc,
      		warning(_("--local is ignored"));
      
     -	create_object_database(the_repository);
    - 	collect_alternates(&alternates, path, is_local);
    + 	collect_alternates(&alternates, is_local ? path : NULL);
     -
     -	for (size_t i = 0; i < alternates.nr; i++)
     -		odb_add_to_alternates_file(the_repository->objects, alternates.v[i]);
 9:  7207b7e2ed =  9:  e1f8f728a6 odb/source: remove the ability to write alternates

---
base-commit: afa255aeb620346d56a2c01fb5ae9163513c56d7
change-id: 20260813-pks-odb-write-alternates-at-creation-time-64010deb94a0


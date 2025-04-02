Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096B1238147
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 11:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743592424; cv=none; b=YLWKEC7ujcVWJBpKLNinsylEa+Wf5+356m/A/fQNgF+PfC7SBD1O73aNtQzgA7B3CWaXRRJ2WG84PQ2l/qnrANxWhvLip78ao+pvOG9JtWen3PqPH/wsbZIAlGUB4usn9NC9XolU9KXasoREi1VuxbHG81yUqjmuEgPCCkccx4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743592424; c=relaxed/simple;
	bh=z6RSskg3mZhiREExvt15XPIOPGprodLtz6qlPkYil44=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=GOD1DGGCiSSSjsYV17pzYV1YajYd6wRsnUBOWCBUad5zDyOb6XmWGycSedWLEBWq+CkXs7xS7hBCTCk0xY+JZdECNKpfI70P4XwP7tqEE9RGEB/GVjKAUttDv4EOpCZcyUxYlyox0I/ysZFys17B9gGbPH5qDaiIloIpXe0ClTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rwD6q5rF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QLy0KPjC; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rwD6q5rF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QLy0KPjC"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0FBE725400EE;
	Wed,  2 Apr 2025 07:13:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 02 Apr 2025 07:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743592420;
	 x=1743678820; bh=TH61mgyRZtT4BCVr2EW4bTvw69hteUc7HUwSk4r94YU=; b=
	rwD6q5rFu1T9M238XSnY1eRi03zvYgA1h02n9KzfQxLMgb0j+nPz1QwtAtJQ4II3
	X/Fu0vSHm9csPe3BS0U/Yxpy9FhgHeGu4K28e4g/8uv3oQ6mPEG7xM6OADmgh3lt
	TBjCW8WNsWXctHvdJeRTWK9BGljPdhgii5wMf/RbBVmaYr3HvBXQS7oUYYoaoFSE
	8XSQG/d71A/qOulyf1mgpUeER3zWHIUHPQpzimv4qmKqq7PDP4qGOwBSfjWU97aD
	n7SpE/odlMWtewRxFnk2DE6A30/KFdWjyw9v+pO3fy8g9L63xFMYX3xRBpGCm4VU
	ACOnqnUQqMn+78raS53SsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743592420; x=
	1743678820; bh=TH61mgyRZtT4BCVr2EW4bTvw69hteUc7HUwSk4r94YU=; b=Q
	Ly0KPjC0ZV8sW/3PnSzTkF2EASrSNEC0sjsnOuDAfpruQQcPeLCbMcBmEz0wVnkG
	oTUavjD2Vfghbm5GIPGdgcW8M8rVmmJ0Usu6UKZwL1tQLubqr9YONCt5sH6UAM46
	ENxNDPDdSKmAS+8xM5pBZDk39R53+90j6GXRTAFw31dNDRRmQCkdzi1/cVjnvBFo
	Bo8teVr80Lxo+uULieKNObQ/PL9PUIQvt4vNGzYydFEvsHSytddHmLxQNpFax0Ni
	MRc8e7/JjKuFA+dPJ23RLSj1hMyscm3YEClHC6Llqpg9ADLZ5UPHOogP5LmGgTEV
	wnxhZKn6UrJSq4eHicskw==
X-ME-Sender: <xms:5BvtZ7P9KLCFCFen5KT_Auo6TN7HfynO7jllnv0Clz1MDtZcbWUB_g>
    <xme:5BvtZ1_zXDhA0LbLf6M71NYpK1H3xlTkvBT6sVuc3xGjsm9MuAnPx0RA46SmI5UyH
    0-IYhcIFTTINpZ76g>
X-ME-Received: <xmr:5BvtZ6RRLzfZ5kNmQV4f1BfkBkWOJ8ok1rCTnJP7FwHgAig73fkp-xPDguqAt13yknyswfZ7VBu_B0YPlkBpKlssyF-L5Tnp1t-mGi5rjWCN8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtkeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeehtddufeehvefhffeileeitdevveehieffieeg
    jeekvefftddvleelffegueehleenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgih
    hthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghp
    thhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:5BvtZ_uGksJ7mBQTPka25RjJwadBiByPim844DOaTNJFE6Gf_iPZpw>
    <xmx:5BvtZze_UNOEJhUxdXnldVG-GL-AnPsSPQa70Atv2kgUJgPTz_NAtw>
    <xmx:5BvtZ71wx_7hzozake5D8OV7XWsVEEUkFP5JIyMu529vZPF3OF13EA>
    <xmx:5BvtZ_9fDvHKJjU8jRQP09DJ4GOailP3Twa2S6ij5zoLtQK169iFOg>
    <xmx:5BvtZ3-VDLDIsiSsuFUb9OyMIrlK4HNlMVJg2lfUyoJ3KISnOUhAbbpK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 07:13:39 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a86fdd5d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Apr 2025 11:13:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/11] builtin/cat-file: allow filtering objects in
 batch mode
Date: Wed, 02 Apr 2025 13:13:35 +0200
Message-Id: <20250402-pks-cat-file-object-type-filter-v3-0-4da6bb21871c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOAb7WcC/4XNzQ6CMBAE4FcxPbtmu9BQPfkexgOUReoPkLZpJ
 IR3t5CoR44zyXwzCc/Oshen3SQcR+tt36WQ7XfCtGV3Y7B1yoKQFBIhDA8PpgzQ2CdDX93ZBAj
 jwEsR2MFR5miQa8UsRVIGx419rw+Xa8qt9aF343oY5dJ+bblpRwkIqBWpDLXWTOe0ONiXWOBIf
 yyjYhujhOVVZYok1oVRP2ye5w/VodpGGAEAAA==
X-Change-ID: 20250220-pks-cat-file-object-type-filter-9140c0ed5ee1
In-Reply-To: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
References: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Hi,

at GitLab, we sometimes have the need to list all objects regardless of
their reachability. We use git-cat-file(1) with `--batch-all-objects` to
do this, and typically this is quite a good fit. In some cases though,
we only want to list objects of a specific type, where we then basically
have the following pipeline:

    git cat-file --batch-all-objects --batch-check='%(objecttype) %(objectname)' |
    grep '^commit ' |
    cut -d' ' -f2 |
    git cat-file --batch

This works okayish in medium-sized repositories, but once you reach a
certain size this isn't really an option anymore. In the Chromium
repository for example [1] simply listing all objects in the first
invocation of git-cat-file(1) takes around 80 to 100 seconds. The
workload is completely I/O-bottlenecked: my machine reads at ~500MB/s,
and the packfile is 50GB in size, which matches the 100 seconds that I
observe.

This series addresses the issue by introducing object filters into
git-cat-file(1). These object filters use the exact same syntax as the
filters we have in git-rev-list(1), but only a subset of them is
supported because not all filters can be computed by git-cat-file(1).
Supported are "blob:none", "blob:limit=" as well as "object:type=".

The filters alone don't really help though: we still have to scan
through the whole packfile in order to compute the packfiles. While we
are able to shed a bit of CPU time because we can stop emitting some of
the objects, we're still I/O-bottlenecked.

The second part of the series thus expands the filters so that they can
make use of bitmap indices for some of the filters, if available. This
allows us to efficiently answer the question where to find all objects
of a specific type, and thus we can avoid scanning through the packfile
and instead directly look up relevant objects, leading to a significant
speedup:

    Benchmark 1: cat-file with filter=object:type=commit (revision = HEAD~)
      Time (mean ± σ):     86.444 s ±  4.081 s    [User: 36.830 s, System: 11.312 s]
      Range (min … max):   80.305 s … 93.104 s    10 runs

    Benchmark 2: cat-file with filter=object:type=commit (revision = HEAD)
      Time (mean ± σ):      2.089 s ±  0.015 s    [User: 1.872 s, System: 0.207 s]
      Range (min … max):    2.073 s …  2.119 s    10 runs

    Summary
      cat-file with filter=object:type=commit (revision = HEAD) ran
       41.38 ± 1.98 times faster than cat-file with filter=object:type=commit (revision = HEAD~)

We now directly scale with the number of objects of a specific type
contained in the packfile instead of scaling with the overall number of
objects. It's quite fun to see how the math plays out: if you sum up the
times for each of the types you arrive at the time for the unfiltered
case.

Changes in v2:
  - The series is now built on top of "master" at 683c54c999c (Git 2.49,
    2025-03-14) with "tb/incremental-midx-part-2" at 27afc272c49 (midx:
    implement writing incremental MIDX bitmaps, 2025-03-20) merged into
    it.
  - Rename the filter options to "--filter=" to match
    git-pack-objects(1).
  - The bitmap-filtering is now reusing existing mechanisms that we
    already have in "pack-bitmap.c", as proposed by Taylor.
  - Link to v1: https://lore.kernel.org/r/20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im

Changes in v3:
  - Wrap some overly long lines.
  - Better describe how filters interact with the different batch modes.
  - Adapt the format with `--batch` and `--batch-check` so that we tell
    the user that the object has been excluded.
  - Add a test for "--no-filter".
  - Use `OPT_PARSE_LIST_OBJECTS_FILTER()`.
  - Link to v2: https://lore.kernel.org/r/20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im

Thanks!

Patrick

[1]: https://github.com/chromium/chromium.git

---
Patrick Steinhardt (11):
      builtin/cat-file: rename variable that tracks usage
      builtin/cat-file: introduce function to report object status
      builtin/cat-file: wire up an option to filter objects
      builtin/cat-file: support "blob:none" objects filter
      builtin/cat-file: support "blob:limit=" objects filter
      builtin/cat-file: support "object:type=" objects filter
      pack-bitmap: allow passing payloads to `show_reachable_fn()`
      pack-bitmap: add function to iterate over filtered bitmapped objects
      pack-bitmap: introduce function to check whether a pack is bitmapped
      builtin/cat-file: deduplicate logic to iterate over all objects
      builtin/cat-file: use bitmaps to efficiently filter by object type

 Documentation/git-cat-file.adoc |  26 ++++
 builtin/cat-file.c              | 256 +++++++++++++++++++++++++++++-----------
 builtin/pack-objects.c          |   3 +-
 builtin/rev-list.c              |   3 +-
 pack-bitmap.c                   |  81 +++++++++++--
 pack-bitmap.h                   |  22 +++-
 reachable.c                     |   3 +-
 t/t1006-cat-file.sh             |  99 ++++++++++++++++
 8 files changed, 411 insertions(+), 82 deletions(-)

Range-diff versus v2:

 1:  a75888e0bf4 !  1:  b0642b6c495 builtin/cat-file: rename variable that tracks usage
    @@ builtin/cat-file.c: int cmd_cat_file(int argc,
      		;
      	else if (batch.follow_symlinks)
     -		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
    -+		usage_msg_optf(_("'%s' requires a batch mode"), builtin_catfile_usage, options,
    - 			       "--follow-symlinks");
    +-			       "--follow-symlinks");
    ++		usage_msg_optf(_("'%s' requires a batch mode"), builtin_catfile_usage,
    ++			       options, "--follow-symlinks");
      	else if (batch.buffer_output >= 0)
     -		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
    -+		usage_msg_optf(_("'%s' requires a batch mode"), builtin_catfile_usage, options,
    - 			       "--buffer");
    +-			       "--buffer");
    ++		usage_msg_optf(_("'%s' requires a batch mode"), builtin_catfile_usage,
    ++			       options, "--buffer");
      	else if (batch.all_objects)
     -		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
    -+		usage_msg_optf(_("'%s' requires a batch mode"), builtin_catfile_usage, options,
    - 			       "--batch-all-objects");
    +-			       "--batch-all-objects");
    ++		usage_msg_optf(_("'%s' requires a batch mode"), builtin_catfile_usage,
    ++			       options, "--batch-all-objects");
      	else if (input_nul_terminated)
     -		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
    -+		usage_msg_optf(_("'%s' requires a batch mode"), builtin_catfile_usage, options,
    - 			       "-z");
    +-			       "-z");
    ++		usage_msg_optf(_("'%s' requires a batch mode"), builtin_catfile_usage,
    ++			       options, "-z");
      	else if (nul_terminated)
     -		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
    -+		usage_msg_optf(_("'%s' requires a batch mode"), builtin_catfile_usage, options,
    - 			       "-Z");
    +-			       "-Z");
    ++		usage_msg_optf(_("'%s' requires a batch mode"), builtin_catfile_usage,
    ++			       options, "-Z");
      
      	batch.input_delim = batch.output_delim = '\n';
    + 	if (input_nul_terminated)
     @@ builtin/cat-file.c: int cmd_cat_file(int argc,
      			batch.transform_mode = opt;
      		else if (opt && opt != 'b')
    @@ builtin/cat-file.c: int cmd_cat_file(int argc,
     +				       builtin_catfile_usage, options, opt);
      		else if (argc)
     -			usage_msg_opt(_("batch modes take no arguments"), usage,
    -+			usage_msg_opt(_("batch modes take no arguments"), builtin_catfile_usage,
    - 				      options);
    +-				      options);
    ++			usage_msg_opt(_("batch modes take no arguments"),
    ++				      builtin_catfile_usage, options);
      
      		return batch_objects(&batch);
    + 	}
     @@ builtin/cat-file.c: int cmd_cat_file(int argc,
      	if (opt) {
      		if (!argc && opt == 'c')
      			usage_msg_optf(_("<rev> required with '%s'"),
     -				       usage, options, "--textconv");
    -+				       builtin_catfile_usage, options, "--textconv");
    ++				       builtin_catfile_usage, options,
    ++				       "--textconv");
      		else if (!argc && opt == 'w')
      			usage_msg_optf(_("<rev> required with '%s'"),
     -				       usage, options, "--filters");
    -+				       builtin_catfile_usage, options, "--filters");
    ++				       builtin_catfile_usage, options,
    ++				       "--filters");
      		else if (!argc && opt_epts)
      			usage_msg_optf(_("<object> required with '-%c'"),
     -				       usage, options, opt);
    @@ builtin/cat-file.c: int cmd_cat_file(int argc,
      			obj_name = argv[0];
      		else
     -			usage_msg_opt(_("too many arguments"), usage, options);
    -+			usage_msg_opt(_("too many arguments"), builtin_catfile_usage, options);
    ++			usage_msg_opt(_("too many arguments"), builtin_catfile_usage,
    ++				      options);
      	} else if (!argc) {
     -		usage_with_options(usage, options);
     +		usage_with_options(builtin_catfile_usage, options);
 -:  ----------- >  2:  18353ba706d builtin/cat-file: introduce function to report object status
 2:  bee9407c1a9 !  3:  1e46af5d07b builtin/cat-file: wire up an option to filter objects
    @@ Documentation/git-cat-file.adoc: OPTIONS
     +--filter=<filter-spec>::
     +--no-filter::
     +	Omit objects from the list of printed objects. This can only be used in
    -+	combination with one of the batched modes. The '<filter-spec>' may be
    -+	one of the following:
    ++	combination with one of the batched modes. Excluded objects that have
    ++	been explicitly requested via any of the batch modes that read objects
    ++	via standard input (`--batch`, `--batch-check`) will be reported as
    ++	"filtered". Excluded objects in `--batch-all-objects` mode will not be
    ++	printed at all. No filters are supported yet.
     +
      --path=<path>::
      	For use with `--textconv` or `--filters`, to allow specifying an object
      	name and a path separately, e.g. when it is difficult to figure out
    +@@ Documentation/git-cat-file.adoc: the repository, then `cat-file` will ignore any custom format and print:
    + <object> SP missing LF
    + ------------
    + 
    ++If a name is specified on stdin that is filtered out via `--filter=`,
    ++then `cat-file` will ignore any custom format and print:
    ++
    ++------------
    ++<object> SP excluded LF
    ++------------
    ++
    + If a name is specified that might refer to more than one object (an ambiguous short sha), then `cat-file` will ignore any custom format and print:
    + 
    + ------------
     
      ## builtin/cat-file.c ##
     @@
    @@ builtin/cat-file.c: int cmd_cat_file(int argc,
      			    N_("run filters on object's content"), 'w'),
      		OPT_STRING(0, "path", &force_path, N_("blob|tree"),
      			   N_("use a <path> for (--textconv | --filters); Not with 'batch'")),
    -+		OPT_CALLBACK(0, "filter", &batch.objects_filter, N_("args"),
    -+			     N_("object filtering"), opt_parse_list_objects_filter),
    ++		OPT_PARSE_LIST_OBJECTS_FILTER(&batch.objects_filter),
      		OPT_END()
      	};
      
    @@ builtin/cat-file.c: int cmd_cat_file(int argc,
      	if (opt == 'b')
      		batch.all_objects = 1;
     @@ builtin/cat-file.c: int cmd_cat_file(int argc,
    - 			usage_msg_opt(_("batch modes take no arguments"), builtin_catfile_usage,
    - 				      options);
    + 			usage_msg_opt(_("batch modes take no arguments"),
    + 				      builtin_catfile_usage, options);
      
     -		return batch_objects(&batch);
     +		ret = batch_objects(&batch);
    @@ t/t1006-cat-file.sh: test_expect_success PERL '--batch-command info is unbuffere
     +		test_cmp expect err
     +	'
     +done
    ++
    ++test_expect_success 'objects filter: disabled' '
    ++	git -C repo cat-file --batch-check="%(objectname)" --batch-all-objects --no-filter >actual &&
    ++	sort actual >actual.sorted &&
    ++	git -C repo rev-list --objects --no-object-names --all >expect &&
    ++	sort expect >expect.sorted &&
    ++	test_cmp expect.sorted actual.sorted
    ++'
     +
      test_done
 3:  ec1d0c63de6 !  4:  878ae8e2a76 builtin/cat-file: support "blob:none" objects filter
    @@ Commit message
         Implement support for the "blob:none" filter in git-cat-file(1), which
         causes us to omit all blobs.
     
    +    Note that this new filter requires us to read the object type via
    +    `oid_object_info_extended()` in `batch_object_write()`. But as we try to
    +    optimize away reading objects from the database the `data->info.typep`
    +    pointer may not be set. We thus have to adapt the logic to conditionally
    +    set the pointer in cases where the filter is given.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## Documentation/git-cat-file.adoc ##
     @@ Documentation/git-cat-file.adoc: OPTIONS
    - 	Omit objects from the list of printed objects. This can only be used in
    - 	combination with one of the batched modes. The '<filter-spec>' may be
    - 	one of the following:
    + 	been explicitly requested via any of the batch modes that read objects
    + 	via standard input (`--batch`, `--batch-check`) will be reported as
    + 	"filtered". Excluded objects in `--batch-all-objects` mode will not be
    +-	printed at all. No filters are supported yet.
    ++	printed at all. The '<filter-spec>' may be one of the following:
     ++
     +The form '--filter=blob:none' omits all blobs.
      
    @@ builtin/cat-file.c: static void batch_object_write(const char *obj_name,
      		case LOFC_DISABLED:
      			break;
     +		case LOFC_BLOB_NONE:
    -+			if (data->type == OBJ_BLOB)
    ++			if (data->type == OBJ_BLOB) {
    ++				if (!opt->all_objects)
    ++					report_object_status(opt, obj_name,
    ++							     &data->oid, "excluded");
     +				return;
    ++			}
     +			break;
      		default:
      			BUG("unsupported objects filter");
    @@ t/t1006-cat-file.sh: test_expect_success 'objects filter with unknown option' '
      do
      	test_expect_success "objects filter with unsupported option $option" '
      		case "$option" in
    -@@ t/t1006-cat-file.sh: do
    - 	'
    - done
    +@@ t/t1006-cat-file.sh: test_expect_success 'objects filter: disabled' '
    + 	test_cmp expect.sorted actual.sorted
    + '
      
     +test_objects_filter () {
     +	filter="$1"
    @@ t/t1006-cat-file.sh: do
     +		sort expect >expect.sorted &&
     +		test_cmp expect.sorted actual.sorted
     +	'
    ++
    ++	test_expect_success "objects filter prints excluded objects: $filter" '
    ++		# Find all objects that would be excluded by the current filter.
    ++		git -C repo rev-list --objects --no-object-names --all >all &&
    ++		git -C repo rev-list --objects --no-object-names --all --filter="$filter" --filter-provided-objects >filtered &&
    ++		sort all >all.sorted &&
    ++		sort filtered >filtered.sorted &&
    ++		comm -23 all.sorted filtered.sorted >expected.excluded &&
    ++		test_line_count -gt 0 expected.excluded &&
    ++
    ++		git -C repo cat-file --batch-check="%(objectname)" --filter="$filter" <expected.excluded >actual &&
    ++		awk "/excluded/{ print \$1 }" actual | sort >actual.excluded &&
    ++		test_cmp expected.excluded actual.excluded
    ++	'
     +}
     +
     +test_objects_filter "blob:none"
 4:  a3ed054994d !  5:  a88d5d4b60a builtin/cat-file: support "blob:limit=" objects filter
    @@ Commit message
     
      ## Documentation/git-cat-file.adoc ##
     @@ Documentation/git-cat-file.adoc: OPTIONS
    - 	one of the following:
    + 	printed at all. The '<filter-spec>' may be one of the following:
      +
      The form '--filter=blob:none' omits all blobs.
     ++
    @@ builtin/cat-file.c: static void batch_object_write(const char *obj_name,
      		if (pack)
      			ret = packed_object_info(the_repository, pack, offset,
     @@ builtin/cat-file.c: static void batch_object_write(const char *obj_name,
    - 			if (data->type == OBJ_BLOB)
      				return;
    + 			}
      			break;
     +		case LOFC_BLOB_LIMIT:
     +			if (data->type == OBJ_BLOB &&
    -+			    data->size >= opt->objects_filter.blob_limit_value)
    ++			    data->size >= opt->objects_filter.blob_limit_value) {
    ++				if (!opt->all_objects)
    ++					report_object_status(opt, obj_name,
    ++							     &data->oid, "excluded");
     +				return;
    ++			}
     +			break;
      		default:
      			BUG("unsupported objects filter");
    @@ t/t1006-cat-file.sh: test_objects_filter () {
     +test_objects_filter "blob:limit=1"
     +test_objects_filter "blob:limit=500"
     +test_objects_filter "blob:limit=1000"
    -+test_objects_filter "blob:limit=1g"
    ++test_objects_filter "blob:limit=1k"
      
      test_done
 5:  8e39cd218c2 !  6:  13be54300c9 builtin/cat-file: support "object:type=" objects filter
    @@ builtin/cat-file.c: static void batch_object_write(const char *obj_name,
      		if (opt->objects_filter.choice == LOFC_BLOB_LIMIT)
      			data->info.sizep = &data->size;
     @@ builtin/cat-file.c: static void batch_object_write(const char *obj_name,
    - 			    data->size >= opt->objects_filter.blob_limit_value)
      				return;
    + 			}
      			break;
     +		case LOFC_OBJECT_TYPE:
    -+			if (data->type != opt->objects_filter.object_type)
    ++			if (data->type != opt->objects_filter.object_type) {
    ++				if (!opt->all_objects)
    ++					report_object_status(opt, obj_name,
    ++							     &data->oid, "excluded");
     +				return;
    ++			}
     +			break;
      		default:
      			BUG("unsupported objects filter");
    @@ t/t1006-cat-file.sh: test_expect_success 'objects filter with unknown option' '
     @@ t/t1006-cat-file.sh: test_objects_filter "blob:limit=1"
      test_objects_filter "blob:limit=500"
      test_objects_filter "blob:limit=1000"
    - test_objects_filter "blob:limit=1g"
    + test_objects_filter "blob:limit=1k"
     +test_objects_filter "object:type=blob"
     +test_objects_filter "object:type=commit"
     +test_objects_filter "object:type=tag"
 6:  a0655de3ace =  7:  d525a5bc2ef pack-bitmap: allow passing payloads to `show_reachable_fn()`
 7:  e1e44303dac =  8:  e3cc1ae3a87 pack-bitmap: add function to iterate over filtered bitmapped objects
 8:  23bc040bb15 =  9:  c0fc0e4ce0c pack-bitmap: introduce function to check whether a pack is bitmapped
 9:  4eba2a70619 = 10:  28ef93dceec builtin/cat-file: deduplicate logic to iterate over all objects
10:  d40f1924ef5 = 11:  842a6002c50 builtin/cat-file: use bitmaps to efficiently filter by object type

---
base-commit: 003c5f45b8447877015b2a23ceab2297638fe1f1
change-id: 20250220-pks-cat-file-object-type-filter-9140c0ed5ee1


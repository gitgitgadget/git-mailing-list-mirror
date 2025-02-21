Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD441FECAB
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 07:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740124061; cv=none; b=kdcsUA7LpHLlL07M/wMygRtE5lW2b5INZP5DJcxk/M7FpCC9tgJ6iYIXJsto5tdyzoMLrf1QZCZWp+JHw0xPoq6Cb+XuIFaPK5uzkEjWSKBa1yp2YjgT/0FHDQHoFVcgZrfPX7WZ8YJGBbqYVgSYjwupn9uyJlCNlfk1vjJ7CdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740124061; c=relaxed/simple;
	bh=wJD8/cG9jcSrmU8bTu4bWUCzeEgEKlbHQuGYmTWIsOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N5fwwD3r9C848lvhX6cNj09yY4RXpIWEAOa5vyC2DuVat6/OiGp0q6IHdmgXE1aloS93By/k/xMIdjK62Gv/MF3s57IVe2678FmjexaMclfRlg1pm3QiWuuMdrBlcGMfVtw0pINWApIwKL3hbTKQhzdCImqtgcJXlnCChD78fLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EbKK2wjg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x1HKsy3T; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EbKK2wjg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x1HKsy3T"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 057BF2540216
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 02:47:38 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 21 Feb 2025 02:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740124058;
	 x=1740210458; bh=mmbLs3ylk7efdVwuKmGfrxpOeKZ0DXvHlhWrpwtzOKU=; b=
	EbKK2wjg/0y3C+oOT0Ij3pigTAWp8x+YANEAkZvgy+xgZHSWEYEuEl9TBfvqYuHL
	dLA+r2w4GpDOxkIuZ7UCtYGsmxS1kYzYakFX0S9lfa3/eTK5OvLo1d99cOiYdv/k
	g4GnjkgBcDrthfVCzXN88jr9De9XV2GcZmGfpNOJ1EWBQsO0mc3o4HH2l/3R7xGd
	NPBLjxLDDnog0+Vh/+JNdf3aRWqmYF+zR1w5awduz1F5xTTVGjTTT/xTQxTmIy4W
	RiVk8I6QuoM9it+tGBS7YtC3SxE1rjyBhcySR9ugYcomU7Hd0mNofn4mSsEVXAeV
	VtHlRjTqfbOrRmlfnKjbJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740124058; x=
	1740210458; bh=mmbLs3ylk7efdVwuKmGfrxpOeKZ0DXvHlhWrpwtzOKU=; b=x
	1HKsy3T0odPRQEHcEfnwB5IYQ3WffYsuEjE/fS+iW1PE3l7dJRS6Evf8KXBUrOqV
	ajvsa4beWqqGjQVUk3xaTak25+mTWOQoO6dmN2h/MHRe+2MZp3A1hxfzu4UqV9aq
	Sa928KaYQ0BKjpH85qy1Vy03K5SS9swr0o3NM8BRz/d96i6LI0tRKOK1UiplrUVi
	nGMtAm7BjWlDlk69B634FzWFtO3V8xyDFMysBGkjzujC7YwR357gXsq82v+rCv+l
	hpLCqU7e81GB4N0y16YYnVJtscKKAsRz89CxWGFqEpXLBlC0g86iCwelA/UTiFRk
	ed7MlRE6aUEFkbdw8oNOw==
X-ME-Sender: <xms:mi-4Z9_NonFkuLQr7jWrPiy_IrKbWCB0V8HMbt6gvEuVE3MOQXn5TQ>
    <xme:mi-4Zxse0hqxE03nzpj8NxSsLXNGxpgUk1PM98i49paE9bkOvX0sfaZDyYdOjztZD
    1SL_rj3R9tqPXD5uQ>
X-ME-Received: <xmr:mi-4Z7Brx1S4_yX36R_h7b2nlREX0O9sBi4xxrLmplQdKFbiRQ-XBzRABUm8AXPvg_s0X89u3aakYNNEVQUNniKnuFvWxyFmfAlUIlvhpih3kw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeileegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiud
    ejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mi-4ZxdmzG7VtqdkCChLDlex46ublGMiR3Bj4sXzIS_m-igZkfM4vw>
    <xmx:mi-4ZyPmNxzCig654minjPdTzccAZfm_0R1flguoQ-eVmFWGS3kRXA>
    <xmx:mi-4ZzkLuz8oCwlb7j1Pq0_PNT8_SRkmYiCPdhCXdmwE8UYa1At0hw>
    <xmx:mi-4Z8uO4mdG_87uSBWyNaRjxoR0lqtHm0X32z9cBwZ603yQNt76Ag>
    <xmx:mi-4Z019a2E7qfF4GZucS1Lfxj9T_jXkbCnVhp5FLOhcoIq1SF4WhQCs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 21 Feb 2025 02:47:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 77880457 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 21 Feb 2025 07:47:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 21 Feb 2025 08:47:30 +0100
Subject: [PATCH 5/9] builtin/cat-file: support "object:type=" objects
 filter
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-pks-cat-file-object-type-filter-v1-5-0852530888e2@pks.im>
References: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
In-Reply-To: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Implement support for the "object:type=" filter in git-cat-file(1),
which causes us to omit all objects that don't match the provided object
type.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-cat-file.adoc | 3 +++
 builtin/cat-file.c              | 8 +++++++-
 t/t1006-cat-file.sh             | 6 +++++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
index 8c474418b52..540d9dffdf9 100644
--- a/Documentation/git-cat-file.adoc
+++ b/Documentation/git-cat-file.adoc
@@ -93,6 +93,9 @@ The form '--filter=blob:limit=<n>[kmg]' omits blobs of size at least n
 bytes or units.  n may be zero.  The suffixes k, m, and g can be used
 to name units in KiB, MiB, or GiB.  For example, 'blob:limit=1k'
 is the same as 'blob:limit=1024'.
++
+The form '--filter=object:type=(tag|commit|tree|blob)' omits all objects
+which are not of the requested type.
 
 --path=<path>::
 	For use with `--textconv` or `--filters`, to allow specifying an object
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index f57bf65cb03..b374c2bb104 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -474,7 +474,8 @@ static void batch_object_write(const char *obj_name,
 
 		if (use_mailmap ||
 		    opt->objects_filter.choice == LOFC_BLOB_NONE ||
-		    opt->objects_filter.choice == LOFC_BLOB_LIMIT)
+		    opt->objects_filter.choice == LOFC_BLOB_LIMIT ||
+		    opt->objects_filter.choice == LOFC_OBJECT_TYPE)
 			data->info.typep = &data->type;
 		if (opt->objects_filter.choice == LOFC_BLOB_LIMIT)
 			data->info.sizep = &data->size;
@@ -505,6 +506,10 @@ static void batch_object_write(const char *obj_name,
 			    data->size >= opt->objects_filter.blob_limit_value)
 				return;
 			break;
+		case LOFC_OBJECT_TYPE:
+			if (data->type != opt->objects_filter.object_type)
+				return;
+			break;
 		default:
 			BUG("unsupported objects filter");
 		}
@@ -1047,6 +1052,7 @@ int cmd_cat_file(int argc,
 		break;
 	case LOFC_BLOB_NONE:
 	case LOFC_BLOB_LIMIT:
+	case LOFC_OBJECT_TYPE:
 		if (!batch.enabled)
 			usage(_("objects filter only supported in batch mode"));
 		break;
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 86c53e01b2f..b908bbf60e1 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -1388,7 +1388,7 @@ test_expect_success 'objects filter with unknown option' '
 	test_cmp expect err
 '
 
-for option in object:type=tag sparse:oid=1234 tree:1 sparse:path=x
+for option in sparse:oid=1234 tree:1 sparse:path=x
 do
 	test_expect_success "objects filter with unsupported option $option" '
 		case "$option" in
@@ -1425,5 +1425,9 @@ test_objects_filter "blob:limit=1"
 test_objects_filter "blob:limit=500"
 test_objects_filter "blob:limit=1000"
 test_objects_filter "blob:limit=1g"
+test_objects_filter "object:type=blob"
+test_objects_filter "object:type=commit"
+test_objects_filter "object:type=tag"
+test_objects_filter "object:type=tree"
 
 test_done

-- 
2.48.1.683.gf705b3209c.dirty


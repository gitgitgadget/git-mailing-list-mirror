Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F1C3126CA
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 15:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155913; cv=none; b=ohTQvwwQvij3i1iAvdMo0jZPA4WMOFSOWMJzgRDpTH3htaztXyg0HrrvFZyfEWHHVAlPhcrB5Z1fc1LXM9YyL4bhq7SK06jNhj2l2sVwIWJLi/dqGCqGk92b9H+2spcscKXE2o4ZdeLKzdS93kaaFIQq4s4f1aj3PHS6+9Y+yDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155913; c=relaxed/simple;
	bh=DbU8H4RWlUPHrobDldmDByw1DPlocA+ob5wSs43VMpw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=haeJH1MlkzmRXOylsc0rMTQFwWZQaPuOgCIk6J07VtWhCvvzz/GQYcnffwcQQkzXPxV0zl7kJsNoOYCdWuyDCT3K80DMGEmBIwkvdhnMqK7Jsy1XDHXt5fe+FXsEW0juVuM4wZkZXanmz473jE902/vukzMmxyMod4+WpY7gDSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nJE+4Aps; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HgWN/SC1; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nJE+4Aps";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HgWN/SC1"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 55B57EC05A6
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 11:18:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 10 Mar 2026 11:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773155911;
	 x=1773242311; bh=muMAu8LVtrtFiVc6GeANJ/wRFZif3NCXvaqhVtHcG+k=; b=
	nJE+4ApsKbytV+oDDpXFRa0debei4eWMlHcADtLHWJx4OfOwtM11BujccmUqsjjD
	HrFWT6GxWK2o+YLLPB10HhoOMqljlBDRQfbDySQTJylXNcefiGohpm3drXy8YUme
	3kN61bxhMdUjJ5hgm0fMsIVGkvVp/DJIOXmKCtvMR5bE6+A1tMDo4dlTtIb8NsZ1
	yACC/WtSM6AKzr+ZRhGKjGtqoRStW0p83I33jO/EpIjG2TbC90hIp7l65jMEPkJB
	hXjiklzvtUVEud9N6LWmLwxLk6YpmMLuQvYQh0rxK1laeeko7VinVRr7uDRK7o8r
	Yzv8f1KfetYbJq2kjJ9tDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773155911; x=
	1773242311; bh=muMAu8LVtrtFiVc6GeANJ/wRFZif3NCXvaqhVtHcG+k=; b=H
	gWN/SC1DeSGgkwJvAbWuzajy4H+L9JprarlFl5xYj8JnD/KOEYvL41BbERUaNHU7
	Pk/fteqo8quiUvnozJ/o4xZ96pLA1MlVD80HsnLOTUN77WUkd4gIyex76Epey2Q3
	74TfI8B4BMe/RsX8fVTP5RxUHnVDC15PPXiAX1cf8/4TYBtOn66qKEzeMT71OjuZ
	GVwTA15EYxmQ21BWUHYc9GmJyxRrMpqVtviVhBTtOom6oxBNJmxRuU6XMcfEuSZF
	4OeIdB+GSGhXGy8BOd+IheoZXRRx2ixtKdQZCAsfeC3Ry7rOC/LHxiwqFX8OGTvp
	17sHYflHq6pm4QkyrsQoQ==
X-ME-Sender: <xms:RzawafgFhcRIOdulV-e9913czfKFRFmUV46Ed37EjblGGPs0QyfWzQ>
    <xme:RzawaS9vQGfflPc0nt2GhgSfhZ8h4ii9bx2ypTZN8iJazeEdfXClrFgPCTq2BtZwy
    aJkLasfKSOULFFfLWVKTyBq7zxjtVt_HaRjc0lGv1MSFUe50lwlJA>
X-ME-Received: <xmr:RzawaUv8yZdYOSWFjxCgR5q6xys66JVleQefWcoEV01O1_A7waMK_ImpTPQePe7NjiYpPsG9G3xy0JYdCL862GW6lYPNQPsxF8G3dGZL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedufeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:RzawaRZPRSFETtBBh_qcama1xxVYmro9tCe8nTUJUuRp0faY1xpWng>
    <xmx:Rzawacpl_Qy89C8BENSzbDLdwMTo-Jgoy78gnrWdGfZB_xX4dcr_xA>
    <xmx:Rzawae-_OvVtlfY6ZXLwTFqR7BI6btabNQrDhQlRYmKbEQ7GXfiUJg>
    <xmx:RzawaT98x3N2QB5b3pHY1qqLTf-sgVgSn5OQX77Z84QvUniVcl8F7g>
    <xmx:RzawaQiQI3XNO_eVirVKHJqdb5XzKmYlvyfrLlmiH581odrisTTdVWyJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 10 Mar 2026 11:18:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 45642c57 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 10 Mar 2026 15:18:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 10 Mar 2026 16:18:22 +0100
Subject: [PATCH 2/6] packfile: extract logic to count number of objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-pks-odb-source-count-objects-v1-2-109e07d425f4@pks.im>
References: <20260310-b4-pks-odb-source-count-objects-v1-0-109e07d425f4@pks.im>
In-Reply-To: <20260310-b4-pks-odb-source-count-objects-v1-0-109e07d425f4@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

In a subsequent commit we're about to introduce a new
`odb_source_count_objects()` function so that we can make the logic
pluggable. Prepare for this change by extracting the logic that we have
to count packed objects into a standalone function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 45 +++++++++++++++++++++++++++++++++++----------
 packfile.h |  9 +++++++++
 2 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/packfile.c b/packfile.c
index 215a23e42b..1ee5dd3da3 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1101,6 +1101,36 @@ struct packfile_list_entry *packfile_store_get_packs(struct packfile_store *stor
 	return store->packs.head;
 }
 
+int packfile_store_count_objects(struct packfile_store *store,
+				 unsigned long *out)
+{
+	struct packfile_list_entry *e;
+	struct multi_pack_index *m;
+	unsigned long count = 0;
+	int ret;
+
+	m = get_multi_pack_index(store->source);
+	if (m)
+		count += m->num_objects + m->num_objects_in_base;
+
+	for (e = packfile_store_get_packs(store); e; e = e->next) {
+		if (e->pack->multi_pack_index)
+			continue;
+		if (open_pack_index(e->pack)) {
+			ret = -1;
+			goto out;
+		}
+
+		count += e->pack->num_objects;
+	}
+
+	*out = count;
+	ret = 0;
+
+out:
+	return ret;
+}
+
 /*
  * Give a fast, rough count of the number of objects in the repository. This
  * ignores loose objects completely. If you have a lot of them, then either
@@ -1113,21 +1143,16 @@ unsigned long repo_approximate_object_count(struct repository *r)
 	if (!r->objects->approximate_object_count_valid) {
 		struct odb_source *source;
 		unsigned long count = 0;
-		struct packed_git *p;
 
 		odb_prepare_alternates(r->objects);
-
 		for (source = r->objects->sources; source; source = source->next) {
-			struct multi_pack_index *m = get_multi_pack_index(source);
-			if (m)
-				count += m->num_objects + m->num_objects_in_base;
-		}
+			struct odb_source_files *files = odb_source_files_downcast(source);
+			unsigned long c;
 
-		repo_for_each_pack(r, p) {
-			if (p->multi_pack_index || open_pack_index(p))
-				continue;
-			count += p->num_objects;
+			if (!packfile_store_count_objects(files->packed, &c))
+				count += c;
 		}
+
 		r->objects->approximate_object_count = count;
 		r->objects->approximate_object_count_valid = 1;
 	}
diff --git a/packfile.h b/packfile.h
index 8b04a258a7..1da8c729cb 100644
--- a/packfile.h
+++ b/packfile.h
@@ -268,6 +268,15 @@ enum kept_pack_type {
 	KEPT_PACK_IN_CORE = (1 << 1),
 };
 
+/*
+ * Count the number objects contained in the given packfile store. If
+ * successful, the number of objects will be written to the `out` pointer.
+ *
+ * Return 0 on success, a negative error code otherwise.
+ */
+int packfile_store_count_objects(struct packfile_store *store,
+				 unsigned long *out);
+
 /*
  * Retrieve the cache of kept packs from the given packfile store. Accepts a
  * combination of `kept_pack_type` flags. The cache is computed on demand and

-- 
2.53.0.880.g73c4285caa.dirty


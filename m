Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1F01AA7AE
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 13:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732109995; cv=none; b=puqyjuAYr7aKl88nAAOiYribPz5yAESv6rjd2thG4m664UsGx7rRTB6UK3zJjfvgU/fIoYgkA1gwKGAM/YiuffBHSr7tbQQXGeB6serLqCJCUliC0xgp6mM8t9HZBMK29LnFFVwdoyPqw1lP7ToWMFdRf/HzHA7tpJ9nShk8jrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732109995; c=relaxed/simple;
	bh=MqGYvgDPd53oG87JKoqjMhx5GUGJwEjRusYHh6hnxU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GbK+6IEulPSZiQmEEE9SmNNRk5d31agdXkoC9ZNJnXs3V+ZB7c43lNOumLlvH7q3Im3vUqi/F7icCIE2EhceoIu9DlGOSsprfNM7i1ULJBBoBKKRWC2kEZMmnmggbad+EVSXhF5cF+ME/ZEYBcmg28RJFB8lAJI7ZZCb9KmAqy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TvPuW1My; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KauioVib; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TvPuW1My";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KauioVib"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 4596A13806E2;
	Wed, 20 Nov 2024 08:39:53 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 20 Nov 2024 08:39:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732109993;
	 x=1732196393; bh=9BILhbnFQaOs2t18coJiGW9TjvST6YFjT+XvMCaWqI0=; b=
	TvPuW1Myer+HCFl3MYe6V/By764eeTe9njMohIQyEPBs2Nic8nB5wM00yR89vr+O
	vZiFR4pFMlBFsRLVbT/ekbUWBAmbmJDj0tdH+fBK+ebjfg9WLzu5PA1i7vLGQ+ny
	iYxByy0DzcNIA6xSLtopjC82j5ZhM50MU2RN0ixGjYdYFcswsHnlmHAxQAt+XZQn
	3jz7GwLGsyewBJUgX26XLdaJRKDRKCZBnVoWcJwOiHlcsFiURYG4CZWgTxn6dIxd
	V4RE9y3QtAyQpUB5hF8dMWHzlCbPEWB9s0DqqqGa7GSVKSh2elwAQiOshNsG8Ps1
	Z/i9vyQEQnxZ+hHfceKQOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732109993; x=
	1732196393; bh=9BILhbnFQaOs2t18coJiGW9TjvST6YFjT+XvMCaWqI0=; b=K
	auioVibYO6uoOM3EwhOg1iQk7HaoOql6UGy6yXbPoI/n0ISyq7NYyvulYT5vephx
	j4D/8eq5HEQLrU69ha4yKfLgzQ45BWzAN82+bBoA2MdJylaDTsRKndA2Jl9W4I/w
	AJJ3+qgLlfadcE0Z7YNkwlTKo5A0gnPpWOT530CmmpIFBhXj+DW25bJ5dvhI6MeS
	9W/wGVyIjlaVIL4su0SsVSdHnEZk6oj44Yl/Jt6/vm72c0oF4YxSEvsrkyX+Xy1J
	Id+fchzF+VbL+Go0Cf2yuCjmEWwi9faF0APGHGtwzlXyi6Aply+CF1M4b5GcaXhj
	MtMK1kVtbrSlzbhqIEDkQ==
X-ME-Sender: <xms:qeY9ZwisrA0gybcPSR_CrjDO1Yrd7szCXMMAODImtKd5Lg5MS1ljUQ>
    <xme:qeY9Z5CLasT9UaXrnSEsG_NYZj95FheU15ytJ7osdEQ4OwIVXWkMq0Lyh8nRXKqx0
    YwC4xyQnAb_evCDIg>
X-ME-Received: <xmr:qeY9Z4Ek4doNgI9LAUCzvbb2gLry80ABU2YCjEK5p-4L9GyxBmvfmIQ12uIwNt2rVqFMCGs0gTnd2pXjz-svgBpbQJM_5QrWmWEYGp_7mq3hCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheprhhjuhhsthhosehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:qeY9ZxTdd0J3sM7NrcATXqfggjyqEn5IgzSMmeH1D_W2Nm1PyHEp1w>
    <xmx:qeY9Z9zdXGAD19Diw0Y9wcup5eFxcaZbTBS3jIqXTMvtGJvQLxqy_w>
    <xmx:qeY9Z_66lEboWM9ol4YkPG3523Axiv6-EgXzepu5mSWR8eOwEZ4oTQ>
    <xmx:qeY9Z6xjGcbvlq5nZSlgJdNdDDBquICRNgrFa65lZnirshz8uZyXhQ>
    <xmx:qeY9Z_s7-97W2qQFFCK-qS-aea3PeYzErjGieef2BlBNTq7lsRV_HN1c>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 08:39:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f6d3d666 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 13:39:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 20 Nov 2024 14:39:36 +0100
Subject: [PATCH v3 07/27] bisect: fix various cases where we leak commit
 list items
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-b4-pks-leak-fixes-pt10-v3-7-d67f08f45c74@pks.im>
References: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
In-Reply-To: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, 
 Jeff King <peff@peff.net>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

There are various cases where we leak commit list items because we
evict items from the list, but don't free them. Plug those.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bisect.c                    | 30 ++++++++++++++++++++++--------
 t/t6030-bisect-porcelain.sh |  1 +
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/bisect.c b/bisect.c
index 12efcff2e3c1836ab6e63d36e4d42269fbcaeaab..f6fa5c235ffb351011ed5e81771fbcdad9ca0917 100644
--- a/bisect.c
+++ b/bisect.c
@@ -442,9 +442,12 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 			best->next = NULL;
 		}
 		*reaches = weight(best);
+	} else {
+		free_commit_list(*commit_list);
 	}
-	free(weights);
 	*commit_list = best;
+
+	free(weights);
 	clear_commit_weight(&commit_weight);
 }
 
@@ -557,8 +560,11 @@ struct commit_list *filter_skipped(struct commit_list *list,
 			tried = &list->next;
 		} else {
 			if (!show_all) {
-				if (!skipped_first || !*skipped_first)
+				if (!skipped_first || !*skipped_first) {
+					free_commit_list(next);
+					free_commit_list(filtered);
 					return list;
+				}
 			} else if (skipped_first && !*skipped_first) {
 				/* This means we know it's not skipped */
 				*skipped_first = -1;
@@ -614,7 +620,7 @@ static int sqrti(int val)
 
 static struct commit_list *skip_away(struct commit_list *list, int count)
 {
-	struct commit_list *cur, *previous;
+	struct commit_list *cur, *previous, *result = list;
 	int prn, index, i;
 
 	prn = get_prn(count);
@@ -626,15 +632,23 @@ static struct commit_list *skip_away(struct commit_list *list, int count)
 	for (i = 0; cur; cur = cur->next, i++) {
 		if (i == index) {
 			if (!oideq(&cur->item->object.oid, current_bad_oid))
-				return cur;
-			if (previous)
-				return previous;
-			return list;
+				result = cur;
+			else if (previous)
+				result = previous;
+			else
+				result = list;
+			break;
 		}
 		previous = cur;
 	}
 
-	return list;
+	for (cur = list; cur != result; ) {
+		struct commit_list *next = cur->next;
+		free(cur);
+		cur = next;
+	}
+
+	return result;
 }
 
 static struct commit_list *managed_skipped(struct commit_list *list,
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index cdc02706404b34b17b29692d72d97fab7eba58b1..310affadebed321fcc93ee5bd785abf4ca013cc1 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -9,6 +9,7 @@ exec </dev/null
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 add_line_into_file()

-- 
2.47.0.274.g962d0b743d.dirty


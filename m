Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDB717E44A
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 02:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935358; cv=none; b=QkFquUC8J8HAJref+oTiX8MY1OAdADeJp/6aThGc3GcGve3/PyBETobcMhC7U/h/MxT1mOPkOrMWjLaJ7aotTUfhdk2aTl1akKCr5725rUUMkmNebAutmLSucU7GV5dkY5ZEB9WVy7wez8zVjTN5F550xybQUxNsCbZDZx82kD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935358; c=relaxed/simple;
	bh=oxreYrDp9BdYmvGLbyhFl1o7XFz1FkY+tTYhhFHIrIE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rZfBN7Yz/+YOJ3eXws9v/Nar6Awrk1a6P5ttyCUSoFzIETxvIN8urN3iyszfvoWvfHutN1owuiWCo6ZlVZXJI8M9pssweLMkdDUGTDrGCWKEYMJANAlbyhWbp1V/znTQUQfy3TxTiFmUokHwGVsE7Wer5mfCnF8NSbaYNZdcJMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3wiWlmE; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3wiWlmE"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f74e613a10so38460111fa.1
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 19:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725935354; x=1726540154; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D90cTLe7P0X0gWvYLCHbiUHT89yrSeqOaitywQgyQyA=;
        b=U3wiWlmEu3Ve+S/WijStp/NJshBDrtX63tfEOP/IDyLivtbybovCMzexaPhK986Tee
         HLj0bxZNQraPbYMfB8E7uffk9poCX2FnSxYP8hjWueXSRTPrusmsaSwn3LbB62PWQBOM
         pXW175kIceXLNC9tcqYZMCRF8dKw4+vNukiequWwpMygdkejZAzzXh1AwWlUcQ8heVPL
         KxM7nReyhYp3odsHRLNTaLPkBON7CtZ1ODy210ViCpY5AoIK+mj5MWNI80z8Dg1JQw+m
         mgi20KQH5QjLe40+2c99fq6jKdSFGIu5dLYcTX+XQzKr1iHHS9YajNZ3fQM0cAQkGW5u
         4TQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725935354; x=1726540154;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D90cTLe7P0X0gWvYLCHbiUHT89yrSeqOaitywQgyQyA=;
        b=q52CbI1magB+XPIJlhQFkqo1HMs+4jgA1wxttTcscQPwFBb2pRe+nDIEcdR/SB5kfI
         XkTS0xU6CeSZsb2Ew9FcbLh8wh6IF2HaTrYCVv3gwZMhHV90zAB4j0ZheDUy7gT6erK1
         v4OPGLmiYxnD+JFNxI8DHycdyEQcn77+vRgG78UYA7LCOduf607j4PjkrUFZJlxYyMDV
         h161AdTSQKvW35zy3CJ33XlFmT1v05fDCV8nBLzpGKovdnbpxtsW1wnUL2kTeijPkLSF
         ySWV0uEzZ5tjrLafHjulIgxxdq3DPA+uvb3ZrTdqRv6i5BbCXK3Bzc42h29sB+syZZsU
         Hv/g==
X-Gm-Message-State: AOJu0Yw55atus4SHt595Q8SkykdXmIIomMINOZxa4C+Ixp0bdAwea3L/
	fu5jZlEkTE4UVdN9XXrT+OcHI3e7uMqPr2L0l5tXsf+fRVJiaIM/Tx23Aw==
X-Google-Smtp-Source: AGHT+IEpv+x0QqQGxKt5p5y0QhN67uOi/cHgvGLY4cUJevKAJJ0srggYU/Sks7qdMCekW22iMNUyyQ==
X-Received: by 2002:a2e:619:0:b0:2f7:712d:d08 with SMTP id 38308e7fff4ca-2f7749e9fb7mr3244931fa.23.1725935354288;
        Mon, 09 Sep 2024 19:29:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d258317d6sm414148566b.29.2024.09.09.19.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 19:29:13 -0700 (PDT)
Message-Id: <3504abb269b5229d4aaff4db9f4d694d925ac1b2.1725935335.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
References: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Sep 2024 02:28:41 +0000
Subject: [PATCH 16/30] survey: add ability to track prioritized lists
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

In future changes, we will make use of these methods. The intention is to
keep track of the top contributors according to some metric. We don't want
to store all of the entries and do a sort at the end, so track a
constant-size table and remove rows that get pushed out depending on the
chosen sorting algorithm.

Co-authored-by: Jeff Hostetler <git@jeffhostetler.com>
Signed-off-by; Jeff Hostetler <git@jeffhostetler.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/survey.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/builtin/survey.c b/builtin/survey.c
index baaaf8a6374..ad467e9a88c 100644
--- a/builtin/survey.c
+++ b/builtin/survey.c
@@ -77,6 +77,102 @@ struct survey_report_object_size_summary {
 	size_t num_missing;
 };
 
+typedef int (*survey_top_size_cmp)(struct survey_report_object_size_summary *s1,
+				   struct survey_report_object_size_summary *s2);
+
+MAYBE_UNUSED
+static int cmp_by_nr(struct survey_report_object_size_summary *s1,
+		     struct survey_report_object_size_summary *s2)
+{
+	if (s1->nr < s2->nr)
+		return -1;
+	if (s1->nr > s2->nr)
+		return 1;
+	return 0;
+}
+
+MAYBE_UNUSED
+static int cmp_by_disk_size(struct survey_report_object_size_summary *s1,
+			    struct survey_report_object_size_summary *s2)
+{
+	if (s1->disk_size < s2->disk_size)
+		return -1;
+	if (s1->disk_size > s2->disk_size)
+		return 1;
+	return 0;
+}
+
+MAYBE_UNUSED
+static int cmp_by_inflated_size(struct survey_report_object_size_summary *s1,
+				struct survey_report_object_size_summary *s2)
+{
+	if (s1->inflated_size < s2->inflated_size)
+		return -1;
+	if (s1->inflated_size > s2->inflated_size)
+		return 1;
+	return 0;
+}
+
+/**
+ * Store a list of "top" categories by some sorting function. When
+ * inserting a new category, reorder the list and free the one that
+ * got ejected (if any).
+ */
+struct survey_report_top_sizes {
+	const char *name;
+	survey_top_size_cmp cmp_fn;
+	struct survey_report_object_size_summary *data;
+	size_t nr;
+	size_t alloc;
+};
+
+MAYBE_UNUSED
+static void init_top_sizes(struct survey_report_top_sizes *top,
+			   size_t limit, const char *name,
+			   survey_top_size_cmp cmp)
+{
+	top->name = name;
+	top->alloc = limit;
+	top->nr = 0;
+	CALLOC_ARRAY(top->data, limit);
+	top->cmp_fn = cmp;
+}
+
+MAYBE_UNUSED
+static void clear_top_sizes(struct survey_report_top_sizes *top)
+{
+	for (size_t i = 0; i < top->nr; i++)
+		free(top->data[i].label);
+	free(top->data);
+}
+
+MAYBE_UNUSED
+static void maybe_insert_into_top_size(struct survey_report_top_sizes *top,
+				       struct survey_report_object_size_summary *summary)
+{
+	size_t pos = top->nr;
+
+	/* Compare against list from the bottom. */
+	while (pos > 0 && top->cmp_fn(&top->data[pos - 1], summary) < 0)
+		pos--;
+
+	/* Not big enough! */
+	if (pos >= top->alloc)
+		return;
+
+	/* We need to shift the data. */
+	if (top->nr == top->alloc)
+		free(top->data[top->nr - 1].label);
+	else
+		top->nr++;
+
+	for (size_t i = top->nr - 1; i > pos; i--)
+		memcpy(&top->data[i], &top->data[i - 1], sizeof(*top->data));
+
+	memcpy(&top->data[pos], summary, sizeof(*summary));
+	top->data[pos].label = xstrdup(summary->label);
+}
+
 /**
  * This struct contains all of the information that needs to be printed
  * at the end of the exploration of the repository and its references.
-- 
gitgitgadget


Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB9642E8D6
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 18:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784227873; cv=none; b=jUWvj9K3KtoC2WcKAl5laIXKHRJuXrQC8UIhGWL7NOCG2zhp7MBn9KF7Lhw7KwY7+2uERMuNMOWR1iCr8Y82RdP0g67DfMje0+HudCxKnhaCBLAizYJ8qUj/yb5vXPB1//wWJksEF3fZ2FuEtFVG/pdbbBEOd0cenKXmajnjus0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784227873; c=relaxed/simple;
	bh=lNBjVNSybNT+xaWWO/Cg7E3UaYAmMVVsRzu7z+WWDdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YElJDr5rMuu31uUHE8RYTanUsfCaQwZG834t/ILG1Wrs+QSoOStNAJ38w8LkCywUnZpioI74fP+VBGLfKi8V2Y3g2hmu8GTA36+LR5pClWaWZ/q5h5UEDSuk9slzPTM+PcDO0FFrF9xsj64iW+1nTWBi9VpNScvyXrA0hOtjRUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3KvEYUj; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3KvEYUj"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e347638adso1877127a91.0
        for <git@vger.kernel.org>; Thu, 16 Jul 2026 11:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784227870; x=1784832670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H1rgj/ddoXyN6ggoTZWbhGX6F1P+AVfhV5lpEE3/94E=;
        b=B3KvEYUj/Nf0qLxm1h6zlK4kVDbvBhhH9UO34NHhscRf0m8WLUxIz6VJCUtUBR0Fya
         nMmZj3jZqkz6NhEB2AUqqoKcf/hl2YUc8QZqdSrCCHKBc8PoZzfh//TdYD/4AvAxy9vd
         62MIQV9D58Xn3QJOSyq+p8KgCu1la8gsiUA3pexCVJVnfpea7yRz/yVB+QC0MP5B/I3g
         j63agyLT5RpJyZsUA/h8AT2ZtgBna0MBnER7PlZD0wGhlv6rXeWM8Zv+8wRi8F9rCl5v
         FH6rIlVx0vIQW8uCt5ZuGRDVNXyvelL2I6D+ms6PjxhbWzWjHHZYl9kmSFyqLxd3vPqv
         1fEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784227870; x=1784832670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H1rgj/ddoXyN6ggoTZWbhGX6F1P+AVfhV5lpEE3/94E=;
        b=Mz9VSbl9h6mBiufFZNu0X39wpbsOdpmpoafkxjUWDhyarD0xv/9HmCXUH7Nlm1xco3
         pPrzlxBTA/K5UrRzhJfdbL7haeYjGPo9q5aaGsH/fLV4o7BPRyKaxnBEop2/h/uCNPNt
         gyvNLFf4jNxUrOSgUFv61DvcHkg7h+67WSW7DPnwlPK029w6Ij1tbmnxmIr0vZyU25mp
         y79JsYT5Isgc7ZigvpfSWQNInm3fgvWASzRfmP73lcz2Mf6/IuF/gXuA5+YtZiIMrCOD
         WjBwYwed9sf/Gvp+peQ09WCRf8AeN2E9dga+RwD0OPwj7D2+gxja2JN94A8eoR/Iuocc
         SsEg==
X-Gm-Message-State: AOJu0Yz5Nc8efVil/XJlCbWWB1l4zyLZYJDkYrotLr5BllSDG0oF+pL1
	sf+6aSxa4w9FMNo8NeG1sW+mSCyLexPgSn6/1qsFBm9IljidVFD3im/ltesc+U0t
X-Gm-Gg: AfdE7cnSe2tnnHzwCDTGoY8Vt0aoYUsx04vVAaorZOFahng3HmuWJ+0PZoOuUjOTn2t
	cn1JqR2I57JsYkXWMagPfH+Dvbs8EjHqtxLqY+0AFinqW686sefceyP1u/JErimzGI1Z7gtWuxl
	IqzxkoyKpmm5l7r5IBR1quAC7q7EGXpRyWZ97yvUagVVnBHqHSlzHwOxF/AAYf89SzZskUnj6wC
	BCwy9IZ6ICeY7JQKSxos7Aif37N8uKh0BGWca46TwtcvfAhh83LIbyRfcvErwE5bo43xftyUYQF
	qQMHghDxlPi2Irg2lHlfDqpk9q83Bar2sVT0FeGuYn2GOhRNZ37Y73Ki7e0vIs5nJaDqllMw+wf
	af+m+PD5sS5zeusgduMp5v+LFkorlYf9ajThlVVrIybiLb2H5uUAtQjglRsFtBdN7clIJ4Tp5EZ
	Ubr4Juv1QnQtT7Q8s783Suc1LrLzc=
X-Received: by 2002:a17:90b:3b4e:b0:38d:e28e:a639 with SMTP id 98e67ed59e1d1-38e2a077f2bmr7262837a91.24.1784227870516;
        Thu, 16 Jul 2026 11:51:10 -0700 (PDT)
Received: from sahitya-07.tail6abcb.ts.net ([2401:4900:8fba:f9ce:5436:7589:6b45:1715])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3141dc5154dsm4203588eec.7.2026.07.16.11.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 11:51:09 -0700 (PDT)
From: Sahitya Chandra <sahityajb@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	avarab@gmail.com,
	stolee@gmail.com,
	peff@peff.net,
	Sahitya Chandra <sahityajb@gmail.com>
Subject: [PATCH] wt-status: avoid quadratic insertion for untracked paths
Date: Fri, 17 Jul 2026 00:20:45 +0530
Message-ID: <20260716185045.229320-1-sahityajb@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wt_status_collect_untracked() copies entries from dir.entries and
dir.ignored into string_lists using string_list_insert(). That keeps the
destination lists sorted and deduplicated, but each insertion may shift
the backing array, making construction O(n^2) in the number of paths.

Collect the entries with string_list_append() instead, then sort and
deduplicate each list once. This preserves the sorted, duplicate-free
result while reducing the construction cost to O(n log n).

Signed-off-by: Sahitya Chandra <sahityajb@gmail.com>
---
Notes for reviewers:

fill_directory() currently sorts dir.entries and dir.ignored
before returning, so another possible approach would be to append the
entries directly and rely on that order, reducing this copy step to O(n).
That would require relying on these arrays not containing duplicate
entries, though, which I have not been able to verify yet. This patch
takes the safer approach of preserving the existing duplicate-removal
behavior from `string_list_insert()` by sorting and deduplicating once
after appending.

 wt-status.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 58461e02f8..13a7cf7946 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -832,14 +832,18 @@ static void wt_status_collect_untracked(struct wt_status *s)
 	for (i = 0; i < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
 		if (index_name_is_other(istate, ent->name, ent->len))
-			string_list_insert(&s->untracked, ent->name);
+			string_list_append(&s->untracked, ent->name);
 	}
+	string_list_sort(&s->untracked);
+	string_list_remove_duplicates(&s->untracked, 0);
 
 	for (i = 0; i < dir.ignored_nr; i++) {
 		struct dir_entry *ent = dir.ignored[i];
 		if (index_name_is_other(istate, ent->name, ent->len))
-			string_list_insert(&s->ignored, ent->name);
+			string_list_append(&s->ignored, ent->name);
 	}
+	string_list_sort(&s->ignored);
+	string_list_remove_duplicates(&s->ignored, 0);
 
 	dir_clear(&dir);
 

base-commit: d35c5399e3e54ac277bb391fc2f6be3e816d312b
-- 
2.43.0

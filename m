Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3937D3D5C0C
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 02:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789440234; cv=none; b=Y+si5hBXb8KkJiRXcQPndU6yK7Po8Hz040G9RLDqdNAncDmAd/xrNw8Z6nEHDuXnoHuKwGCZcr9nIJx8UFW6n9nczifEW57LYNby6K0tkXTxXpJI5UUZek7eG98t44Y0r2+RvICvyckK/NG7aw42RG15ym9KkvchLo0KliLxaDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789440234; c=relaxed/simple;
	bh=sbPSIC+cXUAhDpbkNm2K+OYoiIhmpRswGbEmafnl7Tg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=swsOadaOePZV3BI+1b+Q0nVLngU5XgWG7YRF+zl6JIEwnB2VK4alZrPxva4VSNUkJbhHIxCe9G52kihfSrhwa158daFRnqnO15y+4oGROIxzhJnVmSrU7gYg1ijEWbbWGIDDmRwsIvVFAqicy0LbQ5j+5NuhXUOhbzlmTs0NU8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=eGdXCkcT; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="eGdXCkcT"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-86309e1a213so1759061b3a.0
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 19:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1789440232; x=1790045032; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7+3bJDBXz8FqRU7klF7tKBIjoXx4KLSLjOJ6heYwdss=;
        b=eGdXCkcTtx6jykouWfcjJ/NU5Pv/jgzTyV428/GBgeea+57GBReI3PCG2y/bdAZ0dX
         mtGqlOe8BZF+iyUTWl4dQqRvsxgsE4UiT0+xlKKBi9lPCXtL1f4Sq7TI9bNv2cE29igN
         IBWTwiKwgrHmOpe/wj9ODoCt+OSuWEvOmOYa49xLoWyFmwszWBU4eVeSDfqLugXbbRbw
         i/zFmbjxyXkoHmO8lL9xoDdBAcnGduvJXyYZ8N4IdnAP57xoN/x8IHRp8BW/J7qLHtqI
         6qJOYsYsnU7NmMqov4HacX+SLrcXwwb4BnG3Vg9jAqw92vbjfIc8mff0Hc12tOa60q2O
         ipsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789440232; x=1790045032;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7+3bJDBXz8FqRU7klF7tKBIjoXx4KLSLjOJ6heYwdss=;
        b=WSb7uOY7Q4PAOOrtDgfVChGOVFm0RwK5au4GSQKo5RismxAAUXVA9yUcPkS6wwYMQI
         kxiGFbmBO/Js8fxoUhB7S79NYA4xoPTU5BHtOqTgVZIr0yZcCn7uHrgV/yGqMpuIz4Lt
         XdyV+Ib/m6QenMjWO9gOC0cpRxdqpfSTcfS+jaMHfS6ilDFRn/WJ9aHglVxPO4ChHKCv
         WeKkZZQaYQrAXLxAnwnGd1Ffryo2zJqm4Yu0JMi+l9rL9NpswuDQmDb7C8mBrmqici5K
         5HfCf4gV/tpTzpylos2uH5iXMBF64KJ5Ez8tDd+7UgH3WdKoLr7DZ9lg2hAnbls6ukvO
         /cFA==
X-Gm-Message-State: AFuF++n89JCUJAZiBeLN+HdUxwhyWLy1JnyqulPfEFOiSoN23Z7DbBkB
	WZ2EpKkNs7c6wQaZtlkVLzyHVGSm9g8H5MREVBFR/snKdGjyehZxIHIYmh45YilwCfU=
X-Gm-Gg: AYBFou2tleFMr6auFwHHfuSCwOYn1oTUutDtL+/q7vtSEQvz2Iepm+3mAHs/NET4RaB
	cJg9Xe7GCP61E85VFzT04KkjUH5s/70wxPdfz0sFmNx/7niblncqnMi5L2yGH/urWhsxTURMoOn
	7dJ7VUR9ZbICPZXgbZUHLhL4gMIeDMZb+3CmpY4xnwJ/cBhsJSlayfhJdnRAp7UFvPBuu8Secbr
	cOVSIIRUbFZ+vnjDeKzqPX8dz2HnkGiaoO21OttAfJMuo5poEgjdqR5oPqFw7vDAUrEcPQcp7oW
	M5T6CYl3JOTZSPw2uxWOcvR3pByOd16tetRTY6ku8yndS368jNL7AZ0FV+MyD8uRTGRgMLN1OKB
	9UpeZfVVjVUqPrwdE2dFNpJutLjRzgx9ivkPnwSassbIM/hWCpcQJjEa4/b4Sm5dsOuRtw8v0fF
	TP4PNc6QhuSshK1z6CipnJ7W9+FrWz+qoLajff3CMWHH/6bfjPUSCsv656yoESrAP22uCs4/dBq
	fZC1E6M+VtNqeS7BoAglFqfiL3Y/g+ToIVQ2Dg=
X-Received: by 2002:a05:6a20:2450:b0:3da:80a1:f2f with SMTP id adf61e73a8af0-3db4051ed84mr11588239637.14.1789440232464;
        Mon, 14 Sep 2026 19:43:52 -0700 (PDT)
Received: from brighamcampbell.com ([73.3.69.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f739b5sm29474578eec.25.2026.09.14.19.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 19:43:51 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
Date: Mon, 14 Sep 2026 20:43:13 -0600
Subject: [PATCH] git-contacts: allow inputting patch via stdin
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-git-contacts-stdin-v1-1-9ac628e6fd20@brighamcampbell.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMMQ6DMAxA0asgz7WUpBUiXAV1IMEFMwQUG4SEu
 HtTOr7h/xOEMpNAW52QaWfhJRXYRwVx6tNIyEMxOONq4+0LR1aMS9I+qqDowAktNc77pyHrA5R
 wzfTh4552779lCzNF/Z3gur77b7lkdgAAAA==
X-Change-ID: 20260914-git-contacts-stdin-1e829930e19b
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
 Brigham Campbell <me@brighamcampbell.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1813;
 i=me@brighamcampbell.com; h=from:subject:message-id;
 bh=sbPSIC+cXUAhDpbkNm2K+OYoiIhmpRswGbEmafnl7Tg=;
 b=owGbwMvMwCUWLsWS0KCyxZPxtFoSQ9aKDU/vbO5a2pwjrWc9y/mhr7l2bPP3aZvvcEXtq2552
 ZmpxmbUUcrCIMbFICumyKJya5b6xcnWjw5G8E+AmcPKBDKEgYtTACbi/5eR4VSDwR9/uyaFp2GC
 W+bsSJpoUz7Fe9b6jWmsf3OTSz/cSmH4n+Pbelfj95pztZe7LuVdu/xvm1nUtmf9uVNWpG6TCp/
 3jBUA
X-Developer-Key: i=me@brighamcampbell.com; a=openpgp;
 fpr=24DA9A27D1933BE2C1580F90571A04608024B449

Make git-contacts accept patch contents via stdin for better
interoperability with other utilities. Read from stdin under the
following circumstances:

* stdin is not a terminal
* argv is empty

Cc: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---
I authored this patch as the first of a two-patch series to enable b4 to
automatically determine patch recipients. The second patch modifies
.b4-config to wire everything up. I discovered, however, that b4 doesn't
yet pass the mbox "Fixes " header as it should. I sent a fix to b4.

The second patch of this series will therefore have to wait until the b4
fix lands in the latest version, so I'm splitting up this series of
patches to git. This patch is useful and warranted even by itself.

Link: https://lore.kernel.org/tools/20260914-mbox-from-auto-to-cc-v1-1-fbf0c3fbd460@brighamcampbell.com
---
 contrib/contacts/git-contacts | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-contacts
index 85ad732fc0..52f6fbd044 100755
--- a/contrib/contacts/git-contacts
+++ b/contrib/contacts/git-contacts
@@ -158,7 +158,7 @@ sub mailmap_contacts {
 	return \%mapped;
 }
 
-if (!@ARGV) {
+if (!@ARGV && -t STDIN) {
 	die "No input revisions or patch files\n";
 }
 
@@ -178,6 +178,9 @@ for (@files) {
 if (@rev_args) {
 	scan_rev_args(\%sources, \@rev_args)
 }
+if (!@ARGV) {
+	scan_patches(\%sources, undef, \*STDIN);
+}
 
 my $toplevel = `git rev-parse --show-toplevel`;
 chomp $toplevel;

---
base-commit: 47ce80527c56f462cb97db4ca8125342204d3783
change-id: 20260914-git-contacts-stdin-1e829930e19b

Thanks!
-- 
Brigham Campbell
https://brighamcampbell.com


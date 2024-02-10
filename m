Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50BC1E4B0
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 23:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707608134; cv=none; b=a23A3Nd5NNg4b9FJ8y1oYmUahkqMR80a61eZJLpRw4SfCPLdFr4Mhu8Bh2kksGIw7144BHU+91iWbnpxhSD1YbCzlAaHBZ5sjNVZ2QKdhuSQz6PErLUt2ZLcT7KtxLe1r8PqXqAvpGQCFcs8R/aQ71HBmtHc29UfinqVvMIoavY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707608134; c=relaxed/simple;
	bh=36RKem5NKEB/6iOSLBhqArImBStAcdgNqyQXL0JJNUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M0wvgMGBGYx0qO2OQpU7QVmEBpYFao/Yd/gB5XYkE7O9ZMssJ1AH+vaJ+9zzRVgwzPSO9psqi4w3kFXeO8iZ9Hv/UiOx9qqNhTdO7ikpOLMYg0BbEW235Tieo59ehxOopAlDHSMZImDkCwEp9ZzPVSP3TxbZDa85fetovTKghtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DY9pHBPx; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DY9pHBPx"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-783ef8ae70aso138025785a.2
        for <git@vger.kernel.org>; Sat, 10 Feb 2024 15:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707608131; x=1708212931; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ETwqNh5LjfP5DeXp5YlxqtRiOLNbhPU2EJ7XueDLU/0=;
        b=DY9pHBPxXzI+V6naE3aDiuFeQrd3GOY8dpu2sE4txQ6Efs5hPnzKQ+MuPh6qTMZhxE
         AevKIrt6M98f2ef6I58spkBYfr+zFJ3o3swT79Gt7di7nQj8uk6kVz+QJHj7dYQsoQoT
         pAGB3dJjN0dfl8WcOb6lGrMzQWEV5JUAN37B4z853Cn4Fk6BYLDO2bfWAojjklkaBVw5
         dXWope/h8E71SopvIA1nm5OvqGYt/4E0uC3924OUIakX3jI4734+Y2UKXzUKa68x9di2
         dQEitT+7WsCB4DoNTmvGmO9dxfd2eWaBzawq0Mf9H0gCbBWC1DQtoLbJsDnuL8TLRJUr
         ehKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707608131; x=1708212931;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ETwqNh5LjfP5DeXp5YlxqtRiOLNbhPU2EJ7XueDLU/0=;
        b=u2nfqfaSsnqyRPSPQf5CggXDgxTeeyEdvKikahNvg6Aw2+QgEl1W0Sk5VYZqGV+zV8
         XACafV9/6E1SIwnzRb2M90S5Vcfp5Dvpq+gaGrN8h6V783M5GA06qDWWMPEseHK6UAf/
         pbovBabyzZp4lROQnwPInFwsibhEatX33KlGpcP5A+/JZPN5pRsOLFcweOZrK+xwc6hb
         hln/mYlkpjUZKO1GHPlg6qvayALWGNhZr6H5dTB8pX7OWXYAmgyav99UvTT/KBJwXjzs
         fxrCVqFPFcPMWqV4/DtNeHRyOCKVqxNMCMgVyTYhRReUg49mIg+OJOB46fdN+UV/WNyQ
         jsFA==
X-Gm-Message-State: AOJu0YynRmRwrt66bR1v0RziZkI1M0o2vxZOCsIKBIljgg8Wnt/QabU5
	zSAXKd1SjRarSAj2V84ui7Jw/oI5LPutmD6MMCZ1CNsJkqbYP53xxCr4OwcAVsM=
X-Google-Smtp-Source: AGHT+IFhqZ8qj1e2COfhIf7lY0kIvV/1EmBV2SD2jp/F+JhBGco/4vlLK3WI+GLgcstaUsizP4HXpw==
X-Received: by 2002:a05:620a:8119:b0:783:d709:54a3 with SMTP id os25-20020a05620a811900b00783d70954a3mr3126060qkn.32.1707608131456;
        Sat, 10 Feb 2024 15:35:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWLlEIi7w46bZAdNUUJ5/Dt67mt8nfZN4v/5BB/Qnqul2iVlArWUVhgXHciwn0ZDzoUXNV11Xbeu7j/G9ROheCxEg5GFIzhwFyAq+INL6FNuZpZ2V6jzt0cUOkFAcx+hkmZ/3PmnHUd8iobLPx4m+2CRhZ23a7fbm1s57Psy5UiXfVVPGaQTfhvL9tDMq6Rg3UuGqIsniGAmMgV8levSQVKWQ3RLyF+ZAyt7lk=
Received: from [127.0.0.1] ([2606:6d00:17:3855:d82e:7889:6cb3:5f])
        by smtp.gmail.com with ESMTPSA id qp9-20020a05620a388900b00785c9ea7974sm571942qkn.79.2024.02.10.15.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:35:31 -0800 (PST)
From: Philippe Blain <levraiphilippeblain@gmail.com>
Date: Sat, 10 Feb 2024 18:35:12 -0500
Subject: [PATCH v4 1/2] revision: ensure MERGE_HEAD is a ref in
 prepare_show_merge
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v4-1-3bc9e62808f4@gmail.com>
References: <20240210-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v4-0-3bc9e62808f4@gmail.com>
In-Reply-To: <20240210-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v4-0-3bc9e62808f4@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>, 
 Michael Lohmann <mial.lohmann@gmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt <ps@pks.im>, 
 Michael Lohmann <mi.al.lohmann@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.13-dev-71c1b

From: Michael Lohmann <mi.al.lohmann@gmail.com>

This is done to
(1) ensure MERGE_HEAD is a ref,
(2) obtain the oid without any prefixing by refs.c:repo_dwim_ref()
(3) error out when MERGE_HEAD is a symref.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 2424c9bd67..aa4c4dc778 100644
--- a/revision.c
+++ b/revision.c
@@ -1973,8 +1973,12 @@ static void prepare_show_merge(struct rev_info *revs)
 	if (repo_get_oid(the_repository, "HEAD", &oid))
 		die("--merge without HEAD?");
 	head = lookup_commit_or_die(&oid, "HEAD");
-	if (repo_get_oid(the_repository, "MERGE_HEAD", &oid))
+	if (read_ref_full("MERGE_HEAD",
+			RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+			&oid, NULL))
 		die("--merge without MERGE_HEAD?");
+	if (is_null_oid(&oid))
+		die("MERGE_HEAD is a symbolic ref???");
 	other = lookup_commit_or_die(&oid, "MERGE_HEAD");
 	add_pending_object(revs, &head->object, "HEAD");
 	add_pending_object(revs, &other->object, "MERGE_HEAD");

-- 
2.39.1


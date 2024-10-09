Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1248417BEC5
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 07:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728460707; cv=none; b=fDovnuOUTOVm9E1LBCGkeq0aHBc9kzw0sMvAgoR0QvTB5C27vgHCNmqjvus4zLUrwsoqWDvJvkTE82A8Rw6LhuHBJtNmt8DHBS5FM8MPucsy+j596QEUmJ8owdnFFTcO5l/ZjDQyFN+QA9zFPVQxmrCk4wAwyYwmHrfH65t7LSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728460707; c=relaxed/simple;
	bh=NmI1eWkVK50hGlaljjYOi+mXXxgNpdpJhOVxWJdx2UU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=W9bjtnlcOC2OmyuKY9rrLUQI6yYI+SENp0N+vMH+PiwN1wiwwyx8KJ5ehma6vfmavALHSdKWLlmBDtggz5KVDPaUg63ImtJvw4hHiiQwZA1AfwYNkez030XPfkPpP4D5JGQo7spGvMKxgNs/ioGZrdsjfeKyFaPixy1DaWiOIck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaJ7imHi; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaJ7imHi"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c8967dd2c7so8051752a12.1
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 00:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728460704; x=1729065504; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8/AU0s2/N0BDJJGcVeSY8sR4P/MU5YBpYYWLkQ84L8=;
        b=WaJ7imHi3PkKFbSXPKPrGiYOHnxfy5uc5srL3k/2+x2pfTw19w2MccfTuopjC11w/5
         0Vu+aUVKZX2miap6yWGBkREzt19ECSJyg4+kfjQI1qlsDaNrGLvCv2fzyii5NUp8kvax
         HHJhvZNUhsg00oR8/W+rX7vDx60LbT6BEYO7dYzj5Fy4reSFOgT9gBbFrusxIjaLNbDT
         QQQmV7N6sDLdDevsDsvZR0H+8kQvmCyeVFTY4DlEMYD6uWzRVhGiZMqEmWJM2tBcH97A
         /VT9K4sjeqELw3EWCWv5Vd4BqYJwBdWkvcW+mIgifYA9fJDoyprXH1Noc0vQyCos0y8j
         b5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728460704; x=1729065504;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8/AU0s2/N0BDJJGcVeSY8sR4P/MU5YBpYYWLkQ84L8=;
        b=mYdsL2OKg2AivZKBl0KZ5Noz/OOJ1JI+SgdzRAvPz5lnW2ZBBXEp2n4RNPtq2fzbED
         52JjzXyucOwdn5GRa4tGF54feRW9Xe0qbmll1OMT+UCv4NFaryUQkORlYxyVoFZZa4Zn
         cb3p6R4dFe7a7Io0izWO6AOr0DF5W8gG0Zun4Hm2DsvTQof2m9fG39cyoWFd0PAsTst3
         iBBSAAsA5fAxX+KBsObeeaFAgKq9TPiZ+RdpXnz26Um6eGeoteiM4S56qfryppjbQZcd
         AaKgVit7yBGPpHukuXAlPL6NX0QNQyRqq24ijT5ePu+xy/JCz9auQK2a3cwZ4deEHXgu
         NzLw==
X-Gm-Message-State: AOJu0YyAO1hlSFDxPHPionyHw/yyJXN7gGmsdiYWvG1jbL5nwUbv3Wi6
	culMwu93wngWo/oh/wSvz+QmKsoGXszRdWIvDebrVADC7srDZY+wHFRcVw==
X-Google-Smtp-Source: AGHT+IHRNN2d4Mx9t3oHbWqKy+o04UhUb562TSgxMo77/yJY7B7ElIQgb9/pdLce0hkkQaw7SB8m3w==
X-Received: by 2002:a05:6402:40c8:b0:5c8:f9d1:dfdf with SMTP id 4fb4d7f45d1cf-5c91d66392dmr1366208a12.27.1728460702988;
        Wed, 09 Oct 2024 00:58:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05be8d2sm5174919a12.53.2024.10.09.00.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 00:58:22 -0700 (PDT)
Message-Id: <e030ddd91f365b870332467057ab054bb34aa4cd.1728460700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1784.v3.git.git.1728460700.gitgitgadget@gmail.com>
References: <pull.1784.v2.git.git.1728084140.gitgitgadget@gmail.com>
	<pull.1784.v3.git.git.1728460700.gitgitgadget@gmail.com>
From: "Nicolas Guichard via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 09 Oct 2024 07:58:18 +0000
Subject: [PATCH v3 1/3] load_branch_decorations: fix memory leak with
 non-static filters
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Nicolas Guichard <nicolas@guichard.eu>,
    Nicolas Guichard <nicolas@guichard.eu>

From: Nicolas Guichard <nicolas@guichard.eu>

load_branch_decorations calls normalize_glob_ref on each string of filter's
string_lists. This effectively replaces the potentially non-owning char* of
those items with an owning char*.

Set the strdup_string flag on those string_lists.

This was not caught until now because:
- when passing string_lists already with the strdup_string already set, the
  behaviour was correct
- when passing static string_lists, the new char* remain reachable until
  program exit

Signed-off-by: Nicolas Guichard <nicolas@guichard.eu>
---
 log-tree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/log-tree.c b/log-tree.c
index 3758e0d3b8e..c65ebd29202 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -232,6 +232,11 @@ void load_ref_decorations(struct decoration_filter *filter, int flags)
 			for_each_string_list_item(item, filter->exclude_ref_config_pattern) {
 				normalize_glob_ref(item, NULL, item->string);
 			}
+
+			/* normalize_glob_ref duplicates the strings */
+			filter->exclude_ref_pattern->strdup_strings = 1;
+			filter->include_ref_pattern->strdup_strings = 1;
+			filter->exclude_ref_config_pattern->strdup_strings = 1;
 		}
 		decoration_loaded = 1;
 		decoration_flags = flags;
-- 
gitgitgadget


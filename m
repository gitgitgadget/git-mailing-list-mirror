Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FFA2820C6
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 19:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761851995; cv=none; b=scmMvhEhAyBTcnCDN7EUlUpZ5vjJmupx6TtkQNL6Newis9mVGUTu1dadrazgyPzcO7+vE74/j8GyI3PcQ9Y+LaKVHyo7t1cNR4N2EyJg5QEKlZe/+pPjqOnNPm7ORs9q7zQ6ig+ySayuzg/g9APpuDwKUVRH/n/KeRon9lBDlSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761851995; c=relaxed/simple;
	bh=c7zHYS0aPxOwcgULMEQGFRVzR7TuPNzce7/usx3rKiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYCh+KWxW3QBhmGGytAd1lepFSkAHQE58NzkGrxZzaGKpZ2uRezGU26dhwlJcMgxRdiMoL54O4eA0Y8BDu12X5knw7QwW1VCiCqqGGuwi5ePO2+/D0ndUJ0xRgS5aTrYUX/SCxMyBxAjP7DsenQxudZG+kaicKv5ShdIoHY/xKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ew6T/FG+; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ew6T/FG+"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7a74b13f4f8so440406b3a.1
        for <git@vger.kernel.org>; Thu, 30 Oct 2025 12:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761851992; x=1762456792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2BmJibt7RuBp7ck9CaYLcxRtdyx0DYj4AxYn8lPYbw=;
        b=ew6T/FG+NfVGIqbuYXq9JTs3QWGd1pxfGI8XLbhIWUnuVeEzWxnooE5vAykFez2ouW
         sBnHm6YylqV5GjhPnXlCoaAJ97RwkIXaM4Bom7CmJ2NYnumHYYlQYuYfd3SCyKyIGwaO
         kShs2WcU3ePK3pmYwFtzwvHJqCLV3Ug38CfMP38GVe83lshTp7PpTN82GnTiSX7kutFp
         13Dui9k71U1BYrRyUyMIvW7lLS0JpkDlM0RDfNkAUqWxRAajPE2eEhLJIyktmY8YGs5O
         4sIg8fwmyahIrZhyhJxX1bU/SEE8/4tmgAgomBKTb5OIuuKaXLoDwFAXtCYfvr80gV2t
         umTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761851992; x=1762456792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2BmJibt7RuBp7ck9CaYLcxRtdyx0DYj4AxYn8lPYbw=;
        b=oUcbJ0q5wiumIqumZQ2cT3M3EsFrq63ZYeoXvXBAZQkFP4SiVxXaPjo77Qw2rR+aLC
         WuaC8GJG0LnE7xHTfhmA3fmjEw53zWl3cPn2MCUq8HVYcJq5BWKy3hI7RphPDBGyldXR
         sV5dFHCzMK8OeXwWz2zAPXqapf1Ct/zFs3dtxmWLj7OX2n8V+2wtAMN8YHA42iNsgSWh
         HPaZWd1R9POWFRWHLi98ksnqTGa87Kx8rbEb3caV+qF9b1NO4QJ4xSJCjpgYni/8D5RS
         FdonjPvq4nhudTElmR+MfCa1FTJ+vgqITLfVCa+lYrPRaDVkNWmVoDl3g4kFgCAO/0zs
         tYPA==
X-Gm-Message-State: AOJu0Yzfs3WrhCXgiOI/lpKYgvQY8xbIGKhSbtjTS7X49aUjU3YqS5Y7
	3YC0HH7p3Z9BW+oJhvdyA+RPPXWepFdwIda7AgMKptqTYmWeSgBpaC4GauvNmSKja7A=
X-Gm-Gg: ASbGncsA8+wmmKCe26KNEVqGgZTYUEk/GhNFeWVCw6wiFT0pf4k/IeT6744gM4MAep7
	h/pDjustFCBSKWw/gqSyq7wBLT1UMGivbPk3gemyXA5+VL+n0inXUOAUN9cuoCkfwy+MxcDID/2
	4fIJ7sCK5rmpxZtgZQXy9P0Qzztm+b/vQhCcylDUSbAapfQLuO95mVldZe/AU3HhtoDmEmHJfvp
	hXF2jioA+Uy+GZuaIrs2gUWKDVwtsMCDbPvFGMxx3IH+1nDAQHrF0pn0sRo5XQg4eXCi+PTamE1
	+rtmQ+r155TTnOzcKGwKERXyyykRBH6++LpSkYX92DLt3LIVLXJ2GY1XhWYRzR9MOUEE2uqngv0
	ftpI+Ttd9Dz78EyCEDw45xvCCuobJwJpSJPXcGhe4R12/ifOXBmHqyHGlqQgGgzmsMv8FgLt74F
	zkRMyIMDtmnMlFJ3RdjuqAJRlaMwHsyoMqiUev1rtv+rXBubcT0cMEJHdCWJ6FR53UPNFlcFqnG
	gZ1VW5ElQidfDJAqxbL6b4UBXY1moQJhg==
X-Google-Smtp-Source: AGHT+IFVJ7CfbWxQogQESnD06ISp6eLesMqcY/JEzDlhQ/hNOU39W5GAqxji81XDfNUhc9eWxBMKgg==
X-Received: by 2002:a05:6a00:391a:b0:7a2:8343:1ac with SMTP id d2e1a72fcca58-7a77718a0cbmr667978b3a.2.1761851992413;
        Thu, 30 Oct 2025 12:19:52 -0700 (PDT)
Received: from localhost.localdomain ([2409:40e3:177:42ef:e197:ba89:d0f7:5538])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a445156004sm10359135b3a.51.2025.10.30.12.19.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Oct 2025 12:19:52 -0700 (PDT)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	phillip.wood123@gmail.com,
	phillip.wood@dunelm.org.uk,
	newren@gmail.com,
	gitster@pobox.com,
	ps@pks.im,
	karthik.188@gmail.com,
	code@khaugsbakk.name,
	rybak.a.v@gmail.com,
	jltobler@gmail.com,
	toon@iotcl.com,
	johncai86@gmail.com,
	johannes.schindelin@gmx.de,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v6 1/3] replay: use die_for_incompatible_opt2() for option validation
Date: Fri, 31 Oct 2025 00:49:29 +0530
Message-ID: <20251030191931.30837-2-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030191931.30837-1-siddharthasthana31@gmail.com>
References: <20251028214609.10041-1-siddharthasthana31@gmail.com>
 <20251030191931.30837-1-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding the --ref-action option, convert option
validation to use die_for_incompatible_opt2(). This helper provides
standardized error messages for mutually exclusive options.

The following commit introduces --ref-action which will be incompatible
with certain other options. Using die_for_incompatible_opt2() now means
that commit can cleanly add its validation using the same pattern,
keeping the validation logic consistent and maintainable.

This also aligns git-replay's option handling with how other Git commands
manage option conflicts, using the established die_for_incompatible_opt*()
helper family.

Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 builtin/replay.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 6172c8aacc..b64fc72063 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -330,9 +330,9 @@ int cmd_replay(int argc,
 		usage_with_options(replay_usage, replay_options);
 	}
 
-	if (advance_name_opt && contained)
-		die(_("options '%s' and '%s' cannot be used together"),
-		    "--advance", "--contained");
+	die_for_incompatible_opt2(!!advance_name_opt, "--advance",
+				  contained, "--contained");
+
 	advance_name = xstrdup_or_null(advance_name_opt);
 
 	repo_init_revisions(repo, &revs, prefix);
-- 
2.51.0


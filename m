Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBE2374197
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 17:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769102149; cv=none; b=sHVvaOnI7Fo/U626XPKfAg7BC63XvEleAqHRKtzBDSHxHPwoW+Pk4uY34+8beidzdYp73VS1ITlfQaSdq898jVaOaBKm0vbSNxnEv6K2QOzhJjpG5EhzT3WzScl6qD70S83RI8L0ADBGxbNEJOf10Z/H+9dASFje3oWDOYnOtxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769102149; c=relaxed/simple;
	bh=4/vCmaZn++j+tmfUlkry8NtAaqxIzAFgUCCuPUkHMJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MoyTOjFCocnsT2bpmEYL8/jl+wyMXAa9Ii90lEPy/e2UJCmWkiJDFUQ5lxCVSRZ+VWdIACJw+mK8PSd4FPdbO/e0QKhWrs5fUKZ3myOoVQIe7KNfFLJh23XdtpST+y1cztbSeiXfwgxTzdSWeCFyR3UGV+i7zYpmivAGq0kox54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/y0N1XA; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/y0N1XA"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-bde0f62464cso434730a12.2
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 09:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769102143; x=1769706943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpOnG7AZ8sMEQvbQxV8b+xEK28KWnSg/Gg4yOmSUybM=;
        b=m/y0N1XA+Wo1wYKPE1qhzMCQjQqqmwafDgPR+UftINWidIMlONST4swdEdNal5zw0c
         U2+rzke1uT7gb66I3LMY+UAwdnZchVK3O7HTVQ6rwQ+AhEFTbFnPM5IWobCMSSOlFIcd
         VFDGLIYL4+WUrgb0YH1xnLYYOpwEau8LdbBTBzVeqvy4Hj4CcYrkWpwcbBx9pp5cSEIG
         ez0AQn+TNSvVvQ51dFRvqrXHb+6kIBMo1OFOsT9vxozBP2eWFjoOi0GcQX7KiYlvvpQV
         XG+8p0Q55ineeFPqVGYEZtgy/7gCRr3fXi9nAUceTDl6VI/Rwr+rdq1aFpLt9PhpnOcl
         irIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769102143; x=1769706943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SpOnG7AZ8sMEQvbQxV8b+xEK28KWnSg/Gg4yOmSUybM=;
        b=sVa3mJ0tkA0BtE5H/Mw3BqN6Ei/4SkASmmIznZQ7OmCr751Vz7opAus9uIqtijlwYi
         H1+wzDm4bla4UzcUFg+5ON87dvG4kSdEV3x1S7XBoUX4fFXowDJFev18/3Xf/mSOJwXt
         SQMLmV0XIbWjBd+BCPPC1R6uvxpbVDUo3IyH5Pzx/oYrr52db8MbonJFHVRsu083jF5W
         tLg+nIQgNxFxbD/HUqK7bpYz5xD9efR83mrvUTbtPWvcSZHbFsfdQyybcDqTAWU/atow
         TrLGGUI3wxMI4vbvmJ67J1RRwThTWXPUyXlAJqshqCT0RfoKhZml4DbahYiDnQwvDyeN
         BPvw==
X-Gm-Message-State: AOJu0YyCyN+IJx9f0EcGyj0ioXocvyZN/hKj1PnNWRbPfIo0JAkn4iqE
	LHv+B8CanE4UIC8FBhfpRIYCU1ycNVgHTKL+RnpMkW6E/1bqw/owk+Wt54J0tAQB
X-Gm-Gg: AZuq6aLxe2Cs5y/NhEIWeSyyGQSJNiWcWFp+Khi3/Lq5FKs2SHoFa2I0UwJQryMfbTS
	xl+qbGP3csX4U6FLbQWHD7P2YxgHO5cH2IRwcr5b7fR6Gey4wxQQUp/QybYQnXpRmO27yby+Ue0
	2ywogD8RnJEgtwKjZUx/FRw3z1wa1emHnw7CUqMNHSB5qisbBkgbEP3HOCEPIkgAmH9TOrCtNtH
	EXMnGUo01qN3UpWVYQf284ZN9FRQg/g0rCxTqIDLDylXRBc92OsMpaYUojz1N7fZfGarmMI9cQg
	pvSEzy4TbmzvpXCuiZ+E8yLBraiO5AqUqjjvUhMX78648at48fsr13ncfbco3t7rz31Po06D3dK
	ZjcmpFRkb7ja/i3tdMQKpGY8HUtPe+aMMgbuXS1eqAtbCz6t51ArIlz2LsbDK95qquV8lO03PNm
	DQZyuVcD1L6eNnX/kg6Rilwa1ksejHQOQibNII4MNfhNLZqFiq0zb84sxT8ZAt4jjIAJ0m
X-Received: by 2002:a17:903:3d10:b0:2a7:80ac:85b0 with SMTP id d9443c01a7336-2a7fe43ed60mr1737015ad.2.1769102143106;
        Thu, 22 Jan 2026 09:15:43 -0800 (PST)
Received: from localhost.localdomain ([115.98.234.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a773d4e5basm81557205ad.94.2026.01.22.09.15.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 22 Jan 2026 09:15:42 -0800 (PST)
From: Amisha Chhajed <amishhhaaaa@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	amisha <amishhhaaaa@gmail.com>
Subject: [RFC PATCH 1/2] Adding string_list_sort_u which sorts a list then deduplicates it.
Date: Thu, 22 Jan 2026 22:45:22 +0530
Message-ID: <20260122171523.94234-2-amishhhaaaa@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260122171523.94234-1-amishhhaaaa@gmail.com>
References: <20260122171523.94234-1-amishhhaaaa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

string_list_remove_duplicates is almost always preceeded by
string_list_sort, hence adding string_list_sort_u which dedupliactes
post sorting.

Signed-off-by: Amisha Chhajed <amishhhaaaa@gmail.com>
---
 string-list.c | 6 ++++++
 string-list.h | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/string-list.c b/string-list.c
index 08dc00984c..020ed8fef7 100644
--- a/string-list.c
+++ b/string-list.c
@@ -247,6 +247,12 @@ void string_list_sort(struct string_list *list)
 	QSORT_S(list->items, list->nr, cmp_items, &sort_ctx);
 }
 
+void string_list_sort_u(struct string_list *list, int free_util)
+{
+	string_list_sort(list);
+	string_list_remove_duplicates(list, free_util);
+}
+
 struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
 						     const char *string)
 {
diff --git a/string-list.h b/string-list.h
index fa6ba07853..3ad862a187 100644
--- a/string-list.h
+++ b/string-list.h
@@ -239,6 +239,12 @@ struct string_list_item *string_list_append_nodup(struct string_list *list, char
  */
 void string_list_sort(struct string_list *list);
 
+/**
+ * Sort the list and then remove duplicate entries.  If free_util is true,
+ * call free() on the util members of any items that have to be deleted.
+ */
+void string_list_sort_u(struct string_list *list, int free_util);
+
 /**
  * Like `string_list_has_string()` but for unsorted lists. Linear in
  * size of the list.
-- 
2.51.0


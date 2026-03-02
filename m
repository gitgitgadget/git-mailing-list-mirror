Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F4B387584
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 20:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772481674; cv=none; b=ta361jYAgUlU/IjG4xgIMxxm/6Ov8Lzj0tl93oEjNCZQV4OoBJrUM8PDNbZMtIPlC1lHefrAVXK5U2LzEXSiC3NXAgMiRE4VuhKsxoXrq5dFC2Hohpnm5M/kWrMrrGrgtsbKur4GCHMosy4tdZrspmw0tv4iMuBXg5g6Y3ma0p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772481674; c=relaxed/simple;
	bh=zflbIZ9gt96VXLr0l9cDCiUH825vOTFRLmIGJ3kK7+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LYZvQb9Vd43a67af75WHIHx5AZoj/OYXdqs7eDde7IZ4iRG9nO2WvPpAg5q7pKWHFHnFmYWSsexXsKYidgF86UlWhiAeYp7rZE/LC/SENWcqk9+BiyqA0oXFY9ELOcfK1uADWH9vsw4hCsOk7Dvl8DDh8O/K0MZlgq+DaVHXpV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HygPsVnh; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HygPsVnh"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4836f363d0dso43052725e9.3
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 12:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772481671; x=1773086471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pG+sgb+bQh4ZCrq8hsbc+XzS8OPi08QixnLVdAvcpII=;
        b=HygPsVnheAEikfhLIEfrkJL8MrNtJEM+pQwWJcGupirtuCM9KL6AOTw9bSXN+eKY0Q
         TC1iN+Cv1dpgqQO/v3Ta/bxzS1gZBysiSXM0ku3O2UQU6TmVbFUQ8F6udGwwTefJb8DF
         ylFhODUjnnrVk20Eu7Ms9npb2RHeM0SEBXKY2sew46wKGwQK0B5Q8NZT4LqBaEi/FLY9
         ZHjYzOXfG6/zXVxUaRb607W0zJmY+gWTIZdd5HNE40487CN+XorAh13F6TrNa42Dz2Ns
         i3wBHWdgGcm7ESv4iNjf7WKBifE9p2Q4LBTI+sjhjpFE5pkUjBa0oB61OGQ3IBvlXxcM
         9qgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772481671; x=1773086471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pG+sgb+bQh4ZCrq8hsbc+XzS8OPi08QixnLVdAvcpII=;
        b=MnFbvPf7XUZWBQg0/nY1mj9BS1MMa+6em5reJZYZWhMLBhyvvABF0nndZ1Swd5mkfI
         7yaXNOMTtyGnC+nx0sJu7m/ktJEjxvpJaWiqZ7AaoQ7j0LyEJIT4pPErZnljYMKGV50e
         eKYIRsUjgLTlLbiXBtS58nEgMbNdfPZaw88ovEtD8yRwXT7TgrOnqTdNCk9aIhRxhOQ5
         XdeHAuDnH0uaP3alIbSp+i2IFiiIPBc+VefoEnuXINragUaqpR5qJHKseFzmKSXPpiPk
         V2Cb9j1i7DnFlA7L6+xkJ5ngjG655gSaPtaPZfaG3ku4utnxXgBjEz+y0fEfIq+5xajx
         6VNw==
X-Gm-Message-State: AOJu0YwstWuUdbXDBbAgkjIYYOURMf2vQtg0oRam3F6TNvV/eFaBoKO7
	9D5LuM8he60++Naj1uyR0GwGvzVi94vNl95aQxcKwiuGvPtyCPZROeDmo6K88AFv
X-Gm-Gg: ATEYQzwQGnPzE3MlzJmMuUblPsnKqnE9qLvaWQo3gWZJcTTG/KtgG5QgMA5zam3vNEj
	2OIkg+3bHIDtksDhrCn4Yfau4EekL1pAibjCxrdcrYYIIfZaqPrVNl3e6PAQ2WQOrC4nqwQi+jt
	UUKy1qM28Yl8Y+WZ8OwdCGXecf2uJYttMYAfhkkMj/iAS93q25DM48jfwRbepSOUUOrCH7dzLtE
	4zlzWGdJvIWdY/aVlgKrRT9ZhlCqYYwSFX5w30TJfG3wyacFwNNiPbHpfad/d+o82p1+5tDwG2g
	aqOyLXtdD5uf4D5x9bokC7G+hvE+hIm0Vh4e0LHUHW00citcD1p2bTIaPU96I6Gz5ZBNo/Se+gF
	LKEyuHEYUHW+1dVtuILihuYsUkljd5QYTaIYeKRdKWZZOaeP70pcOFgQQyMwCBgYijRoGzTrMV5
	JmLh9EIbXrymdZhT1YONPqYlfRekdwNL7gLrwSu0frZhmnCmMZSv+7OrPPmNbBM+BO26NnIf4=
X-Received: by 2002:a05:600c:1989:b0:477:561f:6fc8 with SMTP id 5b1f17b1804b1-483c9bb1d3cmr249736695e9.5.1772481671001;
        Mon, 02 Mar 2026 12:01:11 -0800 (PST)
Received: from localhost.localdomain ([105.113.67.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485126547absm446875e9.7.2026.03.02.12.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 12:01:10 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Seyi Kufoiji <kuforiji98@gmail.com>
Subject: [PATCH v2 2/5] builtin/rev-list: migrate missing_objects cleanup to oidmap_clear_with_free()
Date: Mon,  2 Mar 2026 21:00:14 +0100
Message-ID: <20260302200018.75731-3-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260302200018.75731-1-kuforiji98@gmail.com>
References: <20260227234213.17633-1-kuforiji98@gmail.com>
 <20260302200018.75731-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seyi Kufoiji <kuforiji98@gmail.com>

As part of the conversion away from oidmap_clear(), switch the
missing_objects map to use oidmap_clear_with_free().

missing_objects stores struct missing_objects_map_entry instances,
which own an xstrdup()'d path string in addition to the container
struct itself. Previously, rev-list manually freed entry->path
before calling oidmap_clear(&missing_objects, true).

Introduce a dedicated free callback and pass it to
oidmap_clear_with_free(), consolidating entry teardown into a
single place and making cleanup semantics explicit.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 builtin/rev-list.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ddea8aa251..ab5f69826c 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -88,9 +88,19 @@ static int arg_print_omitted; /* print objects omitted by filter */
 
 struct missing_objects_map_entry {
 	struct oidmap_entry entry;
-	const char *path;
+	char *path;
 	unsigned type;
 };
+
+static void free_missing_objects_entry(void *e)
+{
+	struct missing_objects_map_entry *entry =
+		container_of(e, struct missing_objects_map_entry, entry);
+
+	free(entry->path);
+	free(entry);
+}
+
 static struct oidmap missing_objects;
 enum missing_action {
 	MA_ERROR = 0,    /* fail if any missing objects are encountered */
@@ -935,10 +945,9 @@ int cmd_rev_list(int argc,
 		while ((entry = oidmap_iter_next(&iter))) {
 			print_missing_object(entry, arg_missing_action ==
 							    MA_PRINT_INFO);
-			free((void *)entry->path);
 		}
 
-		oidmap_clear(&missing_objects, true);
+		oidmap_clear_with_free(&missing_objects, free_missing_objects_entry);
 	}
 
 	stop_progress(&progress);
-- 
2.43.0


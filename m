Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB511F2395
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 12:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734439181; cv=none; b=C+T2KytM6olj0A2fCyPCIMziEZf1vIfvEiQorv+7guKnZFMHYK87ou9TmJO6DcdsAfSKNRgPW8WfUR9lOjR9tdVI8dAIhxhrOUtrlPj1oPbKGSwdCfkR7pQZkSBe9x+xeHzt4K5yCtnw7RQutp3yxuFTw1I+B0A1GWWKwsQkazE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734439181; c=relaxed/simple;
	bh=1KC96zSPmHJya2DIzaL09EhECZ5b8CYsxTP7yoV/INU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=jir5zXEA0D3UO3lNn7TCQ2URQq6LzgrzHdV24TVRq48f3Lr3ayb4H+OkkBfHGMyZ5MwFcFEHHcxsbZwHwMfAmUum/bbK6feybT+kCnhKGhve1uaV2WnwqmAi3oxIzXrtobWQr/QSGg6jMs+WogAwmn+qaAj5QdIz+gAfMjxl1zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Az1/pXz4; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Az1/pXz4"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso37878425e9.2
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 04:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734439178; x=1735043978; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MPJEHl7tw84DtsSczzVnMJZ8iuiLayGU4nsIWvmjYF4=;
        b=Az1/pXz4RY5ds6BIneSBX+j1KF1PJzQybuTiboge452yOeihyAT1QgDlzH87/qYNxW
         +kosafUUdSsoaRRl0ly0vljCIwZHC8hvCS8PZdClSjgUvIq/4E0NHWiPEdVTko/TcN6p
         0uP9efzfMKt0Qeu1/4os1baJfim1Tb5MDihn66cKkmSAdngUMxUNebFAbuzh2CF/oCR7
         hJJbajkyMi53z6uuFwdWLWqYgSGoNYqxBItVN+/OYS/slbPzsguGtVBqZTu4aB80TzdD
         QqGIdowqzyYWNq4XkUtWrCucat94acpieD8mQwIpVD5PF5ecagIKzWrpieOvJ0LkupPE
         j9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734439178; x=1735043978;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MPJEHl7tw84DtsSczzVnMJZ8iuiLayGU4nsIWvmjYF4=;
        b=RQotiumLfqkHmJp2MIkwmBDe1AQBIIaBJP4iQLVZZ9pyuoZ6VsfhqrF7vpODQq5yyz
         xI6C5y/bnWsUq1n1Mgi372SqwdmfheSrHD67X7L19+otXEsbhjWFxb1Q3RDMHmDlatV0
         TxVJqWOZBtoKCnlnWnBg99XJkWfog+uVfOIfzqDX1siRlCXTdUktsdVyQ3cFE8Jo1wIB
         PPd33NqZshVETA24vOuWjKo6ZHXIYTbKokm1ClEirXTu6qKCa3CFvikOQilOGcKTOWg0
         9iryW5/IjLeZySC2i5v35f1D+lrrPKd5AYLBlOctUIJVr003aqEkzMMTZxKW4A3+ET5T
         MkUw==
X-Gm-Message-State: AOJu0YyIEaT86rFf+eCeiPl/r5FixJuf/eteIz2oEyBy1ZwZDIFDSKeB
	hfh5kY9vWAzJnDtYOMEWbQ6Pf4ERJshtgSOqF+pj6cNMVzxWN+40WEgjkQ==
X-Gm-Gg: ASbGncuYdGp18BOVxqfC6VJk3N9ZHnhXS9T/NnaWI2OHEI8Zo9s+QnKRnq/S2trcwLg
	WP2jum84njP/uebK7glTkKqGcc53cDpeHKRPO3TEJqIaE8A5pfrQL/Zx2qtqbJwA5lZKrfHVA+H
	aMHBpNwB+4fwP5iW16M1b5mKwY6agTsvyHvCK81fXEzfEJar/XSEVa5yNqKRm2eIsHMXMMNHTdp
	ySkexAaUYfEyP77SxyX7B1WuPcybJaXUD6MkvbGKWF6I9Xd/yUscBmLLw==
X-Google-Smtp-Source: AGHT+IG4dhoFVZh2Bu93d6ac2bVPyHU88Cges+TYlwZXullxZZcuEytru6Os1ll3u8k2Zsk1x2Eo6Q==
X-Received: by 2002:a05:600c:3596:b0:434:a529:3b87 with SMTP id 5b1f17b1804b1-4364769028fmr38596125e9.10.1734439177444;
        Tue, 17 Dec 2024 04:39:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625717c9fsm171505435e9.44.2024.12.17.04.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 04:39:36 -0800 (PST)
Message-Id: <pull.1837.git.1734439176360.gitgitgadget@gmail.com>
From: "Wang Bing-hua via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Dec 2024 12:39:36 +0000
Subject: [PATCH] remote: align --verbose output with spaces
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
Cc: Wang Bing-hua <louiswpf@gmail.com>,
    Wang Bing-hua <louiswpf@gmail.com>

From: Wang Bing-hua <louiswpf@gmail.com>

Remote names exceeding a tab width could cause misalignment.
Align --verbose output with spaces instead of a tab.

Signed-off-by: Wang Bing-hua <louiswpf@gmail.com>
---
    remote: align --verbose output with spaces

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1837%2Flouiswpf%2Fremote-align-verbose-output-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1837/louiswpf/remote-align-verbose-output-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1837

 builtin/remote.c  | 30 ++++++++++++++++++++++++++----
 t/t5505-remote.sh |  4 ++--
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 1ad3e70a6b4..876274d9dca 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -16,6 +16,7 @@
 #include "strvec.h"
 #include "commit-reach.h"
 #include "progress.h"
+#include "utf8.h"
 
 static const char * const builtin_remote_usage[] = {
 	"git remote [-v | --verbose]",
@@ -1279,6 +1280,20 @@ static int get_one_entry(struct remote *remote, void *priv)
 	return 0;
 }
 
+static int calc_maxwidth(struct string_list *list)
+{
+	int max = 0;
+
+	for (int i = 0; i < list->nr; i++) {
+		struct string_list_item *item = list->items + i;
+		int w = utf8_strwidth(item->string);
+
+		if (w > max)
+			max = w;
+	}
+	return max;
+}
+
 static int show_all(void)
 {
 	struct string_list list = STRING_LIST_INIT_DUP;
@@ -1292,10 +1307,17 @@ static int show_all(void)
 		string_list_sort(&list);
 		for (i = 0; i < list.nr; i++) {
 			struct string_list_item *item = list.items + i;
-			if (verbose)
-				printf("%s\t%s\n", item->string,
-					item->util ? (const char *)item->util : "");
-			else {
+			if (verbose) {
+				struct strbuf s = STRBUF_INIT;
+
+				strbuf_utf8_align(&s, ALIGN_LEFT,
+						  calc_maxwidth(&list) + 1,
+						  item->string);
+				if (item->util)
+					strbuf_addstr(&s, item->util);
+				printf("%s\n", s.buf);
+				strbuf_release(&s);
+			} else {
 				if (i && !strcmp((item - 1)->string, item->string))
 					continue;
 				printf("%s\n", item->string);
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 08424e878e1..6586f020f74 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -249,8 +249,8 @@ test_expect_success 'without subcommand' '
 
 test_expect_success 'without subcommand accepts -v' '
 	cat >expect <<-EOF &&
-	origin	$(pwd)/one (fetch)
-	origin	$(pwd)/one (push)
+	origin $(pwd)/one (fetch)
+	origin $(pwd)/one (push)
 	EOF
 	git -C test remote -v >actual &&
 	test_cmp expect actual

base-commit: 2ccc89b0c16c51561da90d21cfbb4b58cc877bf6
-- 
gitgitgadget

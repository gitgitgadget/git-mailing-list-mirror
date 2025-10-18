Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5062028312E
	for <git@vger.kernel.org>; Sat, 18 Oct 2025 20:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760818045; cv=none; b=XQ0Fd1uLLJ6QDQPrOTUAPJCu2Ye9m49RQsB61aTNoi86PwJuUfSfLp8sG5DUsfDOs6isxMb+OYWGZRX86qCTGaLoAMDwe4jVEz8tLIpGE9NjwepPqFczHuJGxhSub+sTjW1O7ok7BtkIqLBpbaxaLjvrqVUFKrq9ADRqGMW81VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760818045; c=relaxed/simple;
	bh=E+6Z8q1IRDFxcVq3cSV84TESHewzcb8CkvTa+gfPlcM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QMnRbalQMjRHMLMiP8YpZbkQcdAbEN0jQWjXxankqL29lWh/RPS6OrwqxUgUpS5UrjGi3NsHFI3w4UiGFIzgZ8SpRKYafBXXciJxHr6q6KEuN8wQx8S8UDjGvlSeTnqHKsbtul2xYpL4M4Q7rJQqSYhWOk8NayPfHBAv0ae3lLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6xkP+jk; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6xkP+jk"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-27c369f898fso43532005ad.3
        for <git@vger.kernel.org>; Sat, 18 Oct 2025 13:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760818043; x=1761422843; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9O2aZWzmQCtYCJLlG9l6Ex0Xf13OrdTnNoMgdr9b48U=;
        b=K6xkP+jklsZe4FS4oS5hp7xWpSaB3AGWFbZNThcRELTzPypNxyMdtfanOoo8sEHAVJ
         O9l1xIoJog11mhr5YAL/Wvq4c6biNfQjD6e4TNDeiWtJ9qnPVpoA59I/SSvbQDn9TaPY
         w5HGrYdBsTcloAB0654gKKhq7XEmR2F6wPKTfDUoMgz4xkBXd8I8aaK3KYPWMw6OZYlJ
         MYVg1OvTknRIJ7EGfPq30ATnUnecDQVpXuiER57QAEA80Pfoqy7pF1vgBBfMWIjAhm5J
         BO1yUZB+XYD4YkVvFeiVwpU10l9iC1VgEGrFBRVNGUEuTyMBWTDjqwUwQk/52cjTuxZi
         p9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760818043; x=1761422843;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9O2aZWzmQCtYCJLlG9l6Ex0Xf13OrdTnNoMgdr9b48U=;
        b=UGkzg+uqcur8AO6S+GVLNX5w/FiiDDwRigBlBRsgM1XK3Lpf0EWpwVic4VNSmEXKp8
         Eb1JzuMae1/OUNOvXmHsEJUOIzMtDK6QgzJUpFVcROLjbKCuaJiSSi2ZhZfOkFZerbTz
         pTc5puQDGweY6wzOJoU3WT8U51u1/HdN4+0q3+T9lELFSk/jepyEyCBBn9ddGVqArnat
         pAWyiQXDeFaUmak6ZcPQzErU+rs3YytujYX0/bneg9/2ZmlLguEXLv0/T9wwVDCfQx3J
         f834Tyhd1NQ09QrD7VRKSX3d7VqP876GbUa7WLt9vvctLu5bMLNzCAGx0ZB+iPAyfzop
         hQ4Q==
X-Gm-Message-State: AOJu0Yx42A2Pb98MwqAz0/Ktb5jYj4/SvT49dHvnCdm58rA04+Tm3q9n
	7MG5HJQ1BOAjqjVPKGcE909zKpPypUa4Sxib/q6PTEDgqyIz84fpUc+ueNDSoTxb
X-Gm-Gg: ASbGncspB2i2nZ5oYI3jQGLU3STcpjMJ/vPFtnrCw0sQfEA7sfMH5w/9taMF00VLPDp
	lMnEyBzX069y13V9K1PD3SdYfeo6dHlSEB892xZ4yq9lAFcUaKy4mNPgO9gtAP0Q/ONEAFEoOLC
	opq5zKRjTKrUC/f8mhjQ7yviQfLYnVOkM4hY4WSSy3cLN4v6yJ8gyiy1vcg4TXnRafp59YlbRuW
	DUCIC0xckXybi9NNpgYiSa4/E+z6gDdOO9HkboAS8i+qWUSUPeLVDTKs7TXz0pL9c1yVRgCEH7o
	/+Gs4vPU2w0IPZD061TIPX40jg69pRscgRbwZvaiT+HIP5Jcl+KMHWEC4UBwdtlcA6DtYkM7Zjo
	g0bg7ZM8jIyRQcpFQC/OdaUPUKWuh1J0JQ39VAZZmcfCu3yQ5U/qlMWdNvzhwTz+x7BHee/FPm5
	5CHpo=
X-Google-Smtp-Source: AGHT+IEWjpIK3AmT0z2yqiHhcnwyiko7kApa5ZUl2Kwt0wKWzsai9AcQZ5evxLBlvRzt7BsfzivvLg==
X-Received: by 2002:a17:903:228f:b0:290:91b0:def5 with SMTP id d9443c01a7336-290cb65b1b3mr104213305ad.53.1760818043160;
        Sat, 18 Oct 2025 13:07:23 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.211.85])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebcfd0sm33676755ad.8.2025.10.18.13.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 13:07:22 -0700 (PDT)
Message-Id: <d1b02617e643a32cecc81131cb411b180d6339a4.1760818039.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1987.git.1760818039.gitgitgadget@gmail.com>
References: <pull.1987.git.1760818039.gitgitgadget@gmail.com>
From: "Claus Schneider(Eficode) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 18 Oct 2025 20:07:16 +0000
Subject: [PATCH 2/5] read-cache: let read-cache respect submodule ignore=all
 and --force
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
Cc: =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason <avarab@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Brandon Williams <bmwill@google.com>,
    Claus Schneider <claus.schneider@eficode.com>,
    "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

From: "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

Given the submdule configuration is ignore=all then only update the
submdule if the --force option is given and the submodule is explicit
given in the pathspec.

A message is printed (like ignored files) guiding the user to use the
--force flag if the user has explicitely want to update the submodule
reference.

The reason for the change is support submodule branch tracking or
similar and git status state nothing and git add should not add either.
The workflow is more logic and similar to regular ignored files even
the submodule is already tracked.

The change opens up a lot of possibilities for submodules to be used
more freely and a like the repo tool. A submodule can be added for many
more reason and loosely coupled dependencies to the super repo which often
gives the friction of handle the explicit commits and updates without
the need for tracking the submodule sha1 by sha1.

Signed-off-by: Claus Schneider(Eficode) <claus.schneider@eficode.com>
---
 read-cache.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 56a3ef424c..3e87d03518 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -48,6 +48,8 @@
 #include "csum-file.h"
 #include "promisor-remote.h"
 #include "hook.h"
+#include "submodule.h"
+#include "submodule-config.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -3927,13 +3929,55 @@ static void update_callback(struct diff_queue_struct *q,
 		default:
 			die(_("unexpected diff status %c"), p->status);
 		case DIFF_STATUS_MODIFIED:
-		case DIFF_STATUS_TYPE_CHANGED:
+		case DIFF_STATUS_TYPE_CHANGED: {
+			struct stat st;
+			if (!lstat(path, &st) && S_ISDIR(st.st_mode)) { // only consider submodule if it is a directory
+				const struct submodule *sub = submodule_from_path(data->repo, null_oid(the_hash_algo), path);
+				if (sub && sub->name && sub->ignore && !strcmp(sub->ignore, "all")) {
+					int pathspec_matches = 0;
+					char *norm_pathspec = NULL;
+					int ps_i;
+					trace_printf("ignore=all %s\n", path);
+					trace_printf("pathspec %s\n",
+							(data->pathspec && data->pathspec->nr) ? "has pathspec" : "no pathspec");
+					/* Safely scan all pathspec items (q->nr may exceed pathspec->nr). */
+					if (data->pathspec) {
+						for (ps_i = 0; ps_i < data->pathspec->nr; ps_i++) {
+							const char *m = data->pathspec->items[ps_i].match;
+							if (!m)
+								continue;
+							norm_pathspec = xstrdup(m);
+							strip_dir_trailing_slashes(norm_pathspec);
+							if (!strcmp(path, norm_pathspec)) {
+								pathspec_matches = 1;
+								FREE_AND_NULL(norm_pathspec);
+								break;
+							}
+							FREE_AND_NULL(norm_pathspec);
+						}
+					}
+					if (pathspec_matches) {
+						if (data->ignored_too && data->ignored_too > 0) {
+							trace_printf("Forcing add of submodule ignored=all due to --force: %s\n", path);
+						} else {
+							printf(_("Skipping submodule due to ignore=all: %s"), path);
+							printf(_("Use -f if you really want to add them.") );
+							continue;
+						}
+					} else {
+						/* No explicit pathspec match -> skip silently (or with trace). */
+						trace_printf("pathspec does not match %s\n", path);
+						continue;
+					}
+				}
+			}
 			if (add_file_to_index(data->index, path, data->flags)) {
 				if (!(data->flags & ADD_CACHE_IGNORE_ERRORS))
 					die(_("updating files failed"));
 				data->add_errors++;
 			}
 			break;
+		}
 		case DIFF_STATUS_DELETED:
 			if (data->flags & ADD_CACHE_IGNORE_REMOVAL)
 				break;
-- 
gitgitgadget


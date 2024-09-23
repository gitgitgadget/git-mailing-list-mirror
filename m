Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B9D194A59
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 12:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727093889; cv=none; b=bCMbZsGCwcEblpmJLKbZCnZOLqWp7MMmfsM2yxB7xE9NvCZmydqORZ6rpQNVYZWiNNWJ78SVHPqzggf0vRBkI7xn3tfyrmtzIoKQxev9FoFIdsIwxByGAIWrfrdNh3ewPxxBDSKAvwRPZ6WINWqtb2N4obJlUDMxC3K3SL7Qa7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727093889; c=relaxed/simple;
	bh=8ws8/W/Pdbw/TfHGX4mNDsTXHAxbEtRFIC/nqanYkX8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hzLwZT06o3LiCjLUg20VPpZTfsu3HmHLXPzhqTrx+UZHrtpZDU45Jf2DnRSGv4+74R3pEYQQ44GGchmuJ9eTY871wC+Rsa9quCDlysEPOvbtUQrLRr79MrQ/v5Vt0i2Vwf6vH3Noo1VE6PYVNcMdwkctpPcuqCLcJGVWcmn+K4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVEtPm3j; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVEtPm3j"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c4146c7b28so5444691a12.2
        for <git@vger.kernel.org>; Mon, 23 Sep 2024 05:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727093886; x=1727698686; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIoZAbG+hq+TnnHpkMYQ2EjBECAnAfSrr+G8xZRhZss=;
        b=hVEtPm3jRl6gRhsvfPfeqBGAwO6wELrr8S62DyJfSG89OaurR7Tnu/Puux9lKwI3s8
         QYw9vbBYs7ZmaRBJlQSsq9DCd7yUVFoajYmOECTJ6iJeTH7WzYrsS7bjqrXdzf3LQBCx
         rwt3j73g6g5jnRgcVdwmXivwPwG5FAURO7eKJCY6Xn0B1Up2xLGFP9STHdl/QIgI06sA
         HVfWZXPOis4Z1t8vZucly6euFbCkiG31mYT+jXv6rDSOISa4sn6PRgxcGHKa4f4RYpZB
         G/dHS5uaPlIMhXUxk3efJHUzKYuCIB9fDWj5EnwcqEb174S2lEk87UD/a/2ayNlMJn+E
         zIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727093886; x=1727698686;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PIoZAbG+hq+TnnHpkMYQ2EjBECAnAfSrr+G8xZRhZss=;
        b=weX/lsUWf4uYDlFiShbitK57yUbVNixoizmdnOiAoTYv5eKwCHK3I+2+3JV95oMWUu
         oUqS2ODFlb/xUvVEyo1EwwoqmU1f3SBxborJ40liqE2TFwEDOP5rkt+6e3sM6SJNvkFG
         FOlL5/jd1U4PADSPo0xBVBL40pU2JlB495XhBhsleL6t1wuUZQupwPfcdynXKrMWmia2
         3LwxFfkkuO6+0o/XvT4blNGZeH9CiKYs5vtIv66YnEClyadVurOy3J6Vt1c7p/pQkIZ6
         et5BKXmv0w6IAI/Ig3mHFOwwHGhfPdCZyYSzMeaf7g2hVbblhmI/ujvaIABXFIb04E5j
         a2rQ==
X-Gm-Message-State: AOJu0YwMYyW37+UWV1oqYTAZ92zxyS6+7PPlJ14IpOp4GYcTBkLlrLUz
	nMznUNF3r4TrPFzRzo30qB7MdUhogFDLbM83pBdQ9hTkQU8I8e7YTijbsA==
X-Google-Smtp-Source: AGHT+IEsQiMdusKR0AsKKCAPjihmAPlQuAz21k2taLGMJfyx+KzphIIIFNN78UmGNvCkNuk4GHT3xQ==
X-Received: by 2002:a05:6402:278f:b0:5c2:768d:23e with SMTP id 4fb4d7f45d1cf-5c464df330fmr11500607a12.27.1727093885774;
        Mon, 23 Sep 2024 05:18:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bc898f3sm10175973a12.82.2024.09.23.05.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 05:18:05 -0700 (PDT)
Message-Id: <2474b4c69d68576e901cdd6381aac9410cf21922.1727093878.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1776.v2.git.git.1727093878.gitgitgadget@gmail.com>
References: <pull.1776.git.git.1725279236.gitgitgadget@gmail.com>
	<pull.1776.v2.git.git.1727093878.gitgitgadget@gmail.com>
From: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Sep 2024 12:17:55 +0000
Subject: [PATCH v2 2/5] remote: introduce remote.<name>.serverOption
 configuration
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
Cc: Brandon Williams <bmwill@google.com>,
    Jonathan Tan <jonathantanmy@google.com>,
    Patrick Steinhardt <ps@pks.im>,
    blanet <bupt_xingxin@163.com>,
    Xing Xin <xingxin.xx@bytedance.com>

From: Xing Xin <xingxin.xx@bytedance.com>

Currently, server options for Git protocol v2 can only be specified via
the command line option "--server-option" or "-o", which is inconvenient
when users want to specify a list of default options to send. Therefore,
we are introducing a new configuration to hold a list of default server
options, akin to the `push.pushOption` configuration for push options.

Initially, I named the new configuration `fetch.serverOption` to align
with `push.pushOption`. However, after discussing with Patrick, it was
renamed to `remote.<name>.serverOption` as suggested, because:

1. Server options are designed to be server-specific, making it more
   logical to use a per-remote configuration.
2. Using "fetch." prefixed configurations in git-clone or git-ls-remote
   seems out of place and inconsistent in design.

The parsing logic for `remote.<name>.serverOption` also relies on
`transport.c:parse_transport_option`, similar to `push.pushOption`, and
they follow the same priority design:

1. Server options set in lower-priority configuration files (e.g.,
   /etc/gitconfig or $HOME/.gitconfig) can be overridden or unset in
   more specific repository configurations using an empty string.
2. Command-line specified server options take precedence over those from
   the configuration.

Server options from configuration are stored to the corresponding
`remote.h:remote` as a new field `server_options`.  The field will be
utilized in the subsequent commit to help initialize the
`server_options` of `transport.h:transport`.

And documentation have been updated accordingly.

Helped-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Junio C Hamano <gitster@pobox.com>
Reported-by: Liu Zhongbo <liuzhongbo.6666@bytedance.com>
Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
---
 Documentation/config/remote.txt | 10 ++++++++++
 remote.c                        |  7 +++++++
 remote.h                        |  3 +++
 3 files changed, 20 insertions(+)

diff --git a/Documentation/config/remote.txt b/Documentation/config/remote.txt
index 8efc53e836d..8ba48573fb6 100644
--- a/Documentation/config/remote.txt
+++ b/Documentation/config/remote.txt
@@ -95,3 +95,13 @@ remote.<name>.partialclonefilter::
 	Changing or clearing this value will only affect fetches for new commits.
 	To fetch associated objects for commits already present in the local object
 	database, use the `--refetch` option of linkgit:git-fetch[1].
+
+remote.<name>.serverOption::
+	When no `--server-option=<option>` argument is given from the command
+	line, git will use the values from this configuration as a default list of
+	server options for this remote.
++
+This is a multi-valued variable, and an empty value can be used in a higher
+priority configuration file (e.g. `.git/config` in a repository) to clear
+the values inherited from a lower priority configuration files (e.g.
+`$HOME/.gitconfig`).
diff --git a/remote.c b/remote.c
index 7d5b8f750d8..fe11ead27ad 100644
--- a/remote.c
+++ b/remote.c
@@ -24,6 +24,7 @@
 #include "advice.h"
 #include "connect.h"
 #include "parse-options.h"
+#include "transport.h"
 
 enum map_direction { FROM_SRC, FROM_DST };
 
@@ -125,6 +126,7 @@ static struct remote *make_remote(struct remote_state *remote_state,
 	struct remote *ret;
 	struct remotes_hash_key lookup;
 	struct hashmap_entry lookup_entry, *e;
+	struct string_list server_options = STRING_LIST_INIT_DUP;
 
 	if (!len)
 		len = strlen(name);
@@ -143,6 +145,7 @@ static struct remote *make_remote(struct remote_state *remote_state,
 	ret->name = xstrndup(name, len);
 	refspec_init(&ret->push, REFSPEC_PUSH);
 	refspec_init(&ret->fetch, REFSPEC_FETCH);
+	ret->server_options = server_options;
 
 	ALLOC_GROW(remote_state->remotes, remote_state->remotes_nr + 1,
 		   remote_state->remotes_alloc);
@@ -166,6 +169,7 @@ static void remote_clear(struct remote *remote)
 	free((char *)remote->uploadpack);
 	FREE_AND_NULL(remote->http_proxy);
 	FREE_AND_NULL(remote->http_proxy_authmethod);
+	string_list_clear(&remote->server_options, 0);
 }
 
 static void add_merge(struct branch *branch, const char *name)
@@ -482,6 +486,9 @@ static int handle_config(const char *key, const char *value,
 					 key, value);
 	} else if (!strcmp(subkey, "vcs")) {
 		return git_config_string(&remote->foreign_vcs, key, value);
+	} else if (!strcmp(subkey, "serveroption")) {
+		return parse_transport_option(key, value,
+					      &remote->server_options);
 	}
 	return 0;
 }
diff --git a/remote.h b/remote.h
index b901b56746d..d9926a76d23 100644
--- a/remote.h
+++ b/remote.h
@@ -4,6 +4,7 @@
 #include "hash.h"
 #include "hashmap.h"
 #include "refspec.h"
+#include "string-list.h"
 #include "strvec.h"
 
 struct option;
@@ -104,6 +105,8 @@ struct remote {
 
 	/* The method used for authenticating against `http_proxy`. */
 	char *http_proxy_authmethod;
+
+	struct string_list server_options;
 };
 
 /**
-- 
gitgitgadget


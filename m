Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED7C26CE2B
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 03:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761881863; cv=none; b=ZKY34fwrIz2EFIAY9dZBULr0OCqFkUksBmWO4LdGCnB4VyioqvtxXuhUWKZK236CTNWKR3oSYdsa9sXyaqTf8Hjd0XrQkYgQzNiuroqidp8Tkj1LhPFtrziaEyk2VQSgIrT6ZFszm4iyeiK3iVCQcrlGEA+1evpjuh+Yr73C9lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761881863; c=relaxed/simple;
	bh=fBTbvMSvGjysCQ8XWvQ08552iQzYvkPt1L3Kz/B/zyc=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=fKaQI3y/WJCZQ79yS+wA/INUnwLz/SQ37VgI5tGS/bHGTD2HCCY7IDtB/+pyAZIXF8cZqqaDzFKJ1SiW20E1imuaiU67qseEe/Qb3nh8tsa0urXKttPUdgKZOTMo0KnWqje1Hk7BKxenZchT8Ebg99CeuYlvcxcT+W6Dvf64fLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JryNJWKK; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JryNJWKK"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-793021f348fso1708638b3a.1
        for <git@vger.kernel.org>; Thu, 30 Oct 2025 20:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761881861; x=1762486661; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MVJMSSFd797R3Oj4mb2svtI/1VrizqIbJ0X9QazJbXU=;
        b=JryNJWKKlFKtJii+ZmNsbs2uDvoXhIR8vva2E0AFOzCy+E+HMVngLMTJioh/aMDPnZ
         bzCq9zQ3ZFNIeYoxXGNYwsinNQJqc24sRB8xFAjfC7erJ6gu8wlhPjlD/mOuWBw2A1hi
         aJXP7Dco5AJdkqSSGPF99nZ29EqUhx+cPXLPPr72i9YITZzliPhEHcpd3oVABE8ZCGbF
         8IKI58cO3sQWAHyyRi1mrZeFnUc+gMe8s0LVuVg01Uf/RW5Qs8NmFVnj69L44sBUfg8y
         G73TDtrPSj7HzqR7JoE1rje8WWgRZcIsfsMBlUZV0g+BUfRkROWWHxq8EaDKQaJ2iIaC
         7OIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761881861; x=1762486661;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MVJMSSFd797R3Oj4mb2svtI/1VrizqIbJ0X9QazJbXU=;
        b=pGaSB2a+r77ccNBwgYBUTInZQbNxKoJ0QuciddxUVAnrak9Br369HEiHRCkWoT5+7o
         Cu9tKUqsVUa1H3ZlpAOuvpL1kyFCofPATqFULEfKxnA2j433MV8XXtiPNC3LVNYEIAqz
         P/DLdIEbcFuTGS6sBY1yOGYScfeVRPleApbfG3P6+HaF3Qe1gTyzuDpIFBPi7ukLdOyB
         79cMu3JwA5UYmLTdrAFHXyUbBceTFLzweZylaLLQndw6VUfPxaUDc5agW2K+H5UmhiPp
         ON8+4so54xc5y9l+am/8JxmEA46rY2SwfvL/oWiv4o20ysZsp4ILCBEELoaY+wKeV6Ph
         kUKA==
X-Gm-Message-State: AOJu0Yxc25JmYbSktifTAeohH9I4Q+/i3KP4dFyS0Z2xIaU/6d1l/6wN
	X5kxhXHnrjTATrtv2Lt4U5DYo0QaBQd1gss2EbkRvIZ/tQoKLCbuMdllvcHaUg==
X-Gm-Gg: ASbGncsRc9p4DQekPPdxLZrHHWJ5BwSyIVJOfC0VQVKTMnwa035xKAFvG2P8q8W9Kr0
	Ol498VmY2TbDHJgJ5h6C+quQKy5uPMkvE5yeugh9mRekLWoNldYz3zqHultTGhdcXEC1mMFNxhM
	+8tN0yHY5kb2qxxU4jU5zgyRFolifvKta2GfjJdbqYeqB79wCDznxTfWkO6Geq+45lNfQhtWNug
	6ucn9gVV73UdsB+zA/9OoIh5clwA5pQXOuPN6anLW4I791kW0ZZN/smCDq7vm4JbkITSNqBRJqF
	o8w9ZQ+t3cdkv4ngJSYQ3QBt4UVYnauuWYEtZgL2gj211NkDzSzY3uFNEF9F6gcN454hXNhlOkw
	5oVY1hPmpfsUj8cDSq5h3ZboopKdcTHQBjqOURLz3IY/yIJ1ltfdt9OOgk2E+ozpbq+sefLXDxf
	CF9pYp6VZHncq8zA==
X-Google-Smtp-Source: AGHT+IFupOXCKiRp3J0GV0m8JKEoEwVHM68IGLlwNIQEzhhy5eSb+QDYELoVC9KLLYhEM6kRbicNpA==
X-Received: by 2002:a05:6a00:21ca:b0:77e:8130:fda with SMTP id d2e1a72fcca58-7a77737dd35mr2468758b3a.13.1761881860994;
        Thu, 30 Oct 2025 20:37:40 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.243.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d897e86fsm449269b3a.11.2025.10.30.20.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 20:37:40 -0700 (PDT)
Message-Id: <pull.2090.git.git.1761881859881.gitgitgadget@gmail.com>
From: "Xinyu Ruan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 31 Oct 2025 03:37:39 +0000
Subject: [PATCH] refs: add missing optimize implementation for debug ref
 backend
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
Cc: Xinyu Ruan <r200981113@gmail.com>,
    Xinyu Ruan <r200981113@gmail.com>

From: Xinyu Ruan <r200981113@gmail.com>

The debug ref backend (refs_be_debug) was missing the optimize
function pointer, which caused a segmentation fault when running
'GIT_TRACE_REFS=1 git pack-refs --all' command.

Signed-off-by: Xinyu Ruan <r200981113@gmail.com>
---
    refs: add missing optimize implementation for debug ref backend

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2090%2FRuanXinyu%2Fref-debug-optimize-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2090/RuanXinyu/ref-debug-optimize-v1
Pull-Request: https://github.com/git/git/pull/2090

 refs/debug.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/refs/debug.c b/refs/debug.c
index 697adbd0dc..8dad7046cd 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -124,6 +124,14 @@ static int debug_pack_refs(struct ref_store *ref_store, struct pack_refs_opts *o
 	return res;
 }
 
+static int debug_optimize(struct ref_store *ref_store, struct pack_refs_opts *opts)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	int res = drefs->refs->be->optimize(drefs->refs, opts);
+	trace_printf_key(&trace_refs, "optimize: %d\n", res);
+	return res;
+}
+
 static int debug_rename_ref(struct ref_store *ref_store, const char *oldref,
 			    const char *newref, const char *logmsg)
 {
@@ -444,6 +452,7 @@ struct ref_storage_be refs_be_debug = {
 	.transaction_abort = debug_transaction_abort,
 
 	.pack_refs = debug_pack_refs,
+	.optimize = debug_optimize,
 	.rename_ref = debug_rename_ref,
 	.copy_ref = debug_copy_ref,
 

base-commit: a99f379adf116d53eb11957af5bab5214915f91d
-- 
gitgitgadget

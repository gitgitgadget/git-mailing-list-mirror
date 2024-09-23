Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4032199230
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727093891; cv=none; b=aSlaeoUMEt25/vEnXei/22/JAbyijLaasAH+QOwDjr/RWtMuiQP31UpUJUyF9Co6ehEx75FEP7zM65pUZih5CpEuR/SBYjDPp03SE94PmOdpPr+xFPQ4p1Rqe093OHIJJZyB90Ack/G0rbtaFEBv50WIOsgW/Msj9yiRm6tgnuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727093891; c=relaxed/simple;
	bh=fSdMXQXbgf1ojFECwhMKFP3FpCt+7WTM7/iryZ8UtgM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ttkDVwJkldwmb9b3dioimr4F2VX1zvUjm0hr7sP0w5pKtXWsHUU1gjY5zklL9IB/EL05jxPzmv8gskJx+0FBOCOoZHMjRXOpJaxG6P/zW0QBnwrOHpDmvvXcHkQby43MulLJnL60PwUnnKSe3ggD8xWJEEBtzt24j8Hc/2+OIRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M83CiHXt; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M83CiHXt"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f761461150so48683401fa.0
        for <git@vger.kernel.org>; Mon, 23 Sep 2024 05:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727093887; x=1727698687; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BL86xSZrSOc+3jFRQV+Gg/nTNxFkKgoWNWB4/6JQylE=;
        b=M83CiHXtKBHd37AcuuSlrFrH/94t5yKdtbBE8/+PY9mBFu9P5zq4TKe8ieQPtERqbY
         ak2ZlY9d+/YZ1WJ3WzHL7zE2uPF2eaYA+nlxLtUu7x4LoDTT9RKtu7IlD+9upanEX0Yq
         Sy1gCA0mq9IxKye9ETTfcRISYCplhtyMsqlHIHmNHY0XInX1DjhAND/p1avlkiaMPmaX
         kHPrLRcLoxcBF1TeM6eAYRH+yVsg8g6GiZA74g89WDOLRXD2N5VO74OM0i7kqdjtoupb
         Nzzn7rXfBX3N1IbyPlqQnJCyNWnGwR7VK7EHygJmB5UWTUNV8Z4+1tnxRN3iI2HlCyh/
         UUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727093887; x=1727698687;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BL86xSZrSOc+3jFRQV+Gg/nTNxFkKgoWNWB4/6JQylE=;
        b=K8vBjsw3LXrvJd9K+s/Ci8xJ0PbXQsOswZ3ofZERiwYR3/hA4incp0jEGtAvD9JN6K
         PydTId641Rr6PdHQ2NhCBjb3j8pA+nebnQmzx3GfAF+pmoqrUoaXmD45UoSBVnbkVpDJ
         OjDodGilMPaMYErV2RAb/VZwQFGG0f3OCULALUTF/6csW2smLEP+koae2W/msVUJvFzL
         rY82k2eA7qtB+WhW5rx4UE1kz4Q3b5gTr1S9KSIoj8tl2+RQDroxwdZBhwJC/tHWfi/J
         Hr1MhhtkwyS1sEPOHPKpMuWqUXsaxcnCWZmCN4qeV+ElV3EEJHxOq3AHTHZGr7q7NBm6
         gTjQ==
X-Gm-Message-State: AOJu0YymDKXQebWVzG0M/j7F/ToKxOdIBe0yy3Euqp9Si/7t+Rm4NJHc
	1IpC5qk5l5hkfWhjxYyJVAdhVXtaVg7OLwO2B3SQ+LIzzVXoS2A+uSzdSA==
X-Google-Smtp-Source: AGHT+IHhpHWy2HvULKd1jMKmRhGlYRj2o3gOWGz1gAk/ZaXplzVq7CYqnVie0Ayx9o9p8jDp5TAY/w==
X-Received: by 2002:a05:651c:2222:b0:2f7:5049:160 with SMTP id 38308e7fff4ca-2f7cb30cb37mr81836041fa.13.1727093887246;
        Mon, 23 Sep 2024 05:18:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f451csm1213853866b.58.2024.09.23.05.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 05:18:06 -0700 (PDT)
Message-Id: <39ee8dbef783f425e6a8b01a68ac01fde304b698.1727093878.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1776.v2.git.git.1727093878.gitgitgadget@gmail.com>
References: <pull.1776.git.git.1725279236.gitgitgadget@gmail.com>
	<pull.1776.v2.git.git.1727093878.gitgitgadget@gmail.com>
From: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Sep 2024 12:17:57 +0000
Subject: [PATCH v2 4/5] fetch: respect --server-option when fetching multiple
 remotes
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

Fix an issue where server options specified via the command line
(`--server-option` or `-o`) were not sent when fetching from multiple
remotes using Git protocol v2.

To reproduce the issue with a repository containing multiple remotes:

  GIT_TRACE_PACKET=1 git -c protocol.version=2 fetch --server-option=demo --all

Observe that no server options are sent to any remote.

The root cause was identified in `builtin/fetch.c:fetch_multiple`, which
is invoked when fetching from more than one remote. This function forks
a `git-fetch` subprocess for each remote but did not include the
specified server options in the subprocess arguments.

This commit ensures that command-line specified server options are
properly passed to each subprocess. Relevant tests have been added.

Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
---
 builtin/fetch.c        |  2 ++
 t/t5702-protocol-v2.sh | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index c297569a473..c1b3aea7745 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1980,6 +1980,8 @@ static int fetch_multiple(struct string_list *list, int max_children,
 	strvec_pushl(&argv, "-c", "fetch.bundleURI=",
 		     "fetch", "--append", "--no-auto-gc",
 		     "--no-write-commit-graph", NULL);
+	for (i = 0; i < server_options.nr; i++)
+		strvec_pushf(&argv, "--server-option=%s", server_options.items[i].string);
 	add_options_to_argv(&argv, config);
 
 	if (max_children != 1 && list->nr != 1) {
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 5cec2061d28..d3df81e7852 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -418,6 +418,16 @@ test_expect_success 'server-options are sent when fetching' '
 	grep "server-option=world" log
 '
 
+test_expect_success 'server-options are sent when fetch multiple remotes' '
+	test_when_finished "rm -f log server_options_sent" &&
+	git clone "file://$(pwd)/file_parent" child_multi_remotes &&
+	git -C child_multi_remotes remote add another "file://$(pwd)/file_parent" &&
+	GIT_TRACE_PACKET="$(pwd)/log" git -C child_multi_remotes -c protocol.version=2 \
+		fetch -o hello --all &&
+	grep "fetch> server-option=hello" log >server_options_sent &&
+	test_line_count = 2 server_options_sent
+'
+
 test_expect_success 'server-options from configuration are used by git-fetch' '
 	test_when_finished "rm -rf log myclone" &&
 	git clone "file://$(pwd)/file_parent" myclone &&
-- 
gitgitgadget


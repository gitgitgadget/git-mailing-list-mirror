Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B4D199238
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727093891; cv=none; b=hw7ULYuf0+uJhKnITksLLUyfXDIEkergrdq66DJ57p+W6moavc9BPiIdjgxth1FzeZufpOBFj78id28ZOr2yMoxmIfkuEdypBtqgP7Xcg+wP49icse3pQb3Fhp4ESDlbCmwq1phMvTvUni948RH4O1bDRJBHb8ITZZnasxQV/Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727093891; c=relaxed/simple;
	bh=W0r7iKYsyHh+oM14DXs40VOefGEsbZMWNFYktnS9GXs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TZs135CeY39uSFsImX8MFfqPnpQAH2MM/qR26rH0JIkUyIE9DYjbFVC2t2MN26nPFxP7o0kNWWCSbEgktYyWtEwKTwOldxlVf2Y4GEPLXhfeuWBxqHkJ3Rucm3DA0yv83JCZfXm8wYbYP7yzmylsZRCxz/H9is7Bz+lA+lSi3To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFpT33Gu; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFpT33Gu"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8d6d0fe021so689982866b.1
        for <git@vger.kernel.org>; Mon, 23 Sep 2024 05:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727093888; x=1727698688; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TZ2X1Dl5wVPog5ETmku3rydVM24aE2xH1NUiP6wJlM=;
        b=OFpT33GuNRfH0wsYihBqvqhHUctzFfGTg8j84qc+I24IVsV0QDxxL5c1G3S3smeJm2
         v1/A0QIpo1Skc/QdxhwHYao1vnLBOBMndfjeLHwQeZvRjnx6C+E+9ZGSaD4E9ofu4pU+
         KMJCLTcOY58VIMdP+hLlJE/krbfhLoj+V/6edZFZvUIvkZkV/+sg7xNZrv8ubdy4oDTm
         YI18vCq6ysxNyT38ctHvA0la0akJmFGpB8RPgELUfjzGUckIb2vyvwYgzbDYwM8WNfZ0
         wk/MGOIwstzZwICUhVVcdLTJMD9YiwDEnHWMFqxv/ql/Qpubsso/IxgDpPxrbhT0bOtk
         YCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727093888; x=1727698688;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TZ2X1Dl5wVPog5ETmku3rydVM24aE2xH1NUiP6wJlM=;
        b=hhn56hPdxod7zzNMDAFmcAddfwRXW6Lp5g+ivVdJQeUKeiZvQTnuDSF8IpsOxi3/VI
         roX34x0myqyq3K6LYN52MFpJCRf0Cv2MyfADkPhVxkK7XKQvz+O0onW8s4BhUs5Ux7ze
         7vaYiKw2NtR3Le6GvtRxwSyJFAAelsjjnVFhriP79MGioG8BjC2R1B0M/M4zf3oRH9Xh
         3VbioSBozH3Xuz2arHUfYrE3SerYr+kJpd1s7/oBSRa+suiP8hqACfyZ70IHjlvjJyv9
         HU9oUkstYThF6+SAva6PBGsi+EPIXVd9wfRRMJPRQClyLn8r4yCY8+hKhZKmflIWODIE
         sOHg==
X-Gm-Message-State: AOJu0YwYql9AFoxcdbWnDbzxOSUZqNlry75Oa+VzWYvj93sNBqGZJTVv
	ujAcJSvTOXunuVumkhK5Ir55ak/nCFZ4vz9by9kARDcaQU/6bXeslZUdqg==
X-Google-Smtp-Source: AGHT+IE02BS4WmW3oN6/eolaNwDs7baparR9yOPh8/xa0wZpu6ZrdirfDSGcGMZs4GignsPSBRTcqw==
X-Received: by 2002:a17:907:9708:b0:a83:8591:7505 with SMTP id a640c23a62f3a-a90d5167dc8mr1354316066b.59.1727093887890;
        Mon, 23 Sep 2024 05:18:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612e5d0csm1208466966b.184.2024.09.23.05.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 05:18:07 -0700 (PDT)
Message-Id: <39c07a6c8eed645e22ae55affd015ee55ec59571.1727093878.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1776.v2.git.git.1727093878.gitgitgadget@gmail.com>
References: <pull.1776.git.git.1725279236.gitgitgadget@gmail.com>
	<pull.1776.v2.git.git.1727093878.gitgitgadget@gmail.com>
From: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Sep 2024 12:17:58 +0000
Subject: [PATCH v2 5/5] ls-remote: leakfix for not clearing server_options
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

Ensure `server_options` is properly cleared using `string_list_clear()`
in `builtin/ls-remote.c:cmd_ls_remote`.

Although we cannot yet enable `TEST_PASSES_SANITIZE_LEAK=true` for
`t/t5702-protocol-v2.sh` due to other existing leaks, this fix ensures
that "git-ls-remote" related server options tests pass the sanitize leak
check:

  ...
  ok 12 - server-options are sent when using ls-remote
  ok 13 - server-options from configuration are used by ls-remote
  ...

Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
---
 builtin/ls-remote.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 0a491595ca8..c3fdda08409 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -169,5 +169,6 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	transport_ls_refs_options_release(&transport_options);
 
 	strvec_clear(&pattern);
+	string_list_clear(&server_options, 0);
 	return status;
 }
-- 
gitgitgadget

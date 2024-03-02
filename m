Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6534D18627
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 15:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709394731; cv=none; b=H3Hq8mL6qpGFZhX6RdO3R2Uii1LquDr/Ddo3IL5CU8TOFGnqEOfQLjX3kOtShV47foMBsd9/lb4a8B/R7rqooiZAe2fKmsobXvjVfUjo8lnEEPReZNMgawjl5HOnwB/PhAvXl4cvraklmbYaJTfxpXeA1CyIGu7mtimM+D0IB/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709394731; c=relaxed/simple;
	bh=Wq16BpN2O8D6S3VvQPJymma+WTZ89an9xA0288k+kk4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QZ/ErThI373FtFbQ6FhDt4uuiYcmp3vhaux2uRsDfaHkFawHsBW0GWTQMF9gbhOg5JnC7ryeSY7USmlhf1D9hGD1F8M2tl/+913ljhsxxJbOJ+pPnAICGVfpR/jqNfadq+AYxFoikQ7rviPam/SNbDD0CXqqZLIxMCjkIqAKaqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVuEvFy3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVuEvFy3"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412d5ae1c5cso2921395e9.2
        for <git@vger.kernel.org>; Sat, 02 Mar 2024 07:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709394728; x=1709999528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oNZjf+nWm698qQGdEDR/KdDOnWOkO44NtsRJ1+2zHHA=;
        b=aVuEvFy3Q2zKxPXgZyPU3a8n7gzC5XgQqFBr5tIe0G2f0els3kxqcRUa0D6bayspoT
         GwbVIZXP3BmGC3rRjhpX6iEYQGQgkl5Qqziumk5rqyPLHupUWbtUntT6txMj1GBIge/T
         KEwkhUVWCOuWlY2jUnr7kj3sMvnqp82K2fjrTHQ1zDFTUkLQqJCRp4aYD2B8H2ilwsGe
         42N+97xAvI605+bm0giIExzQ/mfbjeZXJ+HFxHwH/c2slEQTR8Z9/6uy6MDHTy0ycbhz
         qBSnU3jX5+NbBNML5yxC60hNKO0pEFoEpEjiN0OrMCEJ7fSEiF9rt84qBmVSjxgBgxbi
         A6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709394728; x=1709999528;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oNZjf+nWm698qQGdEDR/KdDOnWOkO44NtsRJ1+2zHHA=;
        b=g6mMvEHjS4eWG6JaTSM20k8QDyvBnL2dncguZ1+CDu4YlngXVrazeMFsfLtnciDryc
         zZ5j6ZpinLCcfeJUoHoh8R+sbGUFz2LRqhLbM3N7lGAqGMYB6c5xCFWfg0/1xTy6Li+P
         nzmSQ9sgigDyFFFSkIO5MUoeiocfWdlDrz+8JgF+msQ9YLf/6hqt2n863ROz0kcZyYYx
         cxs3BexFP6SWtAbmGOMH492EN/Q8SiIY8CdtDCp393NgblzJcygpjxXjFHiDvUOxZsfL
         ErzbhC9tId7XLEI4Nq35RG0TUWIeamVSYs09fqq9evFnHplU97XtiCfyfrjUi/pLRSAu
         iRCA==
X-Gm-Message-State: AOJu0YwR/t3lRwglztwgPgWDuCCaSII38NoK2nWS725oHoKY3S4xzvqJ
	YLjIYUKdr65HO/5pm/IeQOm8rXS38avLA2CzV6hczn3mRH1kHHlk1Kc5TIaI
X-Google-Smtp-Source: AGHT+IF2DXKVJdIQdpfit4iqDmogNVNvr4EqxCtUADlasqJqvT3EFZICJ9if/fyg0NCtKd51M+JZAA==
X-Received: by 2002:a05:600c:1384:b0:412:c213:d0fc with SMTP id u4-20020a05600c138400b00412c213d0fcmr4096614wmf.15.1709394727442;
        Sat, 02 Mar 2024 07:52:07 -0800 (PST)
Received: from gmail.com (243.red-88-14-45.dynamicip.rima-tde.net. [88.14.45.243])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600c4fc600b00412656ba919sm1204842wmq.20.2024.03.02.07.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 07:52:07 -0800 (PST)
Message-ID: <69f1dd45-e19d-47ad-b83d-746e9f67368c@gmail.com>
Date: Sat, 2 Mar 2024 16:52:03 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 4/5] completion: factor out __git_resolve_builtins
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
References: <98daf977-dbad-4d3b-a293-6a769895088f@gmail.com>
 <ea6c8890-9ff3-46c9-b933-6a52083b1001@gmail.com>
In-Reply-To: <ea6c8890-9ff3-46c9-b933-6a52083b1001@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We're going to use the result of "git xxx --git-completion-helper" not
only for feeding COMPREPLY.

Therefore, factor out the execution and the caching of its results in
__gitcomp_builtin, to a new function __git_resolve_builtins.

While we're here, move an important comment we have in the function to
its header, so it gains visibility.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---

I've changed my mind last minute, and renamed the function to
__git_resolve_builtins, so the subject of this patch is different
from the one included in the cover letter.

 contrib/completion/git-completion.bash | 31 +++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index dc5f73a9f3..f9fbf1f703 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -452,16 +452,18 @@ fi
 
 # This function is equivalent to
 #
-#    __gitcomp "$(git xxx --git-completion-helper) ..."
+#    ___git_resolved_builtins=$(git xxx --git-completion-helper)
 #
-# except that the output is cached. Accept 1-3 arguments:
+# except that the result of the execution is cached.
+#
+# Accept 1-3 arguments:
 # 1: the git command to execute, this is also the cache key
+#    (use "_" when the command contains spaces, e.g. "remote add"
+#    becomes "remote_add")
 # 2: extra options to be added on top (e.g. negative forms)
 # 3: options to be excluded
-__gitcomp_builtin ()
+__git_resolve_builtins ()
 {
-	# spaces must be replaced with underscore for multi-word
-	# commands, e.g. "git remote add" becomes remote_add.
 	local cmd="$1"
 	local incl="${2-}"
 	local excl="${3-}"
@@ -487,7 +489,24 @@ __gitcomp_builtin ()
 		eval "$var=\"$options\""
 	fi
 
-	__gitcomp "$options"
+	___git_resolved_builtins="$options"
+}
+
+# This function is equivalent to
+#
+#    __gitcomp "$(git xxx --git-completion-helper) ..."
+#
+# except that the output is cached. Accept 1-3 arguments:
+# 1: the git command to execute, this is also the cache key
+#    (use "_" when the command contains spaces, e.g. "remote add"
+#    becomes "remote_add")
+# 2: extra options to be added on top (e.g. negative forms)
+# 3: options to be excluded
+__gitcomp_builtin ()
+{
+	__git_resolve_builtins "$1" "$2" "$3"
+
+	__gitcomp "$___git_resolved_builtins"
 }
 
 # Variation of __gitcomp_nl () that appends to the existing list of
-- 
2.44.0

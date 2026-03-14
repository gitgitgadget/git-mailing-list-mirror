Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F56437BE7D
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 14:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773499118; cv=none; b=T92m2ordb5XFR4uvVwai/l5x1uhvtTPIQCu/BL/TfN3Rh+LFzEhegCrlIpLnYxQ+39ggH+qUNvbR1yGXIx428q9CLa/u0X8IQO6QUIqn3nTFhxdo8rG9Mzrsj1f1h8YAI2jlfDOo3R+VHmvVxYEAx2EA4qG3y1Svapx5E/+Qeuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773499118; c=relaxed/simple;
	bh=Ez4fBo6D2+qaaNB3L9KRc8pl8pxW1U8S83tCtoIRsqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vw72n+HUQxaYWEudmB1XZoa0owAHsbnFOs/TDufVKggZeSLfL1q33F8BBkt24/v2foaFbfIM81Q3SHX4riuVrLjLHj4CLvSh4yj5cbOeawzegDZkDO/ndM4j69v+HyZprrwEC4BFGWoazHq/7VsaO5gnrV0pqCyjgjBYqndNb/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMkNKzdu; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMkNKzdu"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-798578e2918so30374517b3.2
        for <git@vger.kernel.org>; Sat, 14 Mar 2026 07:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773499116; x=1774103916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXvYF9OyPjwrEe/bos3NDYm/5poAWZF9DQeUKHevChY=;
        b=MMkNKzduPOxOJko7Q5I9aEfyYMc4YpohzMoVhTa18Y5LuWf1t8hTQJ0CW1yMo783IZ
         AjOOTgZx/z/Yp4d0nkjg9u5Qxfsy6UR8D0xpPmr3cLtMUHx6xaKrqjINI2m02D2PCM21
         pVvvJjDGYh9i6j6GDfIc3Mn64JW+xSgm0a1piJqijQQoOTGcPJ3rnLWQLTuyWWfWsUEl
         1VFEOdx27rAC1hesA1pvOHRKqCuJk/A2VFEFtCFq3vo97i8mafZqvjl1/zE1IB6nZjhX
         eyyIplyvnltvt5a0nq0tdm+yahpUPIP+0a64fSlAhIli40lVg2YC/kIln7Z7BHz1CtRf
         1xsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773499116; x=1774103916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TXvYF9OyPjwrEe/bos3NDYm/5poAWZF9DQeUKHevChY=;
        b=itF/0KiZBJfthiE7CwR2JSFMdT4+kjTxvxK3LC9iCi5VkxEufa5MfMWAxKvTktZn0Q
         rFneIT5lkTKdSm2U3ExPN+Ft42pnQVxGx1ZKqS8qhJ7SrujyXVtJnaqVsXzhgXWjn/ic
         ZTHtEXPNyga5ZOGKOul40uAIxP133lJQp+75zJn7nvtOv2SaAnp7/UXszASlZWaDrcVY
         sjLKzxaPOr0zmKqZWMqR6hv00RNhxbb8+mOlNQ9wZOuGwBIHgCncEMMph+XcEKWOrELR
         jEfbnRidzRROrVmmhSyl0z0senjwpyhqJHF5Zj5gwCQEYaXmJSet6SRei7Wv8oISv45I
         6+lw==
X-Forwarded-Encrypted: i=1; AJvYcCUdFhR5+JpdhjVXHd8E0HwVFvMS+AA5KuIK/JMVjEgShOXQtLIRyl1zpRZ7tdrRSLFeiK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhiIVdtjGGIxYUtb1j+7TxOBsR108LqvKrMrDzR59g4evRuFnc
	O8WPVb1GO5h4xF8p3NVSKXefNaonxwmTGFVywn/cQpANTlLrcrPwSWau
X-Gm-Gg: ATEYQzxhpZBbBA5jF3cR005+fOT+WdLd/Be4EXzg7Uljj2OyPcdUI3LsO4O2F9OO8BJ
	5IHHwoOWMXjoVir9I/dECHWs66BczyVVapXGbZ7V1aaLtqCvAnsjIorZIRm/6sIV08dQH9U1S/e
	NS5Zmzpw37BZ45T5Xo04r38VQFzh0SH6WfH6yc+YCZSabzkS24TTCXoEbQn2vwUT0XS046hizU/
	s9wUlGssTCtXBjXtvL37L+q//qy1boIvGiMNImCNMKusERpZ9f1CGv8fWY6tzabfZC+M/yo2mqs
	ECL+tUMx9UT4WwLQp/yRg9Q3LQWmjIL99YgOUTPkKXAZ+GD9BZ7b+SzpzHrJRMy3NfXu/64qYvx
	N3E+/eTQO2RfwIvlWhvNviXmgK9jAzW5kpU/wsGPwkcfRSjFC0xc3BKSRz17FfPH+qZiNsXYCwX
	qDRlL2P4BJwSQqkXu7alTwqaUgtzhuMjZr1HQ1a2zYRouWCqBOT36ziGg7duIHktUGo9T5/OhYs
	5/1+t/a59yqaE1c/iuAuV54xKF6RNQ670C51bx8GqgTuI4e0QG4K8/HP0UFWsp5pMLlZU9ZBHa0
	Qg2GFn+57pM=
X-Received: by 2002:a05:690c:998f:b0:798:980f:6706 with SMTP id 00721157ae682-79a1c0e4895mr76754737b3.22.1773499116464;
        Sat, 14 Mar 2026 07:38:36 -0700 (PDT)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917f0846csm65264207b3.39.2026.03.14.07.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 07:38:36 -0700 (PDT)
From: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Alexander Shopov <ash@kambanaria.org>,
	Mikel Forcada <mikel.forcada@gmail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	Emir SARI <bitigchi@me.com>,
	Arkadii Yakovets <ark@cho.red>,
	=?UTF-8?q?V=C5=A9=20Ti=E1=BA=BFn=20H=C6=B0ng?= <newcomerminecraft@gmail.com>,
	Teng Long <dyroneteng@gmail.com>,
	Yi-Jyun Pan <pan93412@gmail.com>
Subject: [PATCH v3 3/5] docs(l10n): add AI agent instructions for updating po/XX.po files
Date: Sat, 14 Mar 2026 22:38:12 +0800
Message-ID: <bc00ca2d3069ca63800c70c40fea1be98a01c64c.1773497547.git.worldhello.net@gmail.com>
X-Mailer: git-send-email 2.51.0.rc2
In-Reply-To: <cover.1773497547.git.worldhello.net@gmail.com>
References: <CANYiYbFM9+4xGmeBRNCC6VyW9EzjEFxEWHDNnOVhJNM73Ga_FA@mail.gmail.com> <cover.1773497547.git.worldhello.net@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new section to po/AGENTS.md to provide clear instructions for
updating language-specific PO files. The improved documentation
significantly reduces both conversation turns and execution time.

Performance evaluation with the Qwen model:

    # Before: instructions in po/README.md; the custom prompt
    # references po/README.md during execution
    git-po-helper agent-test --runs=5 --agent=qwen update-po \
        --prompt="Update po/zh_CN.po according to po/README.md"

    # After: instructions in po/AGENTS.md; the built-in prompt
    # references po/AGENTS.md during execution
    git-po-helper agent-test --runs=5 --agent=qwen update-po

Benchmark results (5-run average):

    | Metric      | Before  | After  | Improvement |
    |-------------|---------|--------|-------------|
    | Turns       | 22      | 4      | -82%        |
    | Exec. time  | 38s     | 9s     | -76%        |
    | Turn range  | 17-39   | 3-9    |             |
    | Time range  | 25s-68s | 7s-14s |             |

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 po/AGENTS.md | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/po/AGENTS.md b/po/AGENTS.md
index 94b7aa7f28..f2b8fc5100 100644
--- a/po/AGENTS.md
+++ b/po/AGENTS.md
@@ -59,6 +59,17 @@ When asked to generate or update `po/git.pot` (or the like):
    command and consider the task complete.
 
 
+### Task 2: Updating po/XX.po
+
+When asked to update `po/XX.po` (or the like):
+
+1. **Directly execute** the command `make po-update PO_FILE=po/XX.po`
+   without reading or checking the file content beforehand.
+
+2. **Do not verify, translate, or review** the updated file after execution.
+   Simply run the command and consider the task complete.
+
+
 ## Human translators remain in control
 
 Git translation is human-driven; language team leaders and contributors are
-- 
2.53.0.rc2.20.g532543fa46


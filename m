Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FFF3D69
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 00:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748911808; cv=none; b=srMbD+LETRabS+W57O0jwf1IhDw9azIWjF5nI8Aspy/9EZ+0rKKgo6DpNv14FCuuKs8QTzi40YtuP+hlRKuJa00HlcpGa00yWVggrNmScOOJaAiga0yIaSz74JmDcUPEi7BqirvVIa/7cqIdvuDo6pPortADRJGOSUa4CutPOCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748911808; c=relaxed/simple;
	bh=nq1ZGu/Mt8NXgTU3ZzqvPR742zD5o7Vlp5CGhqxhfro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HrB6M3h1X8hIPOUSg4BuQ7ax5i3S/KdAFnk58Q22xQUQoGb6+WhfTRssNwNFQOcwx+ZudFHSsyvb5EAykIJTUPpoctNT2aV4T8+6Iw/ycYeor0BMVG9ZI55FYr3A3/5dRVN0YQ013eqlW7RL3hdMVYGejvV6jsBSbvlh/ghUNT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RuFd8k4c; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuFd8k4c"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-742af84818cso3371119b3a.1
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 17:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748911806; x=1749516606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXAjlqdkiopVtqjTrbc5pEeaVFJmeJ5b0PP/yWIqiis=;
        b=RuFd8k4cS5gjl3WTrqwtyQyOFTZ484mJqY+nacfk7qQK+81PsLjxpo6srAFq+3pfOO
         UCDRQeS35VEfxJh7eIsDbfvOJ5gNWeCvTid90Y6pwPe41rS8Vr7rIQRUnEtF56j/SeGp
         5Eux9DtmZu0ffVh6N2TkLe3RjRmlvAmQkzn43Wdzjv5ddRJdC70Jj8eNHxO6jsj7+ofK
         9HE8FX9Mtr9a/Tz6FCwNk3HV0kTb7If3V95fGkkCiZsSFlhGK5Mi9ilMuu3Ws0msRs/z
         idSnNZdkSBnbG/FdPT96IMEnEW9UuwVMkOXbZQz1fHMN2wOC7d7faptYobYoCrhffaR9
         bhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748911806; x=1749516606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iXAjlqdkiopVtqjTrbc5pEeaVFJmeJ5b0PP/yWIqiis=;
        b=dGrF7HvmMlYl+/n3UqqgSpG096gq9Puvh01TqDS8HWjLbCbIAypwM1HwGjPjDVKTQx
         RBz78EULEmKB4OO5CRXU9TLY9KJHoyC4O3Vd+pWnKKCOZr0AI2mWsg/Lq3GNJjEadonV
         aBjJq5IDrOnRHy96IwhwX18qyQ9NPR2T97TdGzDttgtXCDQT+/j8r5D2XqoEbvPIJ6yr
         hIyRf8yjTiBMCiaHZ0RYP+UtUY/9N1bNGGaIkeJnoVVkCRSpCOs8RAbR8/ZJ5eaKgKp2
         4nOMnLXTE80MUd2Cq+s20HjcEFoH3h5FSFSwVBD4Urnul/SO8LLKYxrxFatiEqmkP2Dq
         snbQ==
X-Gm-Message-State: AOJu0YyDPjkcv7JvIOnucLvwTzyLvtZwDJbNpdepFMgYBSOu5woJ7aaL
	Ai00R8o3G0POKopRbxSf1NI0yRhJmBExQ1Qwp2FTc/wj9vTR1cw++zAHke+8qw==
X-Gm-Gg: ASbGncs+MR13GTBtz5wqOeH+d9jheumWgV1Prkvp2GCmVxKRu9u1nbVIdy1uTMw/Fp3
	S5FD4rKUf85f/1JrkCwYaCiIsvak55nPT1kAz6iM5i3YlmE99Gh0KcvoXP/5UcpE5I8B1n3lzYQ
	w+rE71kZ8mnVpdqIUJbuWTkROY6fe72qed+oQPp+gW86MP+mjoyZTJnwtfftzW0SUzdb8nrIBKJ
	ftuX9CrAou69XiP1d68t4pui1WG2ZkbVmw4aaRWRy4yc0nVWq0WtNL0wluktWyKnDXK7ZfQXBHo
	72ZE7p7hFN7F4fe1IT8QMIa2jY2mbHtPkg==
X-Google-Smtp-Source: AGHT+IGwfxh+JM+Ko1RV8rxHm+Tj+rzTUZGgijtsfR1+3a0bNTB0dJe76S7B8St5JK/uDIHYIkyxCg==
X-Received: by 2002:a05:6a21:7e0d:b0:215:ce2e:8b1e with SMTP id adf61e73a8af0-21ad97d9019mr19226310637.26.1748911805886;
        Mon, 02 Jun 2025 17:50:05 -0700 (PDT)
Received: from fedora.. ([2601:646:8081:3770::9eb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2eceb9711asm5282959a12.57.2025.06.02.17.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 17:50:05 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: git@vger.kernel.org
Cc: Collin Funk <collin.funk1@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH] CodingGuidelines: document formatting required by generate-configlist.sh.
Date: Mon,  2 Jun 2025 17:49:12 -0700
Message-ID: <45c586122afab8ae3624be6963d64e770b7396b2.1748911713.git.collin.funk1@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <xmqqplflsmic.fsf@gitster.g>
References: <xmqqplflsmic.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document that related `git config` variables should be placed
one-per-line instead of separated by commas.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Collin Funk <collin.funk1@gmail.com>
---
 Documentation/CodingGuidelines | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index c1046abfb7..3a7e644acf 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -877,6 +877,15 @@ Characters are also surrounded by underscores:
 As a side effect, backquoted placeholders are correctly typeset, but
 this style is not recommended.
 
+ When documenting multiple related `git config` variables, place them on
+ a separate line instead of separating them by commas. For example:
+   core.var1::
+   core.var2::
+  	This is a description of 'core.var1' and 'core.var2'.
+
+This format is required for the `generate-configlist.sh` script to
+properly generate "config-list.h".
+
 Synopsis Syntax
 
  The synopsis (a paragraph with [synopsis] attribute) is automatically
-- 
2.49.0


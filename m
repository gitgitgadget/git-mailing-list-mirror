Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36F71E008C
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 19:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732305033; cv=none; b=d2oWcvh7zmRfVdkefrGi+ODoSGCdxsKZbmlOs5J7lKn8YRN4w5ZS7Gn6CPYxMijd6jgKtRRzqpbbvCRWlm8/bvfqmmmQ7Ae/8jNurs9Qw/htf2UfLaVrxIhIfSB3C/Y5CC30BtIlD4y4WZXniuESwU4DJ2DDsBNUGhkJfEQDumU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732305033; c=relaxed/simple;
	bh=FT4hgwLwB7WAW7NCaVrrKf/Fx/J7HbJZU0g/Sopsu/0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YAbEwc4CS6un+XEr+pek5/T0kEVDS6Qk0iGS98q5Jk302vwLvOtjlRteO+jqo2eNyvndWmU4Of4m/2c/T7cYfiPU9E3BFBdSR7xmxzrzaFc1Z2chW1mict5C55OdOlY8ayM2RNpn0w0diFInE3WjOgCSQMadC8OTxUHvI42K8X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3zD/sh2; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3zD/sh2"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so22190135e9.1
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 11:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732305029; x=1732909829; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCfisCZ+uuTFcTcoJIORd7tZDbQGag4FKL6UDAsasP8=;
        b=a3zD/sh2X2j7OB9xwCyDZVPsIlcZDSMJYqmOSnuoH/vHeFS3sNQQpDL3aEmDgwg029
         Lfbi1NOAszS+UNcwzykx81MIVPhLlNuaaiuuH28Hum6tyeviaK2nnmtOaJ28j814kKd0
         7w6E/MiuJGAWNeizoyUaAcn66XnjzM0zjwHuzWaRzDy031UtRUJZcG/EZLnTR3ajFOBd
         E1ASQGfAJEB3UXmvzdZrBlEub2iePXD0iz1vAHY3GqLpUX26wpmYWAFVJHAr/EEtlv6q
         Ybgp+UQ33rp1DgVz5HxRdNVrWgYRTCH0e8ZQHIY2DPvc36/xfh6YaW/5vrlFcKDx/pmU
         UDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732305029; x=1732909829;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCfisCZ+uuTFcTcoJIORd7tZDbQGag4FKL6UDAsasP8=;
        b=oPRwyKCPTSkjs1ZPH+Uw8aRrvuVdneguk/U+hqadLteNoPIXEDmfhJhaHsCn+XX8+0
         Cf0djzECEOIZulvYb+9sKww9h71O6WkrftDcFUIGZwb14eFy1FRTJ0LvoIyVtkyX8ivJ
         QLdFAfyIP/q8U6MNoJ/g8Ewt57p2KQ/MmdTNTa1A6t6+OhC0ukrI+RYv0+zWxgLkilJD
         Zvv43bsb9JcoJeUp2LxX6yfgf/7BJm3VnlvCwpOEavT7Xwqz4+rS6e/uQDv9LK0R6vu6
         eOwT3nyTY0qLbsP3rHXYJY5g0hSkqFtNdfAv7SxLKIsDzKPv+r9jN6CgB912RLh66fFF
         G1Yw==
X-Gm-Message-State: AOJu0Yzo3dpksYxv3xLDYqKAbcB/xYlDdmucZbTYEInooJ30ohcXPnpw
	5DZogdV+L+xVmkkrQwiBzY+gg4N2UxNgYo1pTno7Ro/9E3SsF10WUuWkDw==
X-Gm-Gg: ASbGncvr4irMmsHqu/vM8JaW3j3Um4/weVHGMJVzvg2tt9tQZtHNYYCqEQeVtAmbY6W
	La+kSrSz/orqrbOI6bdKa9ui02cKx8ds1g2VZBMTwK+YB9hsRUcDds6C3OJlvNu3XCHXluSywwm
	7qUbL5kbhtr0UBcBa7/zYfEd24fLTCSicRo/7dNkAwtG0Hldfa7/pXWr+TXu3x98nxR5LePwES9
	RZyymHhv9MTR5wjOC5oGb6YYvns5OxQLzuxC/R1nvKELAVGzdM=
X-Google-Smtp-Source: AGHT+IHWx+psj0X9RxJBkyAiCYnvf/qkRQfmYkFaU/UXNt8cN3G3yYYaqLsGWqzW2Hb49mpBzfW0TQ==
X-Received: by 2002:a05:600c:a00e:b0:42d:a024:d6bb with SMTP id 5b1f17b1804b1-433ce4ac216mr34391335e9.20.1732305029318;
        Fri, 22 Nov 2024 11:50:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b45bd7d7sm103981375e9.13.2024.11.22.11.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 11:50:28 -0800 (PST)
Message-Id: <f234e965543322d96fd6aa41d12f0f52c3599206.1732305022.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1827.v2.git.1732305022.gitgitgadget@gmail.com>
References: <pull.1827.git.1731459128.gitgitgadget@gmail.com>
	<pull.1827.v2.git.1732305022.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 22 Nov 2024 19:50:21 +0000
Subject: [PATCH v2 4/5] git-mergetool--lib.sh: add error message for unknown
 tool variant
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
Cc: Seth House <seth@eseth.com>,
    David Aguilar <davvid@gmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

In setup_tool, we check if the given tool is a known variant of a tool,
and quietly return with an error if not. This leads to the following
invocation quietly failing:

	git mergetool --tool=vimdiff4

Add an error message before returning in this case.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 git-mergetool--lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index d7e410d9481..11ea181259f 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -264,6 +264,7 @@ setup_tool () {
 
 	if ! list_tool_variants | grep -q "^$tool$"
 	then
+		echo "error: unknown tool variant '$tool'" >&2
 		return 1
 	fi
 
-- 
gitgitgadget


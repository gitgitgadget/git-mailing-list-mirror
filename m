Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E585031B131
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 22:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767997431; cv=none; b=QnNeKkxFtzxsMpCfYgcMIkqQ7TMR247kJ75nnKL2TPx4oNGwzcI8uEANdCwPzuBgBNAiZ7WIPOIhuiB3JiHU2UXncDUQ1vq6eNwr+AauUq/6/KJeOljWeh4svH61XYrNsnD2d3JDRRY173O23KE0oLStTfoB3PWzeyEprGCYdLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767997431; c=relaxed/simple;
	bh=KD2RtFcwUeJkXktSOj6HvbXoWGmLF6gGN+QXt6P1/jc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=etsJaoPaLXPGjhTTwEFX8Zk0nRI+Su65DaAZN8H1PzaZ8Apc8Moj9QvH1xSpJ7xpGe94Pr/fb27OglQ15fJ+Ks16wVevmKuM7bHF+ZFl84iwoOrnFVWB/s6KuZgMW9sEGkj7Ba3e19MlODw3wCM67khRlewUI+wvcLy6JXkBEsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e02WhnDR; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e02WhnDR"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-88888d80590so57749296d6.3
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 14:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767997428; x=1768602228; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Wu+WJEVcS+59yiwWCWqOgegceD0+jNFFCR6539Uxlo=;
        b=e02WhnDRK7SH0IxTdXKgJdBXVTtD5mEI6bA48EyUqBJ0NkfwkF1cUFhiR5DvZVWh0x
         7I4hyBfjY7jJz15IcFbfzbm0lkl9DfPg4Z/ojWoZ+t0hz15PQ64tk8bSOQtwWFGwBDlZ
         n2/4AEflM11waT/VztZC1hSU79aA7O0JokpvxoHXh6ziyickqPsoQXDg2XLgIgKN8iY8
         UbHH2o8UzuHaezns4BWUC0vwa8YcsWdDzqQDLCMJpjowePssMtk+lD2ZHNmj8scKR6Us
         Efk03aySjoEf6xJLjFgMuLbE2xaQvjwm6UbEVoJeE24WqCqszGA1yj3UqMfqeIougW9Z
         NRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767997428; x=1768602228;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Wu+WJEVcS+59yiwWCWqOgegceD0+jNFFCR6539Uxlo=;
        b=CPNhyNDFDi8ZGfvZfdFQN+vZKBdPn7UxvXeEndHqjrgvhUimMF/MpNWleuNFOytBo4
         n+jkzgt6jGwZ11HCHJda58yF2aAOoALJI4d42VmwcSULs696NOrqgXDCmYlm8iiSSffi
         aC0K6HeBqVHe0KXLigdnKgojDNhMUnJo5N8rIkDl3RDxv/q2njmd76p7lAzcH9YIilla
         LO2NCi0UTViLGa+Ivt25+tPOswZoW3f/jNpg3FssC7+kpNQX5tiQzNKU/ETSVejqvluZ
         5KJEG7RYLRIt++DHaolNouHqcKc813pBqXFGZ+f8Knz8D23wiZtAQ9Bn05aWpPuAYkDM
         HNDw==
X-Gm-Message-State: AOJu0YwW+/jf3eYY7YacfWq7KL0/Fq0iUwGWjDCv10UJlvp/1C7OIibp
	C2C7FDGJc53bx3rheEcssJYhgTN+JjJKADEvZHoOzPTlgI1b4A03P2+B9z3LXg==
X-Gm-Gg: AY/fxX4tNh5r4U6cSvPx38cFndrA4Xhwm+kqEOrbtoC1Wu22qXf69YD3Wbmk9GD/VCP
	rsZ11G3V7SpjA8CC+cZo8cI4m7nGPoWdwmzRqXEejgmwhQp94LmyLGEOil/N4GHwFhrHhP6ZPWQ
	OCRefjxJbmsCkUScGjqv+eRC3T5066Draqww+m1FS94sm1/qGodMF798u/VRBmxE+AnLb46PE3n
	osvUXN6E2kEXn4csMZjET71ewtl9SYLCHrtJkoQP8a0e0GFxYVqDBvXbMSvCfTZ5rV5ncc4pMXz
	EeZdUKUpRemIiZV7jLPvJNkj84ZPo9P1vNwCuaky7nloiq/boP2unTw12erAbWuJAMMC92XmzT8
	x2QtM8M3Nu2BpsoIOxJDpyPSysOh9Kn0jq1EGRMLqIHXnPCJ+jpFy+KERS10zRfyjzbaf8mktMZ
	zUYb3M+sgmF5B5qw==
X-Google-Smtp-Source: AGHT+IEn7LDczC763wnp7Gy6bjtK/2DkLduJKA64pihp6QkuMx+kRtWp2BckKdlkLfDsnV9HFG53Tw==
X-Received: by 2002:a05:6214:e84:b0:87d:cb8d:2a98 with SMTP id 6a1803df08f44-8908417657amr147248816d6.2.1767997428561;
        Fri, 09 Jan 2026 14:23:48 -0800 (PST)
Received: from [127.0.0.1] ([135.119.237.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e4262sm82322686d6.20.2026.01.09.14.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 14:23:47 -0800 (PST)
Message-Id: <f8a8d077cd7203663406bf656287ed7e0d6e6d90.1767997426.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2121.v2.git.git.1767997426.gitgitgadget@gmail.com>
References: <pull.2121.git.git.1765303880.gitgitgadget@gmail.com>
	<pull.2121.v2.git.git.1767997426.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Samo=20Poga=C4=8Dnik?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 22:23:45 +0000
Subject: [PATCH v2 1/2] shallow: free local object_array allocations
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Samo =?UTF-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>,
    =?UTF-8?q?Samo=20Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>

From: =?UTF-8?q?Samo=20Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>

The local object_array 'stack' in get_shallow_commits() function
does not free its dynamic elements before the function returns.
As a result elements remain allocated and their reference forgotten.

Also note, that test 'fetching deepen beyond merged branch' added by
'shallow: handling fetch relative-deepen' patch fails without this
correction in linux-leaks and linux-reftable-leaks test runs.

Signed-off-by: Samo Pogačnik <samo_pogacnik@t-2.net>
---
 shallow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/shallow.c b/shallow.c
index 55b9cd9d3f..497a25836b 100644
--- a/shallow.c
+++ b/shallow.c
@@ -198,6 +198,7 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 		}
 	}
 	deep_clear_commit_depth(&depths, free_depth_in_slab);
+	object_array_clear(&stack);
 
 	return result;
 }
-- 
gitgitgadget


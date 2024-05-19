Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882D4EAC7
	for <git@vger.kernel.org>; Sun, 19 May 2024 07:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716102624; cv=none; b=EbBgicoehpje2W/Nd11Mfguw1avMgDlkFeugyqtRwBlx/XG1d13hEZ8bhfRqeWncOx6cL9RK3LDj/cPqztVu+vwGZv4AqRiUaaUl5VJ5D/lbjcbFXp55YY9Vfn0ZYVP++26E/GsI2vmF5OVD6MXg5kby7wetUG7vXhnE5xN8+jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716102624; c=relaxed/simple;
	bh=LEuX1adZnCKgieBrx27KhCNr96hqkf7UITJBXOBALlI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=MItJknC7uQtdu/I0G/IusxRiqxQ1ZV1sfePKjzVYi0+qpd1uIjzi4KLOljW1VCYHHaiekxyZcBMN/uTXtaiaEldTvcwCeP+5HRlfzGAN2oCK4jTvz40AqKusyaSIGX3ewQplk58O/RVXdMoDrSlvV7wxYsL/nwYeN+SA6hTunXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gx93k9kA; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gx93k9kA"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41fd5dc0439so12116505e9.0
        for <git@vger.kernel.org>; Sun, 19 May 2024 00:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716102621; x=1716707421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGrLDrMzJZkxdvn4MPKimjHXx4wtUjAqflv7xuqgZPY=;
        b=Gx93k9kAGkChpZJoAK3j8i+iR9pxUUKhCeqcl0jazkBE8bZcNBKCbycaaLL6AIqGRh
         WQE2Lsad4XGNolzM7zLAzPQAdhAxdLZzmXZ6TV3JA9kOY026X0aWvCQt5jK64mhoLScx
         UtvO0nJB7IlEiiJIr/wlNaSdytv2UaluruURNKhzIYg/j/UNc/Bixb8KJWpDNfm1mC2s
         dJGHGozhr0l8hMvHoRwRv1vNRtMZCx4kRFXHMiLYG784q/H/Wn0DGO4LfjEWYyrRn8VQ
         taUSqTHfBUPSwSugFiaC3n2AjazgGL00+lfttj5YHZ+1NkDcCNmJ2pMuNNl2vDJTC1b7
         I7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716102621; x=1716707421;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rGrLDrMzJZkxdvn4MPKimjHXx4wtUjAqflv7xuqgZPY=;
        b=pA/IoWiKBSvhX9GPTnL3YvgQ/GtS0zjGN904fJ/br3iGSpAWn0Svp+tvCZAC4J+BUw
         aQ58FGjr86BoRENaUJVXH57e9XLjU73H86qdTJBfeu6zo4kzyEZFGRzmQ8wGvJ15kGmu
         HX5Nqgnu2uybT3xk9VIKcX9cRuyxOxjMGSiC5L2Tt/FoWBmItiAz3jdRtYeQBg/GV374
         KPlqFSE/a1lTu/7EI1vogf+iDYDQ1cUNwOO88j38+L+6tgQEblNVz3+OVAZbAYSfQgXB
         kaN84QIYaXsCnKvuVq8LUqJU0shYa8LlR+Au55lyoKr50AGoCiWNpkxmiGZf327sYqYB
         q7HA==
X-Gm-Message-State: AOJu0YxgAuGgV9zB/wcXDuLxZbQWHiqFqxsP5LgfGmdaOxkoXldh7iiQ
	HnpAU2vU9QltZ4OldHsgQyA+UvgusM4wnxurLFaIBHoPHzlEi+cck/3ZCQ==
X-Google-Smtp-Source: AGHT+IEauhbTKDuJbWGYjt8U9pP9qNoEkdo/BtijJyd1WKCNybeLpy60lNHDIXrnR/20DkrOE93YEQ==
X-Received: by 2002:a05:600c:1913:b0:420:141d:994f with SMTP id 5b1f17b1804b1-420141d9a56mr160827525e9.18.1716102620703;
        Sun, 19 May 2024 00:10:20 -0700 (PDT)
Received: from gmail.com (173.red-88-14-51.dynamicip.rima-tde.net. [88.14.51.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42010b1076dsm289258095e9.41.2024.05.19.00.10.18
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 May 2024 00:10:19 -0700 (PDT)
Message-ID: <fc307b09-29ae-4013-b5b9-580b6cff5445@gmail.com>
Date: Sun, 19 May 2024 09:10:16 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/5] add-patch: test for 'p' command
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
Content-Language: en-US
In-Reply-To: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a test for the 'p' command, which was introduced in 66c14ab592
(add-patch: introduce 'p' in interactive-patch, 2024-03-29).

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 t/t3701-add-interactive.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 28a95a775d..52d7830de2 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -542,6 +542,22 @@ test_expect_success 'goto hunk' '
 	test_cmp expect actual.trimmed
 '
 
+test_expect_success 'print again the hunk' '
+	test_when_finished "git reset" &&
+	tr _ " " >expect <<-EOF &&
+	+15
+	 20
+	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? @@ -1,2 +1,3 @@
+	 10
+	+15
+	 20
+	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?_
+	EOF
+	test_write_lines s y g 1 p | git add -p >actual &&
+	tail -n 7 <actual >actual.trimmed &&
+	test_cmp expect actual.trimmed
+'
+
 test_expect_success 'navigate to hunk via regex' '
 	test_when_finished "git reset" &&
 	tr _ " " >expect <<-EOF &&
-- 
2.45.1.209.gd5886bf9cd

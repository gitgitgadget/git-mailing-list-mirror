Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAA164AA4
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 06:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785998432; cv=none; b=CRfiqsy89JXGgUhdYNjod43aMt21N79fcaaatg35mivhcZ8S1VOEZBdv+jxZvklq4iLhxDvJ06fE84IJxvvd2PAtWqF1FtUZJk09cy7jzvUVSRPrQ845uXPKl3JhccA+GuhDwY7rVBsWlgPjuj15tn5xyW8TAQZgbfY+8xy+5EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785998432; c=relaxed/simple;
	bh=qAdEKAIRDOr++RYkRsFhOY2LNN40LmMnAxjXGhkEWS0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=j75W8OHKknab0IlNfSfUVwa2yudh6zpsTMqCPsDfI6MFdYVx3FxEwfAJzJ/p2b8DnkW0A5qaQUxhz9kQKT0NnNrLvPgbyXVlG7Kjgh/Ym0X6NTJQBLXhntSSmUMLJUGvrtkoilguhpgJG5fxB/R0mn9IiwE3fUogyqwpGYLgAsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tCFRJEfR; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCFRJEfR"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7eb545db3afso1342959a34.0
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 23:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785998430; x=1786603230; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NmYdCvO2r3VbJm5EKTVC1FdS3+8DodpenMpqpALI/b8=;
        b=tCFRJEfRGJXsLitnkVZ2y1dcgUABYuQkJZnwHZD3ZnNZ2mGrlhiEPNSgiyKWUycNyJ
         dW7KsyDXt9Gu7tJgIaXKGiL/en/kY7b+stoUrxwlun6csG0yFbOV6AmH+8w3Y+iHE210
         4VTbs9awBULaEIhAlourWps4E2Mu2jJ8bIKdmR8q/DRrBSoU7fP994P0xj8TLiCS+gRp
         ZiqHzRW/JTrCU9K3iHbrBc8Pwv60H8vhOE31wF+kyWUoaw8Uf8B7r1ukvul624j/JR86
         E0UB6MINxY+0JJeE5fnm9J7iN0guzgb9dX94JTSHhaX4RTHd6C3iWtaK0HZ5LyD9jiZH
         adjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785998430; x=1786603230;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NmYdCvO2r3VbJm5EKTVC1FdS3+8DodpenMpqpALI/b8=;
        b=CVP4gwHITbwC2YFaw11jn5tlZltI00CnoAS6ee3T1KLM+vnFpnb+8bdaQ9Dyy400qz
         YLJ0Ov31rF7niLww9JIgP2dgU0hNtn3LxkJnIIPTH3p8kYTVcuo5NdQWalOODYI+5d+J
         mZQbXpQiTDX6hoYeDC8qY0/D7mXpUoLYWd42fnSbVpOz24h1gW8p3mVt4f5znFn0XZO/
         Ixbe0zGxkBGSuGLeTUwcgnEk35HwmvRzRFNFhpDyp9NNE9ZQQN827xwK58Hfg2xJP69t
         zuCBzZQKj7brr1nL8vEgWMW2R/s+ZZRBYZy1LQFSJfDFlfwHgcU2QUaPk2yC5NjJyulV
         JgBA==
X-Gm-Message-State: AOJu0Yxtx4iiPEkuDzv/UFhxMWYsM4O4/kdJFYdQM4zYy1ZFPvYZhIND
	M3Mb4YfBjZZq6l8/7/jaqaa+mIYYAt+JE3Qujor0KL4xEQ60ZNuM51lud7neLeVp
X-Gm-Gg: AR+sD129ooSr54nIvmOebercCQFn9XaptHtA7uQ05vDwFXkTxShj6CbnS54ccdX2S8A
	MhK0q2hn2NkOI7JYBZpYuq/Nb7+lCpEkKrdqO9be2wTxdBFrVArX5iXEYsGPYoq7IWPzE1GF4z3
	yjuv72V0Khmxoz7H15NBIu8c4ASyOEN6yRt/kLarjEBV1I9I8JZpn/z7E2rBMdb22eM8KMi+LYP
	/U29oJYl+ExucwDpediuZks5TZ+VzSQNwfgaPhds7qpdLD/xb+1V1+EHG3kK8XJD/bKPIY6CwnM
	gliEif/oq+LF24g85wogRSpLzsbhCAXvQwoQJt1Fl/kv0ycd5c28eM1Vawmi10OVMZgVpeN2leA
	c0TJa9fbLcxV2T+BL+LYEmH2QLZunIQQNE616F5VhWuMHPvXZkfLhENNIL7ciSRXPM6LF20AauW
	XVSE6yqNU9rOqUVk9c8w2i814KU2O+j4/UTMEmsCfGZn29gueG8pKVueuWD0k0izzC
X-Received: by 2002:a05:6830:67f4:b0:7dd:9b19:a87b with SMTP id 46e09a7af769-7f1e5d0f308mr8081863a34.4.1785998430500;
        Wed, 05 Aug 2026 23:40:30 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.167.80])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f1df345f4dsm4011660a34.12.2026.08.05.23.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 23:40:29 -0700 (PDT)
Message-Id: <0428a92efc4657d2da1e968ebe45038cd186b055.1785998419.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2194.git.1785998419.gitgitgadget@gmail.com>
References: <pull.2194.git.1785998419.gitgitgadget@gmail.com>
From: "Johannes Sixt via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Aug 2026 06:40:16 +0000
Subject: [PATCH 3/5] gitk: show color preferences on the button instead of the
 label
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
Cc: Johannes Sixt <j6t@kdbg.org>,
    Johannes Sixt <j6t@kdbg.org>

From: Johannes Sixt <j6t@kdbg.org>

When the user goes to the color preferences, the eye is automatically
drawn to the color samples. However, clicking on the sample with the
intent to change it does nothing. Instead, the text label also acts as
a button and must be clicked to change the color.

Turn the color samples into clickable buttons and the text labels into
static text. Use non-themed buttons because their color can be changed
by simply specifying the color properties. (Themed buttons would need
a lot more elaboration.)

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 gitk-git/gitk | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 137940defb..877b2ad27f 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -11867,10 +11867,10 @@ proc prefspage_colors {notebook} {
     ]
 
     foreach {uielem colorvar idx label title} $coloruielems {
-        label $page.$uielem -padx 40 -relief sunk
-        ttk::button $page.${uielem}btn -text $label \
+        ttk::label $page.$uielem -text $label
+        button $page.${uielem}btn -padx 40 -pady 0 \
             -command [list choosecolor $colorvar $idx $page $title]
-        grid x $page.${uielem}btn $page.$uielem -sticky w
+        grid x $page.$uielem $page.${uielem}btn -sticky w
     }
 
     grid columnconfigure $page 2 -weight 1
@@ -11896,7 +11896,7 @@ proc prefspage_set_colorswatches {page} {
         linkfg    $linkfgcolor \
     ]
     foreach {uielem color} $coloruielems {
-        $page.$uielem configure -background $color
+        $page.${uielem}btn configure -background $color -activebackground $color
     }
 }
 
-- 
gitgitgadget


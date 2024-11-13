Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5E06FB9
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 00:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731459135; cv=none; b=diR0Kj2B+jzdZ6W6tQzD9v3G9em/PxDmVRnTYUf7mZNLRKc74t3bxy7EU7UlZoh71p6JQcsOq/SFVjlXfMjAE3B84U06ckMw0MQghYang9VajxLHmep7NWqUTHNCDaEEvKhTaoUo/H8tCUbLjW7yRNouHx8MTYFEL/KQFXcJQiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731459135; c=relaxed/simple;
	bh=n1G7BircBUoK42sbe7P8yVNmu2+ti0UN8DPuRet7fW0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fb4HRM6o5tcm+Za99Og3P+ME8fVw/Olz9dXtek2odT0y3ow9BHjmRiMW+bMw8IR7c7Qwat49umyCZyd9gg2d4iXbk46Msyjn1MrToiTS52TLstv4MXQyVUHZFroh4Khq6Y9c6qLaYQU6alBbYLH2aMdxxxAIrs5urHBtKOdI6js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBskmyfk; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBskmyfk"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so56254835e9.1
        for <git@vger.kernel.org>; Tue, 12 Nov 2024 16:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731459132; x=1732063932; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HY5kvNHgWqSM17OD+FB5pLV910wid+teJHraOEqrut0=;
        b=JBskmyfkA/1DbXmnDWfplJ0O6F4cYPuL12ni3i8dRgTbaiG3hEteM/w5yFYx2Mk3xU
         z+evl3p1BUt9f9GWZSEvGjHeP7xqzU2SZeP9Mq9avTDCKUEIT1ju450MOOxlImGi8kVX
         FMCjuoSIOiAdoxchGdKXifL/pYBE1ZNObdSbncXcPpLicoFwlLnlaYNjpDuAaj7GHxhK
         Ro5TlApBnb1dr4voP1439X0IlGdpvSwQn0JAuy1tMpDo0IHt5QpTVESkhtTNH67URpeQ
         p6lLa7KCldw1Omr/hoIWUAyGopwriWxA6XOpYZp8Xn4LMx39sDLhnzAaFIwnNk3cmdP9
         ilPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731459132; x=1732063932;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HY5kvNHgWqSM17OD+FB5pLV910wid+teJHraOEqrut0=;
        b=xQJE36YCmxVAniQJlvdT+SJ/VXuD7B5iVz0M9ibh6CV4YWXlxMirc/insO5GGiDg0A
         YzoLJPkewUcE/oW/pQimonWaPz8OWgMOvuZjYA1uMGjm5gwMqdRi5qnQtdUT1dYDdqcl
         GFL7vD4BHtpDkZP6qsQ/GP/GLWNwGEvj1kjzEU8h+rKVlcapVLK9q6MzjHFqf/BdZSt6
         ARiSIaG9UxNBlePOF1qzhZwilw9rlmgZ6FjVqMfVx03ZUbMqPG/XyFS6luV0+j8hmWum
         Xt8225lllYtH0DrzOJkolktQ4IrgQsFQPinCLyyigwgu0g/4ThaWlQ6YY8HYFhZcz6v/
         AJsA==
X-Gm-Message-State: AOJu0YwwSbSV6Xlgik+gWqL2RBKoSUP+bGb3aKJRGDMUIAb6y+OwhUVe
	ngFr0ymylXl8uBi9yKPS6Pw6Dx48BjYP91cVLoDjZod861hUYDpQGveONQ==
X-Google-Smtp-Source: AGHT+IErpDCJsqcw/XPoycCCILoqiLLBEjw1mlQ9lvsBHc+jq2ooI9C1tgCgkG/jXRnrF8td+71EcA==
X-Received: by 2002:a05:600c:1c8a:b0:431:5ba1:a529 with SMTP id 5b1f17b1804b1-432b7503557mr160334385e9.14.1731459131669;
        Tue, 12 Nov 2024 16:52:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d550f23bsm4677695e9.35.2024.11.12.16.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 16:52:11 -0800 (PST)
Message-Id: <6f7f553b283078ba3c81190686b150a87d901240.1731459128.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1827.git.1731459128.gitgitgadget@gmail.com>
References: <pull.1827.git.1731459128.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 13 Nov 2024 00:52:05 +0000
Subject: [PATCH 2/5] git-mergetool--lib.sh: use TOOL_MODE when erroring about
 unknown tool
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

In git-mergetool--lib.sh::get_merge_tool_path, we check if the chosen
tool is valid via valid_tool and exit with an error message if not. This
error message mentions "Unknown merge tool", even if the command the
user tried was 'git difftool --tool=unknown'. Use the global 'TOOL_MODE'
variable for a more correct error message.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 git-mergetool--lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 1ff26170ffc..269a60ea44c 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -474,7 +474,7 @@ get_merge_tool_path () {
 	merge_tool="$1"
 	if ! valid_tool "$merge_tool"
 	then
-		echo >&2 "Unknown merge tool $merge_tool"
+		echo >&2 "Unknown $TOOL_MODE tool $merge_tool"
 		exit 1
 	fi
 	if diff_mode
-- 
gitgitgadget


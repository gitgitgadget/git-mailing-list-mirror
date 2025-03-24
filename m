Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDED1C84A7
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 20:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742849614; cv=none; b=qGMPVLG5TWA6Jzu9ZGZ3QekS4++C8Pp4FxHqD9LPszo1A8IY1hfPDCT2c3JEKFCaq3qEc7BDFgwUc/jRYVEv6um6DH977j37cUSosxTBxc00ie67BoMg8C/rlRdzHARpn4SWIO82ItYWkQQ5YYRu4bluSiTyqRKA3XQjWMx+pdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742849614; c=relaxed/simple;
	bh=hOXE1B8viWzlCjNn/J6Cd7e+LUlu8GH/VqSuNUONmrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tQ6EKIRu4uQSnMM27u6+2gaZ7cllakyWq0Ahk8EErnw7Jd29AbLLyn81B5ZnkkrKAs/Ufp4URXBtQHyngh6YuLIzI+vi+s8pTMBIesuE+YJhGBzjweyPOZO3xUvqVbepzwTgWDgxsD53nrU3HWrTX10Ko4wQmNWD5I+nmsriulo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0maTyfD; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0maTyfD"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6fead015247so38829447b3.2
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 13:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742849612; x=1743454412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=YZ81+jgyU4HCZnUGrVIORPiEuq+J5FOfPnlXYQZAuEM=;
        b=e0maTyfDy1/zcMpK6UHe51ohupwuUmOJYap+iHyckJguJNP3awxMFmQgM+nClLJM2D
         etaM/a4VVcuvX0FvYhD1IMHSzkuE8HgF1Dx1fkH/958DHKGe0Lbm4Hj6cQRKPUWojVo7
         lXdxk0ftL69cQRx8bystnM+HooklbvlcErlpw9cY/2qDPPauuiPeYhXC3vL3mEzasy/G
         kXKshyO0baq6FzPc/HZ8iBFgyzNuxksffYaNDmlSM2hEyOaabAQy3gXWBPGc5Ri0+tEK
         lsM2n1xM+Pu3UN4Vfn13BB7DfwAq5CYr8CszsilRbrBQyNPWjZNGXZgGh8gFtOLLHcrQ
         PR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742849612; x=1743454412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZ81+jgyU4HCZnUGrVIORPiEuq+J5FOfPnlXYQZAuEM=;
        b=jgsXryEIzacuN4wvNfxRzS4J88SGnZmLVLS9NJr3HTNTuzFhd2mVKSZroPXLMimdBH
         tJqOmJa1Ebzc7z0VZWSS7JtQxDTJK3Ayo9MpOqW5Q5dh54eMCTPi/F/HAvBioiw5LNM/
         jINsIb+yUM75o7dF5MRoPU5UhjTL/Ldl2j6eaOS+rzCHwJBteLxwNS4dmRQJ+T0G/IH9
         LoZj/UDhnrX8xtgCfHRhNRykxYrAaJSjXboGtVMtQ0/aZjM177ge0zMkOmrrm/Jjw6jR
         oSoKTPUY5eU5jN28Xkp0jzm+SZ1XSCx4PH/nxQSOyHDDLNoDX/IBozBbDB4gQW8FBJL8
         S4Xw==
X-Gm-Message-State: AOJu0Ywg+eB927gEh4NqGzhd8kJiVH+0zK8+TQBCnftLNNd7/YMk+u1b
	hAeI9UnN4NokvFsTJQPjSzmoecp2TIPdQZ2+pRGRMTN7A5P11MNhwTxzDhb5
X-Gm-Gg: ASbGncvoGHl84e0foPyKMHbLKkQ/nTrOYHEVRVm/BmGOxhM77FmjxpzQ0tSO5xqGqiE
	ab1Qe6Jb1HjoM4dNACraI/Cb094nOpn+SxXRuW1fnWdDV8U2ExcQyAKkiueuzPu76fN+0N7wywk
	qrizQhnMViLESNsWg0ZdhrYJ5OCQLmd75hjRzCdG2KmY3lIll9Sbo8EmbN4w5U04hIeXQB+5NUf
	1if2a94BAw77Y0S9Lqg+IvNFroDQhAZbNjMHcGxZolgsOgI1ak7vO0d5pPwOtYoAmf9sQcvL2Fs
	16v7JJK2ZrNeJiAtPbbbe+3N4puLbw7HV6O4+06KpK0nzjJW+cqCa7AN/gVQ31KE3t6GIwJcGzm
	mBJBY2w9xhRk+yRefXyg=
X-Google-Smtp-Source: AGHT+IGyV3ZV8Rsi/qY1EgoTTYLgGm7UacCn0l8iiZuZP/mIt8+ao/JQh0JkmRViUhxesGgyK3Og0A==
X-Received: by 2002:a05:690c:3393:b0:6f9:871e:6903 with SMTP id 00721157ae682-700bad24c17mr204967167b3.37.1742849611690;
        Mon, 24 Mar 2025 13:53:31 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:9085:3000:f45e:232c:5c43:1e93])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-700ba8c7f65sm17114127b3.122.2025.03.24.13.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 13:53:30 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Fernando Ramos <greenfoo@u92.eu>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] vimdiff: clarify the sigil used for marking the buffer to save
Date: Mon, 24 Mar 2025 16:52:23 -0400
Message-ID: <20250324205327.79627-1-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The original documentation from 7b5cf8be18 (vimdiff: add tool
documentation, 2022-03-30) mistakenly described the marker as an
asterisk, which is the character "*". The code and examples have always
looked for an arobase ("@").

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---

- v2 signs off the patch ;)
- v1 with notes on the name arobase and scope of change: https://lore.kernel.org/git/CAPig+cQg_VTN7Ug3FTdLdkVwSPZGiQHJZSpCkA2pTxwBiT29bw@mail.gmail.com/

 Documentation/mergetools/vimdiff.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mergetools/vimdiff.adoc b/Documentation/mergetools/vimdiff.adoc
index befa86d692..ab915df408 100644
--- a/Documentation/mergetools/vimdiff.adoc
+++ b/Documentation/mergetools/vimdiff.adoc
@@ -86,7 +86,7 @@ command.
 +
 --
 When `MERGED` is not present in the layout, you must "mark" one of the
-buffers with an asterisk. That will become the buffer you need to edit and
+buffers with an arobase (`@`). That will become the buffer you need to edit and
 save after resolving the conflicts.
 ....
 ------------------------------------------

Diff-intervalle contre v1 :
1:  5b8b824e61 ! 1:  4ab274c3c4 vimdiff: clarify the sigil used for marking the buffer to save
    @@ Commit message
         asterisk, which is the character "*". The code and examples have always
         looked for an arobase ("@").
     
    +    Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
    +
      ## Documentation/mergetools/vimdiff.adoc ##
     @@ Documentation/mergetools/vimdiff.adoc: command.
      +
-- 
2.48.1


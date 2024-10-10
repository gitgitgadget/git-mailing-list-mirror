Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3281C9B88
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 13:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728566448; cv=none; b=PQf59XU2c2/ldmWMFleKo7YNMdPbOhtut76/UO/ZRasFTF1/Nk5RsFMDC4crKBdwzY+RiGNZBvuLdHWaxtg6hUBLJYMyva+RvI3MYdIjYd7Ha4GjTn6Jl2chnrgqlZFuics862eqsOyRHPi2QuGwM4YX6VlUoKXWYBJMTBO2KZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728566448; c=relaxed/simple;
	bh=z+pxM4Ip/l5wEEeqXVONCPv05FMpekQq82BBu/efAQg=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Q4akKzk6n9vR6wzkJj+Wga1K2TNgCZqBogzNkxa5ps6jVPbf4rcQbOQ+kqboqnsI+BFtbeXPU4Gnc/8gn5krfSc5NNRc5O5fMbSV3qzOg5uuhjMMYq3hM+o+BfoKOKl5sYhfOQOAcnZ0EdBci5iitnRVtFcX9vuYo1re1Nw1Cg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFgJztBG; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFgJztBG"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9950d27234so135855666b.1
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 06:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728566444; x=1729171244; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qhNLuigEnzxx+oZB2yedrOLnuLlxcHKpBiOijb2hBV4=;
        b=FFgJztBGfQed8Xw6/jXIX+VHrxxze8lzFtXSv5cMWAb/spmel4ZiWe0h9XmqmX77UR
         0kP2G4ucO9Yc/wTlf41nF1M4lDHkYR4lrA/IeBvFXLsEgomBUp58bu6Z9OTvPj1Z2+Nv
         QjY6V8wrAlIlZQiEGSqfunK6rS6Nf2iNcSrvC9fCkrQtqUqkQW9v9GcZ41buQ0RnB7Oi
         hfphsYHy3BdKzFCBz8V1899WOHq8U3RnOzuODiSZimL4VIcvjk8rurHRdDN3yNQXKXL2
         fFfTjNoUzxOH2SPXuqzKYSVPHsQCnoujkChJrlKcByGlZagjb98rNEyY+jACxybnGaed
         jLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728566444; x=1729171244;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qhNLuigEnzxx+oZB2yedrOLnuLlxcHKpBiOijb2hBV4=;
        b=RHrjcD8N2aV7F5sAtOrH6aEXrznD3Ke4EwynE8Jf9CmRDCeYH5eNZ/Hxehcy0e7Fmb
         DZxR+URdlryCLsSL65WyJSiDZQmAdyz2EEskpfHcY/XYmj9QOTK+qS8gL/lUdBsTcGo0
         R/0U/xU1ZYkDY0S1vLmAQ9+MaEW2caerJqFWjbAG168vj4kzFq1R3GXKoDvXVXMgWALZ
         g6evfTU3TfKxYt1c+G+9tC/m/piVerNMygx0qx6BUiuXXsc1FQ6x7kTMzNxZzh+BwVTD
         34ahrrDz3waXLMMmOxmKwNSSYAwM/YDgWZGb48/22EOaglYnehTqhVCQ2hB/GEFf2xU8
         s8ow==
X-Gm-Message-State: AOJu0Yze/APf/bW/FtLvgNOLg9OssTFYmrtLzvxK4yexG0pvPFp7m5vO
	EMj0Bk4VDzvpudjTMGI5548kiJCcTslrT0L06vdQ0cgF+PgUVoXP0XUgiA==
X-Google-Smtp-Source: AGHT+IFOi/Gs4ftsbTAYCoPVU7aWHvt09ejiixGksz5jCTG/0cl/zOly9Xa+Ve8FNAVm9CF+TkVqqA==
X-Received: by 2002:a17:907:972a:b0:a99:537d:5d10 with SMTP id a640c23a62f3a-a998cf3aee8mr487598466b.0.1728566444162;
        Thu, 10 Oct 2024 06:20:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7ede515sm87953566b.45.2024.10.10.06.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 06:20:43 -0700 (PDT)
Message-Id: <pull.1807.git.git.1728566443089.gitgitgadget@gmail.com>
From: "blanet via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 10 Oct 2024 13:20:42 +0000
Subject: [PATCH] Documentation/gitprotocol-v2.txt: fix a slight inconsistency
 in format
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
Cc: blanet <bupt_xingxin@163.com>,
    Xing Xin <xingxin.xx@bytedance.com>

From: Xing Xin <xingxin.xx@bytedance.com>

Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
---
    Documentation/gitprotocol-v2.txt fix a slight inconsistency in format

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1807%2Fblanet%2Fxx%2Fdoc-format-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1807/blanet/xx/doc-format-v1
Pull-Request: https://github.com/git/git/pull/1807

 Documentation/gitprotocol-v2.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotocol-v2.txt
index 414bc625d5d..ca83b2ecc54 100644
--- a/Documentation/gitprotocol-v2.txt
+++ b/Documentation/gitprotocol-v2.txt
@@ -527,8 +527,8 @@ a request.
 
 The provided options must not contain a NUL or LF character.
 
- object-format
-~~~~~~~~~~~~~~~
+object-format
+~~~~~~~~~~~~~
 
 The server can advertise the `object-format` capability with a value `X` (in the
 form `object-format=X`) to notify the client that the server is able to deal

base-commit: 777489f9e09c8d0dd6b12f9d90de6376330577a2
-- 
gitgitgadget

Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCB823AB9C
	for <git@vger.kernel.org>; Sat, 20 Sep 2025 18:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758393617; cv=none; b=qMJW6rlneU7aPCws/WNQl1UMOklndcLxIUgLlnaUh5j5vhzXnl+6OJEJsw30gHF7JoJ7QTXrsu2XM9i/s5jVlISYmAQM+1N6rwLg7b+GB6MDZyYiqJp+DRVLENrsMlaleU4WzUo8IPQri3kZyliATNZ5om0uA3n7K64vnRe+p0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758393617; c=relaxed/simple;
	bh=dyRxNwE/YUEjnNz91PvYohwqANxCF35nGqW4TbQcoIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ptVvXLx8VcZBb7GCZvOOLME9C2cC/aOqSz/8/KEQsCwIyRabyKWBAgFvj2qaAfykl6NYKwnk5byZvskK/psWi7qPXIdRY7F8+R1s/ARTUueIXeerDjsxN1HGcjtPZiwz59woK/LsxtST98wYG9HbCPiUcUgQD1vex8xx1EUuYzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRK0l/Yb; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRK0l/Yb"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-723ad237d1eso29360327b3.1
        for <git@vger.kernel.org>; Sat, 20 Sep 2025 11:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758393615; x=1758998415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kvdy2f6pARQiW3kHtwBrv/laSMDyLMgmXmGgoCMW4OM=;
        b=mRK0l/YbAYZhPXmVikx+Fb4bjF197XP5o9pSpTGsOG/v1HU31yzr6GWvNOVH0m9irf
         mXj8jo2T6YYqFaIrGu3onJlWJ73GMYEbNExA5hbxMu80vYGLXYkvE+ADE7QujZNCVQXd
         E3rZRPONOlU2SYppQ6q9//E77V2ldZXsm95ONuX9xBkk2e9Vu157cBSL88XOjka7Fxm0
         Q8TUPFC3hCWhx+N0bFyAwKIaj3zP3Hnl8DU/x8XCU2vyVDcTKwqbsHGZ+vuZzvQxi5eh
         +GUpWHViKxN1t1M+N4Sv99FwpPTZD4q21qtPMKUi5LC8RvtHGSrGrMJqSo5Xzf0QfxFg
         gwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758393615; x=1758998415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kvdy2f6pARQiW3kHtwBrv/laSMDyLMgmXmGgoCMW4OM=;
        b=wyf1k6b625aSAiFBT8fLQjl00dQp5m6LlnmgSos5vCXvF+SyFIX23kDeVYJMwkfqeF
         ZRm/nvbY72q30VepkWsvfoZ+ZYq6DbIeaSSPAioG+/hi40DaBeFfAmDKCcDOi77Nn7lp
         ACqDDjwFLkGDN93L/7vueQDDxppMgk3D2C/rawrbGxSdRghcPNjaXzbfh7VmnbnJ9K/g
         fKGg6iM5KttJK/0PMm7Efuf/vw/ytm9WmC8MEBbu+fe7JEN8pqVCFU0nteKnC/xxyfyE
         EEBYeN7LUALkrarjgFFkKj5Ss7DokXxrRNZ72O8AV6w3cJqowgg875xSMbTJn8VN7+D/
         izmQ==
X-Gm-Message-State: AOJu0YzzEdhKhMh6T+SMz/egNjPLSigLnAQ0rLPE1wPoKJS4/jGS+9md
	IW0lVqEnVYjKGM+a2DhOfU40A75lnxyi8F/YCwc4rmHI0YTvOMF2aqYyalmK6xYR
X-Gm-Gg: ASbGncvAJOU2vXl73pkpbWhmqC4Q+ELUtMfSrUWOkpO+4Xwd+1YwPlMDL18zULSuFg0
	w9X/1RaT3comAy9KPt345mSzaL4BEd9ZqDWQwvBobI2OJEh5uJDljtPlqJyR/oQw0GP+GGJyOgS
	cn9NCTgb2TwMyQzvTtCsVal/5eXCey3YGnmJ+yXg3Vn+v5gBwz5pxMe+2fqLS3heudkekfrceSK
	l8Ian2IvJsNtpK9fYCv/TAm7NSp6phuTzryVMO9foquMyw0U2YfRAA8uiBlxHcxAbhGYWoEelnW
	iiPnea+gELinLgVdPtW+Sk7CpKm8KWmq9b5KpfSWZJPJ53QVB4WQmS8lZ4TWUj2bEN/fzANCyOk
	Z24tF25eJKX8WSeweRAKaaz4mni+G8q2UgmDyKPZ0764sqbmtDxLUlks7ncXtfROwjLMWClZv8C
	9uiUOuR438RDWcl0w+xjbvJ65+aGgMTpY=
X-Google-Smtp-Source: AGHT+IEWoeS+Yk8fRQchIDaQVNz7nsHLREuzl3JfbALO2F0W80M+SE6/amAsXVlIlK2VuyD2HyNKwg==
X-Received: by 2002:a05:690c:a003:b0:735:2003:dc1a with SMTP id 00721157ae682-73d30e5774cmr48660247b3.3.1758393614510;
        Sat, 20 Sep 2025 11:40:14 -0700 (PDT)
Received: from USROMMRAPPAZZ01.infor.com (pool-74-105-50-139.nwrknj.fios.verizon.net. [74.105.50.139])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7397188c02asm22814067b3.49.2025.09.20.11.40.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 20 Sep 2025 11:40:13 -0700 (PDT)
From: Michael Rappazzo <rappazzo@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v2 0/2] gitk: make the 'Tags and Heads' window geometry sticky
Date: Sat, 20 Sep 2025 14:40:05 -0400
Message-ID: <20250920184007.26183-1-rappazzo@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Differences from v1:
 - Add a fix to adjust the position of the main window on open.
   Previously, the size was preserved, but not the position.
 - Simplified the mechanism for storing the size and position of the
   tags and head view to use absolute positioning instead of being
   relative to the parent window.

Michael Rappazzo (2):
  gitk: fix the position of the main main window on initialize
  gitk: make Tags and Heads window geometry sticky

 gitk | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

-- 
2.51.0


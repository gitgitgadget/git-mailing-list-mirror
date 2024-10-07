Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE151D1319
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 11:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728299471; cv=none; b=dNrk52+chRioHieEwfFYNGdR9ChNWhJYb5qUCxAdkXtmUEsyV7tHU0ynIL7Gh958Z8dNfZmcFvx5DTDYJgUaMkXN2a5z80HIxMP3DlzteO07X+dFgiPKUaYYc4ElHNAhxmH2QrbDancPleerAO3FY+s8YSzc7MgIGCTqxcK5NaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728299471; c=relaxed/simple;
	bh=HGbzI0+0tCe6gbfdf45iGrEx0RytZruMhS9y3/IvNos=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VxdwJVvGOUuccuykSs9MqZ/K1aDKwAVD2jnwVQ3nxpuwRL3T4GstCyTYkCXuikmPW5i3cHWuq+/40gYlZLTyDsWeYF+fYh3FZLEOSUhl88xhqLJLmQN+bU7+yiKDidaSUIZBg95DB/qTH4CA2chqqnt/EWN1QrJ08vhCZis7naE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f07+WDHx; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f07+WDHx"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7aa086b077so494195766b.0
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 04:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728299467; x=1728904267; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFDw9iu2e6StLFgnakN4cTW1F9f5/HVlphDerb/pfAU=;
        b=f07+WDHxzINM/jJ1OqWNsLGy4Z7exT5DkH6BpLdbTG4RUFPju9ZZw1c7S+Juj/nUVR
         /kIC+1RVqsXHpZn7hALqHFTaA/VqMCPyVo0YQUt3NIyY22fKheevUZv2DNs3qacn2tPY
         Oy8h1CRwmbwNFi5H9tfaanx1onOVq/vmJBK7KFrC7O5pI6yxzEpUNsGPkw45TOnqoY4H
         WEMWiTqVP7zbGjEvhSWTgH3xZQ28vUpUOazfzxFE7qQFFslpdV2JlLB3YLryhdrCI+2W
         rj2xxeL+490K36t601JwutnJTt14hNnl2BKV0pxTXAKuCb0Tc10Nl0XcN7/mhC3op9th
         fOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728299467; x=1728904267;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFDw9iu2e6StLFgnakN4cTW1F9f5/HVlphDerb/pfAU=;
        b=OmpSJHZrzwGcar2MBvfHOa0O70mW4IKihDUhkbrpaDNwSgiV1oBrAfeZ13NBV89ZYO
         5DS67lKiZnPzp4JEHEL8FuGXBRLquJddcaCMBpGtjV+WLGnePy5Vgi0+edWxodDBPgPS
         KAuDD3V5j8J1vHGdrByb4CCPr86qC0vcqqXI8WOmIyvYBpSa3QgNHwJuc3CXqzLFfuzW
         qiXmtuvdRpDahRKwIRCrR1Y7TNPjf35kufJv2Cpc7FfwOZrzter9yxE7oYcDJVGi7b8s
         ufRGVjDXpBHoldkBEF/36cko5XGy1nGj4fmNREWCBea3xaOB3Cgqjf0HyodiRoPFObFB
         Kg3g==
X-Gm-Message-State: AOJu0Yz3koHjkskPfRsaZ2hS/rbhOIsEUDNMjmcq5i4wexnBXWqfUyv4
	c9/K7hfY8VrqHS37TK/wkVaU2H3dkPY0nFwGfUzvuU54E1h/FH+K7+pSXA==
X-Google-Smtp-Source: AGHT+IG6eS+9em28OZG5qp5chYqplqjy1Nu/NFkd48LRWHq+MXt1/Bd+cFXQ0hXTkJ31IyCRHzrQ9Q==
X-Received: by 2002:a17:906:fd87:b0:a99:306c:cd75 with SMTP id a640c23a62f3a-a99306ccf9emr1068533366b.54.1728299467275;
        Mon, 07 Oct 2024 04:11:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9963760779sm3679866b.204.2024.10.07.04.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 04:11:06 -0700 (PDT)
Message-Id: <pull.1805.v6.git.git.1728299466.gitgitgadget@gmail.com>
In-Reply-To: <pull.1805.v5.git.git.1728298308.gitgitgadget@gmail.com>
References: <pull.1805.v5.git.git.1728298308.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 07 Oct 2024 11:11:04 +0000
Subject: [PATCH v6 0/2] [Outreachy][Patch v2] t3404: avoid losing exit status to pipes
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>

Changes since v5:

 * Remove spaces between redirect to conform with git style.

Usman Akinyemi (2):
  t3404: avoid losing exit status with focus on `git show` and `git
    cat-file`
  t3404: employing test_line_count() to replace test

 t/t3404-rebase-interactive.sh | 75 +++++++++++++++++++++++------------
 1 file changed, 50 insertions(+), 25 deletions(-)


base-commit: 90fe3800b92a49173530828c0a17951abd30f0e1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1805%2FUnique-Usman%2Favoid_git_pipes-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1805/Unique-Usman/avoid_git_pipes-v6
Pull-Request: https://github.com/git/git/pull/1805

Range-diff vs v5:

 1:  bfff7937cd2 = 1:  bfff7937cd2 t3404: avoid losing exit status with focus on `git show` and `git cat-file`
 2:  0ce40300fa3 ! 2:  b3d3deced25 t3404: employing test_line_count() to replace test
     @@ t/t3404-rebase-interactive.sh: test_expect_success 'stop on conflicting pick' '
       	test "$(git diff --name-status |
       		sed -n -e "/^U/s/^U[^a-z]*//p")" = file1 &&
      -	test 4 = $(grep -v "^#" < .git/rebase-merge/done | wc -l) &&
     -+	grep -v "^#" < .git/rebase-merge/done >actual &&
     +-	test 0 = $(grep -c "^[^#]" < .git/rebase-merge/git-rebase-todo)
     ++	grep -v "^#" <.git/rebase-merge/done >actual &&
      +	test_line_count = 4 actual &&
     - 	test 0 = $(grep -c "^[^#]" < .git/rebase-merge/git-rebase-todo)
     ++	test 0 = $(grep -c "^[^#]" <.git/rebase-merge/git-rebase-todo)
       '
       
     + test_expect_success 'show conflicted patch' '
      @@ t/t3404-rebase-interactive.sh: test_expect_success 'multi-squash only fires up editor once' '
       	) &&
       	test $base = $(git rev-parse HEAD^) &&

-- 
gitgitgadget

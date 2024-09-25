Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7CF15EFA0
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 12:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727267120; cv=none; b=Wszq4ijuP+FRpLGi/SkF4mEcx9dpV1I/kQvo7JgM7oy2jy+kWB1mh/eVXo0bqL34xENmTwxwUpkGNsXWKsAKpKyI4/04NyXKZ8h+HxQuNxCLGFKDKpbxIH9fzcKr1VxQYEqGH3DhzDHIJBuZJNzNie4GNFQyMDXyu3bA0LgA1FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727267120; c=relaxed/simple;
	bh=Z9z5Di9MD8eAwpdgRhMHoxELHVfXsjDpGmveAkbDaSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q2qH3XKm3ciCWRvWjRC2JtbTgphlF/lwc+9YN8Rv0XRV76kDDrnaxU5gMSJfMqA0V5l9BLd8n7cAPw2/xVnLrOK/wl/X2BCfXQoXPbeyjXNNzKW0oDrABMAUgU1e197yCV84mK6HdshiZ/j5/utfDhzN0w65hAD1Snw0tv9vdVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfWfP3Sd; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfWfP3Sd"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71957eb256bso5787190b3a.3
        for <git@vger.kernel.org>; Wed, 25 Sep 2024 05:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727267117; x=1727871917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UpHDd+iX/PoL6vw4gwqTcjtwFvunx5XxhOCNDO9stbc=;
        b=AfWfP3Sd3NFaVxwuFP2EEX1Sv1c9C1SPOJ4dF2cII6TEqSPC2BneFcrK2P4M30PVFD
         rJIIs6bWtps3p/OXDlg/1I3taubDVyo1C9NgdqyVfoA3/A1ormPsyQNZEjsNvMb9FZJ0
         acE6rkkpu3afQfsiZyISaiAOPthPphPKcquEGmFytJdKFZFG83AW7QqFv5B+B0NU2d4Z
         TTOQJFRkYI9G0M41iV/bJ15R8qpxJTViMX+Iq+DvFyuhX4aE2WTt9pflBO4jBMOlLgYn
         szBsvtQhbUVdNQqBjAFi9dchmjVc3qtAMFYprd9N0FpFoaw3TV/T+JJStHENWJPwsCMV
         abtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727267117; x=1727871917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UpHDd+iX/PoL6vw4gwqTcjtwFvunx5XxhOCNDO9stbc=;
        b=vbRXwAiP+5arxHog9++Yiry3WghHzq0bvCpPIaLI6GuJp5fOwDSbMh/WQUWgHgKOqX
         o0X2Y7134W8YfhgL/MOfnNTeplcGaQN6qhYys4R4N92YMDezZLMHVDZpEyRkT2HBprYx
         y502GPUfSzJRz/mlj8ld44zesxEajTZORzrdU4ducvUigm5iv/Ad8D87K30omzTLq/nt
         +0ZVILLWHSkFycj4S74QTeWiU1mXWlTmW9Ear5zeIiUVefbnl2U+GwF8QKeCtS8M8P3c
         Hk/XHm5mONKLB2tjDvsTLbFQczu1CsYaVZzvfr/x1+BOQTfEtFXqaiR/nT58UwB935bt
         Sy4w==
X-Gm-Message-State: AOJu0YyWOFtf5Fge2jy25ZZKrvAIKlSjr0DwyQS1KslQBctj2w1XeT/M
	ALmR+OiyunWLKAYOEUu2swOGAamSq652tiEmPsKYGvJtHJ2s+edG
X-Google-Smtp-Source: AGHT+IFaHSnhfSYj6fdwYdghLlFCBUl7s/+C/DKgef1+cxTLBWEEuyHXYbKQpLjOt0/iF71ER09mxQ==
X-Received: by 2002:a05:6a21:9214:b0:1d2:e8f6:81e with SMTP id adf61e73a8af0-1d4d4ac6358mr4021315637.24.1727267116945;
        Wed, 25 Sep 2024 05:25:16 -0700 (PDT)
Received: from thunderbird.smith.home (ip70-162-122-51.ph.ph.cox.net. [70.162.122.51])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc8345d5sm2778667b3a.15.2024.09.25.05.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 05:25:16 -0700 (PDT)
Received: from thunderbird.. (localhost [127.0.0.1])
	by thunderbird.smith.home (Postfix) with ESMTP id D93381960236;
	Wed, 25 Sep 2024 05:25:15 -0700 (MST)
From: "Stephen P. Smith" <ishchis2@gmail.com>
To: git@vger.kernel.org
Cc: ishchis2@gmail.com
Subject: Can a note be pushed to origin?
Date: Wed, 25 Sep 2024 05:25:15 -0700
Message-ID: <20240925122515.14015-1-ishchis2@gmail.com>
X-Mailer: git-send-email 2.46.0.540.g4c42d5ff28
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a project that I am working on, some metadata is currently embedded in some 
source files.  The question was asked yesterday if there is a way to move that 
metadata a git specific file and link it to the source file or commit.

I remembered that git has notes which can be used to add such data to a 
commit, but I don't believe that such metadata gets pushed to origin nor 
fetched from origin but another user.  

Is there a currently implemented way to do something like this?

Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04EA17C8B
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 23:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726789691; cv=none; b=I0rhRShdLwpnl86eS+n8faRkYypEv1+i9K261dd4fj7js8UuzcfA/8Kyg1qEG1Jy2fKrsXXRO0TDxHj8gTaAXoqHgySInNBqWmgeFI2K7q+hgp9SDMLISryajGLubbYMpcibBAgN51fC5Ehwb6XGKkov1t8neY9wcBTUHRfMtC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726789691; c=relaxed/simple;
	bh=8ZQMvj/6WFI0wiUR2E5G9ZSYuyFBN1dP+nry0FfCiHQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dFpYa5GcLaDwbPfQ+L3dCJm1FrXdNX2ZvadSHEr2JDjcji0/Ks1Up0L+hzUXaJ2f73g06zKmoUJC+bfIMCQmHhprNuti60eMF9w9bWtTxipw3ZV0O+M0iCUQT8jAVi2gkOz9jaRs86VRxfJqJSqh4isqNkHGVm04GJKqbXMMr34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qCZQKdjx; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qCZQKdjx"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e035949cc4eso2469081276.1
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 16:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726789688; x=1727394488; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j3sxWDxKwOATk5qt5CnOwYniFDXd8CadPDG9v6R2L/0=;
        b=qCZQKdjxfMCoSaRedLPmzvugISlyE6F/wuRmyLZVfo1pPZDHsfZgbOrTO3Juq4+FmX
         X2MT15G7iS3PeeIKPzfbMWgPz4ns7U03gGOl1gFAa9xDq8EDF02b25S9jl7tVYAgYot3
         cKm4JEHhHuUsnjg2Pbe+QKzEiOHZgXhgklCgOcWRBkI2lEehH5+RSsxksDfkKxocmSXM
         muMBlGOez/fP1GaYZbVjaMvEkB7PXZC1rDtvGOOUT2e74cbEwkU801LvyOQ4jVtT7Eby
         mawCP4F4/cN0HjP0IiIcg7XU123hiIlQtEMaoamb6bHmQ3FyF87BklmtG/fljjyFUGkX
         RLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726789688; x=1727394488;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j3sxWDxKwOATk5qt5CnOwYniFDXd8CadPDG9v6R2L/0=;
        b=ZY0aRWcScjVl7hR2CmesYjoSITnLRZi8biGURYQSt4fWB9QDUmyy4yaAw1zFRsWqtI
         xPk/pNT2lfGKhOW109Yo3OEXML9Rv7L3k4gcr+RBwANI+Fsv4ro7nND8HT4GIz/Ik19J
         uYqg0vn+1xHlWEV7HedfqJe20VV1TrJyOClBvgym/biMa3RsAcEdwpCjmum+8kwyEurP
         n+V3BHE8DZwUEOE82O03TniuAFBemFcQYuqDxHFa7SzCGxc/qBri1bUZS6Llfe58Iicf
         ygYty8lWULoPb2tmeF70q6DTKOOo7rqf9f267Fplb+U8uw8H07vy1Zl1WPPuMZtWRJeb
         1M6A==
X-Gm-Message-State: AOJu0YyTpN0XI5oaLPVFryE3ImX+lzk34kIQzxdtngFv80XEXlp+7uey
	pZMayUIfwQTyW0oDTwHvYnG27UIEuACdKx8pFeWhjPWZKCNYGxqD+KbiIUWFo5FQMhAEQJdFUsN
	XLKN/SqN2NHGNM2xq5yRnxSmFw+Sb8RL48Brdx+T0y+l7WpFDlnSDNvvFHscLoSrKaB5lgPdGzE
	/A6kjQ4bx7RhW1E8JqzZTZRSKLE/ld7e7DuaQg7bDvKum/
X-Google-Smtp-Source: AGHT+IFm6t1dVwStzYFKLFopsWRLDZguPS7HFkSDWHX1Oz/KacSSCcDHC7pQMFwzvChsRsIQJuVUL9i27ISNQbw=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a25:ec0c:0:b0:e1a:70ed:6ec9 with SMTP id
 3f1490d57ef6-e2252f1aae0mr9852276.2.1726789688436; Thu, 19 Sep 2024 16:48:08
 -0700 (PDT)
Date: Thu, 19 Sep 2024 23:47:39 +0000
In-Reply-To: <20240802073143.56731-1-hanyang.tony@bytedance.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240919234741.1317946-1-calvinwan@google.com>
Subject: [PATCH 0/2] revision: fix reachable commits being gc'ed in partial repo
From: Calvin Wan <calvinwan@google.com>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, hanyang.tony@bytedance.com, 
	jonathantanmy@google.com, sokcevic@google.com
Content-Type: text/plain; charset="UTF-8"

I took the first patch of Han Young's original series and implemented
the fix suggested by Jonathan[1]. While all of his ideas would've
worked, the first one ends up being the simplest to implement at the
cost of minor network resources but saves on CPU compared to the other
ideas. This series does not fix repositories that were previously broken
by this issue, but broken repositories can easily fix themselves by
refetching the missing commit, so there isn't much benefit adding
preventative measures to gc.

[1] https://lore.kernel.org/git/20240813004508.2768102-1-jonathantanmy@google.com/

Calvin Wan (1):
  fetch-pack.c: do not declare local commits as "have" in partial repos

Han Young (1):
  packfile: split promisor objects oidset into two

 fetch-pack.c             | 17 ++++++++++++++---
 packfile.c               | 24 +++++++++++++++---------
 packfile.h               |  7 ++++++-
 t/t5616-partial-clone.sh | 29 +++++++++++++++++++++++++++++
 4 files changed, 64 insertions(+), 13 deletions(-)

-- 
2.46.0.792.g87dc391469-goog


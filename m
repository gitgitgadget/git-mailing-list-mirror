Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6521D7E2B
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 19:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725391866; cv=none; b=qmiRE4LGwOKUB4F2JKkqGcC8ZEiYN1PsOQO+zfW9tTWkSMF/Dkeqd6tjjqjc7SCSbXko/QbLx3t7F0jfaau5532Au9TNyGHTe1M2V370zzhATN0/kjQX+XoKUp3nCmOawNc26U1MLjA3zahNWIsHb7hw/zi8mZE8LCRQSEWonTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725391866; c=relaxed/simple;
	bh=Oc79HYD+j43GKaRPtdKEnBQGcPA35OZQu14SAdfze1Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=V/Q/z5Y3mGa96+uymwSvRDlN6TLWSupjWNdlYzxIKZ0N4rrRSSJaPnmUJTYHWByZzUJ/vGtcWpPNOOetb3tRsVfCh+7dElNz1Oc5VlzOYSJq1yK/N7Ea3U7Ux5aQihMyTxOYQb9HxgEFZHHnTKC/m4VRn6Z1Qm91VVNnBpN+SwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxeZMnDs; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxeZMnDs"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42c2e50ec13so31524355e9.0
        for <git@vger.kernel.org>; Tue, 03 Sep 2024 12:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725391863; x=1725996663; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Oc79HYD+j43GKaRPtdKEnBQGcPA35OZQu14SAdfze1Q=;
        b=DxeZMnDs+bItJJx/ytyOF/KVWdyQjof38FtHXglUJrEe8i5XoT5gycpYLqafayDJqV
         pyNoVoGC0eDMetAPFi6WwqiGwLQBrLvy+N2ycuRW3qL5i1QVkIe3R619zhDb6nVcoBIN
         7pgE2Evtl2Oo3BPql1waFrXIqcy+xwM3h6bTwZaYhdO+uNIvSktkhMDb08h6owRAk1b6
         6UueoXexe+UnbA0eqMYJ5q/uq+RCfaPTUCzCFm76/KmFSJeJAfkoLHBdStH6eWyCw78T
         5JP9GowUvlWmzUsHxfusuGCYKRwwBUQuQDJVeQvSoRhYehVinhkFLvbVklQJ7kX/o9BF
         +PyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725391863; x=1725996663;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oc79HYD+j43GKaRPtdKEnBQGcPA35OZQu14SAdfze1Q=;
        b=fc6itXRwDxpU+Mzb2JnKFAe+iRLfipKIdJg7J7uKqfS4ivAffOz1FWswwtFICO5yCH
         pfjWkzOfdhj7a6Zu2T2Mu/QfkL7szX+T71/twKkPvQHfqWM6PMbI2MOwfsBHr+OlIHA1
         W2HQFDdfZDHOAn0zokaihKFAAJkfbF9B0GL0uJNxIS43grnFwUJb6oU7IZBklUJ57/BU
         CdQkX8K5C2V81Q5auM+u2HWxjA7on0cwENf/AlBeUgl8KZt6ArAImy2mBEIe8B78pBA4
         KnhOa1zwVX/0m9hYkqnXRc7ZyyeqVGD3iOoQjYl2+CTSwg8um5a54+jGJjGQPUFSr+vn
         07gQ==
X-Gm-Message-State: AOJu0Yy05so0xPV2TkOXkI+o/ZIddS+iXNMg6jgXJVkirqmSTTW184L/
	ef4TmqtpbkMSlI3gz2LvDXVT6tiGon9f4oNqcU/v6vGJKP3YLV5liqHHvE9jo1RoWpPmyS3fLyt
	lgITPW47SMbbRlN981mJlNTsTWUh4UdOQ
X-Google-Smtp-Source: AGHT+IFk6J/PIfZNnKy5AVHpEItzxA2AmgUyza06H6QNWsOLHFSVif1ULmb+Bb/OSLHg/YQnh2zOjiYxLCmST6vubt8=
X-Received: by 2002:a05:600c:1d1d:b0:426:5269:1a50 with SMTP id
 5b1f17b1804b1-42bbb205a6bmr104542645e9.11.1725391862581; Tue, 03 Sep 2024
 12:31:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: faust1002 <faust1002@gmail.com>
Date: Tue, 3 Sep 2024 20:30:51 +0100
Message-ID: <CALHxJxG+xdV4T3ZGMTMiHPzOt_Rm1yh9b=-v0RjJHJn0Z=jiZw@mail.gmail.com>
Subject: Adding a custom submit tool to git p4
To: git@vger.kernel.org, simon@lst.de
Content-Type: text/plain; charset="UTF-8"

Hello guys,
I hope you don't mind so direct approach.
I work in a company where P4 is used as version control system. As you
can probably guess, it is slow, heavy and works in only 50% of cases.
In the interest of my mental health, I'd like to use git. But again,
direct migration to git is not possible due to the company policy. So
I thought about using git p4 as a substitute. Of course it is not so
easy. Clone / rebase / sync work as expected, but there's a problem
with submit. My company uses its own utility to submit changes instead
of the regular p4 utility (again, the company policy). The issue here
is that git-p4.py has hardcoded "p4" as part of p4_build_cmd function
and there is no way of changing it.
I can prepare a patch to change it (I know that dedicating some of my
free time to something my company will clearly benefit from is a dumb
idea, but I'm kind of desperate here) but before I do anything I have
two questions
1) Will such patch be accepted in the first place? This is quite odd
idea and I wouldn't be surprised if you don't want to agree on it.
2) If the answer is yes, do you have any recommendation regarding the
potential implementation?
Kind regards

Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CB829A5
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 04:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736138449; cv=none; b=tRnlm7cMDbkwhOBRbcc+9aXfBY6HPuG8OrzO7Yrr82CTGZJ9W21eITtVnC4fH+jFH2Zk1M0fMeVWOYTS1IfFrnqszZyGc9n/acSWkcCoKzldOO5VIQyWlWOZIODBRKsUtfw9mq2MHcy+8LaOXP5iKr0ULt4+gbEogcZufnWhKSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736138449; c=relaxed/simple;
	bh=4bZMFflbgegczbfWQwJE05pAQIu9s19WACn3pVPkPZ4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=YlQVZhEGiEI/JKF96PtLCc3x/wpN2aFHepiwxyiTNoJ3KfpjRaZ3MeMNFDnMt3D8YlcpQf9ApVorJN6ApghNlnw0vZAaeGPCqP2lDcVLowkSbK8MCWeOIDywNYq62swG0hZFcwveySZTgyfx2mtmpKaxhx4XDVP2n8qZAXxVh+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJ4QB33Y; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJ4QB33Y"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e39f43344c5so18025387276.1
        for <git@vger.kernel.org>; Sun, 05 Jan 2025 20:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736138447; x=1736743247; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wWc1GJkrsOG81ljkk8xRR8Gx2ovANHnPeckUjMsv0Rw=;
        b=mJ4QB33YwM+ECVQQzvxmgS1P9GOjC1gZ9TkKozkkVsQqRXQHEM5X8ndJ9VhbB2QP7v
         vuYj4KBKE7oWvI/vPhOUtLEYGzKloqEZM67XZ/7n+vYh+wJKzUPiVhm6PNd21SLW2jsP
         fsGg/vfbNDRJJcjIVYEySXOrIdx3614sPnzKUAGhHnp4M+94ZQe+AeBfLJn4XOxfKVi0
         sECUeQsqvvyYTGzv25WLWeL445IpxdFUABm3EUNkO1RH2VHSgwvz4Vw4POeFbKt+C1vN
         pTm0lW++L76ZGixsTVlIJJ5wBCu6FLX28+IcT+c8mGsrWAzWGmisADAjp2+j76nXfVHt
         L/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736138447; x=1736743247;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wWc1GJkrsOG81ljkk8xRR8Gx2ovANHnPeckUjMsv0Rw=;
        b=o051Oa2fsJZtj/73q60KNuy3dVX4Z5WVb2YRbVrojzV2YAiwZw/lcpfG0RNpLZ0XXw
         57dnAyb00nsnhdrkQmu/FquEG7oDe4JowmT6SFdzt7KY4Oa/NMamEBagXz9/VWEPxnZt
         AX20Z6c9M7w/BW7/7tT8Tfor0wy6i4UUJBS2C5D7gkjWPkJPWSrRb6HW8Oi9P1wEaIOp
         6tGGPrFxlbFvYgnuHNoZFwcWwa1ZZ7DFbq2wSykiXbVBAHXwhML1vR/K8xjelfaVtDqt
         RzQLwYRwhucSTxXX+ZtESDaJx8DRaP+yzyzxKHYzxAsepvq7BzGeUkk2FqJPyQHyehzj
         IDvw==
X-Gm-Message-State: AOJu0Ywq52ibyjteHfMyNFq+yZHjWepgwKY0mO99R0hnavBoEpRW459N
	sJtDJXOOjuw7Wr4yTr0VfN5MunGwf3W1wLtdfXhLLxZYhzH11j+wkTKM9y23EQBoOEDP1dTEr38
	4kQkNlqNlnJy4XLlQKvcxxsxPih/b/mt7
X-Gm-Gg: ASbGnctnZES+PAfoTTfCFkE3egsjjzckVZeP0Biy2XuVh/4grgaaP4cd+KVtf6tyqQG
	WbBIc0C9cSsU3KhwcpGj1pUkWXtbSndKvfbZk
X-Google-Smtp-Source: AGHT+IHGjBU+SwRpowO3jXEV02o/Tno91V1nD2nwPVlGgHfq/YZkTSelii80gSdVS/vGha2ZWeVze5XIVGYt5wO4iNI=
X-Received: by 2002:a05:690c:9985:b0:6ef:90a7:16ec with SMTP id
 00721157ae682-6f3f8201285mr441019187b3.28.1736138446752; Sun, 05 Jan 2025
 20:40:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chris Packham <judge.packham@gmail.com>
Date: Mon, 6 Jan 2025 17:40:36 +1300
X-Gm-Features: AbW1kvZqg-EQlQVRnhnY_V_K3gefoVHuR1PjslFDTsvg9kno4Eh_wP013REBqtA
Message-ID: <CAFOYHZDQs-mftqLQn5HiFgBWcFN6Z-WDscJt=zVLRyGTo36=HQ@mail.gmail.com>
Subject: Testing for existence of a remote branch from a script
To: GIT <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I look after some scripts we use at $dayjob for pushing changes though
our review system.

For some of our repositories we operate a triangular workflow where
changes are fetched from one branch (e.g. 'foo') but are pushed to a
different one ('foo_incoming'). Our CI system runs to test the changes
and when they pass 'foo_incoming' is merged (fast-forward most of the
time) into 'foo'.

The problem I have is not all our projects use this workflow so I've
tried to automate the detection of this. My script does something like

  br=$(git rev-parse --symbolic-full-name
refs/remotes/origin/foo_incoming -- 2>/dev/null || echo
refs/remotes/origin/foo)

The '--' is necessary because if foo_incoming doesn't exist then there
is extra output on stdout that puts off users. But when foo_incoming
does exist then br gets set to `refs/remotes/origin/foo_incoming\n--`.

Is there a better way of checking for the existence of a remote branch?

Thanks,
Chris

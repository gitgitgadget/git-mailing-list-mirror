Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AA3167D80
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726513254; cv=none; b=Tv0oaxsfyjI5OEd0ltwv6KXoJuUEZoY7FDz7XBob3wG3iN7zjasHcqAxPnvFqZCXXiRAatSPWrskAyHafWcr/Q5MiKLrwNIMxh0opy+4Ym0pCqWtfXQ+D09FrHxvbz5aZOJFtnwQJ56gLND4UTE8FyVY52s91MPxPhH2Y5pyS3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726513254; c=relaxed/simple;
	bh=YMEpLtL8B0yLSCim1yCHhITRS3wB0+khy/PfVsrzVY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=kpSr3qa9tAg98YrCKb9LGb/UfXTa4oHk3WrS8vU+qHTsvKJ6V1A21EuhFuSFJ6QCMsvYeTvVsgG5qHodzAoz/FzaCEemgzs5Z9Hz+j8yaDmNOS1QXTjg/5RHbeuq0zhH5a+Jz6B8oFgELsHip2JwKXSQ2730y+Tu+XU6U6T/4Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSj+1AxI; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSj+1AxI"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6d9f65f9e3eso28348647b3.3
        for <git@vger.kernel.org>; Mon, 16 Sep 2024 12:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726513228; x=1727118028; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YMEpLtL8B0yLSCim1yCHhITRS3wB0+khy/PfVsrzVY8=;
        b=PSj+1AxI/1FBsMTwddlLvGQrKgqklwoS700y6YAnJlUbqc0zbHR+6T039jpYNQkOxx
         xqAxRVeKvleV3SKDpm+SdLnlOC8Ch4ZaNhRdbgjR9N1YHrE3NVuY+0aabgM6tgyppv+o
         GolE7g6OBXANbtc3BIgfu/7KXy9fIlQtkzcm5hby04kS8nUwUJpNU2MR8gSPNkg7jLDK
         uBXngLc3OgLEiA9L673RCCmD+iGiGYE+JyCGw/kGFUZymQTHNcVy14puKwAg0bxIAyfx
         3uyYPWkwYMYh6X79TIMUcr7MrZtLGpKztscXKI3v1C7cveNOD6AxF4GPfw39L5YdkJjJ
         LAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726513228; x=1727118028;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YMEpLtL8B0yLSCim1yCHhITRS3wB0+khy/PfVsrzVY8=;
        b=CvQlg3WHI5rRSKeUttzbl4PDCGcOLtVMvSEGClvSuoHrkqPqyYfBGMWhAixKnK/zJ7
         JNn3WG5WLoKFAK/mYyiH/FVxSDiHZzLA4Fx/Wk7FDM/riSqDC8tv6uESVnzuczvmSBjk
         TCcYjPp2sq7RhAZIo/82V8SsRMO3SksBzQnVb+jD+a/vDWlfO6T5rVKSOofCxPyC/D5R
         tLRm8pCIQUzRiy0Ucm+Mw/MXPEJuZrVarUszI8auAFvkNYOZ1dNQPcWPjtoFrVwd6s58
         jaVQWHk1Cuz5iPhbaISbhLTzmizIGFiyfvCaen8fKZOqZoOiIEW02MhmG4XVNyFRjWvw
         6x7Q==
X-Gm-Message-State: AOJu0YwZu++jhilcRHJDLC1PjzDiqlNuD1CdQW4jnG3No0kJhLSoZ+FV
	ALm7iJuTUp6kxwsjULNcBea4OH/Flm/6egfk+JULGSPxn2q2Vr7HTTpOdypX8LFEFtgO8zR9MaO
	6hk3xeJC0THSU6I8mR3I+dcoxQRv33vVJpq10pQ==
X-Google-Smtp-Source: AGHT+IECGl38K/doV2VlWg5RbGEP187cSNdFlsoxD4Sa7+I4q7PJM3SACxK6Q7GA2y7r3TngeRysHI/k2gMWab4JjVo=
X-Received: by 2002:a05:690c:700f:b0:6ad:f6ae:7685 with SMTP id
 00721157ae682-6dbcc4bede6mr102404217b3.20.1726513228409; Mon, 16 Sep 2024
 12:00:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHmn3WWZ+vHT33z5_bQ07yTM0apY5gLDtErk_2fuLeGw509JPw@mail.gmail.com>
In-Reply-To: <CAHmn3WWZ+vHT33z5_bQ07yTM0apY5gLDtErk_2fuLeGw509JPw@mail.gmail.com>
From: Git Mailing <gitmailing3@gmail.com>
Date: Mon, 16 Sep 2024 21:00:17 +0200
Message-ID: <CAHmn3WVakAs4XPtmvBYB4inKah0WPYACaXJGScerbVMTi4D4eA@mail.gmail.com>
Subject: Re: get file watcher is keeping lock on files for a long time
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I'm not able to delete a folder minutes after the last git operation
as the git process keeps running in the background and won't stop.

How can I have git stop after, say, 30 secs. of non-operation?

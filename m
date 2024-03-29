Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D613CF7D
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 07:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711698077; cv=none; b=upI9poDhD3kfFbqJKD5uw6TBfpx7fagNDOZE4Mlh0+bB4lvCz6oOl0LvxZpVENEke6hHxFnA9vVHyvqoBo5gD9n65OemIi6iVzTOVoQ8mwgZ3+r7xBHn5YwVHSRXBhy6AsvRDv+6t8rF6X9aphgZVdnbH1UCweCAaKerd6/cQ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711698077; c=relaxed/simple;
	bh=+2/zXGKmRB3BZDLfD/yJVeTed/YB/B1dwCvV/ot/5Z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VtYBu+3LAnJFqjdpGug5yTj5XM5VL+ghwZ6Xiac/2jzlOaYAE25tHdz/3bFExdbMJMfhvBsRsNHQjo53Vyy12+FTFg8+Qsnv3P77aH/w16rKygMObYds6WUXHZy2JkDPxNe9sFt9JBpg0XlehaYo2YzHgfZq9gzcVEc/iOjQ23c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJqvvvfL; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJqvvvfL"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-69625f89aa2so13591246d6.3
        for <git@vger.kernel.org>; Fri, 29 Mar 2024 00:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711698075; x=1712302875; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XtkMn5YY+VYtCup3RAY31K+z1wXZWzza7U5epi87hO4=;
        b=LJqvvvfLc03HJvQ10IDVaHdWVAojRxTNLuvhTzNNnpQiYiU58sddn3Z46Xx10PWA8p
         NJ522OnlpHKK8ZiKmP+QICvtFv1bdr8Y5zY0rLb1bxf4Tqf/fZUKZQ9htoi8XlTRUQUP
         C4iGrO9GJgjJxMtjeieOTlvACLuuBfGHq4HKfuJGZ0ool6OT46djAJxXFiiYXP4gIxCt
         s69kZSyx/FqA1o41rytr0yg/zNrDef8JgOHsqEbG7zrBCro/b9aB1A8HK3NJtFf457FW
         Ycv6mAWMNHX3a8cUqK17MnG04KqtBvvPrUjucDTUXpmprtdnXErhH0vv+4GvDnhLYM+H
         huxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711698075; x=1712302875;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XtkMn5YY+VYtCup3RAY31K+z1wXZWzza7U5epi87hO4=;
        b=wf2t0583F9xN286qW5Ju+7Z92Ze3aDcQNGB/c4h5d2lf84xjHPUL5ILAZFrvr2yp1r
         4WJ5ijOQNHet6Ezc5lQMr9HX+f/1ZdKBQc18JrMGgWOVRc02ma6e6+tOTMxGHW/+gugA
         0uVzml26X+eHL5go/hA7vG7kcpa85nWm+Rss9fJ8yxhOf89rAPR1yUmM75qctVQgQfDr
         PyOotjAonbo71QblCJ9XjIxRClERj22Fe/ReEXxdic1yFP5rFSVijBB7CKnZ6dgL+hRf
         w0Mzeve/5EFqon72s0Nu5UkgRvsiBYJmhQzCjznpesM80GqtGklK2EtVHe3BV4ry1W6u
         L1sQ==
X-Gm-Message-State: AOJu0YzlUcPlFnUe4ZKnl+bULhP9nvqdoDBqF8AmOYBjTiHw1SVSy/q1
	6oINuM6T5z0neWBzmuQOdsARx4h2FNgT7WB94+vROrl3dmbvFl6X4+7jW+1q0hueQs+lBkPi/FD
	yFhpzKggP/wLUgmUs9iaJH3Ah4gY=
X-Google-Smtp-Source: AGHT+IFEeAvSL1QlocCsXhWdD/RK6+laQ04MDsLxLuU5iNavH5A/yZEK7FWCcvbmqOKRTVYJlNR/ftyncyaOB03WLWM=
X-Received: by 2002:a05:6214:192:b0:690:afaf:215f with SMTP id
 q18-20020a056214019200b00690afaf215fmr1645484qvr.55.1711698074688; Fri, 29
 Mar 2024 00:41:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK_130T8sZUZAuvj4x7sB278kVL7ARaBv3Pg2djQB45O+7xKTg@mail.gmail.com>
 <xmqqo7aywfc5.fsf@gitster.g> <CAK_130RadXce-_PwnZTzJ6qmr3m=OXd2M9bCj2gggM49RxL9=g@mail.gmail.com>
 <xmqq5xx6uume.fsf@gitster.g>
In-Reply-To: <xmqq5xx6uume.fsf@gitster.g>
From: zhang kai <kylerzhang11@gmail.com>
Date: Fri, 29 Mar 2024 15:41:03 +0800
Message-ID: <CAK_130R-AM6ZKJe52hc_XaLwi++VKm_bW5Ar8m8Yo7JLUnt9Yw@mail.gmail.com>
Subject: Re: Update message_advice_pull_before_push to mention how to push
 after rebasing
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> True, but isn't that a slipperly slope to cram more and more of the
> material from the manual into the "hint" that is supposed to be
> short, helpful and not so obnoxious?  Perhaps removing "pull again
> before you push", and saying "updates were rejected because X; see
> the note about fast-forwards in the manual" and nothing else would
> be an improvement?

I agree. Removing "pull again before you push" is definitely an
improvement for our workflow. But I know some teams don't use rebase
at all, so it may not be ideal for them.

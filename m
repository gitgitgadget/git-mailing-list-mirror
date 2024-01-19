Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9765C383
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 00:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705623663; cv=none; b=MO5SYPb11kD9gUvrx5Yw3sqJpP8aUGnPEnOZrN1HOh+O2YpM+sUWyitD3j+NL9yK+0ZyvA6b8SinHoxU+Jpc3shIGkMH3f5wU2e8mSLmyLbUR3JgMouL1bvD6mwman5UGw8RPwywy2T0qDwpBIIfIOp0gCRwUkzyy8YYYbJkk/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705623663; c=relaxed/simple;
	bh=JvQ6js2wRixtVcthUqmM8XjUO6RDWMdhBGBmreYpq2w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fj1/VAzdKYFMk70foYegCXWJHsqaRBccYNxPMP+3+0TveHzW7dL44ZabNMWlSwN5DCtvXvXhMFzzKXs4FuKl4MEI4FsHdeXR6XlAJ4vb/M4hEcB3d1LJxYkSkap24RQembRaZsNHHS9b99Dty3IOYi7PG8IDSAMz+pTQ+YO9uFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YMPDsQnt; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YMPDsQnt"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-28bbe965866so272719a91.3
        for <git@vger.kernel.org>; Thu, 18 Jan 2024 16:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705623662; x=1706228462; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JvQ6js2wRixtVcthUqmM8XjUO6RDWMdhBGBmreYpq2w=;
        b=YMPDsQnt9qZ1t9yCKiI/I7LBx7oAvKl0qOyF/BSq3SRZa7rD8QTQbSAIpDjVije/LD
         2/QMp3qampXtMgyV71QhSeplC9WxufG04NsX2RmoyZR1q+mSb+UEAI2tR1+iViBNhe4c
         i21pp3B7OM7BDPXhbiusnXUohlZlq0RrZd6r81y3WdBCRUNkjVEFprazBeF+CDd/qOZa
         VAU9SEToAweqKqID7ugtyUAf8X2sQUIGy7OmJy58LCPC7ib+cKas0kdzEEtOAB9wLePs
         7JcjQoQa/Qn9SFjIaSt7e2D8PL3qidi1TWussWA04hgzkBPQxu+w7CgHRYNEXpzb5177
         FDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705623662; x=1706228462;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JvQ6js2wRixtVcthUqmM8XjUO6RDWMdhBGBmreYpq2w=;
        b=GPiI5qCVRI9CG0J/po/lXV5MNCb3+YCWlQS5Jl+SqHxKbY8h+4tWGxZCWWXE+S2ZXS
         zRR+bATZI1UGL6RCkcE6TgvqCgF5nF2cfvKD4tNtGCiV11PmytwjycKfq1dgAHBXUXld
         dtQWOBmq+6racInzOl6I0t3i5gJnKQNuBR/FO9HLhjy55EDK6+VNGtsC9Z1hKjsldll8
         B7RLtzc1Jq2FXEZZkZJ02UHX45oYCMqmp4GFulq8Fgnle9N/ITruCUw9CCP1MTtzIMnl
         IJkM9dNe8NDZV2/0xxadRd+BrQ0Zqxwxn7jRSaL1tyku8EtX8yzVEvn9wuPMyRC+xVBT
         jLXw==
X-Gm-Message-State: AOJu0YyoQ1MNM6Sh96Q6cYnfO5niZE3rwxaAaidstWLFxFcqhjbNVXWQ
	ktkXQiCzoUtA1s38+jlxCJ8W7T5akKItYe6Nr0V9+sJPNJ2SCFEejQXPYFKLm+DQ2wpYicno1KN
	xpw==
X-Google-Smtp-Source: AGHT+IG8iz69Qak6Mx0ovCNAC+U8MQldJRsOlyIYrdFwpnlYFq2TZMeSX/Xcbh3m5q2T6eFw8Yfhr1Im1fg=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:90b:610:b0:28d:b9aa:eec4 with SMTP id
 gb16-20020a17090b061000b0028db9aaeec4mr16710pjb.0.1705623661923; Thu, 18 Jan
 2024 16:21:01 -0800 (PST)
Date: Thu, 18 Jan 2024 16:21:00 -0800
In-Reply-To: <xmqqle8mp9bx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
 <2dc3279b37f3aa81ba20e3dd08b029ca655ac3d8.1704869487.git.gitgitgadget@gmail.com>
 <xmqqle8mp9bx.fsf@gitster.g>
Message-ID: <owlysf2ugolv.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 01/10] trailer: move process_trailers() to interpret-trailers.c
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> I am assuming (and did not verify more than seeing the "git show"
> output with "--color-moved") that other changes in this step are all
> pure moves?

Yup.

Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89164298CD5
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753889217; cv=none; b=hoR+ZIY0PX4eMuYLajFaGVjJ/XC7KaIuGCQHivP6qsEFRUfYrstB+RRQ8h7QFAC5C6pvtrJ+2OoaGWuH/FhW98WVqp5efrzPyVgsmT5CeZmuYE9lDAz3dc4kQNVt7jk8+CMSzABQmJUP8PgdkS2eOMWa954EuFXZOK9VPfX6eYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753889217; c=relaxed/simple;
	bh=YCokL9nmPdXW79Yd1wW4MOLe4eS3vb8tuUH/G19665M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=X/vpwTU11v29sQItL3u0bhY/fQ1BPCSPKkavkFhc6/FXZLRhCYLvdl60a8y3sE5nu441TkL8JUWpySPnJRobcPXv0QgTlnWGKjKrvGNqvhqcMT6FFwhlWelLgelYNhRSKaWDm9eo1dV1GsoFVJq98QPkolZI/fCXJ2KyC4/6lOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBQddw6L; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBQddw6L"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76a3374b143so2279925b3a.0
        for <git@vger.kernel.org>; Wed, 30 Jul 2025 08:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753889216; x=1754494016; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCokL9nmPdXW79Yd1wW4MOLe4eS3vb8tuUH/G19665M=;
        b=BBQddw6LCeHcciqkss35qmaK96YqkYjlrrhK5P808H6AvWY+CT4CpKw5JX0FIFTYHh
         k4wxa6srBfgqUjeeA+TdPfq1vLQ7OFgw4G/mMWgBw7XmTrDhV/lm4a2mr/3b/4zvFslr
         3Koosr2vlBLkSX0v/c05/53A/6pK8UoBRY9U8BA7fUWc7nu/N7D51GbCDIm/OCYBm9D6
         5fg83rfZ6Nh8SyvXQ2pV+ThYmMQRdyiJ2Rd1BACX6VOxeYoYBZL347n2xjiyqYz+Ouvw
         OgieNI9jLjNW99S721RczVb2ujeH0EhMJJYLSW6FbbNCV5T1BLqz1OcDSLtHWkhoBeYb
         04xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753889216; x=1754494016;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCokL9nmPdXW79Yd1wW4MOLe4eS3vb8tuUH/G19665M=;
        b=A54EuseGXRjjB0RvOXQSY+wNe6MrctaD05acVEBVZCO2++YdUfQ81MRxiLRvPDUmmn
         LIJlTbKyVzn3TakLLiJIbZ5o6novDNLD70jmNyN4WNaRMSwOw8XfEagLNTLBaSZc5db0
         sCqMOFeCgOhHfHcY85TiTOFb7mVTiGVSzPy0QHLO4dyWgW6T7/XUX6Qo4/FxdzG4iDKr
         kAsO0IMDVFIjZpk7ssqAdGa18TZWVXwfOOSt29Ru8x6UOUboe3lDNZIA1M2/iqlpkEg+
         yULF+kyYcg8xsytp0vZYHKKDdkZgoSc1DCkCpZ3MUQqwdHUoL7unebaSxDzGA+rhKD1L
         XVrg==
X-Gm-Message-State: AOJu0YxAUUielPeO7L3bWC6nVLvOHQOXd3i3M9QpewTNQAfL0ADH9l2a
	HNlW/ruhD3CvTGdS7AfB0yzC/iiJ+KJj0s8CuGaz1yXEjw2Przy6qQn6
X-Gm-Gg: ASbGncuU/8EIKyIUZvU1JzC/UXOzQ39gGnVni1ilnNCiF2gKDmjRrbcrM/Lt/n/J8af
	7F6MnQeH8vIHSORVDEKAMo/guHoYqdU1PaDdvsF/FeF4YqmbYQWNvXzjhO58g4OPtTf6jlt/q6X
	kvbpT9YNqEby+1fN9CyEfHmG+g4L4q+sHVqz1ZP1Q6e78/im8BGqLGJYmSroanyrDV/ktY8yawN
	ioKB7Z35DyOjehBXnB7RHs1BI16O4Ky5LLLYVv91ZnLz+5nhsll0Nj0k/20WdcGykFdpFCP/HvB
	4cC9y0SAZy74/N0sF2bJxZs2YuOp89Tu3NB5OSakGg28L+L36cCu61TdwFFpvjrxjHkOJGWn4fa
	OJ8wAcjiEaOl9XICSpyISa3UUUWN60ucsnYNbqoOOzGbQQHYJ1yB6mNL1i4OcZMd6zmE=
X-Google-Smtp-Source: AGHT+IEGC7R0Yur1Txh8CxD415iDCLZaNTbpnolkXdmmzHwEOb/06YXPprWuwuvrTb7chkO1zy3RNw==
X-Received: by 2002:a05:6a20:3d0b:b0:23d:9dd0:b2e5 with SMTP id adf61e73a8af0-23dc0ef4952mr6288408637.41.1753889215665;
        Wed, 30 Jul 2025 08:26:55 -0700 (PDT)
Received: from smtpclient.apple (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76408eed6a5sm11010376b3a.58.2025.07.30.08.26.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jul 2025 08:26:55 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [GSoC PATCH v5 0/5] repo: add new command for retrieving
 repository info
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CAPig+cSBj+kSmzKUarNPQt4qk5p9vjHFGFrJVYmT6TrWHACcEg@mail.gmail.com>
Date: Wed, 30 Jul 2025 12:26:39 -0300
Cc: git@vger.kernel.org,
 oswald.buddenhagen@gmx.de,
 ps@pks.im,
 karthik.188@gmail.com,
 ben.knoble@gmail.com,
 gitster@pobox.com,
 phillip.wood@dunelm.org.uk,
 jltobler@gmail.com,
 jn.avila@free.fr
Content-Transfer-Encoding: 7bit
Message-Id: <32163DDA-2DA6-45D0-A877-D305F251FF12@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250727175110.84770-1-lucasseikioshiro@gmail.com>
 <CAPig+cSBj+kSmzKUarNPQt4qk5p9vjHFGFrJVYmT6TrWHACcEg@mail.gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

First of all: thank you for joining this discussion, Eric!

> For this reason, I'm of the opinion that `quote_c_style` should be
> used and documented even at this very early stage.

Ok, so we have three reviews in favor of using `quote_c_style`. I'll
use it in v7.


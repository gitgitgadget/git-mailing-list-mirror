Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBD81AF0C9
	for <git@vger.kernel.org>; Tue, 13 May 2025 15:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747148747; cv=none; b=WQ6hfQ+QHh+uMLACiv+sBlsAEg0o92lso1IHX+RusTLvRHaAEGePYrvfRFCOhWoG9M/cO20xHJTvVot2Fk3JwnvQMLChE7JCMN8kPn9k91XB3Nq0WlPY17VO3N/EKygawd9TqMNQ3AHW4avXW9gjUsk9FH+7WiuO9xj6KpakpIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747148747; c=relaxed/simple;
	bh=PHkAeOVDPZrqOzHZBWWIMls6KGhR4wPx5ozlIF/Hxcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8eqBiiztJoZrELnTQgOrDU6MMkaIM/WEIoMKJXCHzWXgexrQFKY2H/+7xMVFrmDZ2rDIX8/5EA7SR7eFlvAR0PT5iHfS7Lf5GwDm4UUjZJ8xpYQ9izgWWki78V1GZjLHubmmiT1QW16CeD5N3SH3qwMC8UCRGR4CKj4gv16zZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhrvtqkH; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhrvtqkH"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54afb5fcebaso7433043e87.3
        for <git@vger.kernel.org>; Tue, 13 May 2025 08:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747148744; x=1747753544; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PHkAeOVDPZrqOzHZBWWIMls6KGhR4wPx5ozlIF/Hxcc=;
        b=hhrvtqkHhPT45ccs0GpNDP6256/r/2t6L+Cvp9hg3NgfUPLjVlpefjG46mWRft3irA
         gQDDjjyicF1uUTmYoZUSYRLw57dLvaB6GRdJLuc7jP2tgQRw5/J8/5rNE5ynqUYoWqX1
         dwf7Pn9fKW9SakmOKceZnJfDMSfdc/qqY0i3jRqbRAkE6gXx9deuFttoNYHGF47HzHb7
         jceW3p4nn6I31Zux7qUJvxu7zlWfYMa3FWPou1kZcMlVMWeXMAex7D+nKudZqhhyvKuM
         ms7zZch5j+FqglfeJ6qX3oUZucgx0ssCJme90SXk69UfPK+kF3HXBHWmSAO8Mes/8r/j
         yQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747148744; x=1747753544;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PHkAeOVDPZrqOzHZBWWIMls6KGhR4wPx5ozlIF/Hxcc=;
        b=MBnMTnvsjzNbBpNjXw+F5xJG9ElGc0EN5pNMeGSF62SqBKm1zxN7w/COhqg08frwxA
         ZpMKRWqXhg7g3kjrjSfhil8fFEhx3LgtywIqTg6bmMDa1wymMW8ONuryAlrry52OqqGD
         FRqlaIxSrwKAO/9pciiLXqi+Bwjhrb8xaLZKaELqJ1/X2qqxlMw0x/uvCnYXps0Ny6xo
         s1GkRJdPf2b2JORaEeHWlsdSJYOpRo0pf9wN0ix3mVEp4ftASNp+Gxd7Tw5IbRR142zj
         WUsXhNjJbHSydAgOCj/lUTQfk4LjO6ve+OdkEENStVAo5k88LdhG9gJOGA/BR3zyyTqm
         amag==
X-Forwarded-Encrypted: i=1; AJvYcCXurCSRAop0FRynFq+SEBdWwTGJT4MipbDVku9eK38X/U9Z7r7M4IaOfZXqkN0uVhKPRsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4nGjjj+6WKOyqpnJrDRgXWAysVtfbPnYQpSXJpqwR3EUSkci7
	kmPZSScDWVgNaeQgP+bXFlNNQvRDnlMpy96+A8a1UCXvROyIj7nBaI9A3APvpi+g4EaeGOSEGnK
	qHCjOq9PDfoBHYBsPkxnoTaEhI/0=
X-Gm-Gg: ASbGncu/gBkgNm3sCi0XV7oWMha6su8JqkQeyc7warg3MA/8sGY34XyfYfOXHR6fOOr
	h9tFkJSIG3hP6G3uaxHXhtxHtCiE9L8W4ffQYi3fGc5Z6w9vVxqd9GefBalITIAd7zuQ5qUN6Qi
	w5ehAbFS09cG7kGux9ZRZqDSIC1djzKgVrrns8FhxkFDQs0qDvfwBnKnrAmV0V6rU=
X-Google-Smtp-Source: AGHT+IEBzbWFDI6U6ZAGpWd9rmo0Y3NuTj3cEYn3HFily6jmwvLX3j/FdL04RPPmH1y49oLA5NX1IfcH4EC3DR3hG+8=
X-Received: by 2002:a05:6512:631a:b0:545:2300:9256 with SMTP id
 2adb3069b0e04-54fc67acecbmr6577841e87.12.1747148743567; Tue, 13 May 2025
 08:05:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
 <pull.1915.v2.git.1746884789.gitgitgadget@gmail.com> <973dfadd1b3c7e214b14c75494b3b3b786227362.1746884789.git.gitgitgadget@gmail.com>
 <431d6fec-3955-4703-8bb3-376eae7ff052@gmail.com> <0862a881-2e0a-4051-949f-3d0b94408fd5@gmail.com>
In-Reply-To: <0862a881-2e0a-4051-949f-3d0b94408fd5@gmail.com>
From: Leon Michalak <leonmichalak6@gmail.com>
Date: Tue, 13 May 2025 16:05:32 +0100
X-Gm-Features: AX0GCFuPD54OsqRJbs9W4gzVJ8rzWGUJKs87_DYZyunbfP72D4_X8QrwMaDz7Bs
Message-ID: <CAP9jKjEbfbRijEowYjkbeQxKC1GqLCoM=hCjhXSgsrvgVAkO0w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] add-patch: add diff.context command line overrides
To: phillip.wood@dunelm.org.uk
Cc: Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hey, thanks for the thorough review Philip. I will properly digest
this when I get some free time, but I just wanted to say (I probably
should have mentioned this so my bad) that the reason I didn't change
to test just the singular command (yet, anyway) is that someone else
thought this was a good idea testing all of them, so I wasn't sure
whether to touch it or not in the end, and thought I'd just submit
this v2 and gather more opinions. Was this perhaps the wrong approach
though?

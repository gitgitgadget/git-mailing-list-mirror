Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE60D18646
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 15:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751132; cv=none; b=Uz/9RFQcTGA50GUJzBZQxEGout0LgczmPBOEi9beNsIUnuRavqx4TgfrU6dDembr4y6IAaci2ZAHkad4HYxzQjYXL+19CJEn2vuHlROlp3UoQoS1DE43QPc3UyUvwliTUikYJMkePLkI7YTIdIGBpBVl4Bp9aSWcxzrHKgx8f8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751132; c=relaxed/simple;
	bh=pF946CpJ/XUzSX48FA6SkNB38WdYQChRpLEw+WyZWjo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=pJPN6i63I+nHY6OaYs3nwwvZGz+aoPrGlkeZAanPuzh6BYEKyxfdz4oixZEF3b5yt5aVZWz2f9Lv572dOxMh7fePH76I5oosCQvNHzNYZzUHb+s8J6tjKx0zH45JPT/O+0ONPVl3LUXq1523khjdEGsK8i2PmbcYc80XNhqg0Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmyBdLW0; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmyBdLW0"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e2e452c852so686576a34.3
        for <git@vger.kernel.org>; Mon, 12 Feb 2024 07:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707751130; x=1708355930; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pF946CpJ/XUzSX48FA6SkNB38WdYQChRpLEw+WyZWjo=;
        b=HmyBdLW0WquEyPgVo51ji6e+PRQ3jn/qCO2yaQxaQIgP7TQ5lnfeaj9xtF/bZMWEvP
         n8pMhS7w+UavuHK0JPMHnE7q3qJ88S2cqLaVX+C+6Qwvm+CktE0txfANscM/fo4KyeWo
         F2DRTMGXjgrqPapVHq+SbUdwixZcssb5C93UpgqjnD3zDLIWv48qrXrjZyGTjbs+G+Mf
         DFnZ5GBdBZQ08MULWEckkaB53PgcSz2qUDwy/o/JJidnKdpxLZZhdCsmcrvk7KlSYPkP
         xFaxyjHF6oP1WtQPJjN4fnYOy97Y5yLrsEaxbsv82FQjhdvUTKyAMQvktB2MRXhNUR2L
         z2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707751130; x=1708355930;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pF946CpJ/XUzSX48FA6SkNB38WdYQChRpLEw+WyZWjo=;
        b=t/hrlFrJVgdTmx8XtB5wxi7BF/x2F+6TLG8F2qsaK5Ym6wQ9eVhzjLsJ1ilwjtItaW
         ecL7hYvofOBFsYh1o/FWwEShSHqVflWDxilymgyZC4TRh/f33XqUGyZBeRbjPtcO5Egg
         lXuIBUST6nEiO6sPcEyDGQMo+OmIbtaZxfI0/++X2ZPrVecYklkgGbSHDPTlmp5ejTzZ
         CTeDjYQq+Kczr/VDLPqSSSgCN+eZZRTUn/DT3gsszpKljMo30VHIA9kXX92uCoKOHpCJ
         iAFx40TJ4DAld0nv2G9T1BFOp7N1aNt1rsRFB28tMXnO4WpI26dUCAfVVc8AUJ707l5k
         EDoA==
X-Gm-Message-State: AOJu0YyJQLXFF2SDZn4LxoL4JCktv7T/CmGr5qJSr6BZ56Rbco661Rqb
	WEwpqRkc8Jo/r0baygknCSSyt3YfGmeeUXySKSzvuGBJ1YZo3LzTYCZcYOU1t5hW2FXu0mq1fZy
	PdAZBW1iBaVGXFEgHOAvCQHr9xghm0nMnVeA=
X-Google-Smtp-Source: AGHT+IGqnKsRN8rYBWWUuo4lJf+28zmf56XMl/cW2q4XOjB5uVt8+Cmw0eIhrMUshU79QYGgPG33hJv/xCqe0VccpaM=
X-Received: by 2002:a05:6808:2120:b0:3c0:3359:484f with SMTP id
 r32-20020a056808212000b003c03359484fmr6241115oiw.58.1707751129772; Mon, 12
 Feb 2024 07:18:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xiaoguang WANG <wxiaoguang@gmail.com>
Date: Mon, 12 Feb 2024 23:18:38 +0800
Message-ID: <CABn0oJvg3M_kBW-u=j3QhKnO=6QOzk-YFTgonYw_UvFS1NTX4g@mail.gmail.com>
Subject: Bug report: Incorrect GIT_FLUSH behavior in 2.43.1 (regression and breaking)
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ref: https://github.com/git/git/commit/556e68032f8248c831e48207e5cb923c9fe0e42c

If GIT_FLUSH=true, it should mean to "do the flush". But that commit
made skip_stdout_flush=true when GIT_FLUSH=true.

And by the way, only accepting GIT_FLUSH=true is quite breaking, it
drops the compatibility of GIT_FLUSH=1: it causes the existing
programs which depend on the "flushing(GIT_FLUSH=1)" behavior would
hang forever if they use the new git binary, because the program won't
see any flushed output ....

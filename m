Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FAE524B1
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 20:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372846; cv=none; b=C60Tl97eNQsZ4C+0iEyD2D5A4EHpFSgOR/F+ggmWvfUXde74GgNHZC86kSAgR5nHT8jQ1itt6e3lUHJzMYFjC1BCNINLul7MbFeb1ixtdEx+IXmdoJ08Pzh0yu41SDSMDN4zrnFtQ/0K7YJPx5+xOiMhgdj7HAFUld6HMXkCrBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372846; c=relaxed/simple;
	bh=t2+Mfoy1l8Elbv4J10BN4iLVJNKhxs9CluX4b2jRQBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QclNjOocxM8mIglMuSfw4FGTqvocObgKBGqXaLh/yNL8mEaN9CcisOYLARTRkMvWK3uDOi+UIAUrIiqU02rYOKZRtLaL+hq5V5CTyXDiOO/qiHYU9cmZko19rWZ6KJ9K3ng6cJB8dAqcVUZ4+erauymI/8755Z4rR/3zYWkG+7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9W3NYS/; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9W3NYS/"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3e82664d53so193474666b.3
        for <git@vger.kernel.org>; Mon, 19 Feb 2024 12:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708372843; x=1708977643; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YV+7RJVYP/5sOomg9cRq+RTlJDVzwNIk00E2B7e4dRE=;
        b=K9W3NYS/fvb9JdQasMlorcrY8+j4A5rOg5rJIrol2Wua6H2t8kpuzskdAbjRLGz+rM
         aSgf9tOgku5QzbukUWDHIFVET5X6RhzmKwN32OSuzBJc0MGHSFOBntPiSt+jARZYJ6j7
         k6Uo3X+lzd/YwcwBvjS/4r6e97iWzrv93UyGdf84xM07fso3Pjq815TxNS+7je4ZzHlK
         5rNmh0oZdfoEtBLY6r0RU7VTGQFJ0Pt4HsojRnCvKYrSkIJjllZFvnyEcAR1FaX9kCtB
         8WPprJ5P5dUR1acS1X9HEzv2pKkt6tUo0SvnOtO5l9kRV8TnASQBWhHKXy6IDBv+DCDm
         YCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708372843; x=1708977643;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YV+7RJVYP/5sOomg9cRq+RTlJDVzwNIk00E2B7e4dRE=;
        b=vpixvyLReE9R3QxzW7F88A40Lvbn3VzoADw7AQj+NUBUWy7I/32W7SI3dHnQK8KYw2
         3WI+zlfrtxU1umJMIF0SCorHPIb3BzhGY4hMUoV1ZqaXzZmCSpM6V+mCbEVmuyroUs4M
         6kai/SuHVVdVPuoV7GESqAeJzI/b91hYFLrXPsDlVacNRiOoGOvwCkYvK7QNJVMAK4BT
         BQh5VSmrclKYy9KLnLIwqxLGeg3IgPz5X0AvtHwwjfX084dcLaOUgbXg1ur+LyHd9YfY
         NFr2TM7hQnFHnUQ2spa+NSLv9cQ8AlbUFz7R0NoS/UpJCtmiQJzCTDFghlkUPQTFao8Y
         nZ0w==
X-Forwarded-Encrypted: i=1; AJvYcCVv8WZiOKfL+A3Ns7KZqHQcF/iEGkfZKwghO5Lkye3dbkUsRYlcGWLU/Cfg9QCY6BQdsWS6iXKsWnlfsy5gaiRwj5CL
X-Gm-Message-State: AOJu0YyEbAvaHhd48WhMx+ZjXH635QO5HbwajApnt6/uEv9L/9yXatto
	f1oTTLI16fKOZjy5cX0Zj7AovBBLgzlx0CwnqE1gK/0DQ1mxN5OiJKhtp4cKXOE+KphtF3WpDKe
	gfnsszO9tFQ5BDZW4oxo392nGUkE=
X-Google-Smtp-Source: AGHT+IGdDhgQkLRh1CZQ6Cz/JEhx4lF8FJ2rnD79KbIwoJ0xLAtbCtJ8ZdzIrR/4Xn5VYWlKUEa19dN7F9dmYMbM/T0=
X-Received: by 2002:a17:906:b0d1:b0:a3d:4ed8:f5bf with SMTP id
 bk17-20020a170906b0d100b00a3d4ed8f5bfmr10004037ejb.2.1708372842616; Mon, 19
 Feb 2024 12:00:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1676.git.git.1708296694988.gitgitgadget@gmail.com> <ZdLweyFLDtdMAq2x@tanuki>
In-Reply-To: <ZdLweyFLDtdMAq2x@tanuki>
From: M Hickford <mirth.hickford@gmail.com>
Date: Mon, 19 Feb 2024 20:00:00 +0000
Message-ID: <CAGJzqsmwpHu7sMNs6C7k-V5JtpPtdYmXEp2uk-x-ZKLZ8S6jCA@mail.gmail.com>
Subject: Re: [PATCH] libsecret: retrieve empty password
To: Patrick Steinhardt <ps@pks.im>
Cc: M Hickford via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> > +                             g_free(c->password);
> > +                             c->password = strdup("");
>
> Shouldn't we use `g_strdup()` here, like we do everywhere else in this
> credential helper?

You're right. I'll correct in patch v2.

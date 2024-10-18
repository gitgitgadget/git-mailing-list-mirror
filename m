Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01118200CA2
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 09:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729245014; cv=none; b=XemrVZ/gI8Uu4dbdGz+7iRgbpZsRRe9xrTywxPZw8V0jHW5I+SlA87+b0FOY8MzIFVq68nD9HxsjSycP0cCQ+eutxsMg4joAejczUecGGOZ7IyY67Nz8Mb1J3O1/fnTy3oJIgLV1R1wVqFRZLHMpk0WeaEcGlQzuYPo16P11iBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729245014; c=relaxed/simple;
	bh=u5xQHKvK6ai2MaM6QFn9Em7rGKPnMei81U/f35qbTwM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=l6cRluGuW6xeawzOl8jFg8lfOwNoMtaZQ4jvqZq6Irn9Pvi9Xu7M9sfVAX3F/0hlVmelVW35zFlG3eb4Qtvh5elq7B5reMHi3XauakU0XJbQJbNRKgEwBeQXQFwtHY8sqscQyg5MZa+RyfgjWAt3qSYgBG0zfw0xkfCCf4yMPfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQPjn6M8; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQPjn6M8"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5eb5ea185daso934375eaf.2
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 02:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729245012; x=1729849812; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u5xQHKvK6ai2MaM6QFn9Em7rGKPnMei81U/f35qbTwM=;
        b=iQPjn6M8FP244oir2J8TbQvVlMVIuWl9edKBJd/g5O1qtkgxiRr73DjtRjw+nOVoSg
         XjxPr0Dc9lWa5VBprwN8SGN0wVJ2Jj13/lKqGEOx+EIzkwt8pS1F50oMnnxxKvtcYzRn
         VS8pqYvfaARO6mQey7gcHV14VwRhjXlr8WYE/W4HVgbdbvqSK+NTmpwgWsnsDEig7imI
         Qse83hjlBS7S+QjKwzwonJMPO6V6s6x1zkcCLSzgTd2qX+nttcurHVz07Ssd9Rsh2vKo
         qnzYCdgmMp7RFeOAzk+NZ5//y/yWcSnKAafKdFX6Sv3U+5QbvHEqGjqGaST2dUY4Y5dK
         eoeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729245012; x=1729849812;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u5xQHKvK6ai2MaM6QFn9Em7rGKPnMei81U/f35qbTwM=;
        b=UTSrjXyWGKxw8QFN4e/9OdrQCbvvcIChpD/IDjuAzDq3OSnHmfHvSKeWJxRMkwmCQ7
         GWAGly5zJOi15E5HodgP1yKgAlCktaRnYWTeYvkEsPIe0Uln854f/3nGRszRe7ZwOx0E
         qc1p19Ua1jUBNU/aMa2oV06ekbFsCD2qbREFFcYr4JLYfUBGeqMM6JmQ2RoGMQRkXiZX
         B/ISQ3c9nrTobOdcwJSKkzlOozjhTWvQl1GujeqAhvmfppGBhyaZwXe0hIex3+LfcMh6
         7epXCU0CBPyomVHMFv8V8ykXlsh++XGfNq4opYfc1sujKxiUcDsXCnKcAuXWK/ac+Xoj
         uatg==
X-Gm-Message-State: AOJu0YyfcRoVqFpkbrXKcnCwg94M8gsppRty6l6qerHgXiBvGWgLzzJ1
	sBQoFz5ZzwEQKN6ZeFpLAIvCsryNo7jgEY0wdCKYHLg/L7+FR5CBXIGIDl9TCcQggskPrlszWjH
	IAVdIQIggCVhIWkdy7WVSIaslajUuh5ErhSs=
X-Google-Smtp-Source: AGHT+IF6LMe5vyvb45J+TLItwUEogsCC5HWhxAFcJVIYlASlMzVXMtjXr3lOs+55EhbCk+vj4ubA5t2N4Edvy21wX1k=
X-Received: by 2002:a05:6820:50a:b0:5e5:c456:8996 with SMTP id
 006d021491bc7-5eb8b551796mr1319919eaf.4.1729245011784; Fri, 18 Oct 2024
 02:50:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Aswin Benny <aswinbenny.edu@gmail.com>
Date: Fri, 18 Oct 2024 15:20:00 +0530
Message-ID: <CAHJ9C2JNVH6SmE5FoR7u7Z=5eynm8QfW4ZHMeA6dvP0FodxNWA@mail.gmail.com>
Subject: Feature Request : Get repo size without cloning
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I would like to request the following features to git :
1. A command or feature to get the size of the repo without cloning it
to the system
2. An option to know the size of objects that will be downloaded forehand.

Context :
I am a student and I was building a SAAS tool that analyses code.I
need to prevent people from cloning repos more than 1 GB.
I could use the APIs from github and gitlab but there is no common
method amongst them.
Currently I am doing a shallow clone and after cloning check if the
repo size exceeds 1GB, if it exceeds I will delete it. I have to clone
the repos to know the repo size.
Thanks in advance.

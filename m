Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6FA53388
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 17:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712855799; cv=none; b=H4qMCG1SHvkux4i2f54QLDbXZufTL4KVer0YxjCibHWw6pyHyx/GrGGMECpQg7fsu0Sql01OOOqJ2bfQ/eSfPmll2Gj+EOvh6Oa8fleWW+taTyz5OtT9y5PoxIY8t3oSyYFDXV4O1KvFuyO0VZELlLE1j7nGvq8k3gh60DKVXs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712855799; c=relaxed/simple;
	bh=kwJEog5Hqn+hI7h85AQbOcRtdU967uDKh9LHpeUXd90=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=T5U39KxxUhMWwPelNwKmzpEKCl96VJeGrckoNFxfPuJCywQ3cpPvPcyfOiYC8V1edVvdxWbCuSGevtH7sV9tIqKrqmBIu63kw/bQGL5mDoGz5o5OmylnQa4AjevejIEeLQb0GTrur9GdlX9++IhXSOZ/cN8xQ+eApposgzST1h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNa9Lu6+; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNa9Lu6+"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6ea1a55b0c0so57224a34.3
        for <git@vger.kernel.org>; Thu, 11 Apr 2024 10:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712855797; x=1713460597; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kwJEog5Hqn+hI7h85AQbOcRtdU967uDKh9LHpeUXd90=;
        b=KNa9Lu6+WprVnafVJvQ9P7Rm9CVjMnqbuUOJCKiV/fh60s6HHtI93xSBxWsS1iPEDH
         W64XYsbx+deoEQ6Mr1vCdC1oN1gbaKZeVQXIGIoesQgrGKxz3ZXzD9+Rv80TVZIrKkD0
         xOpNvkBA5xG6jdZCnWKJDdcY3eHhOtnH+2q5dfAWkb1dPsn+Yc+IFK4nbhEIaOcpoCS6
         R+UoUTn7gDI28xKM1S4m5jMxHNDDiPizIxFYxALKiOMQFzhpxqXJ9qYBEDM87DsEDkfy
         T1/QJBJ4++rydkotvMZIYcuHjgaAzMu8lcWwg0sVBcPizzY8++JCHPOHvK9+GLCWCvI2
         sZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712855797; x=1713460597;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kwJEog5Hqn+hI7h85AQbOcRtdU967uDKh9LHpeUXd90=;
        b=KVQwOgImuT7rOc87BLgrshKPuGZELgj/7i7iOeB+wLZgUOFqkE4Hwr9/zL9wVBp3H2
         8ZAubUO9SFL4FZZnCtADdrBbKqAgYUtFDGKyMH84nwVHttb4lX202axfqvpWXenkMmQA
         H6eRYYPwMAWjOJUuvfYXvIQa8pHOBVjU47pIdOWecdYJRmaBXsnkZ4595Eee500axp6E
         5LsBqn8dtpflgi0escfzFyBK/M5Zadznt9G4IibjoY7z2NRyRmgJfmJ1BrScMfQYraGG
         82t2t5/l2Jc7NpE0vxF1g9PK3HEL1uxLROXavZ7R4ko/rqRf4O/UC0aSKyxHHZgb3uIc
         TMww==
X-Gm-Message-State: AOJu0Yzefe3llxblnyP/GUIPA/YZgirgiTWCe1+ctJVXEr7uzK4P9h8P
	ZQOvxL5VBskAe3cRr7JGo/weBnu+80chL21qmhp1Zaw1qwF58gF+wapzOiciH7ErkiKPWFOs5JC
	eIGiHHgeARbVkOo4LoxxjMwAiwljbsw==
X-Google-Smtp-Source: AGHT+IGD+IOnZ+kwYPslcLdTypg0ONDZElVbBBkcXQT8uE/zIk4yqe8fAjfBoj9QK0SUJaxR2cPb8YEI3HiDCJhYgXs=
X-Received: by 2002:a9d:3e0c:0:b0:6ea:20d5:5459 with SMTP id
 a12-20020a9d3e0c000000b006ea20d55459mr260153otd.17.1712855796866; Thu, 11 Apr
 2024 10:16:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Wyatt Carpenter <wyattscarpenter@gmail.com>
Date: Thu, 11 Apr 2024 13:16:26 -0400
Message-ID: <CADwVmK293eQ5VFkn-J68tXQ=64u3H79ScMW7H_ukSmtwLwA4wA@mail.gmail.com>
Subject: Short form of --force-with-lease
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I often use git push --force-with-lease; it does exactly what I need.
Is there a short form of the flag, like -f is for --force? If not, I
would like to propose -l be added as one. I don't believe git push has
an -l flag currently, and l is of course the first letter of lease.

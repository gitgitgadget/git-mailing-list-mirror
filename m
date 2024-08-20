Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C451C6A1
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 01:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724118519; cv=none; b=bfwuWUyVD+3uGttYhARCYlteS5fO8+XU/5xd9p+75FXLnMQ/pVPSlfEzUboCKR+igESj/oB5hwLnFn+iG+eoVlQXeYJ0InX3fklEA626uRP4FF+nK1FcxxrS8ccK99k32A4k+hDPHDnN97CnQapu0CGZYnyztYqohODZxgfIsgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724118519; c=relaxed/simple;
	bh=VS34iTezZInhU5zghvV8/CHzDQH/sQ6HfpxIqBtgYc8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=H8SIDb5W+V6plAyi79gs1AbyXLe5uym+biwt/3NoHf5eyHCYkL/8m9CrUbEl/9zfLlzNFqdexZBCAwbG9Z+5fnyglIhYwf3jM8y1O59nWjGhhh8A+j3UjFi62IHIxpOft0fGPjMZhcfLsrWpuFut+zOe3BoNCtkAGVWkq3Ykmj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5WLLLln; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5WLLLln"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5bed83487aeso3677680a12.2
        for <git@vger.kernel.org>; Mon, 19 Aug 2024 18:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724118515; x=1724723315; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9NY0rv6MmEGgT2HegUSZMLknsIHDP+3FhkexaWq9T8=;
        b=Y5WLLLlneae8jRKtINowV+7RJB3dyNZIPxDsUKQ4gTUkc04J9HxFsVlyaB51xVfZd8
         B1gfb6XmsuGXtIw3ZIYqr+n7UIdsC9OTTDfwFif27NlKoIrdbm7tRbDn43YfhO0AGRlN
         ROjUtF2FSp5pOFdWqIupVcFkgZvV6XXPxyd3pyHlm28shXkup0cIYnKqi32GSa2vsNov
         auJbYdrcO3o7f9hSdqN9FleOu9S6yXSK8xzZbDUZHgmp5cFfTqL30la1MN9VPmC2igQ8
         2DKbUNCc1ihzbkfdr9dGnU7GHXCvZiTJVQCcWBZKkhRrAzA0dRW7ns5smqhI4E7V1L95
         0H0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724118515; x=1724723315;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9NY0rv6MmEGgT2HegUSZMLknsIHDP+3FhkexaWq9T8=;
        b=c1I+zABIqToGNan1cnV+F4Tlv1CuI+p/7kXTSEB+fE47TXdK9quL1ZqWkvL6rN1qiF
         ux6oHp3w++IU1VvjgRcD5mrT93vAVf8x0vQ3JQLN65+0l2PZEsSpbMy6UgJ0BiQ7gUh4
         o2jxEg8AKwscDMF9Q4Mv4wVu+z8fV9FHSRwQXn7lWxg/uSDO9xrCQg2jLVWf71V4UE8m
         Z7iPI6Cpje7QDnMijkq2UBN8st0wWr3noGmES2W1yQlJDG97wBaBZ/ahNHoW4Ss4t+S8
         EMnswuZ/MT/WetyOKSyHz8a2zubdQ17Yz6EqKlbty0tM+1QFrPbBTtrSAfkoz9/kZPu1
         /JTg==
X-Gm-Message-State: AOJu0YxovSlDBCpEFYTzj6SA65CbTE2aUWZPBO2ZN+di9/Pb1+Y5Klcf
	6XkElp6rE0EBkPWMwZcDbMy99lbqBcnyeWUVPUm0jDtzk8R+lmMSpaulnQ==
X-Google-Smtp-Source: AGHT+IFYoRgpexDMeQaqdz3xAV+4qbGaCazqSpLH8apC8akJcktoYjmdooH8UZgaTCVi1/4lxnAwCA==
X-Received: by 2002:a05:6402:26cd:b0:5be:eb4f:d4bd with SMTP id 4fb4d7f45d1cf-5beeb4ff007mr5768070a12.7.1724118514547;
        Mon, 19 Aug 2024 18:48:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbde39c1sm6135077a12.23.2024.08.19.18.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 18:48:34 -0700 (PDT)
Message-Id: <pull.1750.v4.git.git.1724118513.gitgitgadget@gmail.com>
In-Reply-To: <pull.1750.v3.git.git.1723886760.gitgitgadget@gmail.com>
References: <pull.1750.v3.git.git.1723886760.gitgitgadget@gmail.com>
From: "Avi Halachmi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 20 Aug 2024 01:48:24 +0000
Subject: [PATCH v4 0/8] git-prompt: support more shells v4
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "Junio C. Hamano" <gitster@pobox.com>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Patrick Steinhardt <ps@pks.im>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Avi Halachmi <avihpit@yahoo.com>

This addresses review comments on part 5/8 v3 (git-prompt: add some missing
quotes) to fix minor wording issues at the commit message.

Hopefully this is the last wording fixup.

Avi Halachmi (:avih) (8):
  git-prompt: use here-doc instead of here-string
  git-prompt: fix uninitialized variable
  git-prompt: don't use shell arrays
  git-prompt: replace [[...]] with standard code
  git-prompt: add some missing quotes
  git-prompt: don't use shell $'...'
  git-prompt: ta-da! document usage in other shells
  git-prompt: support custom 0-width PS1 markers

 contrib/completion/git-prompt.sh | 191 ++++++++++++++++++++-----------
 1 file changed, 126 insertions(+), 65 deletions(-)


base-commit: d19b6cd2dd72dc811f19df4b32c7ed223256c3ee
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1750%2Favih%2Fprompt-compat-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1750/avih/prompt-compat-v4
Pull-Request: https://github.com/git/git/pull/1750

Range-diff vs v3:

 1:  9ce5ddadf0b = 1:  9ce5ddadf0b git-prompt: use here-doc instead of here-string
 2:  680ecb52404 = 2:  680ecb52404 git-prompt: fix uninitialized variable
 3:  7e994eae7bc = 3:  7e994eae7bc git-prompt: don't use shell arrays
 4:  232340902a1 = 4:  232340902a1 git-prompt: replace [[...]] with standard code
 5:  3a41ad889cc ! 5:  18ff70db6b3 git-prompt: add some missing quotes
     @@ Commit message
          in real life, but the fixes improve correctness, and would prevent
          bugs in some uncommon cases, such as weird IFS values.
      
     -    Listing some portability guideline here for future reference.
     +    Listing some portability guidelines here for future reference.
      
          I'm leaving it to someone else to decide whether to include
     -    it in the file itself, place is as a new file, or not.
     +    it in the file itself, place it as a new file, or not.
      
          ---------
      
     @@ Commit message
            Bad:  [ $mode = yes ];   local s=*   x=$y   e=$?   z=$(cmd...)
      
          The arguments to "local" do look like assignments, but they're not
     -    the assignment part of a simple command. they're at the command part.
     +    the assignment part of a simple command; they're at the command part.
      
          Still at the command part, no need to quote non-expandable values:
            Good:                 local x=   y=yes;   echo OK
 6:  e735a1696a0 = 6:  48aa31feedb git-prompt: don't use shell $'...'
 7:  e70440e669a = 7:  cd20b830b24 git-prompt: ta-da! document usage in other shells
 8:  633e71a01d3 = 8:  cb705d5fc8e git-prompt: support custom 0-width PS1 markers

-- 
gitgitgadget

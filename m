Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C75EEC3
	for <git@vger.kernel.org>; Sun, 27 Jul 2025 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753628837; cv=none; b=LQd8zg4J95IRNm8iwdnQgefH7kMT1ykR8JVogmnaqk4WSgDGUqKahy4TGnpMw/rK67Imi5YPXlQrP0Ws0HFdhR8Xl35/W8P9jSnVfkUkWb3duqZzIRgmTdFBwetqd2fPChcqQa/ZOW38jwXUp9TAy2JuAcnTu74qpPiC4bOOf9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753628837; c=relaxed/simple;
	bh=ohry46UxAIJyWhfBG7mKOF1ryXnsPhpEbxZP8EBVTEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKJZNarXMghPLHot/YiKdmt2YXLG/+FSxqU3j7WzlZxqnnHxm4XaFMDDbA4r/ivxXNS8HhIZw2PA27ErAnd2swShjZWNXq0nCh68eG/DZNOWDEcDzsQR3appmNYKut3eIcnqk+MMjQC286+1B6kcOMD1a+mk2EsxVH8vk+93sDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAhwQuC5; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAhwQuC5"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55b51713671so4066929e87.1
        for <git@vger.kernel.org>; Sun, 27 Jul 2025 08:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753628833; x=1754233633; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ScafM1+9ItA0kF/8HmwXEK9pe7XrKoJQrJPB4YsJMJM=;
        b=dAhwQuC5dA/H+1WYVlsjHk5u5/j/DqRLluNdfFWFEzj1vVROTFX1uZTAHAH+DTgrZq
         fZLDOG7x+fXZugDjo7RHXQljP57AAnj3OBS57P3rhjPpoFVD+mFGdTQQNEcbtMUwN6BC
         iHJ6/sX9ygEBPg/W5dIUP7oqvcb80s8xry7f6rs5hnTkjO9jPRCD+EtuUFu2V2CDVTvS
         cCQHjIlo+gppQd66+GSa6AwqiJheBUiIpRM4AVTYW4UnjE5aPTebrRHAD/v23p0RN5fx
         mcBhgI7Q09dLDmefJOjUrlV6FEEGOFfp4O7YTR5scv2UvyLRqwsNf+XUPCsp1PJeZe01
         UfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753628833; x=1754233633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ScafM1+9ItA0kF/8HmwXEK9pe7XrKoJQrJPB4YsJMJM=;
        b=oCdfqrUqb07JnyOKEZJLu1qiOSyMd2Y38UIDu5WEZ1uXHal1akVctlOxmIZ6+TTLsM
         5oE/A/KqYGc1919aoLVrT8JbwSjSUwvO3I+9lMHX+OfrZtQOlJRFt3PerOLoNf9TdhPo
         p6PcAP7pMm0CKzCJNiIQpD+B+3i2atTk8F0KX99UF7J/Tc9SjC+PFoZ0YYABnNZQlx8h
         NvrudDxMeoPVftXOA+3+IYaF5YIiyzjrFcQaIIkNlDa9xTnCK/jxsLK+Q/euXgJJ+lrK
         LPyYuZX6JdWCiwDyUEfFGH1cZqV98B903huzAV/EoyhOGtqcc+5PmBPFhnPrNO0CeztZ
         OOEw==
X-Gm-Message-State: AOJu0YyUe/z6uW0hKGinAvxlvPmSorzFF/v2i3rWSAs4DW4g6Tnj7OMz
	cHVNfwv+ruwlm0fPObrx6FHoTeGyOrLZLFci3+0NmngQdxGDnhqlMmZCrFT2GYrC8/6VEdXqDq7
	RqSEBUIb2JvZ3FTqhYo70NUiPBBGDohi7DnGE
X-Gm-Gg: ASbGncsAuAXE2FEl5NB/o23e4UddueXuzsnmpm3qJ+iXdSwxNiV4jVNcpG+A7V7vAKj
	1REQXdQ1U25vbxxrkQs4W5gpX5Ljpd9ne1NkqgNwxzTyTxhBDZofEbnWEb28J1SbJdQwAYaV0gO
	R2SrxwktYTxMiXevRR9ZjEYpHr9xvSR9gmuRJ1Frq1B8dJ7w+D2nCvMEiSx5NJ5PrPCvyv7M7T8
	NgU
X-Google-Smtp-Source: AGHT+IF+PervonfwscBmUmhdCmStIyfX2baHcIWeU0pROfSekMt3Z7IKjscS2ttYYaoZBFa9ipqA4stlW8MwU03NIuc=
X-Received: by 2002:a05:6512:2205:b0:558:f7fc:87de with SMTP id
 2adb3069b0e04-55b5e518e13mr2321071e87.24.1753628832717; Sun, 27 Jul 2025
 08:07:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1946.git.1753627773304.gitgitgadget@gmail.com>
In-Reply-To: <pull.1946.git.1753627773304.gitgitgadget@gmail.com>
From: =?UTF-8?B?TmVsc29uIEJlbsOtdGV6IExlw7Nu?= <nbenitezl@gmail.com>
Date: Sun, 27 Jul 2025 16:06:35 +0100
X-Gm-Features: Ac12FXy4HX9GFDcZo6x-yJUOSlykQJOuVr5opBT3B6GQI1DC37SK8rAvUUNq7h0
Message-ID: <CAAUd640D3knxury+E07mh6sLac2YPHiYg5r73Q9PnPMFTDi=0w@mail.gmail.com>
Subject: Re: [PATCH] completion: new config var to use --sort in for-each-ref
To: Nelson Benitez Leon via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>     Hi, I'm submitting a patch for the Bash completion script, to be able to
>     change the default implicit alphabetical ordering used when returning
>     refs e.g. when doing "git checkout "

that should be "git checkout <TAB>" (got removed by Github apparently).

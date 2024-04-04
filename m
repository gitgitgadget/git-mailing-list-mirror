Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CF712D76B
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 20:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712260820; cv=none; b=ahsCwAlFYjtb52hWkbh2+KbxLyuSVfoSpDGnT8mL2AhEJAX0wruRTxFiO3otKgJTFcLn2jwlbzp6UfCXRL71hNXYyLh8hWRPfcloSUAfTocMUMo6F2MbVRHhuvPHNdRTRa+HljsVI2Rj5y186sLHKDk41jsxGvR/w+UPreHYEeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712260820; c=relaxed/simple;
	bh=8CyOMJJDNn2+WSCi/lcJAUmI13OPBXw74MoFpDmWdik=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fw8xDYaW1Qn5lYKKQidOoWbKDV+oghU1vwtkem/PwkWSdDzLjOEbglU3VSTGdX5ePtFB6VJv2w/u+O1kFbliPide5B5MsYuJhv5oobfJsHw4clv2hYDUcIIPxyXh8/EYt0SPXDe3TOXf6/gD8mYTRFpv7Lfop1ujMqcdC4/jBQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zbo0yivb; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zbo0yivb"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6ecbb44ddc7so1431873b3a.2
        for <git@vger.kernel.org>; Thu, 04 Apr 2024 13:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712260818; x=1712865618; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rABYbetPK8hhjBZFzfVRQ47eC4uT7qwMFXsutg9oFUg=;
        b=zbo0yivb8vTXRNk5SogOTgsHPar/5WQMF2d+VVwwxpcYXWlfsM1A+uSF0+tnrY5k7+
         gP/kE6uCF74h4MLZGKPfxiMlLxIlKNA3ROKbkSVan0CPnwoUMaHE0aVArUw+BHqKjsWL
         FADqrjNkSz0+a0MJM/d4MlE2y/kwVHZV/eqj5sv3B31Y6MJDyC/stI1JcE3E421PA9d9
         jz7QFnZOjJlV1lrhxgZRk5EDyI60pVUV2gqM3VLKFFayRlanpNV/AxUi3Xkv2neC6afj
         9dk/97keKqlRH7owV1T+Hv/KTkl6lEODV7u+cCzC7mzZgwjE5Bv7PyH4kRsdDYDpxPB5
         AMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712260818; x=1712865618;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rABYbetPK8hhjBZFzfVRQ47eC4uT7qwMFXsutg9oFUg=;
        b=gDAMdBaFX9otgKLeLR0LYe6KMll4gfaTagRpmi6FpjFPa3Oi+uvsX4HU29v669foC8
         nUN8cnWYtD7Bu1zo7jplmz/S/Y5rAIZ338QlrIpI45d2ZyAioIwHRNv9wJa5bg4hSskW
         3MT4wYDwMZf+7KU+0crtVVhfhSoyF3j2IEJOKEDnBIgTtyHyYMNuiOOhGA/6jsxch72u
         DoBDvbhZheGlNZQ4LE/mIwwEGq2NXGLmUtBbG/L8OJktpZnKJDX/UvPz7O9kE70+k41P
         TdtDvvdzlW0hRH/JTE3H3IfphzzsvN249GsYt6CpBI+Wgyiwi+6roqVERTq2y+0GdkHg
         jDdw==
X-Gm-Message-State: AOJu0YzQP5XDTHw9ekqslnpMd808OLlXFYDNx3ulswFD7PG5IlahkWLM
	rmGvgOtdLy/N/EmoTiOpKg6PrEXlO+sPKBhxJBoM/LKgxClTYKUUmeyoSLJsGR8WqN6nRNbhhl6
	V4Q==
X-Google-Smtp-Source: AGHT+IGnzJHtNan7VpL+FfCJ6vesY4H5+rJlcav4sQr6pPX+MaF2ZSG9QGns5qyhFvcfcgYkiU811Cfcvvs=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6a00:9298:b0:6ea:afd1:90e7 with SMTP id
 jw24-20020a056a00929800b006eaafd190e7mr43435pfb.6.1712260817660; Thu, 04 Apr
 2024 13:00:17 -0700 (PDT)
Date: Thu, 04 Apr 2024 13:00:16 -0700
In-Reply-To: <Zgulh1rxl9Af-iQK@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1704.git.1712017205754.gitgitgadget@gmail.com> <Zgulh1rxl9Af-iQK@tanuki>
Message-ID: <owlyv84wsxtb.fsf@fine.c.googlers.com>
Subject: Re: [PATCH] docs: recommend using contrib/contacts/git-contacts
From: Linus Arver <linusa@google.com>
To: Patrick Steinhardt <ps@pks.im>, Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Jonathan Tan <jonathantanmy@google.com>, 
	Emily Shaffer <nasamuffin@google.com>, Pablo CHABANNE <pablo.chabanne@etu.univ-lyon1.fr>, 
	Nathan BERBEZIER <nathan.berbezier@etu.univ-lyon1.fr>, 
	Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>, 
	Matthieu MOY <matthieu.moy@univ-lyon1.fr>
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Apr 02, 2024 at 12:20:05AM +0000, Linus Arver via GitGitGadget wrote:
>> From: Linus Arver <linusa@google.com>
>> 
>> Although we've had this script since 4d06402b1b (contrib: add
>> git-contacts helper, 2013-07-21), we don't mention it in our
>> introductory docs. Do so now.
>> 
>> Signed-off-by: Linus Arver <linusa@google.com>
>> ---
>>     docs: recommend using contrib/contacts/git-contacts
>> 
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1704%2Flistx%2Freviewers-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1704/listx/reviewers-v1
>> Pull-Request: https://github.com/gitgitgadget/git/pull/1704
>> 
>>  Documentation/MyFirstContribution.txt | 3 +++
>>  Documentation/SubmittingPatches       | 4 ++++
>>  2 files changed, 7 insertions(+)
>> 
>> diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
>> index f06563e9817..eb1e27a82df 100644
>> --- a/Documentation/MyFirstContribution.txt
>> +++ b/Documentation/MyFirstContribution.txt
>> @@ -1116,6 +1116,9 @@ $ git send-email --to=target@example.com psuh/*.patch
>>  NOTE: Check `git help send-email` for some other options which you may find
>>  valuable, such as changing the Reply-to address or adding more CC and BCC lines.
>>  
>> +NOTE: Use `contrib/contacts/git-contacts` to get a list of reviewers you should
>> +include in the CC list.
>> +
>
> Should we mention that the script can be passed to git-send-email(1) via
> `--cc-cmd=`?

Ack, will do. I think I can just copy/paste the existing guidance from
git-contact.txt which has this example:

    git send-email --cc-cmd='git contacts' feature/*.patch

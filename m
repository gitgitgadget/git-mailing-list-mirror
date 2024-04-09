Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9533A15884B
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 22:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712701212; cv=none; b=RvryGSOHeMt097nvI0LW+RMDdmFu2jZ/noddZrQO49d7dKpQxS1uIPSeB0aiEopQAY1J9iG/Gp0r07axPOijjmYEs3K++qLsD1Ly8c9fpW05HFC9tNy8NWL3Cbyl0/EX1i6/VjVbgczmA0Vu0SLZhbsFluDIWNQm7ZSGjWevYxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712701212; c=relaxed/simple;
	bh=qq6enqClMG+StPxY6kpTa8XxAkiHxzqkVsB+FUtuMJ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gahIpw4kA1mk8iAsmYNX26/9bPd/qZm+pym4qkNbWe8gh0/Ixvoj9gPOlcPuWEpppjvkOnP17AzDbRW5a4njkfuzAtdqqLU+ww2To5IGd4nQuqE6ZvVsWXQgpDBxT77BpxagCzVy7bKXFNbnM3s0AADiL5qEHr+lTCaASZoX9Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XH50CSYU; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XH50CSYU"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1e45e04bb40so19379875ad.2
        for <git@vger.kernel.org>; Tue, 09 Apr 2024 15:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712701210; x=1713306010; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UD5RAvJ6VHZGwqOZ553Ebh1gIB6YYbewqLbcybO79fU=;
        b=XH50CSYUK5c0BnfFn+FfjVYtRxEBXxjpIiSvqUBpnFci3XAPXNMg0z9MS+nZSvNtwf
         lYZk02/f+OGqr67T/27/P/Dl8JAbnIFKrq9wQeRqN5A7n5LG0RbF9ekQWY+Mx4JENrYY
         4gsNKvRm+4RVfedLRidvWfIUtt6pO5ydWqobDe3OMSBlK856nXkpmU09CIv16V+e30P7
         1/AV6ME5S7Gzju7oOiIVYAVefOZlSM+P9UKfjK2UpE3yjpvifTYllRIrAh58aebj4R03
         L+7ysDANxeF9PuhWydH7xdYXcBgVPUGTa0AyI0XpG/IkfSdoivI/t3CAC9qsrCDXydsm
         Fxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712701210; x=1713306010;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UD5RAvJ6VHZGwqOZ553Ebh1gIB6YYbewqLbcybO79fU=;
        b=CItXYlOHJsLU/3JUwI08AQl1KtYb3ykUNPdG/Vti7rJ2yKPcsVS+7pch48uepWO0b/
         PvrgjLL3pp32bS9GhSIvRaQa0STfz0+2hGNuj7z8M8FHAZ7zbPnIvaDzZq8u0PuqUAAY
         5BrBy5Cltk9lGlIPnrUmyVfvkH6ZCLwPCYLJBFXRrPthcs8/wg+61PCdd+Q1VafKPhpg
         sVA/EBq6Wkzl/CT9yimr7N3r9AI5z+sLrQ/qw2Ry7UXaE+10vpF7Z2oCv0Lp/WCYHl2I
         I5O1L94kONEX+nf6PdsU3LNp/hFRWsPqM4LYOuxTZziBFqUtweudBVX5S6cSSaxrcqlJ
         6ZcQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7vHBFraEcKi/F6OQ1dW6YfuX2mEDpOxUVEmtIzJWAWOqwiqPz4EjGtgpbITtKrmYE3G692lomDk/GEoyV4s2fU9eP
X-Gm-Message-State: AOJu0YxiG0EHaUZKUBR2sYk7SwPQvZIuNFGVyXjBCULn0Qw9YnIT0YXr
	c5+V1YiE35XdZTtJxexIQpVveHbVyoiBLGHwPfUWNQPokFC0nrRYDbCyAXP8Dt4phmVSUhBj2+u
	48g==
X-Google-Smtp-Source: AGHT+IF8qkcwGmaAjLOhqutmj7KM+XHxI32O04x2IVNsj9cQBaaRsyaiZ2CLZpFvMpIp6Av59nzEjEyZITA=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:902:ec8b:b0:1e4:320b:65e5 with SMTP id
 x11-20020a170902ec8b00b001e4320b65e5mr3065plg.13.1712701209697; Tue, 09 Apr
 2024 15:20:09 -0700 (PDT)
Date: Tue, 09 Apr 2024 15:20:08 -0700
In-Reply-To: <1f65dc5ba3ded5b90ed929aa3884574e8b26cd9b.1712699815.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
 <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com> <1f65dc5ba3ded5b90ed929aa3884574e8b26cd9b.1712699815.git.gitgitgadget@gmail.com>
Message-ID: <owlyil0qrxev.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v3 1/8] MyFirstContribution: mention contrib/contacts/git-contacts
From: Linus Arver <linusa@google.com>
To: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Jonathan Tan <jonathantanmy@google.com>, Emily Shaffer <nasamuffin@google.com>, 
	Patrick Steinhardt <ps@pks.im>, Matthieu Moy <git@matthieu-moy.fr>
Content-Type: text/plain; charset="UTF-8"

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> Although we've had this script since 4d06402b1b (contrib: add
> git-contacts helper, 2013-07-21), we don't mention it in our
> introductory docs. Do so now.
>
> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  Documentation/MyFirstContribution.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
> index f06563e9817..00f4c63cb9f 100644
> --- a/Documentation/MyFirstContribution.txt
> +++ b/Documentation/MyFirstContribution.txt
> @@ -1116,6 +1116,11 @@ $ git send-email --to=target@example.com psuh/*.patch
>  NOTE: Check `git help send-email` for some other options which you may find
>  valuable, such as changing the Reply-to address or adding more CC and BCC lines.
>  
> +NOTE: If you're not sure who to CC, use `contrib/contacts/git-contacts` to get a
> +list of reviewers you should include in the CC list. In addition, you can do

I just realized that I could also do s/should/could here, but I assume
you'd prefer to modify in-place instead of me rerolling for a v4 just
for this change. Thanks.

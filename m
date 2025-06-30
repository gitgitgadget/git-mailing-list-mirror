Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CDF137932
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 04:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751257747; cv=none; b=drLsu++3H6sptCVfMhYx7/V3MOtzXbaJsvVGOCocz6qqntMgmMTCv1e/tj9BvpdiIBSb7OeXPYGXBz2t3b4Z/PI9s75ooa46DgJ353UHOOnr1tBYnxN1614Uu2ZgEXEvu6Da/FwP90cB8IFoJIQ8gLr9vP/y0PbuF02twEiJzgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751257747; c=relaxed/simple;
	bh=80sU3SFNPwwjD+NIaVjV9ZGQaC5rMPwD+NolAiXPUdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iVMcumb5rLxuKocCVlO0feEabXIgmMjDgBNJGz93HSurcZVjCKmuZ2Y1kwHJu/uZ3RJlmDXQpA0OgrNQgqs9d046XgqOeSoAJO80zDs307iUC7Vf7Xqt5/2JsqRO8PS+HpsNDQAhfipoAXR0E02r4BBZ0mT46IEZPrWG1BjDzpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnO1LNrc; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnO1LNrc"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-313cde344d4so1649333a91.0
        for <git@vger.kernel.org>; Sun, 29 Jun 2025 21:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751257746; x=1751862546; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=80sU3SFNPwwjD+NIaVjV9ZGQaC5rMPwD+NolAiXPUdE=;
        b=NnO1LNrc3ow/0i6qtbbTKeklRMefmDL5cDj0DOEklu9MV7Y9AMoKMSpwqNSq6cJaRQ
         CgyQVualrirrrOyqC6cL5+OmiDKXDJapgWqA2OmQ/mdOiXfOOUrd6//L6bHS6FeTyVy7
         NcaIaKUMHElEMkK70ueeQQWrZQUgsFUgu4w8DOVBHyWv4N+i4gnFWqHj9qoxhMwS2gZ7
         uHUqE0R5xO52EJXHqbKwsn71/4rgdXdoORd5QbtokKaJJj5MhPPFNBZGkCsS7PxzRQ6w
         UE/WTSMY82FM/hTF4QXL2boINfpFQ+LWCPaj5Q8EEpZ7c0bSxjPowx/kqpHQAjEn+OHM
         vbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751257746; x=1751862546;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=80sU3SFNPwwjD+NIaVjV9ZGQaC5rMPwD+NolAiXPUdE=;
        b=KJ8lBzKIiWq9n3A6CPjSBzj7+nTJORCEafzypoAQQvbONhSrE9yMgj/FpL+PwycvCK
         3lGyfXW5tIpbx8/1SNOxWozxW8/hbtCy4Ej4cIFYDD+HuqjslQyvCUplWgVa5sTKjVJs
         8VWTmA4NzDOQ681rYlC9SGxS7mKPJCt3DHzjDF917jHPSKT+lZ70w8nWUcV4dApZgXTA
         rZBbWC75O3+ar55hXSUVxOjKysAkvSVaiDvRHjYKoKfilXxj/11O8gT8sGSSttXhJD9V
         Km8BWlyYs4MT9E8LAh8p6eAo1UGYfqQRX9dERsODvk/hKl0qgEAI9BYrZkqk6uaJgv8L
         2Z+w==
X-Gm-Message-State: AOJu0YzUtZRMre24PuIg7pfPuFc0g8xww4IhEGwv5qTcsX+zTl/DQyIc
	5wvYTY5gzEQADnfxh25DSsguoN43/HA0TS9V2J6Ik7xu+dXB8fxbcIlLHQwD7ihMb2Zrm10wJo5
	jn4ZNkWjp65PZQ8RkNVvrWMQlL7RCkRp/fZ4H6jc=
X-Gm-Gg: ASbGncv34bUoobkhWqk68Xae6+S0OpQ1dciewLLnQYDFo+HZWCHzHI342kE7DdZ+f1M
	lqG+Kga1Drzr/aiK0ZGzjn+P+Vw2U/Bkr+Cj170NDDfWUE5cb/edQKrvWkKu6SFAOfdeVfHrXTP
	kHUNijWuXOeQ/DOQTDp0jGsvEDSIuZcEkmxGA0vvgCsf6NEVOy7jyF6pIk
X-Google-Smtp-Source: AGHT+IHkgLKI4rGjqQG/RZ6lg3cHxz1xuU3B4CX5d27LVQZT+a5Tg2B4drA2Sek9PyNakvh7K7F/5Nf10Ao+N4R6eYY=
X-Received: by 2002:a17:90a:c106:b0:311:c939:c859 with SMTP id
 98e67ed59e1d1-318c92fd097mr15324063a91.30.1751257745750; Sun, 29 Jun 2025
 21:29:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627074934.1761897-1-meetsoni3017@gmail.com>
 <20250627074934.1761897-2-meetsoni3017@gmail.com> <0d3fe70e-2064-4206-9673-c0589a4445f1@free.fr>
In-Reply-To: <0d3fe70e-2064-4206-9673-c0589a4445f1@free.fr>
From: Meet Soni <meetsoni3017@gmail.com>
Date: Mon, 30 Jun 2025 09:58:53 +0530
X-Gm-Features: Ac12FXzn7b7yJUHb1wYSfhOUoUQVyK4Ert4LdaAZbBZwKk11Cnwkg7tbluJr1cE
Message-ID: <CAPhwyn20tVSZfe2RgmYwoWJkKuMBj9S=Ji_zkYO0a0JMwnOSAQ@mail.gmail.com>
Subject: Re: [GSoC][RFC PATCH 1/2] builtin/refs: add list subcommand
To: =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Cc: git@vger.kernel.org, ps@pks.im, shejialuo@gmail.com, karthik.188@gmail.com, 
	Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Thanks for the review, and apologies. I should've clarified earlier that the
current documentation was meant as a placeholder until the feature direction is
finalized. The intention was to help reviewers get a sense of the intended
usage, and I plan to revise it more thoroughly once there's consensus on the
interface.

Also, noted the follow-up patch to improve the git-for-each-ref documentation.
Thanks for taking that initiative!

Thanks,
Meet

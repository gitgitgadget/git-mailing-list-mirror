Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529812B9C3
	for <git@vger.kernel.org>; Wed, 22 May 2024 17:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716398368; cv=none; b=WdtbVZI/FsICDt5QGmyqtbo8iByVpHjgZiEfHywhYIDGUR7nQ63QuDTCbrZASjguNfF/Ywrk8c5M5ojRuz6lvyrBKJ+kUssR/VW7bjIfJqb4z4BgMHkGrmF/M6ESEBjvrAiMCF07CSWjkViCMFRULQSW5L7vPuxSOy8psp3FcUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716398368; c=relaxed/simple;
	bh=ONgE0ABhImBhn5UU15Um8tbSNTG8KNWLZ0sLP05FQV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GMHr+57EuEy7P6mFbV9jnt3UsGOQRQiJT7/0CdLN3LmWWdvAAWJIzRpJ3gUDdCtEdNHIo0UER08DMBEuQVc7e0fCEwsnDbBS7z0nAS2QLDRbIRtqXA/zXUuH4R5vUsx9zuls/lqhG+TnRYvsw6pJeRzpBtYgz6d2LScnPRyAtG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLkWYjSf; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLkWYjSf"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42017f8de7aso45163385e9.1
        for <git@vger.kernel.org>; Wed, 22 May 2024 10:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716398366; x=1717003166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vzLKAxCrEY7uDbqJTk5KgxKEAjbjo56US0UzpStrN5I=;
        b=OLkWYjSfcANoZjX9NEO41zUfudUdp4D/Au+V5WAELoD5vHVj1DZVVlfivsJba/536U
         9q7yJRkHFMzahF/r47KfpkjDaV7By+uvNX4ksxk5d5EFPyjmewkgFjT7cW/DI5U0U/EA
         2mvdi4wUoHg/UaMjipYH+TJ41BXd/kQep5wEnPEJMtDLn170b7AuKYmnfQS9s7+zFNkC
         JNIwCVMY2GRXvwl/4VQYkulZzY9RNb5NadsNcGGWNKxQ6HCIfVPME9PYwdrTI6ExjeNS
         KOVDtsiU/aKPztRWy7qGWKTmxBUnPsEjQGwh+E+pneHxFA7e8DyFpyMZlfXpRFdIA0Mt
         aPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716398366; x=1717003166;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vzLKAxCrEY7uDbqJTk5KgxKEAjbjo56US0UzpStrN5I=;
        b=wnBBwqSpNpIkPY+dx5faoHn43kNb193SlkoGs8OdIIr9QrH2TJSF3xpLt0esFYiPEq
         T/sXiUUeKnNs88YZrHX0MGxtDSNxHtVllRhY2xEN84J2g+PUknsJ3hdV1Jlv0gvwRb+Q
         aT7q50biNomQdtIVlDi826f3EgP/moEncaRlYg94zwjwZdSpGHZ7f5YQP2MhbSx+6MB3
         OUTeQiMvos1Ugs3u8J+tRf416814KsQm9Jy0oUgr0mLnPFq7435kQ38QFSw291Y362hA
         /l5DlgC0GJ2jO3VS5bkxPTmf+pBvoV5sgccfeEFxAq+EVHGPz0lKCfuxYWBOOsggT2BB
         6dZw==
X-Gm-Message-State: AOJu0YwSshkAOhvT1V7r5eH1AyQiaum+FfAneD14f3u/tGKe9Kt50sbI
	i/nIJijTr9xXNvuNJ1aJ935D3WJNMcZPEBgLf9wIsiJv20KDm4vV
X-Google-Smtp-Source: AGHT+IFlnYrwrKPdvzZxkcmsBxHGNfOp7Xz73D7996DbYJkxd+/HSf7AkNqOtqlO/xuzdLl4NMq1Vg==
X-Received: by 2002:a05:600c:5756:b0:420:16b2:67f4 with SMTP id 5b1f17b1804b1-420fd2fc8f0mr22561705e9.12.1716398365455;
        Wed, 22 May 2024 10:19:25 -0700 (PDT)
Received: from gmail.com (133.red-88-14-54.dynamicip.rima-tde.net. [88.14.54.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f5a576sm453225e9.22.2024.05.22.10.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 10:19:25 -0700 (PDT)
Message-ID: <501a610c-550f-45da-a311-d4c941ae4870@gmail.com>
Date: Wed, 22 May 2024 19:19:08 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] pager: do not close fd 2 unnecessarily
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <80f15223-246e-4cfb-a139-e47af829c938@gmail.com> <xmqqo790fg8z.fsf@gitster.g>
 <a9f199d8-bb06-479f-88c2-63d80338a4e9@gmail.com> <xmqqwmnm993k.fsf@gitster.g>
 <0574914d-8088-434d-8db2-013c1abe27c3@gmail.com> <xmqqikz6966t.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqikz6966t.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, May 21, 2024 at 03:00:10PM -0700, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> > Adding logic to adjust when we close(stderr) in close_pager_fds() makes
> > sense on its own, I think.
> 
> The feature may be.
> 
> > And, the values for the flag "do-we-want-to-close-stderr-at-exit", too,
> > to me.
> 
> But the thing is, the flag is *NOT* named as such, and an
> undocumented "value -1 means X, while value 1 means Y", do not make
> any sense, either

Perhaps this makes more sense?:

1:  8fe915a820 ! 1:  70cc34efc4 pager: do not close fd 2 unnecessarily
    @@ pager.c: int pager_use_color = 1;
      
      static struct child_process pager_process;
      static const char *pager_program;
    -+static int old_fd2 = -1;
    ++static int old_fd2;
      
      /* Is the value coming back from term_columns() just a guess? */
      static int term_columns_guessed;
    @@ pager.c: static void close_pager_fds(void)
      	/* signal EOF to pager */
      	close(1);
     -	close(2);
    -+	if (old_fd2 != -1)
    ++	if (old_fd2)
     +		close(2);
      }

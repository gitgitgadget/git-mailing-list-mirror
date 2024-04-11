Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1982E3D969
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 21:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712870645; cv=none; b=TUlmMkr066cRXdhd3MgFzRB3yDUA55hVTy+Q2VoBEQYw8d9h6U2JcNlshk0gT6XCK8YohEWBjASQY1LjfOeF0chQ0LLRDrAVSQdt/2S/mXrbH6Z6CdZCpsB/U00LYCBNx7ZCeOFEQSv09+MNDxibI9HYTrIDdgKdIvRC+BWYAF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712870645; c=relaxed/simple;
	bh=tpdNCNOUIBaA7K3u0SG3NCRHIf3iZb8Zu8gEKMaikkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZ0tjwpFVkkg41x3sv4UCSnoc4qfct/AhSHl+AxhQ+xsVAM0ajRPigP2NNR3osDoGovyhMh2WP7D2bxftGKlaNpNj9wZyZ9FkgUiOVZSW5hn8yPAe3Urxu/JUmCopr4sn2kbCDlh8j5GDTWwpuwlH/WwsmvOVefPELEKXHtD87k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JV03P48r; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JV03P48r"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6ea1f98f3b9so166066a34.1
        for <git@vger.kernel.org>; Thu, 11 Apr 2024 14:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712870642; x=1713475442; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mjb1+C5fr3/gM8/7puo6PR9/fpswTy5FsZIPqPOJQCI=;
        b=JV03P48rF72gQn+o6n/BgjVCctM4vqdKZTc/v15Fd7wUEi5luA/VCQsX8TCdcW5g9O
         ZMHob21G+KzsMEepaOOlZbs2rYJEr6iPomwi4fRS6EC9ISL7dfAyLsRtR7IQjO7fQLID
         43L1AJ6NAfWepVTQ3AnffCYX22PfaU+1EjHv/KeFroF43Vovx/fpyX18dJIWxfbkvWfC
         lNiVrNQYGqMn83sAojSmb2K7zRXxENE0S9o/ixmkG9gZ4vXCJY5G8iYMagcifCJqR3qg
         3+4GGt8O3qqrAvj9uCxXrW21L1iEBY5YDEY4Z8ohp//DsqZpxMB/IqYe+hz/WcJLrPlf
         phcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712870642; x=1713475442;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mjb1+C5fr3/gM8/7puo6PR9/fpswTy5FsZIPqPOJQCI=;
        b=HYWTJ1v8ek/3/E4jR6C1G/0OV4dS5iqBXewhEEkQFB3l92+7FMT0e2ZQ5oeI4BLDFc
         /4hIV7fHxv/hGvSiUXngKJRjKdU69hVtBFNXIKb4BcRnCx4dFyhjS5u2vXCFtUp8dJxT
         NSDarz1WH3C1qeJ80Wxp9RbQhgNS5WbdYQyF8fdP2X0uUD2/n8Hd/Vdx41EvQcwG+F0Y
         FZoFpWPkCo1wJzPtCJRI3/EMA4ulqWaDAYQGEJ7dRyVyxFvWe1aESVkTBzEWljGRwOte
         7wHEdGXdR64scBEejcantVqsZSha43YwdLZ36dTYzh3nqRR7dRdphYdB5FqdvomPUXAN
         p2Xg==
X-Gm-Message-State: AOJu0YwvF7Vs/ifuJiCcN98JsQVdJ6eqtbYE19qMY+mpM3mIDBR4ycF/
	3NrVtCVM9yxSkifRw5KJLOGJPO8SX+syO+fmRpJ6G+VDSjkjspoP2dYCjMNgvdJxSWHup/260q+
	Xtg==
X-Google-Smtp-Source: AGHT+IF6QAFZpS40AzKt7LWcialHNN/bnAiurHpBePHxC+gKX6PrmfsOY2ykAmtzLlqYXlY1hBpS5A==
X-Received: by 2002:a05:6870:9d15:b0:22e:92b1:5697 with SMTP id pp21-20020a0568709d1500b0022e92b15697mr787760oab.6.1712870642104;
        Thu, 11 Apr 2024 14:24:02 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:5d8a:5a85:8673:4f76])
        by smtp.gmail.com with ESMTPSA id gm7-20020a056a00640700b006ecfdcc2de9sm1674495pfb.10.2024.04.11.14.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 14:24:01 -0700 (PDT)
Date: Thu, 11 Apr 2024 14:23:57 -0700
From: Josh Steadmon <steadmon@google.com>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: Re: [RFC][PATCH] t-prio-queue: simplify using compound literals
Message-ID: <ZhhU7YBY6brbyZDm@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>
References: <520da361-1b80-4ba3-87b2-86d6fdfc18b5@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <520da361-1b80-4ba3-87b2-86d6fdfc18b5@web.de>

On 2024.04.02 20:30, René Scharfe wrote:
> Test names like "basic" are mentioned seven times in the code (ignoring
> case): Twice when defining the input and result macros, thrice when
> defining the test function, and twice again when calling it.  Reduce
> that to a single time by using compound literals to pass the input and
> result arrays via TEST_INPUT to test_prio_queue().
> 
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
> C99 added compound literals.  Are we ready to use them?
> 
> Test definitions become more compact, but look busier due to the added
> punctuation.  We could hide some of it with a sugary macro like this:
> #define INT_ARRAY(...) ((int []){ __VA_ARGS__ })

I definitely like this approach. Reading the original test involved a
lot of jumping around to see which TEST() checked which set of
arguments, now they're all right there in the TEST() call.

Agreed that an INT_ARRAY macro or similar would make it look a bit
nicer, but even without that I think this is a good improvement.

I am in favor of expanding our C99 usage, and ISTM that a unit test is a
friendlier test balloon than production code (although perhaps one that
is easier to miss).

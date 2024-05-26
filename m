Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980941A2C18
	for <git@vger.kernel.org>; Sun, 26 May 2024 06:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716706147; cv=none; b=ItVEIKWCiAZPA+YXZ6+Cwyy7N5fu/RDAbGuk5XwT10f1M0dyvuHkmAAud1WBxp+R8ktG1+MFcdDlNs5BcmXwYUwlJwXXs+FtaK/kB/SIaHxIFWSoQUqpdxbxJWJ5D+oK0ugsH8K7M1/G0W0/23hh2bVc83xhpUqtH2UoGT/sTlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716706147; c=relaxed/simple;
	bh=i6N2eP5ZiW763d3n/cMNrqSU+zUllDWUJi8Fya1UWTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mQ3owNkBcvKnsv4NL3fAggAQqWnFb0rDc5PZ0Q2Ht5c/TS7ENN7y/H/yU05RmDZF43o2MmDyGShi2hIJO3rywyTnGE6shWeeHIWhb3/7p+GsEuyEg5FQ8cGzHCgkLHRdT27Jzk2IsAKClg7LVNB63U+iOgIuKZo1YtFG3hQU5h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bLjVa5EU; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLjVa5EU"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-354f51ac110so3995737f8f.0
        for <git@vger.kernel.org>; Sat, 25 May 2024 23:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716706144; x=1717310944; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NSvTbbBxUA47hVVVZaAYMwiS2DGflIF/qK9YtNIov3Q=;
        b=bLjVa5EUN1SSwma4GyrLtaFMkKPVPPqZnFv04m1a/JJ+Mmvni5nLfvFP+1pt68pbhp
         HHsSt61vMUPHxCiFf7fz4aIJueRt1Q/ZN6jZQe0YAf6D/WxWtjsrqZ+UV5RiDFVc3g9r
         66EkstyxeG8VHPdGnJFicJ5E4TMtIH1h4elby2b9Mh06LIiZQk9cPzdefgdhgfOXGkbB
         zaoBCApdK/mAhimdTeY3DQFlQxg6BxFJRH2LvHbbHTRcQN9XhQ1FfhlINrEiUG6ynuaX
         Owuku9ZfA0wVXK6P97F8rQn42ePpU/pb5UinQgmYuDXaDuqKmBxaaXt/31Hr7PvQxkCX
         deeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716706144; x=1717310944;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NSvTbbBxUA47hVVVZaAYMwiS2DGflIF/qK9YtNIov3Q=;
        b=fi6Z+dxKTcnuPwmWHKZ6K0tx2rQ1TwIeh6zIYwLFyv/jmmFMDgk1DXoBbzZN+u8SDl
         5RqB04RA9F3vLzu7j6zMD6ZHbofY0Fd6V8tvlmj7R+Le2A1ncLs4zKc+uxWRMnOvxEmX
         LfrbA4Cl781Ox9CBG8Sl6hRq/DgnmXqvpUFD4YXnoEOflxqxb9fFO3xzDtFJqoa6CORl
         XYJWfrtlLq8Gw5mxDbpAQAg9YNevo0exHWi/xBl4j/WTUCNFhUTGlercF5s5MYicwMkU
         TVVLnYXTTBqBLMRDH2JkahG1R23msHQe0ecNSuK8ub1gG4PkuxkenfA4wg3u6Cb+S6QA
         7m9Q==
X-Gm-Message-State: AOJu0YzqTfjuqktrIfuTdHX2tFahSdXt+8tw13qijcq7W296lDpfweka
	Hze+BKMGbGwvHeJ41w1pLiRp2SFQdBAsAtVKz9zPNaJeSoR/OxHC
X-Google-Smtp-Source: AGHT+IGHIV7N5pUbGkZSrLNIdU/w3Mc2Ujs0i97rgb6zBjqCwpyT+oKCYg4zLu8atlTptfX5VvI+0g==
X-Received: by 2002:a05:6000:1742:b0:34f:41e7:eb37 with SMTP id ffacd0b85a97d-3552fda7295mr5026288f8f.30.1716706143718;
        Sat, 25 May 2024 23:49:03 -0700 (PDT)
Received: from gmail.com (227.red-88-14-54.dynamicip.rima-tde.net. [88.14.54.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-357250e7fb3sm3072265f8f.0.2024.05.25.23.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 May 2024 23:49:03 -0700 (PDT)
Message-ID: <e6c4dc8f-ffbf-4749-8086-22c29da768a7@gmail.com>
Date: Sun, 26 May 2024 08:48:55 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] pager: do not close fd 2 unnecessarily
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <80f15223-246e-4cfb-a139-e47af829c938@gmail.com> <xmqqo790fg8z.fsf@gitster.g>
 <a9f199d8-bb06-479f-88c2-63d80338a4e9@gmail.com> <xmqqwmnm993k.fsf@gitster.g>
 <0574914d-8088-434d-8db2-013c1abe27c3@gmail.com> <xmqqikz6966t.fsf@gitster.g>
 <501a610c-550f-45da-a311-d4c941ae4870@gmail.com> <xmqqa5kh68zh.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqqa5kh68zh.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Wed, May 22, 2024 at 10:40:18AM -0700, Junio C Hamano wrote:

> Not really.  The name "old_fd2" strongly implies "where did fd#2
> come from?" and it did not come from fd#0, did it?

Perhaps "close_fd2" is a better name?:

@@ pager.c: int pager_use_color = 1;
  
  static struct child_process pager_process;
  static const char *pager_program;
-+static int old_fd2 = -1;
++static int close_fd2;
  
  /* Is the value coming back from term_columns() just a guess? */
  static int term_columns_guessed;

@@ pager.c: static void close_pager_fds(void)
  	/* signal EOF to pager */
  	close(1);
 -	close(2);
-+	if (old_fd2 != -1)
++	if (close_fd2)
 +		close(2);
  }

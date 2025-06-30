Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6703222126A
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751300624; cv=none; b=AfBq3NmgIaQ6kJHSyu6kMePvedw1iiylFR353a7WiADLsN1iOCxfMoR1Z8o1G7LJw3KKXqO0EmuRJ4V47j6/0Cxu8mOpFTIbM56HavAM0w/SyxvxP7LwrTrrkmCBMz/vzNFw7DKQQORG4kXMGXE4vmBvGRoVM4Qq8/21mNGz+Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751300624; c=relaxed/simple;
	bh=f2HMvxlWxN33V7JIrPcXZUljqlc4/neVmKpvrVllToI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ua15WzMBqqC0dOB73zbsovfgR5cYccEMDqSCjhL+BTfxOZ1Y+xzxuWgJyOJyHgGeS1Km3zh1zZwJrAZoFFTFy1Ku+lnFg5LBub4vbXlflreOdwk6B0ghpUmyAadgnYGSVGf03z/e1AOBCenKe7rIfvOD0jYx8icVzGqbsuv7aGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbxA0FQt; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbxA0FQt"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7481600130eso2947884b3a.3
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 09:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751300623; x=1751905423; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n0ohaCfgEVclJt49FIYu38d+7NyNnoTQdz3cimfIkt4=;
        b=lbxA0FQtHBaRTYj/2huE9mOrO5fWP/8gf+iQqZuj4rosiHcg+esZlVhH4FuEDYEuMq
         WTiTMJzXzYJTgdcm0ZqmKGm0aM7luDz09K6S81LH/o9/oYpyER0mhQkfZypKssFatr8/
         FdQg5dCF5dHDeSTV7kKVtPvZRPgYTG9GaXDyZu6Yfh5GGSW5e4+a0kEvYQw/sFkah2OK
         3+oWFpYXUwCnA2caJTZOtlV4VJ/qBH5/0YKljNn08M1QsPbM/tZeflDTvCBaPFxvE9ph
         3V0ZgYiwzZk9k885WMIdv+FstHNbDKPZEfhYS9ra5RhxiOM1aWXE/ByysH7YhkoyNGT4
         Kn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751300623; x=1751905423;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n0ohaCfgEVclJt49FIYu38d+7NyNnoTQdz3cimfIkt4=;
        b=kl2coAHR7CfhLCegLwECtQXIScXECA6udcbf/i0rH0gQfjT9dKh0UWWgNj3i+AFgdw
         nCEXJlcWCT8q1svwSyq4j4rWMsvizEFBNtdz4t9q4jMmtQBWRpRvywrIJ/rZORd/snxv
         pL2eaZJb/02jo3poD15UIeJURoJ0asbjlUHNbOgK8CMNeG3kU1ZpqLmnFV8Qls8oXEbG
         CcVpgzmBarFljuoxOr8g2jaGrpdKiXzGQ4kkxIZcXqw+hQv5ReQeTYeLYQegOy0Okf9e
         yG4zNeyz2HRqi7i/fLollLpDAucisL3YobjlseGhVimLxaziHXyr7s4ynw/NVv4jiHD8
         8H6Q==
X-Gm-Message-State: AOJu0Yw+crlFfqUzxvKpzIMJtCtaVPaXXvHqC1pV/7z2H4IiMSmN3LQx
	15Be5EbhA0jFM5RBonEgroIrRJXXVPUhDsDeXDZ+cQCcq4X8eY+6RcoIbS/UuA==
X-Gm-Gg: ASbGnctxFRzDI3/jBvK4GzojbCK+EhG0pKBqAhJBbd+Lh84tbp3vB32S9jWmDAhtKOy
	wXoFh0z+p1kLdlTEzuUD+DDNIxY3LBAK+YVAiyezL6L8X4QjObiFBYi9sIP5r4D7YtPrvFZM8bo
	UxaB+1qnjKNf3QOfqRKQ+RcPCNj9FyPGuiL0fxZt+VnyroqUh4/xy3UfOpHpeSX6xD0XuIXFJ87
	ivFtdStCrwSP3eelSNhZKE3lFVWmSypoUbYH3ncBQ1LNA7TpAxSlG6P3FTF9gnJis9Omufz6bZb
	aAHJ9L52oRzHls52JegstbtRrc0UeRfuaRec8n5MYRwPQpWQ+bOtrhwEquaMvsqcgodK+osIRoo
	0fksLjBGiutSxVmSeYoksoQhGk1s=
X-Google-Smtp-Source: AGHT+IFktuEFUoXoporsfk099erCg0Z/97oOFv7+7LLtX9TP3Hp15z7JT5FyX9wzE1hQcel1sQSa3Q==
X-Received: by 2002:a05:6a21:a44:b0:21f:53a9:b73a with SMTP id adf61e73a8af0-220a16c9babmr23275565637.39.1751300622619;
        Mon, 30 Jun 2025 09:23:42 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b34e31da845sm8346646a12.53.2025.06.30.09.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 09:23:42 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: "Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Christian Couder <christian.couder@gmail.com>,
  Phillip Wood <phillip.wood123@gmail.com>,  Leon Michalak
 <leonmichalak6@gmail.com>
Subject: Re: [PATCH v3 1/4] test: use "test_grep"
In-Reply-To: <044a93014b677914870a872a9c317a46a5a81699.1751128487.git.gitgitgadget@gmail.com>
	(Leon Michalak via GitGitGadget's message of "Sat, 28 Jun 2025
	16:34:43 +0000")
References: <pull.1915.v2.git.1746884789.gitgitgadget@gmail.com>
	<pull.1915.v3.git.1751128486.gitgitgadget@gmail.com>
	<044a93014b677914870a872a9c317a46a5a81699.1751128487.git.gitgitgadget@gmail.com>
Date: Mon, 30 Jun 2025 09:23:41 -0700
Message-ID: <xmqqplel2o6q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Leon Michalak <leonmichalak6@gmail.com>
>
> Use the modern "test_grep" test utility instead of regular "grep" which
> provides better debug information if tests fail.
>
> This is a prerequisite to the commits that follow which add to both test
> files.

Just a terminology thing, but we would phrase the last paragraph
more like

    As a preparatory clean-up, use the "test_grep" test utility
    instead of regular "grep" which provides better debug
    information if tests fail.

to avoid saying "This does X", "This commit is Y", etc.  It also
avoids giving a wrong impression by misusing the word "prerequisite"
which we almost always use for a step that cannot be skipped.  While
we add new tests to the same file, we _could_ leave these existing
tests as-is, but there is a good reason to making this change
beforehand, which we often call is a "preparatory clean-up".

> @@ -86,7 +86,7 @@ test_expect_success 'revert works (initial)' '
>  	git add file &&
>  	test_write_lines r 1 | git add -i &&
>  	git ls-files >output &&
> -	! grep . output
> +	test_grep ! . output
>  '

Good (we sometime see people got the negation wrong).

Thanks.

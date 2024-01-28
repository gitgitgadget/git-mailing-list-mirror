Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0B26117
	for <git@vger.kernel.org>; Sun, 28 Jan 2024 05:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706418083; cv=none; b=ssuSqnPFIyqb1plOO6tStelMopP9VBFKRbdB95Pr7cJ9Gt3C+FBaI5VFboywiRTEdj7TPRSYrx4SDwAx/NkPyvvDj1GwkhbHZVcILJg9mUdc2WZdZsaatbl4hKINXVL5lBCrTcDYrT7W/APHYMLmLfS9tMYdyWxHrCCgl6l3tSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706418083; c=relaxed/simple;
	bh=q/e/O3vqboL3ZsNdAupCCpLr6E3e4rHhssSjHaj4jbA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FoVWpeASynsAuf8oFHz7aXRbTovUDYKb7FWu+JA/mgdLvAqdF3Qo9mzOvggUHjAO4SmlvHtDWquoDE7V5pUA5niGjGY64KXaHSWAQrVVtwCY4jW40DyRY5V66G4pFieGvk9WV7pvUrJO1yqJpb4+b5yzdGLoDyfxg3yifcUeKPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0N0JqJpP; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0N0JqJpP"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5d43d0d6024so1064302a12.3
        for <git@vger.kernel.org>; Sat, 27 Jan 2024 21:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706418081; x=1707022881; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L0nG8KF8Sps1dhTXE4spjBxeNFB3H3AgTticXP5D+6M=;
        b=0N0JqJpPHNKWN6WE1y/eyVf08KuGvF7fXf5s1UyyAn3Z+JE7w0ngVjuryV8YJZ43Ip
         WXkbrQ2WPHE7IL9hDdYUsIFHqfdwp85tPT1Os+JFSHOuyCzltl0EFBHL8bhBHbLupVJq
         fw6MXmHvdRMVqpAFhIIKA/kOjcbZqHkakufX8EEBBS83qKHZIVDNC4zL1XWyt5muirPj
         7sZnHNkctm+JFFYU2XDbm2Hq3IkAbYapZ+bzlQMlHstDxVmLhyRtlaus1FqsD/EzeF1F
         CHCTyXvga0iWRqTFs5GZjAqT/tW3uxVNMfSXmsv39m/nDGCR3MHDjGCKlI1yJk5eBnf7
         a+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706418081; x=1707022881;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L0nG8KF8Sps1dhTXE4spjBxeNFB3H3AgTticXP5D+6M=;
        b=ggnQ5zZbouDjHyRAJg4bvVwVMbgoMx9OSWDaEwsCDx2TUD1UGbYqIDqVFIAcc0Ny5f
         HFuD0f4U+JPhcBsBGn7FVIQFhF85w8XMDcivE88s3p6vDQOz5w7LISTITucLlSUsdooJ
         4QtveID/ndsoWVm0NiePD9Wh2r0swTOoMdj5inG9CmMNS72olVYRI/9qVOR3c3TqYov8
         w7IIBMlAoDzI7ZwLYRzVDABgsMnUHbRZ8775B3rOUse81LwRuUEFkki6FhoAJEOQl1o/
         lBInrcAt7eAQGCS0ad1de3WLAsni949qeKLUIFDj8P4JmtRJ3VsEJYzA6CzItuwkAmyf
         qKSg==
X-Gm-Message-State: AOJu0Yzn/1nJnllOoSp+cBQ+MB+M8l7/Y2A5bJflOq6BY/VB5v3aciNl
	AyiQTb935v7Dqwqi6JXh/HATes24Sph5WmbnypHCGOP0B042BJTH1j+gLajCYb8OB+v5/+ISTNm
	fCQ==
X-Google-Smtp-Source: AGHT+IHiXsoCi6kSW9YkZ3WIKBmJtrJY9DPte6ElQrK8Zxb6Jnwp4eQLWHZCxkB1H33rPzNC+yR1r3RwE/o=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:90a:928c:b0:28d:bc32:ffc with SMTP id
 n12-20020a17090a928c00b0028dbc320ffcmr19868pjo.6.1706418081015; Sat, 27 Jan
 2024 21:01:21 -0800 (PST)
Date: Sat, 27 Jan 2024 21:01:19 -0800
In-Reply-To: <1b4bdde65bcb375ce9ef2345814330df92e6d932.1706308737.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
 <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com> <1b4bdde65bcb375ce9ef2345814330df92e6d932.1706308737.git.gitgitgadget@gmail.com>
Message-ID: <owlyh6iy2grk.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 09/10] trailer: move arg handling to interpret-trailers.c
From: Linus Arver <linusa@google.com>
To: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>, Junio C Hamano <gitster@pobox.com>, 
	Emily Shaffer <nasamuffin@google.com>, Josh Steadmon <steadmon@google.com>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/trailer.h b/trailer.h
> index c6aa96dd6be..e01437160cf 100644
> --- a/trailer.h
> +++ b/trailer.h
> @@ -46,9 +46,20 @@ struct new_trailer_item {
>  	enum trailer_if_missing if_missing;
>  };
>
> +void trailer_conf_set(enum trailer_where where,
> +		      enum trailer_if_exists if_exists,
> +		      enum trailer_if_missing if_missing,
> +		      struct trailer_conf *conf);
> +
> +struct trailer_conf *new_trailer_conf(void);
>  void duplicate_trailer_conf(struct trailer_conf *dst,
>  			    const struct trailer_conf *src);
>
> +const char *default_separators(void);
> +
> +void add_arg_item(char *tok, char *val, const struct trailer_conf *conf,
> +		  struct list_head *arg_head);

Looks like I forgot to add a "trailer" keyword for these API functions.
Will rename to "trailer_default_separators()" and
"trailer_add_arg_item()" in next reroll.

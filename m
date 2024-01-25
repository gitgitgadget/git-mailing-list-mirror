Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73E179D9
	for <git@vger.kernel.org>; Thu, 25 Jan 2024 23:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706225955; cv=none; b=kmVX1WKr/J3LwOUhQn6CmZy/Tck8xvslbzEtOmr6YlZOv+GAIG1HMGkm0iefoe/fHIgRovF75dh1i5QjOOUGKgAHL3JYl6a5JodTCovEIOt1lYTjeTyANgDBXJl8Qn7COChV01SjUiQSqi7s1Wi+bFNtiBDcS1wCuDktVRJvT2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706225955; c=relaxed/simple;
	bh=+rYNq6otzCf/79NfITYwGFU8nPEzlM09VgnZ4hIc8Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9nkhJdFNPnGuQgoDiRW/bjZDJOfG7mcKe+GuEL8+XwvClhKc6wYrqhsG7FeW5e9pdqXqkgcqdjKOWO7eeXuix2WMlJCJaDJFyPWQt+VtjlHdh8219H+rmSm1kIKtFZYjfWEnBeUMZMcRXr0qd4m8wYfLs0HTEEiRpjvPkhXeQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ElI6EWu; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ElI6EWu"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d751bc0c15so47017745ad.2
        for <git@vger.kernel.org>; Thu, 25 Jan 2024 15:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706225953; x=1706830753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/dgfLqpbiroRpgYMuuYxKdX6Fzdii4ENPYf8uO7kkk=;
        b=3ElI6EWuKOmFGhXgn3QH/LSPR16PAr/QkHxcUy8v+z5AzChN1UIpUdSRaXiGpiitbq
         VfXTARiqa2Gg0gh0KeUPh3L5YqdBtm0S06JYAnq4HyjpZbzWD2+i1Trbanl4A6TVT9x5
         t/aypP331J8Eo+mgn4Stm5YL2qoyQBHh3eUBRVmOJaPUfr1sjlj6vWUo2V0Q7sX+5Ch4
         I4gBJiGh58+ajIEs9Z1mg9e9rihyNXoYNiqHkYMbbzK7SmbPvRdH3+AHbfncbUI/PRAz
         A/cghE6HzeOudQALXRXmnY0rKlWfxmHqGPda3zOMr38+J0PHuopoNHBUa176rqxIzHHL
         GM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706225953; x=1706830753;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g/dgfLqpbiroRpgYMuuYxKdX6Fzdii4ENPYf8uO7kkk=;
        b=l5R2wXvLqEqfOtJ+eUm4RLwyuSLjt3G5A7bszUK3WS+AEbA02dPvWwnjs9r0xqPMkv
         HyyOqi79tQ2Vef31cmIa4jkz4smXWCyHftgc04XYaBrnz3CTfeWMIRMqu5H4jkVHKqtg
         fZQal1lBxt5P/TnKRTOLBz1bF4e/SOK0z8LbVvXQivxUgFs1H5sBb201KNJfWG4JL+Gg
         tDBl27Hwx9bUA5VwSB7miEZ71xuN5fz0oRRtlRhniB9ae2xw500UtHGS1ULzc73xnhO+
         DMj/WUYWTUab9Hal4aFgo5zVTc5sQSk6EjKO6SIdlYXiWI8PHo48VVOwfJ3dk7EZcGiJ
         70QQ==
X-Gm-Message-State: AOJu0Yzi0MpPtlDyOB3Kwmgo+dk44osr6fjjrVzqo8H7/MSVJCDwuEJ1
	tf88XNL1vuL0Y/d454V4W/95vhyQSEfnMKf4JrhEV3M1oN6hQEBIPBHYgLKyYw==
X-Google-Smtp-Source: AGHT+IECOwwXNsiCWZavPBPU774WPwIlH0Ov7QjdPbRON2fs27vz0HFnobKfhUD5orcfe5bqbNeCCQ==
X-Received: by 2002:a17:902:b10f:b0:1d5:7220:9ff with SMTP id q15-20020a170902b10f00b001d5722009ffmr480569plr.117.1706225952855;
        Thu, 25 Jan 2024 15:39:12 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:e113:1259:42a9:a0c8])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902a9c200b001d6ff1795aesm41501plr.8.2024.01.25.15.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 15:39:12 -0800 (PST)
Date: Thu, 25 Jan 2024 15:39:07 -0800
From: Josh Steadmon <steadmon@google.com>
To: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Linus Arver <linusa@google.com>
Subject: Re: [PATCH 08/10] trailer: prepare to move
 parse_trailers_from_command_line_args() to builtin
Message-ID: <ZbLxG8zVZAnrCQea@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Linus Arver <linusa@google.com>
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
 <406725df46a81f485d7a74c11488e625d3026dc5.1704869487.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <406725df46a81f485d7a74c11488e625d3026dc5.1704869487.git.gitgitgadget@gmail.com>

On 2024.01.10 06:51, Linus Arver via GitGitGadget wrote:
> From: Linus Arver <linusa@google.com>
> 
> Expose more functions in the trailer.h API, in preparation for moving
> out
> 
>     parse_trailers_from_command_line_args()
> 
> to interpret-trailer.c, because the trailer API should not be concerned
> with command line arguments (as it has nothing to do with trailers
> themselves). The interpret-trailers builtin is the only user of the
> above function.
> 
> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  trailer.c | 66 +++++++++++++++++++++++++++----------------------------
>  trailer.h | 10 +++++++++
>  2 files changed, 42 insertions(+), 34 deletions(-)
> 
> diff --git a/trailer.c b/trailer.c
> index 360e76376b8..e2d541372a3 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -33,7 +33,7 @@ struct trailer_block {
>  	size_t trailer_nr;
>  };
>  
> -struct conf_info {
> +struct trailer_conf {

Can you also add a note about this conf_info -> trailer_conf rename? I
agree that it's an improvement but I think it should be mentioned in the
commit message.

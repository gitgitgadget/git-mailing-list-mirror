Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BF1291864
	for <git@vger.kernel.org>; Fri,  9 May 2025 13:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746796128; cv=none; b=iv3fCiZ2UDEUv2FKGPfu+OMHyOjAQuEEBHxhthh0XYBRow6TZ6+ga3YtZYUhS9w59Yx3Ddl7CpQ45b1xSNiHnDjPtABBulaQNuB2xRR+8Rg6S6dHz6kyjjGzxJTtT2gingDQOVw/d0HaZ6QjvqNcYrdlhPZpIntQnJWmTQilGv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746796128; c=relaxed/simple;
	bh=sKNZN+3blbNuj1imp1GyEzUFZGyukX9mAsP6dnCCeEg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BkhftYCzZvZ/Ese0Uw7khfc9XzITOQCkHK8uZpycQGJtCR5Y/B+lwNOi6qyIIy66c0vhbg2a45JZHjarpxrNbx1TxiDTfkKqsCmmijobdGQ+rlBnuqZ2oDkTS25uBJ+cGUBwBx/DZbo+FOT+g+aEoawSkn495f+XmKaONiFuw/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCm4ZJbV; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCm4ZJbV"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a0b637db6eso1261181f8f.0
        for <git@vger.kernel.org>; Fri, 09 May 2025 06:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746796124; x=1747400924; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pFl0Cnifpz0tSnoh/x92ld2jLHlwPY0iaYmfU0M8wK8=;
        b=dCm4ZJbViSE0/ZILzbmEB7o+Ad7mEazqn+ZpMhGpP2uaTdUnn+anZNnbsaTofKHKJY
         0wWsRWGDlr4pCGPn4bvYhtdTAn+2bmKgDeKVqNjOQ+LGc7j45X2vBogriD30n1O6qQxU
         mxEd9TL0UCl/8o+yp6b9GTXrx3mE+wd4tfsodp1K+PB5/XiaqMMZgp49JiyUlbSrG/SL
         mvijFSLamvvEcf/AAssrSUxnGhFfi02rUCu7FM8pLyKXEtR+KDnARGCJG8PY47Nycz/B
         /J0v8MvR8yl8O7HHOkDKwQ4QPsGU4GvCK9lS4CdODLlN+U6rEzitIQt/7wkYhg4qWIZv
         I2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746796124; x=1747400924;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pFl0Cnifpz0tSnoh/x92ld2jLHlwPY0iaYmfU0M8wK8=;
        b=SFs8auW6rcHEkvPJvf1cD7bbjJP9+qXYvC1//4w1iq23B9DfEaL364yPh/wdsIkq3L
         jEenZTUa3pjvsA8Z2XNf8V1jFHIjmGgx+/lX1BL6cvkBRAmMNv3Jg2+a/i6X7NgjtGO+
         e5SmcUdObwgWqvn/Sz070QFXHTDWufWrObs9gLCoJrR+MqJAufI03AO7OdRRJaKFFWAs
         xNoc1khILl2omPDpQtzK00OjOxjobJahSwyBWz+AueLO+4/UzsZyPIr8OB7u324lJ2mC
         8NcWJXaIl8nJFPjQ380to4Ic+djZ+HAkd36aNELGeqAjdzZjZMUv/CRPV2wtQBli65T1
         ca3Q==
X-Gm-Message-State: AOJu0YxPHnAf6XL5DgSqPbboIIsnHzP4ZVHiH3KZYfB2BDys+TtIEBbY
	YeVBzp2nE8AYTJqun2zON0IjHj/qIvaavWqPFkStpr9nt4cOnA2pV0qdcg==
X-Gm-Gg: ASbGnctKyDyCNqXhQaj5S6G6m44DTU+eC8W0r03cOyzZtTeMIOcwaXrBTfBTEZSKfuh
	LXVL5UVBeZpDQC00htD0BexCLJQbSjB7v118pDbYsqlpBsU4HuScofULYBjgGjOlsjV9ZRObldd
	prbrAJlMElvU9p5vUUfeG7+9TvzwkdOdwVzq7Ac07p9GjTtAnOZFoZuBvD2L+RTk0Iz0gVDMam8
	2UB/kmLuB+nrV4H8cbv7DRX52ITI5KtrvTB+GmNQMCzENDG71Eb+NAMEq1ZON+XAcBiAxMH3psz
	tfofyA8L+e4DY9oVAYRV81LoPGKy9KyBNPwIcU4CGxXbncA0hl2uieL+EZOeqxscOkl6dQo9baW
	b1G8wqvAZc7wx2Yej
X-Google-Smtp-Source: AGHT+IFQtd8LIIqLO84foGkKP2gr5floSZz69mhQF/BRJvTRsPzfS/Z6chxOpEMKcA35LXwLKEiG1Q==
X-Received: by 2002:a05:6000:2289:b0:390:e158:a1b8 with SMTP id ffacd0b85a97d-3a1f647fccemr2064151f8f.43.1746796123395;
        Fri, 09 May 2025 06:08:43 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:3cd0:e939:e6b:f95c? ([2a0a:ef40:700:a501:3cd0:e939:e6b:f95c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4d0dbsm3151056f8f.88.2025.05.09.06.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 06:08:43 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phil@crinan.ddns.net>
Message-ID: <ac89ba0a-b50e-469c-99ce-c70b825ae4af@crinan.ddns.net>
Date: Fri, 9 May 2025 14:08:52 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] parse-options: fix xstrdup leak in parse_options_step
 parse-options:984
To: Patrick Steinhardt <ps@pks.im>,
 Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Lidong Yan <502024330056@smail.nju.edu.cn>
References: <pull.1954.git.git.1746585203.gitgitgadget@gmail.com>
 <pull.1954.v2.git.git.1746624294017.gitgitgadget@gmail.com>
 <aB2ejA1tCK9DR1Nq@pks.im>
Content-Language: en-US
In-Reply-To: <aB2ejA1tCK9DR1Nq@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/05/2025 07:19, Patrick Steinhardt wrote:
> 
> All of that starts to become kind of involved though. So unless others
> disagree with my analysis I just don't think this edge case really is
> worth the complexity.

I agree with this. We seem to be copying the string because argv is a
const char** but would it really be so bad to modify the string that
gets passed to us? We know that any bundled options that come before
an unknown option cannot have a value or else what we see as the
unknown option would be part of that value. So I think we could do


diff --git a/parse-options.c b/parse-options.c
index 35fbb3b0d6..9e6e46da27 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -924,12 +924,12 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
                                          if (internal_help && *ctx->opt == 'h')
                                                  goto show_usage;

-                                        /* fake a short option thing to hide the fact that we may have
+                                        /* move a short option thing to hide the fact that we may have
                                           * started to parse aggregated stuff
-                                         *
-                                         * This is leaky, too bad.
                                           */
-                                        ctx->argv[0] = xstrdup(ctx->opt - 1);
+                                        MOVE_ARRAY((char *)arg, ctx->opt - 1,
+                                                   strlen(ctx->opt) + 2);
+                                        ctx->argv[0] = arg;
                                          *(char *)ctx->argv[0] = '-';
                                          goto unknown;
                                  case PARSE_OPT_NON_OPTION:

Best Wishes

Phillip


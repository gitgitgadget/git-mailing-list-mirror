Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3E1380
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 03:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711684593; cv=none; b=VC7e0AAXYsBUcWUeOn+7jSDpEiE1D0VScsz93PO5vyWAjVJ5k+8erRa3cKBcTg+lyNMWxcw6drnsjpOe/Z4eyZR/6N3TQK65anID15gaGDxQ1OQTt4+JaKHR3WfRb7M7duKUYow2Sl0YS6DMN7VWkqobwHxIq0XKVyH8HoklYwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711684593; c=relaxed/simple;
	bh=56FC8zsjiXLHR9KtakbnnndzJRBJ9gK1zk2PNeF6Cf0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hcbKAVNDFWq2YAcf0mSvsnBUR1RpRX54SLBVCS++N/YI7VvZjSXNY7OYkmzC1UVPNisUIPPU8XFEDJu1P0xcuBE7U3MJcZskXXm1mfvyYNeBfAfyVDkzy6jol3ebI8m1ZVxkBDbTJBvlhDlLLoJ/g/TVtECzM8cXFeHZ8cGAhNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1UlsI0u; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1UlsI0u"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-341cf77b86bso1046077f8f.2
        for <git@vger.kernel.org>; Thu, 28 Mar 2024 20:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711684590; x=1712289390; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=209sb07kT4VtkYJD4Kx3a+OTEpCUYg2s7QgC9oucg5U=;
        b=g1UlsI0u7YVxTd0aE6+DP99ecshDGffp22q0FuIdSSpfY76JEMTAoxPYl+Lp0z6tpP
         vNxvJBaqYKN5oe3LVSBS0qE1zY/C3k+gmDBos0cUedBmawVz+MI2QP6u82I1yOWu+HJI
         e1AX/Ds6Xjr4KB3AOFV/6fZBZW/Snm1MgrFyhb1MRXsU7atQWWlYo6206vK03EAsoEz5
         U6Z8T8Iunp+2yWiP1sHv63SiIjRDVi+YzK/v1onA881Y6NdDQTSj1fZcn2iGc5rvk/QA
         6Pw1IYkyCB9RgTTjSXl2qx0lfr3b/tNuQ4ANvSA6D+q8P5Q3I+TW3MOLRqKhQHJali2I
         NuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711684590; x=1712289390;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=209sb07kT4VtkYJD4Kx3a+OTEpCUYg2s7QgC9oucg5U=;
        b=umNflLLpf8y1SSjg3z/RHy7GJ15A8NVdvD0CYKtCLBhknEtv/lciBG0KlNSefhCS/4
         VoOZ2CPS3Ort4+hS0aSeohmla4v+1j2P29Yi54R/3TZKttc+EuYx7WBjfhAdjBuqLari
         TMsnRRR1yRlJWgYxoU++3dcFW1X1qRmyNNiIIeTYUwc5Hh1BuveO0L0USqaykaqvWn19
         1eddjywhz7MP+GnpkKWypGR42R9qUM6kzRv0CcFQdnJ11bNCO7fcREW2tp8eLetMqX9V
         nAGZPc2t8LzxyjtF5zoTdaZD+Q0ZAEvMMcHzYbj4g/yOCJT89AoC+U00lfdqcKI9DTJt
         79EQ==
X-Gm-Message-State: AOJu0YwXi+M2zQ55oK9cxAqYhAhjunLiGC+5kNx1nw1PAAiyk/e0mzuD
	EmPQsclaxJ+YKAmQ89E/BuU6/9ZO0vZ9BAUc1TJOg+F9/jWieH3MNX1m+XMo
X-Google-Smtp-Source: AGHT+IFKMEjiTYWpXDTH0zEcchTQN5NBE/03/5CnHTK2WEnWJNiVfQg6mkX7joWKRkr9C91HAQmYzw==
X-Received: by 2002:a5d:6a8b:0:b0:341:c000:5f02 with SMTP id s11-20020a5d6a8b000000b00341c0005f02mr554494wru.7.1711684589777;
        Thu, 28 Mar 2024 20:56:29 -0700 (PDT)
Received: from gmail.com (220.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.220])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d59c3000000b00341cc9c1871sm3227096wry.0.2024.03.28.20.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 20:56:29 -0700 (PDT)
Message-ID: <a9c515fe-6664-4b5d-abca-d88fdd32a883@gmail.com>
Date: Fri, 29 Mar 2024 04:56:24 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 0/2] improve interactive-patch
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
 <6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
 <60d978d0-f69a-4b65-b4ba-d30dac8f112a@gmail.com>
Content-Language: en-US
In-Reply-To: <60d978d0-f69a-4b65-b4ba-d30dac8f112a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Let's reduce the verbosity in the interactive-patch process, in order to
make it less confusing.

Rubén Justo (2):
  add-patch: introduce 'p' in interactive-patch
  add-patch: do not print hunks repeatedly

 Documentation/git-add.txt  |  1 +
 add-patch.c                | 23 +++++++++++++++++------
 t/t3701-add-interactive.sh | 22 +++++++++++-----------
 3 files changed, 29 insertions(+), 17 deletions(-)

Range-diff against v3:
1:  545ca3f0b3 ! 1:  338f1ebc9e add-patch: introduce 'p' in interactive-patch
    @@ Documentation/git-add.txt: patch::
             K - leave this hunk undecided, see previous hunk
             s - split the current hunk into smaller hunks
             e - manually edit the current hunk
    -+       p - print the current hunk again
    ++       p - print the current hunk
             ? - print help
      +
      After deciding the fate for all hunks, if there is any hunk
    @@ add-patch.c: N_("j - leave this hunk undecided, see next undecided hunk\n"
         "/ - search for a hunk matching the given regex\n"
         "s - split the current hunk into smaller hunks\n"
         "e - manually edit the current hunk\n"
    -+   "p - print the current hunk again\n"
    ++   "p - print the current hunk\n"
         "? - print help\n");
      
      static int patch_update_file(struct add_p_state *s,
2:  b6b98e5dbb ! 2:  e17b8d70f1 add-patch: do not print hunks repeatedly
    @@ add-patch.c: static int patch_update_file(struct add_p_state *s,
      				permitted |= ALLOW_GOTO_PREVIOUS_UNDECIDED_HUNK;
      				strbuf_addstr(&s->buf, ",k");
     @@ add-patch.c: static int patch_update_file(struct add_p_state *s,
    - 			if (!(permitted & ALLOW_SPLIT))
    + 			hunk_index = i;
    + 		} else if (s->answer.buf[0] == 's') {
    + 			size_t splittable_into = hunk->splittable_into;
    +-			if (!(permitted & ALLOW_SPLIT))
    ++			if (!(permitted & ALLOW_SPLIT)) {
      				err(s, _("Sorry, cannot split this hunk"));
    - 			else if (!split_hunk(s, file_diff,
    +-			else if (!split_hunk(s, file_diff,
     -					     hunk - file_diff->hunk))
    ++			} else if (!split_hunk(s, file_diff,
     +					     hunk - file_diff->hunk)) {
      				color_fprintf_ln(stdout, s->s.header_color,
      						 _("Split into %d hunks."),
-- 
2.44.0.370.ge17b8d70f1

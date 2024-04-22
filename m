Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689BC18132E
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 22:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713826459; cv=none; b=okGhNSqC5PVq4KEyC+dyHsLvhL1Q5uUrlBXTlxsCy4I/4v6MB+HTVxezckrDiHx91t4cxG9k4hNPLy151BPYHFiw+EdxOqg4If7mYdFYKfbIWhOlEdxWJA5RabXPzK2lICwmkmvs4kPhJQZ6iLE140ChfDUTvtmdX9PMrGETt+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713826459; c=relaxed/simple;
	bh=VAooSrui6zEydVaUcelsxciCv+m+WLiivb/rSBMkiWE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=XRVRWuK7/owC2FJWoqUnkruG6lQfeo/jTN++AvmEvOZEjWl58EXESwqJ4L4NRywuW4G8LDHwqOlqiJnaHqwWPfkXZvp32RHzkrMDahJDgY+6FTZIY+6MoFMOp0WcPR+knhuYM7PRCN2FMoUPGsobz4eNHFBQZ9XUH/790qRFWBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtzbLab9; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtzbLab9"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41a77836fa6so9051075e9.2
        for <git@vger.kernel.org>; Mon, 22 Apr 2024 15:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713826456; x=1714431256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ekfKFOFw7YNc6a9IprhW4SfhR/ROfQIAqDZPjkahrA=;
        b=EtzbLab9LGKr6iv5tI6LrHaNlJsDAvkehyud5kn5QkKszyK4HWfq6icKO6eZMFi6+l
         w1z75pC0AV7S4PV7sBVX5xHTgRDzhz5pjJMP6naQ1mcvcOjuc0WQxSHjzr06K2HBA8t1
         F8BxnDxaAMLWB6z521zJjUyrzSJUH6sPCP6d/JyUlZ9hXI4/DZAq8AO5kl4oIm90jSeb
         xq+7ikRcexPmY1fyC8iJzctMuMi9g6d1235meK7IA6ZnQzcAHTbUy0nEjIlCYDxPzbv2
         rTxysbBF7YHDINcdcNeuV+/TsVBRFbim+CgV0e6b5/GbOYmuDg8mkMOljAyXopGWhhnH
         JQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713826456; x=1714431256;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ekfKFOFw7YNc6a9IprhW4SfhR/ROfQIAqDZPjkahrA=;
        b=xNbfyjVLJ5h/i2/2oLfyoQ54nWvzbBzDCqNUafv6oeG5ddrd9mObuucm01KvWiGQmj
         zYzdWyxecHeW0Pbj+mRcDTk/viwlDU5wev78QnXhjoBF7u2sxEaO52OaxvbIiQ5gksIV
         pP8uP/g7G0981ZNnsLi0v7Rix47xnzzOAxvFi2AkB080G35z0oyWcUD82ti0HUZve5Ap
         OrP3wAyTf+5tnLxasaxaHK67Ts6PqG5t0QniOBnbj62gKvVchM0i+xBmr9MaVkfWeB1e
         xmsFXn9hvPpLrSIW/1EImuV0eX1mfs2agReI4l5GngAY3IHShNAjyWmCNsYDbKMI84lh
         wMSg==
X-Gm-Message-State: AOJu0YwQWEXX+jwU8bL5FJkulo9ray2M8rg/ZjQAOnG9IwKBOpjMPsvC
	gyCM3xXIEM/dBUdphHSMqMCWYrf2hjeHyoaU/HhG7me+Vk3nYjZPlJMKNg==
X-Google-Smtp-Source: AGHT+IF7SB9t0GaKGFEBI3REMrUEAmSMwJ8p3QgSephbU+Q6pwYDonBKTtWK4kvRaPcb4od5XYTm+w==
X-Received: by 2002:a05:6000:ad1:b0:34b:66be:3199 with SMTP id di17-20020a0560000ad100b0034b66be3199mr656651wrb.62.1713826455818;
        Mon, 22 Apr 2024 15:54:15 -0700 (PDT)
Received: from gmail.com (247.red-88-14-44.dynamicip.rima-tde.net. [88.14.44.247])
        by smtp.gmail.com with ESMTPSA id y5-20020adfe6c5000000b003436cb45f7esm13016752wrm.90.2024.04.22.15.54.15
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 15:54:15 -0700 (PDT)
Message-ID: <f35a22a9-bbb1-491c-9f1f-e8c77f18fb9f@gmail.com>
Date: Tue, 23 Apr 2024 00:54:14 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 3/4] add-patch: plug a leak handling the '/' command
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <b7b2d0d2-245e-440f-a7cc-fa0df1ce73ad@gmail.com>
 <69f86760-96ff-4c62-9649-4627652b7c19@gmail.com>
Content-Language: en-US
In-Reply-To: <69f86760-96ff-4c62-9649-4627652b7c19@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Plug a leak we have since d6cf873340 (built-in add -p: implement the '/'
("search regex") command, 2019-12-13).

This leak can be triggered with:

    $ printf "A\n\nB\n" >file
    $ git add file && git commit -m file
    $ printf "AA\n\nBB\n" >file
    $ printf "s\n/ .\n" >lines
    $ git add -p <lines

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 add-patch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/add-patch.c b/add-patch.c
index a06dd18985..0997d4af73 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1646,6 +1646,7 @@ static int patch_update_file(struct add_p_state *s,
 				err(s, _("No hunk matches the given pattern"));
 				break;
 			}
+			regfree(&regex);
 			hunk_index = i;
 		} else if (s->answer.buf[0] == 's') {
 			size_t splittable_into = hunk->splittable_into;
-- 
2.45.0.rc0.4.gfff7e48949

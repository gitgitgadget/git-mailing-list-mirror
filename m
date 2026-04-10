Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DAE3446A7
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 19:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775848725; cv=none; b=BknoQ8DzN8exuZ9V1wxh13jCoSNPH1pgVqAv6AWgEBQesXxxV2NWF4VWHHAKDjL8aPJw0sPTDPcgW7DC57dYXctYmRXXMiQKJ1VTn1P1dTHBJJJrnmjF8Cflz6KeqezggKViZB+wzZzNiC6kPVqVYyuJ4x59syXf95bTlf8BAPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775848725; c=relaxed/simple;
	bh=m9hz5U+Qqv4EguwkSSeNa4/fdmVVQ6KIqQs7T273mOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IdDaz+iJag78jW79hd0YJ52sNT7BsgEGLN04cH8NKpBSfnN4SeDjbmWf46CHaDE2/BvQ9skDY4ZT8KtsY0Rp1UpaHHcuhwavk6Y1G8lAq+/U1GxDBN6mPch4UESmUTLX7FO3V4WFW3Pn375SzNaq40Td7OYLVJzn4Pi0nzNyafY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxBld/Qw; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxBld/Qw"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59dea72099eso2378782e87.0
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 12:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775848722; x=1776453522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ddZDfwdOGm89/KkKgDbKBdrqb5+fTjCTjDRLoH+PfM=;
        b=hxBld/Qw2Pj/K14iJyIB29tiPWORb9kfw6toFmFF8t5iil91Ehyep2mjND0ODhgOe7
         uD3vqJcdxV3oEM2ZYbD897dLMlhRWgk0f0CqwzJ1XUnt8+DRCSvqbM5IHLEodBhvgku0
         swltXcj4jccZ2g79iS1EHO3ildlrSzVbnhKap0tK5U5M/PJLVHfMIMM3qCmgyNw433Z2
         lx05xBrcMdXWbPd6Mb1FhF7iy5ve2Q9iV0JomOlxQba533rg4Mnj+amsDY2iesDlEdTU
         z8sbNggBxx6+V3WypRK19Nt4y4TzctEuD7fOfyWhCyxMtO+DMsgz/5dMtq34rcAQ5MG+
         g02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775848722; x=1776453522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7ddZDfwdOGm89/KkKgDbKBdrqb5+fTjCTjDRLoH+PfM=;
        b=osw5k/f8LLXqQt6UdHp0L1W5cYsbl3mJmMa/q4U/DCxPytKQ4ZWJgwLwiIvHqSS53y
         5dkSMNsGw+aFftnutL9z70SlhPNGWhx8Ul79L1H01S5N1iEXM6v6vx5jbUom/meVrEM9
         eefGqvnTTj3gGgoNkthm1855N9l6vWUmmLgw1Y+bdZMH6tOoNg8fSeh9kVd4FgjLDU0n
         G75Ls3a6irHaGo/T/hs2/rRYwBPPDF03/lo/bOumJdf1+FAze2rI0rc3X4Pqf4NobG2E
         n3uq6aNaYiyLjdkcbY7d0ZhOicYtPM0nnU3StSchaXaDICxXr02sLymJIR6A2rUM6QV+
         zZaA==
X-Gm-Message-State: AOJu0YxG1sQyj1YKhH8Gz5f34Zo1pB/ssc1x2KUwdXUIXaFiEqI5WjWN
	cK5cmMGvDSX9WaKqWb94tNReLSFG2HFV3ozSiAQSXQbEM9WFw5myZYJo
X-Gm-Gg: AeBDiet/7tIXey4B8AeSnkPVl4p7u6tEnnJuZDc9kXrnlnbeqjH5VwCPbHsRf+FR+lR
	TD5ZhdmpZmF1wXmRzap86XSMWBD2eOgo39v3oQnA0RUeRHHG/ofeSeq6h+9KltjzapdQcmQaQmB
	acLHwkkLz4MH+kluTUy+U3jEuC4c7mg4NjsZXo9smkPkNPNSFJQuRY13qmiL+Zif1tOAYf3TrQo
	UV4teePRNkRuNuUgPleFlNgzexrKorT5FpfsBxwweX08RkH74zi+eyQ3DlevkuCIvUsz3DKvhSs
	X27HVvutP63WJSFs3g+5qFC6n9Olg06byvYb1H2fSYr6it8Kq9b866ee3yrwIAmos+gMVMC2Dtp
	9WKUzPWOhtMFNwfe1nYAzs7l2UX+f+H86QoruIcoO5E+OlBdPVYivqxTQ0VIPwEDF1MnkxUglqc
	BTKJfLeORl7YeYFShDM2vRw1xD9isn8YNw0rmwrmAkKIJIhVJhbQk5Vq69rTx9NUnkiYvV8EEpi
	CzhEZkqLgJC1sni
X-Received: by 2002:a05:6512:3ca2:b0:5a1:3bd8:a068 with SMTP id 2adb3069b0e04-5a3efb45508mr1347920e87.30.1775848721811;
        Fri, 10 Apr 2026 12:18:41 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38e4957eb4csm8400231fa.33.2026.04.10.12.18.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Apr 2026 12:18:41 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: phillip.wood123@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
Date: Fri, 10 Apr 2026 21:18:40 +0200
Message-ID: <20260410191840.38747-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <0d1c7bf2-6404-4779-a0d6-6db592510a04@gmail.com>
References: <0d1c7bf2-6404-4779-a0d6-6db592510a04@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This patch seems to be missing the implementation of these new options. 
> Before submitting a patch series I find it is very helpful to run
> 
>      git rebase --keep-base -x make -x 'cd t && prove -j6 <tests that I 
> think might fail>'
> 
> to catch any mistakes.

Wow, that command is so powerful! Thanks for sharing that!

Will shift that definition to an earlier commit in my set.

> Why do we need to create a new repository just to stash some changes?

Isn't it good to do it in isolation, for when the test and/or its cleanup
fails. I tried to change it now, but it's not trivial, I quickly broke a
lot of subsequent tests.

> We have a helper test_commit() for creating commits (it is documented in 
> t/test-lib-functions.sh)

Thanks, will update!


Harald

Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DB715749A
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 20:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724877497; cv=none; b=en2cd2ClSvDY804hSTGh6Ma6QduwXMkxPixpQBTKiSvJR7J7zKzeW5YNKViM78OYZj/VMSG16I4Lr8qtOorFtYCf7MwmlG8x9E/J8hUKbX6LNfSVSkOq2B9ZSZW3yA1nahydeziMSwAzppP1XYSkvGk2t41Y+DtW5ZmJF77I5GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724877497; c=relaxed/simple;
	bh=y2DZF4btF/vNfc2DM2ewjcQPg1BV5TD+JQEsSoG1QaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcdOhvA9YJQFR5BnE6e9lvAcNgKlAQ26RH6xPHE8N3zYm0HEwEKlfY2t4tDKwG31m442HW0q/BtMkykCc1sL+5vriVrKqv7CaTGPnpsnjkrPOpnISlXpyIsFFZ42A73kf6g+ySy7kDH4sVQfAzBGuju1Mjp0JKy7OSmBUzFwrZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hYRA6hjp; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hYRA6hjp"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20353e5de9cso50595ad.0
        for <git@vger.kernel.org>; Wed, 28 Aug 2024 13:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724877495; x=1725482295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKZ8zKoyGwOUNLxtnTYbiJkyD1BVlEJAvj7cLWi10L4=;
        b=hYRA6hjpL7lBFACISCSvvsBIksi6l3Zt0iDnc4EM6y4KK2PdB3I3uIOxDypniUqUgQ
         1IdkeIaznp5KeuSg2Kdn9X43LQ1THK97scsbqMOQFLYPoxanKLV+A5GRnzc8USjXlbst
         vVn41MP9Cto8EDy0ENbfYN/GL1YgtcBQS7CsgJPQYVfetMjz2PTHggwpdYZDP2CmXApO
         Fxc453MOYmkxl4StBP/kIcfEv5YuPsxmDkJdJiwNg0VZfe4BH5Ez2tDr9uFY4ocbu2Kp
         tWDU+XHKdkALYFxvkYo6XXDpK5Zk3680RJHQS9homI81Wf6g+I1TZGZjwFkkUDWqbyw0
         lKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724877495; x=1725482295;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pKZ8zKoyGwOUNLxtnTYbiJkyD1BVlEJAvj7cLWi10L4=;
        b=IzNZdeLQaRnKQOTWEXoLZRTq4dUxSUqQr0mtqNQkn/NaFuZQwncocndldxIm2gJbKd
         bEm4OWzqKVC84LJfeKb480MX7pFyk8ZYHf3KpHBtsbp2QIFmQaBbRwF0RR2K3kDyrTyj
         EYji6o9soRfhuHj7A4o4OPn5kGaSdUWRcbYJrubBszhYLZ418054iTQyDQAPMEvVizLy
         ZB1RabFZoVdxvqBQPvDihxuQZcgzLERNuYth0r8YB3G8NznWfacmbGmQ2ocJz5WG+sG9
         IJgB9NuCkOq/IowY73v9o5Tub3vrk9aZJ5lycZ4+r7nkfLcZp8FkSDhp2On0FkGFrgu0
         zyyg==
X-Gm-Message-State: AOJu0Yz8ellM+QjQK3NYtwR408KfW6Ko2AAljFR1H118omcBiHknVRsk
	8LtddUu2CRbGsKGN1VjogEi2ri0oHiNDn4eb/B6+JaWE1ZWUnHiBtblgY81vcf1/+9he7lB4xAz
	WDQ==
X-Google-Smtp-Source: AGHT+IEdzjWzLyIXyxdc1yPkRveMepvfiw9H6EF0kLZL5BP82B7V5+0CdQHk9DCi1BD022TkYc3Owg==
X-Received: by 2002:a17:902:e5ca:b0:200:8e1e:9940 with SMTP id d9443c01a7336-20510d58e83mr40635ad.23.1724877494872;
        Wed, 28 Aug 2024 13:38:14 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:70f6:9fb5:f5d4:421a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714343105a8sm10515628b3a.180.2024.08.28.13.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:38:14 -0700 (PDT)
Date: Wed, 28 Aug 2024 13:38:09 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Libification update (was: What's cooking in git.git (Aug 2024, #10;
 Tue, 27))
Message-ID: <eoy2sjhnul57g6crprxi3etgeuacjmgxpl4yllstih7woyuebm@bd62ib3fi2ju>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq5xrl7fgu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5xrl7fgu.fsf@gitster.g>

Hi folks,

Since we're no longer doing our regular libification sync
videoconference, I wanted to highlight recent developments related to
libification. These include:
* general code-health cleanups that make it easier to use Git as a
  library, such as leak fixes, error handling improvements, and
  reduction of global state
* unit testing, to get more coverage on Git internals
* explicit libification, i.e. exposing Git internals for use in other
  code bases


There are some interesting series which could use some more reviewers:
* Calvin's and my js/libgit-rust [1] to add a proof-of-concept Rust
  wrapper and API around Git internals
* Patrick's ps/clar-unit-test [2] to add the Clar [3] unit-testing
  framework
* Patrick's ps/leakfixes-part-6 [11] to fix various memory leaks
* Toon's series [12] to fix a leak in bundle-uri.c
* Ghanshyam's gt/unit-test-oidset [13] to add tests for oidset
* Ghanshyam's gt/unit-test-oid-array [15] to migrate testhelper tests to
  the unit-test framework


Other relevant series, which do not necessarily need reviewer attention
at the moment:
* Patrick's ps/leakfixes-part-5 [4], which is cooking in next


One stalled series, perhaps someone is interested in picking this up?
* Philip's pp/add-parse-range-unit-test [5], expecting a reroll


Finally, I'd like to celebrate a few series that have (or will soon)
graduate to master:
* gt/unit-test-urlmatch-normalization [6] to migrate testhelper tests to
  the unit-test framework
* cp/unit-test-reftable-block [7] and cp/unit-test-reftable-readwrite
  [9] to migrate reftable tests to the unit-test framework
* ps/config-wo-the-repository [8] to remove dependency on global state
  in path.c and config.c
* ps/leakfixes-part-4 [10] to fix various memory leaks
* rs/remote-leakfix [14] fixes memory leaks in git-remote

In the near future, we at Google (mostly just Emily, Calvin, and me)
will be focusing on the next reroll of js/libgit-rust and reviewing
other libification-related series.

Thank you to everyone who contributed with series and/or reviews!

[1] https://lore.kernel.org/git/cover.1723242556.git.steadmon@google.com/
[2] https://lore.kernel.org/git/cover.1724159966.git.ps@pks.im/
[3] https://github.com/clar-test/clar
[4] https://lore.kernel.org/git/cover.1724315484.git.ps@pks.im/
[5] https://lore.kernel.org/git/pull.1677.v2.git.git.1716710073910.gitgitgadget@gmail.com/
[6] https://lore.kernel.org/git/20240820152008.21354-2-shyamthakkar001@gmail.com/
[7] https://lore.kernel.org/git/20240821124150.4463-1-chandrapratap3519@gmail.com/
[8] https://lore.kernel.org/git/cover.1723540226.git.ps@pks.im/
[9] https://lore.kernel.org/git/20240813144440.4602-1-chandrapratap3519@gmail.com/
[10] https://lore.kernel.org/git/cover.1723614263.git.ps@pks.im/
[11] https://lore.kernel.org/git/cover.1724656120.git.ps@pks.im/
[12] https://lore.kernel.org/git/20240826083052.1542228-1-toon@iotcl.com/
[13] https://lore.kernel.org/git/20240824172028.39419-1-shyamthakkar001@gmail.com/
[14] https://lore.kernel.org/git/82cb986c-6830-4d9a-bad1-fe4cab6a76eb@web.de/
[15] https://lore.kernel.org/git/20240824170223.36080-1-shyamthakkar001@gmail.com/

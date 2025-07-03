Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50A51C6FE9
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 21:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751577913; cv=none; b=ndOAMK5Bi8yURBhU0+Xquvk1KIj5fzirYX7IHubTnTcBFABxaGR/HUZ8jT4XgnQShw2rIYc+IV+RYbWqm4GMXpf1xMXP6zrt9r8noXZsPOmJ7yhyiDhsbSxWR3ZgzhgMmDsNqOGqy6kLeVfqWonvVzLanBSSsao7LZa49LlxoZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751577913; c=relaxed/simple;
	bh=Sz+2V8bcQ7ewRl0x+tIeocXluCCcjYWiJfLIsdwg4uE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=drN/zzXI+KRX5R0w3Q8CiERQuiQCCcT7ctgTRfBIsFGX0314s2ytLxk3Nv32q0bxGctglFipfBJhgOnmkXBT1HINUspaCAYaBE5mKl5AeisWz7EO/eQody262uoTNAvB1TCJ/IRY88RLzM0TU63uiia1gMaUKLq9JUi+X6njSCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=CpwYipl8; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="CpwYipl8"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7d20f79a00dso40638585a.0
        for <git@vger.kernel.org>; Thu, 03 Jul 2025 14:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1751577910; x=1752182710; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=63qhGgAqsMzmMhNi+gejVdr09TpfVUlS3leFChYXsv4=;
        b=CpwYipl8ZUTT2aIcIcPHQiq9q8tSInGd+kpM90fe72cGwUKOZlcXkpy7tOV+TNhlVC
         OXCKPeFGb/UC5IH070Bvx0hpse7opmX/bIFlA3a6EOsK5E+xVKRbnOsYLBwHgSa8tOF4
         ooYXOj8BgWmlKFtI4ORfjJfoSyneRXU3x8OHH+MBMMjUt5/5/6ii+Q+zYWkCl4+8BnG7
         CD+CS52s15ijSzWEnqgQNSGj7ElmaynSCYTsQQ+3K797ivt2Pg3upzb55iEIt7slg/Uz
         Usc1sMvIhodghWWgro40ILhPYbr7jxzipcBAC1QJ48CEl4R3K1QYYF/57ii/hVp61Z5O
         oXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751577910; x=1752182710;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=63qhGgAqsMzmMhNi+gejVdr09TpfVUlS3leFChYXsv4=;
        b=QHXiYXY1P408XSOzTAp3Chs4Y0HulmXi8LIiVFPytdy4LdXaBXpc6ITJCoU+t0J1Un
         L2/jjp6HL/SdSLhAigVQvl27n5JgQmtKhAiIfdB5RYM6ynWOHk3attbG3o07rp8cmcNo
         NMwkH+g2fYJpuplnwCNUeBPliHezezT71EigEMrInjRrWZxAWt1NPTFWPU2Pla8ceQjr
         +/XITzwfOruD5r1F/e8EI7LAs+gPqYSzWZ1BdyjnLhOkHXRCupJcdwcfYpRPd/Fl32A5
         /GcL1bTijlDLZvQG66eUlkEMBcvFKGOt6tBZOHbDql9Ymrqlu2v5Qs2+20i3YeuMhIj8
         qSYw==
X-Gm-Message-State: AOJu0YzJM+UmIJrulcAh9oZJmIKkYVXC0Ll/M+RjideKkTb2wzq+5FfQ
	lTfnSsWf73z/SjpAndj7/UFL6G5FQaVHxV67wt4yARLu7pNuNNa5SbVg4CkzWuW58NxiYT9Qtpm
	Njj+7Su0=
X-Gm-Gg: ASbGncuQNuoqZ1jhRCu1KYbwWAX+nYkpSQERJEs7f4YB+jJ1CcBbolcCFWNTmfWoJCO
	SMkASKVjqLETApf4IfDOgmmfYaUzUaZUBZ+cNZbJ8B4aXt51uOUheAJavfTloEdbAChz/4ed+R3
	lyQ6L63IE4ymj9GN4EVvEFPwOJani97y2Sv/VqHSZA+MSZ2CpFISmK95WVSPNMhOVrrfgSVgsOZ
	PJtYJauvftIpTmufl3xCvOsFFheLhjrFZVA29uLTLzPTOusIZJhhNzANrjOhYMOIRZffNRcj7rb
	7hT68a9zGiZVgwaTQZJ7d8IwCMFtrvuy+m7a4MWjacxVCMI+3ZwZWLHe5JkMRL9wgAvGpjrOre7
	4MmzjUWVk5qwfYjJ4qTkInXzZdGPzK0IvdQ==
X-Google-Smtp-Source: AGHT+IFOPj7Vri8Ozn4gum0FU6MwB1lkSOR/NSsTCMbCGDvqsQCcLaT4i0EPspCjrD8bXylFHJ8D8w==
X-Received: by 2002:a05:620a:1aa7:b0:7d4:57a5:9742 with SMTP id af79cd13be357-7d5dcd0783amr68071685a.39.1751577910600;
        Thu, 03 Jul 2025 14:25:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-702c4d50f73sm3420886d6.66.2025.07.03.14.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 14:25:10 -0700 (PDT)
Date: Thu, 3 Jul 2025 17:25:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Additional travel sponsorships for Git Merge 2025
Message-ID: <aGb1NAHN/+T/3oYH@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This is a small follow-up to the Git Merge[1] announcement to say that
we are **accepting more requests for travel sponsorships** to attend
the conference.

Some details:

 - This is open to not only previous GSoC and Outreachy contributors,
   but to current GSoC contributors as well.

 - If you are in either of these groups and interested in applying,
   please email <git@sfconservancy.org> anytime before July 15, 2025
   for more details.

I'm looking forward to seeing many of you either in person or
virtually in September. If you have any other questions in the
meantime, please feel free to reach out to me either on- or off-list
directly.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/Z+L3Mt58n18KUNzs@nand.local/

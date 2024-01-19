Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F35D389
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 00:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705623179; cv=none; b=XFim3iJmcGB2NbXPhUWRYuecb2GdQADe8IA+C/5dfB4OCRxbKiNhmB8xPdXs7jC9GcGoWpSnzOPuR5ojELd2pBSpv7UYZBo0/8l0kbgh752hPvsu7YZ5K7cVJzJvc7tAInY/5Cs9Rx8gh+/ll5PnyZsffKh13Erd88V//jhlrdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705623179; c=relaxed/simple;
	bh=lsmTor+nTrnEMiKsp6rSUB33copfKTzySAr6XUflWFg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LGlv5BHjB3jzWSOjmjej22qVF5qxGVDcfoAl66V3k6ApeDj8uA5EDTWx5GtDhSrY98j6Ih1aCNm3GHCLVuXsX+kyXxkqKg2mxfVL8hoRxS1g5aV0qu9gF8DnWcrZ7w4dUzV+FBWGkxPWF5bAp3P6+2iKGPsMICvlkuDMCXuPVnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N6KTisgd; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N6KTisgd"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbeac1f5045so386077276.1
        for <git@vger.kernel.org>; Thu, 18 Jan 2024 16:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705623177; x=1706227977; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZWHMiXA+7iziPpEpdLsu61HBl/4pqVcdj3Jr/Y8ocs=;
        b=N6KTisgdg8kz1IgP9WPzDw4d+t49lkmDYNzBcvQwD+Zj5hYxp+Lma7+P4nBiHHo3pn
         F1/ySmwlyJiUoIG065MCsphnrkamUEqVFvdfKW7ZAesL5ZqSBorBo4UXmoGT12NzzlMp
         +ecf7RvJRFKRFEE/K5MoUfaFcmwoH9gdUhmx4DI6cuEqGcFSPEL+ohsrrdH+tMXyHWSo
         Tk4QaobCgUo+l5lvI+9/O1U3QZSzNBmpavf9RyPNF2UJtcw2IxY/NMN0dJn/mmypDn7P
         eRf7vZq5159wizQ2kH7bND0gxbBFJRVyMgDsmTMrXNx5UO9Tzz/rxXSbVTrYGb3e7ti/
         2O6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705623177; x=1706227977;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZWHMiXA+7iziPpEpdLsu61HBl/4pqVcdj3Jr/Y8ocs=;
        b=KQEfnuzWqiRwKOt32cnSQxPTnfRJQuIxJNyYuRuYqb53uK3AvX/xyDtZbjVFC8V5ZU
         tJbMt/XLlRlQCulLpExQjObPNlZaqJHUTXJ4Ofg4O98Y/yC9QVqv2iDgAnKDUZmXSRx0
         5WWbP8g2ggmx2lZLtNg7TwEveolOps8aJWdkdxZuou23L1icoA2K6V1nRlD54HOdnLuX
         YXfLZbhd3nJrimr4oOX6pKXGG2XVb6A46RyElcVwRF4kiD9XhAchYAzHw5QzpvLSfuD1
         50bOCOQZqBKZLJhr9je2MgjDvOEaUvtdiHneDLRvd+Gx5fcAblkFaGd9wS4WCW+3CvPs
         kefg==
X-Gm-Message-State: AOJu0Ywc7gcilANT/l83VvAqaYm4K2uTiGGcBIXi7mgYNzHkd05sOvn4
	Gd1qDfmRjArM9RP1IVZitdZWebgPIE+ujjvY/EpUtwRGXEAVpe0BCNBKDU0xLvD42WFE784UzdF
	r+Q==
X-Google-Smtp-Source: AGHT+IFiovE/tcczzI+wsIL373+AezMJ865buMKIn+kx7YKaYgAwH4gPyJIRoUPG7q6ppGEZqTk3C6rTYQ0=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:1c5:b0:dbf:4359:326a with SMTP id
 u5-20020a05690201c500b00dbf4359326amr52100ybh.1.1705623177561; Thu, 18 Jan
 2024 16:12:57 -0800 (PST)
Date: Thu, 18 Jan 2024 16:12:56 -0800
In-Reply-To: <xmqqfryup98u.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
 <5f64718abfc2e61b4e259de700c137bc817fbb1c.1704869487.git.gitgitgadget@gmail.com>
 <xmqqfryup98u.fsf@gitster.g>
Message-ID: <owlyv87qgozb.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 02/10] trailer: include "trailer" term in API functions
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Linus Arver <linusa@google.com>
>>
>> These functions are exposed to clients and so they should include
>> "trailer" in their names for easier identification, just like all the
>> other functions already exposed by trailer.h.
>
> Oh, if you were to do this and code movement in two separate
> patches, doing the rename before the move in the previous step would
> have made much more sense.  If we stopped after 01/10, the tree
> would have been a very sorry state.  If this came first, even if we
> stop after these renaming of internal functions that are not extern,
> nobody wil be hurt by these new and improved names.

Ah very true. I think I was thinking of the series as one atomic thing
(all 10 patches or nothing), which is a bad habit I need to break. I'll
reorder these two on the next reroll, because principles matter (and
it's an easy mechanical change). Thanks.

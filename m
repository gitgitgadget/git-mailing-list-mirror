Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE22714D294
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712157343; cv=none; b=l3eILU5QCDg1uH7YNdIE0mIa2J3f7DlQPOMRhp1YdIdC6ZuLIEUSE6Wue7Vs7rbe321eMDC2E5E/T+ryJa5R6fTJzWk8L8VVqWqZr8EIPyG6OLaqf6sYGKdk3dkPInt36CKYSNcho/SVqXnrWUexPxFdG6SitV4pITZxn/F66M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712157343; c=relaxed/simple;
	bh=0nQ0xQdm6LHEsTZ+Zc0dVYyN1r2lbIXt+y5WvSq/Jtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJoD1wr+ibVZwRccV4zDT2LzrhXOF1/L4ywa8Odhte5n4qjPHezLoK6BungN4G48jDVvvuqzRF8PO8F0KTFqw3+T6VkuRFTNr0sD8lZSimzZJ7k72z/L0pDKnM8j/DEpVCLBAQMy6BPrmiI5JUtZDZ2przIdA/Jp6J95DbSK6/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtYmQmGz; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtYmQmGz"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-22a1e72f683so4674646fac.0
        for <git@vger.kernel.org>; Wed, 03 Apr 2024 08:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712157341; x=1712762141; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5wzZ8NlavAAxgxuXjc1qjBkB4Rfjeat9kW0o2D0UTGE=;
        b=HtYmQmGz/OnVM1TmlTBBkAznB0F7n9iXYew7mcH8vyWp2bGgDqpWY5tXupxTGaA1UH
         JMbWx0LnuD/uu0GDkGXXAqyumnii7kMce4zz6pYrPUzyz2ZE8TTFZ8DktV5LZrr9RAkC
         +Emn3+ADPoT0/rVCx9KH1NSFBq0OWZHvRLTn43ulB51kS1tvgpW9pnrZ/qFGaILs0TEa
         5vjw12jENGDLwg4FHEMOBS52nQ3DQrLqG4jb02dfNaZClHRZ/uv9NCuREC/TwdwTnj/6
         Jn+yPzbbLMP+sQhJUteSUKOADA7aWr17Bf4+zQgaLcrtAHQRPs/B/qESaDkHSDr/TBre
         EyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712157341; x=1712762141;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wzZ8NlavAAxgxuXjc1qjBkB4Rfjeat9kW0o2D0UTGE=;
        b=VZTpTBfLb7cmO1l2PkmaeyEikTikECOs8zLF2n7CcYFJhjJBgBrWQ2X5wWnuZ/7ENL
         DL1L3STQ6ef2KSVKPknvWoHh3ZlgSzivuBMp08WZqsje95zhxf8pt3nfoavp95MHbLi6
         TX0azj9IOQajgc+xrOsFE3glofPxOM8ipV+koRTwt9m0J5MffKZTsOtBrwwtUVsZo5LV
         mgiuHG9m6OsF/YG3iHbvaxuW8+oZrPUXpQ5pkGNMcPQYiijpfLwgYMiu2GP7wVSkO/Nw
         yNOFSj7eAx0ENdUAY0So+zoZN0uNr0wfoLjzbzCKpxIStbjWsfmq+/mrA0q7tzmFCsMB
         IfJg==
X-Forwarded-Encrypted: i=1; AJvYcCXeA7uph40B5gcZQ13f4SdxODTi5BzvImVeD/uLGGU96QPkhd8Zbijd/MdKh53h37bLz4XfVFK9AcmcyFn5k5Woc7Dq
X-Gm-Message-State: AOJu0YxwOWyXHcaq9zkYRMv5sM78wMA0Ba9d/in/cEQCxlb8qoMnDrGU
	gCf9993kLGGvZNjcGfMcD4ng9WoeMvflF85OtMgY+9UZoNCXxCxl
X-Google-Smtp-Source: AGHT+IHJsNolohTO6NtlTO9WATxOI7M+5pahhNagQXzgcjTtfb3156KXnaFzRAmODkeecYY43YjoDQ==
X-Received: by 2002:a05:6870:8183:b0:22e:912f:252b with SMTP id k3-20020a056870818300b0022e912f252bmr2791260oae.2.1712157340728;
        Wed, 03 Apr 2024 08:15:40 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id qo6-20020a056870ff4600b0022961470307sm3980780oab.45.2024.04.03.08.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 08:15:40 -0700 (PDT)
Date: Wed, 3 Apr 2024 10:14:43 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>, 
	Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v2 0/3] reftable/stack: use geometric table compaction
Message-ID: <b24jjzw72rlcpctteokr5yfbuwuy2cc3qvibzhuju4gbj63lfa@gbtsmvufyuhd>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, 
	Han-Wen Nienhuys <hanwenn@gmail.com>, Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>, 
	git@vger.kernel.org, Josh Steadmon <steadmon@google.com>
References: <pull.1683.git.1709669025722.gitgitgadget@gmail.com>
 <pull.1683.v2.git.1711060819.gitgitgadget@gmail.com>
 <Zfzd8YdAwzYRYkA3@tanuki>
 <CAOw_e7az+S4nkG1HKDcqXkK0BOhs6cBpkb=QEGBoZW8MSEEvGg@mail.gmail.com>
 <Zg0tEa7DDEuub09Q@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zg0tEa7DDEuub09Q@tanuki>

On 24/04/03 12:18PM, Patrick Steinhardt wrote:
> On Wed, Apr 03, 2024 at 12:13:42PM +0200, Han-Wen Nienhuys wrote:
> > On Fri, Mar 22, 2024 at 10:51 AM Patrick Steinhardt <ps@pks.im> wrote:
> > > > Thanks for taking a look!
> > >
> > > Cc'ing Han-Wen and Josh for additional input. From my point of view the
> > > new algorithm is simpler to understand and less fragile, but I do wonder
> > > whether there is anything that we're missing.
> > 
> > Good spotting. I hadn't thought about alternating tables.
> > 
> > I have one minor criticism:
> > 
> > Environment variables are untyped global variables without any form of
> > data protection, so I find them unsavoury, and have tried to avoid
> > them throughout. (The whole reftable library only looks at $TMPDIR in
> > tests). They're also accessible to end users, so it can become a
> > feature that can inadvertently become a maintenance burden.
> > 
> > For testing, there is a stack->disable_auto_compact.
> > 
> > If you want to keep that style, I would elevate disable_auto_compact
> > into reftable_write_options to make it API surface. This will let you
> > use it in tests written in C, which can be unittests and therefore
> > more precise and fine-grained. They also run more quickly, and are
> > easier to instrument with asan/valgrind/etc. The test for tables with
> > alternating sizes can be easily written in C.
> > 
> > If you really need it, you could initialize disable_auto_compact from
> > the environment, but I would suggest avoiding it if possible.
> 
> That's actually a good point. I think keeping this as an environment
> variable isn't too bad as a stop-gap measure for now, and it should be
> obvious to users that it's not for general use due to the `GIT_TEST`
> prefix.
> 
> But I'm definitely supportive of lifting it out of the reftable library
> and into the reftable backend so that it is specific to Git, not to the
> reftable library.

Moving the env out of the reftable library seems reasonable to me. I'll
make this change as part of the next version of this series.

-Justin


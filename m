Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66B51B95B
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728748577; cv=none; b=KMT7igUaVBpgVCJgQtIPBM4kcgmEn62maCz9xABHbDiv+dQvwhxzKmqRGAFuu0rMhmH0NokDCI4E6ZGaw3RsXll1b3eS0nU9dRZk0wH8G6151dLixc0jil83CO45ewIhVV81v9WJWih6ZmdpXixQbBAJCbjd/zhDO/A0wLLm5cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728748577; c=relaxed/simple;
	bh=jHyAsJfdVNVf7ejzPmrsYwmOjTfm0alvGvXSi5cTEFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btjRslIikMtTdImDJJlinSSqcO20C9sY7Khc0/+eozozr2qfszXpuffqTtFluj8OGgT2mD0gtK0OAZEOP7Sgg4Lgswq4tWGnLuzj5pEG9uq+osmNNDxcQdhWXm8vXChi+/79Oju1GCgV6Sj8cwLXx2DVXOrFYGV0umlVZEREhAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=BKNE26Hf; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="BKNE26Hf"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso2510646276.1
        for <git@vger.kernel.org>; Sat, 12 Oct 2024 08:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728748574; x=1729353374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mse4jOCNEFA/1CDAQwRiMLIM71kTpQ57Sm2C9zv8QI0=;
        b=BKNE26HfVakBsvuA5jDhgZiQ4OfyOEfrpIMcFWdcWZJN+5lY2BO93fr33CasCqGFkD
         4tUx7PFZa+WlbkelHi54DlNVSkO1afN5+nxzlDY5TF/08w4dB86WBUgYiPVhv7N2PPzH
         2D2HH1IBKoMGvAZJfVdB4fjCsAPnATagSO6aAHQ5bbsjWpivR7fbKt/9RN5FIDDI8Wdg
         RRtwafJeBCk5PnxTQ4PdCIDLq7DgniXxOOiAOupu3upiRcDcS1tlbcFWWZ+plaZ3zYvz
         cc+WWQlpKrITG1GmSbLyRGSkhQ6zoLkkjTth05SWLciuT4Ss7dI7Ko+U75BeNdA/0CU0
         fdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728748574; x=1729353374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mse4jOCNEFA/1CDAQwRiMLIM71kTpQ57Sm2C9zv8QI0=;
        b=wBIUHYHl6JHadGhV5gYDsd8xg4eyhrwGhjeqMRv0MlSoAQhmsVVbizjRtPSoIx11ls
         f30Mz2oQR4qfy7IbYENCSKINahWuosgL26CvnDHvJN+/8rXeq+P49IRBMRDx5IunSN5F
         1UjCVnL92+FrlGrngV8FCzUsOCt4Rovq4wY+SuaF/4mP69N17ehalchWJW3xETIDlpTG
         GN5Ya5fZAwEE+YwyJNn8O4a2/qOOFMOJ7eO81OjB5sP8cPv7AVWSejPMzmdngGFO4EI2
         KrmVuddjJ6vGCD3oh7Od8tdZa7usAMEcyrKQPol3SNK5x2g8GnEinQyoBhvo0tJJV166
         m0lg==
X-Gm-Message-State: AOJu0YwNiQol1soYILcKQBzNTom+ViU8JOqdu3ISmEJXTd6EUL38YQ2O
	fvO1ZHtT54y6HdKw9mOJOOQgS6WnTDpnVg+JbgbSXDsfypFIOeDWYSG2nCu9sEU=
X-Google-Smtp-Source: AGHT+IE9kXPaDwKDGVRWR1J77gTduBImH+bpbvBu8sanCRZpXId0Oybhvwm+2dEwN6Nm2p8bksRtOg==
X-Received: by 2002:a05:6902:2188:b0:e29:2ce2:9c81 with SMTP id 3f1490d57ef6-e292ce29ce1mr3547114276.3.1728748574587;
        Sat, 12 Oct 2024 08:56:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e290ef7a45asm1424134276.56.2024.10.12.08.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 08:56:13 -0700 (PDT)
Date: Sat, 12 Oct 2024 11:56:12 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Patrick Steinhardt <ps@pks.im>,
	phillip.wood123@gmail.com,
	Christian Couder <christian.couder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC Outreachy] Leftoverbits, which involve replacing atoi with
 strtol or strtol_i or equivalent.
Message-ID: <ZwqcHDzaR2U2JNu0@nand.local>
References: <CAPSxiM9FoGBhsnBE4E0Fvq-x_HvyFGGkkhaLNoRdVkvE6CpaZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPSxiM9FoGBhsnBE4E0Fvq-x_HvyFGGkkhaLNoRdVkvE6CpaZw@mail.gmail.com>

Hi Usman,

On Sat, Oct 12, 2024 at 11:21:13AM +0000, Usman Akinyemi wrote:
> Hello,
>
> I was looking at some #leftoverbits which I can work on and I came
> across this conversation.
> https://public-inbox.org/git/CAC4O8c-nuOTS=a0sVp1603KaM2bZjs+yNZzdAaa5CGTNGFE7hQ@mail.gmail.com/
>
> I followed the conversation and came accross
> three instances where I think atoi can be
> converted to strtol or strtol_i or parse_timestamp().
> These are the three files which I think the atoi can be
> replaced with.

This seems like a good #leftoverbits to use as an Outreachy
contribution. From a brief skim, it looks like this is going in the
right direction.

But to get help from the rest of the list, please submit this change as
a patch or patch series, following the instructions in:

  - Documentation/MyFirstContribution.txt, and
  - Documentation/SubmittingPatches

Thanks,
Taylor

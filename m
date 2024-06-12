Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C10D2576F
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 10:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718187148; cv=none; b=SoAbkN0r0z7gZMC0OD6b20d9OAgH/IFwqg4fMTEQDdLXacE4iGS5u2S3s/n9FNmx2Vb/rAX+tn4C/n3DBg4zKcNtk0bMlT/JEm6vYE/+gCi0OYjavLF7tNkyogsMxR5AfTmfmplNCRuut99bijbLZqYIqweYtSttmZ42SX60O0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718187148; c=relaxed/simple;
	bh=61Wv3yYLYd8jbKmDxmEux44xgVqrAh8+H//dmzOjw3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFhmNsyhz1tl1qOrRrUhoOMAjbylJtbANX/MTvgo4bM7kaBfjgd1wwv8Owk3Pb1BhsdaXfXCMLMUlG6Y9Kt+aXKI3VugdyC6WLfnd7z4k0/UvkORoCpTaaTf4pHr2dp21+IcNMmic70J/L4DHDe7bMlm++cX2Bxwnkt2y+puNM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbojVP3F; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbojVP3F"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ff6fe215c6so5851749b3a.3
        for <git@vger.kernel.org>; Wed, 12 Jun 2024 03:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718187146; x=1718791946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FGKthOH2ygJBuekmAptFnXpoDG6vQcezjj5yNMWwG4Q=;
        b=LbojVP3Fy2LNydZjiTNYZ4r4PWDzQqGVtRSfhFkZKtfTRZeTUSUa/sbIFRtO5YYrAp
         4R5gBHNoIQ+9aU4YbQx0oDNeRT+NyWmEgageJg6P/Zpo7sJzC0KkHwJnCgqFFs53G+1h
         O17ORwDdzDrGD1ckBFH/EcP4na/spAaK5IYcU0eyDSpBrdz2pOJ5T1ZNq6I9Y7s3j640
         uIUqP/Qm7iQj/ojEgGu0NJM6eu7ifnvCLMh44iREnVR0FC1LLerk0Mjk8U0dEIhhT30K
         BZQR5O4PH7FfI+3EBOViROZHUmNSp8d3NFO+Pvn8Dl949sA4/vt7DKQg+ao7n070iUny
         O4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718187146; x=1718791946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGKthOH2ygJBuekmAptFnXpoDG6vQcezjj5yNMWwG4Q=;
        b=boCmVsiQ84n3xZesWHYuL7b+Z+Xq/I0uAZ/KM4W5NzyC1vfRA+leyPXKD4s7BVhpc6
         1RwilEIrvnTVk4RZqQQkj1LpYYWXlRuT7Vvhl0xzp/WKUihhhLH+L0dJPJdTG13ZmZsr
         8BcwlIW6ZK7OifGVqRws4XpLT0v/joKWoezqvtSI110jfR9UEZSF1OuveGgaHT2kr4Z7
         k9K4Vbm6dVVuBp1s7EpaJ3kdr5Cq4jk9x/CBerAvzsyI/r1H/qLtwMuRVxmODu09WDQE
         ji5cv1qTVNldAcEhgpT8n/ghaD3nZVAsixuH3uqBuFeufw47k5okRzLvSHoY8/RHFYno
         ASuw==
X-Forwarded-Encrypted: i=1; AJvYcCXFT97C2EqYApvUgLMstlG1At//PqTT1kMG//E3SIYOQhrFVSV0flkuiu5Zhic0V5cazOnleY2IlJ2M4bM374rbo2TR
X-Gm-Message-State: AOJu0YzxbTfQft8mMs8OkQqQoidqw8zCcUyYkQHbbAOGiwFUojlLc3xd
	Fl5JST50+eIdgHhOTWclhF2HeqKp47u7ttb4/7qz0W+zWAsxrCMdu7zgAjtT420=
X-Google-Smtp-Source: AGHT+IHM//xqMlImVsiRk0aQhYL5CtQoXaVKSFLGX3awLcPlarOT+2PtfTkcvk5AuDovzR0072RO/g==
X-Received: by 2002:a05:6a20:3c8c:b0:1b6:73b1:b177 with SMTP id adf61e73a8af0-1b8a9c553a7mr1690052637.38.1718187146397;
        Wed, 12 Jun 2024 03:12:26 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f71b9dec2bsm48549565ad.186.2024.06.12.03.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 03:12:26 -0700 (PDT)
Date: Wed, 12 Jun 2024 15:42:23 +0530
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: [PATCH 00/21] Introduce `USE_THE_REPOSITORY_VARIABLE` macro
Message-ID: <nvvhy5jofnvke22xpwauimfk55gnoq4arl5xo6yi7uycevxkt5@gvumdjdsoatp>
References: <cover.1718106284.git.ps@pks.im>
 <ZmjcrqnDnHAZjr6V@tapette.crustytoothpaste.net>
 <ZmlQQadfFyCHo_k1@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmlQQadfFyCHo_k1@tanuki>

On Wed, 12 Jun 2024, Patrick Steinhardt <ps@pks.im> wrote:
> On Tue, Jun 11, 2024 at 11:24:30PM +0000, brian m. carlson wrote:
> > On 2024-06-11 at 11:57:33, Patrick Steinhardt wrote:
> > > Hi,
> > > 
> > > use of the `the_repository` variable is nowadays considered to be
> > > deprecated, and over time we want to convert our codebase to stop using
> > > it in favor of explicitly passing down the repository to functions via
> > > parameters. This effort faces some important problems though.
> > > 
> > >   - It is hard to prove that a certain code unit does not use
> > >     `the_repository` anymore when sending patch series. The reviewer has
> > >     no way to verify that it's not used anymore without reading through
> > >     the code itself.
> > > 
> > >   - It is easy to sneak in new usages of `the_repository` by accident
> > >     into a code unit that is already `the_repository`-clean.
> > > 
> > >   - There are many functions which implicitly use `the_repository`,
> > >     which is really hard to spot.
> > > 
> > > This patch series aims to address those problems by introducing a new
> > > `USE_THE_REPOSITORY_VARIABLE` macro. When unset, then the declarations
> > > of `the_repository`, `the_hash_algo` and some functions that implicitly
> > > depend on them will be hidden away. This makes it trivial to demonstrate
> > > that a code unit is `the_repository`-free by removing the definition of
> > > any such macro.
> > 
> > Overall, I left a few comments, but I think this definitely moves us in
> > the right direction and I'm glad to see it.  This obviously improves the
> > experience with libification and unit testing in a lot of ways, which is
> > good.
> > 
> > My only caution is that using the *_any functions will cause us a world
> > of pain if we ever adopt another 256-bit hash function, since it will be
> > ambiguous which algorithm is to be used.  That's why, traditionally, we
> > haven't assumed a hash algorithm based on the object ID length.  I don't
> > think the amount of uses we have is excessive, even with your changes,
> > but we'll need to be mindful of that going forward.
> 
> The only cases where I add new calls to `_any()` are in test helpers:
> 
>   - "t/helper/test-oidtree.c". This one is getting converted to a unit
>     test by Ghanshyam, so I'll leave it to him to improve this.

Yeah, I don't use '_any()', and explicitly give algo using '_algop()'.

link:https://lore.kernel.org/git/20240608165731.29467-1-shyamthakkar001@gmail.com/

Thanks.

>   - "t/helper/test-proc-receive.c". Here we don't care about the actual
>     algorithm, the only thing we care about is that we can correctly
>     parse them and then eventually emit them via `oid_to_hex()` again.
>     So even if we introduce a second hash function with the same length
>     this code would continue to work alright.
> 
> So I think it should be fine in the context of this series. But the
> remark is certainly valid and something we should be cautious about
> going forward.
> 
> Thanks!
> 
> Patrick



Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3313CBE6D
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 22:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783721674; cv=none; b=H3j3ucbxvlCV/a8SaUfLjhoo+xLOJJM/JBXDd6Ehjn7p9bQp00ik+96BKMF7uvGZdfYxiGw6jtaFEP0+WuTkXmrZ6Iapd7h/pUMrXrWChl8eBqrLPxFMn0OBhIKYdprbwiJiNsfyyQBetdFVDbAAS12vYvlxMRbBRz/qDqywRGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783721674; c=relaxed/simple;
	bh=q27gB2Fb86trDDg/G5P2HmtLUUo+jZA1YuncwSBxVzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXCf1tV3EqqEwh++OuvMhMxU6kAJPKODbevlTwEox/ZcnNbZf658TdXExCpvY/ezaEAmnntzZxLUIMNJ93puVTLzOh8cLlqq9h3srwC2hqMz1/8xBOAYuohwjkefrMbiYnbsPqg+/kWKI2WOlu8GQFtUfARFF0mmQ8kLEje9F6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=T8Gg2Bq0; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="T8Gg2Bq0"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e54f8c051so72601785a.3
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 15:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1783721672; x=1784326472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X+150qwBX4s9JTgKGxLeWnv+x1Cc24CLtIz/XKjYD8g=;
        b=T8Gg2Bq0q4CBeHiL8OEvl4eNpR6JBG4Dl94ItDf4QswUUfzdZrXoZERIZXeEzoROZ8
         QThuPQg9Cac0p/Dz9M86Sn1DTN0nw/qhh3W01DLFbG5oetTksT/VpAQrrBnrrPD53cvI
         n+iftUExrADt9LFJO5D/2L76eB5yifKmUpI7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783721672; x=1784326472;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X+150qwBX4s9JTgKGxLeWnv+x1Cc24CLtIz/XKjYD8g=;
        b=JdqcXmpWbtf1ZuqS4q7Gl5xKDt3cjqErmn79owDrBoK7Dcf5+jAGiS1KgXVupfFlU/
         a+AoGGAZ7SWrjKtdvAhkXHfSeP3ecOY741mscYjfBVV6iQEp6wIg3CCf+HCm85dn1++b
         oeiLFQSP1DxXIddq7rjGwP3qMOyi+Ff/mjC6LROuz44OI+7SXxqo+8eBfecWPAOOH9Ln
         vErGLw8r2CyPaFl4FjBlCg76c39YFe2XP1a4Rco4yq1AYPVe/qhhK7D/DjEskNoq93s7
         bCd7Xvz9fxHM5zfuJYGdGiInKkDeHW5Ac15VoSM6h7+LFM0fJPWbhsBGyodoc97NC9Z2
         Hyzw==
X-Forwarded-Encrypted: i=1; AHgh+RqDv0DR+NMhiV6udSqBivKdZbEPyxFVpGhjf+rVgQebzsMfOuTmhCtbxpbv405InszNaMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydxl4+LV6IvqnRyv1InC9mQzALJ6e6kTZJZE81SSnlwJNzI5rh
	VPcljCfsrIOBDAp9pRhTymOLj82YX69igfAfNjLZmP1u25XwRTrsufGBT9tTp1lUQuc=
X-Gm-Gg: AfdE7ckMouJZgfcoly/hBTmUbj+WDxzCtlT3PjwzUw9HLIgJ5q51NN3waJFQsHERaAV
	vXhddiIiQGUhqnLYmjWb3wy/Bxh1Rl+MsuaFtK3unHpQ538KosIgSmaHcXkdHNHUIEVZ1msfBTo
	qV/h5RfUwlEgV0kLQH2WcypBSmcJpmXKBVFdl/1x0bkeaCyiyGmheGBS6uEd8b17jjN/ZOSZ/TM
	/Oalr5EW8NuDjHWpkbOSG3PyuhXBvLzuzxbSFRICHAL4M/BnkHYlBUDPN5CdeeM07hpZd6E63DF
	Xfrs1/lyEApBQ67Xe8MLsSizSb5pQe/fZiJkOky5D1Ag5OAGdykd2DoUg+Iq9c28NFsUS7xfN0v
	cgonoEul4aYIx03u0PUmbwTnuq3h38DAYKoqhLkxxqYvsY2OmyvAD8E2+qKM8M1wQYL/fN0iufG
	9DRGi0e8Xb+A1/YTQB5l4KGD3v
X-Received: by 2002:a05:620a:3703:b0:92e:f0a5:ac3e with SMTP id af79cd13be357-92ef2b32b67mr132969085a.28.1783721672080;
        Fri, 10 Jul 2026 15:14:32 -0700 (PDT)
Received: from com-79390 ([209.249.37.133])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e10e9sm51225466d6.7.2026.07.10.15.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 15:14:31 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:14:28 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: Kristofer Karlsson <krka@spotify.com>, '@com-79390
Cc: Taylor Blau <me@ttaylorr.com>,
	Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 2/2] commit-graph: propagate topo_levels slab to all
 chain layers
Message-ID: <alFuxPQQcFxseAzh@com-79390>
References: <pull.2170.git.1783418384.gitgitgadget@gmail.com>
 <f9c1482a76493520b948a2e918de7a5481fa1043.1783418384.git.gitgitgadget@gmail.com>
 <ak0D44nhSH/98WYD@nand.local>
 <CAL71e4OuU1+KHd0TrcxDX2dyoWEJXmi86m8u+E7vtxhcSF6M1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL71e4OuU1+KHd0TrcxDX2dyoWEJXmi86m8u+E7vtxhcSF6M1Q@mail.gmail.com>

On Tue, Jul 07, 2026 at 04:57:13PM +0200, Kristofer Karlsson wrote:
> (b) Move topo_levels to struct object_database. Since
> fill_commit_graph_info() can already reach the odb via
> g->odb_source->odb, no signature changes are needed.
> The write side becomes a single assignment:
>
>     ctx.r->objects->topo_levels = &topo_levels;
>
> and cleanup becomes:
>
>     ctx.r->objects->topo_levels = NULL;
>
> No chain walk needed and the diff is fairly small.
> I am not sure about the semantics of it though -- should the odb
> have a reference to topo_levels?

This seems to be the most promising approach, though I'd be curious what
Patrick's thoughts are. The commit-slab API is really a property of the
object database, but we treat these as a global as I do not recall them
yet being touched by the ODB refactoring effort.

> [...]
>
> I have a prototype of (b) that compiles and passes the test suite.
>
> For now though, I think the minimal bugfix is the right thing to do.

Agreed.

Thanks,
Taylor
